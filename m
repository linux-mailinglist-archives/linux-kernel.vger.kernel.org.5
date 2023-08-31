Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0778F40D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbjHaUat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347415AbjHaUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:30:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339CFE5F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:30:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3DC99CE2227
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A84C433C9;
        Thu, 31 Aug 2023 20:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693513824;
        bh=9ttkNcaoXlsBRfjZS07t2h1iweJEZgbKCykYEPAFygY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G04MT2FTbabnx+BlpXYijKXzvYAgiubfk6ob7qtBOSuOTBascEBhz+HXeFfbkC05w
         H4BLZJiYKYWzWVnp7BoxAvF0XsVjoSbiWNhjhwL5Hh/xiubN9iN1ZCA9b84VF3ujwK
         3WNrpuRCvE4cJAGPN4KW61j+YD7VevvbqtJw6KNINuIZeTz8IJUN/IVeAox0/7svrF
         LmuYVrMJr+zzyfbejfnV9cnjcF02a+msE5KKbjfHhycwY0/SwYfLRMRa1TSKZBTXdc
         gv62oXpBrr9apQwEFnzGeF1GP+R9rbKtiDKRbee2Bito7O2xlzgErbYVIJAs2052dJ
         Q2K+F8OfupJew==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, bristot@kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v4 6/7] sched/deadline: Deferrable dl server
Date:   Thu, 31 Aug 2023 22:28:57 +0200
Message-Id: <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1693510979.git.bristot@kernel.org>
References: <cover.1693510979.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Among the motivations for the DL servers is the real-time throttling
mechanism. This mechanism works by throttling the rt_rq after
running for a long period without leaving space for fair tasks.

The base dl server avoids this problem by boosting fair tasks instead
of throttling the rt_rq. The point is that it boosts without waiting
for potential starvation, causing some non-intuitive cases.

For example, an IRQ dispatches two tasks on an idle system, a fair
and an RT. The DL server will be activated, running the fair task
before the RT one. This problem can be avoided by deferring the
dl server activation.

By passing the deferring option, the dl_server will dispatch an
SCHED_DEADLINE reservation throttled, and the replenishment
timer set for (period - runtime) ns from start time. Thus,
boosting the fair rq on its 0-laxity time with respect
to rt_rq.

The fair server will be scheduled under EDF, with a new
a period at the replenishment time, thus not breaking dl tasks.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/sched.h   |  7 +++++
 kernel/sched/deadline.c | 61 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/fair.c     | 10 ++++---
 kernel/sched/rt.c       |  6 ++++
 kernel/sched/sched.h    | 12 +++++++-
 5 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 40fbf3f034e0..38d0b3de03b2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -609,6 +609,12 @@ struct sched_rt_entity {
 typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
 typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
 
+enum dl_server_state {
+	DL_SERVER_STOPPED = 0,
+	DL_SERVER_DEFER,
+	DL_SERVER_RUNNING
+};
+
 struct sched_dl_entity {
 	struct rb_node			rb_node;
 
@@ -685,6 +691,7 @@ struct sched_dl_entity {
 	struct rq			*rq;
 	dl_server_has_tasks_f		server_has_tasks;
 	dl_server_pick_f		server_pick;
+	enum dl_server_state			server_state;
 
 #ifdef CONFIG_RT_MUTEXES
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7844cfb73029..7f1c52bfe78f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -422,7 +422,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se)
 	if (dl_entity_is_special(dl_se))
 		return;
 
-	WARN_ON(dl_se->dl_non_contending);
+	WARN_ON_ONCE(dl_se->dl_non_contending);
 
 	zerolag_time = dl_se->deadline -
 		 div64_long((dl_se->runtime * dl_se->dl_period),
@@ -1155,6 +1155,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 		struct rq_flags rf;
 
 		rq_lock(rq, &rf);
+
 		if (dl_se->dl_throttled) {
 			sched_clock_tick();
 			update_rq_clock(rq);
@@ -1165,9 +1166,12 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 				__push_dl_task(rq, &rf);
 			} else {
 				replenish_dl_entity(dl_se);
+				task_non_contending(dl_se);
 			}
 
 		}
+
+		dl_se->server_state = DL_SERVER_RUNNING;
 		rq_unlock(rq, &rf);
 
 		return HRTIMER_NORESTART;
@@ -1441,18 +1445,65 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 	update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
-void dl_server_start(struct sched_dl_entity *dl_se)
+void dl_server_start(struct sched_dl_entity *dl_se, int defer)
 {
+	if (dl_se->server_state != DL_SERVER_STOPPED) {
+		WARN_ON_ONCE(!(on_dl_rq(dl_se) || dl_se->dl_throttled));
+		return;
+	}
+
+	if (defer) {
+		/*
+		 * Postpone the replenishment to the (next period - the execution time)
+		 *
+		 * With this in place, we have two cases:
+		 *
+		 * On the absence of DL tasks:
+		 *	The server will start at the replenishment time, getting
+		 *	its runtime before now + period. This is the expected
+		 *	throttling behavior.
+		 *
+		 * In the presense of DL tasks:
+		 *	The server will be replenished, and then it will be
+		 *	schedule according to EDF, not breaking SCHED_DEADLINE.
+		 *
+		 *	In the first cycle the server will be postponed at most
+		 *	at period + period - runtime at most. But then the
+		 *	server will receive its runtime/period.
+		 *
+		 *	The server will, however, run on top of any RT task, which
+		 *	is the expected throttling behavior.
+		 */
+		dl_se->deadline = rq_clock(dl_se->rq) + dl_se->dl_period - dl_se->dl_runtime;
+		/* Zero the runtime */
+		dl_se->runtime = 0;
+		/* throttle the server */
+		dl_se->dl_throttled = 1;
+
+		dl_se->server_state = DL_SERVER_DEFER;
+		start_dl_timer(dl_se);
+		return;
+	}
+
 	if (!dl_server(dl_se)) {
 		dl_se->dl_server = 1;
 		setup_new_dl_entity(dl_se);
 	}
+
+	dl_se->server_state = DL_SERVER_RUNNING;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 }
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
+	if (dl_se->server_state == DL_SERVER_STOPPED)
+		return;
+
+	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+
+	dl_se->dl_throttled = 0;
+	dl_se->server_state = DL_SERVER_STOPPED;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -1462,6 +1513,8 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 	dl_se->rq = rq;
 	dl_se->server_has_tasks = has_tasks;
 	dl_se->server_pick = pick;
+	dl_se->server_state = DL_SERVER_STOPPED;
+	dl_se->dl_server = 1;
 }
 
 /*
@@ -1817,8 +1870,9 @@ static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	 * (the task moves from "active contending" to "active non contending"
 	 * or "inactive")
 	 */
-	if (flags & DEQUEUE_SLEEP)
+	if (flags & DEQUEUE_SLEEP && !dl_server(dl_se))
 		task_non_contending(dl_se);
+
 }
 
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
@@ -1875,7 +1929,6 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_pushable_dl_task(rq, p);
 }
 
-
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 580e6764a68b..b9d0f08dc8ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6499,9 +6499,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
-	if (!rq->cfs.h_nr_running)
-		dl_server_start(&rq->fair_server);
-
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -6568,6 +6565,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_overutilized_status(rq);
 
 enqueue_throttle:
+	if (sched_fair_server_needed(rq))
+		dl_server_start(&rq->fair_server, rq->fair_server_defer);
+
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
@@ -6646,7 +6646,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
-	if (!rq->cfs.h_nr_running)
+	if (!sched_fair_server_needed(rq))
 		dl_server_stop(&rq->fair_server);
 
 	util_est_update(&rq->cfs, p, task_sleep);
@@ -8317,6 +8317,8 @@ void fair_server_init(struct rq *rq)
 	dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
 	dl_se->dl_period = 1000 * NSEC_PER_MSEC;
 
+	rq->fair_server_defer = 1;
+
 	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e23cc67c9467..7595110a5a3e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1537,6 +1537,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
+
+	if (sched_fair_server_needed(rq))
+		dl_server_start(&rq->fair_server, rq->fair_server_defer);
 }
 
 static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
@@ -1547,6 +1550,9 @@ static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_rt_entity(rt_se, flags);
 
 	dequeue_pushable_task(rq, p);
+
+	if (!sched_fair_server_needed(rq))
+		dl_server_stop(&rq->fair_server);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ac94c386741c..510c4db379be 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -345,7 +345,7 @@ extern int  dl_bw_check_overflow(int cpu);
  *   dl_server_init() -- initializes the server.
  */
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
-extern void dl_server_start(struct sched_dl_entity *dl_se);
+extern void dl_server_start(struct sched_dl_entity *dl_se, int defer);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
@@ -1027,6 +1027,7 @@ struct rq {
 	struct dl_rq		dl;
 
 	struct sched_dl_entity	fair_server;
+	int			fair_server_defer;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
@@ -2394,6 +2395,15 @@ static inline bool sched_fair_runnable(struct rq *rq)
 	return rq->cfs.nr_running > 0;
 }
 
+static inline bool sched_fair_server_needed(struct rq *rq)
+{
+	/*
+	 * The fair server will activate anytime a fair task can starve
+	 * because real-time tasks.
+	 */
+	return (sched_rt_runnable(rq) && sched_fair_runnable(rq));
+}
+
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 extern struct task_struct *pick_next_task_idle(struct rq *rq);
 
-- 
2.40.1

