FROM ubuntu:16.04

ADD requirements.txt setup.py package/
ADD ast2vec package/ast2vec

RUN rm -rf package/ast2vec/tests && \
    apt-get update && \
    apt-get install -y git python3 python3-dev libxml2 libxml2-dev make gcc curl && \
    apt-get clean && \
    curl https://bootstrap.pypa.io/get-pip.py | python3 && \
    pip3 install --no-cache-dir -r package/requirements.txt && \
    apt-get remove -y python3-dev libxml2-dev make gcc curl && \
    apt-get remove *-doc && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir ./package && rm -rf package

ENTRYPOINT ["ast2vec"]
