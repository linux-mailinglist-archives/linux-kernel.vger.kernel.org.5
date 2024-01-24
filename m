Return-Path: <linux-kernel+bounces-37380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE883AF25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D045F28657D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E281208;
	Wed, 24 Jan 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQfsInHm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714F80058
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115912; cv=none; b=sq6GvXmd6rj8zwJn142eYKOJr05cM3XxCdkoISQT2COC0kad5TS/jEylTsHFcDLvNzuKzNQIzmKQAJO5Z1ZRr8mF9oy3yQH2ycSmsqPDQ59IYl6ekAvtZ/YyfsUnBYxmlycek0j/4eqqcZ3l8l5wKzcws1neUloj1HGjr/NNThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115912; c=relaxed/simple;
	bh=yHPR6j3OL36RltRUGFvaGlb/MMYM5ilnHWsVaQEKuT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcYvRfNQJirxiwr1aQKCCNn6zfHo78+kZ+BpuMORA6CYAKyemi3dxvrjJJ3JiQ7dtrk2mhT8PUlHPMKut3a/S22lxtFs/2KNZPwDafzKS9GDI0rAqmltLCWEpHsoxVkwES0xGXLaePujzwKjLutTrwFVVRw90Bz8ZzAfBaFLhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQfsInHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EABC433F1;
	Wed, 24 Jan 2024 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115912;
	bh=yHPR6j3OL36RltRUGFvaGlb/MMYM5ilnHWsVaQEKuT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQfsInHmRq9DSrjfNMLhsPDqw+p77hD7gmMndejyr2j4ovFyXStTsUR4BY+7zGZNW
	 6TjJ3foqNPdU+BM3L4D3ZjbXEmn3i02koEdCeCtpGjj9cGDNPvlBMaKtnoeju5/eIp
	 8OtrIh2aLovc5ot5goCSePo/QKJWwRwepBPwoZNQV6NH1MqsPIo96hy7Hr+S2S3Uet
	 G83GVehCyNDctDdTNBjm2XxQjRYwCLUtwThdxRjjgM4gldwz8t2JVNxW3IPnWS9gbk
	 oQvjMkqxUetd/8h6SZ4U7jd3wT0DXCTeSag24Nxustpi7eStWk3HdWSCuiLS2dR4pZ
	 znaL1S3Gth1hQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peng Liu <liupeng17@lenovo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 01/15] tick/nohz: Remove duplicate between tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
Date: Wed, 24 Jan 2024 18:04:45 +0100
Message-ID: <20240124170459.24850-2-frederic@kernel.org>
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

The ts->sched_timer initialization work of tick_nohz_switch_to_nohz()
is almost the same as that of tick_setup_sched_timer(), so adjust the
latter to get it reused by tick_nohz_switch_to_nohz().

This also makes low-res mode sched_timer benefit from the tick skew
boot option.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/hrtimer.c    |  2 +-
 kernel/time/tick-sched.c | 38 +++++++++++++++++---------------------
 kernel/time/tick-sched.h |  2 +-
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 760793998cdd..355b5a957f7f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -746,7 +746,7 @@ static void hrtimer_switch_to_hres(void)
 	base->hres_active = 1;
 	hrtimer_resolution = HIGH_RES_NSEC;
 
-	tick_setup_sched_timer();
+	tick_setup_sched_timer(NOHZ_MODE_HIGHRES);
 	/* "Retrigger" the interrupt to get things going */
 	retrigger_next_event(NULL);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d2501673028d..e90dbb7ae70a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1433,9 +1433,6 @@ static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
  */
 static void tick_nohz_switch_to_nohz(void)
 {
-	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	ktime_t next;
-
 	if (!tick_nohz_enabled)
 		return;
 
@@ -1444,16 +1441,9 @@ static void tick_nohz_switch_to_nohz(void)
 
 	/*
 	 * Recycle the hrtimer in 'ts', so we can share the
-	 * hrtimer_forward_now() function with the highres code.
+	 * highres code.
 	 */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	/* Get the next period */
-	next = tick_init_jiffy_update();
-
-	hrtimer_set_expires(&ts->sched_timer, next);
-	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
-	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	tick_nohz_activate(ts, NOHZ_MODE_LOWRES);
+	tick_setup_sched_timer(NOHZ_MODE_LOWRES);
 }
 
 static inline void tick_nohz_irq_enter(void)
@@ -1532,7 +1522,9 @@ static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 
 	return HRTIMER_RESTART;
 }
+#endif /* HIGH_RES_TIMERS */
 
+#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
 static int __init skew_tick(char *str)
@@ -1545,15 +1537,18 @@ early_param("skew_tick", skew_tick);
 
 /**
  * tick_setup_sched_timer - setup the tick emulation timer
+ * @mode: tick_nohz_mode to setup for
  */
-void tick_setup_sched_timer(void)
+void tick_setup_sched_timer(int mode)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	ktime_t now = ktime_get();
 
 	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ts->sched_timer.function = tick_nohz_highres_handler;
+#ifdef CONFIG_HIGH_RES_TIMERS
+	if (mode == NOHZ_MODE_HIGHRES)
+		ts->sched_timer.function = tick_nohz_highres_handler;
+#endif
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
@@ -1566,13 +1561,14 @@ void tick_setup_sched_timer(void)
 		hrtimer_add_expires_ns(&ts->sched_timer, offset);
 	}
 
-	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
-	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
-	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
+	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
+	if (mode == NOHZ_MODE_HIGHRES)
+		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
+	else
+		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
+	tick_nohz_activate(ts, mode);
 }
-#endif /* HIGH_RES_TIMERS */
 
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
@@ -1589,7 +1585,7 @@ void tick_cancel_sched_timer(int cpu)
 	ts->idle_sleeptime = idle_sleeptime;
 	ts->iowait_sleeptime = iowait_sleeptime;
 }
-#endif
+#endif /* CONFIG_NO_HZ_COMMON || CONFIG_HIGH_RES_TIMERS */
 
 /*
  * Async notification about clocksource changes
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 5ed5a9d41d5a..35808bbb8a47 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -102,7 +102,7 @@ struct tick_sched {
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
 
-extern void tick_setup_sched_timer(void);
+extern void tick_setup_sched_timer(int mode);
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 extern void tick_cancel_sched_timer(int cpu);
 #else
-- 
2.43.0


