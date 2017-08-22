FROM ubuntu:xenial

ADD https://github.com/krallin/tini/releases/download/v0.15.0/tini-amd64 /sbin/tini

ARG \
    JAVA_URL=http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/server-jre-8u144-linux-x64.tar.gz

ENV \
    JAVA_HOME=/opt/java

RUN \
    apt-get update && \
    apt-get install curl -y && \
    mkdir -p /opt/java && \
    cd /opt/java && \
    curl -L ${JAVA_URL} -b oraclelicense=accept-securebackup-cookie | tar -xz --strip-components=1 && \
    ln -s /opt/java/bin/java /usr/local/bin/java && \
    chmod +x /sbin/tini && \
    rm -rf /var/lib/apt/lists

ENTRYPOINT ["/sbin/tini", "--"]
