Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619567CCFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJQWMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQWMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:12:13 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB8AB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697580728;
        bh=aq553lTH/P/eg3unHB+xg5ckzW8DyeiJUeDSvYFj37Y=;
        h=From:To:Cc:Subject:Date:From;
        b=SGtnRQyii2OodO7HTwkxdYWU+oLFQ009vvcPAHAezz9SYIQzDaHHXSnRyKcDnU6yn
         KEJaeuI5yxaqPKb6A9O81cHwA535hPhyJ4dVRhkmRrw+vaYkPBSQFwk89L2iwGKBNF
         qEGRk1f0u5Uhoiz/yPbKlNkH/GpPerx8XpJP3AoiZsIo7MMgfBGXqGCyq/crSzUK4Y
         zaq7p5dP/Kei6uoiRTDkYdYoAHiNbLUtGCQvGKQeFMm8hGKp2woH0Fitg26W1c7BzP
         +czYOL6No4uL6zsaRNclqFDcIxfOfMOuBe2c8g8mBbXb11Z5aViTR34cTRm9EqS2W/
         HT4zb+MY9WgPQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4S97WD4kNBz1Xwy;
        Tue, 17 Oct 2023 18:12:08 -0400 (EDT)
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
        Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
Subject: [RFC PATCH] sched/fair: Introduce WAKEUP_BIAS_PREV to reduce migrations
Date:   Tue, 17 Oct 2023 18:12:04 -0400
Message-Id: <20231017221204.1535774-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the WAKEUP_BIAS_PREV scheduler feature to reduce the task
migration rate.

For scenarios where the system is under-utilized (CPUs are partly idle),
eliminate frequent task migrations from CPUs with spare capacity left to
completely idle CPUs by introducing a bias towards the previous CPU if
it is idle or has spare capacity left in select_idle_sibling(). Use 25%
of the previously used CPU capacity as spare capacity cutoff.

For scenarios where the system is fully or over-utilized (CPUs are
almost never idle), favor the previous CPU (rather than the target CPU)
if all CPUs are busy to minimize migrations. (suggested by Chen Yu)

The following benchmarks are performed on a v6.5.5 kernel with
mitigations=off.

This speeds up the following hackbench workload on a 192 cores AMD EPYC
9654 96-Core Processor (over 2 sockets):

hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

from 49s to 29s. (41% speedup)

We can observe that the number of migrations is reduced significantly
(-94%) with this patch, which may explain the speedup:

Baseline:      118M cpu-migrations  (9.286 K/sec)
With patch:      7M cpu-migrations  (0.701 K/sec)

As a consequence, the stalled-cycles-backend are reduced:

Baseline:     8.16% backend cycles idle
With patch:   6.46% backend cycles idle

Interestingly, the rate of context switch increases with the patch, but
it does not appear to be an issue performance-wise:

Baseline:     454M context-switches (35.677 K/sec)
With patch:   683M context-switches (69.299 K/sec)

This was developed as part of the investigation into a weird regression
reported by AMD where adding a raw spinlock in the scheduler context
switch accelerated hackbench. It turned out that changing this raw
spinlock for a loop of 10000x cpu_relax within do_idle() had similar
benefits.

This patch achieves a similar effect without the busy-waiting by
allowing select_task_rq to favor the previously used CPUs based on the
utilization of that CPU. The threshold of 25% spare capacity has been
identified empirically using the hackbench workload.

Feedback is welcome. I am especially interested to learn whether this
patch has positive or detrimental effects on performance of other
workloads.

Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/f6dc1652-bc39-0b12-4b6b-29a2f9cd8484@amd.com/
Link: https://lore.kernel.org/lkml/20230822113133.643238-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230823060832.454842-1-aaron.lu@intel.com/
Link: https://lore.kernel.org/lkml/20230905171105.1005672-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/cover.1695704179.git.yu.c.chen@intel.com/
Link: https://lore.kernel.org/lkml/20230929183350.239721-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20231012203626.1298944-1-mathieu.desnoyers@efficios.com/
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
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Gautham R . Shenoy <gautham.shenoy@amd.com>
Cc: x86@kernel.org
---
 kernel/sched/fair.c     | 46 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |  6 ++++++
 kernel/sched/sched.h    |  6 ++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d9c2482c5a3..23c055db48d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7113,6 +7113,25 @@ static inline bool asym_fits_cpu(unsigned long util,
 	return true;
 }
 
+/*
+ * Use the util_est.enqueued of the runqueue to estimate how much
+ * capacity is left in the cpu. util_est.enqueued sums the utilization
+ * of the runnable tasks, _excluding_ blocked and sleeping tasks.
+ *
+ * Compare this to arch_scale_cpu_capacity(). This is imperfect because
+ * it does not take into account the capacity used by other scheduling
+ * classes, but capacity_of() accounts for blocked and sleeping tasks
+ * from other scheduler classes, which is not what is needed here.
+ */
+static bool
+spare_capacity_cpu(int cpu, struct task_struct *p)
+{
+	if (!sched_feat(UTIL_EST))
+		return false;
+	return READ_ONCE(cpu_rq(cpu)->cfs.avg.util_est.enqueued) * 1024 <=
+	       arch_scale_cpu_capacity(cpu) * (1024 - SPARE_CAPACITY_THRESHOLD);
+}
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
@@ -7139,18 +7158,32 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
+	/*
+	 * With the WAKEUP_BIAS_PREV feature, if the previous CPU is
+	 * cache affine and has spare capacity left, prefer the previous
+	 * CPU to the target CPU to inhibit costly task migration.
+	 */
+	if (sched_feat(WAKEUP_BIAS_PREV) &&
+	    (prev == target || cpus_share_cache(prev, target)) &&
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev) || spare_capacity_cpu(prev, p)) &&
+	    asym_fits_cpu(task_util, util_min, util_max, prev))
+		return prev;
+
 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
 	/*
-	 * If the previous CPU is cache affine and idle, don't be stupid:
+	 * Without the WAKEUP_BIAS_PREV feature, use the previous CPU if
+	 * it is cache affine and idle if the target cpu is not idle.
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (!sched_feat(WAKEUP_BIAS_PREV) &&
+	    prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev))
 		return prev;
 
+
 	/*
 	 * Allow a per-cpu kthread to stack with the wakee if the
 	 * kworker thread and the tasks previous CPUs are the same.
@@ -7217,6 +7250,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	/*
+	 * With the WAKEUP_BIAS_PREV feature, if the previous CPU is
+	 * cache affine, prefer the previous CPU when all CPUs are busy
+	 * to inhibit migration.
+	 */
+	if (sched_feat(WAKEUP_BIAS_PREV) &&
+	    prev != target && cpus_share_cache(prev, target))
+		return prev;
+
 	return target;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..f264d90aae72 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -37,6 +37,12 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
+/*
+ * Bias runqueue selection towards the previous runqueue if it has
+ * spare capacity left or if all CPUs are busy.
+ */
+SCHED_FEAT(WAKEUP_BIAS_PREV, true)
+
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
 SCHED_FEAT(DOUBLE_TICK, false)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e93e006a942b..264baab2721c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -178,6 +178,12 @@ extern int sched_rr_timeslice;
  */
 #define RUNTIME_INF		((u64)~0ULL)
 
+/*
+ * Spare capacity threshold (value out of 1024) used to bias runqueue
+ * selection towards previous runqueue.
+ */
+#define SPARE_CAPACITY_THRESHOLD	256
+
 static inline int idle_policy(int policy)
 {
 	return policy == SCHED_IDLE;
-- 
2.39.2

