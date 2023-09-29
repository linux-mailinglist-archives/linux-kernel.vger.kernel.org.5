Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E47B3A19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjI2Se3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjI2Se1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:34:27 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5977D19F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1696012462;
        bh=AlRztrkqyKUOFkQYVS+dl2vFj7Ffobpd8WDcQyWDybc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZxI5MF+6gaoCDzGJJbN6lgPMdDS2d6nd2t5VfOqglCfgRqz2pjQVJZ4V5xn9I7XJW
         tFC1i16fXHgZvZqViBS09fHpsgGH62+HHa/eWHCJilw4akAc3Scnux7g8rtBlEuL9y
         zCIo5i12gzrspNL4bVIup9IUPJaQBYbvNfAJduOV41diEfwfKScoI5XP7QLyu/huZ8
         3IEHOY2cnXtQ/QlSt7STb3MreW0//BTzXBkF6W/90yPdCvjag4enw7CrDOqo37v+03
         ++26pbKhgS9vOLFQ1SgZldb5G+fba2RMdam5qYZNxSwamfP8mN9lDkrRDygFcAOB/9
         kMiIXBI/HuX7Q==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RxzXG4p6zz1Rdc;
        Fri, 29 Sep 2023 14:34:22 -0400 (EDT)
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
Subject: [RFC PATCH] sched/fair: Bias runqueue selection towards almost idle prev CPU
Date:   Fri, 29 Sep 2023 14:33:50 -0400
Message-Id: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
select_task_rq towards the previous CPU if it was almost idle
(avg_load <= 0.1%). It eliminates frequent task migrations from almost
idle CPU to completely idle CPUs. This is achieved by using the CPU
load of the previously used CPU as "almost idle" criterion in
wake_affine_idle() and select_idle_sibling().

The following benchmarks are performed on a v6.5.5 kernel with
mitigations=off.

This speeds up the following hackbench workload on a 192 cores AMD EPYC
9654 96-Core Processor (over 2 sockets):

hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

from 49s to 32s. (34% speedup)

We can observe that the number of migrations is reduced significantly
(-94%) with this patch, which may explain the speedup:

Baseline:      118M cpu-migrations  (9.286 K/sec)
With patch:      7M cpu-migrations  (0.709 K/sec)

As a consequence, the stalled-cycles-backend are reduced:

Baseline:     8.16% backend cycles idle
With patch:   6.70% backend cycles idle

Interestingly, the rate of context switch increases with the patch, but
it does not appear to be an issue performance-wise:

Baseline:     454M context-switches (35.677 K/sec)
With patch:   654M context-switches (62.290 K/sec)

This was developed as part of the investigation into a weird regression
reported by AMD where adding a raw spinlock in the scheduler context
switch accelerated hackbench. It turned out that changing this raw
spinlock for a loop of 10000x cpu_relax within do_idle() had similar
benefits.

This patch achieves a similar effect without the busy-waiting by
allowing select_task_rq to favor almost idle previously used CPUs based
on the CPU load of that CPU. The threshold of 0.1% avg_load for almost
idle CPU load has been identified empirically using the hackbench
workload.

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
 kernel/sched/fair.c     | 18 +++++++++++++-----
 kernel/sched/features.h |  6 ++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d9c2482c5a3..65a7d923ea61 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6599,6 +6599,14 @@ static int wake_wide(struct task_struct *p)
 	return 1;
 }
 
+static bool
+almost_idle_cpu(int cpu, struct task_struct *p)
+{
+	if (!sched_feat(WAKEUP_BIAS_PREV_IDLE))
+		return false;
+	return cpu_load_without(cpu_rq(cpu), p) <= LOAD_AVG_MAX / 1000;
+}
+
 /*
  * The purpose of wake_affine() is to quickly determine on which CPU we can run
  * soonest. For the purpose of speed we only consider the waking and previous
@@ -6612,7 +6620,7 @@ static int wake_wide(struct task_struct *p)
  *			  for the overloaded case.
  */
 static int
-wake_affine_idle(int this_cpu, int prev_cpu, int sync)
+wake_affine_idle(int this_cpu, int prev_cpu, int sync, struct task_struct *p)
 {
 	/*
 	 * If this_cpu is idle, it implies the wakeup is from interrupt
@@ -6632,7 +6640,7 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
 
-	if (available_idle_cpu(prev_cpu))
+	if (available_idle_cpu(prev_cpu) || almost_idle_cpu(prev_cpu, p))
 		return prev_cpu;
 
 	return nr_cpumask_bits;
@@ -6687,7 +6695,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	int target = nr_cpumask_bits;
 
 	if (sched_feat(WA_IDLE))
-		target = wake_affine_idle(this_cpu, prev_cpu, sync);
+		target = wake_affine_idle(this_cpu, prev_cpu, sync, p);
 
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
@@ -7139,7 +7147,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	if ((available_idle_cpu(target) || sched_idle_cpu(target) || (prev == target && almost_idle_cpu(target, p))) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
@@ -7147,7 +7155,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
-	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev) || almost_idle_cpu(prev, p)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev))
 		return prev;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..b06d06c2b728 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -37,6 +37,12 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
+/*
+ * Bias runqueue selection towards previous runqueue if it is almost
+ * idle.
+ */
+SCHED_FEAT(WAKEUP_BIAS_PREV_IDLE, true)
+
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
 SCHED_FEAT(DOUBLE_TICK, false)
-- 
2.39.2

