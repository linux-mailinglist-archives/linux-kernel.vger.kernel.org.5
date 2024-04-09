Return-Path: <linux-kernel+bounces-136674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE689D6F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850EA1C21359
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506BA81751;
	Tue,  9 Apr 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lYZJJGS1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0pcujErO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F180629
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658556; cv=none; b=M5YBwqpv/SVf31v+VU6khHTF00eggkbZ9HWPqQO1OwQXfoSjrPjCdz8UEkstrg8ylt9xPL0uyY2sjQCEXsKsKk1qcwV3zKWP/egRVNgHNCzBgVMAqGNr8GV1A3VElFbE7DciF0VevR0wursIlcn+i+NeyZUNsoX5v4j72/WA/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658556; c=relaxed/simple;
	bh=XNnyP8qVi1HgN7u6NP7Q7yseLfpjzGBeNAOYFNuri88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RZzhbBisiyO+IiR8jQc2nFJN22vw4mn/jnQki47I4ILeY0W5njXmUusjaw+o+kCU9AVAip+RMoOissGq83EJGBsgvph4DLy/PQye80AvV7OHSOhqdkm4VAk71mmQ64E7t3yo+I7aUEq79VSsh3dONLeAqnhryuPecbUOQHA3Q+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lYZJJGS1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0pcujErO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712658552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EF6ovFLdWNLhvSGuwEQg4yxIeTGiTX0nsnyNSwoTsr0=;
	b=lYZJJGS1T08kmtgYpWSzPd3Ox4L8SjKZOeTLqC4dEC0cQJRdfztnNIOhWhxc4wW7X+g4H7
	+iPdkT5l3MdTExFEjZREIrunsdd0R9L135tv4I+eZ79Wxs7yXHNwTLegUDWefjN49wctZI
	wtfz12cfp71zTWVC7tMsokckBTfNGn42SJp2Q2S6mzNTu94rTfO5P+oEBLyJJ5CpvEAnfy
	aiudqhaOglPtSmPR+dHj4++m5/aHeMK7H+l9V3KCrPEhgicbkOvqKH5Fd6zsjXt5DqkKvj
	rZ9sobL+RXRwaglGNRrv71dWI0Ttu4bLKWcaCfwMLD9g0CCpkpFSnCXXNwGtMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712658552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EF6ovFLdWNLhvSGuwEQg4yxIeTGiTX0nsnyNSwoTsr0=;
	b=0pcujErOj0KtWGpK/4UyeHbcdqpP0+9z5skGuaH7NrgnggkFNteBp3Z2wrETC/NgE+lN3+
	l2cL83BopLDVphCQ==
To: Sean Anderson <sean.anderson@seco.com>, Mirsad Todorovac
 <mirsad.todorovac@alu.unizg.hr>, linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: timekeeping: Use READ/WRITE_ONCE() for tick_do_timer_cpu
In-Reply-To: <ab147205-41cc-4c1b-8280-000e638b6534@seco.com>
References: <40ac9903-469a-b1ea-4339-8b06f855450e@alu.unizg.hr>
 <3993c468-fdac-2ff2-c3ee-9784c098694c@alu.unizg.hr>
 <83b3c900-d4eb-457f-99e6-cb21e0eae4cb@seco.com> <87a5n4rfhu.ffs@tglx>
 <ab147205-41cc-4c1b-8280-000e638b6534@seco.com>
Date: Tue, 09 Apr 2024 12:29:12 +0200
Message-ID: <87cyqy7rt3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

tick_do_timer_cpu is used lockless to check which CPU needs to take care
of the per tick timekeeping duty. This is done to avoid a thundering
herd problem on jiffies_lock.

The read and writes are not annotated so KCSAN complains about data races:

  BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event                                                                                                                                                       
                                                                                                                                                                                                                                 
  write to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 26:                                                                                                                                                                    
   tick_nohz_idle_stop_tick+0x3b1/0x4a0                                                                                                                                                                                          
   do_idle+0x1e3/0x250                                                                                                                                                                                                           
                                                                                                                                                                                                                                 
  read to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 16:                                                                                                                                                                     
   tick_nohz_next_event+0xe7/0x1e0                                                                                                                                                                                               
   tick_nohz_get_sleep_length+0xa7/0xe0                                                                                                                                                                                          
   menu_select+0x82/0xb90                                                                                                                                                                                                        
   cpuidle_select+0x44/0x60                                                                                                                                                                                                      
   do_idle+0x1c2/0x250                                                                                                                                                                                                           
                                                                                                                                                                                                                                 
  value changed: 0x0000001a -> 0xffffffff                  

Annotate them with READ/WRITE_ONCE() to document the intentional data race.

Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sean Anderson <sean.anderson@seco.com>
---
 kernel/time/tick-common.c |   17 +++++++++--------
 kernel/time/tick-sched.c  |   36 ++++++++++++++++++++++--------------
 2 files changed, 31 insertions(+), 22 deletions(-)

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
@@ -891,6 +894,7 @@ static ktime_t tick_nohz_next_event(stru
 {
 	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
+	int tick_cpu;
 
 	basemono = get_jiffies_update(&basejiff);
 	ts->last_jiffies = basejiff;
@@ -947,9 +951,9 @@ static ktime_t tick_nohz_next_event(stru
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
@@ -970,6 +974,7 @@ static void tick_nohz_stop_tick(struct t
 	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
 	bool timer_idle = tick_sched_flag_test(ts, TS_FLAG_STOPPED);
+	int tick_cpu;
 	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
@@ -1007,10 +1012,11 @@ static void tick_nohz_stop_tick(struct t
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
 
@@ -1173,15 +1179,17 @@ static bool can_stop_idle_tick(int cpu,
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
 

