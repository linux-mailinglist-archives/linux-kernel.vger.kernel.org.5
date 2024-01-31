Return-Path: <linux-kernel+bounces-47348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFE4844CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCD51C24FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BD648CD4;
	Wed, 31 Jan 2024 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emkGsz4c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4F487A9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742695; cv=none; b=ffi+HrVdbmCMru86eQd8f276za6yDx0BD2lypv+nLg1YIClk69EWjcBiHtwd0JixDOm5ykE6yZXwUFxaE+yPr+2eglFMOXLt1F+v2gHdfKLRoVfLB5at+ZIwnDmA+OBZX6JyfvUIIMvkRUEp7D/M+EYCOaFVtksc0aej4bH7nz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742695; c=relaxed/simple;
	bh=0QAgU9z275M0DklHxMY3gX1axsMyYua5aTjHQfiW1kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRlyYsVHsghiRMUWslDEaSbceb6+wuVOXtlrP2oAiRAVIAvDIqIT1zbeM7tcdgAlTj2q7f3wiK9m5aCQWrfCibf4VHcpQG7x5I6qFKpYvObj9ZLWWPunnxP6iZhC5UWQWO4LLO60yRun33/7+yTYeN4znzaEyifbsfCmkZrhk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emkGsz4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5B4C43394;
	Wed, 31 Jan 2024 23:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742695;
	bh=0QAgU9z275M0DklHxMY3gX1axsMyYua5aTjHQfiW1kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emkGsz4cAKUCPe1skkiVLn6N0ywXEcObelKHbU1OOLULFuhWypqSivcxbNE71Txjy
	 EMiFBzhgpRbyZSaoIJqYeeqNsQoOhcDTl89g73U/8mOp4kZLwjcN4LSkl4uNusKobz
	 VZ1hgpX48OInX72j0QopSWdKEDvXs3jBLtymp1HY4PW2CDd3v7cCgi1Nm6SS5qZGky
	 Fb72rCdRaN7XMIaFg5eJjPwL8VSh6e30eGVXyYDtXO9Yt7oc2+GmXBzosdpnW7ysMK
	 jtAcWHj4VyHd9WTRlofzB+MxxY0yQVNn9TKhnwTh4mOo7u6qdlJT5C7INv2HB76R7C
	 fKmE1+4arkEJw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 04/15] tick: Use IS_ENABLED() whenever possible
Date: Thu,  1 Feb 2024 00:11:09 +0100
Message-ID: <20240131231120.12006-5-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131231120.12006-1-frederic@kernel.org>
References: <20240131231120.12006-1-frederic@kernel.org>
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
index e674269692ab..c4bf796a3285 100644
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
@@ -1549,10 +1547,8 @@ void tick_cancel_sched_timer(int cpu)
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


