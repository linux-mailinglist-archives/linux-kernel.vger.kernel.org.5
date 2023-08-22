Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A46783EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjHVLbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjHVLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:31:02 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF373CD5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692703860;
        bh=SGb+2EYDa1JyIeIJLif+q9cXee8PjYwXk3X5TSjwFec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9HijNvYj0P5Ja84a0b/yEUeAyKZ7yuUjLrQVrB7/Tb9CcZ5dLjc9t+MyBXSsJegc
         LODWBd8f1hH2yj1sUaWFizc2jsZba3ofJuodWQDyPlKO63qPFlUgbYGDHxkaT40f0W
         KdSZeSBKK9Ab+42kixrzgRD6fvbkN2HW28Ev6FLsHUN3fXmGlsFkR1Dw1RP717BDTl
         38MdAxdamuyi+4wWw4umZsri/BLW1gPy/G5BRMmt45wP0zxXQgZ8KwAfclY765HzbP
         di1fIUaPwBYy+a1UDoRQ92VOuMvrPdKeFLqlyHOtayBCalX9BMyLYi7Vpi1b+U76r8
         S7CtY9PuPCRxA==
Received: from thinkos.home (unknown [142.120.205.109])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RVRxH6MXZz1MGJ;
        Tue, 22 Aug 2023 07:30:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
Subject: [RFC PATCH v3 3/3] sched: ttwu_queue_cond: skip queued wakeups across different l2 caches
Date:   Tue, 22 Aug 2023 07:31:33 -0400
Message-Id: <20230822113133.643238-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering a system like the AMD EPYC 9654 96-Core Processor, the L1
cache has a latency of 4-5 cycles, the L2 cache has a latency of at
least 14ns, whereas the L3 cache has a latency of 50ns [1]. Compared to
this, I measured the RAM accesses to a latency around 120ns on my
system [2]. So L3 really is only 2.4x faster than RAM accesses.
Therefore, with this relatively slow access speed compared to L2, the
scheduler will benefit from only considering CPUs sharing an L2 cache
for the purpose of using remote runqueue locking rather than queued
wakeups.

Skipping queued wakeups for all logical CPUs sharing an LLC means that
on a 192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), groups
of 8 cores (16 hardware threads) end up grabbing runqueue locks of other
runqueues within the same group for each wakeup, causing contention on
the runqueue locks.

Improve this by only considering logical cpus sharing an L2 cache as
candidates for skipping use of the queued wakeups.

This results in the following benchmark improvements:

    hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

from 49s to 34s. (30% speedup)

And similarly with perf bench:

    perf bench sched messaging -g 32 -p -t -l 100000

from 10.9s to 7.4s (32% speedup)

I have noticed that in order to observe the speedup, the workload needs
to keep the CPUs sufficiently busy to cause runqueue lock contention,
but not so busy that they don't go idle. This can be explained by the
fact that idle CPUs are a preferred target for task wakeup runqueue
selection, and therefore having idle cpus causes more migrations, which
triggers more remote wakeups. For both the hackbench and the perf bench
sched messaging benchmarks, the scale of the workload can be tweaked by
changing the number groups.

This was developed as part of the investigation into a weird regression
reported by AMD where adding a raw spinlock in the scheduler context
switch accelerated hackbench. It turned out that changing this raw
spinlock for a loop of 10000x cpu_relax within do_idle() had similar
benefits.

This patch achieves a similar effect without busy waiting nor changing
anything about runqueue selection on wakeup. It considers that only
hardware threads sharing an L2 cache should skip the queued
try-to-wakeup and directly grab the target runqueue lock, rather than
allowing all hardware threads sharing an LLC to do so.

I would be interested to hear feedback about performance impact of this
patch (improvement or regression) on other workloads and hardware,
especially for Intel CPUs. One thing that we might want to empirically
figure out from the topology is whether there is a maximum number of
hardware threads within an LLC below which it would make sense to use
the LLC rather than L2 as group within which queued wakeups can be
skipped.

Link: https://en.wikichip.org/wiki/amd/microarchitectures/zen_4 [1]
Link: https://github.com/ChipsandCheese/MemoryLatencyTest [2]
Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: x86@kernel.org
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 11e60a69ae31..317f4cec4653 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3934,10 +3934,10 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 		return false;
 
 	/*
-	 * If the CPU does not share cache, then queue the task on the
+	 * If the CPU does not share L2 cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
 	 */
-	if (!cpus_share_llc(smp_processor_id(), cpu))
+	if (!cpus_share_l2c(smp_processor_id(), cpu))
 		return true;
 
 	if (cpu == smp_processor_id())
-- 
2.39.2

