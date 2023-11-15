Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02B37EBC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjKODhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjKODhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:37:33 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFC0F4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:28 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c398717726so5504716b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700019448; x=1700624248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu05TqF1mMA8yrCM083vJ/OVx2NY3Qgo312HI68ZsBQ=;
        b=kufJS7OymXQYVx37zoa5Gbi8CDuXszwi0MgdE12I8j0SMl0pTIskCYXygWbIX6O8UQ
         1PMvE3dkOz9LxwLQw8Cc05j87XuYO2cbjGOSSnn7CvdczN1HB+nDueHpWGHT+VpNSsy7
         eRqtfi7l3uSDOdAI9v9Qv/QqvtY6z/IBYBFybMJMEGpe7/8BJo+q5qWMC6qlU2xKONjU
         EV8G9x4rGNl7zt0p8RlAucwdgGfzZlaNIx/9C4fvNY20TDKkBVoaikv7lX+uVKjIkL35
         2fMd2qP5UJI+exwfdVnF9bf/KUnYwxyHBWQFexna1LE/0dITJPcSgH9n0KEaYjx+V8bB
         qDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019448; x=1700624248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu05TqF1mMA8yrCM083vJ/OVx2NY3Qgo312HI68ZsBQ=;
        b=EqbvOh4BApJp8MvGghNyFuvrPtbKiz/vxDkxqf50g4kpNqWug6ipN9BqXNvLlh3HiB
         abdCqDaqVZIiT87+7i/O1XsDZKP8o22niqc0sDTgpjO7Y/o+emTaa/M+6cZxCJj6nhzG
         TQLtw8ky6ZHtJQTbwpFa/NWov5s1EZXZj36Rmvmlr1Mh/xIOujtL7ZFkKb2Xu1X/AYNk
         mM91d6xryrh+DgGIyFsMW11v2GEnzB0pHhPVDM+T9zSUYYyQHpkzbNGDnhN+D1e8XaEs
         tUT487WfBURgYdx5n0D0eXwV5zEDbQDxpQCu1e4eeC2G6vV/DKYE872FMkbmgt+oWg1M
         MjRw==
X-Gm-Message-State: AOJu0Yyd2AJKRS1zYG9DeNNjdz0KtBRXtywF1U6NLzRPBmN6WNB1UXHu
        wBq9HFvMMncnMobM3hO197hXYA==
X-Google-Smtp-Source: AGHT+IHtVsbY3/pN1PvZSJXqLJGyXYtYtDaPEojW8ctjRwSC4toEowW62J7SOmtkG8Z+554vGzmDKA==
X-Received: by 2002:a05:6a20:12cb:b0:17b:9b0c:f215 with SMTP id v11-20020a056a2012cb00b0017b9b0cf215mr10994158pzg.37.1700019448133;
        Tue, 14 Nov 2023 19:37:28 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001b9da42cd7dsm6419529plk.279.2023.11.14.19.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:37:27 -0800 (PST)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2 2/4] sched/eevdf: Sort the rbtree by virtual deadline
Date:   Wed, 15 Nov 2023 11:36:45 +0800
Message-Id: <20231115033647.80785-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231115033647.80785-1-wuyun.abel@bytedance.com>
References: <20231115033647.80785-1-wuyun.abel@bytedance.com>
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

Sort the task timeline by virtual deadline and keep the min_vruntime
in the augmented tree, so we can avoid doubling the worst case cost
and make full use of the cached leftmost node to enable O(1) fastpath
picking in next patch.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched.h |   2 +-
 kernel/sched/debug.c  |  11 ++-
 kernel/sched/fair.c   | 168 +++++++++++++++++-------------------------
 kernel/sched/sched.h  |   1 +
 4 files changed, 77 insertions(+), 105 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..cd56d4018527 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -553,7 +553,7 @@ struct sched_entity {
 	struct load_weight		load;
 	struct rb_node			run_node;
 	u64				deadline;
-	u64				min_deadline;
+	u64				min_vruntime;
 
 	struct list_head		group_node;
 	unsigned int			on_rq;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4580a450700e..168eecc209b4 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -628,8 +628,8 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
-	s64 left_vruntime = -1, min_vruntime, right_vruntime = -1, spread;
-	struct sched_entity *last, *first;
+	s64 left_vruntime = -1, min_vruntime, right_vruntime = -1, left_deadline = -1, spread;
+	struct sched_entity *last, *first, *root;
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
@@ -644,15 +644,20 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			SPLIT_NS(cfs_rq->exec_clock));
 
 	raw_spin_rq_lock_irqsave(rq, flags);
+	root = __pick_root_entity(cfs_rq);
+	if (root)
+		left_vruntime = root->min_vruntime;
 	first = __pick_first_entity(cfs_rq);
 	if (first)
-		left_vruntime = first->vruntime;
+		left_deadline = first->deadline;
 	last = __pick_last_entity(cfs_rq);
 	if (last)
 		right_vruntime = last->vruntime;
 	min_vruntime = cfs_rq->min_vruntime;
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_deadline",
+			SPLIT_NS(left_deadline));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_vruntime",
 			SPLIT_NS(left_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 025d90925bf6..e1d686196528 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -551,7 +551,11 @@ static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
 static inline bool entity_before(const struct sched_entity *a,
 				 const struct sched_entity *b)
 {
-	return (s64)(a->vruntime - b->vruntime) < 0;
+	/*
+	 * Tiebreak on vruntime seems unnecessary since it can
+	 * hardly happen.
+	 */
+	return (s64)(a->deadline - b->deadline) < 0;
 }
 
 static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -720,7 +724,7 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Note: using 'avg_vruntime() > se->vruntime' is inacurate due
  *       to the loss in precision caused by the division.
  */
-int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	s64 avg = cfs_rq->avg_vruntime;
@@ -733,7 +737,12 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		load += weight;
 	}
 
-	return avg >= entity_key(cfs_rq, se) * load;
+	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
+}
+
+int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	return vruntime_eligible(cfs_rq, se->vruntime);
 }
 
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
@@ -752,9 +761,8 @@ static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
-	struct sched_entity *se = __pick_first_entity(cfs_rq);
+	struct sched_entity *se = __pick_root_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
-
 	u64 vruntime = cfs_rq->min_vruntime;
 
 	if (curr) {
@@ -766,9 +774,9 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 
 	if (se) {
 		if (!curr)
-			vruntime = se->vruntime;
+			vruntime = se->min_vruntime;
 		else
-			vruntime = min_vruntime(vruntime, se->vruntime);
+			vruntime = min_vruntime(vruntime, se->min_vruntime);
 	}
 
 	/* ensure we never gain time by being placed backwards. */
@@ -781,34 +789,34 @@ static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
 	return entity_before(__node_2_se(a), __node_2_se(b));
 }
 
-#define deadline_gt(field, lse, rse) ({ (s64)((lse)->field - (rse)->field) > 0; })
+#define vruntime_gt(field, lse, rse) ({ (s64)((lse)->field - (rse)->field) > 0; })
 
-static inline void __update_min_deadline(struct sched_entity *se, struct rb_node *node)
+static inline void __min_vruntime_update(struct sched_entity *se, struct rb_node *node)
 {
 	if (node) {
 		struct sched_entity *rse = __node_2_se(node);
-		if (deadline_gt(min_deadline, se, rse))
-			se->min_deadline = rse->min_deadline;
+		if (vruntime_gt(min_vruntime, se, rse))
+			se->min_vruntime = rse->min_vruntime;
 	}
 }
 
 /*
- * se->min_deadline = min(se->deadline, left->min_deadline, right->min_deadline)
+ * se->min_vruntime = min(se->vruntime, {left,right}->min_vruntime)
  */
-static inline bool min_deadline_update(struct sched_entity *se, bool exit)
+static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
 {
-	u64 old_min_deadline = se->min_deadline;
+	u64 old_min_vruntime = se->min_vruntime;
 	struct rb_node *node = &se->run_node;
 
-	se->min_deadline = se->deadline;
-	__update_min_deadline(se, node->rb_right);
-	__update_min_deadline(se, node->rb_left);
+	se->min_vruntime = se->vruntime;
+	__min_vruntime_update(se, node->rb_right);
+	__min_vruntime_update(se, node->rb_left);
 
-	return se->min_deadline == old_min_deadline;
+	return se->min_vruntime == old_min_vruntime;
 }
 
-RB_DECLARE_CALLBACKS(static, min_deadline_cb, struct sched_entity,
-		     run_node, min_deadline, min_deadline_update);
+RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
+		     run_node, min_vruntime, min_vruntime_update);
 
 /*
  * Enqueue an entity into the rb-tree:
@@ -816,18 +824,28 @@ RB_DECLARE_CALLBACKS(static, min_deadline_cb, struct sched_entity,
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
-	se->min_deadline = se->deadline;
+	se->min_vruntime = se->vruntime;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
-				__entity_less, &min_deadline_cb);
+				__entity_less, &min_vruntime_cb);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
-				  &min_deadline_cb);
+				  &min_vruntime_cb);
 	avg_vruntime_sub(cfs_rq, se);
 }
 
+struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *root = cfs_rq->tasks_timeline.rb_root.rb_node;
+
+	if (!root)
+		return NULL;
+
+	return __node_2_se(root);
+}
+
 struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *left = rb_first_cached(&cfs_rq->tasks_timeline);
@@ -850,23 +868,28 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
  *     with the earliest virtual deadline.
  *
  * We can do this in O(log n) time due to an augmented RB-tree. The
- * tree keeps the entries sorted on service, but also functions as a
- * heap based on the deadline by keeping:
+ * tree keeps the entries sorted on deadline, but also functions as a
+ * heap based on the vruntime by keeping:
  *
- *  se->min_deadline = min(se->deadline, se->{left,right}->min_deadline)
+ *  se->min_vruntime = min(se->vruntime, se->{left,right}->min_vruntime)
  *
- * Which allows an EDF like search on (sub)trees.
+ * Which allows tree pruning through eligibility.
  */
-static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
-	struct sched_entity *best_left = NULL;
+
+	/*
+	 * We can safely skip eligibility check if there is only one entity
+	 * in this cfs_rq, saving some cycles.
+	 */
+	if (cfs_rq->nr_running == 1)
+		return curr && curr->on_rq ? curr : __node_2_se(node);
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
-	best = curr;
 
 	/*
 	 * Once selected, run a task until it either becomes non-eligible or
@@ -875,95 +898,38 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
 	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
 		return curr;
 
+	/* Heap search for the EEVD entity */
 	while (node) {
 		struct sched_entity *se = __node_2_se(node);
+		struct rb_node *left = node->rb_left;
 
 		/*
-		 * If this entity is not eligible, try the left subtree.
+		 * Eligible entities in left subtree are always better
+		 * choices, since they have earlier deadlines.
 		 */
-		if (!entity_eligible(cfs_rq, se)) {
-			node = node->rb_left;
+		if (left && vruntime_eligible(cfs_rq,
+					__node_2_se(left)->min_vruntime)) {
+			node = left;
 			continue;
 		}
 
 		/*
-		 * Now we heap search eligible trees for the best (min_)deadline
+		 * The left subtree either is empty or has no eligible
+		 * entity, so check the current node since it is the one
+		 * with earliest deadline that might be eligible.
 		 */
-		if (!best || deadline_gt(deadline, best, se))
+		if (entity_eligible(cfs_rq, se)) {
 			best = se;
-
-		/*
-		 * Every se in a left branch is eligible, keep track of the
-		 * branch with the best min_deadline
-		 */
-		if (node->rb_left) {
-			struct sched_entity *left = __node_2_se(node->rb_left);
-
-			if (!best_left || deadline_gt(min_deadline, best_left, left))
-				best_left = left;
-
-			/*
-			 * min_deadline is in the left branch. rb_left and all
-			 * descendants are eligible, so immediately switch to the second
-			 * loop.
-			 */
-			if (left->min_deadline == se->min_deadline)
-				break;
-		}
-
-		/* min_deadline is at this node, no need to look right */
-		if (se->deadline == se->min_deadline)
 			break;
-
-		/* else min_deadline is in the right branch. */
-		node = node->rb_right;
-	}
-
-	/*
-	 * We ran into an eligible node which is itself the best.
-	 * (Or nr_running == 0 and both are NULL)
-	 */
-	if (!best_left || (s64)(best_left->min_deadline - best->deadline) > 0)
-		return best;
-
-	/*
-	 * Now best_left and all of its children are eligible, and we are just
-	 * looking for deadline == min_deadline
-	 */
-	node = &best_left->run_node;
-	while (node) {
-		struct sched_entity *se = __node_2_se(node);
-
-		/* min_deadline is the current node */
-		if (se->deadline == se->min_deadline)
-			return se;
-
-		/* min_deadline is in the left branch */
-		if (node->rb_left &&
-		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
-			node = node->rb_left;
-			continue;
 		}
 
-		/* else min_deadline is in the right branch */
 		node = node->rb_right;
 	}
-	return NULL;
-}
 
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
-{
-	struct sched_entity *se = __pick_eevdf(cfs_rq);
-
-	if (!se) {
-		struct sched_entity *left = __pick_first_entity(cfs_rq);
-		if (left) {
-			pr_err("EEVDF scheduling fail, picking leftmost\n");
-			return left;
-		}
-	}
+	if (!best || (curr && entity_before(curr, best)))
+		best = curr;
 
-	return se;
+	return best;
 }
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..539c7e763f15 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2822,6 +2822,7 @@ DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
 		    double_rq_lock(_T->lock, _T->lock2),
 		    double_rq_unlock(_T->lock, _T->lock2))
 
+extern struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
 
-- 
2.37.3

