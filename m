Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B94A7CFF06
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbjJSQF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346418AbjJSQFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:05:21 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17541B6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697731516;
        bh=/qm7GcGwm1ebkabq6qaUZBB+Rnlf8p16CqUhbmaGPMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCozT0bBR8yiQPSUL4b3MjiN4PCSLMl6gR6wH2f2aS7EnSVrtqWDWkUA6SANwXP0i
         /Q7DmTTPXjHeSSP5UHrZ/64piIqGFcOUinT5bJ+v+eGF8uiDpnOvhcy4pQLoCM+krV
         LmrmVpJ1V9GIXL8UeQj7QaLhaxUkmoi08jWtxvAdpEbjw7681RTczW1IgI3Zx3+Wjq
         YMZN5sSBHTmuehbLPE/g88uVb8TvVb+TjW3A1J/WtNc2h5QgR0OUQX51xurmbhvyTz
         QZ3cxgk1J5a4B6fsyinMKjKfmBcPSVsrGHVS+4/HF9u3P90vo0bCyWCYArZxDocc35
         WZHEFC2u4LTxQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SBCH03TyNz1YRj;
        Thu, 19 Oct 2023 12:05:16 -0400 (EDT)
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
Subject: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY feature (v2)
Date:   Thu, 19 Oct 2023 12:05:22 -0400
Message-Id: <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the UTIL_FITS_CAPACITY scheduler feature. The runqueue
selection picks the previous, target, or recent runqueues if they have
enough remaining capacity to enqueue the task before scanning for an
idle cpu.

This feature is introduced in preparation for the SELECT_BIAS_PREV
scheduler feature.

The following benchmarks only cover the UTIL_FITS_CAPACITY feature.
Those are performed on a v6.5.5 kernel with mitigations=off.

The following hackbench workload on a 192 cores AMD EPYC 9654 96-Core
Processor (over 2 sockets) improves the wall time from 49s to 40s
(18% speedup).

hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

We can observe that the number of migrations is reduced significantly
with this patch (improvement):

Baseline:      117M cpu-migrations  (9.355 K/sec)
With patch:     47M cpu-migrations  (3.977 K/sec)

The task-clock utilization is increased (improvement):

Baseline:      253.275 CPUs utilized
With patch:    271.367 CPUs utilized

The number of context-switches is increased (degradation):

Baseline:      445M context-switches (35.516 K/sec)
With patch:    586M context-switches (48.823 K/sec)

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
Link: https://lore.kernel.org/lkml/20231017221204.1535774-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20231018204511.1563390-1-mathieu.desnoyers@efficios.com/
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
Changes since v1:
- Use scale_rt_capacity(),
- Use fits_capacity which leaves 20% unused capacity to account for
  metrics inaccuracy.
---
 kernel/sched/fair.c     | 40 ++++++++++++++++++++++++++++++++++------
 kernel/sched/features.h |  6 ++++++
 kernel/sched/sched.h    |  5 +++++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d9c2482c5a3..cc86d1ffeb27 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4497,6 +4497,28 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
+static unsigned long scale_rt_capacity(int cpu);
+
+/*
+ * Returns true if adding the task utilization to the estimated
+ * utilization of the runnable tasks on @cpu does not exceed the
+ * capacity of @cpu.
+ *
+ * This considers only the utilization of _runnable_ tasks on the @cpu
+ * runqueue, excluding blocked and sleeping tasks. This is achieved by
+ * using the runqueue util_est.enqueued.
+ */
+static inline bool task_fits_remaining_cpu_capacity(unsigned long task_util,
+						    int cpu)
+{
+	unsigned long total_util;
+
+	if (!sched_util_fits_capacity_active())
+		return false;
+	total_util = READ_ONCE(cpu_rq(cpu)->cfs.avg.util_est.enqueued) + task_util;
+	return fits_capacity(total_util, scale_rt_capacity(cpu));
+}
+
 static inline int util_fits_cpu(unsigned long util,
 				unsigned long uclamp_min,
 				unsigned long uclamp_max,
@@ -7124,12 +7146,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	int i, recent_used_cpu;
 
 	/*
-	 * On asymmetric system, update task utilization because we will check
-	 * that the task fits with cpu's capacity.
+	 * With the UTIL_FITS_CAPACITY feature and on asymmetric system,
+	 * update task utilization because we will check that the task
+	 * fits with cpu's capacity.
 	 */
-	if (sched_asym_cpucap_active()) {
+	if (sched_util_fits_capacity_active() || sched_asym_cpucap_active()) {
 		sync_entity_load_avg(&p->se);
 		task_util = task_util_est(p);
+	}
+	if (sched_asym_cpucap_active()) {
 		util_min = uclamp_eff_value(p, UCLAMP_MIN);
 		util_max = uclamp_eff_value(p, UCLAMP_MAX);
 	}
@@ -7139,7 +7164,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	if ((available_idle_cpu(target) || sched_idle_cpu(target) ||
+	    task_fits_remaining_cpu_capacity(task_util, target)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
@@ -7147,7 +7173,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
-	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev) ||
+	    task_fits_remaining_cpu_capacity(task_util, prev)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev))
 		return prev;
 
@@ -7173,7 +7200,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
+	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu) ||
+	    task_fits_remaining_cpu_capacity(task_util, recent_used_cpu)) &&
 	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
 		return recent_used_cpu;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..9a84a1401123 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -97,6 +97,12 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
 
+/*
+ * Select the previous, target, or recent runqueue if they have enough
+ * remaining capacity to enqueue the task. Requires UTIL_EST.
+ */
+SCHED_FEAT(UTIL_FITS_CAPACITY, true)
+
 SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e93e006a942b..463e75084aed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2090,6 +2090,11 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 
 #endif /* SCHED_DEBUG */
 
+static __always_inline bool sched_util_fits_capacity_active(void)
+{
+	return sched_feat(UTIL_EST) && sched_feat(UTIL_FITS_CAPACITY);
+}
+
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
 
-- 
2.39.2

