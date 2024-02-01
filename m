Return-Path: <linux-kernel+bounces-47346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E543B844CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7744928DEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D07482F3;
	Wed, 31 Jan 2024 23:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rii2qKbA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC9482E2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742691; cv=none; b=VIjJIdyZt4uiU1kljg9FBeAkgeuSlHP3LNvXba12K8rYxQn8BOuWP44ClBm58erspK7bB6FhfUMsdPASDc8niy6tHIFuYoBTLeZg96wtKQL8vndu9hhryKLku3RZiIeEcbE/Gf47ypxKpG0SQNCUmGJUg6AKy53iXQK6G4iPp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742691; c=relaxed/simple;
	bh=wo077DcopptE4PXrUnE2wvN1oXs9MI9u90VSK05yiuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTCIa7Zkpqlu84+PYmDjJMih0mAxFMcfw7E6EQe7zNZHnqFD9LWbxbzwipqmT9LXA9Q7D6YCvw1I1JYYy4HyrVtNfGirrKeip8M0Z0+V6IMej0sL3jf1tVd6gmb8t/arTbWYkEMrYpeaDIUa2UY8rZZ5iA5JZs0Kyyu3mAmxe40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rii2qKbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E15C433F1;
	Wed, 31 Jan 2024 23:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742690;
	bh=wo077DcopptE4PXrUnE2wvN1oXs9MI9u90VSK05yiuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rii2qKbAxLpzyE1Gk6YhTQxo7MFmtFY9qpdUNiBxws/Bha2Gx933vVZzdTZbuMOlo
	 yOLZnxrcuEC2aaniYWxvl2zhg+F7C9AGnMKYb6sOGU1/Rql2m9NSscRbjVi/JIoOhq
	 peGT9zaXKuDUu5yuqBilBrL/nQVfMZPvVlCqytA2h7G8moZdVuKmfdn3xrfeOrTBW3
	 J3PtmJgtDTPwJnp1DI7vY/3L828wjKncB8Sn/BrqYQCaMJ/9/j0qB+7Tyifmsb8lhL
	 GZvV9llaO9FTEs8id/l2ce0XVMc9g+znXetHgEJmnfVQSz7h5gniZho+wuVUeRSrXp
	 hGMEqhSeybjLQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peng Liu <liupeng17@lenovo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 02/15] tick/nohz: Remove duplicate between lowres and highres handlers
Date: Thu,  1 Feb 2024 00:11:07 +0100
Message-ID: <20240131231120.12006-3-frederic@kernel.org>
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

From: Peng Liu <liupeng17@lenovo.com>

tick_nohz_lowres_handler() does the same work as
tick_nohz_highres_handler() plus the clockevent device reprogramming, so
make the former reuse the latter and rename it accordingly.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 96 +++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 60 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 639ee689e7cc..cc19c4ff5a25 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -255,6 +255,40 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING);
 }
+
+/*
+ * We rearm the timer until we get disabled by the idle code.
+ * Called with interrupts disabled.
+ */
+static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
+{
+	struct tick_sched *ts =	container_of(timer, struct tick_sched, sched_timer);
+	struct pt_regs *regs = get_irq_regs();
+	ktime_t now = ktime_get();
+
+	tick_sched_do_timer(ts, now);
+
+	/*
+	 * Do not call when we are not in IRQ context and have
+	 * no valid 'regs' pointer
+	 */
+	if (regs)
+		tick_sched_handle(ts, regs);
+	else
+		ts->next_tick = 0;
+
+	/*
+	 * In dynticks mode, tick reprogram is deferred:
+	 * - to the idle task if in dynticks-idle
+	 * - to IRQ exit if in full-dynticks.
+	 */
+	if (unlikely(ts->tick_stopped))
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward(timer, now, TICK_NSEC);
+
+	return HRTIMER_RESTART;
+}
 #endif
 
 #ifdef CONFIG_NO_HZ_FULL
@@ -1391,31 +1425,15 @@ void tick_nohz_idle_exit(void)
  * at the clockevent level. hrtimer can't be used instead, because its
  * infrastructure actually relies on the tick itself as a backend in
  * low-resolution mode (see hrtimer_run_queues()).
- *
- * This low-resolution handler still makes use of some hrtimer APIs meanwhile
- * for convenience with expiration calculation and forwarding.
  */
 static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	struct pt_regs *regs = get_irq_regs();
-	ktime_t now = ktime_get();
 
 	dev->next_event = KTIME_MAX;
 
-	tick_sched_do_timer(ts, now);
-	tick_sched_handle(ts, regs);
-
-	/*
-	 * In dynticks mode, tick reprogram is deferred:
-	 * - to the idle task if in dynticks-idle
-	 * - to IRQ exit if in full-dynticks.
-	 */
-	if (likely(!ts->tick_stopped)) {
-		hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
+	if (likely(tick_nohz_handler(&ts->sched_timer) == HRTIMER_RESTART))
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	}
-
 }
 
 static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
@@ -1484,48 +1502,6 @@ void tick_irq_enter(void)
 	tick_nohz_irq_enter();
 }
 
-/*
- * High resolution timer specific code
- */
-#ifdef CONFIG_HIGH_RES_TIMERS
-/*
- * We rearm the timer until we get disabled by the idle code.
- * Called with interrupts disabled.
- */
-static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
-{
-	struct tick_sched *ts =
-		container_of(timer, struct tick_sched, sched_timer);
-	struct pt_regs *regs = get_irq_regs();
-	ktime_t now = ktime_get();
-
-	tick_sched_do_timer(ts, now);
-
-	/*
-	 * Do not call when we are not in IRQ context and have
-	 * no valid 'regs' pointer
-	 */
-	if (regs)
-		tick_sched_handle(ts, regs);
-	else
-		ts->next_tick = 0;
-
-	/*
-	 * In dynticks mode, tick reprogram is deferred:
-	 * - to the idle task if in dynticks-idle
-	 * - to IRQ exit if in full-dynticks.
-	 */
-	if (unlikely(ts->tick_stopped))
-		return HRTIMER_NORESTART;
-
-	hrtimer_forward(timer, now, TICK_NSEC);
-
-	return HRTIMER_RESTART;
-}
-#else
-#define tick_nohz_highres_handler NULL
-#endif /* CONFIG_HIGH_RES_TIMERS */
-
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
@@ -1549,7 +1525,7 @@ void tick_setup_sched_timer(int mode)
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 
 	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
-		ts->sched_timer.function = tick_nohz_highres_handler;
+		ts->sched_timer.function = tick_nohz_handler;
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
-- 
2.43.0


