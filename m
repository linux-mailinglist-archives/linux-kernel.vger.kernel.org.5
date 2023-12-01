Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167508006E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378159AbjLAJ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378084AbjLAJ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69138173A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:18 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDkZ99bgjbwfcazN7cvP/yxsFnqYGi5j6mcGkkMlXpc=;
        b=i5sS1zVbA72IjyBXtjc3SlWfoRyosMorQZH3qX/weLjOiNry7I/7+4ZgkwI7rmOt1p/UXO
        3ww8mo0MOUqO+0Diq1FG02gACn2a5p8pLaKx4fFpd3Yawe9JQAKrWl12KLbQwY1IMXXpAh
        5W45BtdaHxyhbNgs8peW4ql2RF8W+ZB6yl2g9nfSMXzk+zG6IaY0ToMyTnMmUuM/iuz3mQ
        bqLuNhAa5FwwvNfTHeMY4zkeaW0719YMrlCGBsafijBw499DvJ87pFui7vqLqhZttIzHFJ
        rv22HaG2jZbCCvq2dWwD47XGS1nPvy+Bj4UvuGISVk33iYxk+xxsOgkyHOJrtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDkZ99bgjbwfcazN7cvP/yxsFnqYGi5j6mcGkkMlXpc=;
        b=pmacNEm05CQnWjnwz89fRs+iAO6fnmS1N9jqQgq915NFXVkq+NFsHJgid3bh8sVzGv0A5B
        dpET6y0V972a7nCA==
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
Subject: [PATCH v9 15/32] timers: Move marking timer bases idle into tick_nohz_stop_tick()
Date:   Fri,  1 Dec 2023 10:26:37 +0100
Message-Id: <20231201092654.34614-16-anna-maria@linutronix.de>
In-Reply-To: <20231201092654.34614-1-anna-maria@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
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

The timer base is marked idle when get_next_timer_interrupt() is
executed. But the decision whether the tick will be stopped and whether the
system is able to go idle is done later. When the timer bases is marked
idle and a new first timer is enqueued remote an IPI is raised. Even if it
is not required because the tick is not stopped and the timer base is
evaluated again at the next tick.

To prevent this, the timer base is marked idle in tick_nohz_stop_tick() and
get_next_timer_interrupt() is streamlined by only looking for the next
timer interrupt. All other work is postponed to
timer_base_try_to_set_idle() which is called by tick_nohz_stop_tick().

While at it fix some nearby whitespace damage as well.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9:
    - update to the changes of the patch before
    - Cleanup logic in tick_nohz_stop_tick() after executing timer_base_try_to_set_idle()
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 46 ++++++++++++++++++++++++++---------
 kernel/time/timer.c         | 48 ++++++++++++++++++++++++++++---------
 3 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 649f2b48e8f0..dc12a938f00f 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -164,6 +164,7 @@ static inline void timers_update_nohz(void) { }
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
+u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle);
 void timer_clear_idle(void);
 
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b1b591de781e..3e1cdb7c6966 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -849,11 +849,6 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 */
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
@@ -889,12 +884,41 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
+	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
-	u64 expires = ts->timer_expires;
+	bool timer_idle;
+	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
 	ts->timer_expires_base = 0;
 
+	/*
+	 * Now the tick should be stopped definitely - so the timer base needs
+	 * to be marked idle as well to not miss a newly queued timer.
+	 */
+	expires = timer_base_try_to_set_idle(basejiff, basemono, &timer_idle);
+	if (!timer_idle) {
+		/*
+		 * Do not clear tick_stopped here when it was already set - it
+		 * will be retained on the next idle iteration when the tick
+		 * expired earlier than expected.
+		 */
+		expires = basemono + TICK_NSEC;
+	} else if (expires > ts->timer_expires) {
+		/*
+		 * This path could only happen when the first timer was removed
+		 * between calculating the possible sleep length and now (when
+		 * high resolution mode is not active, timer could also be a
+		 * hrtimer).
+		 *
+		 * We have to stick to the original calculated expiry value to
+		 * not stop the tick for too long with a shallow C-state (which
+		 * was programmed by cpuidle because of an early next expiration
+		 * value).
+		 */
+		expires = ts->timer_expires;
+	}
+
 	/*
 	 * If this CPU is the one which updates jiffies, then give up
 	 * the assignment and let it be taken by the CPU which runs
@@ -930,6 +954,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * in tick_nohz_restart_sched_tick().
 	 */
 	if (!ts->tick_stopped) {
+		/* If the timer base is not idle, retain the tick. */
+		if (!timer_idle)
+			return;
+
 		calc_load_nohz_start();
 		quiet_vmstat();
 
@@ -991,7 +1019,7 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	touch_softlockup_watchdog_sched();
 
 	/* Cancel the scheduled timer and restore the tick: */
-	ts->tick_stopped  = 0;
+	ts->tick_stopped = 0;
 	tick_nohz_restart(ts, now);
 }
 
@@ -1147,10 +1175,6 @@ void tick_nohz_idle_stop_tick(void)
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
index c9f7f86e95fd..df6558f62e6f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1911,7 +1911,8 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
-static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
+					     bool *idle)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
@@ -1921,8 +1922,11 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
 	 * Pretend that there is no timer pending if the cpu is offline.
 	 * Possible pending timers will be migrated later to an active cpu.
 	 */
-	if (cpu_is_offline(smp_processor_id()))
+	if (cpu_is_offline(smp_processor_id())) {
+		if (idle)
+			*idle = true;
 		return expires;
+	}
 
 	raw_spin_lock(&base->lock);
 	if (base->next_expiry_recalc)
@@ -1952,16 +1956,24 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
 	__forward_timer_base(base, basej);
 
 	/*
-	 * Base is idle if the next event is more than a tick away.
-	 *
-	 * If the base is marked idle then any timer add operation must forward
-	 * the base clk itself to keep granularity small. This idle logic is
-	 * only maintained for the BASE_STD base, deferrable timers may still
-	 * see large granularity skew (by design).
+	 * Set base->is_idle only when caller is timer_base_try_to_set_idle()
 	 */
-	base->is_idle = time_after(nextevt, basej + 1);
+	if (idle) {
+		/*
+		 * Base is idle if the next event is more than a tick away.
+		 *
+		 * If the base is marked idle then any timer add operation must
+		 * forward the base clk itself to keep granularity small. This
+		 * idle logic is only maintained for the BASE_STD base,
+		 * deferrable timers may still see large granularity skew (by
+		 * design).
+		 */
+		if (!base->is_idle)
+			base->is_idle = time_after(nextevt, basej + 1);
+		*idle = base->is_idle;
+		trace_timer_base_idle(base->is_idle, base->cpu);
+	}
 
-	trace_timer_base_idle(base->is_idle, base->cpu);
 	raw_spin_unlock(&base->lock);
 
 	return cmp_next_hrtimer_event(basem, expires);
@@ -1977,7 +1989,21 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
  */
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
-	return __get_next_timer_interrupt(basej, basem);
+	return __get_next_timer_interrupt(basej, basem, NULL);
+}
+
+/**
+ * timer_base_try_to_set_idle() - Try to set the idle state of the timer bases
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @idle:	pointer to store the value of timer_base->is_idle
+ *
+ * Returns the tick aligned clock monotonic time of the next pending
+ * timer or KTIME_MAX if no timer is pending.
+ */
+u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
+{
+	return __get_next_timer_interrupt(basej, basem, idle);
 }
 
 /**
-- 
2.39.2

