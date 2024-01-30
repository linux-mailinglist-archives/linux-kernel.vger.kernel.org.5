Return-Path: <linux-kernel+bounces-45324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D95842E84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7E51C25326
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E4F762F0;
	Tue, 30 Jan 2024 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8e2OOat"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA029762C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649199; cv=none; b=dMN0PSm5kdO7ZGO/X8CPQrTArRC/y01lqX6//xMBKyBa5NFQeqEUwKz8Gg7b2vuEjxDAsSkMW3eloMzQTI4jiqQUZvDhCk4BCMUJZL6HlymWB/vUJ1dUT1gdVLRUcp2a8wEzqWHfwMWwvwWdU/dWw5B/1hgD1f7ysvawQKWku/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649199; c=relaxed/simple;
	bh=O4Tyv99Ce8WAKIj525zTnqLmSNekR2HvNaaDN+njopg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZytrKWiLpG97CtA9E0JuiWnb8lkNEEhmAf4aSsLmoUjIhFSnaaYsHpL8znYTCt3/Rf0bNUXhHewgZJpQrZPqCapmql5muYH3GMJnisVZTLoEEQRhW5BkhefUAhBhAX9LxP+zdcPQJvtFAAzVQGyJPEFfX3KkneagDTP7IpEikg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8e2OOat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B610DC433C7;
	Tue, 30 Jan 2024 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706649199;
	bh=O4Tyv99Ce8WAKIj525zTnqLmSNekR2HvNaaDN+njopg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8e2OOatKVWrjrqN2r6c91KYIPtYQO183smzNbxkgWry5Kd6kBuwwQeGaDSdDbCpS
	 TuyNLtA3c4RiQBZugA0L3+5YJ0OptYKRvLJcz/VvXLtyKpG6Wt+Kf/TvzsFnzWyV22
	 z8f4arQP5bX6041fiX355kMEZAgbANmVJHaYwNEo0cTI3WoSi5ddI+v4m8D8AJKrFO
	 zcEee+7Z3DNeP8mm7h7+IvgCHhZPd1uAiaVQYX33RHSLjP0kRrXo/6H4ddhk4k9DdH
	 YjJYifHfIzVBr58977gGq4UB7w4cWzAyaGP0H3oJVj7kWRhV69TzGsYICbNKAnqCVp
	 ckP4gaIXJ+7nw==
Date: Tue, 30 Jan 2024 22:13:15 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Message-ID: <Zblma8NNZOftJ5fb@pavilion.home>
References: <Zbb5m0hRHgk59-8z@pavilion.home>
 <87v87a9033.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v87a9033.fsf@somnus>

Le Tue, Jan 30, 2024 at 06:56:32PM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> > CPU 1 went idle, CPU 3 will take care of CPU 1's timer. Then come two
> > things happening at the same time: CPU 0 has a timer interrupt, due to
> > RCU callbacks handling for example, and CPU 3 goes offline:
> >
> > CPU 0                                   CPU 3
> > -----                                   -----
> >                                         // On top level [GRP1:0], just set migrator = TMIGR_NONE
> >                                         tmigr_inactive_up() {
> >                                             cpu = cpumask_any_but(cpu_online_mask, cpu);
> >                                             //cpu == 0
> >                                             tmc_resched = per_cpu_ptr(&tmigr_cpu, CPU 0);
> >                                             raw_spin_lock(&tmc_resched->lock);
> >                                             tmc_resched->wakeup_recalc = true;
> >                                             raw_spin_unlock(&tmc_resched->lock);
> > // timer interrupt
> > run_local_timers() {
> >     tmigr_requires_handle_remote() {
> >         data.firstexp = KTIME_MAX;
> >         // CPU 0 sees the tmc_resched->wakeup_recalc
> >         // latest update
> >         if (tmc->wakeup_recalc) {
> >             tmigr_requires_handle_remote_up() {
> >                 // CPU 0 doesn't see GRP0:0 
> >                 // latest update from CPU 1,
> >                 // because it has no locking
> >                 // and does a racy check.
> >         	    if (!tmigr_check_migrator(group, childmask))
> >                     return true;
> >             }
> >             raw_spin_lock(&tmc->lock);
> >             WRITE_ONCE(tmc->wakeup, data.firstexp);
> >             tmc->wakeup_recalc = false;
> >             raw_spin_unlock(&tmc->lock)
> >             return 0;
> >         }
> >                                             // IPI is sent only now
> > 		                                    smp_send_reschedule(cpu);
> >                                             }
> >
> >
> > There is nothing that prevents CPU 0 from not seeing the hierarchy updates from
> > other CPUs since it checks the migrators in a racy way. As a result the timer of
> > CPU 1 may be ignored by CPU 0.
> >
> > You'd need to lock the tmc while calling tmigr_requires_handle_remote_up(), so
> > that CPU 0 "inherits" everything that CPU 3 has seen, and that includes changes
> > from CPU 1.
> >
> 
> puhh. ok. But for the !idle case the lockless walk of
> tmigr_requires_handle_remote_up() is ok?

Looks ok to me. It's racy but if the !idle migrator doesn't notice in the
current tick, it will in the next one.

> It's also possible, that the
> CPU misses an update of the state - another CPU goes idle and selects
> this CPU as the new migrator. And this CPU reads a stale value where the
> other CPU is migrator. But this will be revisited on the next
> tick. hmm...

Exactly, and I'm not worried. There has to be strong ordering with atomics
or locking in the idle case because the CPU goes to sleep and it must make
sure not to miss a timer. But in the !idle case the check is periodic, so you
don't need any of that. We can live with an unnoticed timer for a tick or two.

> 
> >
> > But I see that tmigr_cpu_new_timer() does it right. Wouldn't it be possible to
> > exlusively let tmigr_cpu_new_timer() handle the wakeup_recalc thing? This is
> > going to be called after the end of the IRQ (whether timer interrupt or sched
> > IPI) in any case.
> 
> Should work, yes. But when a timer has to be handled right away and it
> is checked after the end of the IRQ, then the tick might be reprogrammed
> so that CPU comes out of idle, or am I wrong?

If there is a pending timer, it can wait a tick. That's what happens if
we wait for tmigr_cpu_new_timer() to handle it.

But you know what, let's make it more simple. CPU down hotplug is not a
fast path and it doesn't deserve so many optimizations. Just remove ->wakeup_recalc
entirely and if the offlining CPU detects it's the last active CPU in the
hierarchy, just queue an empty work to the first online CPU. It will briefly
force that CPU out of idle and trigger an activate. Then either the CPU
periodically checks remote timers or it will go back idle and notice.

Something like this (untested):

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index de1905b0bae7..0f15215ef257 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -548,7 +548,6 @@ static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
 
 	tmc->cpuevt.ignore = true;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
-	tmc->wakeup_recalc = false;
 
 	walk_groups(&tmigr_active_up, &data, tmc);
 }
@@ -1041,41 +1040,11 @@ int tmigr_requires_handle_remote(void)
 	}
 
 	/*
-	 * If the CPU is idle, check whether the recalculation of @tmc->wakeup
-	 * is required. @tmc->wakeup_recalc is set, when the last active CPU
-	 * went offline. The last active CPU delegated the handling of the timer
-	 * migration hierarchy to another (this) CPU by updating this flag and
-	 * sending a reschedule.
-	 *
-	 * Racy lockless check is valid:
-	 * - @tmc->wakeup_recalc is set by the remote CPU before it issues
-	 *   reschedule IPI.
-	 * - As interrupts are disabled here this CPU will either observe
-	 *   @tmc->wakeup_recalc set before the reschedule IPI can be handled or
-	 *   it will observe it when this function is called again on return
-	 *   from handling the reschedule IPI.
-	 */
-	if (tmc->wakeup_recalc) {
-		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
-
-		if (data.firstexp != KTIME_MAX)
-			ret = 1;
-
-		raw_spin_lock(&tmc->lock);
-		WRITE_ONCE(tmc->wakeup, data.firstexp);
-		tmc->wakeup_recalc = false;
-		raw_spin_unlock(&tmc->lock);
-
-		return ret;
-	}
-
-	/*
-	 * When the CPU is idle and @tmc->wakeup is reliable as
-	 * @tmc->wakeup_recalc is not set, compare it with @data.now. The lock
-	 * is required on 32bit architectures to read the variable consistently
-	 * with a concurrent writer. On 64bit the lock is not required because
-	 * the read operation is not split and so it is always consistent.
-
+	 * When the CPU is idle and @tmc->wakeup is reliable, compare it with
+	 * @data.now. The lock is required on 32bit architectures to read the
+	 * variable consistently with a concurrent writer. On 64bit the lock
+	 * is not required because the read operation is not split and so it is
+	 * always consistent.
 	 */
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		if (data.now >= READ_ONCE(tmc->wakeup))
@@ -1119,21 +1088,7 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 		    tmc->cpuevt.ignore) {
 			ret = tmigr_new_timer(tmc, nextexp);
 		}
-	} else if (tmc->wakeup_recalc) {
-		struct tmigr_remote_data data;
-
-		data.now = KTIME_MAX;
-		data.childmask = tmc->childmask;
-		data.firstexp = KTIME_MAX;
-		data.tmc_active = false;
-		data.check = false;
-
-		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
-
-		ret = data.firstexp;
 	}
-	tmc->wakeup_recalc = false;
-
 	/*
 	 * Make sure the reevaluation of timers in idle path will not miss an
 	 * event.
@@ -1212,36 +1167,7 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	 *   hierarchy) and
 	 * - there is a pending event in the hierarchy
 	 */
-	if (data->firstexp != KTIME_MAX) {
-		WARN_ON_ONCE(group->parent);
-		/*
-		 * Top level path: If this CPU is about going offline and was
-		 * the last active CPU, wake up some random other CPU so it will
-		 * take over the migrator duty and program its timer
-		 * properly. Ideally wake the CPU with the closest expiry time,
-		 * but that's overkill to figure out.
-		 *
-		 * Set wakeup_recalc of remote CPU, to make sure the complete
-		 * idle hierarchy with enqueued timers is reevaluated.
-		 */
-		if (!(this_cpu_ptr(&tmigr_cpu)->online)) {
-			struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
-			unsigned int cpu = smp_processor_id();
-			struct tmigr_cpu *tmc_resched;
-
-			cpu = cpumask_any_but(cpu_online_mask, cpu);
-			tmc_resched = per_cpu_ptr(&tmigr_cpu, cpu);
-
-			raw_spin_unlock(&tmc->lock);
-
-			raw_spin_lock(&tmc_resched->lock);
-			tmc_resched->wakeup_recalc = true;
-			raw_spin_unlock(&tmc_resched->lock);
-
-			raw_spin_lock(&tmc->lock);
-			smp_send_reschedule(cpu);
-		}
-	}
+	WARN_ON_ONCE(data->firstexp != KTIME_MAX && group->parent);
 
 	return walk_done;
 }
@@ -1579,9 +1505,20 @@ static int tmigr_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+long tmigr_trigger_active(void *unused)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+
+	WARN_ON_ONCE(!tmc->online || tmc->idle);
+
+	return 0;
+}
+
 static int tmigr_cpu_offline(unsigned int cpu)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	int migrator;
+	u64 firstexp;
 
 	raw_spin_lock_irq(&tmc->lock);
 	tmc->online = false;
@@ -1591,9 +1528,14 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	 * CPU has to handle the local events on his own, when on the way to
 	 * offline; Therefore nextevt value is set to KTIME_MAX
 	 */
-	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
 	raw_spin_unlock_irq(&tmc->lock);
 
+	if (firstexp != KTIME_MAX) {
+		migrator = cpumask_any_but(cpu_online_mask, cpu);
+		work_on_cpu(migrator, tmigr_trigger_active, NULL);
+	}
+
 	return 0;
 }
 
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index c32947cf429b..c556d5824792 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -78,18 +78,12 @@ struct tmigr_group {
  * @idle:		Indicates whether the CPU is idle in the timer migration
  *			hierarchy
  * @remote:		Is set when timers of the CPU are expired remotely
- * @wakeup_recalc:	Indicates, whether a recalculation of the @wakeup value
- *			is required. @wakeup_recalc is only used by this CPU
- *			when it is marked idle in the timer migration
- *			hierarchy. It is set by a remote CPU which was the last
- *			active CPU and is on the way to idle.
  * @tmgroup:		Pointer to the parent group
  * @childmask:		childmask of tmigr_cpu in the parent group
  * @wakeup:		Stores the first timer when the timer migration
  *			hierarchy is completely idle and remote expiry was done;
  *			is returned to timer code in the idle path and is only
- *			used in idle path; it is only valid, when @wakeup_recalc
- *			is not set.
+ *			used in idle path.
  * @cpuevt:		CPU event which could be enqueued into the parent group
  */
 struct tmigr_cpu {
@@ -97,7 +91,6 @@ struct tmigr_cpu {
 	bool			online;
 	bool			idle;
 	bool			remote;
-	bool			wakeup_recalc;
 	struct tmigr_group	*tmgroup;
 	u8			childmask;
 	u64			wakeup;

