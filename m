Return-Path: <linux-kernel+bounces-47359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5AB844CCB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93501F26E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472413AA4D;
	Wed, 31 Jan 2024 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBTfiSUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7813A25F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742720; cv=none; b=dOyAFKmDHTTQP4d7idGOZHesCfPbC6WHWS9Whle1KOJki9Y7DNCz8DAFuNl+TuosqdXn+aqiA+IjOnVXPvL7/FVTR9NpGCh8WvkcU+af4hvVxARzeKQo8Qf9bEktJFSctlC1Gt6GuQErzJxj6ud45BfNRwCBCG+cfula19cDe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742720; c=relaxed/simple;
	bh=u2P1r5FEYqsMg24uO7pS2JZU0ctu1FvUTqkt+nPckno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h10O9MJ5Wzr7T+yIIapIIviC5zJRxo32EZ1hx5y1Ih1Zmm1sGWAzuJY2UMeHFRWpR4FAnN7lLgW9EbQiqbez6jVVZ8CG0mzaBFx+FK+JsWN7ASfuXhpeU2F4e+PLG3yTez/qT+zUtdKbRiEdtrl/V8uPrkLW40iDcO+rF7Tqii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBTfiSUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88DAC433A6;
	Wed, 31 Jan 2024 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742720;
	bh=u2P1r5FEYqsMg24uO7pS2JZU0ctu1FvUTqkt+nPckno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBTfiSUMVYOYZ/98kxN4SU48/pwvj2neLluIuuDRY7aLiJ2KIiovzLWi6+aJ5bhJc
	 95KL2r+0LZw8e914CEY7qxy9oXioveIxzbRlVGMX5Npq0yaQJ3DjKUJrnAxaIGq2M1
	 bmUkzXdxcRG1aFHUWvTwl1BJlBN160jRIJfqyPCyVVMAsOLmJsYKqbIAW98K7vLxnO
	 zoj8micYhI9ER/BeI4IqxO3mPADK0yP8XYXsoCp7ncMmtvXLMfisdi23KLewQpi85g
	 Lzs/+JkfrJBoKqhr6yg5GniHWyupM5aI0Fb5zdzGoNBV7+eztPu8GVuY8WfGd9CLR6
	 MSbEsjA1ahb0w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 15/15] tick: Assume timekeeping is correctly handed over upon last offline idle call
Date: Thu,  1 Feb 2024 00:11:20 +0100
Message-ID: <20240131231120.12006-16-frederic@kernel.org>
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

The timekeeping duty is handed over from the outgoing CPU on stop
machine, then the oneshot tick is stopped right after.  Therefore it's
guaranteed that the current CPU isn't the timekeeper upon its last call
to idle.

Besides, calling tick_nohz_idle_stop_tick() while the dying CPU goes
into idle suggests that the tick is going to be stopped while it is
actually stopped already from the appropriate CPU hotplug state.

Remove the confusing call and the obsolete case handling and convert it
to a sanity check that verifies the above assumption.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/tick.h      |  2 ++
 kernel/cpu.c              |  1 +
 kernel/sched/idle.c       |  1 -
 kernel/time/tick-common.c |  4 ++++
 kernel/time/tick-sched.c  | 13 +------------
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index c7840ae8ebaf..44fddfa93e18 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -29,8 +29,10 @@ static inline void tick_cleanup_dead_cpu(int cpu) { }
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_HOTPLUG_CPU)
 extern int tick_cpu_dying(unsigned int cpu);
+extern void tick_assert_timekeeping_handover(void);
 #else
 #define tick_cpu_dying	NULL
+static inline void tick_assert_timekeeping_handover(void) { }
 #endif
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_SUSPEND)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5a8ad4f5ccf3..7e84a7b0675e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1399,6 +1399,7 @@ void cpuhp_report_idle_dead(void)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
 	BUG_ON(st->state != CPUHP_AP_OFFLINE);
+	tick_assert_timekeeping_handover();
 	rcutree_report_cpu_dead();
 	st->state = CPUHP_AP_IDLE_DEAD;
 	/*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 31231925f1ec..b15d40cad7ea 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -291,7 +291,6 @@ static void do_idle(void)
 		local_irq_disable();
 
 		if (cpu_is_offline(cpu)) {
-			tick_nohz_idle_stop_tick();
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
 		}
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 9cd09eea06d6..fb0fdec8719a 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -396,6 +396,10 @@ int tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 EXPORT_SYMBOL_GPL(tick_broadcast_oneshot_control);
 
 #ifdef CONFIG_HOTPLUG_CPU
+void tick_assert_timekeeping_handover(void)
+{
+	WARN_ON_ONCE(tick_do_timer_cpu == smp_processor_id());
+}
 /*
  * Stop the tick and transfer the timekeeping job away from a dying cpu.
  */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cb8e4a171288..0dcd1c0e0a4e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1117,18 +1117,7 @@ static bool report_idle_softirq(void)
 
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
-	/*
-	 * If this CPU is offline and it is the one which updates
-	 * jiffies, then give up the assignment and let it be taken by
-	 * the CPU which runs the tick timer next. If we don't drop
-	 * this here, the jiffies might be stale and do_timer() never
-	 * gets invoked.
-	 */
-	if (unlikely(!cpu_online(cpu))) {
-		if (cpu == tick_do_timer_cpu)
-			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-		return false;
-	}
+	WARN_ON_ONCE(cpu_is_offline(cpu));
 
 	if (unlikely(!tick_sched_flag_test(ts, TS_FLAG_NOHZ)))
 		return false;
-- 
2.43.0


