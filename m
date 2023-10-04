Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE8D7B7B09
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbjJDJFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241916AbjJDJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:05:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85E24D8;
        Wed,  4 Oct 2023 02:05:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D96EF1515;
        Wed,  4 Oct 2023 02:06:11 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ADB83F59C;
        Wed,  4 Oct 2023 02:05:31 -0700 (PDT)
From:   Hongyan Xia <Hongyan.Xia2@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org, Hongyan Xia <hongyan.xia2@arm.com>,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH 3/6] sched/fair: Use CFS util_avg_uclamp for utilization and frequency
Date:   Wed,  4 Oct 2023 10:04:51 +0100
Message-Id: <b2fc40b143f90ce652a02950503cbe744bc1d112.1696345700.git.Hongyan.Xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696345700.git.Hongyan.Xia2@arm.com>
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyan Xia <hongyan.xia2@arm.com>

Switch to the new util_avg_uclamp for task and runqueue utilization.
Since util_est() calls task_util(), this means util_est is now also a
clamped value.

Now that we have the sum aggregated CFS util value, we do not need to
consult uclamp buckets to know how the frequency should be clamped. We
simply look at the aggregated top level root_cfs_util_uclamp to know
what frequency to choose. Because we simulate PELT decay in
root_cfs_util_uclamp anyway, there's no need in cpufreq_schedutil.c to
avoid premature frequency drops.

Consequently, there is no need for uclamp_rq_util_with(). This function
takes the un-clamped util value and sends it through various clamping
filters to get the final value. However, util_avg_uclamp is propagated
with clamping in mind already, so it does not need to be clamped again.

TODO: There are two major caveats in this patch.
1. At the moment sum aggregation does not consider RT tasks. The avg_rt
   signal considers all RT tasks on this rq as a single entity, which
   means the utilization of individual RT tasks is not tracked
   separately. If we want to use sum aggregation, we might have to track
   utilization of RT tasks individually.
2. Busy time accounting in compute_energy() now takes the uclamp'ed
   value. Ideally, it should reflect reality and use the un-clamp'ed
   values. However, that would require maintaining both the normal and
   uclamp'ed values for util_est. This needs to be revisited if it
   causes real problems in practice.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/core.c              |  10 +--
 kernel/sched/cpufreq_schedutil.c |  19 +++---
 kernel/sched/fair.c              |  38 +++++------
 kernel/sched/sched.h             | 106 +++++++++----------------------
 4 files changed, 59 insertions(+), 114 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index efe3848978a0..32511ee63f01 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7402,10 +7402,12 @@ int sched_core_idle_cpu(int cpu)
  * The DL bandwidth number otoh is not a measured metric but a value computed
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
+ *
+ * The util_cfs parameter has already taken uclamp into account (unless uclamp
+ * support is not compiled in).
  */
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 enum cpu_util_type type,
-				 struct task_struct *p)
+				 enum cpu_util_type type)
 {
 	unsigned long dl_util, util, irq, max;
 	struct rq *rq = cpu_rq(cpu);
@@ -7439,8 +7441,6 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * frequency will be gracefully reduced with the utilization decay.
 	 */
 	util = util_cfs + cpu_util_rt(rq);
-	if (type == FREQUENCY_UTIL)
-		util = uclamp_rq_util_with(rq, util, p);
 
 	dl_util = cpu_util_dl(rq);
 
@@ -7493,7 +7493,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 
 unsigned long sched_cpu_util(int cpu)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL);
 }
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4492608b7d7f..6e63952b8063 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -159,8 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
-					  FREQUENCY_UTIL, NULL);
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util, FREQUENCY_UTIL);
 }
 
 /**
@@ -282,7 +281,11 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 	 * into the same scale so we can compare.
 	 */
 	boost = (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
-	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
+	/*
+	 * TODO: Investigate what should be done here. In sum aggregation there
+	 * is no such thing as uclamp_max on a rq, so how do we cap the boost
+	 * value, or do we want to cap the boost frequency here at all?
+	 */
 	if (sg_cpu->util < boost)
 		sg_cpu->util = boost;
 }
@@ -346,11 +349,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
-	 *
-	 * Except when the rq is capped by uclamp_max.
 	 */
-	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
+	if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
 		next_f = sg_policy->next_freq;
 
 		/* Restore cached freq as next_freq has changed */
@@ -399,11 +399,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	/*
 	 * Do not reduce the target performance level if the CPU has not been
 	 * idle recently, as the reduction is likely to be premature then.
-	 *
-	 * Except when the rq is capped by uclamp_max.
 	 */
-	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
+	if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 420af57d01ee..31004aae5f09 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4572,10 +4572,17 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 
 static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
 
+#ifdef CONFIG_UCLAMP_TASK
+static inline unsigned long task_util(struct task_struct *p)
+{
+	return READ_ONCE(p->se.avg.util_avg_uclamp);
+}
+#else
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.util_avg);
 }
+#endif
 
 static inline unsigned long _task_util_est(struct task_struct *p)
 {
@@ -4589,22 +4596,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
 	return max(task_util(p), _task_util_est(p));
 }
 
-#ifdef CONFIG_UCLAMP_TASK
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return clamp(task_util_est(p), uclamp_min, uclamp_max);
-}
-#else
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return task_util_est(p);
-}
-#endif
-
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
@@ -7468,11 +7459,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 static unsigned long
 cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 {
-	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
-	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
+	struct rq *rq = cpu_rq(cpu);
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	unsigned long util = root_cfs_util(rq);
+	bool capped = uclamp_rq_is_capped(rq);
 	unsigned long runnable;
 
-	if (boost) {
+	if (boost && !capped) {
 		runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
 		util = max(util, runnable);
 	}
@@ -7629,7 +7622,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	for_each_cpu(cpu, pd_cpus) {
 		unsigned long util = cpu_util(cpu, p, -1, 0);
 
-		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
+		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL);
 	}
 
 	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
@@ -7650,7 +7643,6 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 	int cpu;
 
 	for_each_cpu(cpu, pd_cpus) {
-		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
 		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
 		unsigned long eff_util;
 
@@ -7661,7 +7653,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
+		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL);
 		max_util = max(max_util, eff_util);
 	}
 
@@ -7758,7 +7750,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!uclamp_task_util(p, p_util_min, p_util_max))
+	if (!task_util_est(p))
 		goto unlock;
 
 	eenv_task_busy_time(&eenv, p, prev_cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 98fa5e79f4e9..e73aedd9a76b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2997,8 +2997,7 @@ enum cpu_util_type {
 };
 
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 enum cpu_util_type type,
-				 struct task_struct *p);
+				 enum cpu_util_type type);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
@@ -3055,85 +3054,44 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
 }
 
-/**
- * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
- * @rq:		The rq to clamp against. Must not be NULL.
- * @util:	The util value to clamp.
- * @p:		The task to clamp against. Can be NULL if you want to clamp
- *		against @rq only.
- *
- * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
- *
- * If sched_uclamp_used static key is disabled, then just return the util
- * without any clamping since uclamp aggregation at the rq level in the fast
- * path is disabled, rendering this operation a NOP.
+/*
+ * When uclamp is compiled in, the aggregation at rq level is 'turned off'
+ * by default in the fast path and only gets turned on once userspace performs
+ * an operation that requires it.
  *
- * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
- * will return the correct effective uclamp value of the task even if the
- * static key is disabled.
+ * Returns true if userspace opted-in to use uclamp and aggregation at rq level
+ * hence is active.
  */
-static __always_inline
-unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
-				  struct task_struct *p)
+static inline bool uclamp_is_used(void)
 {
-	unsigned long min_util = 0;
-	unsigned long max_util = 0;
-
-	if (!static_branch_likely(&sched_uclamp_used))
-		return util;
-
-	if (p) {
-		min_util = uclamp_eff_value(p, UCLAMP_MIN);
-		max_util = uclamp_eff_value(p, UCLAMP_MAX);
-
-		/*
-		 * Ignore last runnable task's max clamp, as this task will
-		 * reset it. Similarly, no need to read the rq's min clamp.
-		 */
-		if (uclamp_rq_is_idle(rq))
-			goto out;
-	}
-
-	min_util = max_t(unsigned long, min_util, uclamp_rq_get(rq, UCLAMP_MIN));
-	max_util = max_t(unsigned long, max_util, uclamp_rq_get(rq, UCLAMP_MAX));
-out:
-	/*
-	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
-	 * RUNNABLE tasks with _different_ clamps, we can end up with an
-	 * inversion. Fix it now when the clamps are applied.
-	 */
-	if (unlikely(min_util >= max_util))
-		return min_util;
+	return static_branch_likely(&sched_uclamp_used);
+}
 
-	return clamp(util, min_util, max_util);
+static inline unsigned long root_cfs_util(struct rq *rq)
+{
+	return READ_ONCE(rq->root_cfs_util_uclamp);
 }
 
 /* Is the rq being capped/throttled by uclamp_max? */
 static inline bool uclamp_rq_is_capped(struct rq *rq)
 {
-	unsigned long rq_util;
-	unsigned long max_util;
+	unsigned long uclamp_util, real_util;
 
-	if (!static_branch_likely(&sched_uclamp_used))
+	if (!uclamp_is_used())
 		return false;
 
-	rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
-	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
-
-	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
-}
+	/*
+	 * At the moment there's no such thing as uclamp_max for RT tasks, so
+	 * we only see if CFS is capped.
+	 *
+	 * TODO: Implement uclamp sum aggregation for RT.
+	 */
+	uclamp_util = root_cfs_util(rq);
+	real_util = READ_ONCE(rq->cfs.avg.util_avg);
 
-/*
- * When uclamp is compiled in, the aggregation at rq level is 'turned off'
- * by default in the fast path and only gets turned on once userspace performs
- * an operation that requires it.
- *
- * Returns true if userspace opted-in to use uclamp and aggregation at rq level
- * hence is active.
- */
-static inline bool uclamp_is_used(void)
-{
-	return static_branch_likely(&sched_uclamp_used);
+	/* XXX: The 80 margin here isn't backed by science. */
+	return uclamp_util < SCHED_CAPACITY_SCALE &&
+		real_util > uclamp_util + 80;
 }
 
 static inline void enqueue_util_avg_uclamp(struct cfs_rq *cfs_rq,
@@ -3172,13 +3130,6 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline
-unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
-				  struct task_struct *p)
-{
-	return util;
-}
-
 static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
 
 static inline bool uclamp_is_used(void)
@@ -3205,6 +3156,11 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return false;
 }
 
+static inline unsigned long root_cfs_util(struct rq *rq)
+{
+	return READ_ONCE(rq->cfs.avg.util_avg);
+}
+
 static inline void enqueue_util_avg_uclamp(struct cfs_rq *cfs_rq,
 					   struct sched_entity *se)
 {
-- 
2.34.1

