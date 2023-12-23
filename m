Return-Path: <linux-kernel+bounces-10488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE8281D4F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B152831CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2112E62;
	Sat, 23 Dec 2023 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NNXovK6+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5I3LnDev"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B0FC0B;
	Sat, 23 Dec 2023 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Dec 2023 16:09:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703347790;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL0XZXYrTACusnUU+KCmnaDAl7Tw0w60ptsEIJMAJ2I=;
	b=NNXovK6+ZOGpazKrIGo8SkBzIoXQeAnUlBy1expMuo6XIouLQcLyaLBIonvUMkW/1haqbO
	azFA0d24Q+aKuH8e3u6mwzCnGGnZeuKieoi8Q86jqpTdwDE2UuGq7R6i80D2muXKJufy9n
	TIhdboEHvSmFdwWWw/WbRzFL1gj6Rf4xR6iCZ5jbJ8cXJ0rXMLBpbht+A7H0+sQifr/3uN
	Ic3BPFQlJFWLgPApYIWFkIJqLgDkCg9nTYywyCfSOHC5g5dZjkJELOREMdNI6p4zabBZRA
	mzWg8FeeKaTXyjL3T/aPA6yAJcJvSaobwl5liC8KHVi9Dg/vY0O/Nusiu05eHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703347790;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL0XZXYrTACusnUU+KCmnaDAl7Tw0w60ptsEIJMAJ2I=;
	b=5I3LnDevdfoiBTaYLpaV78YnPlZPMYz3Q4d+jd+KbKx9i+NRJZVZKwMbkbMVm16lO2m0b0
	KCQlKnwWDIZ5jhCA==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Simplify util_est
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Hongyan Xia <hongyan.xia2@arm.com>, Alex Shi <alexs@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231201161652.1241695-3-vincent.guittot@linaro.org>
References: <20231201161652.1241695-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170334778936.398.5563802544957527903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     11137d384996bb05cf33c8163db271e1bac3f4bf
Gitweb:        https://git.kernel.org/tip/11137d384996bb05cf33c8163db271e1bac3f4bf
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 01 Dec 2023 17:16:52 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Dec 2023 15:59:58 +01:00

sched/fair: Simplify util_est

With UTIL_EST_FASTUP now being permanent, we can take advantage of the
fact that the ewma jumps directly to a higher utilization at dequeue to
simplify util_est and remove the enqueued field.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Alex Shi <alexs@kernel.org>
Link: https://lore.kernel.org/r/20231201161652.1241695-3-vincent.guittot@linaro.org
---
 include/linux/sched.h | 49 ++++++-------------------
 kernel/sched/debug.c  |  7 +---
 kernel/sched/fair.c   | 82 +++++++++++++++---------------------------
 kernel/sched/pelt.h   |  4 +-
 4 files changed, 48 insertions(+), 94 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d25816..03bfe9a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -415,42 +415,6 @@ struct load_weight {
 	u32				inv_weight;
 };
 
-/**
- * struct util_est - Estimation utilization of FAIR tasks
- * @enqueued: instantaneous estimated utilization of a task/cpu
- * @ewma:     the Exponential Weighted Moving Average (EWMA)
- *            utilization of a task
- *
- * Support data structure to track an Exponential Weighted Moving Average
- * (EWMA) of a FAIR task's utilization. New samples are added to the moving
- * average each time a task completes an activation. Sample's weight is chosen
- * so that the EWMA will be relatively insensitive to transient changes to the
- * task's workload.
- *
- * The enqueued attribute has a slightly different meaning for tasks and cpus:
- * - task:   the task's util_avg at last task dequeue time
- * - cfs_rq: the sum of util_est.enqueued for each RUNNABLE task on that CPU
- * Thus, the util_est.enqueued of a task represents the contribution on the
- * estimated utilization of the CPU where that task is currently enqueued.
- *
- * Only for tasks we track a moving average of the past instantaneous
- * estimated utilization. This allows to absorb sporadic drops in utilization
- * of an otherwise almost periodic task.
- *
- * The UTIL_AVG_UNCHANGED flag is used to synchronize util_est with util_avg
- * updates. When a task is dequeued, its util_est should not be updated if its
- * util_avg has not been updated in the meantime.
- * This information is mapped into the MSB bit of util_est.enqueued at dequeue
- * time. Since max value of util_est.enqueued for a task is 1024 (PELT util_avg
- * for a task) it is safe to use MSB.
- */
-struct util_est {
-	unsigned int			enqueued;
-	unsigned int			ewma;
-#define UTIL_EST_WEIGHT_SHIFT		2
-#define UTIL_AVG_UNCHANGED		0x80000000
-} __attribute__((__aligned__(sizeof(u64))));
-
 /*
  * The load/runnable/util_avg accumulates an infinite geometric series
  * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
@@ -505,9 +469,20 @@ struct sched_avg {
 	unsigned long			load_avg;
 	unsigned long			runnable_avg;
 	unsigned long			util_avg;
-	struct util_est			util_est;
+	unsigned int			util_est;
 } ____cacheline_aligned;
 
+/*
+ * The UTIL_AVG_UNCHANGED flag is used to synchronize util_est with util_avg
+ * updates. When a task is dequeued, its util_est should not be updated if its
+ * util_avg has not been updated in the meantime.
+ * This information is mapped into the MSB bit of util_est at dequeue time.
+ * Since max value of util_est for a task is 1024 (PELT util_avg for a task)
+ * it is safe to use MSB.
+ */
+#define UTIL_EST_WEIGHT_SHIFT		2
+#define UTIL_AVG_UNCHANGED		0x80000000
+
 struct sched_statistics {
 #ifdef CONFIG_SCHEDSTATS
 	u64				wait_start;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 168eecc..8d5d98a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -684,8 +684,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.runnable_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
-	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
-			cfs_rq->avg.util_est.enqueued);
+	SEQ_printf(m, "  .%-30s: %u\n", "util_est",
+			cfs_rq->avg.util_est);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.load_avg",
 			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
@@ -1075,8 +1075,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.runnable_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
-	P(se.avg.util_est.ewma);
-	PM(se.avg.util_est.enqueued, ~UTIL_AVG_UNCHANGED);
+	PM(se.avg.util_est, ~UTIL_AVG_UNCHANGED);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
 	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e94d65d..823dd76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4781,9 +4781,7 @@ static inline unsigned long task_runnable(struct task_struct *p)
 
 static inline unsigned long _task_util_est(struct task_struct *p)
 {
-	struct util_est ue = READ_ONCE(p->se.avg.util_est);
-
-	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
+	return READ_ONCE(p->se.avg.util_est) & ~UTIL_AVG_UNCHANGED;
 }
 
 static inline unsigned long task_util_est(struct task_struct *p)
@@ -4800,9 +4798,9 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 		return;
 
 	/* Update root cfs_rq's estimated utilization */
-	enqueued  = cfs_rq->avg.util_est.enqueued;
+	enqueued  = cfs_rq->avg.util_est;
 	enqueued += _task_util_est(p);
-	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
+	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
@@ -4816,34 +4814,20 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
 		return;
 
 	/* Update root cfs_rq's estimated utilization */
-	enqueued  = cfs_rq->avg.util_est.enqueued;
+	enqueued  = cfs_rq->avg.util_est;
 	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
-	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
+	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
 
 #define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
 
-/*
- * Check if a (signed) value is within a specified (unsigned) margin,
- * based on the observation that:
- *
- *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
- *
- * NOTE: this only works when value + margin < INT_MAX.
- */
-static inline bool within_margin(int value, int margin)
-{
-	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
-}
-
 static inline void util_est_update(struct cfs_rq *cfs_rq,
 				   struct task_struct *p,
 				   bool task_sleep)
 {
-	long last_ewma_diff, last_enqueued_diff;
-	struct util_est ue;
+	unsigned int ewma, dequeued, last_ewma_diff;
 
 	if (!sched_feat(UTIL_EST))
 		return;
@@ -4855,23 +4839,25 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (!task_sleep)
 		return;
 
+	/* Get current estimate of utilization */
+	ewma = READ_ONCE(p->se.avg.util_est);
+
 	/*
 	 * If the PELT values haven't changed since enqueue time,
 	 * skip the util_est update.
 	 */
-	ue = p->se.avg.util_est;
-	if (ue.enqueued & UTIL_AVG_UNCHANGED)
+	if (ewma & UTIL_AVG_UNCHANGED)
 		return;
 
-	last_enqueued_diff = ue.enqueued;
+	/* Get utilization at dequeue */
+	dequeued = task_util(p);
 
 	/*
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
 	 */
-	ue.enqueued = task_util(p);
-	if (ue.ewma < ue.enqueued) {
-		ue.ewma = ue.enqueued;
+	if (ewma <= dequeued) {
+		ewma = dequeued;
 		goto done;
 	}
 
@@ -4879,27 +4865,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * Skip update of task's estimated utilization when its members are
 	 * already ~1% close to its last activation value.
 	 */
-	last_ewma_diff = ue.enqueued - ue.ewma;
-	last_enqueued_diff -= ue.enqueued;
-	if (within_margin(last_ewma_diff, UTIL_EST_MARGIN)) {
-		if (!within_margin(last_enqueued_diff, UTIL_EST_MARGIN))
-			goto done;
-
-		return;
-	}
+	last_ewma_diff = ewma - dequeued;
+	if (last_ewma_diff < UTIL_EST_MARGIN)
+		goto done;
 
 	/*
 	 * To avoid overestimation of actual task utilization, skip updates if
 	 * we cannot grant there is idle time in this CPU.
 	 */
-	if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
+	if (dequeued > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
 		return;
 
 	/*
 	 * To avoid underestimate of task utilization, skip updates of EWMA if
 	 * we cannot grant that thread got all CPU time it wanted.
 	 */
-	if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
+	if ((dequeued + UTIL_EST_MARGIN) < task_runnable(p))
 		goto done;
 
 
@@ -4907,25 +4888,24 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * Update Task's estimated utilization
 	 *
 	 * When *p completes an activation we can consolidate another sample
-	 * of the task size. This is done by storing the current PELT value
-	 * as ue.enqueued and by using this value to update the Exponential
-	 * Weighted Moving Average (EWMA):
+	 * of the task size. This is done by using this value to update the
+	 * Exponential Weighted Moving Average (EWMA):
 	 *
 	 *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
 	 *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
 	 *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
-	 *          = w * (      last_ewma_diff            ) +     ewma(t-1)
-	 *          = w * (last_ewma_diff  +  ewma(t-1) / w)
+	 *          = w * (      -last_ewma_diff           ) +     ewma(t-1)
+	 *          = w * (-last_ewma_diff +  ewma(t-1) / w)
 	 *
 	 * Where 'w' is the weight of new samples, which is configured to be
 	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
 	 */
-	ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
-	ue.ewma  += last_ewma_diff;
-	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
+	ewma <<= UTIL_EST_WEIGHT_SHIFT;
+	ewma  -= last_ewma_diff;
+	ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
-	ue.enqueued |= UTIL_AVG_UNCHANGED;
-	WRITE_ONCE(p->se.avg.util_est, ue);
+	ewma |= UTIL_AVG_UNCHANGED;
+	WRITE_ONCE(p->se.avg.util_est, ewma);
 
 	trace_sched_util_est_se_tp(&p->se);
 }
@@ -7653,16 +7633,16 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 	if (sched_feat(UTIL_EST)) {
 		unsigned long util_est;
 
-		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+		util_est = READ_ONCE(cfs_rq->avg.util_est);
 
 		/*
 		 * During wake-up @p isn't enqueued yet and doesn't contribute
-		 * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
+		 * to any cpu_rq(cpu)->cfs.avg.util_est.
 		 * If @dst_cpu == @cpu add it to "simulate" cpu_util after @p
 		 * has been enqueued.
 		 *
 		 * During exec (@dst_cpu = -1) @p is enqueued and does
-		 * contribute to cpu_rq(cpu)->cfs.util_est.enqueued.
+		 * contribute to cpu_rq(cpu)->cfs.util_est.
 		 * Remove it to "simulate" cpu_util without @p's contribution.
 		 *
 		 * Despite the task_on_rq_queued(@p) check there is still a
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 3a0e0dc..9e10834 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -52,13 +52,13 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 		return;
 
 	/* Avoid store if the flag has been already reset */
-	enqueued = avg->util_est.enqueued;
+	enqueued = avg->util_est;
 	if (!(enqueued & UTIL_AVG_UNCHANGED))
 		return;
 
 	/* Reset flag to report util_avg has been updated */
 	enqueued &= ~UTIL_AVG_UNCHANGED;
-	WRITE_ONCE(avg->util_est.enqueued, enqueued);
+	WRITE_ONCE(avg->util_est, enqueued);
 }
 
 static inline u64 rq_clock_pelt(struct rq *rq)

