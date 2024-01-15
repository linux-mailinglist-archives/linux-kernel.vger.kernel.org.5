Return-Path: <linux-kernel+bounces-26109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4271582DB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0221C21C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A642418E39;
	Mon, 15 Jan 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8GGphrl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j+t04NEL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23D182C3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ia4sddnbK0Qx+BWCOb+xOAdGjZ34vg4G3iXN8bRXi4s=;
	b=b8GGphrlLbDvJc/pDdyXU2kGAPnBE+bfQAiN++hh9wO8KyqhoTl94U9CrJSuGmSpPDyFZl
	cLIe0e0k4amIcy5S/NJU1uzMOZvDYVocGPAJ0Mejw3owPepGbbfbh1p0KI7My6IJG2A6a6
	oHwdiNYrIW6rAmolipJKKpjx/cBeYpKIOFLnBZ8ojnpA89TnqzcOnv14q89e1Y41EAaG9E
	DU8pnAwafNmnZIqkH2lJ8HS5k3yqCimeJGbB54bllC7IIEDGpfk+jSOL7DyqK/ZUlzMLVr
	vNCzqb5rmrN2pLujw2Tik888Lvz7W6SXTgr9qm6hOEl51qitzauy9SiGlvVC9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ia4sddnbK0Qx+BWCOb+xOAdGjZ34vg4G3iXN8bRXi4s=;
	b=j+t04NELCR9FOn+3Ltaz1pEStFnL5V8hESrqaOUd7BCwDRzN1BJgcvFY9O/2TamDwtwKWQ
	5IJD6N6eDzQki4Bw==
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
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v10 13/20] timers: Add get next timer interrupt functionality for remote CPUs
Date: Mon, 15 Jan 2024 15:37:36 +0100
Message-Id: <20240115143743.27827-14-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 remote CPUs

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have functionality available getting the
next timer interrupt on a remote CPU.

Locking of the timer bases and getting the information for the next timer
interrupt functionality is split into separate functions. This is required
to be compliant with lock ordering when the new model is in place.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10:
 - sparse annotations for locks

v8:
 - Update comment

v7:
 - Move functions into CONFIG_SMP && CONFIG_NO_HZ_COMMON section
 - change lock, fetch functions to be unconditional
 - split out unlock function into a separate function

v6:
 - introduce timer_lock_remote_bases() to fix race
---
 kernel/time/tick-internal.h | 10 +++++
 kernel/time/timer.c         | 80 ++++++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 47df30b871e4..8b0c28edbd09 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -8,6 +8,11 @@
 #include "timekeeping.h"
 #include "tick-sched.h"
 
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 # define TICK_DO_TIMER_NONE	-1
@@ -154,6 +159,11 @@ extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
 # ifdef CONFIG_SMP
 extern struct static_key_false timers_migration_enabled;
+extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+					      struct timer_events *tevt,
+					      unsigned int cpu);
+extern void timer_lock_remote_bases(unsigned int cpu);
+extern void timer_unlock_remote_bases(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9fa759dd80f5..3e2adfc15f3a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -221,11 +221,6 @@ struct timer_base {
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
-struct timer_events {
-	u64	local;
-	u64	global;
-};
-
 #ifdef CONFIG_NO_HZ_COMMON
 
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
@@ -2031,6 +2026,81 @@ static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
 	return nextevt;
 }
 
+# ifdef CONFIG_SMP
+/**
+ * fetch_next_timer_interrupt_remote() - Store next timers into @tevt
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @tevt:	Pointer to the storage for the expiry values
+ * @cpu:	Remote CPU
+ *
+ * Stores the next pending local and global timer expiry values in the
+ * struct pointed to by @tevt. If a queue is empty the corresponding
+ * field is set to KTIME_MAX. If local event expires before global
+ * event, global event is set to KTIME_MAX as well.
+ *
+ * Caller needs to make sure timer base locks are held (use
+ * timer_lock_remote_bases() for this purpose).
+ */
+void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+				       struct timer_events *tevt,
+				       unsigned int cpu)
+{
+	struct timer_base *base_local, *base_global;
+
+	/* Preset local / global events */
+	tevt->local = tevt->global = KTIME_MAX;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	lockdep_assert_held(&base_local->lock);
+	lockdep_assert_held(&base_global->lock);
+
+	fetch_next_timer_interrupt(basej, basem, base_local, base_global, tevt);
+}
+
+/**
+ * timer_unlock_remote_bases - unlock timer bases of cpu
+ * @cpu:	Remote CPU
+ *
+ * Unlocks the remote timer bases.
+ */
+void timer_unlock_remote_bases(unsigned int cpu)
+	__releases(timer_bases[BASE_LOCAL]->lock)
+	__releases(timer_bases[BASE_GLOBAL]->lock)
+{
+	struct timer_base *base_local, *base_global;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
+}
+
+/**
+ * timer_lock_remote_bases - lock timer bases of cpu
+ * @cpu:	Remote CPU
+ *
+ * Locks the remote timer bases.
+ */
+void timer_lock_remote_bases(unsigned int cpu)
+	__acquires(timer_bases[BASE_LOCAL]->lock)
+	__acquires(timer_bases[BASE_GLOBAL]->lock)
+{
+	struct timer_base *base_local, *base_global;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	lockdep_assert_irqs_disabled();
+
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+}
+# endif /* CONFIG_SMP */
+
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
-- 
2.39.2


