Return-Path: <linux-kernel+bounces-48207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB95D845897
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7229628B261
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F9C5D46D;
	Thu,  1 Feb 2024 13:12:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735F25CDFD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793151; cv=none; b=lWp06rbFPC6TcqgiDvTLhTPPnY/mfIz3fFJw/oY6H50MbHkuW4pZAlstHsgokpF0QkDOTR6lL0DnrDt6U6iF091e4wCJtGWjYc0mBjOZrZm61PmycG3itbeHpZH4H9TzJRDxePOr7YLNqkLw2NgOCtprXqaA4TiwkbYVum43HAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793151; c=relaxed/simple;
	bh=t7Hg4wTa+RM0YHgJQOc3/BebdVYjqWwE6KBAvsLFOVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urVen31Z1aQcVwfX29KQvmlnjyFBPG+ScEPuRYsXOn0uLysVrT/sfayYMRXgXkkj786i2oIpjNt2shYY1/yRaS1OcQW0dp1nG3QI0Rtnp9ydrFteuqxg2BdZEDZGz4yZKQOOoaIQ7HeB5OZI7Rjyeget8cRZ+P0p3aTdhkywI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A6F1764;
	Thu,  1 Feb 2024 05:13:10 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A19333F762;
	Thu,  1 Feb 2024 05:12:25 -0800 (PST)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org,
	David Dai <davidai@google.com>,
	Saravana Kannan <saravanak@google.com>
Subject: [RFC PATCH v2 5/7] sched/fair: Massively simplify util_fits_cpu()
Date: Thu,  1 Feb 2024 13:12:01 +0000
Message-Id: <b9a301921ccf7ee7e203ba6b74cb75bcb7c2b052.1706792708.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706792708.git.hongyan.xia2@arm.com>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there's no way to distinguish the difference between 1) a CPU
that is actually maxed out at its highest frequency, or 2) one that is
throttled because of UCLAMP_MAX, since both present util_avg values of
1024. This is problematic because when we try to pick a CPU for a task
to run, we would like to give 2) a chance, or at least prefer 2) to 1).

Current upstream now gives all 0 spare capacity CPUs a chance to
consider queuing more tasks because there's a chance that 0 spare
capacity is due to UCLAMP_MAX. However, this creates further problems
because energy calculations are now bogus when spare capacity is already
0, and tasks tend to pile up on one CPU.

Fix by using util_avg_uclamp for util_fits_cpu(). This way, case 1) will
still keep its utilization at 1024 whereas 2) shows spare capacities if
the sum of util_avg_uclamp values is still under the CPU capacity.

Under sum aggregation, checking whether a task fits a CPU becomes much
simpler. We simply do fits_capacity() and there does not need to be all
kinds of code checking all corner cases for uclamp. This means
util_fits_cpu() returns to true and false instead of tri-state,
simplifying a huge amount of code.

[1]: https://lore.kernel.org/all/20230205224318.2035646-2-qyousef@layalina.io/

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c | 253 ++++----------------------------------------
 1 file changed, 23 insertions(+), 230 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b92739e1c52f..49997f1f58fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4974,135 +4974,19 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
-static inline int util_fits_cpu(unsigned long util,
-				unsigned long uclamp_min,
-				unsigned long uclamp_max,
-				int cpu)
+/* util must be the uclamp'ed value (i.e. from util_avg_uclamp). */
+static inline int util_fits_cpu(unsigned long util, int cpu)
 {
-	unsigned long capacity_orig, capacity_orig_thermal;
 	unsigned long capacity = capacity_of(cpu);
-	bool fits, uclamp_max_fits;
 
-	/*
-	 * Check if the real util fits without any uclamp boost/cap applied.
-	 */
-	fits = fits_capacity(util, capacity);
-
-	if (!uclamp_is_used())
-		return fits;
-
-	/*
-	 * We must use arch_scale_cpu_capacity() for comparing against uclamp_min and
-	 * uclamp_max. We only care about capacity pressure (by using
-	 * capacity_of()) for comparing against the real util.
-	 *
-	 * If a task is boosted to 1024 for example, we don't want a tiny
-	 * pressure to skew the check whether it fits a CPU or not.
-	 *
-	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
-	 * should fit a little cpu even if there's some pressure.
-	 *
-	 * Only exception is for thermal pressure since it has a direct impact
-	 * on available OPP of the system.
-	 *
-	 * We honour it for uclamp_min only as a drop in performance level
-	 * could result in not getting the requested minimum performance level.
-	 *
-	 * For uclamp_max, we can tolerate a drop in performance level as the
-	 * goal is to cap the task. So it's okay if it's getting less.
-	 */
-	capacity_orig = arch_scale_cpu_capacity(cpu);
-	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
-
-	/*
-	 * We want to force a task to fit a cpu as implied by uclamp_max.
-	 * But we do have some corner cases to cater for..
-	 *
-	 *
-	 *                                 C=z
-	 *   |                             ___
-	 *   |                  C=y       |   |
-	 *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _  uclamp_max
-	 *   |      C=x        |   |      |   |
-	 *   |      ___        |   |      |   |
-	 *   |     |   |       |   |      |   |    (util somewhere in this region)
-	 *   |     |   |       |   |      |   |
-	 *   |     |   |       |   |      |   |
-	 *   +----------------------------------------
-	 *         cpu0        cpu1       cpu2
-	 *
-	 *   In the above example if a task is capped to a specific performance
-	 *   point, y, then when:
-	 *
-	 *   * util = 80% of x then it does not fit on cpu0 and should migrate
-	 *     to cpu1
-	 *   * util = 80% of y then it is forced to fit on cpu1 to honour
-	 *     uclamp_max request.
-	 *
-	 *   which is what we're enforcing here. A task always fits if
-	 *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
-	 *   the normal upmigration rules should withhold still.
-	 *
-	 *   Only exception is when we are on max capacity, then we need to be
-	 *   careful not to block overutilized state. This is so because:
-	 *
-	 *     1. There's no concept of capping at max_capacity! We can't go
-	 *        beyond this performance level anyway.
-	 *     2. The system is being saturated when we're operating near
-	 *        max capacity, it doesn't make sense to block overutilized.
-	 */
-	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
-	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
-	fits = fits || uclamp_max_fits;
-
-	/*
-	 *
-	 *                                 C=z
-	 *   |                             ___       (region a, capped, util >= uclamp_max)
-	 *   |                  C=y       |   |
-	 *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _ uclamp_max
-	 *   |      C=x        |   |      |   |
-	 *   |      ___        |   |      |   |      (region b, uclamp_min <= util <= uclamp_max)
-	 *   |_ _ _|_ _|_ _ _ _| _ | _ _ _| _ | _ _ _ _ _ uclamp_min
-	 *   |     |   |       |   |      |   |
-	 *   |     |   |       |   |      |   |      (region c, boosted, util < uclamp_min)
-	 *   +----------------------------------------
-	 *         cpu0        cpu1       cpu2
-	 *
-	 * a) If util > uclamp_max, then we're capped, we don't care about
-	 *    actual fitness value here. We only care if uclamp_max fits
-	 *    capacity without taking margin/pressure into account.
-	 *    See comment above.
-	 *
-	 * b) If uclamp_min <= util <= uclamp_max, then the normal
-	 *    fits_capacity() rules apply. Except we need to ensure that we
-	 *    enforce we remain within uclamp_max, see comment above.
-	 *
-	 * c) If util < uclamp_min, then we are boosted. Same as (b) but we
-	 *    need to take into account the boosted value fits the CPU without
-	 *    taking margin/pressure into account.
-	 *
-	 * Cases (a) and (b) are handled in the 'fits' variable already. We
-	 * just need to consider an extra check for case (c) after ensuring we
-	 * handle the case uclamp_min > uclamp_max.
-	 */
-	uclamp_min = min(uclamp_min, uclamp_max);
-	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
-		return -1;
-
-	return fits;
+	return fits_capacity(util, capacity);
 }
 
 static inline int task_fits_cpu(struct task_struct *p, int cpu)
 {
-	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
-	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
 	unsigned long util = task_util_est(p);
-	/*
-	 * Return true only if the cpu fully fits the task requirements, which
-	 * include the utilization but also the performance hints.
-	 */
-	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
+
+	return util_fits_cpu(util, cpu);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -6678,11 +6562,8 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
-	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
-
 	/* Return true only if the utilization doesn't fit CPU's capacity */
-	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
+	return !util_fits_cpu(cpu_util_cfs(cpu), cpu);
 }
 
 static inline void update_overutilized_status(struct rq *rq)
@@ -7463,8 +7344,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
-	unsigned long task_util, util_min, util_max, best_cap = 0;
-	int fits, best_fits = 0;
+	unsigned long task_util, best_cap = 0;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
@@ -7472,8 +7352,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	task_util = task_util_est(p);
-	util_min = uclamp_eff_value(p, UCLAMP_MIN);
-	util_max = uclamp_eff_value(p, UCLAMP_MAX);
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap = capacity_of(cpu);
@@ -7481,44 +7359,22 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			continue;
 
-		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
-
-		/* This CPU fits with all requirements */
-		if (fits > 0)
+		if (util_fits_cpu(task_util, cpu))
 			return cpu;
-		/*
-		 * Only the min performance hint (i.e. uclamp_min) doesn't fit.
-		 * Look for the CPU with best capacity.
-		 */
-		else if (fits < 0)
-			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
 
-		/*
-		 * First, select CPU which fits better (-1 being better than 0).
-		 * Then, select the one with best capacity at same level.
-		 */
-		if ((fits < best_fits) ||
-		    ((fits == best_fits) && (cpu_cap > best_cap))) {
+		if (cpu_cap > best_cap) {
 			best_cap = cpu_cap;
 			best_cpu = cpu;
-			best_fits = fits;
 		}
 	}
 
 	return best_cpu;
 }
 
-static inline bool asym_fits_cpu(unsigned long util,
-				 unsigned long util_min,
-				 unsigned long util_max,
-				 int cpu)
+static inline bool asym_fits_cpu(unsigned long util, int cpu)
 {
 	if (sched_asym_cpucap_active())
-		/*
-		 * Return true only if the cpu fully fits the task requirements
-		 * which include the utilization and the performance hints.
-		 */
-		return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
+		return util_fits_cpu(util, cpu);
 
 	return true;
 }
@@ -7530,7 +7386,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	bool has_idle_core = false;
 	struct sched_domain *sd;
-	unsigned long task_util, util_min, util_max;
+	unsigned long task_util;
 	int i, recent_used_cpu, prev_aff = -1;
 
 	/*
@@ -7540,8 +7396,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (sched_asym_cpucap_active()) {
 		sync_entity_load_avg(&p->se);
 		task_util = task_util_est(p);
-		util_min = uclamp_eff_value(p, UCLAMP_MIN);
-		util_max = uclamp_eff_value(p, UCLAMP_MAX);
 	}
 
 	/*
@@ -7550,7 +7404,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	lockdep_assert_irqs_disabled();
 
 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, target))
+	    asym_fits_cpu(task_util, target))
 		return target;
 
 	/*
@@ -7558,7 +7412,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
+	    asym_fits_cpu(task_util, prev)) {
 
 		if (!static_branch_unlikely(&sched_cluster_active) ||
 		    cpus_share_resources(prev, target))
@@ -7579,7 +7433,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    in_task() &&
 	    prev == smp_processor_id() &&
 	    this_rq()->nr_running <= 1 &&
-	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
+	    asym_fits_cpu(task_util, prev)) {
 		return prev;
 	}
 
@@ -7591,7 +7445,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
-	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
+	    asym_fits_cpu(task_util, recent_used_cpu)) {
 
 		if (!static_branch_unlikely(&sched_cluster_active) ||
 		    cpus_share_resources(recent_used_cpu, target))
@@ -7966,13 +7820,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
-	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
-	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
-	int prev_fits = -1, best_fits = -1;
-	unsigned long best_thermal_cap = 0;
-	unsigned long prev_thermal_cap = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -8001,14 +7850,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	eenv_task_busy_time(&eenv, p, prev_cpu);
 
 	for (; pd; pd = pd->next) {
-		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
-		unsigned long rq_util_min, rq_util_max;
 		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
-		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -8024,8 +7870,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
-			struct rq *rq = cpu_rq(cpu);
-
 			eenv.pd_cap += cpu_thermal_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
@@ -8036,31 +7880,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 			util = cpu_util(cpu, p, cpu, 0);
 			cpu_cap = capacity_of(cpu);
-
-			/*
-			 * Skip CPUs that cannot satisfy the capacity request.
-			 * IOW, placing the task there would make the CPU
-			 * overutilized. Take uclamp into account to see how
-			 * much capacity we can get out of the CPU; this is
-			 * aligned with sched_cpu_util().
-			 */
-			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
-				/*
-				 * Open code uclamp_rq_util_with() except for
-				 * the clamp() part. Ie: apply max aggregation
-				 * only. util_fits_cpu() logic requires to
-				 * operate on non clamped util but must use the
-				 * max-aggregated uclamp_{min, max}.
-				 */
-				rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
-				rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
-
-				util_min = max(rq_util_min, p_util_min);
-				util_max = max(rq_util_max, p_util_max);
-			}
-
-			fits = util_fits_cpu(util, util_min, util_max, cpu);
-			if (!fits)
+			if (!util_fits_cpu(util, cpu))
 				continue;
 
 			lsub_positive(&cpu_cap, util);
@@ -8068,9 +7888,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (cpu == prev_cpu) {
 				/* Always use prev_cpu as a candidate. */
 				prev_spare_cap = cpu_cap;
-				prev_fits = fits;
-			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
+			} else if (cpu_cap > max_spare_cap) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -8078,7 +7896,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				 */
 				max_spare_cap = cpu_cap;
 				max_spare_cap_cpu = cpu;
-				max_fits = fits;
 			}
 		}
 
@@ -8097,50 +7914,26 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (prev_delta < base_energy)
 				goto unlock;
 			prev_delta -= base_energy;
-			prev_thermal_cap = cpu_thermal_cap;
 			best_delta = min(best_delta, prev_delta);
 		}
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
-			/* Current best energy cpu fits better */
-			if (max_fits < best_fits)
-				continue;
-
-			/*
-			 * Both don't fit performance hint (i.e. uclamp_min)
-			 * but best energy cpu has better capacity.
-			 */
-			if ((max_fits < 0) &&
-			    (cpu_thermal_cap <= best_thermal_cap))
-				continue;
-
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
 						   max_spare_cap_cpu);
 			/* CPU utilization has changed */
 			if (cur_delta < base_energy)
 				goto unlock;
 			cur_delta -= base_energy;
-
-			/*
-			 * Both fit for the task but best energy cpu has lower
-			 * energy impact.
-			 */
-			if ((max_fits > 0) && (best_fits > 0) &&
-			    (cur_delta >= best_delta))
-				continue;
-
-			best_delta = cur_delta;
-			best_energy_cpu = max_spare_cap_cpu;
-			best_fits = max_fits;
-			best_thermal_cap = cpu_thermal_cap;
+			if (cur_delta < best_delta) {
+				best_delta = cur_delta;
+				best_energy_cpu = max_spare_cap_cpu;
+			}
 		}
 	}
 	rcu_read_unlock();
 
-	if ((best_fits > prev_fits) ||
-	    ((best_fits > 0) && (best_delta < prev_delta)) ||
-	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
+	if (best_delta < prev_delta)
 		target = best_energy_cpu;
 
 	return target;
-- 
2.34.1


