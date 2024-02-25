Return-Path: <linux-kernel+bounces-80339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388A5862D81
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6971C21332
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6D1BDEB;
	Sun, 25 Feb 2024 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6krpi+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C711BC56
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901740; cv=none; b=YJVGOhGi6xKq8xSqHo0ijVHQshI2housgARkpfsPPhf7LD55Awj5tkNw9rYkHab250oF2U5jTcjdlLnudRSK1+diQ529q0YkFKLqeu9RrnK51lq6ygknywJQ1pfpwX0dTxKT18WtaVXJhTIhQ71tvTUnnLODR2k4YOwXTkCksYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901740; c=relaxed/simple;
	bh=nvq+0+c2VgwiAV9LLQoQtr7r3jeFHn9GHHJ6M6acVz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6TlCy9suLfSO848apWqmaiQcaYUnPWNAhnPIvdt23MJUZlzDuGOyRD4uNjXoiFcx20qMN5EBy7bAsrhwRQalwuP1Pdu9vpFvnCF0tyHKio2tbihKgi94zOPicS5nhVrSNvO6rJ2a+Kj6P4DxMb5sdQfECg9uncnF1QlWEUxqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6krpi+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034E8C433F1;
	Sun, 25 Feb 2024 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901739;
	bh=nvq+0+c2VgwiAV9LLQoQtr7r3jeFHn9GHHJ6M6acVz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6krpi+uTj30i1AM6Rhbq+0CRl7L0VL/A7HfIV6qZMm2zKgnIsJZIZwWX8sBxdFDe
	 /SchY+1KCq3xwPRU+MdxtC29L4XU2ixQ6CmNqm/3FvlgM2ahlin5TdfgKY5Vu7ijCO
	 0p96bXCwmFcKNwohle9F1RJumyTXA5/nO5ii7/lUrAI2fT/fPr85cUk0OPCLELQP/j
	 uulL0wGCgBQcNZ6guTrpQ7G6Xs5Mo8k3A6W4UUy6f+XvSm/bImrAxU1FeDTPlcciGJ
	 U7h0XbtvzphlbHMP+WHOljIFpUwnYkU1wr1Akl+78T0BXuAu5IJE+BNy1fLlaTsBOx
	 SXti2G3vnDyFQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 12/16] tick: Move individual bit features to debuggable mask accesses
Date: Sun, 25 Feb 2024 23:55:04 +0100
Message-ID: <20240225225508.11587-13-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225225508.11587-1-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The individual bitfields of struct tick_sched must be modified from
IRQs disabled places, otherwise local modifications can race due to them
sharing the same memory storage.

The recent move of the "got_idle_tick" bitfield to its own storage shows
that the use of these bitfields, as pretty as they look, can be as much
error prone.

In order to avoid future issues of the like and make sure that those
bitfields are safely accessed, move those flags to an explicit mask
along with a mutator function performing the basic IRQs disabled sanity
check.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 88 +++++++++++++++++++++++++---------------
 kernel/time/tick-sched.h | 23 +++++++----
 kernel/time/timer_list.c |  5 ++-
 3 files changed, 73 insertions(+), 43 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b79f5403433b..4aa7ce04a72c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -180,6 +180,26 @@ static ktime_t tick_init_jiffy_update(void)
 	return period;
 }
 
+static inline int tick_sched_flag_test(struct tick_sched *ts,
+				       unsigned long flag)
+{
+	return !!(ts->flags & flag);
+}
+
+static inline void tick_sched_flag_set(struct tick_sched *ts,
+				       unsigned long flag)
+{
+	lockdep_assert_irqs_disabled();
+	ts->flags |= flag;
+}
+
+static inline void tick_sched_flag_clear(struct tick_sched *ts,
+					 unsigned long flag)
+{
+	lockdep_assert_irqs_disabled();
+	ts->flags &= ~flag;
+}
+
 #define MAX_STALLED_JIFFIES 5
 
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
@@ -223,7 +243,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 		}
 	}
 
-	if (ts->inidle)
+	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE))
 		ts->got_idle_tick = 1;
 }
 
@@ -237,7 +257,8 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 	 * idle" jiffy stamp so the idle accounting adjustment we do
 	 * when we go busy again does not account too many ticks.
 	 */
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && ts->tick_stopped) {
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) &&
+	    tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		touch_softlockup_watchdog_sched();
 		if (is_idle_task(current))
 			ts->idle_jiffies++;
@@ -279,7 +300,7 @@ static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
 	 * - to the idle task if in dynticks-idle
 	 * - to IRQ exit if in full-dynticks.
 	 */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(tick_sched_flag_test(ts, TS_FLAG_STOPPED)))
 		return HRTIMER_NORESTART;
 
 	hrtimer_forward(timer, now, TICK_NSEC);
@@ -559,7 +580,7 @@ void __tick_nohz_task_switch(void)
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (ts->tick_stopped) {
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		if (atomic_read(&current->tick_dep_mask) ||
 		    atomic_read(&current->signal->tick_dep_mask))
 			tick_nohz_full_kick();
@@ -656,14 +677,14 @@ bool tick_nohz_tick_stopped(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	return ts->tick_stopped;
+	return tick_sched_flag_test(ts, TS_FLAG_STOPPED);
 }
 
 bool tick_nohz_tick_stopped_cpu(int cpu)
 {
 	struct tick_sched *ts = per_cpu_ptr(&tick_cpu_sched, cpu);
 
-	return ts->tick_stopped;
+	return tick_sched_flag_test(ts, TS_FLAG_STOPPED);
 }
 
 /**
@@ -693,7 +714,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 {
 	ktime_t delta;
 
-	if (WARN_ON_ONCE(!ts->idle_active))
+	if (WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)))
 		return;
 
 	delta = ktime_sub(now, ts->idle_entrytime);
@@ -705,7 +726,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
 
 	ts->idle_entrytime = now;
-	ts->idle_active = 0;
+	tick_sched_flag_clear(ts, TS_FLAG_IDLE_ACTIVE);
 	write_seqcount_end(&ts->idle_sleeptime_seq);
 
 	sched_clock_idle_wakeup_event();
@@ -715,7 +736,7 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
 {
 	write_seqcount_begin(&ts->idle_sleeptime_seq);
 	ts->idle_entrytime = ktime_get();
-	ts->idle_active = 1;
+	tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
 	write_seqcount_end(&ts->idle_sleeptime_seq);
 
 	sched_clock_idle_sleep_event();
@@ -737,7 +758,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
 	do {
 		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
 
-		if (ts->idle_active && compute_delta) {
+		if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE) && compute_delta) {
 			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
 
 			idle = ktime_add(*sleeptime, delta);
@@ -905,7 +926,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		 * We've not stopped the tick yet, and there's a timer in the
 		 * next period, so no point in stopping it either, bail.
 		 */
-		if (!ts->tick_stopped) {
+		if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 			ts->timer_expires = 0;
 			goto out;
 		}
@@ -918,7 +939,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 */
 	delta = timekeeping_max_deferment();
 	if (cpu != tick_do_timer_cpu &&
-	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE || !ts->do_timer_last))
+	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE ||
+	     !tick_sched_flag_test(ts, TS_FLAG_DO_TIMER_LAST)))
 		delta = KTIME_MAX;
 
 	/* Calculate the next expiry time */
@@ -938,7 +960,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
-	bool timer_idle = ts->tick_stopped;
+	bool timer_idle = tick_sched_flag_test(ts, TS_FLAG_STOPPED);
 	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
@@ -978,13 +1000,13 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 */
 	if (cpu == tick_do_timer_cpu) {
 		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-		ts->do_timer_last = 1;
+		tick_sched_flag_set(ts, TS_FLAG_DO_TIMER_LAST);
 	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
-		ts->do_timer_last = 0;
+		tick_sched_flag_clear(ts, TS_FLAG_DO_TIMER_LAST);
 	}
 
 	/* Skip reprogram of event if it's not changed */
-	if (ts->tick_stopped && (expires == ts->next_tick)) {
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED) && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
 		if (expires == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
 			return;
@@ -1002,12 +1024,12 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * call we save the current tick time, so we can restart the
 	 * scheduler tick in tick_nohz_restart_sched_tick().
 	 */
-	if (!ts->tick_stopped) {
+	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		calc_load_nohz_start();
 		quiet_vmstat();
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
-		ts->tick_stopped = 1;
+		tick_sched_flag_set(ts, TS_FLAG_STOPPED);
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
 
@@ -1064,7 +1086,7 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	touch_softlockup_watchdog_sched();
 
 	/* Cancel the scheduled timer and restore the tick: */
-	ts->tick_stopped = 0;
+	tick_sched_flag_clear(ts, TS_FLAG_STOPPED);
 	tick_nohz_restart(ts, now);
 }
 
@@ -1076,7 +1098,7 @@ static void __tick_nohz_full_update_tick(struct tick_sched *ts,
 
 	if (can_stop_full_tick(cpu, ts))
 		tick_nohz_full_stop_tick(ts, cpu);
-	else if (ts->tick_stopped)
+	else if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
 		tick_nohz_restart_sched_tick(ts, now);
 #endif
 }
@@ -1196,14 +1218,14 @@ void tick_nohz_idle_stop_tick(void)
 	ts->idle_calls++;
 
 	if (expires > 0LL) {
-		int was_stopped = ts->tick_stopped;
+		int was_stopped = tick_sched_flag_test(ts, TS_FLAG_STOPPED);
 
 		tick_nohz_stop_tick(ts, cpu);
 
 		ts->idle_sleeps++;
 		ts->idle_expires = expires;
 
-		if (!was_stopped && ts->tick_stopped) {
+		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 			ts->idle_jiffies = ts->last_jiffies;
 			nohz_balance_enter_idle(cpu);
 		}
@@ -1234,7 +1256,7 @@ void tick_nohz_idle_enter(void)
 
 	WARN_ON_ONCE(ts->timer_expires_base);
 
-	ts->inidle = 1;
+	tick_sched_flag_set(ts, TS_FLAG_INIDLE);
 	tick_nohz_start_idle(ts);
 
 	local_irq_enable();
@@ -1263,7 +1285,7 @@ void tick_nohz_irq_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (ts->inidle)
+	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE))
 		tick_nohz_start_idle(ts);
 	else
 		tick_nohz_full_update_tick(ts);
@@ -1317,7 +1339,7 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	ktime_t now = ts->idle_entrytime;
 	ktime_t next_event;
 
-	WARN_ON_ONCE(!ts->inidle);
+	WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_INIDLE));
 
 	*delta_next = ktime_sub(dev->next_event, now);
 
@@ -1389,7 +1411,7 @@ void tick_nohz_idle_restart_tick(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (ts->tick_stopped) {
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		ktime_t now = ktime_get();
 		tick_nohz_restart_sched_tick(ts, now);
 		tick_nohz_account_idle_time(ts, now);
@@ -1430,12 +1452,12 @@ void tick_nohz_idle_exit(void)
 
 	local_irq_disable();
 
-	WARN_ON_ONCE(!ts->inidle);
+	WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_INIDLE));
 	WARN_ON_ONCE(ts->timer_expires_base);
 
-	ts->inidle = 0;
-	idle_active = ts->idle_active;
-	tick_stopped = ts->tick_stopped;
+	tick_sched_flag_clear(ts, TS_FLAG_INIDLE);
+	idle_active = tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE);
+	tick_stopped = tick_sched_flag_test(ts, TS_FLAG_STOPPED);
 
 	if (idle_active || tick_stopped)
 		now = ktime_get();
@@ -1498,10 +1520,10 @@ static inline void tick_nohz_irq_enter(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now;
 
-	if (!ts->idle_active && !ts->tick_stopped)
+	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED | TS_FLAG_IDLE_ACTIVE))
 		return;
 	now = ktime_get();
-	if (ts->idle_active)
+	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE))
 		tick_nohz_stop_idle(ts, now);
 	/*
 	 * If all CPUs are idle we may need to update a stale jiffies value.
@@ -1510,7 +1532,7 @@ static inline void tick_nohz_irq_enter(void)
 	 * rare case (typically stop machine). So we must make sure we have a
 	 * last resort.
 	 */
-	if (ts->tick_stopped)
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
 		tick_nohz_update_jiffies(now);
 }
 
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 3b555e0fa937..07a4c0144c47 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -20,14 +20,22 @@ enum tick_nohz_mode {
 	NOHZ_MODE_HIGHRES,
 };
 
+/* The CPU is in the tick idle mode */
+#define TS_FLAG_INIDLE		BIT(0)
+/* The idle tick has been stopped */
+#define TS_FLAG_STOPPED		BIT(1)
+/*
+ * Indicator that the CPU is actively in the tick idle mode;
+ * it is reset during irq handling phases.
+ */
+#define TS_FLAG_IDLE_ACTIVE	BIT(2)
+/* CPU was the last one doing do_timer before going idle */
+#define TS_FLAG_DO_TIMER_LAST	BIT(3)
+
 /**
  * struct tick_sched - sched tick emulation and no idle tick control/stats
  *
- * @inidle:		Indicator that the CPU is in the tick idle mode
- * @tick_stopped:	Indicator that the idle tick has been stopped
- * @idle_active:	Indicator that the CPU is actively in the tick idle mode;
- *			it is reset during irq handling phases.
- * @do_timer_last:	CPU was the last one doing do_timer before going idle
+ * @flags:		State flags gathering the TS_FLAG_* features
  * @got_idle_tick:	Tick timer function has run with @inidle set
  * @stalled_jiffies:	Number of stalled jiffies detected across ticks
  * @last_tick_jiffies:	Value of jiffies seen on last tick
@@ -57,10 +65,7 @@ enum tick_nohz_mode {
  */
 struct tick_sched {
 	/* Common flags */
-	unsigned int			inidle		: 1;
-	unsigned int			tick_stopped	: 1;
-	unsigned int			idle_active	: 1;
-	unsigned int			do_timer_last	: 1;
+	unsigned long			flags;
 
 	/* Tick handling: jiffies stall check */
 	unsigned int			stalled_jiffies;
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index ed7d6ad694fb..38f81d836fc5 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -147,11 +147,14 @@ static void print_cpu(struct seq_file *m, int cpu, u64 now)
 # define P_ns(x) \
 	SEQ_printf(m, "  .%-15s: %Lu nsecs\n", #x, \
 		   (unsigned long long)(ktime_to_ns(ts->x)))
+# define P_flag(x, f)			    \
+	SEQ_printf(m, "  .%-15s: %d\n", #x, !!(ts->flags & (f)))
+
 	{
 		struct tick_sched *ts = tick_get_tick_sched(cpu);
 		P(nohz_mode);
 		P_ns(last_tick);
-		P(tick_stopped);
+		P_flag(tick_stopped, TS_FLAG_STOPPED);
 		P(idle_jiffies);
 		P(idle_calls);
 		P(idle_sleeps);
-- 
2.43.0


