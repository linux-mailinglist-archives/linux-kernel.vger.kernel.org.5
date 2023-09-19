Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2A7A66F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjISOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjISOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:42:25 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6078883;
        Tue, 19 Sep 2023 07:42:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsRxVvS_1695134522;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsRxVvS_1695134522)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 22:42:14 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/18] net/smc: implement virtual ISM extension and loopback-ism
Date:   Tue, 19 Sep 2023 22:41:44 +0800
Message-Id: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

# Background

SMC-D is now used in IBM z with ISM function to optimize network interconnect
for intra-CPC communications. Inspired by this, we try to make SMC-D available
on the non-s390 architecture through a software-simulated virtual ISM device,
such as loopback-ism device here, to accelerate inter-process or inter-containers
communication within the same OS.

# Design

This patch set includes 4 parts:

 - Patch #1-#3: decouple ISM device hard code from SMC-D stack.
 - Patch #4-#8: implement virtual ISM extension defined in SMCv2.1.
 - Patch #9-#13: implement loopback-ism device.
 - Patch #14-#18: memory copy optimization for the case using loopback.

The loopback-ism device is designed as a kernel device and not be limited to
a specific net namespace, ends of both inter-process connection (1/1' in diagram
below) or inter-container connection (2/2' in diagram below) will find that peer
shares the same loopback-ism device during the CLC handshake. Then loopback-ism
device will be chosen.

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


loopback-ism device allocs RMBs and sndbufs for each connection peer and 'moves'
data from sndbuf at one end to RMB at the other end. Since communication occurs
within the same kernel, the sndbuf can be mapped to peer RMB so that the data
copy in loopback-ism case can be avoided.

 Container 1 (ns1)                              Container 2 (ns2)
 +-----------------------------------------+    +-------------------------+
 | +-------+      +-------+      +-------+ |    |        +-------+        |
 | | App A |      | App B |      | App C | |    |        | App D |        |
 | +-------+      +--^----+      +-------+ |    |        +---^---+        |
 |       |           |               |     |    |            |            |
 |   (1) |      (1') |           (2) |     |    |       (2') |            |
 |       |           |               |     |    |            |            |
 +-------|-----------|---------------|-----+    +------------|------------+
         |           |               |                       |
 Kernel  |           |               |                       |
 +-------|-----------|---------------|-----------------------|------------+
 | +-----v-+      +-------+      +---v---+               +-------+        |
 | | snd A |-+    | RMB B |<--+  | snd C |-+          +->| RMB D |        |
 | +-------+ |    +-------+   |  +-------+ |          |  +-------+        |
 | +-------+ |    +-------+   |  +-------+ |          |  +-------+        |
 | | RMB A | |    | snd B |   |  | RMB C | |          |  | snd D |        |
 | +-------+ |    +-------+   |  +-------+ |          |  +-------+        |
 |           |               +-------------v+         |                   |
 |           +-------------->| smc loopback |---------+                   |
 +---------------------------+--------------+-----------------------------+

# Benchmark Test

 * Test environments:
      - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
      - SMC sndbuf/RMB size 1MB.

 * Test object:
      - TCP: run on TCP loopback.
      - domain: run on UNIX domain.
      - SMC lo: run on SMC loopback device.

1. ipc-benchmark (see [1])

 - ./<foo> -c 1000000 -s 100

                       TCP              domain              SMC-lo
Message
rate (msg/s)         78855     107621(+36.41%)     153351(+94.47%)

2. sockperf

 - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
 - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30

                            TCP                  SMC-lo
Bandwidth(MBps)        5169.250       8007.080(+54.89%)
Latency(us)               6.122          3.174(-48.15%)

3. nginx/wrk

 - serv: <smc_run> nginx
 - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80

                           TCP                   SMC-lo
Requests/s           197432.19       261056.09(+32.22%)

4. redis-benchmark

 - serv: <smc_run> redis-server
 - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024

                           TCP                   SMC-lo
GET(Requests/s)       86244.07       122025.62(+41.48%)
SET(Requests/s)       86749.08       120048.02(+38.38%)

[1] https://github.com/goldsborough/ipc-bench

Wen Gu (18):
  net/smc: decouple ism_dev from SMC-D device dump
  net/smc: decouple ism_dev from SMC-D DMB registration
  net/smc: extract v2 check helper from SMC-D device registration
  net/smc: support SMCv2.x supplemental features negotiation
  net/smc: reserve CHID range for SMC-D virtual device
  net/smc: extend GID to 128bits for virtual ISM device
  net/smc: disable SEID on non-s390 architecture
  net/smc: enable virtual ISM device feature bit
  net/smc: introduce SMC-D loopback device
  net/smc: implement ID-related operations of loopback
  net/smc: implement some unsupported operations of loopback
  net/smc: implement DMB-related operations of loopback
  net/smc: register loopback device as SMC-Dv2 device
  net/smc: add operation for getting DMB attribute
  net/smc: add operations for DMB attach and detach
  net/smc: avoid data copy from sndbuf to peer RMB in SMC-D
  net/smc: modify cursor update logic when sndbuf mapped to RMB
  net/smc: add interface implementation of loopback device

 drivers/s390/net/ism_drv.c |  13 +-
 include/net/smc.h          |  28 ++-
 include/uapi/linux/smc.h   |   3 +
 net/smc/Makefile           |   2 +-
 net/smc/af_smc.c           |  73 +++++--
 net/smc/smc.h              |   7 +
 net/smc/smc_cdc.c          |  56 ++++--
 net/smc/smc_cdc.h          |   1 +
 net/smc/smc_clc.c          |  56 ++++--
 net/smc/smc_clc.h          |  10 +-
 net/smc/smc_core.c         | 108 +++++++++-
 net/smc/smc_core.h         |   9 +-
 net/smc/smc_diag.c         |   6 +-
 net/smc/smc_ism.c          |  96 ++++++---
 net/smc/smc_ism.h          |  24 ++-
 net/smc/smc_loopback.c     | 482 +++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h     |  52 +++++
 net/smc/smc_pnet.c         |   4 +-
 18 files changed, 938 insertions(+), 92 deletions(-)
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h

-- 
1.8.3.1

