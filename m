Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDAF7E0EE4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjKDLAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjKDLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:00:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5040FD47
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 03:59:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262C1C433D9;
        Sat,  4 Nov 2023 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699095598;
        bh=/tkdPd8l0zJh8Zr2pNqa5tEoVWnxLX29JBambo76CEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjb/OjO7mznWTe5H4GTk+cTznokt0oUlIksqNNSmLg2EnlRMNibQRq5R7IqXCHHn6
         UNBjdrT56oh9Kw5n8kBphlQLB4gyaTK/vuB0pEUvrkwesB4OdSQIgbvuDcVOFlSvpF
         fyQGKK5ieWK5Ig5Gs5IXz1wPFhYNKjy9EeXfIWquJBqrrVgjxSqfq9zt5H9Lt8w/gu
         Oy4VrTW1ZA0k3ahJ6HL+RnrvE7L9VyQEL6bvMAZDUrFpF6FahqxNo9qU+CUJwm5j4h
         5EWukEndM3JjSRZ9SFQhe04CYTj/EhJyHUWse+WyFCgwnXEcMOkmKpOjc3bFHI2WlB
         4RPGbSWdcjFCw==
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
Subject: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Date:   Sat,  4 Nov 2023 11:59:23 +0100
Message-Id: <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1699095159.git.bristot@kernel.org>
References: <cover.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

By setting the zerolax option, the dl_server will dispatch an
SCHED_DEADLINE reservation with replenished runtime, but throttled.

The dl_timer will be set for (period - runtime) ns from start time.
Thus boosting the fair rq on its 0-laxity time with respect to
rt_rq.

If the fair scheduler has the opportunity to run while waiting
for zerolax time, the dl server runtime will be consumed. If
the runtime is completely consumed before the zerolax time, the
server will be replenished while still in a throttled state. Then,
the dl_timer will be reset to the new zerolax time

If the fair server reaches the zerolax time without consuming
its runtime, the server will be boosted, following CBS rules
(thus without breaking SCHED_DEADLINE).

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/sched.h   |   2 +
 kernel/sched/deadline.c | 100 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/fair.c     |   3 ++
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5ac1f252e136..56e53e6fd5a0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -660,6 +660,8 @@ struct sched_dl_entity {
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
 	unsigned int			dl_server         : 1;
+	unsigned int			dl_zerolax	  : 1;
+	unsigned int			dl_zerolax_armed  : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1d7b96ca9011..69ee1fbd60e4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -772,6 +772,14 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 	/* for non-boosted task, pi_of(dl_se) == dl_se */
 	dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
 	dl_se->runtime = pi_of(dl_se)->dl_runtime;
+
+	/*
+	 * If it is a zerolax reservation, throttle it.
+	 */
+	if (dl_se->dl_zerolax) {
+		dl_se->dl_throttled = 1;
+		dl_se->dl_zerolax_armed = 1;
+	}
 }
 
 /*
@@ -828,6 +836,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
  * could happen are, typically, a entity voluntarily trying to overcome its
  * runtime, or it just underestimated it during sched_setattr().
  */
+static int start_dl_timer(struct sched_dl_entity *dl_se);
 static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
@@ -874,6 +883,28 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 		dl_se->dl_yielded = 0;
 	if (dl_se->dl_throttled)
 		dl_se->dl_throttled = 0;
+
+	/*
+	 * If this is the replenishment of a zerolax reservation,
+	 * clear the flag and return.
+	 */
+	if (dl_se->dl_zerolax_armed) {
+		dl_se->dl_zerolax_armed = 0;
+		return;
+	}
+
+	/*
+	 * A this point, if the zerolax server is not armed, and the deadline
+	 * is in the future, throttle the server and arm the zerolax timer.
+	 */
+	if (dl_se->dl_zerolax &&
+	    dl_time_before(dl_se->deadline - dl_se->runtime, rq_clock(rq))) {
+		if (!is_dl_boosted(dl_se)) {
+			dl_se->dl_zerolax_armed = 1;
+			dl_se->dl_throttled = 1;
+			start_dl_timer(dl_se);
+		}
+	}
 }
 
 /*
@@ -1024,6 +1055,13 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 		}
 
 		replenish_dl_new_period(dl_se, rq);
+	} else if (dl_server(dl_se) && dl_se->dl_zerolax) {
+		/*
+		 * The server can still use its previous deadline, so throttle
+		 * and arm the zero-laxity timer.
+		 */
+		dl_se->dl_zerolax_armed = 1;
+		dl_se->dl_throttled = 1;
 	}
 }
 
@@ -1056,8 +1094,20 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
 	 * We want the timer to fire at the deadline, but considering
 	 * that it is actually coming from rq->clock and not from
 	 * hrtimer's time base reading.
+	 *
+	 * The zerolax reservation will have its timer set to the
+	 * deadline - runtime. At that point, the CBS rule will decide
+	 * if the current deadline can be used, or if a replenishment
+	 * is required to avoid add too much pressure on the system
+	 * (current u > U).
 	 */
-	act = ns_to_ktime(dl_next_period(dl_se));
+	if (dl_se->dl_zerolax_armed) {
+		WARN_ON_ONCE(!dl_se->dl_throttled);
+		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
+	} else {
+		act = ns_to_ktime(dl_next_period(dl_se));
+	}
+
 	now = hrtimer_cb_get_time(timer);
 	delta = ktime_to_ns(now) - rq_clock(rq);
 	act = ktime_add_ns(act, delta);
@@ -1333,6 +1383,9 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 		return;
 	}
 
+	if (dl_server(dl_se) && dl_se->dl_throttled && !dl_se->dl_zerolax)
+		return;
+
 	if (dl_entity_is_special(dl_se))
 		return;
 
@@ -1356,6 +1409,39 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 	dl_se->runtime -= scaled_delta_exec;
 
+	/*
+	 * The fair server can consume its runtime while throttled (not queued).
+	 *
+	 * If the server consumes its entire runtime in this state. The server
+	 * is not required for the current period. Thus, reset the server by
+	 * starting a new period, pushing the activation to the zero-lax time.
+	 */
+	if (dl_se->dl_zerolax && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
+		s64 runtime_diff = dl_se->runtime + dl_se->dl_runtime;
+
+		/*
+		 * If this is a regular throttling case, let it run negative until
+		 * the dl_runtime - runtime > 0. The reason being is that the next
+		 * replenishment will result in a positive runtime one period ahead.
+		 *
+		 * Otherwise, the deadline will be pushed more than one period, not
+		 * providing runtime/period anymore.
+		 *
+		 * If the dl_runtime - runtime < 0, then the server was able to get
+		 * the runtime/period before the replenishment. So it is safe
+		 * to start a new deffered period.
+		 */
+		if (!dl_se->dl_zerolax_armed && runtime_diff > 0)
+			return;
+
+		hrtimer_try_to_cancel(&dl_se->dl_timer);
+
+		replenish_dl_new_period(dl_se, dl_se->rq);
+		start_dl_timer(dl_se);
+
+		return;
+	}
+
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
 		dl_se->dl_throttled = 1;
@@ -1432,6 +1518,9 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+	hrtimer_try_to_cancel(&dl_se->dl_timer);
+	dl_se->dl_zerolax_armed = 0;
+	dl_se->dl_throttled = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -1743,7 +1832,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	 * be counted in the active utilization; hence, we need to call
 	 * add_running_bw().
 	 */
-	if (dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
+	if (!dl_se->dl_zerolax && dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
 		if (flags & ENQUEUE_WAKEUP)
 			task_contending(dl_se, flags);
 
@@ -1765,6 +1854,13 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 		setup_new_dl_entity(dl_se);
 	}
 
+	/*
+	 * If we are still throttled, eg. we got replenished but are a
+	 * zero-laxity task and still got to wait, don't enqueue.
+	 */
+	if (dl_se->dl_throttled && start_dl_timer(dl_se))
+		return;
+
 	__enqueue_dl_entity(dl_se);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b15f7f376a67..399237cd9f59 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1201,6 +1201,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		account_group_exec_runtime(curtask, delta_exec);
 		if (curtask->server)
 			dl_server_update(curtask->server, delta_exec);
+		else
+			dl_server_update(&rq_of(cfs_rq)->fair_server, delta_exec);
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
@@ -8421,6 +8423,7 @@ void fair_server_init(struct rq *rq)
 	dl_se->dl_runtime = 50 * NSEC_PER_MSEC;
 	dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
 	dl_se->dl_period = 1000 * NSEC_PER_MSEC;
+	dl_se->dl_zerolax = 1;
 
 	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
 }
-- 
2.40.1

