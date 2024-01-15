Return-Path: <linux-kernel+bounces-26099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBF082DB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A165D1C21B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804C6179B2;
	Mon, 15 Jan 2024 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W85lh00Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rwASbY7z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C791F17732
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cawu2qRxujfpAJkXtS4G5pM5Zis15l5+RosRC2CHij0=;
	b=W85lh00Z8Bd2TwnSXwhuTY7NxPs3Pbd0tRT8/E7ERMFhpeJOMKCEFl+agh81alVUlY95ZR
	Rf5eohvgqFiyP4Mu3j5y41QEJIxSNET9l/4PU4HMy7mgnL2Xh4fPKmgpsb3sIdHu/3l9wT
	2kfMA3WS3y7yji4FbFMuuUx1+aOyXmy2lPGFO81HWDa/sR0JL2JcY3DDp5vhFrj64ImSZg
	AazX2KiBDfv3KZl6v4TFxVjj1UnIRgSYEokDS2/1bk71nsfM0Y4BVZ6G3jNZJCWFnBsfNj
	W0M+YGjEiQ55WBxl33gPg9rT+2eaQpDmIP84MWG/34sjTAtZaYKcNvSkBLhkaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cawu2qRxujfpAJkXtS4G5pM5Zis15l5+RosRC2CHij0=;
	b=rwASbY7zJUfUnjudKyyiqJI4YgwJVGLnhdA9+Rn+0LHFic2vInNiDAfCkIVWw0hOj70W9b
	iGrWq4H2zN3z0VDg==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v10 03/20] timers: Move marking timer bases idle into tick_nohz_stop_tick()
Date: Mon, 15 Jan 2024 15:37:26 +0100
Message-Id: <20240115143743.27827-4-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 tick_nohz_stop_tick()

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

With this, tick_sched::tick_stopped and timer_base::is_idle is always in
sync. So there is no longer the need to execute timer_clear_idle() in
tick_nohz_idle_retain_tick(). This was required before, as
tick_nohz_next_event() set timer_base::is_idle even if the tick would not
be stopped. So timer_clear_idle() is only executed, when timer base is
idle. So the check whether timer base is idle, is now no longer required as
well.

While at it fix some nearby whitespace damage as well.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 47 +++++++++++++++++++++--------
 kernel/time/timer.c         | 60 ++++++++++++++++++++++++++-----------
 3 files changed, 78 insertions(+), 30 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 481b7ab65e2c..47df30b871e4 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -163,6 +163,7 @@ static inline void timers_update_nohz(void) { }
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
+u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle);
 void timer_clear_idle(void);
 
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a17d26002831..c6223afc801f 100644
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
 	 * scheduler tick in tick_nohz_restart_sched_tick().
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
 
@@ -1147,11 +1175,6 @@ void tick_nohz_idle_stop_tick(void)
 void tick_nohz_idle_retain_tick(void)
 {
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
-	/*
-	 * Undo the effect of get_next_timer_interrupt() called from
-	 * tick_nohz_next_event().
-	 */
-	timer_clear_idle();
 }
 
 /**
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2aea55d53416..3a668060692e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1911,19 +1911,22 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
-static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
+					     bool *idle)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
 	u64 expires = KTIME_MAX;
-	bool was_idle;
 
 	/*
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
@@ -1953,17 +1956,26 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
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
-	was_idle = base->is_idle;
-	base->is_idle = time_after(nextevt, basej + 1);
-	if (was_idle != base->is_idle)
-		trace_timer_base_idle(base->is_idle, base->cpu);
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
+		if (!base->is_idle) {
+			if (time_after(nextevt, basej + 1)) {
+				base->is_idle = true;
+				trace_timer_base_idle(true, base->cpu);
+			}
+		}
+		*idle = base->is_idle;
+	}
 
 	raw_spin_unlock(&base->lock);
 
@@ -1980,7 +1992,21 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
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
@@ -1998,10 +2024,8 @@ void timer_clear_idle(void)
 	 * sending the IPI a few instructions smaller for the cost of taking
 	 * the lock in the exit from idle path.
 	 */
-	if (base->is_idle) {
-		base->is_idle = false;
-		trace_timer_base_idle(false, smp_processor_id());
-	}
+	base->is_idle = false;
+	trace_timer_base_idle(false, smp_processor_id());
 }
 #endif
 
-- 
2.39.2


