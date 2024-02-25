Return-Path: <linux-kernel+bounces-80340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD47862D82
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC9C1C212B3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD861F95F;
	Sun, 25 Feb 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVwZkeMs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797761BF35
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901742; cv=none; b=gtgw/R6fbm3nGA8djoahxscpc1IvwcGf2H140vVdR9dTP3lhw1F6NDkkLEqykZbrcDUXikgMgyDgbsQeSZSF0EQpsStq8Y/ccSCc4RD/HwmcQCFkLe7oQVdhBCu3A+EvIhLqk/vSjk+SGxU7PGqOfph/8LxydQkT0Wn6YDReODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901742; c=relaxed/simple;
	bh=9i+6LrQeoWXgQOQr/7C+jReFscj2yOzZY2cAKOTq+14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmJvVCh8C8QQgpvJ9Hkp4wHkTQBi8Dv8N4Ghsvca+u3MWxzRtf0/xZeoHBDrnER2Qm1zNa5Rww1k2swBQqkTWf2bp7kXTQKFI3ZzYoNw/bzgVrPSZA9vRHupMsLt/LQwOQ1SsCgB9x53GerMMsx1MH5PvsGFxKfT44BOrTiB83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVwZkeMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1BEC433C7;
	Sun, 25 Feb 2024 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901742;
	bh=9i+6LrQeoWXgQOQr/7C+jReFscj2yOzZY2cAKOTq+14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VVwZkeMsb7A/3ki85CSFzmoP7osV+sScdBpSFfRw6LhcJL4CF8gwEijrOOygciyQh
	 XI/heK/npidAx6ccy5RZ9oM11kiQr7V+RjhDaTPsm3G+cYhmcaCfLma8bcTDa/e8ZQ
	 Wdsl2UvcklxV0bGVEL6yfGHCVJmDZPWcdUbZAo4sRCCzzledLJFCiUepVfOKsI4Jr5
	 04PLo5XgcTDi5z4/dU29SMQqGEU6gUt1iVO54ywQhchWXDsa4PYETT0G91gjkAE2+X
	 dhYDrW6qmoC+9K+7l1wcX4+1AnOIUP5TQnr//s0J+UiR1Rjr5KJdEKJN0YkN2yvdn7
	 BX2yLRgiccZ5g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 13/16] tick: Split nohz and highres features from nohz_mode
Date: Sun, 25 Feb 2024 23:55:05 +0100
Message-ID: <20240225225508.11587-14-frederic@kernel.org>
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

The nohz mode field tells about low resolution nohz mode or high
resolution nohz mode but it doesn't tell about high resolution non-nohz
mode.

In order to retrieve the latter state, tick_cancel_sched_timer() must
fiddle with struct hrtimer's internals to guess if the tick has been
initialized in high resolution.

Move instead the nohz mode field information into the tick flags and
provide two new bits: one to know if the tick is in nohz mode and
another one to know if the tick is in high resolution. The combination
of those two flags provides all the needed informations to determine
which of the three tick modes is running.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/hrtimer.c    |  2 +-
 kernel/time/tick-sched.c | 32 +++++++++++++++++---------------
 kernel/time/tick-sched.h | 13 +++++--------
 kernel/time/timer_list.c |  5 +++--
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3e95474199ac..70625dff62ce 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -747,7 +747,7 @@ static void hrtimer_switch_to_hres(void)
 	base->hres_active = 1;
 	hrtimer_resolution = HIGH_RES_NSEC;
 
-	tick_setup_sched_timer(NOHZ_MODE_HIGHRES);
+	tick_setup_sched_timer(true);
 	/* "Retrigger" the interrupt to get things going */
 	retrigger_next_event(NULL);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4aa7ce04a72c..dcb9f0394182 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -831,7 +831,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 	/* Forward the time to expire in the future */
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 
-	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES)) {
 		hrtimer_start_expires(&ts->sched_timer,
 				      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
@@ -1040,14 +1040,14 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * the tick timer.
 	 */
 	if (unlikely(expires == KTIME_MAX)) {
-		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
+		if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
 			hrtimer_cancel(&ts->sched_timer);
 		else
 			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
-	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES)) {
 		hrtimer_start(&ts->sched_timer, expires,
 			      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
@@ -1108,7 +1108,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	if (!tick_nohz_full_cpu(smp_processor_id()))
 		return;
 
-	if (ts->nohz_mode == NOHZ_MODE_INACTIVE)
+	if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
 		return;
 
 	__tick_nohz_full_update_tick(ts, ktime_get());
@@ -1168,7 +1168,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		return false;
 	}
 
-	if (unlikely(ts->nohz_mode == NOHZ_MODE_INACTIVE))
+	if (unlikely(!tick_sched_flag_test(ts, TS_FLAG_NOHZ)))
 		return false;
 
 	if (need_resched())
@@ -1487,11 +1487,11 @@ static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
-static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
+static inline void tick_nohz_activate(struct tick_sched *ts)
 {
 	if (!tick_nohz_enabled)
 		return;
-	ts->nohz_mode = mode;
+	tick_sched_flag_set(ts, TS_FLAG_NOHZ);
 	/* One update is enough */
 	if (!test_and_set_bit(0, &tick_nohz_active))
 		timers_update_nohz();
@@ -1512,7 +1512,7 @@ static void tick_nohz_switch_to_nohz(void)
 	 * Recycle the hrtimer in 'ts', so we can share the
 	 * highres code.
 	 */
-	tick_setup_sched_timer(NOHZ_MODE_LOWRES);
+	tick_setup_sched_timer(false);
 }
 
 static inline void tick_nohz_irq_enter(void)
@@ -1540,7 +1540,7 @@ static inline void tick_nohz_irq_enter(void)
 
 static inline void tick_nohz_switch_to_nohz(void) { }
 static inline void tick_nohz_irq_enter(void) { }
-static inline void tick_nohz_activate(struct tick_sched *ts, int mode) { }
+static inline void tick_nohz_activate(struct tick_sched *ts) { }
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
@@ -1567,15 +1567,17 @@ early_param("skew_tick", skew_tick);
  * tick_setup_sched_timer - setup the tick emulation timer
  * @mode: tick_nohz_mode to setup for
  */
-void tick_setup_sched_timer(int mode)
+void tick_setup_sched_timer(bool hrtimer)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer) {
+		tick_sched_flag_set(ts, TS_FLAG_HIGHRES);
 		ts->sched_timer.function = tick_nohz_handler;
+	}
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
@@ -1589,11 +1591,11 @@ void tick_setup_sched_timer(int mode)
 	}
 
 	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer)
 		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	else
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	tick_nohz_activate(ts, mode);
+	tick_nohz_activate(ts);
 }
 
 void tick_cancel_sched_timer(int cpu)
@@ -1602,7 +1604,7 @@ void tick_cancel_sched_timer(int cpu)
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
 
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && ts->sched_timer.base)
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
 		hrtimer_cancel(&ts->sched_timer);
 
 	idle_sleeptime = ts->idle_sleeptime;
@@ -1652,7 +1654,7 @@ int tick_check_oneshot_change(int allow_nohz)
 	if (!test_and_clear_bit(0, &ts->check_clocks))
 		return 0;
 
-	if (ts->nohz_mode != NOHZ_MODE_INACTIVE)
+	if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
 		return 0;
 
 	if (!timekeeping_valid_for_hres() || !tick_is_oneshot_available())
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 07a4c0144c47..bbe72a078985 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -14,12 +14,6 @@ struct tick_device {
 	enum tick_device_mode mode;
 };
 
-enum tick_nohz_mode {
-	NOHZ_MODE_INACTIVE,
-	NOHZ_MODE_LOWRES,
-	NOHZ_MODE_HIGHRES,
-};
-
 /* The CPU is in the tick idle mode */
 #define TS_FLAG_INIDLE		BIT(0)
 /* The idle tick has been stopped */
@@ -31,6 +25,10 @@ enum tick_nohz_mode {
 #define TS_FLAG_IDLE_ACTIVE	BIT(2)
 /* CPU was the last one doing do_timer before going idle */
 #define TS_FLAG_DO_TIMER_LAST	BIT(3)
+/* NO_HZ is enabled */
+#define TS_FLAG_NOHZ		BIT(4)
+/* High resolution tick mode */
+#define TS_FLAG_HIGHRES		BIT(5)
 
 /**
  * struct tick_sched - sched tick emulation and no idle tick control/stats
@@ -84,7 +82,6 @@ struct tick_sched {
 	ktime_t				idle_entrytime;
 
 	/* Tick stop */
-	enum tick_nohz_mode		nohz_mode;
 	unsigned long			last_jiffies;
 	u64				timer_expires_base;
 	u64				timer_expires;
@@ -107,7 +104,7 @@ struct tick_sched {
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
 
-extern void tick_setup_sched_timer(int mode);
+extern void tick_setup_sched_timer(bool hrtimer);
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 extern void tick_cancel_sched_timer(int cpu);
 #else
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 38f81d836fc5..1c311c46da50 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -152,7 +152,8 @@ static void print_cpu(struct seq_file *m, int cpu, u64 now)
 
 	{
 		struct tick_sched *ts = tick_get_tick_sched(cpu);
-		P(nohz_mode);
+		P_flag(nohz, TS_FLAG_NOHZ);
+		P_flag(highres, TS_FLAG_HIGHRES);
 		P_ns(last_tick);
 		P_flag(tick_stopped, TS_FLAG_STOPPED);
 		P(idle_jiffies);
@@ -259,7 +260,7 @@ static void timer_list_show_tickdevices_header(struct seq_file *m)
 
 static inline void timer_list_header(struct seq_file *m, u64 now)
 {
-	SEQ_printf(m, "Timer List Version: v0.9\n");
+	SEQ_printf(m, "Timer List Version: v0.10\n");
 	SEQ_printf(m, "HRTIMER_MAX_CLOCK_BASES: %d\n", HRTIMER_MAX_CLOCK_BASES);
 	SEQ_printf(m, "now at %Ld nsecs\n", (unsigned long long)now);
 	SEQ_printf(m, "\n");
-- 
2.43.0


