Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD64806758
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376805AbjLFGe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjLFGe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:34:26 -0500
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040D1BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:34:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701844469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+ur4a0hWU+7jS1cQdkoVwB5xk0PqQxzIYs0iU9W36Q=;
        b=THWr/WsIUQYJV3nh7/K0bWCOiqU/xSaMB1QTvbGUaM8Xrm6iojxUSSW0cF8hUwqCTicbn2
        HYKEqJPLH3cDWODr4m7Ph7tt/gohXtZiPp/Hed0RSj8srIVAuDqmJ62G7hrtNgBeHj8T6+
        512YdlsETVcVx7Y8YX4J3WPDz+7UGmQ=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2 1/2] sched/fair: Return NULL when entity isn't a task in task_of()
Date:   Wed,  6 Dec 2023 14:33:59 +0800
Message-Id: <20231206063400.3206346-2-yajun.deng@linux.dev>
In-Reply-To: <20231206063400.3206346-1-yajun.deng@linux.dev>
References: <20231206063400.3206346-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before calling task_of(), we need to make sure that the entity is a task.
There is also a warning in task_of() if the entity isn't a task. That
means we need to check the entity twice. If the entity isn't a task,
return the task struct is meaningless.

Return NULL when entity isn't a task in task_of(), and call task_of()
instead of entity_is_task() when we need a task_struct.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/fair.c  | 50 +++++++++++++++++++++-----------------------
 kernel/sched/sched.h |  4 +++-
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcd0f230e21f..5003c8501398 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -470,8 +470,10 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
 
 static int se_is_idle(struct sched_entity *se)
 {
-	if (entity_is_task(se))
-		return task_has_idle_policy(task_of(se));
+	struct task_struct *p = task_of(se);
+
+	if (p)
+		return task_has_idle_policy(p);
 	return cfs_rq_is_idle(group_cfs_rq(se));
 }
 
@@ -1156,6 +1158,7 @@ s64 update_curr_common(struct rq *rq)
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
+	struct task_struct *p;
 	s64 delta_exec;
 
 	if (unlikely(!curr))
@@ -1169,8 +1172,9 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
-	if (entity_is_task(curr))
-		update_curr_task(task_of(curr), delta_exec);
+	p = task_of(curr);
+	if (p)
+		update_curr_task(p, delta_exec);
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
@@ -1184,24 +1188,19 @@ static inline void
 update_stats_wait_start_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
 
 	stats = __schedstats_from_se(se);
 
-	if (entity_is_task(se))
-		p = task_of(se);
-
-	__update_stats_wait_start(rq_of(cfs_rq), p, stats);
+	__update_stats_wait_start(rq_of(cfs_rq), task_of(se), stats);
 }
 
 static inline void
 update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
@@ -1217,27 +1216,20 @@ update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (unlikely(!schedstat_val(stats->wait_start)))
 		return;
 
-	if (entity_is_task(se))
-		p = task_of(se);
-
-	__update_stats_wait_end(rq_of(cfs_rq), p, stats);
+	__update_stats_wait_end(rq_of(cfs_rq), task_of(se), stats);
 }
 
 static inline void
 update_stats_enqueue_sleeper_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct sched_statistics *stats;
-	struct task_struct *tsk = NULL;
 
 	if (!schedstat_enabled())
 		return;
 
 	stats = __schedstats_from_se(se);
 
-	if (entity_is_task(se))
-		tsk = task_of(se);
-
-	__update_stats_enqueue_sleeper(rq_of(cfs_rq), tsk, stats);
+	__update_stats_enqueue_sleeper(rq_of(cfs_rq), task_of(se), stats);
 }
 
 /*
@@ -1263,6 +1255,7 @@ update_stats_enqueue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
 static inline void
 update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
+	struct task_struct *tsk;
 
 	if (!schedstat_enabled())
 		return;
@@ -1274,8 +1267,8 @@ update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
 	if (se != cfs_rq->curr)
 		update_stats_wait_end_fair(cfs_rq, se);
 
-	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
-		struct task_struct *tsk = task_of(se);
+	tsk = task_of(se);
+	if ((flags & DEQUEUE_SLEEP) && tsk) {
 		unsigned int state;
 
 		/* XXX racy against TTWU */
@@ -3569,12 +3562,14 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct task_struct *p = task_of(se);
+
 	update_load_add(&cfs_rq->load, se->load.weight);
 #ifdef CONFIG_SMP
-	if (entity_is_task(se)) {
+	if (p) {
 		struct rq *rq = rq_of(cfs_rq);
 
-		account_numa_enqueue(rq, task_of(se));
+		account_numa_enqueue(rq, p);
 		list_add(&se->group_node, &rq->cfs_tasks);
 	}
 #endif
@@ -3586,10 +3581,12 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct task_struct *p = task_of(se);
+
 	update_load_sub(&cfs_rq->load, se->load.weight);
 #ifdef CONFIG_SMP
-	if (entity_is_task(se)) {
-		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
+	if (p) {
+		account_numa_dequeue(rq_of(cfs_rq), p);
 		list_del_init(&se->group_node);
 	}
 #endif
@@ -5323,9 +5320,10 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 static void
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
+	struct task_struct *p = task_of(se);
 	int action = UPDATE_TG;
 
-	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
+	if (p && task_on_rq_migrating(p))
 		action |= DO_DETACH;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..6baba9ebcde1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1432,7 +1432,9 @@ static inline void update_idle_core(struct rq *rq) { }
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
-	SCHED_WARN_ON(!entity_is_task(se));
+	if (!entity_is_task(se))
+		return NULL;
+
 	return container_of(se, struct task_struct, se);
 }
 
-- 
2.25.1

