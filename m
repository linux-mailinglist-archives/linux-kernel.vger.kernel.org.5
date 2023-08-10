Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7B4777047
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjHJGZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHJGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291E710FE;
        Wed,  9 Aug 2023 23:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF43261B50;
        Thu, 10 Aug 2023 06:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79D2C433C8;
        Thu, 10 Aug 2023 06:25:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        chenhuacai@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 1/2] tick: Rename tick_do_update_jiffies64() and allow external usage
Date:   Thu, 10 Aug 2023 14:25:26 +0800
Message-Id: <20230810062527.3700080-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename tick_do_update_jiffies64() to do_update_jiffies_64() and move it
to jiffies.c. This keeps the same naming style in jiffies.c and allow it
be used by external components. This patch is a preparation for the next
one which attempts to avoid necessary rcu stall warnings.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Fix build.

 include/linux/jiffies.h   |   2 +
 kernel/time/jiffies.c     | 113 ++++++++++++++++++++++++++++++++++++-
 kernel/time/tick-sched.c  | 115 ++------------------------------------
 kernel/time/timekeeping.h |   1 +
 4 files changed, 118 insertions(+), 113 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 5e13f801c902..48866314c68b 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -88,6 +88,8 @@ static inline u64 get_jiffies_64(void)
 }
 #endif
 
+void do_update_jiffies_64(s64 now); /* typedef s64 ktime_t */
+
 /*
  *	These inlines deal with timer wrapping correctly. You are 
  *	strongly encouraged to use them
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index bc4db9e5ab70..507a1e7e619e 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -5,14 +5,14 @@
  * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
  */
 #include <linux/clocksource.h>
+#include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
-#include <linux/init.h>
+#include <linux/sched/loadavg.h>
 
 #include "timekeeping.h"
 #include "tick-internal.h"
 
-
 static u64 jiffies_read(struct clocksource *cs)
 {
 	return (u64) jiffies;
@@ -61,6 +61,115 @@ EXPORT_SYMBOL(get_jiffies_64);
 
 EXPORT_SYMBOL(jiffies);
 
+/*
+ * The time, when the last jiffy update happened. Write access must hold
+ * jiffies_lock and jiffies_seq. Because tick_nohz_next_event() needs to
+ * get a consistent view of jiffies and last_jiffies_update.
+ */
+ktime_t last_jiffies_update;
+
+/*
+ * Must be called with interrupts disabled !
+ */
+void do_update_jiffies_64(ktime_t now)
+{
+#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
+	unsigned long ticks = 1;
+	ktime_t delta, nextp;
+
+	/*
+	 * 64bit can do a quick check without holding jiffies lock and
+	 * without looking at the sequence count. The smp_load_acquire()
+	 * pairs with the update done later in this function.
+	 *
+	 * 32bit cannot do that because the store of tick_next_period
+	 * consists of two 32bit stores and the first store could move it
+	 * to a random point in the future.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
+			return;
+	} else {
+		unsigned int seq;
+
+		/*
+		 * Avoid contention on jiffies_lock and protect the quick
+		 * check with the sequence count.
+		 */
+		do {
+			seq = read_seqcount_begin(&jiffies_seq);
+			nextp = tick_next_period;
+		} while (read_seqcount_retry(&jiffies_seq, seq));
+
+		if (ktime_before(now, nextp))
+			return;
+	}
+
+	/* Quick check failed, i.e. update is required. */
+	raw_spin_lock(&jiffies_lock);
+	/*
+	 * Reevaluate with the lock held. Another CPU might have done the
+	 * update already.
+	 */
+	if (ktime_before(now, tick_next_period)) {
+		raw_spin_unlock(&jiffies_lock);
+		return;
+	}
+
+	write_seqcount_begin(&jiffies_seq);
+
+	delta = ktime_sub(now, tick_next_period);
+	if (unlikely(delta >= TICK_NSEC)) {
+		/* Slow path for long idle sleep times */
+		s64 incr = TICK_NSEC;
+
+		ticks += ktime_divns(delta, incr);
+
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   incr * ticks);
+	} else {
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   TICK_NSEC);
+	}
+
+	/* Advance jiffies to complete the jiffies_seq protected job */
+	jiffies_64 += ticks;
+
+	/*
+	 * Keep the tick_next_period variable up to date.
+	 */
+	nextp = ktime_add_ns(last_jiffies_update, TICK_NSEC);
+
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		/*
+		 * Pairs with smp_load_acquire() in the lockless quick
+		 * check above and ensures that the update to jiffies_64 is
+		 * not reordered vs. the store to tick_next_period, neither
+		 * by the compiler nor by the CPU.
+		 */
+		smp_store_release(&tick_next_period, nextp);
+	} else {
+		/*
+		 * A plain store is good enough on 32bit as the quick check
+		 * above is protected by the sequence count.
+		 */
+		tick_next_period = nextp;
+	}
+
+	/*
+	 * Release the sequence count. calc_global_load() below is not
+	 * protected by it, but jiffies_lock needs to be held to prevent
+	 * concurrent invocations.
+	 */
+	write_seqcount_end(&jiffies_seq);
+
+	calc_global_load();
+
+	raw_spin_unlock(&jiffies_lock);
+	update_wall_time();
+#endif
+}
+
 static int __init init_jiffies_clocksource(void)
 {
 	return __clocksource_register(&clocksource_jiffies);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4df14db4da49..c993c7dfe79d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -44,113 +44,6 @@ struct tick_sched *tick_get_tick_sched(int cpu)
 }
 
 #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
-/*
- * The time, when the last jiffy update happened. Write access must hold
- * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
- * consistent view of jiffies and last_jiffies_update.
- */
-static ktime_t last_jiffies_update;
-
-/*
- * Must be called with interrupts disabled !
- */
-static void tick_do_update_jiffies64(ktime_t now)
-{
-	unsigned long ticks = 1;
-	ktime_t delta, nextp;
-
-	/*
-	 * 64bit can do a quick check without holding jiffies lock and
-	 * without looking at the sequence count. The smp_load_acquire()
-	 * pairs with the update done later in this function.
-	 *
-	 * 32bit cannot do that because the store of tick_next_period
-	 * consists of two 32bit stores and the first store could move it
-	 * to a random point in the future.
-	 */
-	if (IS_ENABLED(CONFIG_64BIT)) {
-		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
-			return;
-	} else {
-		unsigned int seq;
-
-		/*
-		 * Avoid contention on jiffies_lock and protect the quick
-		 * check with the sequence count.
-		 */
-		do {
-			seq = read_seqcount_begin(&jiffies_seq);
-			nextp = tick_next_period;
-		} while (read_seqcount_retry(&jiffies_seq, seq));
-
-		if (ktime_before(now, nextp))
-			return;
-	}
-
-	/* Quick check failed, i.e. update is required. */
-	raw_spin_lock(&jiffies_lock);
-	/*
-	 * Reevaluate with the lock held. Another CPU might have done the
-	 * update already.
-	 */
-	if (ktime_before(now, tick_next_period)) {
-		raw_spin_unlock(&jiffies_lock);
-		return;
-	}
-
-	write_seqcount_begin(&jiffies_seq);
-
-	delta = ktime_sub(now, tick_next_period);
-	if (unlikely(delta >= TICK_NSEC)) {
-		/* Slow path for long idle sleep times */
-		s64 incr = TICK_NSEC;
-
-		ticks += ktime_divns(delta, incr);
-
-		last_jiffies_update = ktime_add_ns(last_jiffies_update,
-						   incr * ticks);
-	} else {
-		last_jiffies_update = ktime_add_ns(last_jiffies_update,
-						   TICK_NSEC);
-	}
-
-	/* Advance jiffies to complete the jiffies_seq protected job */
-	jiffies_64 += ticks;
-
-	/*
-	 * Keep the tick_next_period variable up to date.
-	 */
-	nextp = ktime_add_ns(last_jiffies_update, TICK_NSEC);
-
-	if (IS_ENABLED(CONFIG_64BIT)) {
-		/*
-		 * Pairs with smp_load_acquire() in the lockless quick
-		 * check above and ensures that the update to jiffies_64 is
-		 * not reordered vs. the store to tick_next_period, neither
-		 * by the compiler nor by the CPU.
-		 */
-		smp_store_release(&tick_next_period, nextp);
-	} else {
-		/*
-		 * A plain store is good enough on 32bit as the quick check
-		 * above is protected by the sequence count.
-		 */
-		tick_next_period = nextp;
-	}
-
-	/*
-	 * Release the sequence count. calc_global_load() below is not
-	 * protected by it, but jiffies_lock needs to be held to prevent
-	 * concurrent invocations.
-	 */
-	write_seqcount_end(&jiffies_seq);
-
-	calc_global_load();
-
-	raw_spin_unlock(&jiffies_lock);
-	update_wall_time();
-}
-
 /*
  * Initialize and return retrieve the jiffies update.
  */
@@ -207,7 +100,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 
 	/* Check, if the jiffies need an update */
 	if (tick_do_timer_cpu == cpu)
-		tick_do_update_jiffies64(now);
+		do_update_jiffies_64(now);
 
 	/*
 	 * If jiffies update stalled for too long (timekeeper in stop_machine()
@@ -218,7 +111,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 		ts->last_tick_jiffies = READ_ONCE(jiffies);
 	} else {
 		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
-			tick_do_update_jiffies64(now);
+			tick_do_update_jiffies_64(now);
 			ts->stalled_jiffies = 0;
 			ts->last_tick_jiffies = READ_ONCE(jiffies);
 		}
@@ -652,7 +545,7 @@ static void tick_nohz_update_jiffies(ktime_t now)
 	__this_cpu_write(tick_cpu_sched.idle_waketime, now);
 
 	local_irq_save(flags);
-	tick_do_update_jiffies64(now);
+	do_update_jiffies_64(now);
 	local_irq_restore(flags);
 
 	touch_softlockup_watchdog_sched();
@@ -975,7 +868,7 @@ static void tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
 static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 {
 	/* Update jiffies first */
-	tick_do_update_jiffies64(now);
+	do_update_jiffies_64(now);
 
 	/*
 	 * Clear the timer idle flag, so we avoid IPIs on remote queueing and
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 543beba096c7..21670f6c7421 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -28,6 +28,7 @@ extern void update_wall_time(void);
 
 extern raw_spinlock_t jiffies_lock;
 extern seqcount_raw_spinlock_t jiffies_seq;
+extern ktime_t last_jiffies_update;
 
 #define CS_NAME_LEN	32
 
-- 
2.39.3

