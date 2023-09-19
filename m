Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2EF7A5EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjISJxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjISJw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:52:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE1F5;
        Tue, 19 Sep 2023 02:52:52 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:52:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695117171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cmbxedhjULxQ5f/9ToQ2wKpfQ2l8/2rPZBD9k7fMJ04=;
        b=AfXz9Z9j3LigFYq8+rFm390pUPdhgPszRHnOlTWpkqhJE22qQKP13FxW0ToC+EeohW0SeH
        cpo5sQPTKkQDK+4NAKUTO8WAk/hDvlGUCaCGfVXksrjtonJ66RdMDWGJGTlTCijkvcnpEv
        UbYyddAqZjTKFF2FR3E4T51Sji2y83H4QzL5DBTqjQ6QQw9gYzGdPR3M9eZFrsnRogJIDt
        zaIt+RjQKcqdcmnNENZ4PB7TpU0NgVtH/1OTRDo9oVUtZR6MFxlV0DdEaIWO1VpB9Ty1Jz
        kGgt98uKkXCnR+i7kHobR4z7GkUJ0XmvjYIGpMFJPdAlcA6s+sSjRFNsq1omHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695117171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cmbxedhjULxQ5f/9ToQ2wKpfQ2l8/2rPZBD9k7fMJ04=;
        b=LBqwFSmwo37bURuahNGUsXU9HQ0BkFU/K0fLGRu6s3Wuu4M1mEpkD42CluxmBJHzjn4IGu
        l37nLRmv97ZrE8Cg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename check_preempt_curr() to wakeup_preempt()
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169511717054.27769.5426777929140245485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e23edc86b09df655bf8963bbcb16647adc787395
Gitweb:        https://git.kernel.org/tip/e23edc86b09df655bf8963bbcb16647adc787395
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 19 Sep 2023 10:38:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Sep 2023 10:40:10 +02:00

sched/fair: Rename check_preempt_curr() to wakeup_preempt()

The name is a bit opaque - make it clear that this is about wakeup
preemption.

Also rename the ->check_preempt_curr() methods similarly.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      | 14 +++++++-------
 kernel/sched/deadline.c  | 10 +++++-----
 kernel/sched/fair.c      | 10 +++++-----
 kernel/sched/idle.c      |  4 ++--
 kernel/sched/rt.c        |  6 +++---
 kernel/sched/sched.h     |  4 ++--
 kernel/sched/stop_task.c |  4 ++--
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5a50c4e..52ceb85 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2211,10 +2211,10 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 		p->sched_class->prio_changed(rq, p, oldprio);
 }
 
-void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
+void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (p->sched_class == rq->curr->sched_class)
-		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
+		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
 	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
 		resched_curr(rq);
 
@@ -2508,7 +2508,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 	rq_lock(rq, rf);
 	WARN_ON_ONCE(task_cpu(p) != new_cpu);
 	activate_task(rq, p, 0);
-	check_preempt_curr(rq, p, 0);
+	wakeup_preempt(rq, p, 0);
 
 	return rq;
 }
@@ -3390,7 +3390,7 @@ static void __migrate_swap_task(struct task_struct *p, int cpu)
 		deactivate_task(src_rq, p, 0);
 		set_task_cpu(p, cpu);
 		activate_task(dst_rq, p, 0);
-		check_preempt_curr(dst_rq, p, 0);
+		wakeup_preempt(dst_rq, p, 0);
 
 		rq_unpin_lock(dst_rq, &drf);
 		rq_unpin_lock(src_rq, &srf);
@@ -3764,7 +3764,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 	}
 
 	activate_task(rq, p, en_flags);
-	check_preempt_curr(rq, p, wake_flags);
+	wakeup_preempt(rq, p, wake_flags);
 
 	ttwu_do_wakeup(p);
 
@@ -3835,7 +3835,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 			 * it should preempt the task that is current now.
 			 */
 			update_rq_clock(rq);
-			check_preempt_curr(rq, p, wake_flags);
+			wakeup_preempt(rq, p, wake_flags);
 		}
 		ttwu_do_wakeup(p);
 		ret = 1;
@@ -4854,7 +4854,7 @@ void wake_up_new_task(struct task_struct *p)
 
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
 	trace_sched_wakeup_new(p);
-	check_preempt_curr(rq, p, WF_FORK);
+	wakeup_preempt(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 58b542b..fb1996a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -763,7 +763,7 @@ static inline void deadline_queue_pull_task(struct rq *rq)
 
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags);
-static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p, int flags);
+static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p, int flags);
 
 static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 					    struct rq *rq)
@@ -1175,7 +1175,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
 	if (dl_task(rq->curr))
-		check_preempt_curr_dl(rq, p, 0);
+		wakeup_preempt_dl(rq, p, 0);
 	else
 		resched_curr(rq);
 
@@ -1939,7 +1939,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
  * Only called when both the current and waking task are -deadline
  * tasks.
  */
-static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
+static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
 	if (dl_entity_preempt(&p->dl, &rq->curr->dl)) {
@@ -2652,7 +2652,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 			deadline_queue_push_tasks(rq);
 #endif
 		if (dl_task(rq->curr))
-			check_preempt_curr_dl(rq, p, 0);
+			wakeup_preempt_dl(rq, p, 0);
 		else
 			resched_curr(rq);
 	} else {
@@ -2721,7 +2721,7 @@ DEFINE_SCHED_CLASS(dl) = {
 	.dequeue_task		= dequeue_task_dl,
 	.yield_task		= yield_task_dl,
 
-	.check_preempt_curr	= check_preempt_curr_dl,
+	.wakeup_preempt		= wakeup_preempt_dl,
 
 	.pick_next_task		= pick_next_task_dl,
 	.put_prev_task		= put_prev_task_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aeaf31e..fcf0c5b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8007,7 +8007,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 
 	/*
 	 * This is possible from callers such as attach_tasks(), in which we
-	 * unconditionally check_preempt_curr() after an enqueue (which may have
+	 * unconditionally wakeup_preempt() after an enqueue (which may have
 	 * lead to a throttle).  This both saves work and prevents false
 	 * next-buddy nomination below.
 	 */
@@ -8914,7 +8914,7 @@ static void attach_task(struct rq *rq, struct task_struct *p)
 
 	WARN_ON_ONCE(task_rq(p) != rq);
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
-	check_preempt_curr(rq, p, 0);
+	wakeup_preempt(rq, p, 0);
 }
 
 /*
@@ -12369,7 +12369,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
-		check_preempt_curr(rq, p, 0);
+		wakeup_preempt(rq, p, 0);
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -12471,7 +12471,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		if (task_current(rq, p))
 			resched_curr(rq);
 		else
-			check_preempt_curr(rq, p, 0);
+			wakeup_preempt(rq, p, 0);
 	}
 }
 
@@ -12830,7 +12830,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.yield_task		= yield_task_fair,
 	.yield_to_task		= yield_to_task_fair,
 
-	.check_preempt_curr	= check_preempt_wakeup_fair,
+	.wakeup_preempt		= check_preempt_wakeup_fair,
 
 	.pick_next_task		= __pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 342f58a..26f7140 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -400,7 +400,7 @@ balance_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 /*
  * Idle tasks are unconditionally rescheduled:
  */
-static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int flags)
+static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 {
 	resched_curr(rq);
 }
@@ -481,7 +481,7 @@ DEFINE_SCHED_CLASS(idle) = {
 	/* dequeue is not valid, we print a debug message there: */
 	.dequeue_task		= dequeue_task_idle,
 
-	.check_preempt_curr	= check_preempt_curr_idle,
+	.wakeup_preempt		= wakeup_preempt_idle,
 
 	.pick_next_task		= pick_next_task_idle,
 	.put_prev_task		= put_prev_task_idle,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0597ba0..3e442fa 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -953,7 +953,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 
 				/*
 				 * When we're idle and a woken (rt) task is
-				 * throttled check_preempt_curr() will set
+				 * throttled wakeup_preempt() will set
 				 * skip_update and the time between the wakeup
 				 * and this unthrottle will get accounted as
 				 * 'runtime'.
@@ -1715,7 +1715,7 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 /*
  * Preempt the current task with a newly woken task if needed:
  */
-static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
+static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (p->prio < rq->curr->prio) {
 		resched_curr(rq);
@@ -2702,7 +2702,7 @@ DEFINE_SCHED_CLASS(rt) = {
 	.dequeue_task		= dequeue_task_rt,
 	.yield_task		= yield_task_rt,
 
-	.check_preempt_curr	= check_preempt_curr_rt,
+	.wakeup_preempt		= wakeup_preempt_rt,
 
 	.pick_next_task		= pick_next_task_rt,
 	.put_prev_task		= put_prev_task_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f217b1..7e070dc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2236,7 +2236,7 @@ struct sched_class {
 	void (*yield_task)   (struct rq *rq);
 	bool (*yield_to_task)(struct rq *rq, struct task_struct *p);
 
-	void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
+	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
 	struct task_struct *(*pick_next_task)(struct rq *rq);
 
@@ -2510,7 +2510,7 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
-extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
+extern void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags);
 
 #ifdef CONFIG_PREEMPT_RT
 #define SCHED_NR_MIGRATE_BREAK 8
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 8559059..6cf7304 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -23,7 +23,7 @@ balance_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 #endif /* CONFIG_SMP */
 
 static void
-check_preempt_curr_stop(struct rq *rq, struct task_struct *p, int flags)
+wakeup_preempt_stop(struct rq *rq, struct task_struct *p, int flags)
 {
 	/* we're never preempted */
 }
@@ -120,7 +120,7 @@ DEFINE_SCHED_CLASS(stop) = {
 	.dequeue_task		= dequeue_task_stop,
 	.yield_task		= yield_task_stop,
 
-	.check_preempt_curr	= check_preempt_curr_stop,
+	.wakeup_preempt		= wakeup_preempt_stop,
 
 	.pick_next_task		= pick_next_task_stop,
 	.put_prev_task		= put_prev_task_stop,
