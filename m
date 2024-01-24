Return-Path: <linux-kernel+bounces-37383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAE283AF29
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C80287CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82EF85C66;
	Wed, 24 Jan 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2DXBDkk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31D85C59
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115920; cv=none; b=OrZY4TSJLZiDsY+1DALORbwGqRorYtEnb3r3R6sKyMNXlYbyBCfGYupCe0foQklpW2gO9k1i1AKuNsR+PnJjdHojkEVycgCsaetIgnXIvsXEBYtytsJKEWwuilMiEw7VsK6rGuhvtHok5wDzA/4tabHqKft9D1b9jkifLzI1yS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115920; c=relaxed/simple;
	bh=BgMq2YElGqLaGH2mfhaxMYUEX5WNvbQSroN6VFODaUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IalOgNjtasWD1DB43W5r+kt/QylKxVnilNFmKQgf3b1YCyHR7LxHWyw681gwvLWTXjG1HeLygAd7X1W6O3st7st5X+gcGZJGPjwcUPvQBJ9Ii+4N6seE7ZwtoKy0dJMdrpMKZxME3zc8s4Q4U6K6yUk4GVixjKNm+emXDgwdQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2DXBDkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A3BC43399;
	Wed, 24 Jan 2024 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115919;
	bh=BgMq2YElGqLaGH2mfhaxMYUEX5WNvbQSroN6VFODaUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2DXBDkkZHJUQjzAm0QNqlFd12H10f2Q2r/mGZsLT8iKi3Ub0XjWZuzC7FH0rrCnh
	 32adMHW4RZOCOAxHK6ViN++qd/NtrGkisLdVDwKtlQlthEgxB7PFQNYsCiLnkh1pyV
	 pyObvs8UPCntxM2Pgqr7b+xiV3QoMjLFR7ad0EjUR9OQ3gR6yO9QFNNDEdNxJOL+SY
	 PlaiqImx2VUYI5P0DcCYa2CHtdPFIj7PyYmx+Ikqrl3e/Z60UzGGY9DDOT8q6orWpl
	 wyhIuFPlGwn/XhyFgJvRzZ2XfXGaYQFJmQK0+7q8H92U/Ws6fKw7+19gqNV8vUI3xE
	 WzkeXnHu9LXSw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 04/15] tick: Use IS_ENABLED() whenever possible
Date: Wed, 24 Jan 2024 18:04:48 +0100
Message-ID: <20240124170459.24850-5-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170459.24850-1-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid ifdeferry if it can be converted to IS_ENABLED() whenever possible

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-common.c |  4 +---
 kernel/time/tick-sched.c  | 14 +++++---------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index e9138cd7a0f5..0084e1ae2583 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -111,15 +111,13 @@ void tick_handle_periodic(struct clock_event_device *dev)
 
 	tick_periodic(cpu);
 
-#if defined(CONFIG_HIGH_RES_TIMERS) || defined(CONFIG_NO_HZ_COMMON)
 	/*
 	 * The cpu might have transitioned to HIGHRES or NOHZ mode via
 	 * update_process_times() -> run_local_timers() ->
 	 * hrtimer_run_queues().
 	 */
-	if (dev->event_handler != tick_handle_periodic)
+	if (IS_ENABLED(CONFIG_TICK_ONESHOT) && dev->event_handler != tick_handle_periodic)
 		return;
-#endif
 
 	if (!clockevent_state_oneshot(dev))
 		return;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 75385b9a233e..c311b7388685 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -186,7 +186,6 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
 
-#ifdef CONFIG_NO_HZ_COMMON
 	/*
 	 * Check if the do_timer duty was dropped. We don't care about
 	 * concurrency: This happens only when the CPU in charge went
@@ -197,13 +196,13 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * If nohz_full is enabled, this should not happen because the
 	 * 'tick_do_timer_cpu' CPU never relinquishes.
 	 */
-	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) &&
+	    unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
 		WARN_ON_ONCE(tick_nohz_full_running);
 #endif
 		tick_do_timer_cpu = cpu;
 	}
-#endif
 
 	/* Check if jiffies need an update */
 	if (tick_do_timer_cpu == cpu)
@@ -230,7 +229,6 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 
 static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 {
-#ifdef CONFIG_NO_HZ_COMMON
 	/*
 	 * When we are idle and the tick is stopped, we have to touch
 	 * the watchdog as we might not schedule for a really long
@@ -239,7 +237,7 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 	 * idle" jiffy stamp so the idle accounting adjustment we do
 	 * when we go busy again does not account too many ticks.
 	 */
-	if (ts->tick_stopped) {
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && ts->tick_stopped) {
 		touch_softlockup_watchdog_sched();
 		if (is_idle_task(current))
 			ts->idle_jiffies++;
@@ -250,7 +248,7 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 		 */
 		ts->next_tick = 0;
 	}
-#endif
+
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING);
 }
@@ -1551,10 +1549,8 @@ void tick_cancel_sched_timer(int cpu)
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t idle_sleeptime, iowait_sleeptime;
 
-# ifdef CONFIG_HIGH_RES_TIMERS
-	if (ts->sched_timer.base)
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
-# endif
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
-- 
2.43.0


