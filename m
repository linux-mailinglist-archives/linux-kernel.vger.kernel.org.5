Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF027F5D01
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbjKWKyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344712AbjKWKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:54:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967F1BD;
        Thu, 23 Nov 2023 02:54:42 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700736881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JGggGpeD1lZUn4G8SHqDv+vQD2DIJeF/08zaMfPpa8=;
        b=lnw5NCvl6/FDKlaq0bkKTlDnSFsd0pGbnxKcmvbC2rCWzueoYEWTMgQV4fx48wcuMnw2/i
        O2D8d18xK/Bse//Hu/dUHYGwd3D0H8Tml2U3jzioMtGoxnG8MKr0yZmTmfw7CFujDQmIKi
        mNW//3CBg0o4SdyJEM7CNLboZoalDNSnLzpUWbEF66mB0vbL9GG4MZeB9VDChaH/VRCtBS
        qUCdb4pXM0qxOS9uUnQB4HGZtYvFSDOLRCqzn3WV5WXPCTS+3dV3IvLYY+VdQoZUdslqro
        s8lx4g6b5Cx+GTF4ND6hgACLD/l7cw37Apnc0PVB6U7xiYv17NtULeGeWDtUOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700736881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JGggGpeD1lZUn4G8SHqDv+vQD2DIJeF/08zaMfPpa8=;
        b=lzTkSkHPY0Q04Bn/XMcFtgrxYmZ2oBMomWo/bYMqO16q9J3XyMPiv7VZfrpva6CiKg7FdL
        isobqhaiR1JOJbCA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpufreq: Rework schedutil governor
 performance estimation
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231122133904.446032-2-vincent.guittot@linaro.org>
References: <20231122133904.446032-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <170073688055.398.12687414937207369825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d
Gitweb:        https://git.kernel.org/tip/9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 22 Nov 2023 14:39:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Nov 2023 11:32:01 +01:00

sched/cpufreq: Rework schedutil governor performance estimation

The current method to take into account uclamp hints when estimating the
target frequency can end in a situation where the selected target
frequency is finally higher than uclamp hints, whereas there are no real
needs. Such cases mainly happen because we are currently mixing the
traditional scheduler utilization signal with the uclamp performance
hints. By adding these 2 metrics, we loose an important information when
it comes to select the target frequency, and we have to make some
assumptions which can't fit all cases.

Rework the interface between the scheduler and schedutil governor in order
to propagate all information down to the cpufreq governor.

effective_cpu_util() interface changes and now returns the actual
utilization of the CPU with 2 optional inputs:

- The minimum performance for this CPU; typically the capacity to handle
  the deadline task and the interrupt pressure. But also uclamp_min
  request when available.

- The maximum targeting performance for this CPU which reflects the
  maximum level that we would like to not exceed. By default it will be
  the CPU capacity but can be reduced because of some performance hints
  set with uclamp. The value can be lower than actual utilization and/or
  min performance level.

A new sugov_effective_cpu_perf() interface is also available to compute
the final performance level that is targeted for the CPU, after applying
some cpufreq headroom and taking into account all inputs.

With these 2 functions, schedutil is now able to decide when it must go
above uclamp hints. It now also has a generic way to get the min
performance level.

The dependency between energy model and cpufreq governor and its headroom
policy doesn't exist anymore.

eenv_pd_max_util() asks schedutil for the targeted performance after
applying the impact of the waking task.

[ mingo: Refined the changelog & C comments. ]

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20231122133904.446032-2-vincent.guittot@linaro.org
---
 include/linux/energy_model.h     |  1 +-
 kernel/sched/core.c              | 90 +++++++++++++------------------
 kernel/sched/cpufreq_schedutil.c | 35 ++++++++----
 kernel/sched/fair.c              | 22 ++++++--
 kernel/sched/sched.h             | 24 ++------
 5 files changed, 89 insertions(+), 83 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b9caa01..adec808 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -243,7 +243,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	scale_cpu = arch_scale_cpu_capacity(cpu);
 	ps = &pd->table[pd->nr_perf_states - 1];
 
-	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
 	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2de77a6..db4be49 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7467,18 +7467,13 @@ int sched_core_idle_cpu(int cpu)
  * required to meet deadlines.
  */
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 enum cpu_util_type type,
-				 struct task_struct *p)
+				 unsigned long *min,
+				 unsigned long *max)
 {
-	unsigned long dl_util, util, irq, max;
+	unsigned long util, irq, scale;
 	struct rq *rq = cpu_rq(cpu);
 
-	max = arch_scale_cpu_capacity(cpu);
-
-	if (!uclamp_is_used() &&
-	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
-		return max;
-	}
+	scale = arch_scale_cpu_capacity(cpu);
 
 	/*
 	 * Early check to see if IRQ/steal time saturates the CPU, can be
@@ -7486,45 +7481,49 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * update_irq_load_avg().
 	 */
 	irq = cpu_util_irq(rq);
-	if (unlikely(irq >= max))
-		return max;
+	if (unlikely(irq >= scale)) {
+		if (min)
+			*min = scale;
+		if (max)
+			*max = scale;
+		return scale;
+	}
+
+	if (min) {
+		/*
+		 * The minimum utilization returns the highest level between:
+		 * - the computed DL bandwidth needed with the IRQ pressure which
+		 *   steals time to the deadline task.
+		 * - The minimum performance requirement for CFS and/or RT.
+		 */
+		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
+
+		/*
+		 * When an RT task is runnable and uclamp is not used, we must
+		 * ensure that the task will run at maximum compute capacity.
+		 */
+		if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
+			*min = max(*min, scale);
+	}
 
 	/*
 	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
 	 * CFS tasks and we use the same metric to track the effective
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
-	 *
-	 * CFS and RT utilization can be boosted or capped, depending on
-	 * utilization clamp constraints requested by currently RUNNABLE
-	 * tasks.
-	 * When there are no CFS RUNNABLE tasks, clamps are released and
-	 * frequency will be gracefully reduced with the utilization decay.
 	 */
 	util = util_cfs + cpu_util_rt(rq);
-	if (type == FREQUENCY_UTIL)
-		util = uclamp_rq_util_with(rq, util, p);
-
-	dl_util = cpu_util_dl(rq);
+	util += cpu_util_dl(rq);
 
 	/*
-	 * For frequency selection we do not make cpu_util_dl() a permanent part
-	 * of this sum because we want to use cpu_bw_dl() later on, but we need
-	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
-	 * that we select f_max when there is no idle time.
-	 *
-	 * NOTE: numerical errors or stop class might cause us to not quite hit
-	 * saturation when we should -- something for later.
+	 * The maximum hint is a soft bandwidth requirement, which can be lower
+	 * than the actual utilization because of uclamp_max requirements.
 	 */
-	if (util + dl_util >= max)
-		return max;
+	if (max)
+		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
 
-	/*
-	 * OTOH, for energy computation we need the estimated running time, so
-	 * include util_dl and ignore dl_bw.
-	 */
-	if (type == ENERGY_UTIL)
-		util += dl_util;
+	if (util >= scale)
+		return scale;
 
 	/*
 	 * There is still idle time; further improve the number by using the
@@ -7535,28 +7534,15 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 *   U' = irq + --------- * U
 	 *                 max
 	 */
-	util = scale_irq_capacity(util, irq, max);
+	util = scale_irq_capacity(util, irq, scale);
 	util += irq;
 
-	/*
-	 * Bandwidth required by DEADLINE must always be granted while, for
-	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
-	 * to gracefully reduce the frequency when no tasks show up for longer
-	 * periods of time.
-	 *
-	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
-	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
-	 * an interface. So, we only do the latter for now.
-	 */
-	if (type == FREQUENCY_UTIL)
-		util += cpu_bw_dl(rq);
-
-	return min(max, util);
+	return min(scale, util);
 }
 
 unsigned long sched_cpu_util(int cpu)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
 }
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5888176..f3acf2c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -47,7 +47,7 @@ struct sugov_cpu {
 	u64			last_update;
 
 	unsigned long		util;
-	unsigned long		bw_dl;
+	unsigned long		bw_min;
 
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -143,7 +143,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 
-	util = map_util_perf(util);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
@@ -153,14 +152,30 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
+unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
+				 unsigned long min,
+				 unsigned long max)
+{
+	/* Add dvfs headroom to actual utilization */
+	actual = map_util_perf(actual);
+	/* Actually we don't need to target the max performance */
+	if (actual < max)
+		max = actual;
+
+	/*
+	 * Ensure at least minimum performance while providing more compute
+	 * capacity when possible.
+	 */
+	return max(min, max);
+}
+
 static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
-	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
-	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
 
-	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
-					  FREQUENCY_UTIL, NULL);
+	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
+	sg_cpu->bw_min = min;
+	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
 }
 
 /**
@@ -306,7 +321,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
  */
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
-	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
+	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
 		sg_cpu->sg_policy->limits_changed = true;
 }
 
@@ -407,8 +422,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
-	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util), max_cap);
+	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
+				   sg_cpu->util, max_cap);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 53dea95..34fe6e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7793,7 +7793,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	for_each_cpu(cpu, pd_cpus) {
 		unsigned long util = cpu_util(cpu, p, -1, 0);
 
-		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
+		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
 	}
 
 	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
@@ -7816,7 +7816,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
 		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
-		unsigned long eff_util;
+		unsigned long eff_util, min, max;
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -7825,7 +7825,23 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
+		eff_util = effective_cpu_util(cpu, util, &min, &max);
+
+		/* Task's uclamp can modify min and max value */
+		if (tsk && uclamp_is_used()) {
+			min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
+
+			/*
+			 * If there is no active max uclamp constraint,
+			 * directly use task's one, otherwise keep max.
+			 */
+			if (uclamp_rq_is_idle(cpu_rq(cpu)))
+				max = uclamp_eff_value(p, UCLAMP_MAX);
+			else
+				max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
+		}
+
+		eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
 		max_util = max(max_util, eff_util);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8a70d51..c1574cd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2994,24 +2994,14 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_SMP
-/**
- * enum cpu_util_type - CPU utilization type
- * @FREQUENCY_UTIL:	Utilization used to select frequency
- * @ENERGY_UTIL:	Utilization used during energy calculation
- *
- * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
- * need to be aggregated differently depending on the usage made of them. This
- * enum is used within effective_cpu_util() to differentiate the types of
- * utilization expected by the callers, and adjust the aggregation accordingly.
- */
-enum cpu_util_type {
-	FREQUENCY_UTIL,
-	ENERGY_UTIL,
-};
-
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 enum cpu_util_type type,
-				 struct task_struct *p);
+				 unsigned long *min,
+				 unsigned long *max);
+
+unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
+				 unsigned long min,
+				 unsigned long max);
+
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
