Return-Path: <linux-kernel+bounces-80331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B7862D79
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1921F223E2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC0D1CA97;
	Sun, 25 Feb 2024 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJiqOwTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D41C6BC
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901723; cv=none; b=lJFCny5mlXn27ZBYuzshyZrZlr1gfLZ4l/UiA/akgJA1QXiNQLqgdYNbXvQGtBh6GWVt6bkTzMKk0Zf7rhiB0lQ+86xlSesxBo+UAAmhfES5Cy+pyrlrWwPhds32fDeMNRg45Loy6Ylu2rO1m0Szk27KfjDduDR2HiaJJMoTARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901723; c=relaxed/simple;
	bh=Uf94OwcRiSANlW0Oxi4zepCxsB0vE767pi+Mh6tUbYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7P7IT1VN6kitmSr63ZlX7HC0lxRFm+fjzCa7NuPm+oNeWEYUsKmebP/M0Q1Uz6LIzP6En/cTcpPlNpXm2NULgoyJgxYs3iKOfBLgeIpiO3ktOgEbB7ZTH5pAvapCkE8wi33cCBx9h9IM8TJ4lx5Wwy7se43s25ijqQJZsOH17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJiqOwTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B472C433A6;
	Sun, 25 Feb 2024 22:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901722;
	bh=Uf94OwcRiSANlW0Oxi4zepCxsB0vE767pi+Mh6tUbYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJiqOwTaNKs7nT10lRqYCUxxCsw5cqZ7uUhn3K1lUaPPznGvnTAGwOlIUPDQKGOO7
	 3Lj6mO7SyUuCzZaY+mNUO/wFcZefZAVaXOlqGFZ3EefthIm7999koKBPdyuwGls+sd
	 f9Iyk600QRuw8EGYW5ltYs6015SsgJbGq3cnRqC88BBNgliUNVbt4pOa47KZjMbm+W
	 u1wA6R/ipUJIm8r5yspWO3h64j93F2h4U0+348IdeBeEfGpoSwDLroO/ViiscWGOHN
	 pN/bIIywPRE2IKqlcQpNGpBshwU7kjss/0vDItHoPZPjH7mkphwaKFU6AstZOopE5m
	 Wwt62ZVpnUxGA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 04/16] tick: Use IS_ENABLED() whenever possible
Date: Sun, 25 Feb 2024 23:54:56 +0100
Message-ID: <20240225225508.11587-5-frederic@kernel.org>
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

Avoid ifdeferry if it can be converted to IS_ENABLED() whenever possible

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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
index 27aaecb2e50c..4e34967edc0d 100644
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
@@ -1587,10 +1585,8 @@ void tick_cancel_sched_timer(int cpu)
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
 
-# ifdef CONFIG_HIGH_RES_TIMERS
-	if (ts->sched_timer.base)
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
-# endif
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
-- 
2.43.0


