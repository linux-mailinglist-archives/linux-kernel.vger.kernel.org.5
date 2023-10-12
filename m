Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D147C630C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347044AbjJLCtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjJLCsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:52 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA12C6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VtykMeL_1697078924;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VtykMeL_1697078924)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 10:48:47 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        tj@kernel.org, mingo@redhat.com
Subject: [PATCH RFC 0/5] support NUMA emulation for arm64
Date:   Thu, 12 Oct 2023 10:48:37 +0800
Message-Id: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A brief introduction
====================

The NUMA emulation can fake more node base on a single
node system, e.g.

one node system:

[root@localhost ~]# numactl -H
available: 1 nodes (0)
node 0 cpus: 0 1 2 3 4 5 6 7
node 0 size: 31788 MB
node 0 free: 31446 MB
node distances:
node   0
  0:  10

add numa=fake=2 (fake 2 node on each origin node):

[root@localhost ~]# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7
node 0 size: 15806 MB
node 0 free: 15451 MB
node 1 cpus: 0 1 2 3 4 5 6 7
node 1 size: 16029 MB
node 1 free: 15989 MB
node distances:
node   0   1
  0:  10  10
  1:  10  10

As above shown, a new node has been faked. As cpus, the realization
of x86 NUMA emulation is kept. Maybe each node should has 4 cores is
better (not sure, next to do if so).

Why do this
===========

It seems has following reasons:
  (1) In x86 host, apply NUMA emulation can fake more nodes environment
      to test or verify some performance stuff, but arm64 only has
      one method that modify ACPI table to do this. It's troublesome
      more or less.
  (2) Reduce competition for some locks. Here an example we found:
      will-it-scale/tlb_flush1_processes -t 96 -s 10, it shows obvious
      hotspot on lruvec->lock when test in single environment. What's
      more, The performance improved greatly if test in two more nodes
      system. The data shows below (more is better):

      ---------------------------------------------------------------------
      threads/process |   1     |     12   |     24   |   48     |   96
      ---------------------------------------------------------------------
      one node        | 14 1122 | 110 5372 | 111 2615 | 79 7084  | 72 4516
      ---------------------------------------------------------------------
      numa=fake=2     | 14 1168 | 144 4848 | 215 9070 | 157 0412 | 142 3968
      ---------------------------------------------------------------------
                      | For concurrency 12, no lruvec->lock hotspot. For 24,
      hotspot         | one node has 24% hotspot on lruvec->lock, but
                      | two nodes env hasn't.
      ---------------------------------------------------------------------

As for risks (e.g. numa balance...), they need to be discussed here.

Lastly, this just is a draft, I can improve next if it's acceptable.

Thanks!

Rongwei Wang (5):
  mm/numa: move numa emulation APIs into generic files
  mm: percpu: fix variable type of cpu
  arch_numa: remove __init in early_cpu_to_node()
  mm/numa: support CONFIG_NUMA_EMU for arm64
  mm/numa: migrate leftover numa emulation into mm/numa.c

 arch/x86/Kconfig                          |   8 -
 arch/x86/include/asm/numa.h               |   3 -
 arch/x86/mm/Makefile                      |   1 -
 arch/x86/mm/numa.c                        | 216 +-------------
 arch/x86/mm/numa_internal.h               |  14 +-
 drivers/base/arch_numa.c                  |   7 +-
 include/asm-generic/numa.h                |  33 +++
 include/linux/percpu.h                    |   2 +-
 mm/Kconfig                                |   8 +
 mm/Makefile                               |   1 +
 arch/x86/mm/numa_emulation.c => mm/numa.c | 333 +++++++++++++++++++++-
 11 files changed, 373 insertions(+), 253 deletions(-)
 rename arch/x86/mm/numa_emulation.c => mm/numa.c (63%)

-- 
2.32.0.3.gf3a3e56d6

