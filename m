Return-Path: <linux-kernel+bounces-98993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E6B878205
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A57A1C21765
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62749446D3;
	Mon, 11 Mar 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M57tLDJC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7aktardZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03D446BD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168529; cv=none; b=Frf6WKWKOUlsyTlyaYNK+Ya3O2iEphXUNELX5N5k9Dtaxq+TFCC7mdXVJsTYPf1ERMOcqev1ByZoXYiXyHtZIQzKra1gAsiMCIcHT5H6vlniXos5lP3d/SkfHD0nJJOq0PGIA/soCyBohbjzLMvGsANb6kDFN4qnWRn/RMCelxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168529; c=relaxed/simple;
	bh=ysVqqR7SLOMO/FjxJCCwZfvV0GMIGtMY+d9+ljZInOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DpKuoFuzJVdanX2AxU6HzialX/FJFXtJxcj04NqBk3lJaGjNo1wLoNyIPaV9n/3uXuT8nVb+g9tnlPiCxI7Y0ouUGY8BBWKl9AppMpXyQX2PN1cvw6cTtn58DRuDmVR8CPmy6pw58Xd8bhEQLJf77sPL4isau6MsdxCizV3+qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M57tLDJC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7aktardZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710168525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfJAQs2hKQxLNR77U6uStXoAhiAS5rDNvv3whnriMBc=;
	b=M57tLDJCUdybTdIIQ6gSX5WazFpSwbUd2PV/olOEoq7C0B0ffzlG/+EBkuYAB17dwGqDeK
	mH/za+3fwAG+c1QNIZrmucExRI1GvPfAGb85/JacKckPOon05QNInpaw4CPgaSF8p+bYmA
	rT4QvQTpLsDqoBInNxOv05U942djNcetlAH1QhmifZVY+msh2YZ4gC8K0RP6h0TzAyr4KB
	3p+76OZXu0o/0R9qqtt8oeFf9RznHpDWIZAV0USAwJm2XbXB5mfSAETp3GfXZLt9//abio
	1hitOKg3RE7SiUB91SQR0ppOYRSeXuFkGlWe/ECKc8OKeSnsq/16tW6/I2vjhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710168525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfJAQs2hKQxLNR77U6uStXoAhiAS5rDNvv3whnriMBc=;
	b=7aktardZjQvMc4bpILuI88zPfNkaWAqIoBg2vkEOX0ew9z+SeX9j0hZGHro3YlYT0mIdhb
	qu+h9+fW0qwAp1Cg==
To: Sean Anderson <sean.anderson@seco.com>, Mirsad Todorovac
 <mirsad.todorovac@alu.unizg.hr>, linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [BUG] KCSAN: data-race in tick_nohz_idle_stop_tick /
 tick_nohz_next_event
In-Reply-To: <83b3c900-d4eb-457f-99e6-cb21e0eae4cb@seco.com>
References: <40ac9903-469a-b1ea-4339-8b06f855450e@alu.unizg.hr>
 <3993c468-fdac-2ff2-c3ee-9784c098694c@alu.unizg.hr>
 <83b3c900-d4eb-457f-99e6-cb21e0eae4cb@seco.com>
Date: Mon, 11 Mar 2024 15:48:45 +0100
Message-ID: <87a5n4rfhu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 07 2024 at 14:43, Sean Anderson wrote:
> On 8/18/23 10:15, Mirsad Todorovac wrote:
>
> The justification seems to be in tick_sched_do_timer:
>
>         /*
>          * Check if the do_timer duty was dropped. We don't care about
>          * concurrency: This happens only when the CPU in charge went
>          * into a long sleep. If two CPUs happen to assign themselves to
>          * this duty, then the jiffies update is still serialized by
>          * jiffies_lock.
>          *
>          * If nohz_full is enabled, this should not happen because the
>          * tick_do_timer_cpu never relinquishes.
>          */
>
> with the other assignment being in tick_nohz_stop_tick. I'm not familiar
> enough with this code to say whether we should be using READ/WRITE_ONCE
> or maybe just data_race (as would be implied by the comment above).

It wants to be READ/WRITE_ONCE(). Something like the untested below,
which applies to -next or the master branch of the tip tree.

Thanks,

        tglx
---

--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -7,6 +7,7 @@
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
  */
+#include <linux/compiler.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/hrtimer.h>
@@ -84,7 +85,7 @@ int tick_is_oneshot_available(void)
  */
 static void tick_periodic(int cpu)
 {
-	if (tick_do_timer_cpu == cpu) {
+	if (READ_ONCE(tick_do_timer_cpu) == cpu) {
 		raw_spin_lock(&jiffies_lock);
 		write_seqcount_begin(&jiffies_seq);
 
@@ -215,8 +216,8 @@ static void tick_setup_device(struct tic
 		 * If no cpu took the do_timer update, assign it to
 		 * this cpu:
 		 */
-		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			tick_do_timer_cpu = cpu;
+		if (READ_ONCE(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
@@ -232,7 +233,7 @@ static void tick_setup_device(struct tic
 						!tick_nohz_full_cpu(cpu)) {
 			tick_take_do_timer_from_boot();
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(tick_do_timer_cpu != cpu);
+			WARN_ON(READ_ON_ONCE(tick_do_timer_cpu) != cpu);
 #endif
 		}
 
@@ -406,10 +407,10 @@ void tick_assert_timekeeping_handover(vo
 int tick_cpu_dying(unsigned int dying_cpu)
 {
 	/*
-	 * If the current CPU is the timekeeper, it's the only one that
-	 * can safely hand over its duty. Also all online CPUs are in
-	 * stop machine, guaranteed not to be idle, therefore it's safe
-	 * to pick any online successor.
+	 * If the current CPU is the timekeeper, it's the only one that can
+	 * safely hand over its duty. Also all online CPUs are in stop
+	 * machine, guaranteed not to be idle, therefore there is no
+	 * concurrency and it's safe to pick any online successor.
 	 */
 	if (tick_do_timer_cpu == dying_cpu)
 		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -8,6 +8,7 @@
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
  */
+#include <linux/compiler.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/hrtimer.h>
@@ -204,7 +205,7 @@ static inline void tick_sched_flag_clear
 
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
-	int cpu = smp_processor_id();
+	int tick_cpu, cpu = smp_processor_id();
 
 	/*
 	 * Check if the do_timer duty was dropped. We don't care about
@@ -216,16 +217,18 @@ static void tick_sched_do_timer(struct t
 	 * If nohz_full is enabled, this should not happen because the
 	 * 'tick_do_timer_cpu' CPU never relinquishes.
 	 */
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) &&
-	    unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+	tick_cpu = READ_ONCE(tick_do_timer_cpu);
+
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && unlikely(tick_cpu == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
 		WARN_ON_ONCE(tick_nohz_full_running);
 #endif
-		tick_do_timer_cpu = cpu;
+		WRITE_ONCE(tick_do_timer_cpu, cpu);
+		tick_cpu = cpu;
 	}
 
 	/* Check if jiffies need an update */
-	if (tick_do_timer_cpu == cpu)
+	if (tick_cpu == cpu)
 		tick_do_update_jiffies64(now);
 
 	/*
@@ -610,7 +613,7 @@ bool tick_nohz_cpu_hotpluggable(unsigned
 	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
-	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
+	if (tick_nohz_full_running && READ_ONCE(tick_do_timer_cpu) == cpu)
 		return false;
 	return true;
 }
@@ -890,6 +893,7 @@ static ktime_t tick_nohz_next_event(stru
 {
 	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
+	int tick_cpu;
 
 	basemono = get_jiffies_update(&basejiff);
 	ts->last_jiffies = basejiff;
@@ -946,9 +950,9 @@ static ktime_t tick_nohz_next_event(stru
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta = timekeeping_max_deferment();
-	if (cpu != tick_do_timer_cpu &&
-	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE ||
-	     !tick_sched_flag_test(ts, TS_FLAG_DO_TIMER_LAST)))
+	tick_cpu = READ_ONCE(tick_do_timer_cpu);
+	if (tick_cpu != cpu &&
+	    (tick_cpu != TICK_DO_TIMER_NONE || !tick_sched_flag_test(ts, TS_FLAG_DO_TIMER_LAST)))
 		delta = KTIME_MAX;
 
 	/* Calculate the next expiry time */
@@ -969,6 +973,7 @@ static void tick_nohz_stop_tick(struct t
 	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
 	bool timer_idle = tick_sched_flag_test(ts, TS_FLAG_STOPPED);
+	int tick_cpu;
 	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
@@ -1006,10 +1011,11 @@ static void tick_nohz_stop_tick(struct t
 	 * do_timer() never gets invoked. Keep track of the fact that it
 	 * was the one which had the do_timer() duty last.
 	 */
-	if (cpu == tick_do_timer_cpu) {
-		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+	tick_cpu = READ_ONCE(tick_do_timer_cpu);
+	if (tick_cpu == cpu) {
+		WRITE_ONCE(tick_do_timer_cpu, TICK_DO_TIMER_NONE);
 		tick_sched_flag_set(ts, TS_FLAG_DO_TIMER_LAST);
-	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
+	} else if (tick_cpu != TICK_DO_TIMER_NONE) {
 		tick_sched_flag_clear(ts, TS_FLAG_DO_TIMER_LAST);
 	}
 
@@ -1172,15 +1178,17 @@ static bool can_stop_idle_tick(int cpu,
 		return false;
 
 	if (tick_nohz_full_enabled()) {
+		int tick_cpu = READ_ONCE(tick_do_timer_cpu);
+
 		/*
 		 * Keep the tick alive to guarantee timekeeping progression
 		 * if there are full dynticks CPUs around
 		 */
-		if (tick_do_timer_cpu == cpu)
+		if (tick_cpu == cpu)
 			return false;
 
 		/* Should not happen for nohz-full */
-		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
+		if (WARN_ON_ONCE(tick_cpu == TICK_DO_TIMER_NONE))
 			return false;
 	}
 


