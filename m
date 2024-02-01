Return-Path: <linux-kernel+bounces-48206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631BD845896
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E248D1F2773C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781DD5CDFE;
	Thu,  1 Feb 2024 13:12:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D35336B;
	Thu,  1 Feb 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793147; cv=none; b=M0SOYbiWhHh+LdEk68kOg3MhL08qO3tXD9SXjlAGfraSZ8kU79A6QmrfLQBko3QQ73rZeeqL5QN1bjXNHMSd+P1lgEGRwb+tuyeHUJ7oAiyvCikz/Nush/4cCnf7XRZMXcLezn1nV7bsRy0FR58jqGYg81Y6ELtY30OIzMSWmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793147; c=relaxed/simple;
	bh=g9to9mHQTMEKme4LM6eXw5e3J3La88oBjiXs5Njofgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOg2YSLvlsgDvR02CqZAgQn6vEVa3OWscYyRR9xs5cJyf2hhdTfUf0sO/ZsvShpSNoy9E/1EFgieag6A+FDMRbVZoiopVskdsY4v4Za58IMIISyQY+g2DEgHVS55BxR/UlFyIPsiefZFzXChVdJlljOK8Yi9Z2CqdZLQz6S1pBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7641A1763;
	Thu,  1 Feb 2024 05:13:07 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A3A43F762;
	Thu,  1 Feb 2024 05:12:22 -0800 (PST)
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
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org,
	David Dai <davidai@google.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 4/7] sched/fair: Use CFS util_avg_uclamp for utilization and frequency
Date: Thu,  1 Feb 2024 13:12:00 +0000
Message-Id: <4f755ae12895bbc74a74bac56bf2ef0f30413a32.1706792708.git.hongyan.xia2@arm.com>
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

Switch to the new util_avg_uclamp for task and runqueue utilization.
Since task_util_est() calls task_util() which now uses util_avg_uclamp,
this means util_est is now also a clamped value.

Now that we have the sum aggregated CFS util value, we do not need to
consult uclamp buckets to know how the frequency should be clamped. We
simply look at the aggregated top level root_cfs_util_uclamp to know
what frequency to choose.

TODO: Sum aggregation for RT tasks. I have already implemented RT sum
aggregation, which is only 49 lines of code, but I don't want RT to
distract this series which is mainly CFS-focused. RT will be sent in a
separate mini series.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/core.c              | 17 ++++----------
 kernel/sched/cpufreq_schedutil.c | 10 ++------
 kernel/sched/fair.c              | 39 ++++++++++++++++----------------
 kernel/sched/sched.h             | 21 +++++++++++++----
 4 files changed, 42 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f..0bedc05c883f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7465,6 +7465,9 @@ int sched_core_idle_cpu(int cpu)
  * The DL bandwidth number otoh is not a measured metric but a value computed
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
+ *
+ * The util_cfs parameter has already taken uclamp into account (unless uclamp
+ * support is not compiled in).
  */
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long *min,
@@ -7490,13 +7493,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	}
 
 	if (min) {
-		/*
-		 * The minimum utilization returns the highest level between:
-		 * - the computed DL bandwidth needed with the IRQ pressure which
-		 *   steals time to the deadline task.
-		 * - The minimum performance requirement for CFS and/or RT.
-		 */
-		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
+		*min = irq + cpu_bw_dl(rq);
 
 		/*
 		 * When an RT task is runnable and uclamp is not used, we must
@@ -7515,12 +7512,8 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	util = util_cfs + cpu_util_rt(rq);
 	util += cpu_util_dl(rq);
 
-	/*
-	 * The maximum hint is a soft bandwidth requirement, which can be lower
-	 * than the actual utilization because of uclamp_max requirements.
-	 */
 	if (max)
-		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
+		*max = scale;
 
 	if (util >= scale)
 		return scale;
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 95c3c097083e..48a4e4a685d0 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -381,11 +381,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
-	 *
-	 * Except when the rq is capped by uclamp_max.
 	 */
-	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
+	if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
 	    !sg_policy->need_freq_update) {
 		next_f = sg_policy->next_freq;
 
@@ -435,11 +432,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
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
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 36357cfaf48d..b92739e1c52f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4821,10 +4821,17 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 
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
 
 static inline unsigned long task_runnable(struct task_struct *p)
 {
@@ -4932,8 +4939,13 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * To avoid underestimate of task utilization, skip updates of EWMA if
 	 * we cannot grant that thread got all CPU time it wanted.
 	 */
-	if ((dequeued + UTIL_EST_MARGIN) < task_runnable(p))
+	if ((READ_ONCE(p->se.avg.util_avg) + UTIL_EST_MARGIN) <
+			task_runnable(p)) {
+		ewma = clamp(ewma,
+			     uclamp_eff_value(p, UCLAMP_MIN),
+			     uclamp_eff_value(p, UCLAMP_MAX));
 		goto done;
+	}
 
 
 	/*
@@ -7685,11 +7697,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
@@ -7867,7 +7881,6 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 	int cpu;
 
 	for_each_cpu(cpu, pd_cpus) {
-		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
 		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
 		unsigned long eff_util, min, max;
 
@@ -7880,20 +7893,6 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 */
 		eff_util = effective_cpu_util(cpu, util, &min, &max);
 
-		/* Task's uclamp can modify min and max value */
-		if (tsk && uclamp_is_used()) {
-			min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
-
-			/*
-			 * If there is no active max uclamp constraint,
-			 * directly use task's one, otherwise keep max.
-			 */
-			if (uclamp_rq_is_idle(cpu_rq(cpu)))
-				max = uclamp_eff_value(p, UCLAMP_MAX);
-			else
-				max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
-		}
-
 		eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
 		max_util = max(max_util, eff_util);
 	}
@@ -7996,7 +7995,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!task_util_est(p) && p_util_min == 0)
+	if (!task_util_est(p))
 		goto unlock;
 
 	eenv_task_busy_time(&eenv, p, prev_cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ce80b87b549b..3ee28822f48f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3062,16 +3062,17 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 /* Is the rq being capped/throttled by uclamp_max? */
 static inline bool uclamp_rq_is_capped(struct rq *rq)
 {
-	unsigned long rq_util;
-	unsigned long max_util;
+	unsigned long rq_uclamp_util, rq_real_util;
 
 	if (!static_branch_likely(&sched_uclamp_used))
 		return false;
 
-	rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
-	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+	rq_uclamp_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
+	rq_real_util = READ_ONCE(rq->cfs.avg.util_avg) +
+		       READ_ONCE(rq->avg_rt.util_avg);
 
-	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
+	return rq_uclamp_util < SCHED_CAPACITY_SCALE &&
+	       rq_real_util > rq_uclamp_util;
 }
 
 /*
@@ -3087,6 +3088,11 @@ static inline bool uclamp_is_used(void)
 	return static_branch_likely(&sched_uclamp_used);
 }
 
+static inline unsigned long root_cfs_util(struct rq *rq)
+{
+	return READ_ONCE(rq->root_cfs_util_uclamp);
+}
+
 static inline void util_uclamp_enqueue(struct sched_avg *avg,
 				       struct task_struct *p)
 {
@@ -3160,6 +3166,11 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return false;
 }
 
+static inline unsigned long root_cfs_util(struct rq *rq)
+{
+	return READ_ONCE(rq->cfs.avg.util_avg);
+}
+
 static inline void remove_root_cfs_util_uclamp(struct task_struct *p)
 {
 }
-- 
2.34.1


