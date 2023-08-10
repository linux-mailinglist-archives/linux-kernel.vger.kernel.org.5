Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A6777118
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjHJHLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjHJHLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:11:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1E61718;
        Thu, 10 Aug 2023 00:11:00 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:10:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691651459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4z3qjTKksTG+hc6zmxe0k4gXAH/v+hP6uADhoSiHyGQ=;
        b=GWT/dju8VOPbLuI4DTsDCrrChiQQCfD4hR5nc6dRhdyOm1id78vnVgXV4iNPGTMlDoX+S5
        dLThzv1bf4ymKrjOODXnr4oaPCc56a532zYh1JiDunN0w/rx2i9KUV9OenjriZWaM54kL8
        z9T8V6SPfB1qwfHa4rLNNcug3pyfrJR1m7J8gLUj8p1nIVHJYhnLQrTKzRcRqXeKqm8DVI
        VxSzr0gu6RGDshkrdp2f5a5ERU1dU4KgUhF1Vf6JVQUabmsWx0pBvIe1DZr8ALoK8cNved
        Jv5+u/0rWvQNWFy/L0x+7KNDbItcI7I5yxFFvuo2LtWpT8r50jt/tOfzgRiSrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691651459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4z3qjTKksTG+hc6zmxe0k4gXAH/v+hP6uADhoSiHyGQ=;
        b=yDgXZYue2s+mLuDAtnHsNRR6MXRYe7ss414uj/LvSR3OIpIaM3Rh27M6CzOF8B+3M51YPJ
        kQttk6bIE+UfTSBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add cfs_rq::avg_vruntime
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531124603.654144274@infradead.org>
References: <20230531124603.654144274@infradead.org>
MIME-Version: 1.0
Message-ID: <169165145896.27769.15700825811302012794.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     af4cf40470c22efa3987200fd19478199e08e103
Gitweb:        https://git.kernel.org/tip/af4cf40470c22efa3987200fd19478199e08e103
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 13:58:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Jul 2023 09:43:58 +02:00

sched/fair: Add cfs_rq::avg_vruntime

In order to move to an eligibility based scheduling policy, we need
to have a better approximation of the ideal scheduler.

Specifically, for a virtual time weighted fair queueing based
scheduler the ideal scheduler will be the weighted average of the
individual virtual runtimes (math in the comment).

As such, compute the weighted average to approximate the ideal
scheduler -- note that the approximation is in the individual task
behaviour, which isn't strictly conformant.

Specifically consider adding a task with a vruntime left of center, in
this case the average will move backwards in time -- something the
ideal scheduler would of course never do.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230531124603.654144274@infradead.org
---
 kernel/sched/debug.c |  32 ++++------
 kernel/sched/fair.c  | 137 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   5 ++-
 3 files changed, 154 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index aeeba46..e48d2b2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -627,10 +627,9 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
-	s64 MIN_vruntime = -1, min_vruntime, max_vruntime = -1,
-		spread, rq0_min_vruntime, spread0;
+	s64 left_vruntime = -1, min_vruntime, right_vruntime = -1, spread;
+	struct sched_entity *last, *first;
 	struct rq *rq = cpu_rq(cpu);
-	struct sched_entity *last;
 	unsigned long flags;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -644,26 +643,25 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			SPLIT_NS(cfs_rq->exec_clock));
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	if (rb_first_cached(&cfs_rq->tasks_timeline))
-		MIN_vruntime = (__pick_first_entity(cfs_rq))->vruntime;
+	first = __pick_first_entity(cfs_rq);
+	if (first)
+		left_vruntime = first->vruntime;
 	last = __pick_last_entity(cfs_rq);
 	if (last)
-		max_vruntime = last->vruntime;
+		right_vruntime = last->vruntime;
 	min_vruntime = cfs_rq->min_vruntime;
-	rq0_min_vruntime = cpu_rq(0)->cfs.min_vruntime;
 	raw_spin_rq_unlock_irqrestore(rq, flags);
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "MIN_vruntime",
-			SPLIT_NS(MIN_vruntime));
+
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_vruntime",
+			SPLIT_NS(left_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
 			SPLIT_NS(min_vruntime));
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "max_vruntime",
-			SPLIT_NS(max_vruntime));
-	spread = max_vruntime - MIN_vruntime;
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread",
-			SPLIT_NS(spread));
-	spread0 = min_vruntime - rq0_min_vruntime;
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread0",
-			SPLIT_NS(spread0));
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "avg_vruntime",
+			SPLIT_NS(avg_vruntime(cfs_rq)));
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "right_vruntime",
+			SPLIT_NS(right_vruntime));
+	spread = right_vruntime - left_vruntime;
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
 			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d3df5b1..bb54606 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -601,9 +601,134 @@ static inline bool entity_before(const struct sched_entity *a,
 	return (s64)(a->vruntime - b->vruntime) < 0;
 }
 
+static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	return (s64)(se->vruntime - cfs_rq->min_vruntime);
+}
+
 #define __node_2_se(node) \
 	rb_entry((node), struct sched_entity, run_node)
 
+/*
+ * Compute virtual time from the per-task service numbers:
+ *
+ * Fair schedulers conserve lag:
+ *
+ *   \Sum lag_i = 0
+ *
+ * Where lag_i is given by:
+ *
+ *   lag_i = S - s_i = w_i * (V - v_i)
+ *
+ * Where S is the ideal service time and V is it's virtual time counterpart.
+ * Therefore:
+ *
+ *   \Sum lag_i = 0
+ *   \Sum w_i * (V - v_i) = 0
+ *   \Sum w_i * V - w_i * v_i = 0
+ *
+ * From which we can solve an expression for V in v_i (which we have in
+ * se->vruntime):
+ *
+ *       \Sum v_i * w_i   \Sum v_i * w_i
+ *   V = -------------- = --------------
+ *          \Sum w_i            W
+ *
+ * Specifically, this is the weighted average of all entity virtual runtimes.
+ *
+ * [[ NOTE: this is only equal to the ideal scheduler under the condition
+ *          that join/leave operations happen at lag_i = 0, otherwise the
+ *          virtual time has non-continguous motion equivalent to:
+ *
+ *	      V +-= lag_i / W
+ *
+ *	    Also see the comment in place_entity() that deals with this. ]]
+ *
+ * However, since v_i is u64, and the multiplcation could easily overflow
+ * transform it into a relative form that uses smaller quantities:
+ *
+ * Substitute: v_i == (v_i - v0) + v0
+ *
+ *     \Sum ((v_i - v0) + v0) * w_i   \Sum (v_i - v0) * w_i
+ * V = ---------------------------- = --------------------- + v0
+ *                  W                            W
+ *
+ * Which we track using:
+ *
+ *                    v0 := cfs_rq->min_vruntime
+ * \Sum (v_i - v0) * w_i := cfs_rq->avg_vruntime
+ *              \Sum w_i := cfs_rq->avg_load
+ *
+ * Since min_vruntime is a monotonic increasing variable that closely tracks
+ * the per-task service, these deltas: (v_i - v), will be in the order of the
+ * maximal (virtual) lag induced in the system due to quantisation.
+ *
+ * Also, we use scale_load_down() to reduce the size.
+ *
+ * As measured, the max (key * weight) value was ~44 bits for a kernel build.
+ */
+static void
+avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long weight = scale_load_down(se->load.weight);
+	s64 key = entity_key(cfs_rq, se);
+
+	cfs_rq->avg_vruntime += key * weight;
+	cfs_rq->avg_load += weight;
+}
+
+static void
+avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long weight = scale_load_down(se->load.weight);
+	s64 key = entity_key(cfs_rq, se);
+
+	cfs_rq->avg_vruntime -= key * weight;
+	cfs_rq->avg_load -= weight;
+}
+
+static inline
+void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
+{
+	/*
+	 * v' = v + d ==> avg_vruntime' = avg_runtime - d*avg_load
+	 */
+	cfs_rq->avg_vruntime -= cfs_rq->avg_load * delta;
+}
+
+u64 avg_vruntime(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 avg = cfs_rq->avg_vruntime;
+	long load = cfs_rq->avg_load;
+
+	if (curr && curr->on_rq) {
+		unsigned long weight = scale_load_down(curr->load.weight);
+
+		avg += entity_key(cfs_rq, curr) * weight;
+		load += weight;
+	}
+
+	if (load)
+		avg = div_s64(avg, load);
+
+	return cfs_rq->min_vruntime + avg;
+}
+
+static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
+{
+	u64 min_vruntime = cfs_rq->min_vruntime;
+	/*
+	 * open coded max_vruntime() to allow updating avg_vruntime
+	 */
+	s64 delta = (s64)(vruntime - min_vruntime);
+	if (delta > 0) {
+		avg_vruntime_update(cfs_rq, delta);
+		min_vruntime = vruntime;
+	}
+	return min_vruntime;
+}
+
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
@@ -629,7 +754,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 
 	/* ensure we never gain time by being placed backwards. */
 	u64_u32_store(cfs_rq->min_vruntime,
-		      max_vruntime(cfs_rq->min_vruntime, vruntime));
+		      __update_min_vruntime(cfs_rq, vruntime));
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -642,12 +767,14 @@ static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	avg_vruntime_add(cfs_rq, se);
 	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	rb_erase_cached(&se->run_node, &cfs_rq->tasks_timeline);
+	avg_vruntime_sub(cfs_rq, se);
 }
 
 struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
@@ -3379,6 +3506,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
+		else
+			avg_vruntime_sub(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
@@ -3394,9 +3523,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 #endif
 
 	enqueue_load_avg(cfs_rq, se);
-	if (se->on_rq)
+	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
-
+		if (cfs_rq->curr != se)
+			avg_vruntime_add(cfs_rq, se);
+	}
 }
 
 void reweight_task(struct task_struct *p, int prio)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9baeb1a..52a0a4b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -548,6 +548,9 @@ struct cfs_rq {
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
+	s64			avg_vruntime;
+	u64			avg_load;
+
 	u64			exec_clock;
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
@@ -3483,4 +3486,6 @@ static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
 static inline void init_sched_mm_cid(struct task_struct *t) { }
 #endif
 
+extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
+
 #endif /* _KERNEL_SCHED_SCHED_H */
