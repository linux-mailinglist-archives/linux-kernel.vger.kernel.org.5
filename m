Return-Path: <linux-kernel+bounces-37394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291AC83AF35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C46E1C22D62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C831292F3;
	Wed, 24 Jan 2024 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg4qqDuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA841292E1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115945; cv=none; b=KOPk3zID6PKiNf6aMm3hbRdgnrx+ImTPFKIeUHPfDS1dzcQtTRJ8y1QtPGClVIkd078ek1RkMJKvU5FSPSzBaoSv6gqiqM8L+wbdnpeoU39wk9TEcEd1N4F4g5iXtbsS6PGkfNncHcP/d4AYCn1HsSrE5V2rGqSGX/YZ+uhEPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115945; c=relaxed/simple;
	bh=3rLpbH9TxDLwqTYzfL+gAm8SDz7YKrWvuQPGpKHVxno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hluESTlVXO7vLEj/ov6lIDC8qrK9x87weWYtTn38dOYejREm0CDtfFoDqmD774SzV3JpqroEc99JZkkHoM+oVlD5+av/GAQrlS2ehU+ympWngiJ5z81V55qbDOtWs0VVL/SeJyVYKqzG3yEzuVp55HSmXWITJuv07ceDQakr07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg4qqDuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9C5C433C7;
	Wed, 24 Jan 2024 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115944;
	bh=3rLpbH9TxDLwqTYzfL+gAm8SDz7YKrWvuQPGpKHVxno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vg4qqDuykNEPszLPrOj3WVHt2+IWNF4VYtJnXEuBGLuZ97X8YmliQh60bLzFAxuuQ
	 bohOfSKHiqFzobB1EoJrFe1QzZ0Ch7FRDrljo3acl03u4KUM3HfdZCItw5LvIEQNGL
	 +UlyYuYN3NMntl/X3ReQeK3JMxCNVIADU+/xUcFINYVfPrU5DFBLwaZFO7NUG/azBL
	 eCqPaUZzKZ+SthVI78rsCXQNNXXyWk8xaAmSKo0AdUpbwHG+nOZmoUeuOGMXmiDMaC
	 AgNFHECZDuxyYFihka2vblwHHATOyTTHioLAlJ/sQrj/+hj4GUIPFp6IDLal0iYY2R
	 lF5jsKMKQzGUg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 15/15] tick: Assume timekeeping is correctly handed over upon last offline idle call
Date: Wed, 24 Jan 2024 18:04:59 +0100
Message-ID: <20240124170459.24850-16-frederic@kernel.org>
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

The timekeeping duty is handed over from the outgoing CPU on stop
machine, then the oneshot tick is stopped right after.  Therefore it's
guaranteed that the current CPU isn't the timekeeper upon its last call
to idle.

Besides, calling tick_nohz_idle_stop_tick() while the dying CPU goes
into idle suggests that the tick is going to be stopped while it is
actually stopped already from the appropriate CPU hotplug state.

Remove the confusing call and the obsolete case handling and convert it
to a sanity check that verifies the above assumption.

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
index 5e7fe19b9977..a98e026244b0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1118,18 +1118,7 @@ static bool report_idle_softirq(void)
 
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


