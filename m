Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6207EBF07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjKOJE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbjKOJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:04:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7620811B;
        Wed, 15 Nov 2023 01:04:52 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoDHrq8vq+wvyYdae/OPp+OFVl7jBNhB8NklNFmdKlQ=;
        b=1yIV3M7p0QQAHoIUI+KhvMtC/JTDv13IgGvi0h1Avh+9hyVaE3afxL4wR/K16PeI0yzfj8
        xlVd7himYQByK0+jwr4OeNPEx68/hOx6saGkEgSD4QFpZy3iZyjx6vGzdvifqB8d5ROA4s
        VqSVxz3T8r8QyO71z2FzExzz+uO+oEF6W/V/xh+ReYPJwvnQKrnWP+98XEt1eYpuf20/70
        V0XVRSqt9cBMF3sHLqMNZ1mM3eLy0ZuQTy/aHT9yyLbPEOAHgt2s12g1a72iKLH+tsX3D3
        9mN8T5Jgtwh33Fv4/sltxDbdWlUhQBSPWVI+Oc7QSQnRkZWfTIIjcnQJ6RfWNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoDHrq8vq+wvyYdae/OPp+OFVl7jBNhB8NklNFmdKlQ=;
        b=p68w/r1sb1ILfHpc3jesHgSw4dvu/fr1u6I5uSfrNtQ73SgWV5TnFMG0Vm0g6WSxDuHt4+
        DAk7XeZ/YR9+P0Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Move bandwidth accounting into
 {en,de}queue_dl_entity
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <a86dccbbe44e021b8771627e1dae01a69b73466d.1699095159.git.bristot@kernel.org>
References: <a86dccbbe44e021b8771627e1dae01a69b73466d.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Message-ID: <170003909036.391.1992458122172559536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2f7a0f58948d8231236e2facecc500f1930fb996
Gitweb:        https://git.kernel.org/tip/2f7a0f58948d8231236e2facecc500f1930fb996
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Nov 2023 11:59:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:50 +01:00

sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity

In preparation of introducing !task sched_dl_entity; move the
bandwidth accounting into {en.de}queue_dl_entity().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/a86dccbbe44e021b8771627e1dae01a69b73466d.1699095159.git.bristot@kernel.org
---
 kernel/sched/deadline.c | 130 +++++++++++++++++++++------------------
 kernel/sched/sched.h    |   6 ++-
 2 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e80bb88..81810f6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -391,12 +391,12 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se);
  * up, and checks if the task is still in the "ACTIVE non contending"
  * state or not (in the second case, it updates running_bw).
  */
-static void task_non_contending(struct task_struct *p)
+static void task_non_contending(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
 	struct hrtimer *timer = &dl_se->inactive_timer;
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct task_struct *p = dl_task_of(dl_se);
 	s64 zerolag_time;
 
 	/*
@@ -428,13 +428,14 @@ static void task_non_contending(struct task_struct *p)
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
+
 		if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
 			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
 			if (READ_ONCE(p->__state) == TASK_DEAD)
-				sub_rq_bw(&p->dl, &rq->dl);
+				sub_rq_bw(dl_se, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
-			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
+			__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
 			raw_spin_unlock(&dl_b->lock);
 			__dl_clear_params(dl_se);
 		}
@@ -1602,6 +1603,41 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
 
 	/*
+	 * Check if a constrained deadline task was activated
+	 * after the deadline but before the next period.
+	 * If that is the case, the task will be throttled and
+	 * the replenishment timer will be set to the next period.
+	 */
+	if (!dl_se->dl_throttled && !dl_is_implicit(dl_se))
+		dl_check_constrained_dl(dl_se);
+
+	if (flags & (ENQUEUE_RESTORE|ENQUEUE_MIGRATING)) {
+		struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+
+		add_rq_bw(dl_se, dl_rq);
+		add_running_bw(dl_se, dl_rq);
+	}
+
+	/*
+	 * If p is throttled, we do not enqueue it. In fact, if it exhausted
+	 * its budget it needs a replenishment and, since it now is on
+	 * its rq, the bandwidth timer callback (which clearly has not
+	 * run yet) will take care of this.
+	 * However, the active utilization does not depend on the fact
+	 * that the task is on the runqueue or not (but depends on the
+	 * task's state - in GRUB parlance, "inactive" vs "active contending").
+	 * In other words, even if a task is throttled its utilization must
+	 * be counted in the active utilization; hence, we need to call
+	 * add_running_bw().
+	 */
+	if (dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
+		if (flags & ENQUEUE_WAKEUP)
+			task_contending(dl_se, flags);
+
+		return;
+	}
+
+	/*
 	 * If this is a wakeup or a new instance, the scheduling
 	 * parameters of the task might need updating. Otherwise,
 	 * we want a replenishment of its runtime.
@@ -1620,9 +1656,28 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	__enqueue_dl_entity(dl_se);
 }
 
-static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
+static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
 	__dequeue_dl_entity(dl_se);
+
+	if (flags & (DEQUEUE_SAVE|DEQUEUE_MIGRATING)) {
+		struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+
+		sub_running_bw(dl_se, dl_rq);
+		sub_rq_bw(dl_se, dl_rq);
+	}
+
+	/*
+	 * This check allows to start the inactive timer (or to immediately
+	 * decrease the active utilization, if needed) in two cases:
+	 * when the task blocks and when it is terminating
+	 * (p->state == TASK_DEAD). We can handle the two cases in the same
+	 * way, because from GRUB's point of view the same thing is happening
+	 * (the task moves from "active contending" to "active non contending"
+	 * or "inactive")
+	 */
+	if (flags & DEQUEUE_SLEEP)
+		task_non_contending(dl_se);
 }
 
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
@@ -1667,76 +1722,35 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		return;
 	}
 
-	/*
-	 * Check if a constrained deadline task was activated
-	 * after the deadline but before the next period.
-	 * If that is the case, the task will be throttled and
-	 * the replenishment timer will be set to the next period.
-	 */
-	if (!p->dl.dl_throttled && !dl_is_implicit(&p->dl))
-		dl_check_constrained_dl(&p->dl);
-
-	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & ENQUEUE_RESTORE) {
-		add_rq_bw(&p->dl, &rq->dl);
-		add_running_bw(&p->dl, &rq->dl);
-	}
-
-	/*
-	 * If p is throttled, we do not enqueue it. In fact, if it exhausted
-	 * its budget it needs a replenishment and, since it now is on
-	 * its rq, the bandwidth timer callback (which clearly has not
-	 * run yet) will take care of this.
-	 * However, the active utilization does not depend on the fact
-	 * that the task is on the runqueue or not (but depends on the
-	 * task's state - in GRUB parlance, "inactive" vs "active contending").
-	 * In other words, even if a task is throttled its utilization must
-	 * be counted in the active utilization; hence, we need to call
-	 * add_running_bw().
-	 */
-	if (p->dl.dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
-		if (flags & ENQUEUE_WAKEUP)
-			task_contending(&p->dl, flags);
-
-		return;
-	}
-
 	check_schedstat_required();
 	update_stats_wait_start_dl(dl_rq_of_se(&p->dl), &p->dl);
 
+	if (p->on_rq == TASK_ON_RQ_MIGRATING)
+		flags |= ENQUEUE_MIGRATING;
+
 	enqueue_dl_entity(&p->dl, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && !p->dl.dl_throttled && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
 
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_stats_dequeue_dl(&rq->dl, &p->dl, flags);
-	dequeue_dl_entity(&p->dl);
-	dequeue_pushable_dl_task(rq, p);
+	dequeue_dl_entity(&p->dl, flags);
+
+	if (!p->dl.dl_throttled)
+		dequeue_pushable_dl_task(rq, p);
 }
 
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
-	__dequeue_task_dl(rq, p, flags);
 
-	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & DEQUEUE_SAVE) {
-		sub_running_bw(&p->dl, &rq->dl);
-		sub_rq_bw(&p->dl, &rq->dl);
-	}
+	if (p->on_rq == TASK_ON_RQ_MIGRATING)
+		flags |= DEQUEUE_MIGRATING;
 
-	/*
-	 * This check allows to start the inactive timer (or to immediately
-	 * decrease the active utilization, if needed) in two cases:
-	 * when the task blocks and when it is terminating
-	 * (p->state == TASK_DEAD). We can handle the two cases in the same
-	 * way, because from GRUB's point of view the same thing is happening
-	 * (the task moves from "active contending" to "active non contending"
-	 * or "inactive")
-	 */
-	if (flags & DEQUEUE_SLEEP)
-		task_non_contending(p);
+	__dequeue_task_dl(rq, p, flags);
 }
 
 /*
@@ -2551,7 +2565,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	 * will reset the task parameters.
 	 */
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
-		task_non_contending(p);
+		task_non_contending(&p->dl);
 
 	/*
 	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3c62df1..1cda787 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2177,6 +2177,10 @@ extern const u32		sched_prio_to_wmult[40];
  * MOVE - paired with SAVE/RESTORE, explicitly does not preserve the location
  *        in the runqueue.
  *
+ * NOCLOCK - skip the update_rq_clock() (avoids double updates)
+ *
+ * MIGRATION - p->on_rq == TASK_ON_RQ_MIGRATING (used for DEADLINE)
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
@@ -2187,6 +2191,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
+#define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
@@ -2201,6 +2206,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define ENQUEUE_MIGRATED	0x00
 #endif
 #define ENQUEUE_INITIAL		0x80
+#define ENQUEUE_MIGRATING	0x100
 
 #define RETRY_TASK		((void *)-1UL)
 
