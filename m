Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4708006F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378278AbjLAJ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378201AbjLAJ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:28:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D88E1FDD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:30 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYexXRgS2m5/dffYZ2zGFXnxjxh6wHD+OeXAnIrdHS4=;
        b=CaKDJWrMIQ2XDsHebkDLVj6vhfpY1bVbxlutZsI2FXCWK5GlSqOp9ycw/krKlnZcFKGsaX
        jSZcx3uZRM97ThMaXYFFFJmCWI864VKBNRpf92bkHuN3DykbJ7cDnWITVhwupQzdBiMR3C
        VDhuTVto3q6v34p/0MU4EEmoa+i01EcMnxju8dE+Lb9C7Qubv7nrrElqNIBRevESh3OjqH
        Ky8ewq1ml+IcXQspz+Wrw1MZ0tUyQ2JHWZuX5fn8Vc/JxL9l60YggYqiXRQsnsAftvNM5f
        g9gDlKPSCoZlnABDbZ1fGARLiMBLefQ5l8uNx3F8nCiWoJIR+yEnQIH+TaC+cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYexXRgS2m5/dffYZ2zGFXnxjxh6wHD+OeXAnIrdHS4=;
        b=A0lpCutDv4FDkeQp+mxGZD/cO52q4pGv2KnxDGTXksG1RQRM0/MTNKD+h5e0wys3W7C0zA
        IZU3vnjknhOnYjAA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v9 32/32] timers: Always queue timers on the local CPU
Date:   Fri,  1 Dec 2023 10:26:54 +0100
Message-Id: <20231201092654.34614-33-anna-maria@linutronix.de>
In-Reply-To: <20231201092654.34614-1-anna-maria@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 include/linux/timer.h | 14 ++++---------
 kernel/time/timer.c   | 46 +++++++++++++++++++++----------------------
 2 files changed, 26 insertions(+), 34 deletions(-)

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
index ac3e888d053f..6e9e1d852438 100644
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
@@ -2228,11 +2220,17 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		 * BASE_GLOBAL base, deferrable timers may still see large
 		 * granularity skew (by design).
 		 */
-		if (!base_local->is_idle) {
-			bool is_idle = time_after(nextevt, basej + 1);
 
-			base_local->is_idle = base_global->is_idle = is_idle;
-		}
+		/*
+		 * base->is_idle information is required to wakeup an idle CPU
+		 * when a new timer was enqueued. Only pinned timers could be
+		 * enqueued remotely into a idle base. Therefore do maintain
+		 * only base_local->is_idle information and ignore
+		 * base_global->is_idle information.
+		 */
+		if (!base_local->is_idle)
+			base_local->is_idle = time_after(nextevt, basej + 1);
+
 		*idle = base_local->is_idle;
 		trace_timer_base_idle(base_local->is_idle, base_local->cpu);
 
@@ -2307,13 +2305,13 @@ bool timer_base_is_idle(void)
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
 
 	trace_timer_base_idle(0, smp_processor_id());
 
-- 
2.39.2

