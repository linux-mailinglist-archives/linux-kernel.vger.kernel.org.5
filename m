Return-Path: <linux-kernel+bounces-37381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6D83AF27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37792858E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1946A823B6;
	Wed, 24 Jan 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo3Ks91e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738D81AD7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115915; cv=none; b=nkrKTWWXI54OZOH5poe2CxavT6tW90QW6iMzIvrtJydmOK7kpSFbEgXkxQukD6/UazkJ2kVpj08Bbv7E9f8nQaG55rUUx2Qp0RaFjVCSVUbZnukiXotXTW2k1Msk814y521+bTw8+vm3o5uFKFG6srfg62e+7m6m7uWb33yJJcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115915; c=relaxed/simple;
	bh=JNABFf9l7peDqU/Keofwd5fi4DbQISwry21UShiw/q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXPJ0cUVsDu3rGhQ8gfm85XXe4VoWdNOlOc/0gYOQECguK9Q+IF+1ShT5h56hPXtECMjNzy1F4R/pDtGV51+5+kHGIreeezvIs5IepVhlk/cMGrcVszK8e6uOzPAlD3zyzapFBB6008goEfbUwN1g19Boj80DaCj+l/07m8qhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo3Ks91e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA85AC43394;
	Wed, 24 Jan 2024 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115914;
	bh=JNABFf9l7peDqU/Keofwd5fi4DbQISwry21UShiw/q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xo3Ks91ecsh5kAWpzzWn/VCsbSUBy31Cy7IrMNMJ8qT4K4ItWhbuJHlVv9lp7S4ih
	 SPxbLceATVw8ZhiElnQu9MvxclyW4/+BRhen36Z63F/IqaGKkG4zqZDEtKrvbZ/Y/i
	 RkvCFOP5bF51av/xUGH7zAyTRS38bHy6pOE39CBoPSaSzwokrkcwGrfBo4LfjeMIj2
	 qlTcUeTwCRkUcHxdPURNW50i5cTlD1y58yHPQv/Q/BxlM0qG4ql9gnz2FD7J1NAUGL
	 Oqmas3KSUEmuRhfewfJsuhluRYjR1adLecv8+QgJowfLfqVIJhvaq3WQCQvYKels1t
	 T3YNgHklN1Dtg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peng Liu <liupeng17@lenovo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 02/15] tick/nohz: Remove duplicate between lowres and highres handlers
Date: Wed, 24 Jan 2024 18:04:46 +0100
Message-ID: <20240124170459.24850-3-frederic@kernel.org>
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

From: Peng Liu <liupeng17@lenovo.com>

tick_nohz_lowres_handler() does the same work as
tick_nohz_highres_handler() plus the clockevent device reprogramming, so
make the former reuse the latter.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 96 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 58 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index e90dbb7ae70a..6f69ae88e47e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -255,6 +255,41 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING);
 }
+
+/*
+ * We rearm the timer until we get disabled by the idle code.
+ * Called with interrupts disabled.
+ */
+static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
+{
+	struct tick_sched *ts =
+		container_of(timer, struct tick_sched, sched_timer);
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
@@ -1392,30 +1427,17 @@ void tick_nohz_idle_exit(void)
  * infrastructure actually relies on the tick itself as a backend in
  * low-resolution mode (see hrtimer_run_queues()).
  *
- * This low-resolution handler still makes use of some hrtimer APIs meanwhile
- * for convenience with expiration calculation and forwarding.
+ * This low-resolution handler still reuse tick_nohz_highres_handler() since
+ * most of the work is independent from the clockevent level.
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
+	if (likely(tick_nohz_highres_handler(&ts->sched_timer) == HRTIMER_RESTART))
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	}
-
 }
 
 static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
@@ -1484,46 +1506,6 @@ void tick_irq_enter(void)
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
-#endif /* HIGH_RES_TIMERS */
-
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
@@ -1545,10 +1527,8 @@ void tick_setup_sched_timer(int mode)
 
 	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-#ifdef CONFIG_HIGH_RES_TIMERS
 	if (mode == NOHZ_MODE_HIGHRES)
 		ts->sched_timer.function = tick_nohz_highres_handler;
-#endif
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
-- 
2.43.0


