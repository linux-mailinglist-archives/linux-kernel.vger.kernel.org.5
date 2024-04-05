Return-Path: <linux-kernel+bounces-133423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0D89A37B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3EE1C216E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B617167D;
	Fri,  5 Apr 2024 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPYETBzo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C476171675
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338113; cv=none; b=r12Ra/yM05ELJVD37cDODsR9/dvZjw5RnkadFsC8z6fXZ9SlktNw/8LVKoy+/1u5q3m5rNB7Ptyfs8pHCStiTLrnJLznz7wxdGsp+tQ0Ujk+ISSTqfvg3fQRaL66xcfyl6x0q1Uxpe9uMhquNK5t4BPW5W3olO1+kaQJKcqKu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338113; c=relaxed/simple;
	bh=amxxtWFGOE1JGozhcxEvRnk4Kms40eihsREXxOMDgd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWxairhVS7BgyZ3lJZyS16Ftj6qaua/UymVPyDFsfzcnzgY748S1lBij6HOmPZzzm6cpOwIrTWa9DcZCAC42VZnfSDPj+XjnBpfSjkZS+BBjKybkG5iw0eCACciSIEFIzIS4AZXbHwpgJC10PtyQLpEOqf5P8AtPb7xp9gJ7XjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPYETBzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2533DC433A6;
	Fri,  5 Apr 2024 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338113;
	bh=amxxtWFGOE1JGozhcxEvRnk4Kms40eihsREXxOMDgd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPYETBzo1BUsmVKL31ivlMSv12JsW8h7JFgAgNAXb1NgmdxSy5PWis91cKF1U2Itw
	 D59Jwca9OlbwiiCyYxOwS1spA5IQsCLWhlM3xQVyDLcm4RUAv2FwqOJrD+L55uxeHF
	 q/9XW1Xr/+hwrZJDdEWfPbfgp/A4wAVecCdlwHnoRLX6WaiZ3MecKszHGosCa4PE/3
	 KH56Y235MtPkS0CecpDYFhQOzN1Gp5S+nA0L8uVpeqEJZCbv1GGRV03qyWQ7oDWiSV
	 odD5N/qYrMaffrXQApobKLkPlh2yTcOf9uIvrEOFii+OBQUqDAE/3Mfnuluj21Hjmj
	 tCeqcPQsoTUhw==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V6 2/6] sched/deadline: Deferrable dl server
Date: Fri,  5 Apr 2024 19:28:01 +0200
Message-ID: <7b9c206e914ef257a2534199f25938ffafa3e59e.1712337227.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712337227.git.bristot@kernel.org>
References: <cover.1712337227.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

By setting the defer option, the dl_server will dispatch an
SCHED_DEADLINE reservation with replenished runtime, but throttled.

The dl_timer will be set for the defer time at (period - runtime) ns
from start time. Thus boosting the fair rq at defer time.

If the fair scheduler has the opportunity to run while waiting
for defer time, the dl server runtime will be consumed. If
the runtime is completely consumed before the defer time, the
server will be replenished while still in a throttled state. Then,
the dl_timer will be reset to the new defer time

If the fair server reaches the defer time without consuming
its runtime, the server will start running, following CBS rules
(thus without breaking SCHED_DEADLINE). Then the server will
continue the running state (without deferring) until it fair
tasks are able to execute as regular fair scheduler (end of
the starvation).

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/sched.h   |   3 +
 kernel/sched/deadline.c | 296 ++++++++++++++++++++++++++++++++++------
 kernel/sched/fair.c     |  24 +++-
 kernel/sched/idle.c     |   2 +
 kernel/sched/sched.h    |   4 +-
 5 files changed, 284 insertions(+), 45 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..4a405f0e64f8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -643,6 +643,9 @@ struct sched_dl_entity {
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
 	unsigned int			dl_server         : 1;
+	unsigned int			dl_defer	  : 1;
+	unsigned int			dl_defer_armed	  : 1;
+	unsigned int			dl_defer_running  : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index db5dc5c09106..6ea9c05711ce 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -772,6 +772,15 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 	/* for non-boosted task, pi_of(dl_se) == dl_se */
 	dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
 	dl_se->runtime = pi_of(dl_se)->dl_runtime;
+
+	/*
+	 * If it is a deferred reservation, and the server
+	 * is not handling an starvation case, defer it.
+	 */
+	if (dl_se->dl_defer & !dl_se->dl_defer_running) {
+		dl_se->dl_throttled = 1;
+		dl_se->dl_defer_armed = 1;
+	}
 }
 
 /*
@@ -810,6 +819,9 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	replenish_dl_new_period(dl_se, rq);
 }
 
+static int start_dl_timer(struct sched_dl_entity *dl_se);
+static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
+
 /*
  * Pure Earliest Deadline First (EDF) scheduling does not deal with the
  * possibility of a entity lasting more than what it declared, and thus
@@ -838,9 +850,18 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	/*
 	 * This could be the case for a !-dl task that is boosted.
 	 * Just go with full inherited parameters.
+	 *
+	 * Or, it could be the case of a deferred reservation that
+	 * was not able to consume its runtime in background and
+	 * reached this point with current u > U.
+	 *
+	 * In both cases, set a new period.
 	 */
-	if (dl_se->dl_deadline == 0)
-		replenish_dl_new_period(dl_se, rq);
+	if (dl_se->dl_deadline == 0 ||
+	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
+		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+	}
 
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
 		dl_se->runtime = 0;
@@ -874,6 +895,37 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 		dl_se->dl_yielded = 0;
 	if (dl_se->dl_throttled)
 		dl_se->dl_throttled = 0;
+
+	/*
+	 * If this is the replenishment of a deferred reservation,
+	 * clear the flag and return.
+	 */
+	if (dl_se->dl_defer_armed) {
+		dl_se->dl_defer_armed = 0;
+		return;
+	}
+
+	/*
+	 * A this point, if the deferred server is not armed, and the deadline
+	 * is in the future, if it is not running already, throttle the server
+	 * and arm the defer timer.
+	 */
+	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
+	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
+		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
+			dl_se->dl_defer_armed = 1;
+			dl_se->dl_throttled = 1;
+			if (!start_dl_timer(dl_se)) {
+				/*
+				 * If for whatever reason (delays), if a previous timer was
+				 *  queued but not serviced, cancel it.
+				 */
+				hrtimer_try_to_cancel(&dl_se->dl_timer);
+				dl_se->dl_defer_armed = 0;
+				dl_se->dl_throttled = 0;
+			}
+		}
+	}
 }
 
 /*
@@ -1024,6 +1076,15 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 		}
 
 		replenish_dl_new_period(dl_se, rq);
+	} else if (dl_server(dl_se) && dl_se->dl_defer) {
+		/*
+		 * The server can still use its previous deadline, so check if
+		 * it left the dl_defer_running state.
+		 */
+		if (!dl_se->dl_defer_running) {
+			dl_se->dl_defer_armed = 1;
+			dl_se->dl_throttled = 1;
+		}
 	}
 }
 
@@ -1056,8 +1117,20 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
 	 * We want the timer to fire at the deadline, but considering
 	 * that it is actually coming from rq->clock and not from
 	 * hrtimer's time base reading.
+	 *
+	 * The deferred reservation will have its timer set to
+	 * (deadline - runtime). At that point, the CBS rule will decide
+	 * if the current deadline can be used, or if a replenishment is
+	 * required to avoid add too much pressure on the system
+	 * (current u > U).
 	 */
-	act = ns_to_ktime(dl_next_period(dl_se));
+	if (dl_se->dl_defer_armed) {
+		WARN_ON_ONCE(!dl_se->dl_throttled);
+		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
+	} else {
+		act = ns_to_ktime(dl_next_period(dl_se));
+	}
+
 	now = hrtimer_cb_get_time(timer);
 	delta = ktime_to_ns(now) - rq_clock(rq);
 	act = ktime_add_ns(act, delta);
@@ -1107,6 +1180,64 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 #endif
 }
 
+/* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
+static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
+
+static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
+{
+	struct rq *rq = rq_of_dl_se(dl_se);
+	enum hrtimer_restart restart = 0;
+	struct rq_flags rf;
+	u64 fw;
+
+	rq_lock(rq, &rf);
+	if (dl_se->dl_throttled) {
+		sched_clock_tick();
+		update_rq_clock(rq);
+
+		if (!dl_se->dl_runtime)
+			goto unlock;
+
+		if (!dl_se->server_has_tasks(dl_se)) {
+			replenish_dl_entity(dl_se);
+			goto unlock;
+		}
+
+		if (dl_se->dl_defer_armed) {
+			/*
+			 * First check if the server could consume runtime in background.
+			 * If so, it is possible to push the defer timer for this amount
+			 * of time. The dl_server_min_res serves as a limit to avoid
+			 * forwarding the timer for a too small amount of time.
+			 */
+			if (dl_time_before(rq_clock(dl_se->rq),
+				(dl_se->deadline - dl_se->runtime - dl_server_min_res))) {
+
+				/* reset the defer timer */
+				fw = dl_se->deadline - rq_clock(dl_se->rq) - dl_se->runtime;
+
+				hrtimer_forward_now(timer, ns_to_ktime(fw));
+				restart = 1;
+				goto unlock;
+			}
+
+			dl_se->dl_defer_running = 1;
+		}
+
+		enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
+
+		if (!dl_task(dl_se->rq->curr) ||
+			dl_entity_preempt(dl_se, &dl_se->rq->curr->dl))
+			resched_curr(rq);
+
+		__push_dl_task(rq, &rf);
+	}
+unlock:
+	rq_unlock(rq, &rf);
+
+	return restart ? HRTIMER_RESTART : HRTIMER_NORESTART;
+}
+
 /*
  * This is the bandwidth enforcement timer callback. If here, we know
  * a task is not on its dl_rq, since the fact that the timer was running
@@ -1129,28 +1260,8 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (dl_server(dl_se)) {
-		struct rq *rq = rq_of_dl_se(dl_se);
-		struct rq_flags rf;
-
-		rq_lock(rq, &rf);
-		if (dl_se->dl_throttled) {
-			sched_clock_tick();
-			update_rq_clock(rq);
-
-			if (dl_se->server_has_tasks(dl_se)) {
-				enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
-				resched_curr(rq);
-				__push_dl_task(rq, &rf);
-			} else {
-				replenish_dl_entity(dl_se);
-			}
-
-		}
-		rq_unlock(rq, &rf);
-
-		return HRTIMER_NORESTART;
-	}
+	if (dl_server(dl_se))
+		return dl_server_timer(timer, dl_se);
 
 	p = dl_task_of(dl_se);
 	rq = task_rq_lock(p, &rf);
@@ -1320,22 +1431,10 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 	return (delta * u_act) >> BW_SHIFT;
 }
 
-static inline void
-update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
-                        int flags);
-static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
+s64 dl_scalled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	s64 scaled_delta_exec;
 
-	if (unlikely(delta_exec <= 0)) {
-		if (unlikely(dl_se->dl_yielded))
-			goto throttle;
-		return;
-	}
-
-	if (dl_entity_is_special(dl_se))
-		return;
-
 	/*
 	 * For tasks that participate in GRUB, we implement GRUB-PA: the
 	 * spare reclaimed bandwidth is used to clock down frequency.
@@ -1354,8 +1453,64 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
 	}
 
+	return scaled_delta_exec;
+}
+
+static inline void
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+			int flags);
+static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
+{
+	s64 scaled_delta_exec;
+
+	if (unlikely(delta_exec <= 0)) {
+		if (unlikely(dl_se->dl_yielded))
+			goto throttle;
+		return;
+	}
+
+	if (dl_server(dl_se) && dl_se->dl_throttled && !dl_se->dl_defer)
+		return;
+
+	if (dl_entity_is_special(dl_se))
+		return;
+
+	scaled_delta_exec = dl_scalled_delta_exec(rq, dl_se, delta_exec);
+
 	dl_se->runtime -= scaled_delta_exec;
 
+	/*
+	 * The fair server can consume its runtime while throttled (not queued/
+	 * running as regular CFS).
+	 *
+	 * If the server consumes its entire runtime in this state. The server
+	 * is not required for the current period. Thus, reset the server by
+	 * starting a new period, pushing the activation.
+	 */
+	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
+		/*
+		 * If the server was previously activated - the starving condition
+		 * took place, it this point it went away because the fair scheduler
+		 * was able to get runtime in background. So return to the initial
+		 * state.
+		 */
+		dl_se->dl_defer_running = 0;
+
+		hrtimer_try_to_cancel(&dl_se->dl_timer);
+
+		replenish_dl_new_period(dl_se, dl_se->rq);
+
+		/*
+		 * Not being able to start the timer seems problematic. If it could not
+		 * be started for whatever reason, we need to "unthrottle" the DL server
+		 * and queue right away. Otherwise nothing might queue it. That's similar
+		 * to what enqueue_dl_entity() does on start_dl_timer==0. For now, just warn.
+		 */
+		WARN_ON_ONCE(!start_dl_timer(dl_se));
+
+		return;
+	}
+
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
 		dl_se->dl_throttled = 1;
@@ -1415,9 +1570,47 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	}
 }
 
+/*
+ * In the non-defer mode, the idle time is not accounted, as the
+ * server provides a guarantee.
+ *
+ * If the dl_server is in defer mode, the idle time is also considered
+ * as time available for the fair server. This avoids creating a
+ * regression with the rt throttling behavior where the idle time did
+ * not create a penalty to the rt schedulers.
+ */
+void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+{
+	s64 delta_exec, scaled_delta_exec;
+
+	if (!rq->fair_server.dl_defer)
+		return;
+
+	/* no need to discount more */
+	if (rq->fair_server.runtime < 0)
+		return;
+
+	delta_exec = rq_clock_task(rq) - p->se.exec_start;
+	if (delta_exec < 0)
+		return;
+
+	scaled_delta_exec = dl_scalled_delta_exec(rq, &rq->fair_server, delta_exec);
+
+	rq->fair_server.runtime -= scaled_delta_exec;
+
+	if (rq->fair_server.runtime < 0) {
+		rq->fair_server.dl_defer_running = 0;
+		rq->fair_server.runtime = 0;
+	}
+
+	p->se.exec_start = rq_clock_task(rq);
+}
+
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+	/* 0 runtime = fair server disabled */
+	if (dl_se->dl_runtime)
+		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
 void dl_server_start(struct sched_dl_entity *dl_se)
@@ -1431,6 +1624,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 		dl_se->dl_period = 1000 * NSEC_PER_MSEC;
 
 		dl_se->dl_server = 1;
+		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
 	}
 
@@ -1448,6 +1642,9 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 		return;
 
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+	hrtimer_try_to_cancel(&dl_se->dl_timer);
+	dl_se->dl_defer_armed = 0;
+	dl_se->dl_throttled = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -1759,7 +1956,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	 * be counted in the active utilization; hence, we need to call
 	 * add_running_bw().
 	 */
-	if (dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
+	if (!dl_se->dl_defer && dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
 		if (flags & ENQUEUE_WAKEUP)
 			task_contending(dl_se, flags);
 
@@ -1781,6 +1978,25 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 		setup_new_dl_entity(dl_se);
 	}
 
+	/*
+	 * If the reservation is still throttled, e.g., it got replenished but is a
+	 * deferred task and still got to wait, don't enqueue.
+	 */
+	if (dl_se->dl_throttled && start_dl_timer(dl_se))
+		return;
+
+	/*
+	 * We're about to enqueue, make sure we're not ->dl_throttled!
+	 * In case the timer was not started, say because the defer time
+	 * has passed, mark as not throttled and mark unarmed.
+	 * Also cancel earlier timers, since letting those run is pointless.
+	 */
+	if (dl_se->dl_throttled) {
+		hrtimer_try_to_cancel(&dl_se->dl_timer);
+		dl_se->dl_defer_armed = 0;
+		dl_se->dl_throttled = 0;
+	}
+
 	__enqueue_dl_entity(dl_se);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 304697a80e9e..fdeb4a61575c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1156,12 +1156,13 @@ s64 update_curr_common(struct rq *rq)
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
+	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
 
 	if (unlikely(!curr))
 		return;
 
-	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
+	delta_exec = update_curr_se(rq, curr);
 	if (unlikely(delta_exec <= 0))
 		return;
 
@@ -1169,8 +1170,19 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
-	if (entity_is_task(curr))
-		update_curr_task(task_of(curr), delta_exec);
+	if (entity_is_task(curr)) {
+		struct task_struct *p = task_of(curr);
+
+		update_curr_task(p, delta_exec);
+
+		/*
+		 * Any fair task that runs outside of fair_server should
+		 * account against fair_server such that it can account for
+		 * this time and possibly avoid running this period.
+		 */
+		if (p->dl_server != &rq->fair_server)
+			dl_server_update(&rq->fair_server, delta_exec);
+	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
@@ -6722,8 +6734,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
-	if (!rq->cfs.h_nr_running)
+	if (!rq->cfs.h_nr_running) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr);
 		dl_server_start(&rq->fair_server);
+	}
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6135fbe83d68..5f8806bc6924 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -458,12 +458,14 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
+	dl_server_update_idle_time(rq, prev);
 }
 
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	next->se.exec_start = rq_clock_task(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 205e56929e15..e70e17be83c3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -312,7 +312,7 @@ extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int  dl_bw_check_overflow(int cpu);
-
+extern s64 dl_scalled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec);
 /*
  * SCHED_DEADLINE supports servers (nested scheduling) with the following
  * interface:
@@ -340,6 +340,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void dl_server_update_idle_time(struct rq *rq,
+		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
 
 #ifdef CONFIG_CGROUP_SCHED
-- 
2.44.0


