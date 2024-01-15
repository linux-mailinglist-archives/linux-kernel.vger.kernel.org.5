Return-Path: <linux-kernel+bounces-26115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3084082DB81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CA41F229AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1799718C01;
	Mon, 15 Jan 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sxM7WZm+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V0te2fdr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC51947A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8FYkcVHVLyMjEugh4Zzvv2eVrdB5BKbeH71HJmbkiM=;
	b=sxM7WZm+5FtzNzexxDgXWNCqEwS3r5nCxUYiLWgomIg2Ni0lZoVAW/wPdMA1M+Bc7VBtYq
	s9Oz76cdORwbPA5moxhUmqsWdQDhfbyeKywlqDVpggedSs/840JvenzNjNW/5eGJMml7DJ
	TYdSobFWHVKkFa46LjoPr18at0O3FAKrL1peY1NhJTbiDJyO5U4rWHoEPGc0ZSqfiBjuTB
	ky0hbXqmr529qRmjolKKkW26ufgXmJTkyVqTeIPobZvpL6c/T6UQLYc1HKQHSijO7Ih/jB
	KKqlYj7gI5KNeB/ZyeNzmq8vMxHgW8g4qEwm85C2XubaSeoQgO/VbwkJFbN2qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8FYkcVHVLyMjEugh4Zzvv2eVrdB5BKbeH71HJmbkiM=;
	b=V0te2fdrVPmijf/2dLYsUg5/Bqkk1AzUt4raxBy2PrteUn3wgDmpMfVN5HtU6cYKkAigRF
	83v9ZUg5aHm1BGDQ==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v10 20/20] timers: Always queue timers on the local CPU
Date: Mon, 15 Jan 2024 15:37:43 +0100
Message-Id: <20240115143743.27827-21-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timer pull model is in place so we can remove the heuristics which try
to guess the best target CPU at enqueue/modification time.

All non pinned timers are queued on the local CPU in the separate storage
and eventually pulled at expiry time to a remote CPU.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9:
 - Update to the changes of the preceding patches

v6:
 - Update TIMER_PINNED flag description.

v5:
 - Move WARN_ONCE() in add_timer_on() into a previous patch
 - Fold crystallball magic related hunks into this patch

v4: Update comment about TIMER_PINNED flag (heristic is removed)
---
 include/linux/timer.h | 14 ++++----------
 kernel/time/timer.c   | 34 +++++++++++++---------------------
 2 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 404bb31a95c7..4dd59e4e5681 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -50,16 +50,10 @@ struct timer_list {
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
  *
- * @TIMER_PINNED: A pinned timer will not be affected by any timer
- * placement heuristics (like, NOHZ) and will always expire on the CPU
- * on which the timer was enqueued.
- *
- * Note: Because enqueuing of timers can migrate the timer from one
- * CPU to another, pinned timers are not guaranteed to stay on the
- * initialy selected CPU.  They move to the CPU on which the enqueue
- * function is invoked via mod_timer() or add_timer().  If the timer
- * should be placed on a particular CPU, then add_timer_on() has to be
- * used.
+ * @TIMER_PINNED: A pinned timer will always expire on the CPU on which the
+ * timer was enqueued. When a particular CPU is required, add_timer_on()
+ * has to be used. Enqueue via mod_timer() and add_timer() is always done
+ * on the local CPU.
  */
 #define TIMER_CPUMASK		0x0003FFFF
 #define TIMER_MIGRATING		0x00040000
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a52f68be8dfd..8d53718af21d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -590,10 +590,13 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 
 	/*
 	 * We might have to IPI the remote CPU if the base is idle and the
-	 * timer is not deferrable. If the other CPU is on the way to idle
-	 * then it can't set base->is_idle as we hold the base lock:
+	 * timer is pinned. If it is a non pinned timer, it is only queued
+	 * on the remote CPU, when timer was running during queueing. Then
+	 * everything is handled by remote CPU anyway. If the other CPU is
+	 * on the way to idle then it can't set base->is_idle as we hold
+	 * the base lock:
 	 */
-	if (base->is_idle)
+	if (base->is_idle && timer->flags & TIMER_PINNED)
 		wake_up_nohz_cpu(base->cpu);
 }
 
@@ -941,17 +944,6 @@ static inline struct timer_base *get_timer_base(u32 tflags)
 	return get_timer_cpu_base(tflags, tflags & TIMER_CPUMASK);
 }
 
-static inline struct timer_base *
-get_target_base(struct timer_base *base, unsigned tflags)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-	if (static_branch_likely(&timers_migration_enabled) &&
-	    !(tflags & TIMER_PINNED))
-		return get_timer_cpu_base(tflags, get_nohz_timer_target());
-#endif
-	return get_timer_this_cpu_base(tflags);
-}
-
 static inline void __forward_timer_base(struct timer_base *base,
 					unsigned long basej)
 {
@@ -1106,7 +1098,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	if (!ret && (options & MOD_TIMER_PENDING_ONLY))
 		goto out_unlock;
 
-	new_base = get_target_base(base, timer->flags);
+	new_base = get_timer_this_cpu_base(timer->flags);
 
 	if (base != new_base) {
 		/*
@@ -2237,7 +2229,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		 * granularity skew (by design).
 		 */
 		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
-			base_local->is_idle = base_global->is_idle = true;
+			base_local->is_idle = true;
 			trace_timer_base_idle(true, base_local->cpu);
 		}
 		*idle = base_local->is_idle;
@@ -2303,13 +2295,13 @@ u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
 void timer_clear_idle(void)
 {
 	/*
-	 * We do this unlocked. The worst outcome is a remote enqueue sending
-	 * a pointless IPI, but taking the lock would just make the window for
-	 * sending the IPI a few instructions smaller for the cost of taking
-	 * the lock in the exit from idle path.
+	 * We do this unlocked. The worst outcome is a remote pinned timer
+	 * enqueue sending a pointless IPI, but taking the lock would just
+	 * make the window for sending the IPI a few instructions smaller
+	 * for the cost of taking the lock in the exit from idle
+	 * path. Required for BASE_LOCAL only.
 	 */
 	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
-	__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 	trace_timer_base_idle(false, smp_processor_id());
 
 	/* Activate without holding the timer_base->lock */
-- 
2.39.2


