Return-Path: <linux-kernel+bounces-26116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EAC82DB84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1841C21B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E9419BCD;
	Mon, 15 Jan 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRvux8a4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hpo5uJRH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CE18EA5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+xUY73XPxFi07Ol5/lrj6+HQZCPHVTqKyY6q9PFF4U=;
	b=HRvux8a4t7ujbag2jIVE45ME5m1vRWkeJjqODn8IOrzumi3owTvEUVDsP1wYnxiqMFgBKR
	Pv1H3tbHKp0jr9zvN1a3hX14IMoOoyGzcoj6g/KzjGJ9FPZnTgfCimzMv3lCGrh1ta8zAt
	0KO/LQj/EqFQe8E5OggroCUloweNEoDBOZtftLstUx/Go1XK6/r5Q7y3c26Cc3JNnuPgpt
	euqhQcqIAU0jeg1BHA/kY4YO7ZMiertgg31/RiCzat+gBCsrWkDAp9b7Ug4qVOgZ/BScwt
	9EApx7F6LE5ri+peLiSOazyOoyeLbbGxLpRRwPUWAcRxJFRrY6BP/tFugislSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+xUY73XPxFi07Ol5/lrj6+HQZCPHVTqKyY6q9PFF4U=;
	b=Hpo5uJRHhqQbVq/qmXUjGj1HbQrUkLXzgCAzg6Q5pOWvW1JCVqpm4vbufrIZ0x/NfWCMdV
	XegPE6drpSBiwRBg==
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
Subject: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Date: Mon, 15 Jan 2024 15:37:41 +0100
Message-Id: <20240115143743.27827-19-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Placing timers at enqueue time on a target CPU based on dubious heuristics
does not make any sense:

 1) Most timer wheel timers are canceled or rearmed before they expire.

 2) The heuristics to predict which CPU will be busy when the timer expires
    are wrong by definition.

So placing the timers at enqueue wastes precious cycles.

The proper solution to this problem is to always queue the timers on the
local CPU and allow the non pinned timers to be pulled onto a busy CPU at
expiry time.

Therefore split the timer storage into local pinned and global timers:
Local pinned timers are always expired on the CPU on which they have been
queued. Global timers can be expired on any CPU.

As long as a CPU is busy it expires both local and global timers. When a
CPU goes idle it arms for the first expiring local timer. If the first
expiring pinned (local) timer is before the first expiring movable timer,
then no action is required because the CPU will wake up before the first
movable timer expires. If the first expiring movable timer is before the
first expiring pinned (local) timer, then this timer is queued into an idle
timerqueue and eventually expired by another active CPU.

To avoid global locking the timerqueues are implemented as a hierarchy. The
lowest level of the hierarchy holds the CPUs. The CPUs are associated to
groups of 8, which are separated per node. If more than one CPU group
exist, then a second level in the hierarchy collects the groups. Depending
on the size of the system more than 2 levels are required. Each group has a
"migrator" which checks the timerqueue during the tick for remote expirable
timers.

If the last CPU in a group goes idle it reports the first expiring event in
the group up to the next group(s) in the hierarchy. If the last CPU goes
idle it arms its timer for the first system wide expiring timer to ensure
that no timer event is missed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v10:
  - Fix fallout of 0day (s/unsigned int/int)
  - Adress review remarks of bigeasy

v9:
  - Adapt to the changes of the preceding patches
  - Fix state inconsitency (when timer base is idle, cpu must also be
    marked as idle in hierarchy)
  - Make sure new timers are considered, when timer base is idle and a
    timer is enqueued into global queue (e.g. during interrupt) ->
    timer_use_tmigr()
  - Changes which are required due to the timer code change of marking the
    timer base idle in tick_nohz_stop_tick()

v8:
  - Review of Frederic:
    - Fix hotplug race (introduction of wakeup_recalc)
    - Make wakeup and wakeup_recalc logic consistent all over the place
    - Fix child/group state race and read it with locks held
  - Add more clarifying comments
  - Fix grammar all over the place
  - change integers which act as boolean value into bool
  - rewrite condition in tmigr_check_migrator() without negation
  - Improve update events logic with a check of the first event
  - Implement a quick forecast which is called when
    get_next_timer_interrupt() is executed.

v7:
  - Review remarks of Frederic and bigeasy:
    - change logic in tmigr_handle_remote_cpu()
    - s/kzalloc/kcalloc
    - move timer_expire_remote() into NO_HZ_COMMON && SMP config section
    - drop DBG_BUG_ON() makro and use only WARN_ON_ONCE()
    - remove leftovers from sibling logic during setup
  - Move timer_expire_remote() into tick-internal.h
  - Add documentation section about "Required event and timerqueue update
    after remote expiry"
  - Fix fallout of kernel test robot

v6:
  - Fix typos
  - Review remarks of Peter Zijlstra (locking, struct member cleanup, use
    atomic_try_cmpxchg(), update struct member descriptions)
  - Fix race in tmigr_handle_remote_cpu() (Frederic Weisbecker)

v5:
  - Review remarks of Frederic
  - Return nextevt when CPU is marked offline in timer migration hierarchy
    instead of KTIME_MAX
  - Fix update of group events issue, after remote expiring

v4:
  - Fold typo fix in comment into proper patch "timer: Split out "get next
    timer interrupt" functionality"
  - Update wrong comment for tmigr_state union definition
  - Fix fallout of kernel test robot
---
 create mode 100644 kernel/time/timer_migration.c
---
 include/linux/cpuhotplug.h    |    1 +
 kernel/time/Makefile          |    3 +
 kernel/time/tick-internal.h   |    1 +
 kernel/time/timer.c           |  113 ++-
 kernel/time/timer_migration.c | 1667 +++++++++++++++++++++++++++++++++
 kernel/time/timer_migration.h |  147 +++
 6 files changed, 1924 insertions(+), 8 deletions(-)
 create mode 100644 kernel/time/timer_migration.c
 create mode 100644 kernel/time/timer_migration.h

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index efc0c0b07efb..85a78c5a7c01 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -245,6 +245,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
 	CPUHP_AP_PERF_CSKY_ONLINE,
+	CPUHP_AP_TMIGR_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RANDOM_ONLINE,
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 7e875e63ff3b..4af2a264a160 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -17,6 +17,9 @@ endif
 obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+= sched_clock.o
 obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
 obj-$(CONFIG_LEGACY_TIMER_TICK)			+= tick-legacy.o
+ifeq ($(CONFIG_SMP),y)
+ obj-$(CONFIG_NO_HZ_COMMON)			+= timer_migration.o
+endif
 obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 7e3090109e33..a3243c4ac45f 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -166,6 +166,7 @@ extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
 extern void timer_lock_remote_bases(unsigned int cpu);
 extern void timer_unlock_remote_bases(unsigned int cpu);
 extern bool timer_base_is_idle(void);
+extern void timer_expire_remote(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3c49d8fdfd53..a52f68be8dfd 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -53,6 +53,7 @@
 #include <asm/io.h>
 
 #include "tick-internal.h"
+#include "timer_migration.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/timer.h>
@@ -2109,6 +2110,64 @@ bool timer_base_is_idle(void)
 {
 	return __this_cpu_read(timer_bases[BASE_LOCAL].is_idle);
 }
+
+static void __run_timer_base(struct timer_base *base);
+
+/**
+ * timer_expire_remote() - expire global timers of cpu
+ * @cpu:	Remote CPU
+ *
+ * Expire timers of global base of remote CPU.
+ */
+void timer_expire_remote(unsigned int cpu)
+{
+	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	__run_timer_base(base);
+}
+
+static void timer_use_tmigr(unsigned long basej, u64 basem,
+			    unsigned long *nextevt, bool *tick_stop_path,
+			    bool timer_base_idle, struct timer_events *tevt)
+{
+	u64 next_tmigr;
+
+	if (timer_base_idle)
+		next_tmigr = tmigr_cpu_new_timer(tevt->global);
+	else if (tick_stop_path)
+		next_tmigr = tmigr_cpu_deactivate(tevt->global);
+	else
+		next_tmigr = tmigr_quick_check();
+
+	/*
+	 * If the CPU is the last going idle in timer migration hierarchy, make
+	 * sure the CPU will wake up in time to handle remote timers.
+	 * next_tmigr == KTIME_MAX if other CPUs are still active.
+	 */
+	if (next_tmigr < tevt->local) {
+		u64 tmp;
+
+		/* If we missed a tick already, force 0 delta */
+		if (next_tmigr < basem)
+			next_tmigr = basem;
+
+		tmp = div_u64(next_tmigr - basem, TICK_NSEC);
+
+		*nextevt = basej + (unsigned long)tmp;
+		tevt->local = next_tmigr;
+	}
+}
+# else
+static void timer_use_tmigr(unsigned long basej, u64 basem,
+			    unsigned long *nextevt, bool *tick_stop_path,
+			    bool timer_base_idle, struct timer_events *tevt)
+{
+	/*
+	 * Make sure first event is written into tevt->local to not miss a
+	 * timer on !SMP systems.
+	 */
+	tevt->local = min_t(u64, tevt->local, tevt->global);
+}
 # endif /* CONFIG_SMP */
 
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
@@ -2117,7 +2176,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	struct timer_base *base_local, *base_global;
 	unsigned long nextevt;
-	u64 expires;
+	bool idle_is_possible;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -2138,6 +2197,22 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	nextevt = fetch_next_timer_interrupt(basej, basem, base_local,
 					     base_global, &tevt);
 
+	/*
+	 * If the next event is only one jiffie ahead there is no need to call
+	 * timer migration hierarchy related functions. The value for the next
+	 * global timer in @tevt struct equals then KTIME_MAX. This is also
+	 * true, when the timer base is idle.
+	 *
+	 * The proper timer migration hierarchy function depends on the callsite
+	 * and whether timer base is idle or not. @nextevt will be updated when
+	 * this CPU needs to handle the first timer migration hierarchy
+	 * event. See timer_use_tmigr() for detailed information.
+	 */
+	idle_is_possible = time_after(nextevt, basej + 1);
+	if (idle_is_possible)
+		timer_use_tmigr(basej, basem, &nextevt, idle,
+				base_local->is_idle, &tevt);
+
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
@@ -2150,7 +2225,10 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	 */
 	if (idle) {
 		/*
-		 * Bases are idle if the next event is more than a tick away.
+		 * Bases are idle if the next event is more than a tick
+		 * away. Caution: @nextevt could have changed by enqueueing a
+		 * global timer into timer migration hierarchy. Therefore a new
+		 * check is required here.
 		 *
 		 * If the base is marked idle then any timer add operation must
 		 * forward the base clk itself to keep granularity small. This
@@ -2163,14 +2241,23 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 			trace_timer_base_idle(true, base_local->cpu);
 		}
 		*idle = base_local->is_idle;
+
+		/*
+		 * When timer base is not set idle, undo the effect of
+		 * tmigr_cpu_deactivate() to prevent inconsitent states - active
+		 * timer base but inactive timer migration hierarchy.
+		 *
+		 * When timer base was already marked idle, nothing will be
+		 * changed here.
+		 */
+		if (!base_local->is_idle && idle_is_possible)
+			tmigr_cpu_activate();
 	}
 
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
-	expires = min_t(u64, tevt.local, tevt.global);
-
-	return cmp_next_hrtimer_event(basem, expires);
+	return cmp_next_hrtimer_event(basem, tevt.local);
 }
 
 /**
@@ -2178,8 +2265,11 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
  *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
+ * Returns the tick aligned clock monotonic time of the next pending timer or
+ * KTIME_MAX if no timer is pending. If timer of global base was queued into
+ * timer migration hierarchy, first global timer is not taken into account. If
+ * it was the last CPU of timer migration hierarchy going idle, first global
+ * event is taken into account.
  */
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
@@ -2221,6 +2311,9 @@ void timer_clear_idle(void)
 	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
 	__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 	trace_timer_base_idle(false, smp_processor_id());
+
+	/* Activate without holding the timer_base->lock */
+	tmigr_cpu_activate();
 }
 #endif
 
@@ -2290,6 +2383,9 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
 		run_timer_base(BASE_GLOBAL);
 		run_timer_base(BASE_DEF);
+
+		if (is_timers_nohz_active())
+			tmigr_handle_remote();
 	}
 }
 
@@ -2304,7 +2400,8 @@ static void run_local_timers(void)
 
 	for (int i = 0; i < NR_BASES; i++, base++) {
 		/* Raise the softirq only if required. */
-		if (time_after_eq(jiffies, base->next_expiry)) {
+		if (time_after_eq(jiffies, base->next_expiry) ||
+		    (i == BASE_DEF && tmigr_requires_handle_remote())) {
 			raise_softirq(TIMER_SOFTIRQ);
 			return;
 		}
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
new file mode 100644
index 000000000000..de1905b0bae7
--- /dev/null
+++ b/kernel/time/timer_migration.c
@@ -0,0 +1,1667 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Infrastructure for migratable timers
+ *
+ * Copyright(C) 2022 linutronix GmbH
+ */
+#include <linux/cpuhotplug.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/timerqueue.h>
+#include <trace/events/ipi.h>
+
+#include "timer_migration.h"
+#include "tick-internal.h"
+
+/*
+ * The timer migration mechanism is built on a hierarchy of groups. The
+ * lowest level group contains CPUs, the next level groups of CPU groups
+ * and so forth. The CPU groups are kept per node so for the normal case
+ * lock contention won't happen across nodes. Depending on the number of
+ * CPUs per node even the next level might be kept as groups of CPU groups
+ * per node and only the levels above cross the node topology.
+ *
+ * Example topology for a two node system with 24 CPUs each.
+ *
+ * LVL 2                           [GRP2:0]
+ *                              GRP1:0 = GRP1:M
+ *
+ * LVL 1            [GRP1:0]                      [GRP1:1]
+ *               GRP0:0 - GRP0:2               GRP0:3 - GRP0:5
+ *
+ * LVL 0  [GRP0:0]  [GRP0:1]  [GRP0:2]  [GRP0:3]  [GRP0:4]  [GRP0:5]
+ * CPUS     0-7       8-15      16-23     24-31     32-39     40-47
+ *
+ * The groups hold a timer queue of events sorted by expiry time. These
+ * queues are updated when CPUs go in idle. When they come out of idle
+ * ignore flag of events is set.
+ *
+ * Each group has a designated migrator CPU/group as long as a CPU/group is
+ * active in the group. This designated role is necessary to avoid that all
+ * active CPUs in a group try to migrate expired timers from other CPUs,
+ * which would result in massive lock bouncing.
+ *
+ * When a CPU is awake, it checks in it's own timer tick the group
+ * hierarchy up to the point where it is assigned the migrator role or if
+ * no CPU is active, it also checks the groups where no migrator is set
+ * (TMIGR_NONE).
+ *
+ * If it finds expired timers in one of the group queues it pulls them over
+ * from the idle CPU and runs the timer function. After that it updates the
+ * group and the parent groups if required.
+ *
+ * CPUs which go idle arm their CPU local timer hardware for the next local
+ * (pinned) timer event. If the next migratable timer expires after the
+ * next local timer or the CPU has no migratable timer pending then the
+ * CPU does not queue an event in the LVL0 group. If the next migratable
+ * timer expires before the next local timer then the CPU queues that timer
+ * in the LVL0 group. In both cases the CPU marks itself idle in the LVL0
+ * group.
+ *
+ * When CPU comes out of idle and when a group has at least a single active
+ * child, the ignore flag of the tmigr_event is set. This indicates, that
+ * the event is ignored even if it is still enqueued in the parent groups
+ * timer queue. It will be removed when touching the timer queue the next
+ * time. This spares locking in active path as the lock protects (after
+ * setup) only event information. For more information about locking,
+ * please read the section "Locking rules".
+ *
+ * If the CPU is the migrator of the group then it delegates that role to
+ * the next active CPU in the group or sets migrator to TMIGR_NONE when
+ * there is no active CPU in the group. This delegation needs to be
+ * propagated up the hierarchy so hand over from other leaves can happen at
+ * all hierarchy levels w/o doing a search.
+ *
+ * When the last CPU in the system goes idle, then it drops all migrator
+ * duties up to the top level of the hierarchy (LVL2 in the example). It
+ * then has to make sure, that it arms it's own local hardware timer for
+ * the earliest event in the system.
+ *
+ *
+ * Lifetime rules:
+ * ---------------
+ *
+ * The groups are built up at init time or when CPUs come online. They are
+ * not destroyed when a group becomes empty due to offlining. The group
+ * just won't participate in the hierarchy management anymore. Destroying
+ * groups would result in interesting race conditions which would just make
+ * the whole mechanism slow and complex.
+ *
+ *
+ * Locking rules:
+ * --------------
+ *
+ * For setting up new groups and handling events it's required to lock both
+ * child and parent group. The lock ordering is always bottom up. This also
+ * includes the per CPU locks in struct tmigr_cpu. For updating the migrator and
+ * active CPU/group information atomic_try_cmpxchg() is used instead and only
+ * the per CPU tmigr_cpu->lock is held.
+ *
+ * During the setup of groups tmigr_level_list is required. It is protected by
+ * @tmigr_mutex.
+ *
+ * When @timer_base->lock as well as tmigr related locks are required, the lock
+ * ordering is: first @timer_base->lock, afterwards tmigr related locks.
+ *
+ *
+ * Protection of the tmigr group state information:
+ * ------------------------------------------------
+ *
+ * The state information with the list of active children and migrator needs to
+ * be protected by a sequence counter. It prevents a race when updates in child
+ * groups are propagated in changed order. The state update is performed
+ * lockless and group wise. The following scenario describes what happens
+ * without updating the sequence counter:
+ *
+ * Therefore, let's take three groups and four CPUs (CPU2 and CPU3 as well
+ * as GRP0:1 will not change during the scenario):
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = CPU0           migrator = CPU2
+ *           active   = CPU0           active   = CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             active      idle           active      idle
+ *
+ *
+ * 1. CPU0 goes idle. As the update is performed group wise, in the first step
+ *    only GRP0:0 is updated. The update of GRP1:0 is pending as CPU0 has to
+ *    walk the hierarchy.
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *       --> migrator = TMIGR_NONE     migrator = CPU2
+ *       --> active   =                active   = CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *         --> idle        idle           active      idle
+ *
+ * 2. While CPU0 goes idle and continues to update the state, CPU1 comes out of
+ *    idle. CPU1 updates GRP0:0. The update for GRP1:0 is pending as CPU1 also
+ *    has to the hierarchy. Both CPUs (CPU0 and CPU1) now walk the hierarchy to
+ *    perform the needed update from their point of view. The currently visible
+ *    state looks the following:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *       --> migrator = CPU1           migrator = CPU2
+ *       --> active   = CPU1           active   = CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle    --> active         active      idle
+ *
+ * 3. Here is the race condition: CPU1 managed to propagate its changes (from
+ *    step 2) through the hierarchy to GRP1:0 before CPU0 (step 1) did. The
+ *    active members of GRP1:0 remain unchanged after the update since it is
+ *    still valid from CPU1 current point of view:
+ *
+ *    LVL 1            [GRP1:0]
+ *                 --> migrator = GRP0:1
+ *                 --> active   = GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = CPU1           migrator = CPU2
+ *           active   = CPU1           active   = CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        active         active      idle
+ *
+ * 4. Now CPU0 finally propagates its changes (from step 1) to GRP1:0.
+ *
+ *    LVL 1            [GRP1:0]
+ *                 --> migrator = GRP0:1
+ *                 --> active   = GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = CPU1           migrator = CPU2
+ *           active   = CPU1           active   = CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        active         active      idle
+ *
+ *
+ * The race of CPU0 vs. CPU1 led to an inconsistent state in GRP1:0. CPU1 is
+ * active and is correctly listed as active in GRP0:0. However GRP1:0 does not
+ * have GRP0:0 listed as active, which is wrong. The sequence counter has been
+ * added to avoid inconsistent states during updates. The state is updated
+ * atomically only if all members, including the sequence counter, match the
+ * expected value (compare-and-exchange).
+ *
+ * Looking back at the previous example with the addition of the sequence
+ * counter: The update as performed by CPU0 in step 4 will fail. CPU1 changed
+ * the sequence number during the update in step 3 so the expected old value (as
+ * seen by CPU0 before starting the walk) does not match.
+ *
+ * Required event and timerqueue update after a remote expiry:
+ * -----------------------------------------------------------
+ *
+ * After expiring timers of a remote CPU, a walk through the hierarchy and
+ * update of events and timerqueues is required. It is obviously needed if there
+ * is a 'new' global timer but also if there is no new global timer but the
+ * remote CPU is still idle.
+ *
+ * 1. CPU0 and CPU1 are idle and have both a global timer expiring at the same
+ *    time. So both have an event enqueued in the timerqueue of GRP0:0. CPU3 is
+ *    also idle and has no global timer pending. CPU2 is the only active CPU and
+ *    thus also the migrator:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:1
+ *                 --> timerqueue = evt-GRP0:0
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = TMIGR_NONE     migrator = CPU2
+ *           active   =                active   = CPU2
+ *           groupevt.ignore = false   groupevt.ignore = true
+ *           groupevt.cpu = CPU0       groupevt.cpu =
+ *           timerqueue = evt-CPU0,    timerqueue =
+ *                        evt-CPU1
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * 2. CPU2 starts to expire remote timers. It starts with LVL0 group
+ *    GRP0:1. There is no event queued in the timerqueue, so CPU2 continues with
+ *    the parent of GRP0:1: GRP1:0. In GRP1:0 it dequeues the first event. It
+ *    looks at tmigr_event::cpu struct member and expires the pending timer(s)
+ *    of CPU0.
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:1
+ *                 --> timerqueue =
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = TMIGR_NONE     migrator = CPU2
+ *           active   =                active   = CPU2
+ *           groupevt.ignore = false   groupevt.ignore = true
+ *       --> groupevt.cpu = CPU0       groupevt.cpu =
+ *           timerqueue = evt-CPU0,    timerqueue =
+ *                        evt-CPU1
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * 3. Some work has to be done after expiring the timers of CPU0. If we stop
+ *    here, then CPU1's pending global timer(s) will not expire in time and the
+ *    timerqueue of GRP0:0 has still an event for CPU0 enqueued which has just
+ *    been processed. So it is required to walk the hierarchy from CPU0's point
+ *    of view and update it accordingly. CPU0's event will be removed from the
+ *    timerqueue because it has no pending timer. If CPU0 would have a timer
+ *    pending then it has to expire after CPU1's first timer because all timers
+ *    from this period were just expired. Either way CPU1's event will be first
+ *    in GRP0:0's timerqueue and therefore set in the CPU field of the group
+ *    event which is then enqueued in GRP1:0's timerqueue as GRP0:0 is still not
+ *    active:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator = GRP0:1
+ *                     active   = GRP0:1
+ *                 --> timerqueue = evt-GRP0:0
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator = TMIGR_NONE     migrator = CPU2
+ *           active   =                active   = CPU2
+ *           groupevt.ignore = false   groupevt.ignore = true
+ *       --> groupevt.cpu = CPU1       groupevt.cpu =
+ *       --> timerqueue = evt-CPU1     timerqueue =
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * Now CPU2 (migrator) will continue step 2 at GRP1:0 and will expire the
+ * timer(s) of CPU1.
+ *
+ * The hierarchy walk in step 3 can be skipped if the migrator notices that a
+ * CPU of GRP0:0 is active again. The CPU will mark GRP0:0 active and take care
+ * of the group as migrator and any needed updates within the hierarchy.
+ */
+
+static DEFINE_MUTEX(tmigr_mutex);
+static struct list_head *tmigr_level_list __read_mostly;
+
+static unsigned int tmigr_hierarchy_levels __read_mostly;
+static unsigned int tmigr_crossnode_level __read_mostly;
+
+static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
+
+#define TMIGR_NONE	0xFF
+#define BIT_CNT		8
+
+static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
+{
+	return !(tmc->tmgroup && tmc->online);
+}
+
+/*
+ * Returns true, when @childmask corresponds to the group migrator or when the
+ * group is not active - so no migrator is set.
+ */
+static bool tmigr_check_migrator(struct tmigr_group *group, u8 childmask)
+{
+	union tmigr_state s;
+
+	s.state = atomic_read(&group->migr_state);
+
+	if ((s.migrator == childmask) || (s.migrator == TMIGR_NONE))
+		return true;
+
+	return false;
+}
+
+static bool tmigr_check_migrator_and_lonely(struct tmigr_group *group, u8 childmask)
+{
+	bool lonely, migrator = false;
+	unsigned long active;
+	union tmigr_state s;
+
+	s.state = atomic_read(&group->migr_state);
+
+	if ((s.migrator == childmask) || (s.migrator == TMIGR_NONE))
+		migrator = true;
+
+	active = s.active;
+	lonely = bitmap_weight(&active, BIT_CNT) <= 1;
+
+	return (migrator && lonely);
+}
+
+static bool tmigr_check_lonely(struct tmigr_group *group)
+{
+	unsigned long active;
+	union tmigr_state s;
+
+	s.state = atomic_read(&group->migr_state);
+
+	active = s.active;
+
+	return bitmap_weight(&active, BIT_CNT) <= 1;
+}
+
+typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, void *);
+
+static void __walk_groups(up_f up, void *data,
+			  struct tmigr_cpu *tmc)
+{
+	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
+
+	do {
+		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
+
+		if (up(group, child, data))
+			break;
+
+		child = group;
+		group = group->parent;
+	} while (group);
+}
+
+static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
+{
+	lockdep_assert_held(&tmc->lock);
+
+	__walk_groups(up, data, tmc);
+}
+
+/**
+ * struct tmigr_walk - data required for walking the hierarchy
+ * @nextexp:		Next CPU event expiry information which is handed into
+ *			the timer migration code by the timer code
+ *			(get_next_timer_interrupt())
+ * @firstexp:		Contains the first event expiry information when last
+ *			active CPU of hierarchy is on the way to idle to make
+ *			sure CPU will be back in time.
+ * @evt:		Pointer to tmigr_event which needs to be queued (of idle
+ *			child group)
+ * @childmask:		childmask of child group
+ * @remote:		Is set, when the new timer path is executed in
+ *			tmigr_handle_remote_cpu()
+ */
+struct tmigr_walk {
+	u64			nextexp;
+	u64			firstexp;
+	struct tmigr_event	*evt;
+	u8			childmask;
+	bool			remote;
+};
+
+/**
+ * struct tmigr_remote_data - data required for remote expiry hierarchy walk
+ * @basej:		timer base in jiffies
+ * @now:		timer base monotonic
+ * @firstexp:		returns expiry of the first timer in the idle timer
+ *			migration hierarchy to make sure the timer is handled in
+ *			time; it is stored in the per CPU tmigr_cpu struct of
+ *			CPU which expires remote timers
+ * @childmask:		childmask of child group
+ * @check:		is set if there is the need to handle remote timers;
+ *			required in tmigr_check_handle_remote() only
+ * @tmc_active:		this flag indicates, whether the CPU which triggers
+ *			the hierarchy walk is !idle in the timer migration
+ *			hierarchy. When the CPU is idle and the whole hierarchy is
+ *			idle, only the first event of the top level has to be
+ *			considered.
+ */
+struct tmigr_remote_data {
+	unsigned long	basej;
+	u64		now;
+	u64		firstexp;
+	u8		childmask;
+	bool		check;
+	bool		tmc_active;
+};
+
+/*
+ * Returns the next event of the timerqueue @group->events
+ *
+ * Removes timers with ignore flag and update next_expiry of the group. Values
+ * of the group event are updated in tmigr_update_events() only.
+ */
+static struct tmigr_event *tmigr_next_groupevt(struct tmigr_group *group)
+{
+	struct timerqueue_node *node = NULL;
+	struct tmigr_event *evt = NULL;
+
+	lockdep_assert_held(&group->lock);
+
+	WRITE_ONCE(group->next_expiry, KTIME_MAX);
+
+	while ((node = timerqueue_getnext(&group->events))) {
+		evt = container_of(node, struct tmigr_event, nextevt);
+
+		if (!evt->ignore) {
+			WRITE_ONCE(group->next_expiry, evt->nextevt.expires);
+			return evt;
+		}
+
+		/*
+		 * Remove next timers with ignore flag, because the group lock
+		 * is held anyway
+		 */
+		if (!timerqueue_del(&group->events, node))
+			break;
+	}
+
+	return NULL;
+}
+
+/*
+ * Return the next event (with the expiry equal or before @now)
+ *
+ * Event, which is returned, is also removed from the queue.
+ */
+static struct tmigr_event *tmigr_next_expired_groupevt(struct tmigr_group *group,
+						     u64 now)
+{
+	struct tmigr_event *evt = tmigr_next_groupevt(group);
+
+	if (!evt || now < evt->nextevt.expires)
+		return NULL;
+
+	/*
+	 * The event is ready to expire. Remove it and update next group event.
+	 */
+	timerqueue_del(&group->events, &evt->nextevt);
+	tmigr_next_groupevt(group);
+
+	return evt;
+}
+
+static u64 tmigr_next_groupevt_expires(struct tmigr_group *group)
+{
+	struct tmigr_event *evt;
+
+	evt = tmigr_next_groupevt(group);
+
+	if (!evt)
+		return KTIME_MAX;
+	else
+		return evt->nextevt.expires;
+}
+
+static bool tmigr_active_up(struct tmigr_group *group,
+			    struct tmigr_group *child,
+			    void *ptr)
+{
+	union tmigr_state curstate, newstate;
+	struct tmigr_walk *data = ptr;
+	bool walk_done;
+	u8 childmask;
+
+	childmask = data->childmask;
+	curstate.state = atomic_read(&group->migr_state);
+
+	do {
+		newstate = curstate;
+		walk_done = true;
+
+		if (newstate.migrator == TMIGR_NONE) {
+			newstate.migrator = childmask;
+
+			/* Changes need to be propagated */
+			walk_done = false;
+		}
+
+		newstate.active |= childmask;
+		newstate.seq++;
+
+	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));
+
+
+	if ((walk_done == false) && group->parent)
+		data->childmask = group->childmask;
+
+	/*
+	 * The group is active (again). The group event might be still queued
+	 * into the parent group's timerqueue but can now be handled by the
+	 * migrator of this group. Therefore the ignore flag for the group event
+	 * is updated to reflect this.
+	 *
+	 * The update of the ignore flag in the active path is done lockless. In
+	 * worst case the migrator of the parent group observes the change too
+	 * late and expires remotely all events belonging to this group. The
+	 * lock is held while updating the ignore flag in idle path. So this
+	 * state change will not be lost.
+	 */
+	group->groupevt.ignore = true;
+
+	return walk_done;
+}
+
+static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
+{
+	struct tmigr_walk data;
+
+	data.childmask = tmc->childmask;
+
+	tmc->cpuevt.ignore = true;
+	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+	tmc->wakeup_recalc = false;
+
+	walk_groups(&tmigr_active_up, &data, tmc);
+}
+
+/**
+ * tmigr_cpu_activate() - set this CPU active in timer migration hierarchy
+ *
+ * Call site timer_clear_idle() is called with interrupts disabled.
+ */
+void tmigr_cpu_activate(void)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+
+	if (tmigr_is_not_available(tmc))
+		return;
+
+	if (WARN_ON_ONCE(!tmc->idle))
+		return;
+
+	raw_spin_lock(&tmc->lock);
+	tmc->idle = false;
+	__tmigr_cpu_activate(tmc);
+	raw_spin_unlock(&tmc->lock);
+}
+
+/*
+ * Returns true, if there is nothing to be propagated to the next level
+ *
+ * @data->firstexp is set to expiry of first gobal event of the (top level of
+ * the) hierarchy, but only when hierarchy is completely idle.
+ *
+ * This is the only place where the group event expiry value is set.
+ */
+static
+bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
+			 struct tmigr_walk *data, union tmigr_state childstate,
+			 union tmigr_state groupstate)
+{
+	struct tmigr_event *evt, *first_childevt;
+	bool walk_done, remote = data->remote;
+	bool leftmost_change = false;
+	u64 nextexp;
+
+	if (child) {
+		raw_spin_lock(&child->lock);
+		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
+
+		if (childstate.active) {
+			walk_done = true;
+			goto unlock;
+		}
+
+		first_childevt = tmigr_next_groupevt(child);
+		nextexp = child->next_expiry;
+		evt = &child->groupevt;
+	} else {
+		nextexp = data->nextexp;
+
+		first_childevt = evt = data->evt;
+
+		/*
+		 * Walking the hierarchy is required in any case when a
+		 * remote expiry was done before. This ensures to not lose
+		 * already queued events in non active groups (see section
+		 * "Required event and timerqueue update after a remote
+		 * expiry" in the documentation at the top).
+		 *
+		 * The two call sites which are executed without a remote expiry
+		 * before, are not prevented from propagating changes through
+		 * the hierarchy by the return:
+		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
+		 *    is never set.
+		 *  - tmigr_inactive_up() takes care of the propagation by
+		 *    itself and ignores the return value. But an immediate
+		 *    return is required because nothing has to be done in this
+		 *    level as the event could be ignored.
+		 */
+		if (evt->ignore && !remote)
+			return true;
+
+		raw_spin_lock(&group->lock);
+	}
+
+	if (nextexp == KTIME_MAX) {
+		evt->ignore = true;
+
+		/*
+		 * When the next child event could be ignored (nextexp is
+		 * KTIME_MAX) and there was no remote timer handling before or
+		 * the group is already active, there is no need to walk the
+		 * hierarchy even if there is a parent group.
+		 *
+		 * The other way round: even if the event could be ignored, but
+		 * if a remote timer handling was executed before and the group
+		 * is not active, walking the hierarchy is required to not miss
+		 * an enqueued timer in the non active group. The enqueued timer
+		 * of the group needs to be propagated to a higher level to
+		 * ensure it is handled.
+		 */
+		if (!remote || groupstate.active) {
+			walk_done = true;
+			goto unlock;
+		}
+	} else {
+		/*
+		 * An update of @evt->cpu and @evt->ignore flag is required only
+		 * when @child is set (the child is equal or higher than lvl0),
+		 * but it doesn't matter if it is written once more to the per
+		 * CPU event; make the update unconditional.
+		 */
+		evt->cpu = first_childevt->cpu;
+		evt->ignore = false;
+	}
+
+	walk_done = !group->parent;
+
+	/*
+	 * If the child event is already queued in the group, remove it from the
+	 * queue when the expiry time changed only.
+	 */
+	if (timerqueue_node_queued(&evt->nextevt)) {
+		if (evt->nextevt.expires == nextexp)
+			goto check_toplvl;
+
+		leftmost_change = timerqueue_getnext(&group->events) == &evt->nextevt;
+		if (!timerqueue_del(&group->events, &evt->nextevt))
+			WRITE_ONCE(group->next_expiry, KTIME_MAX);
+	}
+
+	evt->nextevt.expires = nextexp;
+
+	if (timerqueue_add(&group->events, &evt->nextevt)) {
+		leftmost_change = true;
+		WRITE_ONCE(group->next_expiry, nextexp);
+	}
+
+check_toplvl:
+	if (walk_done && (groupstate.migrator == TMIGR_NONE)) {
+		/*
+		 * Nothing to do when first event didn't changed and update was
+		 * done during remote timer handling.
+		 */
+		if (remote && !leftmost_change)
+			goto unlock;
+		/*
+		 * The top level group is idle and it has to be ensured the
+		 * global timers are handled in time. (This could be optimized
+		 * by keeping track of the last global scheduled event and only
+		 * arming it on the CPU if the new event is earlier. Not sure if
+		 * its worth the complexity.)
+		 */
+		data->firstexp = tmigr_next_groupevt_expires(group);
+	}
+
+unlock:
+	raw_spin_unlock(&group->lock);
+
+	if (child)
+		raw_spin_unlock(&child->lock);
+
+	return walk_done;
+}
+
+static bool tmigr_new_timer_up(struct tmigr_group *group,
+			       struct tmigr_group *child,
+			       void *ptr)
+{
+	union tmigr_state childstate, groupstate;
+	struct tmigr_walk *data = ptr;
+
+	if (child)
+		childstate.state = atomic_read(&child->migr_state);
+	else
+		childstate.state = 0;
+
+	groupstate.state = atomic_read(&group->migr_state);
+
+	return tmigr_update_events(group, child, data, childstate, groupstate);
+}
+
+/*
+ * Returns the expiry of the next timer that needs to be handled. KTIME_MAX is
+ * returned, if an active CPU will handle all the timer migration hierarchy
+ * timers.
+ */
+static u64 tmigr_new_timer(struct tmigr_cpu *tmc, u64 nextexp)
+{
+	struct tmigr_walk data = { .nextexp = nextexp,
+				   .firstexp = KTIME_MAX,
+				   .evt = &tmc->cpuevt };
+
+	lockdep_assert_held(&tmc->lock);
+
+	if (tmc->remote)
+		return KTIME_MAX;
+
+	tmc->cpuevt.ignore = false;
+	data.remote = false;
+
+	walk_groups(&tmigr_new_timer_up, &data, tmc);
+
+	/* If there is a new first global event, make sure it is handled */
+	return data.firstexp;
+}
+
+static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
+				   unsigned long jif)
+{
+	struct timer_events tevt;
+	struct tmigr_walk data;
+	struct tmigr_cpu *tmc;
+	u64 next = KTIME_MAX;
+
+	tmc = per_cpu_ptr(&tmigr_cpu, cpu);
+
+	raw_spin_lock_irq(&tmc->lock);
+
+	/*
+	 * If the remote CPU is offline then the timers have been migrated to
+	 * another CPU.
+	 *
+	 * If tmigr_cpu::remote is set, at the moment another CPU already
+	 * expires the timers of the remote CPU.
+	 *
+	 * If tmigr_event::ignore is set, then the CPU returns from idle and
+	 * takes care of its timers.
+	 *
+	 * If the next event expires in the future, then the event has been
+	 * updated and there are no timers to expire right now. The CPU which
+	 * updated the event takes care when hierarchy is completely
+	 * idle. Otherwise the migrator does it as the event is enqueued.
+	 */
+	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
+	    now < tmc->cpuevt.nextevt.expires) {
+		raw_spin_unlock_irq(&tmc->lock);
+		return next;
+	}
+
+	tmc->remote = true;
+	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+
+	/* Drop the lock to allow the remote CPU to exit idle */
+	raw_spin_unlock_irq(&tmc->lock);
+
+	if (cpu != smp_processor_id())
+		timer_expire_remote(cpu);
+
+	/*
+	 * Lock ordering needs to be preserved - timer_base locks before tmigr
+	 * related locks (see section "Locking rules" in the documentation at
+	 * the top). During fetching the next timer interrupt, also tmc->lock
+	 * needs to be held. Otherwise there is a possible race window against
+	 * the CPU itself when it comes out of idle, updates the first timer in
+	 * the hierarchy and goes back to idle.
+	 *
+	 * timer base locks are dropped as fast as possible: After checking
+	 * whether the remote CPU went offline in the meantime and after
+	 * fetching the next remote timer interrupt. Dropping the locks as fast
+	 * as possible keeps the locking region small and prevents holding
+	 * several (unnecessary) locks during walking the hierarchy for updating
+	 * the timerqueue and group events.
+	 */
+	local_irq_disable();
+	timer_lock_remote_bases(cpu);
+	raw_spin_lock(&tmc->lock);
+
+	/*
+	 * When the CPU went offline in the meantime, no hierarchy walk has to
+	 * be done for updating the queued events, because the walk was
+	 * already done during marking the CPU offline in the hierarchy.
+	 *
+	 * When the CPU is no longer idle, the CPU takes care of the timers and
+	 * also of the timers in the hierarchy.
+	 *
+	 * (See also section "Required event and timerqueue update after a
+	 * remote expiry" in the documentation at the top)
+	 */
+	if (!tmc->online || !tmc->idle) {
+		timer_unlock_remote_bases(cpu);
+		goto unlock;
+	} else {
+		/* next	event of CPU */
+		fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);
+	}
+
+	timer_unlock_remote_bases(cpu);
+
+	data.nextexp = tevt.global;
+	data.firstexp = KTIME_MAX;
+	data.evt = &tmc->cpuevt;
+	data.remote = true;
+
+	/*
+	 * The update is done even when there is no 'new' global timer pending
+	 * on the remote CPU (see section "Required event and timerqueue update
+	 * after a remote expiry" in the documentation at the top)
+	 */
+	walk_groups(&tmigr_new_timer_up, &data, tmc);
+
+	next = data.firstexp;
+
+unlock:
+	tmc->remote = false;
+	raw_spin_unlock_irq(&tmc->lock);
+
+	return next;
+}
+
+static bool tmigr_handle_remote_up(struct tmigr_group *group,
+				   struct tmigr_group *child,
+				   void *ptr)
+{
+	struct tmigr_remote_data *data = ptr;
+	u64 now, next = KTIME_MAX;
+	struct tmigr_event *evt;
+	unsigned long jif;
+	u8 childmask;
+
+	jif = data->basej;
+	now = data->now;
+
+	childmask = data->childmask;
+
+again:
+	/*
+	 * Handle the group only if @childmask is the migrator or if the
+	 * group has no migrator. Otherwise the group is active and is
+	 * handled by its own migrator.
+	 */
+	if (!tmigr_check_migrator(group, childmask))
+		return true;
+
+	raw_spin_lock_irq(&group->lock);
+
+	evt = tmigr_next_expired_groupevt(group, now);
+
+	if (evt) {
+		unsigned int remote_cpu = evt->cpu;
+
+		raw_spin_unlock_irq(&group->lock);
+
+		next = tmigr_handle_remote_cpu(remote_cpu, now, jif);
+
+		/* check if there is another event, that needs to be handled */
+		goto again;
+	} else {
+		raw_spin_unlock_irq(&group->lock);
+	}
+
+	/*
+	 * Update of childmask for the next level and keep track of the expiry
+	 * of the first event that needs to be handled
+	 */
+	data->childmask = group->childmask;
+	data->firstexp = next;
+
+	return false;
+}
+
+/**
+ * tmigr_handle_remote() - Handle global timers of remote idle CPUs
+ *
+ * Called from the timer soft interrupt with interrupts enabled.
+ */
+void tmigr_handle_remote(void)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_remote_data data;
+
+	if (tmigr_is_not_available(tmc))
+		return;
+
+	data.childmask = tmc->childmask;
+	data.firstexp = KTIME_MAX;
+
+	/*
+	 * NOTE: This is a doubled check because the migrator test will be done
+	 * in tmigr_handle_remote_up() anyway. Keep this check to speed up the
+	 * return when nothing has to be done.
+	 */
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
+		return;
+
+	data.now = get_jiffies_update(&data.basej);
+
+	/*
+	 * Update @tmc->wakeup only at the end and do not reset @tmc->wakeup to
+	 * KTIME_MAX. Even if tmc->lock is not held during the whole remote
+	 * handling, tmc->wakeup is fine to be stale as it is called in
+	 * interrupt context and tick_nohz_next_event() is executed in interrupt
+	 * exit path only after processing the last pending interrupt.
+	 */
+
+	__walk_groups(&tmigr_handle_remote_up, &data, tmc);
+
+	raw_spin_lock_irq(&tmc->lock);
+	WRITE_ONCE(tmc->wakeup, data.firstexp);
+	raw_spin_unlock_irq(&tmc->lock);
+}
+
+static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
+					    struct tmigr_group *child,
+					    void *ptr)
+{
+	struct tmigr_remote_data *data = ptr;
+	u8 childmask;
+
+	childmask = data->childmask;
+
+	/*
+	 * Handle the group only if the child is the migrator or if the group
+	 * has no migrator. Otherwise the group is active and is handled by its
+	 * own migrator.
+	 */
+	if (!tmigr_check_migrator(group, childmask))
+		return true;
+
+	/*
+	 * When there is a parent group and the CPU which triggered the
+	 * hierarchy walk is not active, proceed the walk to reach the top level
+	 * group before reading the next_expiry value.
+	 */
+	if (group->parent && !data->tmc_active)
+		goto out;
+
+	/*
+	 * The lock is required on 32bit architectures to read the variable
+	 * consistently with a concurrent writer. On 64bit the lock is not
+	 * required because the read operation is not split and so it is always
+	 * consistent.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		data->firstexp = READ_ONCE(group->next_expiry);
+		if (data->now >= data->firstexp) {
+			data->check = true;
+			return true;
+		}
+	} else {
+		raw_spin_lock(&group->lock);
+		data->firstexp = group->next_expiry;
+		if (data->now >= group->next_expiry) {
+			data->check = true;
+			raw_spin_unlock(&group->lock);
+			return true;
+		}
+		raw_spin_unlock(&group->lock);
+	}
+
+out:
+	/* Update of childmask for the next level */
+	data->childmask = group->childmask;
+	return false;
+}
+
+/**
+ * tmigr_requires_handle_remote() - Check the need of remote timer handling
+ *
+ * Must be called with interrupts disabled.
+ */
+int tmigr_requires_handle_remote(void)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_remote_data data;
+	unsigned int ret = 0;
+	unsigned long jif;
+
+	if (tmigr_is_not_available(tmc))
+		return ret;
+
+	data.now = get_jiffies_update(&jif);
+	data.childmask = tmc->childmask;
+	data.firstexp = KTIME_MAX;
+	data.tmc_active = !tmc->idle;
+	data.check = false;
+
+	/*
+	 * If the CPU is active, walk the hierarchy to check whether a remote
+	 * expiry is required.
+	 *
+	 * Check is done lockless as interrupts are disabled and @tmc->idle is
+	 * set only by the local CPU.
+	 */
+	if (!tmc->idle) {
+		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
+
+		if (data.firstexp != KTIME_MAX)
+			ret = 1;
+
+		return ret;
+	}
+
+	/*
+	 * If the CPU is idle, check whether the recalculation of @tmc->wakeup
+	 * is required. @tmc->wakeup_recalc is set, when the last active CPU
+	 * went offline. The last active CPU delegated the handling of the timer
+	 * migration hierarchy to another (this) CPU by updating this flag and
+	 * sending a reschedule.
+	 *
+	 * Racy lockless check is valid:
+	 * - @tmc->wakeup_recalc is set by the remote CPU before it issues
+	 *   reschedule IPI.
+	 * - As interrupts are disabled here this CPU will either observe
+	 *   @tmc->wakeup_recalc set before the reschedule IPI can be handled or
+	 *   it will observe it when this function is called again on return
+	 *   from handling the reschedule IPI.
+	 */
+	if (tmc->wakeup_recalc) {
+		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
+
+		if (data.firstexp != KTIME_MAX)
+			ret = 1;
+
+		raw_spin_lock(&tmc->lock);
+		WRITE_ONCE(tmc->wakeup, data.firstexp);
+		tmc->wakeup_recalc = false;
+		raw_spin_unlock(&tmc->lock);
+
+		return ret;
+	}
+
+	/*
+	 * When the CPU is idle and @tmc->wakeup is reliable as
+	 * @tmc->wakeup_recalc is not set, compare it with @data.now. The lock
+	 * is required on 32bit architectures to read the variable consistently
+	 * with a concurrent writer. On 64bit the lock is not required because
+	 * the read operation is not split and so it is always consistent.
+
+	 */
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		if (data.now >= READ_ONCE(tmc->wakeup))
+			ret = 1;
+	} else {
+		raw_spin_lock(&tmc->lock);
+		if (data.now >= tmc->wakeup)
+			ret = 1;
+		raw_spin_unlock(&tmc->lock);
+	}
+
+	return ret;
+}
+
+/**
+ * tmigr_cpu_new_timer() - enqueue next global timer into hierarchy (idle tmc)
+ * @nextexp:	Next expiry of global timer (or KTIME_MAX if not)
+ *
+ * The CPU is already deactivated in the timer migration
+ * hierarchy. tick_nohz_get_sleep_length() calls tick_nohz_next_event()
+ * and thereby the timer idle path is executed once more. @tmc->wakeup
+ * holds the first timer, when the timer migration hierarchy is
+ * completely idle.
+ *
+ * Returns the first timer that needs to be handled by this CPU or KTIME_MAX if
+ * nothing needs to be done.
+ */
+u64 tmigr_cpu_new_timer(u64 nextexp)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	u64 ret;
+
+	if (tmigr_is_not_available(tmc))
+		return nextexp;
+
+	raw_spin_lock(&tmc->lock);
+
+	ret = READ_ONCE(tmc->wakeup);
+	if (nextexp != KTIME_MAX) {
+		if (nextexp != tmc->cpuevt.nextevt.expires ||
+		    tmc->cpuevt.ignore) {
+			ret = tmigr_new_timer(tmc, nextexp);
+		}
+	} else if (tmc->wakeup_recalc) {
+		struct tmigr_remote_data data;
+
+		data.now = KTIME_MAX;
+		data.childmask = tmc->childmask;
+		data.firstexp = KTIME_MAX;
+		data.tmc_active = false;
+		data.check = false;
+
+		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
+
+		ret = data.firstexp;
+	}
+	tmc->wakeup_recalc = false;
+
+	/*
+	 * Make sure the reevaluation of timers in idle path will not miss an
+	 * event.
+	 */
+	WRITE_ONCE(tmc->wakeup, ret);
+
+	raw_spin_unlock(&tmc->lock);
+	return ret;
+}
+
+static bool tmigr_inactive_up(struct tmigr_group *group,
+			      struct tmigr_group *child,
+			      void *ptr)
+{
+	union tmigr_state curstate, newstate, childstate;
+	struct tmigr_walk *data = ptr;
+	bool walk_done;
+	u8 childmask;
+
+	childmask = data->childmask;
+	curstate.state = atomic_read(&group->migr_state);
+	childstate.state = 0;
+
+	do {
+		if (child)
+			childstate.state = atomic_read(&child->migr_state);
+
+		newstate = curstate;
+		walk_done = true;
+
+		/* Reset active bit when the child is no longer active */
+		if (!childstate.active)
+			newstate.active &= ~childmask;
+
+		if (newstate.migrator == childmask) {
+			/*
+			 * Find a new migrator for the group, because the child
+			 * group is idle!
+			 */
+			if (!childstate.active) {
+				unsigned long new_migr_bit, active = newstate.active;
+
+				new_migr_bit = find_first_bit(&active, BIT_CNT);
+
+				if (new_migr_bit != BIT_CNT) {
+					newstate.migrator = BIT(new_migr_bit);
+				} else {
+					newstate.migrator = TMIGR_NONE;
+
+					/* Changes need to be propagated */
+					walk_done = false;
+				}
+			}
+		}
+
+		newstate.seq++;
+
+		WARN_ON_ONCE((newstate.migrator != TMIGR_NONE) && !(newstate.active));
+
+	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));
+
+	data->remote = false;
+
+	/* Event Handling */
+	tmigr_update_events(group, child, data, childstate, newstate);
+
+	if (group->parent && (walk_done == false))
+		data->childmask = group->childmask;
+
+	/*
+	 * data->firstexp was set by tmigr_update_events() and contains the
+	 * expiry of the first global event which needs to be handled. It
+	 * differs from KTIME_MAX if:
+	 * - group is the top level group and
+	 * - group is idle (which means CPU was the last active CPU in the
+	 *   hierarchy) and
+	 * - there is a pending event in the hierarchy
+	 */
+	if (data->firstexp != KTIME_MAX) {
+		WARN_ON_ONCE(group->parent);
+		/*
+		 * Top level path: If this CPU is about going offline and was
+		 * the last active CPU, wake up some random other CPU so it will
+		 * take over the migrator duty and program its timer
+		 * properly. Ideally wake the CPU with the closest expiry time,
+		 * but that's overkill to figure out.
+		 *
+		 * Set wakeup_recalc of remote CPU, to make sure the complete
+		 * idle hierarchy with enqueued timers is reevaluated.
+		 */
+		if (!(this_cpu_ptr(&tmigr_cpu)->online)) {
+			struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+			unsigned int cpu = smp_processor_id();
+			struct tmigr_cpu *tmc_resched;
+
+			cpu = cpumask_any_but(cpu_online_mask, cpu);
+			tmc_resched = per_cpu_ptr(&tmigr_cpu, cpu);
+
+			raw_spin_unlock(&tmc->lock);
+
+			raw_spin_lock(&tmc_resched->lock);
+			tmc_resched->wakeup_recalc = true;
+			raw_spin_unlock(&tmc_resched->lock);
+
+			raw_spin_lock(&tmc->lock);
+			smp_send_reschedule(cpu);
+		}
+	}
+
+	return walk_done;
+}
+
+static u64 __tmigr_cpu_deactivate(struct tmigr_cpu *tmc, u64 nextexp)
+{
+	struct tmigr_walk data = { .nextexp = nextexp,
+				   .firstexp = KTIME_MAX,
+				   .evt = &tmc->cpuevt,
+				   .childmask = tmc->childmask };
+
+	/*
+	 * If nextexp is KTIME_MAX, the CPU event will be ignored because the
+	 * local timer expires before the global timer, no global timer is set
+	 * or CPU goes offline.
+	 */
+	if (nextexp != KTIME_MAX)
+		tmc->cpuevt.ignore = false;
+
+	walk_groups(&tmigr_inactive_up, &data, tmc);
+	return data.firstexp;
+}
+
+/**
+ * tmigr_cpu_deactivate() - Put current CPU into inactive state
+ * @nextexp:	The next timer event expiry set in the current CPU
+ *
+ * Must be called with interrupts disabled.
+ *
+ * Return: the next event expiry of the current CPU or the next event expiry
+ * from the hierarchy if this CPU is the top level migrator or the hierarchy is
+ * completely idle.
+ */
+u64 tmigr_cpu_deactivate(u64 nextexp)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	u64 ret;
+
+	if (tmigr_is_not_available(tmc))
+		return nextexp;
+
+	raw_spin_lock(&tmc->lock);
+
+	ret = __tmigr_cpu_deactivate(tmc, nextexp);
+
+	tmc->idle = true;
+
+	/*
+	 * Make sure the reevaluation of timers in idle path will not miss an
+	 * event.
+	 */
+	WRITE_ONCE(tmc->wakeup, ret);
+
+	raw_spin_unlock(&tmc->lock);
+	return ret;
+}
+
+/**
+ * tmigr_quick_check() - Quick forecast of next tmigr event when CPU wants to
+ *			 go idle
+ *
+ * Returns KTIME_MAX, when it is probable that nothing has to be done (not the
+ * only one in the level 0 group; and if it is the only one in level 0 group,
+ * but there are more than a single group active in top level)
+ *
+ * Returns first expiry of the top level group, when it is the only one in level
+ * 0 and top level also only has a single active child.
+ */
+u64 tmigr_quick_check(void)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_group *topgroup;
+	struct list_head lvllist;
+
+	if (tmigr_is_not_available(tmc))
+		return KTIME_MAX;
+
+	if (WARN_ON_ONCE(tmc->idle))
+		return KTIME_MAX;
+
+	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->childmask))
+		return KTIME_MAX;
+
+	for (int i = tmigr_hierarchy_levels; i > 0 ; i--) {
+		lvllist = tmigr_level_list[i - 1];
+		if (list_is_singular(&lvllist)) {
+			topgroup = list_first_entry(&lvllist, struct tmigr_group, list);
+
+			if (tmigr_check_lonely(topgroup))
+				return READ_ONCE(topgroup->next_expiry);
+		} else {
+			continue;
+		}
+	}
+
+	return KTIME_MAX;
+}
+
+static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
+			     int node)
+{
+	union tmigr_state s;
+
+	raw_spin_lock_init(&group->lock);
+
+	group->level = lvl;
+	group->numa_node = lvl < tmigr_crossnode_level ? node : NUMA_NO_NODE;
+
+	group->num_children = 0;
+
+	s.migrator = TMIGR_NONE;
+	s.active = 0;
+	s.seq = 0;
+	atomic_set(&group->migr_state, s.state);
+
+	timerqueue_init_head(&group->events);
+	timerqueue_init(&group->groupevt.nextevt);
+	group->groupevt.nextevt.expires = KTIME_MAX;
+	WRITE_ONCE(group->next_expiry, KTIME_MAX);
+	group->groupevt.ignore = true;
+}
+
+static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
+					   unsigned int lvl)
+{
+	struct tmigr_group *tmp, *group = NULL;
+
+	lockdep_assert_held(&tmigr_mutex);
+
+	/* Try to attach to an existing group first */
+	list_for_each_entry(tmp, &tmigr_level_list[lvl], list) {
+		/*
+		 * If @lvl is below the cross NUMA node level, check whether
+		 * this group belongs to the same NUMA node.
+		 */
+		if (lvl < tmigr_crossnode_level && tmp->numa_node != node)
+			continue;
+
+		/* Capacity left? */
+		if (tmp->num_children >= TMIGR_CHILDREN_PER_GROUP)
+			continue;
+
+		/*
+		 * TODO: A possible further improvement: Make sure that all CPU
+		 * siblings end up in the same group of the lowest level of the
+		 * hierarchy. Rely on the topology sibling mask would be a
+		 * reasonable solution.
+		 */
+
+		group = tmp;
+		break;
+	}
+
+	if (group)
+		return group;
+
+	/* Allocate and	set up a new group */
+	group = kzalloc_node(sizeof(*group), GFP_KERNEL, node);
+	if (!group)
+		return ERR_PTR(-ENOMEM);
+
+	tmigr_init_group(group, lvl, node);
+
+	/* Setup successful. Add it to the hierarchy */
+	list_add(&group->list, &tmigr_level_list[lvl]);
+	return group;
+}
+
+static void tmigr_connect_child_parent(struct tmigr_group *child,
+				       struct tmigr_group *parent)
+{
+	union tmigr_state childstate;
+
+	raw_spin_lock_irq(&child->lock);
+	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
+
+	child->parent = parent;
+	child->childmask = BIT(parent->num_children++);
+
+	raw_spin_unlock(&parent->lock);
+	raw_spin_unlock_irq(&child->lock);
+
+	/*
+	 * To prevent inconsistent states, active children need to be active in
+	 * the new parent as well. Inactive children are already marked inactive
+	 * in the parent group.
+	 */
+	childstate.state = atomic_read(&child->migr_state);
+	if (childstate.migrator != TMIGR_NONE) {
+		struct tmigr_walk data;
+
+		data.childmask = child->childmask;
+
+		/*
+		 * There is only one new level per time. When connecting the
+		 * child and the parent and set the child active when the parent
+		 * is inactive, the parent needs to be the uppermost
+		 * level. Otherwise there went something wrong!
+		 */
+		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
+	}
+}
+
+static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
+{
+	struct tmigr_group *group, *child, **stack;
+	int top = 0, err = 0, i = 0;
+	struct list_head *lvllist;
+
+	stack = kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
+	if (!stack)
+		return -ENOMEM;
+
+	do {
+		group = tmigr_get_group(cpu, node, i);
+		if (IS_ERR(group)) {
+			err = PTR_ERR(group);
+			break;
+		}
+
+		top = i;
+		stack[i++] = group;
+
+		/*
+		 * When booting only less CPUs of a system than CPUs are
+		 * available, not all calculated hierarchy levels are required.
+		 *
+		 * The loop is aborted as soon as the highest level, which might
+		 * be different from tmigr_hierarchy_levels, contains only a
+		 * single group.
+		 */
+		if (group->parent || i == tmigr_hierarchy_levels ||
+		    (list_empty(&tmigr_level_list[i]) &&
+		     list_is_singular(&tmigr_level_list[i - 1])))
+			break;
+
+	} while (i < tmigr_hierarchy_levels);
+
+	do {
+		group = stack[--i];
+
+		if (err < 0) {
+			list_del(&group->list);
+			kfree(group);
+			continue;
+		}
+
+		WARN_ON_ONCE(i != group->level);
+
+		/*
+		 * Update tmc -> group / child -> group connection
+		 */
+		if (i == 0) {
+			struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+
+			raw_spin_lock_irq(&group->lock);
+
+			tmc->tmgroup = group;
+			tmc->childmask = BIT(group->num_children++);
+
+			raw_spin_unlock_irq(&group->lock);
+
+			/* There are no children that need to be connected */
+			continue;
+		} else {
+			child = stack[i - 1];
+			tmigr_connect_child_parent(child, group);
+		}
+
+		/* check if uppermost level was newly created */
+		if (top != i)
+			continue;
+
+		WARN_ON_ONCE(top == 0);
+
+		lvllist = &tmigr_level_list[top];
+		if (group->num_children == 1 && list_is_singular(lvllist)) {
+			lvllist = &tmigr_level_list[top - 1];
+			list_for_each_entry(child, lvllist, list) {
+				if (child->parent)
+					continue;
+
+				tmigr_connect_child_parent(child, group);
+			}
+		}
+	} while (i > 0);
+
+	kfree(stack);
+
+	return err;
+}
+
+static int tmigr_add_cpu(unsigned int cpu)
+{
+	int node = cpu_to_node(cpu);
+	int ret;
+
+	mutex_lock(&tmigr_mutex);
+	ret = tmigr_setup_groups(cpu, node);
+	mutex_unlock(&tmigr_mutex);
+
+	return ret;
+}
+
+static int tmigr_cpu_online(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	int ret;
+
+	/* First online attempt? Initialize CPU data */
+	if (!tmc->tmgroup) {
+		raw_spin_lock_init(&tmc->lock);
+
+		ret = tmigr_add_cpu(cpu);
+		if (ret < 0)
+			return ret;
+
+		if (tmc->childmask == 0)
+			return -EINVAL;
+
+		timerqueue_init(&tmc->cpuevt.nextevt);
+		tmc->cpuevt.nextevt.expires = KTIME_MAX;
+		tmc->cpuevt.ignore = true;
+		tmc->cpuevt.cpu = cpu;
+
+		tmc->remote = false;
+		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+	}
+	raw_spin_lock_irq(&tmc->lock);
+	tmc->idle = timer_base_is_idle();
+	if (!tmc->idle)
+		__tmigr_cpu_activate(tmc);
+	tmc->online = true;
+	raw_spin_unlock_irq(&tmc->lock);
+	return 0;
+}
+
+static int tmigr_cpu_offline(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+
+	raw_spin_lock_irq(&tmc->lock);
+	tmc->online = false;
+	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+
+	/*
+	 * CPU has to handle the local events on his own, when on the way to
+	 * offline; Therefore nextevt value is set to KTIME_MAX
+	 */
+	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	raw_spin_unlock_irq(&tmc->lock);
+
+	return 0;
+}
+
+static int __init tmigr_init(void)
+{
+	unsigned int cpulvl, nodelvl, cpus_per_node, i;
+	unsigned int nnodes = num_possible_nodes();
+	unsigned int ncpus = num_possible_cpus();
+	int ret = -ENOMEM;
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(TMIGR_CHILDREN_PER_GROUP);
+
+	/* Nothing to do if running on UP */
+	if (ncpus == 1)
+		return 0;
+
+	/*
+	 * Calculate the required hierarchy levels. Unfortunately there is no
+	 * reliable information available, unless all possible CPUs have been
+	 * brought up and all NUMA nodes are populated.
+	 *
+	 * Estimate the number of levels with the number of possible nodes and
+	 * the number of possible CPUs. Assume CPUs are spread evenly across
+	 * nodes. We cannot rely on cpumask_of_node() because it only works for
+	 * online CPUs.
+	 */
+	cpus_per_node = DIV_ROUND_UP(ncpus, nnodes);
+
+	/* Calc the hierarchy levels required to hold the CPUs of a node */
+	cpulvl = DIV_ROUND_UP(order_base_2(cpus_per_node),
+			      ilog2(TMIGR_CHILDREN_PER_GROUP));
+
+	/* Calculate the extra levels to connect all nodes */
+	nodelvl = DIV_ROUND_UP(order_base_2(nnodes),
+			       ilog2(TMIGR_CHILDREN_PER_GROUP));
+
+	tmigr_hierarchy_levels = cpulvl + nodelvl;
+
+	/*
+	 * If a NUMA node spawns more than one CPU level group then the next
+	 * level(s) of the hierarchy contains groups which handle all CPU groups
+	 * of the same NUMA node. The level above goes across NUMA nodes. Store
+	 * this information for the setup code to decide in which level node
+	 * matching is no longer required.
+	 */
+	tmigr_crossnode_level = cpulvl;
+
+	tmigr_level_list = kcalloc(tmigr_hierarchy_levels, sizeof(struct list_head), GFP_KERNEL);
+	if (!tmigr_level_list)
+		goto err;
+
+	for (i = 0; i < tmigr_hierarchy_levels; i++)
+		INIT_LIST_HEAD(&tmigr_level_list[i]);
+
+	pr_info("Timer migration: %d hierarchy levels; %d children per group;"
+		" %d crossnode level\n",
+		tmigr_hierarchy_levels, TMIGR_CHILDREN_PER_GROUP,
+		tmigr_crossnode_level);
+
+	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
+				tmigr_cpu_online, tmigr_cpu_offline);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	pr_err("Timer migration setup failed\n");
+	return ret;
+}
+late_initcall(tmigr_init);
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
new file mode 100644
index 000000000000..c32947cf429b
--- /dev/null
+++ b/kernel/time/timer_migration.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _KERNEL_TIME_MIGRATION_H
+#define _KERNEL_TIME_MIGRATION_H
+
+/* Per group capacity. Must be a power of 2! */
+#define TMIGR_CHILDREN_PER_GROUP 8
+
+/**
+ * struct tmigr_event - a timer event associated to a CPU
+ * @nextevt:	The node to enqueue an event in the parent group queue
+ * @cpu:	The CPU to which this event belongs
+ * @ignore:	Hint whether the event could be ignored; it is set when
+ *		CPU or group is active;
+ */
+struct tmigr_event {
+	struct timerqueue_node	nextevt;
+	unsigned int		cpu;
+	bool			ignore;
+};
+
+/**
+ * struct tmigr_group - timer migration hierarchy group
+ * @lock:		Lock protecting the event information and group hierarchy
+ *			information during setup
+ * @parent:		Pointer to the parent group
+ * @groupevt:		Next event of the group which is only used when the
+ *			group is !active. The group event is then queued into
+ *			the parent timer queue.
+ *			Ignore bit of @groupevt is set when the group is active.
+ * @next_expiry:	Base monotonic expiry time of the next event of the
+ *			group; It is used for the racy lockless check whether a
+ *			remote expiry is required; it is always reliable
+ * @events:		Timer queue for child events queued in the group
+ * @migr_state:		State of the group (see union tmigr_state)
+ * @level:		Hierarchy level of the group; Required during setup
+ * @numa_node:		Required for setup only to make sure CPU and low level
+ *			group information is NUMA local. It is set to NUMA node
+ *			as long as the group level is per NUMA node (level <
+ *			tmigr_crossnode_level); otherwise it is set to
+ *			NUMA_NO_NODE
+ * @num_children:	Counter of group children to make sure the group is only
+ *			filled with TMIGR_CHILDREN_PER_GROUP; Required for setup
+ *			only
+ * @childmask:		childmask of the group in the parent group; is set
+ *			during setup and will never change; can be read
+ *			lockless
+ * @list:		List head that is added to the per level
+ *			tmigr_level_list; is required during setup when a
+ *			new group needs to be connected to the existing
+ *			hierarchy groups
+ */
+struct tmigr_group {
+	raw_spinlock_t		lock;
+	struct tmigr_group	*parent;
+	struct tmigr_event	groupevt;
+	u64			next_expiry;
+	struct timerqueue_head	events;
+	atomic_t		migr_state;
+	unsigned int		level;
+	int			numa_node;
+	unsigned int		num_children;
+	u8			childmask;
+	struct list_head	list;
+};
+
+/**
+ * struct tmigr_cpu - timer migration per CPU group
+ * @lock:		Lock protecting the tmigr_cpu group information
+ * @online:		Indicates whether the CPU is online; In deactivate path
+ *			it is required to know whether the migrator in the top
+ *			level group is to be set offline, while a timer is
+ *			pending. Then another online CPU needs to be notified to
+ *			take over the migrator role. Furthermore the information
+ *			is required in CPU hotplug path as the CPU is able to go
+ *			idle before the timer migration hierarchy hotplug AP is
+ *			reached. During this phase, the CPU has to handle the
+ *			global timers on its own and must not act as a migrator.
+ * @idle:		Indicates whether the CPU is idle in the timer migration
+ *			hierarchy
+ * @remote:		Is set when timers of the CPU are expired remotely
+ * @wakeup_recalc:	Indicates, whether a recalculation of the @wakeup value
+ *			is required. @wakeup_recalc is only used by this CPU
+ *			when it is marked idle in the timer migration
+ *			hierarchy. It is set by a remote CPU which was the last
+ *			active CPU and is on the way to idle.
+ * @tmgroup:		Pointer to the parent group
+ * @childmask:		childmask of tmigr_cpu in the parent group
+ * @wakeup:		Stores the first timer when the timer migration
+ *			hierarchy is completely idle and remote expiry was done;
+ *			is returned to timer code in the idle path and is only
+ *			used in idle path; it is only valid, when @wakeup_recalc
+ *			is not set.
+ * @cpuevt:		CPU event which could be enqueued into the parent group
+ */
+struct tmigr_cpu {
+	raw_spinlock_t		lock;
+	bool			online;
+	bool			idle;
+	bool			remote;
+	bool			wakeup_recalc;
+	struct tmigr_group	*tmgroup;
+	u8			childmask;
+	u64			wakeup;
+	struct tmigr_event	cpuevt;
+};
+
+/**
+ * union tmigr_state - state of tmigr_group
+ * @state:	Combined version of the state - only used for atomic
+ *		read/cmpxchg function
+ * @struct:	Split version of the state - only use the struct members to
+ *		update information to stay independent of endianness
+ */
+union tmigr_state {
+	u32 state;
+	/**
+	 * struct - split state of tmigr_group
+	 * @active:	Contains each childmask bit of the active children
+	 * @migrator:	Contains childmask of the child which is migrator
+	 * @seq:	Sequence counter needs to be increased when an update
+	 *		to the tmigr_state is done. It prevents a race when
+	 *		updates in the child groups are propagated in changed
+	 *		order. Detailed information about the scenario is
+	 *		given in the documentation at the begin of
+	 *		timer_migration.c.
+	 */
+	struct {
+		u8	active;
+		u8	migrator;
+		u16	seq;
+	} __packed;
+};
+
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+extern void tmigr_handle_remote(void);
+extern int tmigr_requires_handle_remote(void);
+extern void tmigr_cpu_activate(void);
+extern u64 tmigr_cpu_deactivate(u64 nextevt);
+extern u64 tmigr_cpu_new_timer(u64 nextevt);
+extern u64 tmigr_quick_check(void);
+#else
+static inline void tmigr_handle_remote(void) { }
+static inline int tmigr_requires_handle_remote(void) { return 0; }
+static inline void tmigr_cpu_activate(void) { }
+#endif
+
+#endif
-- 
2.39.2


