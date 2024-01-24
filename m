Return-Path: <linux-kernel+bounces-37386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDAF83AF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E08528240B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F771823B3;
	Wed, 24 Jan 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXzVaOqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7A7F7E5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115926; cv=none; b=WxHJzhZmbOHcjiFqeWPtyZ4s4iZlv10AM+R/I6Dj/VWvywZYm7arfql8GhVVAKstHu+NXKU1e2ZAmpA9lyBletSi4rh6g29dH3g7UbrqZIqyj1JNtlWF31OFMaAJt8tbionnTQcnaSDeY7qiJBII9koB4FSybNhedDaLIHlE1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115926; c=relaxed/simple;
	bh=QnM+UJz4XeNONc8p34P/cNRqaLoZXdwjMjeyYr3C37A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUM60QDD6AQwWxIcYh+eRzAuZ4BCGdG0AMMWWzBmOPRaLfXIVhvkgCcCej7F7+iKxcz/AHZTUhdXdHbB0//LpAP+8btTkPPx3iy8SdPWSYWTmuoPTEWETs3XUwnMoGxjdiIB8SawMge9IMfDD0KzlbIos5qejTosPHROy2bE+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXzVaOqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88904C433C7;
	Wed, 24 Jan 2024 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115926;
	bh=QnM+UJz4XeNONc8p34P/cNRqaLoZXdwjMjeyYr3C37A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXzVaOqeB2ae8XATVtYY0ATKykzEeznIoL8vtipt7Hh4+mPoJWCee6eppLkzEuMRW
	 lEErjWM7fz7Rk1PxV0+WBfqkLD6ozrB9y3LApzb0e9xzeRRgXEF1bncjj7D6Eqq3QH
	 qSuzGt9P6a2HxJD2vj/iRsRQwyKP3ZjnCggKfEhozjBvpUCHAlKMjyvpvp76Xu67Fe
	 cSZLXw1RK2vb0EPb65Aymf7Xtv/qex3lK/NA96qq+MVpo7MZPfrLjR9DBuBkCAehc5
	 u8JxxYmQtpYKnaunlXSz2I8qHsq9nsdF8UoGzMomNZpF2EIsj8yBpYM/Q2p59QSFDv
	 InVDcjj58+94A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 07/15] tick: Start centralizing tick related CPU hotplug operations
Date: Wed, 24 Jan 2024 18:04:51 +0100
Message-ID: <20240124170459.24850-8-frederic@kernel.org>
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

During the CPU offlining process, the various timer tick features are
shut down from scattered places, sometimes from teardown callbacks on
stop machine, sometimes through explicit calls, sometimes from the
control CPU after the CPU died. The reason why these shutdown operations
are spread around is not always clear and it makes the tick lifecycle
hard to follow.

The tick should be shut down in order from highest to lowest level:

On stop machine from the dying CPU (high-level):

1) Hand-over the timekeeping duty (tick_handover_do_timer())
2) Cancel the tick implementation called by the clockevent callback
   (tick_cancel_sched_timer())
3) Shutdown broadcasting (tick_offline_cpu() / tick_broadcast_offline())

On stop machine from the dying CPU (low-level):

4) Shutdown clockevents drivers (CPUHP_AP_*_TIMER_STARTING states)

From the control CPU after the CPU died (low-level):

5) Shutdown/unregister/cleanup clockevents for the dead CPU
   (tick_cleanup_dead_cpu())

Instead the current order is 2, 4 (both from CPU hotplug states), then
1 and 3 through direct calls. This layout and order don't make much
sense. The operations 1, 2, 3 should be gathered together and in order.

Sort this situation with creating a new TICK shut-down CPU hotplug state
and start with introducing the timekeeping duty hand-over there. The
state must precede hrtimers migration because the tick hrtimer will be
stopped from it in a further patch.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuhotplug.h |  1 +
 include/linux/tick.h       |  8 ++++++--
 kernel/cpu.c               |  8 +++++---
 kernel/time/tick-common.c  | 17 +++++++++++------
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 172d0a743e5d..74fcdd2b82c8 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -184,6 +184,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
 	CPUHP_AP_HRTIMERS_DYING,
+	CPUHP_AP_TICK_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 716d17f31c45..afff4c207bd8 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -19,16 +19,20 @@ extern void __init tick_init(void);
 extern void tick_suspend_local(void);
 /* Should be core only, but XEN resume magic and ARM BL switcher require it */
 extern void tick_resume_local(void);
-extern void tick_handover_do_timer(void);
 extern void tick_cleanup_dead_cpu(int cpu);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_suspend_local(void) { }
 static inline void tick_resume_local(void) { }
-static inline void tick_handover_do_timer(void) { }
 static inline void tick_cleanup_dead_cpu(int cpu) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
+#if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_HOTPLUG_CPU)
+extern int tick_cpu_dying(unsigned int cpu);
+#else
+#define tick_cpu_dying	NULL
+#endif
+
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_SUSPEND)
 extern void tick_freeze(void);
 extern void tick_unfreeze(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba4950b..263508073da8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1324,8 +1324,6 @@ static int take_cpu_down(void *_param)
 	 */
 	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
 
-	/* Give up timekeeping duties */
-	tick_handover_do_timer();
 	/* Remove CPU from timer broadcasting */
 	tick_offline_cpu(cpu);
 	/* Park the stopper thread */
@@ -2205,7 +2203,11 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= NULL,
 		.teardown.single	= hrtimers_cpu_dying,
 	},
-
+	[CPUHP_AP_TICK_DYING] = {
+		.name			= "tick:dying",
+		.startup.single		= NULL,
+		.teardown.single	= tick_cpu_dying,
+	},
 	/* Entry state on starting. Interrupts enabled from here on. Transient
 	 * state for synchronsization */
 	[CPUHP_AP_ONLINE] = {
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 0084e1ae2583..a89ef450fda7 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -397,15 +397,20 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot_control);
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
- * Transfer the do_timer job away from a dying cpu.
- *
- * Called with interrupts disabled. No locking required. If
- * tick_do_timer_cpu is owned by this cpu, nothing can change it.
+ * Stop the tick and transfer the timekeeping job away from a dying cpu.
  */
-void tick_handover_do_timer(void)
+int tick_cpu_dying(unsigned int dying_cpu)
 {
-	if (tick_do_timer_cpu == smp_processor_id())
+	/*
+	 * If the current CPU is the timekeeper, it's the only one that
+	 * can safely hand over its duty. Also all online CPUs are in
+	 * stop machine, guaranteed not to be idle, therefore it's safe
+	 * to pick any online successor.
+	 */
+	if (tick_do_timer_cpu == dying_cpu)
 		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
+
+	return 0;
 }
 
 /*
-- 
2.43.0


