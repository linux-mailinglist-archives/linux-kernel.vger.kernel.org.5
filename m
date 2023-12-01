Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE8380113A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378338AbjLAQRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378448AbjLAQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:16:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2C6170F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:17:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so20813705e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701447422; x=1702052222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E74LvjTxUZWLtJvvaUHypL9+wv4NgOIsNkiFl+I7+yg=;
        b=MlcwSg2qs1ntSYVGQd/MCxfNhPe3vgD+XBhLpmL/1OrvBtdqd8wea7Xh7kY+91rFbk
         wfA0udfQ0SAGtnTxH6ISma0+fgeGFZFl11vubdfkJbr3XWMLjyuNbX/PVI0ILaoK4qlZ
         7L3CQ2exQCXuF+A47yMr1Y5Mqo+5WF493t13jPQprskHBceXGHM68FHbJdigDSpea7hW
         bY1Dy0s3eDLdElZ7N7Ybz4YvQNZDqP2x0+o1nDyEMeE7Kz4wR0DNa8c3rQzT6pFvfJRA
         P7o/NpFZcts5mOj8VBX+9Ku+gd72xlnn1OJZ6lNObt9l5nmfKszoRE+JDY/xckI/w0qN
         2xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447422; x=1702052222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E74LvjTxUZWLtJvvaUHypL9+wv4NgOIsNkiFl+I7+yg=;
        b=s5cF4QXSGOm9JWJbLGWnLQoc+7DIBGSsjPlbs6wy4RDTNL2HQIFv500YcF+SnQuR6m
         fIOWxkjcnvlxOq+dGyd6SqOGTzDFfI10ohyijy951SMal0evoLayn9PDYDCw8FUVbXOZ
         EVe2lbkkYAAoL+ZWMNutpUSOq/c3g9Y1eUh5/vaDJKHdMWQmNcsNdkjepLglgnrngUjG
         TjDZzWNCs+jtxQOjPyciQrTEE9K4arIJ8mcleZ+TcOOeTIt03PaonetAxhkM47LFFuAW
         jJni2GMtyCtM7aCftwl2wPrsgGv+42ccpwrT9dprVCIWUGKwi7ReIrIeNYj2uR3ShUhV
         b1hg==
X-Gm-Message-State: AOJu0YyRiVsXsFZwHE1A4z6/Le20oDMlrC0QDOjtjgQWVjamZr5alPb2
        /ge60h8HCqgsVP1xKwdyOONmcA==
X-Google-Smtp-Source: AGHT+IGw9gQNjf3z/miV80OD0PEF8SvC09RO8HQQ/oLaFcUtbEKwH5EunZeAHMp3SHeSv1bdXOq24A==
X-Received: by 2002:a05:600c:5247:b0:40b:5e22:962 with SMTP id fc7-20020a05600c524700b0040b5e220962mr727299wmb.81.1701447422401;
        Fri, 01 Dec 2023 08:17:02 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:6db5:f04:fbd5:88e1])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003feae747ff2sm9591398wms.35.2023.12.01.08.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:17:01 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     lukasz.luba@arm.com, hongyan.xia2@arm.com, yizhou.tang@shopee.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/2] sched/fair: Simplify util_est
Date:   Fri,  1 Dec 2023 17:16:52 +0100
Message-Id: <20231201161652.1241695-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201161652.1241695-1-vincent.guittot@linaro.org>
References: <20231201161652.1241695-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With UTIL_EST_FASTUP now being permanent, we can take advantage of the
fact that the ewma jumps directly to a higher utilization at dequeue to
simplify util_est and remove the enqueued field.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 include/linux/sched.h | 49 +++++++-------------------
 kernel/sched/debug.c  |  7 ++--
 kernel/sched/fair.c   | 82 ++++++++++++++++---------------------------
 kernel/sched/pelt.h   |  4 +--
 4 files changed, 48 insertions(+), 94 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d258162deb0..03bfe9ab2951 100644
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
index 168eecc209b4..8d5d98a5834d 100644
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
index e94d65da8d66..823dd76d0546 100644
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
index 3a0e0dc28721..9e1083465fbc 100644
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
-- 
2.34.1

