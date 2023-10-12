Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0543D7C77EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442502AbjJLUga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347394AbjJLUg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:36:28 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A61A9D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697142985;
        bh=FPaY66C3ZPJy5gK2Z09xtlcQh0OXYz9y/MMCrQXYRXk=;
        h=From:To:Cc:Subject:Date:From;
        b=pE39xo8q970/u/dDuWfE2JdXtGoEW9tJAKiQcWQ0PttESH9jYzmzIiSGvxv72AHuf
         A+rCuoNf5fI7xdMCEFoOvVTDr2QFAB5UsGBXR8VqrHDfNjiUheSQQ0Cb2snJw7eylu
         OdYXcEN8wRqWxuSTBD4+fHyCzgLSN6KvAPwTODS2azICjIrsjm3F5qZp635DVewhxi
         pG6V1gRuNRmjZFPcDjaqaSLctWbaO3PTSClWAScxG2ytl33f10MZzSi0fbRI2+bUI+
         XtwkbTnxjE6kC492Id31HoDxTCeW1vN/hufzjA4QfyC/6zXiuJPNycPno3ogq5F438
         As5Z7FSXOMquQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4S61d54Kx6z1XSn;
        Thu, 12 Oct 2023 16:36:25 -0400 (EDT)
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
Subject: [RFC PATCH] sched/fair: Introduce WAKEUP_BIAS_PREV_IDLE to reduce migrations
Date:   Thu, 12 Oct 2023 16:36:26 -0400
Message-Id: <20231012203626.1298944-1-mathieu.desnoyers@efficios.com>
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

Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature to reduce the
task migration rate.

For scenarios where the system is under-utilized (CPUs are partly idle),
eliminate frequent task migrations from almost idle CPU to completely
idle CPUs by introducing a bias towards the previous CPU if it is idle
or almost idle in select_idle_sibling(). Use 1% of the CPU capacity
of the previously used CPU as CPU utilization "almost idle" cutoff.

For scenarios where the system is fully or over-utilized (CPUs are
almost never idle), favor the previous CPU (rather than the target CPU)
if all CPUs are busy to minimize migrations. (suggested by Chen Yu)

The following benchmarks are performed on a v6.5.5 kernel with
mitigations=off.

This speeds up the following hackbench workload on a 192 cores AMD EPYC
9654 96-Core Processor (over 2 sockets):

hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

from 49s to 31s. (37% speedup)

We can observe that the number of migrations is reduced significantly
(-90%) with this patch, which may explain the speedup:

Baseline:      118M cpu-migrations  (9.286 K/sec)
With patch:      5M cpu-migrations  (0.580 K/sec)

As a consequence, the stalled-cycles-backend are reduced:

Baseline:     8.16% backend cycles idle
With patch:   6.85% backend cycles idle

Interestingly, the rate of context switch increases with the patch, but
it does not appear to be an issue performance-wise:

Baseline:     454M context-switches (35.677 K/sec)
With patch:   670M context-switches (70.805 K/sec)

This was developed as part of the investigation into a weird regression
reported by AMD where adding a raw spinlock in the scheduler context
switch accelerated hackbench. It turned out that changing this raw
spinlock for a loop of 10000x cpu_relax within do_idle() had similar
benefits.

This patch achieves a similar effect without the busy-waiting by
allowing select_task_rq to favor almost idle previously used CPUs based
on the utilization of that CPU. The threshold of 1% cpu_util for almost
idle CPU has been identified empirically using the hackbench workload.

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
 kernel/sched/fair.c     | 45 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |  6 ++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d9c2482c5a3..70bffe3b6bd7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7113,6 +7113,23 @@ static inline bool asym_fits_cpu(unsigned long util,
 	return true;
 }
 
+static unsigned long cpu_util_without(int cpu, struct task_struct *p);
+
+/*
+ * A runqueue is considered almost idle if:
+ *
+ *   cpu_util_without(cpu, p) / 1024 <= 1% * capacity_of(cpu)
+ *
+ * This inequality is transformed as follows to minimize arithmetic:
+ *
+ *   cpu_util_without(cpu, p) <= 10 * capacity_of(cpu)
+ */
+static bool
+almost_idle_cpu(int cpu, struct task_struct *p)
+{
+	return cpu_util_without(cpu, p) <= 10 * capacity_of(cpu);
+}
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
@@ -7139,18 +7156,33 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
+	/*
+	 * With the WAKEUP_BIAS_PREV_IDLE feature, if the previous CPU
+	 * is cache affine and almost idle, prefer the previous CPU to
+	 * the target CPU to inhibit costly task migration.
+	 */
+	if (sched_feat(WAKEUP_BIAS_PREV_IDLE) &&
+	    (prev == target || cpus_share_cache(prev, target)) &&
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev) || almost_idle_cpu(prev, p)) &&
+	    asym_fits_cpu(task_util, util_min, util_max, prev))
+		return prev;
+
 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
 	/*
-	 * If the previous CPU is cache affine and idle, don't be stupid:
+	 * Without the WAKEUP_BIAS_PREV_IDLE feature, use the previous
+	 * CPU if it is cache affine and idle if the target cpu is not
+	 * idle.
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (!sched_feat(WAKEUP_BIAS_PREV_IDLE) &&
+	    prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev))
 		return prev;
 
+
 	/*
 	 * Allow a per-cpu kthread to stack with the wakee if the
 	 * kworker thread and the tasks previous CPUs are the same.
@@ -7217,6 +7249,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	/*
+	 * With the WAKEUP_BIAS_PREV_IDLE feature, if the previous CPU
+	 * is cache affine, prefer the previous CPU when all CPUs are
+	 * busy to inhibit migration.
+	 */
+	if (sched_feat(WAKEUP_BIAS_PREV_IDLE) &&
+	    prev != target && cpus_share_cache(prev, target))
+		return prev;
+
 	return target;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..1ba67d177fe0 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -37,6 +37,12 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
+/*
+ * Bias runqueue selection towards the previous runqueue if it is almost
+ * idle or if all CPUs are busy.
+ */
+SCHED_FEAT(WAKEUP_BIAS_PREV_IDLE, true)
+
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
 SCHED_FEAT(DOUBLE_TICK, false)
-- 
2.39.2

