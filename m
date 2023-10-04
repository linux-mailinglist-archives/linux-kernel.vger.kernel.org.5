Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE37B7F4D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbjJDMgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbjJDMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C92D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:32 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/q/IZGOBCByN7ctkTK1opSNX4mw41Rp8Yoe6wCW+ls=;
        b=FITpH5ekOEGXTKWb7Cg4KxAfSZZE2dXVixEzf60S0AYTH3nxohwlUavh4JWd4m9+vAZc7t
        1rjGezjbE4F4PN3F1ri+Z/0bjUNeEFDICmwDUi79CIwWEiuTWZ9QCMPgilP+4a2dGvWF07
        xtbTKVF/vPyrsUrhcQnQzP1HAn7xigyeHFJfji/RRvV0prno/ZOHlcubVZsa0QzDR5OA2Y
        1mHICa1eHk4zQaTXbNyjTCa8VHddZJwo4+bireF9uJYjUeJAiOe1HOY7Sj/TymdSpA13Ff
        85dprfJgr1s0fodSnH5Y2v/NyFem+NGNigkRK85XgIFaCrP19to50jmvs7QnoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/q/IZGOBCByN7ctkTK1opSNX4mw41Rp8Yoe6wCW+ls=;
        b=XeBthWl1I+T1u+Bn4yFhNaK/Qe/v2Rp/zUka5bVHiTR+30a692II7ZDIy1CVk0ttgnqct6
        g0W9KupvEWd9E7AQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v8 10/25] timers: Move marking timer bases idle into tick_nohz_stop_tick()
Date:   Wed,  4 Oct 2023 14:34:39 +0200
Message-Id: <20231004123454.15691-11-anna-maria@linutronix.de>
In-Reply-To: <20231004123454.15691-1-anna-maria@linutronix.de>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer base is marked idle when get_next_timer_interrupt() is
executed. But the decision whether the tick will be stopped and whether the
system is able to go idle is done later. When the timer bases is marked
idle and a new first timer is enqueued remote an IPI is raised. Even if it
is not required because the tick is not stopped and the timer base is
evaluated again at the next tick.

To prevent this, the timer base is marked idle in tick_nohz_stop_tick() and
get_next_timer_interrupt() is streamlined by only looking for the next
timer interrupt. All other work is postponed to timer_set_idle() which is
called by tick_nohz_stop_tick().

While at it a whitespace damage is fixed as well.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 38 ++++++++++++++++++++++++-----------
 kernel/time/timer.c         | 40 +++++++++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 649f2b48e8f0..b035606a6f5e 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -164,6 +164,7 @@ static inline void timers_update_nohz(void) { }
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
+u64 timer_set_idle(unsigned long basej, u64 basem, bool *idle);
 void timer_clear_idle(void);
 
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b3cf535881a4..7e1fdbc6d5f0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -846,11 +846,6 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 
 	delta = next_tick - basemono;
 	if (delta <= (u64)TICK_NSEC) {
-		/*
-		 * Tell the timer code that the base is not idle, i.e. undo
-		 * the effect of get_next_timer_interrupt():
-		 */
-		timer_clear_idle();
 		/*
 		 * We've not stopped the tick yet, and there's a timer in the
 		 * next period, so no point in stopping it either, bail.
@@ -886,12 +881,35 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
+	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
-	u64 expires = ts->timer_expires;
+	bool timer_idle = ts->tick_stopped;
+	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
 	ts->timer_expires_base = 0;
 
+	/*
+	 * Now the tick should be stopped definitely - so timer base needs to be
+	 * marked idle as well to not miss a newly queued timer.
+	 */
+	expires = timer_set_idle(basejiff, basemono, &timer_idle);
+	if (!timer_idle) {
+		/*
+		 * Do not clear tick_stopped here when it was already set - it will
+		 * be retained on next idle iteration when tick expired earlier
+		 * than expected.
+		 */
+		expires = basemono + TICK_NSEC;
+
+		/* Undo the effect of timer_set_idle() */
+		timer_clear_idle();
+	} else if (expires < ts->timer_expires) {
+		ts->timer_expires = expires;
+	} else {
+		expires = ts->timer_expires;
+	}
+
 	/*
 	 * If this CPU is the one which updates jiffies, then give up
 	 * the assignment and let it be taken by the CPU which runs
@@ -926,7 +944,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * first call we save the current tick time, so we can restart
 	 * the scheduler tick in nohz_restart_sched_tick.
 	 */
-	if (!ts->tick_stopped) {
+	if (!ts->tick_stopped && timer_idle) {
 		calc_load_nohz_start();
 		quiet_vmstat();
 
@@ -989,7 +1007,7 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	/*
 	 * Cancel the scheduled timer and restore the tick
 	 */
-	ts->tick_stopped  = 0;
+	ts->tick_stopped = 0;
 	tick_nohz_restart(ts, now);
 }
 
@@ -1145,10 +1163,6 @@ void tick_nohz_idle_stop_tick(void)
 void tick_nohz_idle_retain_tick(void)
 {
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
-	/*
-	 * Undo the effect of get_next_timer_interrupt() called from
-	 * tick_nohz_next_event().
-	 */
 	timer_clear_idle();
 }
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f443aa807fbc..8518f7aa7319 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1950,6 +1950,40 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	if (cpu_is_offline(smp_processor_id()))
 		return expires;
 
+	raw_spin_lock(&base->lock);
+	nextevt = __get_next_timer_interrupt(basej, base);
+	raw_spin_unlock(&base->lock);
+
+	expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+
+	return cmp_next_hrtimer_event(basem, expires);
+}
+
+/**
+ * timer_set_idle - Set the idle state of the timer bases (if possible)
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @idle:	pointer to store the value of timer_base->in_idle
+ *
+ * Returns the next timer expiry.
+ *
+ * hrtimers are not taken into account once more, as they already have been
+ * taken into account when asking for the next timer expiry.
+ */
+u64 timer_set_idle(unsigned long basej, u64 basem, bool *idle)
+{
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	unsigned long nextevt;
+
+	/*
+	 * Pretend that there is no timer pending if the cpu is offline.
+	 * Possible pending timers will be migrated later to an active cpu.
+	 */
+	if (cpu_is_offline(smp_processor_id())) {
+		*idle = true;
+		return KTIME_MAX;
+	}
+
 	raw_spin_lock(&base->lock);
 	nextevt = __get_next_timer_interrupt(basej, base);
 
@@ -1966,13 +2000,11 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	 * maintained for the BASE_STD base, deferrable timers may still
 	 * see large granularity skew (by design).
 	 */
-	base->is_idle = time_after(nextevt, basej + 1);
+	base->is_idle = *idle = time_after(nextevt, basej + 1);
 
 	raw_spin_unlock(&base->lock);
 
-	expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
-
-	return cmp_next_hrtimer_event(basem, expires);
+	return basem + (u64)(nextevt - basej) * TICK_NSEC;
 }
 
 /**
-- 
2.39.2

