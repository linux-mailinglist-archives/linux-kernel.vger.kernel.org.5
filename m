Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B357E03B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377706AbjKCNSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377628AbjKCNSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:18:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF44134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:18:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32f7abbb8b4so1257509f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699017506; x=1699622306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mIt+lv4yPEO9Yhocb1mj5iSx33QbDf2o5rRTl2H5Vw=;
        b=FO0kh7KI7yQmR3ciYXFn3OKucucTMKHrAF3aAVgOcXGBYd1ginF/OqXTsHe//MVW8M
         fTyCzftilpzu9XhgCEMaxgTJpZB+mNe/6tmuuf5q+VDo94GvHxJZXoMlCtIX5AHQ249U
         deSahFClMFwYGdmZeIDedpqvVAh8/8SXNxmTXnLVq8W3TLahFzOD0/5kIRcoeQz4+HMv
         6zOqkG17PzzdnkRtAjrmzOTQVd0v3q9MjKbeqe3RJbahbqw8U5wlibXVDdrkm+kF/no1
         Ej0KRuWZotawytML4kvQdpFibLjjGnidqTdCtfnUIzEy6sy1mRdk4mi9Kh862SCwcEYz
         UO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017506; x=1699622306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mIt+lv4yPEO9Yhocb1mj5iSx33QbDf2o5rRTl2H5Vw=;
        b=b9QSh8GqQp5LRN3bL0wKLnkApBE/dDCa15QQeTKGMQfs1juGKAAPj355zb125MNG/2
         NlhCO2dCaTLJvI49n+Jii6rSvbbRrIoz51ARmhHWYh/xK30eB7YHPy0ICAvyqLHfTlkJ
         CG0IutYzT11Dl2/ca6UkcEivEcWr9xNf97HRDl9u77gKX3tNwVrT9HZ6S09Chrm2xY69
         6F8lhzdGViQtd0UL1fDKjA+bEp0GywVIRdDLN8Ybk/iOAZnn70NtfgEQvW6vrI8tkhfY
         NbTcS/aZtqVP7VB+FkWtSxOrSSJULhEiC9peM448j+/YQg4zSU2GYu9OviArESPtwJRT
         SsaA==
X-Gm-Message-State: AOJu0YwfJhmvFyDn8bojfg2xXmYiYaJN60ZLLxYIEXwoRcKLDxh1VkUG
        bNwJpD4VCOLZ8o+kP2BLvYnjSw==
X-Google-Smtp-Source: AGHT+IGR8BxEBHae/pbTAzHkz3eFx7aLN9DnhUF4/DSeMLPC6Gk9RlOQKM/sSMO2KvhKKLRpEV0SlQ==
X-Received: by 2002:a5d:5981:0:b0:32f:7767:eab2 with SMTP id n1-20020a5d5981000000b0032f7767eab2mr19356640wri.14.1699017506222;
        Fri, 03 Nov 2023 06:18:26 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d68ce000000b0032daf848f68sm1877565wrw.59.2023.11.03.06.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:18:25 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
Date:   Fri,  3 Nov 2023 14:18:20 +0100
Message-Id: <20231103131821.1176294-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103131821.1176294-1-vincent.guittot@linaro.org>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current method to take into account uclamp hints when estimating the
target frequency can end into situation where the selected target
frequency is finally higher than uclamp hints whereas there are no real
needs. Such cases mainly happen because we are currently mixing the
traditional scheduler utilization signal with the uclamp performance
hints. By adding these 2 metrics, we loose an important information when
it comes to select the target frequency and we have to make some
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
the final performance level that is targeted for the CPU after applying
some cpufreq headroom and taking into account all inputs.

With these 2 functions, schedutil is now able to decide when it must go
above uclamp hints. It now also have a generic way to get the min
perfromance level.

The dependency between energy model and cpufreq governor and its headroom
policy doesn't exist anymore.

eenv_pd_max_util asks schedutil for the targeted performance after
applying the impact of the waking task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h     |  1 -
 kernel/sched/core.c              | 82 ++++++++++++--------------------
 kernel/sched/cpufreq_schedutil.c | 40 ++++++++++++----
 kernel/sched/fair.c              | 22 +++++++--
 kernel/sched/sched.h             | 24 +++-------
 5 files changed, 86 insertions(+), 83 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b9caa01dfac4..adec808b371a 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -243,7 +243,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	scale_cpu = arch_scale_cpu_capacity(cpu);
 	ps = &pd->table[pd->nr_perf_states - 1];
 
-	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
 	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7a0c16115b79..af5333327493 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7391,18 +7391,13 @@ int sched_core_idle_cpu(int cpu)
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
@@ -7410,45 +7405,41 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
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
+	/*
+	 * The minimum utilization returns the highest level between:
+	 * - the computed DL bandwidth needed with the irq pressure which
+	 *   steals time to the deadline task.
+	 * - The minimum bandwidth requirement for CFS and/or RT.
+	 */
+	if (min)
+		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
 
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
+	 * The maximum hint is a soft bandwidth requirement which can be lower
+	 * than the actual utilization because of uclamp_max requirements
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
@@ -7459,28 +7450,15 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
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
index 458d359f5991..38accd8c854b 100644
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
@@ -153,14 +152,35 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
+unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
+				 unsigned long min,
+				 unsigned long max)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (rt_rq_is_runnable(&rq->rt))
+		return max;
+
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
+	sg_cpu->bw_min = map_util_perf(min);
+	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
 }
 
 /**
@@ -306,7 +326,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
  */
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
-	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
+	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
 		sg_cpu->sg_policy->limits_changed = true;
 }
 
@@ -407,8 +427,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
-	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util), max_cap);
+	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
+				   sg_cpu->util, max_cap);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8767988242ee..ed64f2eaaa2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7671,7 +7671,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	for_each_cpu(cpu, pd_cpus) {
 		unsigned long util = cpu_util(cpu, p, -1, 0);
 
-		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
+		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
 	}
 
 	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
@@ -7694,7 +7694,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
 		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
-		unsigned long eff_util;
+		unsigned long eff_util, min, max;
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -7703,7 +7703,23 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
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
+			 * directly use task's one otherwise keep max
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
index 2e5a95486a42..302b451a3fd8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2961,24 +2961,14 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
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
-- 
2.34.1

