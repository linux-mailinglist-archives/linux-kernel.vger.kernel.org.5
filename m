Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7380D4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbjLKSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbjLKSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:04:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB4CD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:04:21 -0800 (PST)
Date:   Mon, 11 Dec 2023 19:04:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702317859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hwIxmS6FmU4+B5yQIwczQUKS2fo8Wko8tr9hrUQH94=;
        b=t/fbZOmr/z/Su+FDvFbQYm7PHbKnth4QQoUw2Kx3YO/7a3UyII5S8JCkh6Uq4W8e03DBMA
        c4jCm8DN3hqf1qzSjxzYcQkYwxEKbyPFMGe2d9L9RfCiNq9G25gFf7w0l91GlkIiWQd1ZI
        NjDldocDY3l34pVhwcn4WUa8ECqNBMygCN3kn+93UOHpoDaSxhoyT71Wy+JUQqckrJvXdi
        PjNIt8laiBOEzm0lycXYd/ROWKBDe6G4f0K90oFFZJFL7rO8dPgRgGKBhAjuM44uKn2Q91
        NahAWE6TpmOmSszfFEQGKzmBsr652TTg+tCgBsJS4n6DcIWA+40wyIgra2eo/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702317859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hwIxmS6FmU4+B5yQIwczQUKS2fo8Wko8tr9hrUQH94=;
        b=xwddmrWDYV89nzPLL25sNLUqrv+vay0HnoRz9sYgW7J7DLpRmS3D1D4r2DTDHMHeE4QpPL
        aSowT6HWTS1qljBw==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 30/32] timers: Implement the hierarchical pull model
Message-ID: <20231211180417.XG9G3ryS@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231201092654.34614-31-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> new file mode 100644
> index 000000000000..05cd8f1bc45d
> --- /dev/null
> +++ b/kernel/time/timer_migration.c
> @@ -0,0 +1,1636 @@
=E2=80=A6
> +static bool tmigr_active_up(struct tmigr_group *group,
> +			    struct tmigr_group *child,
> +			    void *ptr)
> +{
> +	union tmigr_state curstate, newstate;
> +	struct tmigr_walk *data =3D ptr;
> +	bool walk_done;
> +	u8 childmask;
> +
> +	childmask =3D data->childmask;
> +	newstate =3D curstate =3D data->groupstate;
> +
> +retry:
> +	walk_done =3D true;
> +
> +	if (newstate.migrator =3D=3D TMIGR_NONE) {
> +		newstate.migrator =3D childmask;
> +
> +		/* Changes need to be propagated */
> +		walk_done =3D false;
> +	}
> +
> +	newstate.active |=3D childmask;
> +
> +	newstate.seq++;
> +
> +	if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.s=
tate)) {
> +		newstate.state =3D curstate.state;

This does not look right. If
	group->migr_state !=3D curstate.state
then
	curstate.state =3D newstate.state

does not make a difference since curstate is on stack. So this should
become

|	if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.sta=
te)) {
|		curstate.state =3D newstate.state =3D atomic_read(&group->parent->migr_s=
tate);

and now I question the existence of tmigr_walk::groupstate. It does not
match the comment for the struct saying it will be re-read if the
cmpxchg() fails because it does not happen (at least here). Also why do
we have it? Is it avoid atomic_read() and have it "cached"?

> +		goto retry;
> +	}
> +
> +	if (group->parent && (walk_done =3D=3D false)) {

The group's parent doesn't change so it can be accessed lock-less. It is
just that the topmost group has no parent so we need this check. I would
move the walk_done check to the left so it can be evaluated first.

> +		data->groupstate.state =3D atomic_read(&group->parent->migr_state);
> +		data->childmask =3D group->childmask;

We don't re-read in case the cmpxchg failed assuming someone else is
updating the state. Wouldn't it make sense to read the childmask at top
of the function from the child pointer. There is no need to keep around
in the data pointer, right?

> +	}
> +
> +	/*
> +	 * The group is active and the event will be ignored - the ignore flag =
is
> +	 * updated without holding the lock. In case the bit is set while
> +	 * another CPU already handles remote events, nothing happens, because
> +	 * it is clear that the CPU became active just in this moment, or in
> +	 * worst case the event is handled remote. Nothing to worry about.
> +	 */

   The CPU is becoming active, so is the group. The ignore flag for the
   group is updated lock less to reflect this. Another CPU might also
   set it true while becoming active. In worst case the migrator
   observes it too late and expires remotely timer belonging to this
   group. The lock is held while going idle (and setting ignore to
   false) so the state is not lost.

> +	group->groupevt.ignore =3D true;
> +
> +	return walk_done;
> +}
=E2=80=A6
> +/*
> + * Returns the expiry of the next timer that needs to be handled. KTIME_=
MAX is
> + * returned, when an active CPU will handle all the timer migration hier=
archy

s/when/if ?

> + * timers.
> + */
> +static u64 tmigr_new_timer(struct tmigr_cpu *tmc, u64 nextexp)
> +{
> +	struct tmigr_walk data =3D { .evt =3D &tmc->cpuevt,
> +				   .nextexp =3D nextexp };
> +
> +	lockdep_assert_held(&tmc->lock);
> +
> +	if (tmc->remote)
> +		return KTIME_MAX;
> +
> +	tmc->cpuevt.ignore =3D false;
> +	data.remote =3D false;
> +
> +	walk_groups(&tmigr_new_timer_up, &data, tmc);
> +
> +	/* If there is a new first global event, make sure it is handled */
> +	return data.nextexp;
> +}
> +
> +static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
> +				   unsigned long jif)
> +{
> +	struct timer_events tevt;
> +	struct tmigr_walk data;
> +	struct tmigr_cpu *tmc;
> +	u64 next =3D KTIME_MAX;
> +
> +	tmc =3D per_cpu_ptr(&tmigr_cpu, cpu);
> +
> +	raw_spin_lock_irq(&tmc->lock);
> +
> +	/*
> +	 * The remote CPU is offline or the CPU event does not has to be handled
> +	 * (the CPU is active or there is no longer an event to expire) or
> +	 * another CPU handles the CPU timers already or the next event was
> +	 * already expired - return!
> +	 */

The comment is the english version of the C code below. The *why* is
usually the thing we care about. This basically sums up to:

	If remote CPU is offline then the timer events have been
	migrated away.
	If tmigr_cpu::remote is set then another CPU takes care of this.
	If tmigr_event::ignore is set then the CPU is returning from
	idle and take care of its timers.
	If the next event expires in the future then the event node has
	been updated and there are no timer to expire right now.

> +	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
> +	    now < tmc->cpuevt.nextevt.expires) {
> +		raw_spin_unlock_irq(&tmc->lock);
> +		return next;

Looking at the last condition where the timerqueue has been forwarded by
a jiffy+, shouldn't we return _that_ values next instead of KTIME_MAX?

> +	}
> +
> +	tmc->remote =3D true;
> +	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
> +
> +	/* Drop the lock to allow the remote CPU to exit idle */
> +	raw_spin_unlock_irq(&tmc->lock);
> +
> +	if (cpu !=3D smp_processor_id())
> +		timer_expire_remote(cpu);
> +
> +	/*
> +	 * Lock ordering needs to be preserved - timer_base locks before tmigr
> +	 * related locks (see section "Locking rules" in the documentation at
> +	 * the top). During fetching the next timer interrupt, also tmc->lock
> +	 * needs to be held. Otherwise there is a possible race window against
> +	 * the CPU itself when it comes out of idle, updates the first timer in
> +	 * the hierarchy and goes back to idle.
> +	 *
> +	 * timer base locks are dropped as fast as possible: After checking
> +	 * whether the remote CPU went offline in the meantime and after
> +	 * fetching the next remote timer interrupt. Dropping the locks as fast
> +	 * as possible keeps the locking region small and prevents holding
> +	 * several (unnecessary) locks during walking the hierarchy for updating
> +	 * the timerqueue and group events.
> +	 */
> +	local_irq_disable();
> +	timer_lock_remote_bases(cpu);
> +	raw_spin_lock(&tmc->lock);
> +
> +	/*
> +	 * When the CPU went offline in the meantime, no hierarchy walk has to
> +	 * be done for updating the queued events, because the walk was
> +	 * already done during marking the CPU offline in the hierarchy.
> +	 *
> +	 * When the CPU is no longer idle, the CPU takes care of the timers and
   If the CPU is no longer idle then it takes care of its timers and
   also of the timers in its hierarchy.

> +	 * also of the timers in the path to the top.
> +	 *
> +	 * (See also section "Required event and timerqueue update after
> +	 * remote expiry" in the documentation at the top)

Perfect. The reasoning why it is safe to skip walk + expire timers, has
been explained.

> +	 */
> +	if (!tmc->online || !tmc->idle) {
> +		timer_unlock_remote_bases(cpu);
> +		goto unlock;
> +	} else {
> +		/* next	event of CPU */
> +		fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);
> +	}
> +
> +	timer_unlock_remote_bases(cpu);
> +
> +	data.evt =3D &tmc->cpuevt;
> +	data.nextexp =3D tevt.global;
> +	data.remote =3D true;
> +
> +	/*
> +	 * The update is done even when there is no 'new' global timer pending
> +	 * on the remote CPU (see section "Required event and timerqueue update
> +	 * after remote expiry" in the documentation at the top)
> +	 */
> +	walk_groups(&tmigr_new_timer_up, &data, tmc);
> +
> +	next =3D data.nextexp;
> +
> +unlock:
> +	tmc->remote =3D false;
> +	raw_spin_unlock_irq(&tmc->lock);
> +
> +	return next;
> +}
> +
=E2=80=A6
> +/**
> + * tmigr_handle_remote() - Handle global timers of remote idle CPUs
> + *
> + * Called from the timer soft interrupt with interrupts enabled.
> + */
> +void tmigr_handle_remote(void)
> +{
> +	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> +	struct tmigr_remote_data data;
> +
> +	if (tmigr_is_not_available(tmc))
> +		return;
> +
> +	data.childmask =3D tmc->childmask;
> +	data.nextexp =3D KTIME_MAX;
> +
> +	/*
> +	 * NOTE: This is a doubled check because the migrator test will be done
> +	 * in tmigr_handle_remote_up() anyway. Keep this check to fasten the

s/fasten/speed up/

> +	 * return when nothing has to be done.
> +	 */
> +	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
> +		return;
> +
> +	data.now =3D get_jiffies_update(&data.basej);
> +
> +	/*
> +	 * Update @tmc->wakeup only at the end and do not reset @tmc->wakeup to
> +	 * KTIME_MAX. Even if tmc->lock is not held during the whole remote
> +	 * handling, tmc->wakeup is fine to be stale as it is called in
> +	 * interrupt context and tick_nohz_next_event() is executed in interrupt
> +	 * exit path only after processing the last pending interrupt.
> +	 */
> +
> +	__walk_groups(&tmigr_handle_remote_up, &data, tmc);
> +
> +	raw_spin_lock_irq(&tmc->lock);
> +	WRITE_ONCE(tmc->wakeup, data.nextexp);
> +	raw_spin_unlock_irq(&tmc->lock);
> +}
> +
> +static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
> +					    struct tmigr_group *child,
> +					    void *ptr)
> +{
> +	struct tmigr_remote_data *data =3D ptr;
> +	u8 childmask;
> +
> +	childmask =3D data->childmask;
> +
> +	/*
> +	 * Handle the group only if the child is the migrator or if the group
> +	 * has no migrator. Otherwise the group is active and is handled by its
> +	 * own migrator.
> +	 */
> +	if (!tmigr_check_migrator(group, childmask))
> +		return true;
> +
> +	/*
> +	 * When there is a parent group and the CPU which triggered the
> +	 * hierarchy walk is not active, proceed the walk to reach the top level
> +	 * group before reading the next_expiry value.
> +	 */
> +	if (group->parent && !data->tmc_active)
> +		goto out;
> +
> +	/*
> +	 * On 32 bit systems the racy lockless check for next_expiry will
> +	 * turn into a random number generator. Therefore do the lockless
> +	 * check only on 64 bit systems.
> +	 */

	 The lock is required on 32bit architectures to read the
	 variable consistently with a concurrent writer. On 64bit the
	 lock is not required because the read operation is not split
	 and so is always consistent.

> +	if (IS_ENABLED(CONFIG_64BIT)) {
> +		data->nextexp =3D READ_ONCE(group->next_expiry);
> +		if (data->now >=3D data->nextexp) {
> +			data->check =3D true;
> +			return true;
> +		}
> +	} else {
> +		raw_spin_lock(&group->lock);
> +		data->nextexp =3D group->next_expiry;
> +		if (data->now >=3D group->next_expiry) {
> +			data->check =3D true;
> +			raw_spin_unlock(&group->lock);
> +			return true;
> +		}
> +		raw_spin_unlock(&group->lock);
> +	}
> +
> +out:
> +	/* Update of childmask for the next level */
> +	data->childmask =3D group->childmask;
> +	return false;
> +}
> +
> +/**
> + * tmigr_requires_handle_remote() - Check the need of remote timer handl=
ing
> + *
> + * Must be called with interrupts disabled.
> + */
> +int tmigr_requires_handle_remote(void)
> +{
> +	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> +	struct tmigr_remote_data data;
> +	unsigned int ret =3D 0;
> +	unsigned long jif;
> +
> +	if (tmigr_is_not_available(tmc))
> +		return ret;
> +
> +	data.now =3D get_jiffies_update(&jif);
> +	data.childmask =3D tmc->childmask;
> +	data.nextexp =3D KTIME_MAX;
> +	data.tmc_active =3D !tmc->idle;
> +	data.check =3D false;
> +
> +	/*
> +	 * When the CPU is active, walking the hierarchy to check whether a
> +	 * remote expiry is required.

s/When/If
s/walking/walk

> +	 *
> +	 * Check is done lockless as interrupts are disabled and @tmc->idle is
> +	 * set only by the local CPU.
> +	 */
> +	if (!tmc->idle) {
> +		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
> +
> +		if (data.nextexp !=3D KTIME_MAX)
> +			ret =3D 1;
> +
> +		return ret;
> +	}
> +
> +	/*
> +	 * When the CPU is idle, check whether the recalculation of @tmc->wakeup
> +	 * is required. @tmc->wakeup_recalc is set by a remote CPU which is
> +	 * about to go offline, was the last active CPU in the whole timer
> +	 * migration hierarchy and now delegates handling of the hierarchy to
> +	 * this CPU.

I'm failing here=E2=80=A6

> +	 * Racy lockless check is valid:
> +	 * - @tmc->wakeup_recalc is set by the remote CPU before it issues
> +	 *   reschedule IPI.
> +	 * - As interrupts are disabled here this CPU will either observe
> +	 *   @tmc->wakeup_recalc set before the reschedule IPI can be handled or
> +	 *   it will observe it when this function is called again on return
> +	 *   from handling the reschedule IPI.
> +	 */
> +	if (tmc->wakeup_recalc) {
> +		raw_spin_lock(&tmc->lock);
> +
> +		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
> +
> +		if (data.nextexp !=3D KTIME_MAX)
> +			ret =3D 1;
> +
> +		WRITE_ONCE(tmc->wakeup, data.nextexp);
> +		tmc->wakeup_recalc =3D false;
> +		raw_spin_unlock(&tmc->lock);
> +
> +		return ret;
> +	}
> +
> +	/*
> +	 * When the CPU is idle and @tmc->wakeup is reliable, compare it with
> +	 * @data.now. On 64 bit it is valid to do this lockless. On 32 bit
> +	 * systems, holding the lock is required to get valid data on concurrent
> +	 * writers.

The wakeup value is reliable when the CPU is idle?

See the comments regarding 64bit.=20

> +	 */
> +	if (IS_ENABLED(CONFIG_64BIT)) {
> +		if (data.now >=3D READ_ONCE(tmc->wakeup))
> +			ret =3D 1;
> +	} else {
> +		raw_spin_lock(&tmc->lock);
> +		if (data.now >=3D tmc->wakeup)
> +			ret =3D 1;
> +		raw_spin_unlock(&tmc->lock);
> +	}
> +
> +	return ret;
> +}

=E2=80=A6

> +static bool tmigr_inactive_up(struct tmigr_group *group,
> +			      struct tmigr_group *child,
> +			      void *ptr)
> +{
> +	union tmigr_state curstate, newstate;
> +	struct tmigr_walk *data =3D ptr;
> +	bool walk_done;
> +	u8 childmask;
> +
> +	childmask =3D data->childmask;
> +	newstate =3D curstate =3D data->groupstate;
> +
> +retry:
> +	walk_done =3D true;
> +
> +	/* Reset active bit when the child is no longer active */
> +	if (!data->childstate.active)
> +		newstate.active &=3D ~childmask;
> +
> +	if (newstate.migrator =3D=3D childmask) {
> +		/*
> +		 * Find a new migrator for the group, because the child group is
> +		 * idle!
> +		 */
> +		if (!data->childstate.active) {
> +			unsigned long new_migr_bit, active =3D newstate.active;
> +
> +			new_migr_bit =3D find_first_bit(&active, BIT_CNT);
> +
> +			if (new_migr_bit !=3D BIT_CNT) {
> +				newstate.migrator =3D BIT(new_migr_bit);
> +			} else {
> +				newstate.migrator =3D TMIGR_NONE;
> +
> +				/* Changes need to be propagated */
> +				walk_done =3D false;
> +			}
> +		}
> +	}
> +
> +	newstate.seq++;
> +
> +	WARN_ON_ONCE((newstate.migrator !=3D TMIGR_NONE) && !(newstate.active));
> +
> +	if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.s=
tate)) {

This one appears wrong, too. The curstate is not getting updated during
retry.

> +		newstate.state =3D curstate.state;
> +
> +		/*
> +		 * Something changed in the child/parent group in the meantime,
> +		 * reread the state of the child and parent; Update of
> +		 * data->childstate is required for event handling;
> +		 */
> +		if (child)
> +			data->childstate.state =3D atomic_read(&child->migr_state);
> +
> +		goto retry;
> +	}
> +
> +	data->groupstate =3D newstate;
> +	data->remote =3D false;
> +
> +	/* Event Handling */
> +	tmigr_update_events(group, child, data);
> +
> +	if (group->parent && (walk_done =3D=3D false)) {
> +		data->childmask =3D group->childmask;
> +		data->childstate =3D newstate;
> +		data->groupstate.state =3D atomic_read(&group->parent->migr_state);
> +	}
> +
> +	/*
> +	 * data->nextexp was set by tmigr_update_events() and contains the
> +	 * expiry of the first global event which needs to be handled
> +	 */
> +	if (data->nextexp !=3D KTIME_MAX) {
> +		WARN_ON_ONCE(group->parent);
> +		/*
> +		 * Top level path - If this CPU is about going offline, wake
> +		 * up some random other CPU so it will take over the
> +		 * migrator duty and program its timer properly. Ideally
> +		 * wake the CPU with the closest expiry time, but that's
> +		 * overkill to figure out.
> +		 *
> +		 * Set wakeup_recalc of remote CPU, to make sure the complete
> +		 * idle hierarchy with enqueued timers is reevaluated.
> +		 */
> +		if (!(this_cpu_ptr(&tmigr_cpu)->online)) {
> +			struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> +			unsigned int cpu =3D smp_processor_id();
> +			struct tmigr_cpu *tmc_resched;
> +
> +			cpu =3D cpumask_any_but(cpu_online_mask, cpu);
> +			tmc_resched =3D per_cpu_ptr(&tmigr_cpu, cpu);
> +
> +			raw_spin_unlock(&tmc->lock);
> +
> +			raw_spin_lock(&tmc_resched->lock);
> +			tmc_resched->wakeup_recalc =3D true;
> +			raw_spin_unlock(&tmc_resched->lock);
> +
> +			raw_spin_lock(&tmc->lock);
> +			smp_send_reschedule(cpu);

This whole thing confuses me.
If the CPU goes offline, it needs to get removed from the migration
hierarchy and this is it. Everything else is handled by the migrator. If
the migrator is going offline then it needs wake a random CPU and make
sure it takes the migrator role. I am confused by the whole ::wakeup and
::wakeup_recalc thingy.

> +		}
> +	}
> +
> +	return walk_done;
> +}

Sebastian
