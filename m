Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF5A80BAE9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjLJNYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJNYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:24:14 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F87EDB;
        Sun, 10 Dec 2023 05:24:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy8BbjO_1702214655;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy8BbjO_1702214655)
          by smtp.aliyun-inc.com;
          Sun, 10 Dec 2023 21:24:16 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 00/13] net/smc: implement loopback-ism used by SMC-D
Date:   Sun, 10 Dec 2023 21:24:01 +0800
Message-Id: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Note that this patch set depends on virtual ISM support, which is under review:
https://lore.kernel.org/netdev/1702021259-41504-1-git-send-email-guwen@linux.alibaba.com/)

This patch set acts as the second part of the new version of [1], the updated
things of this version are listed at the end.

# Background

SMC-D is now used in IBM z with ISM function to optimize network interconnect
for intra-CPC communications. Inspired by this, we try to make SMC-D available
on the non-s390 architecture through a software-implemented virtual ISM device,
that is the loopback-ism device here, to accelerate inter-process or
inter-containers communication within the same OS instance.

# Design

This patch set includes 3 parts:

 - Patch #1-#2: some prepare work for loopback-ism.
 - Patch #3-#9: implement loopback-ism device.
 - Patch #10-#13: memory copy optimization for loopback scenario.

The loopback-ism device is designed as a ISMv2 device and not be limited to
a specific net namespace, ends of both inter-process connection (1/1' in diagram
below) or inter-container connection (2/2' in diagram below) can find the same
available loopback-ism and choose it during the CLC handshake.

 Container 1 (ns1)                              Container 2 (ns2)
 +-----------------------------------------+    +-------------------------+
 | +-------+      +-------+      +-------+ |    |        +-------+        |
 | | App A |      | App B |      | App C | |    |        | App D |<-+     |
 | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
 |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
 |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
 |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
 +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
              |   |           |                                  |
 Kernel       |   |           |                                  |
 +----+-------v---+-----------v----------------------------------+---+----+
 |    |                            TCP                               |    |
 |    |                                                              |    |
 |    +--------------------------------------------------------------+    |
 |                                                                        |
 |                           +--------------+                             |
 |                           | smc loopback |                             |
 +---------------------------+--------------+-----------------------------+

loopback-ism device creates DMBs (shared memory) for each connection peer.
Since data transfer occurs within the same kernel, the sndbuf of each peer
is only a descriptor and point to the same memory region as peer DMB, so that
the data copy from sndbuf to peer DMB can be avoided in loopback-ism case.

 Container 1 (ns1)                              Container 2 (ns2)
 +-----------------------------------------+    +-------------------------+
 | +-------+                               |    |        +-------+        |
 | | App C |-----+                         |    |        | App D |        |
 | +-------+     |                         |    |        +-^-----+        |
 |               |                         |    |          |              |
 |           (2) |                         |    |     (2') |              |
 |               |                         |    |          |              |
 +---------------|-------------------------+    +----------|--------------+
                 |                                         |
 Kernel          |                                         |
 +---------------|-----------------------------------------|--------------+
 | +--------+ +--v-----+                           +--------+ +--------+  |
 | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc|  |
 | +-----|--+ +--|-----+                           +-----|--+ +--------+  |
 | +-----|--+    |                                 +-----|--+             |
 | | DMB C  |    +---------------------------------| DMB D  |             |
 | +--------+                                      +--------+             |
 |                                                                        |
 |                           +--------------+                             |
 |                           | smc loopback |                             |
 +---------------------------+--------------+-----------------------------+

# Benchmark Test

 * Test environments:
      - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
      - SMC sndbuf/DMB size 1MB.

 * Test object:
      - TCP: run on TCP loopback.
      - domain: run on UNIX domain.
      - SMC lo: run on SMC loopback device.

1. ipc-benchmark (see [2])

 - ./<foo> -c 1000000 -s 100

                            TCP                  SMC-lo
Message
rate (msg/s)              81539                  151251(+85.50%)

2. sockperf

 - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
 - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30

                            TCP                  SMC-lo
Bandwidth(MBps)         5313.66                 8270.51(+55.65%)
Latency(us)               5.806                   3.207(-44.76%)

3. nginx/wrk

 - serv: <smc_run> nginx
 - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80

                           TCP                   SMC-lo
Requests/s           194641.79                258656.13(+32.89%)

4. redis-benchmark

 - serv: <smc_run> redis-server
 - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024

                           TCP                   SMC-lo
GET(Requests/s)       85855.34                115640.35(+34.69%)
SET(Requests/s)       86337.15                118203.30(+36.90%)

[1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
[2] https://github.com/goldsborough/ipc-bench


Updated in this version compare to [1]:

- Patch #1: improve the loopback-ism dump, it shows as follows now:
  # smcd d
  FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
  0000 0     loopback-ism  ffff   No        0
- Patch #3: introduce the smc_ism_set_v2_capable() helper and set
  smc_ism_v2_capable when ISMv2 or virtual ISM is registered,
  regardless of whether there is already a device in smcd device list.
- Patch #3: loopback-ism will be added into /sys/devices/virtual/smc/loopback-ism/.
- Patch #8: introduce the runtime switch /sys/devices/virtual/smc/loopback-ism/active
  to activate or deactivate the loopback-ism.
- Patch #9: introduce the statistics of loopback-ism by
  /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.
- Some minor changes and comments improvements.

Wen Gu (13):
  net/smc: improve SMC-D device dump for virtual ISM
  net/smc: decouple specialized struct from SMC-D DMB registration
  net/smc: introduce virtual ISM device loopback-ism
  net/smc: implement ID-related operations of loopback-ism
  net/smc: implement some unsupported operations of loopback-ism
  net/smc: implement DMB-related operations of loopback-ism
  net/smc: register loopback-ism into SMC-D device list
  net/smc: introduce loopback-ism runtime switch
  net/smc: introduce loopback-ism statistics attributes
  net/smc: introduce operations to {at|de}tach ghost sndbuf to peer DMB
  net/smc: attach or detach ghost sndbuf to peer DMB.
  net/smc: adapt cursor update when sndbuf is mapped to peer DMB
  net/smc: implement {at|de}tach_dmb interfaces of loopback-ism

 drivers/s390/net/ism_drv.c |   2 +-
 include/net/smc.h          |   6 +-
 net/smc/Kconfig            |  13 +
 net/smc/Makefile           |   2 +-
 net/smc/af_smc.c           |  33 ++-
 net/smc/smc_cdc.c          |  58 ++++-
 net/smc/smc_cdc.h          |   1 +
 net/smc/smc_core.c         |  71 +++++-
 net/smc/smc_core.h         |   1 +
 net/smc/smc_ism.c          |  69 +++++-
 net/smc/smc_ism.h          |   5 +
 net/smc/smc_loopback.c     | 603 +++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h     |  80 ++++++
 13 files changed, 915 insertions(+), 29 deletions(-)
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h

-- 
1.8.3.1

