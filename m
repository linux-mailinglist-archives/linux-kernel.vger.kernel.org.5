Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2A280F1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376740AbjLLP7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376763AbjLLP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:59:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3CF2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:59:43 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:59:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702396781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZYUGGhGIcq4pE6W68er3NNyNlAUozlYglpukm412Vs=;
        b=KnPTuFe2hjj3bt5IFJKNFhFoExaBxz+/BsbAHWxGFsoomXhhaDtRrC5+FfvASby/ocJpsK
        c8dDvKfu1DWBDSuJuISf2XBJ3KwTszByLPMQQvCpp+D+KMFLASG58WlMW/eLuq5fwubYCy
        h8kXONN+9AiYMSyDLuMYA2meHpvzde9uqeZVlWHJyLaUOMIFFkl8FNJN6ukBCc24JqH5Vt
        bKlXXvef195wKXZuPIQcf/yI826WZnZU3FYNoC64ioZunWiJpIKvDFFAjjVEXks/HGfZQd
        FWzK+jip4rnPPP4f7QYPwHPU1U1Orqykqfk5pt0hklmFIs46PHWcF/ZEK9Jo5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702396781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZYUGGhGIcq4pE6W68er3NNyNlAUozlYglpukm412Vs=;
        b=pU6km5Og1ShqVbKq4usrIy3bV33YC05BrFhVOLFDGXe7hWN27pwxTcAZfp4mpT87/Q2otK
        NouffezMEhhViMAw==
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
Message-ID: <20231212155939.Z_YQl91J@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
 <20231211180417.XG9G3ryS@linutronix.de>
 <87h6knmzco.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87h6knmzco.fsf@somnus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-12 12:31:19 [+0100], Anna-Maria Behnsen wrote:
> Sebastian Siewior <bigeasy@linutronix.de> writes:
>=20
> > On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:
> >> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migrati=
on.c
> >> new file mode 100644
> >> index 000000000000..05cd8f1bc45d
> >> --- /dev/null
> >> +++ b/kernel/time/timer_migration.c
> >> @@ -0,0 +1,1636 @@
> > =E2=80=A6
> >> +static bool tmigr_active_up(struct tmigr_group *group,
> >> +			    struct tmigr_group *child,
> >> +			    void *ptr)
> >> +{
> >> +	union tmigr_state curstate, newstate;
> >> +	struct tmigr_walk *data =3D ptr;
> >> +	bool walk_done;
> >> +	u8 childmask;
> >> +
> >> +	childmask =3D data->childmask;
> >> +	newstate =3D curstate =3D data->groupstate;
> >> +
> >> +retry:
> >> +	walk_done =3D true;
> >> +
> >> +	if (newstate.migrator =3D=3D TMIGR_NONE) {
> >> +		newstate.migrator =3D childmask;
> >> +
> >> +		/* Changes need to be propagated */
> >> +		walk_done =3D false;
> >> +	}
> >> +
> >> +	newstate.active |=3D childmask;
> >> +
> >> +	newstate.seq++;
> >> +
> >> +	if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstat=
e.state)) {
> >> +		newstate.state =3D curstate.state;
> >
> > This does not look right. If
> > 	group->migr_state !=3D curstate.state
> > then
> > 	curstate.state =3D newstate.state
> >
> > does not make a difference since curstate is on stack. So this should
> > become
> >
> > |	if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate=
=2Estate)) {
> > |		curstate.state =3D newstate.state =3D atomic_read(&group->parent->mi=
gr_state);
> >
> > and now I question the existence of tmigr_walk::groupstate. It does not
> > match the comment for the struct saying it will be re-read if the
> > cmpxchg() fails because it does not happen (at least here). Also why do
> > we have it? Is it avoid atomic_read() and have it "cached"?
>=20
> atomic_try_cmpxchg() updates curstate.state with the actual
> group->migr_state when those values do not match. So it is reread by
> atomic_try_cmpxchg() and still matches the description. (This at least
> tells the function description of atomic_try_cmpxchg()).

Ach. Indeed. That part slipped my mind. Could still replace it with:
	newstate =3D curstate

to match the assignment at the top of the function? Or do something
like:

|         childmask =3D data->childmask;
|         curstate =3D data->groupstate;
| retry:
|         newstate =3D curstate;
|
|         walk_done =3D true;
=E2=80=A6
|         if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, news=
tate.state))
|                 goto retry;

So gcc can save a branch and recycle the upper the cooking the code.
gcc-13 does not recognise this, clang-16 does.

> But beside of this, why do I want to update curstate.state with
> group->parent->migr_state when cmpxchg of this group wasn't successful
> yet or was it a copy paste error?

It was an error.

> >> +		data->groupstate.state =3D atomic_read(&group->parent->migr_state);
> >> +		data->childmask =3D group->childmask;
> >
> > We don't re-read in case the cmpxchg failed assuming someone else is
> > updating the state. Wouldn't it make sense to read the childmask at top
> > of the function from the child pointer. There is no need to keep around
> > in the data pointer, right?
>=20
> When we are in lvl0, then @child is NULL as the child is a tmigr_cpu and
> not a tmigr_group. This is the reason why I decided to store it inside
> the tmigr_walk struct.

But it supposed to be group->migr_state for the cmpxchg. So considering
the previous bit, why not:

|         childmask =3D data->childmask;
|         curstate =3D atomic_read(&group->migr_state);
|=20
| 	  do {
|         	newstate =3D curstate;
|         	walk_done =3D true;
|=20
|         	if (newstate.migrator =3D=3D TMIGR_NONE) {
|         	        newstate.migrator =3D childmask;
|=20
|         	        /* Changes need to be propagated */
|         	        walk_done =3D false;
|         	}
|=20
|         	newstate.active |=3D childmask;
|=20
|         	newstate.seq++;
|=20
|         } while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state,=
 newstate.state));

this seems nice.

> >> +	}
> >> +
> >> +	/*
> >> +	 * The group is active and the event will be ignored - the ignore fl=
ag is
> >> +	 * updated without holding the lock. In case the bit is set while
> >> +	 * another CPU already handles remote events, nothing happens, becau=
se
> >> +	 * it is clear that the CPU became active just in this moment, or in
> >> +	 * worst case the event is handled remote. Nothing to worry about.
> >> +	 */
> >
> >    The CPU is becoming active, so is the group. The ignore flag for the
> >    group is updated lock less to reflect this. Another CPU might also
> >    set it true while becoming active. In worst case the migrator
> >    observes it too late and expires remotely timer belonging to this
> >    group. The lock is held while going idle (and setting ignore to
> >    false) so the state is not lost.
> >
>=20
> This is what I wanted to explain:
>=20
> /*
>  * The group is active (again). The group event might be still queued
>  * into the parent group's timerqueue but can now be handled by the the

s/the$@@

>  * migrator of this group. Therefore the ignore flag for the group event
>  * is updated to reflect this.
>  *
>  * The update of the ignore flag in the active path is done lock
lockless

>  * less. In worst case the migrator of the parent group observes the
>  * change too late and expires remotely timer belonging to this
a timer?

>  * group. The lock is held while updating the ignore flag in idle
>  * path. So this state change will not be lost.
>  */
>=20
> >> +	group->groupevt.ignore =3D true;
> >> +
> >> +	return walk_done;
> >> +}
=E2=80=A6
> >> +	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
> >> +	    now < tmc->cpuevt.nextevt.expires) {
> >> +		raw_spin_unlock_irq(&tmc->lock);
> >> +		return next;
> >
> > Looking at the last condition where the timerqueue has been forwarded by
> > a jiffy+, shouldn't we return _that_ values next instead of KTIME_MAX?
>=20
> No. Because the event is already queued into the hierarchy and the
> migrator takes care. If hiererachy is completely idle, the CPU which
> updated the event takes care. I'll add this to the comment above.

So another CPU took care of it and we set tmc->wakeup to KTIME_MAX=E2=80=A6

One confusing part is that this return value (if not aborted early but
after completing this function) is used to set tmc->wakeup based on the
next pending timer for the CPU that was expired remotely.
We could have expired four CPUs and the next timer of the last CPU may
not be the earliest timer for the fist CPU in the group.
And this fine because it can be stale and only valid if the CPU goes
idle?

> >> +	/*
> >> +	 * When the CPU is idle, check whether the recalculation of @tmc->wa=
keup
> >> +	 * is required. @tmc->wakeup_recalc is set by a remote CPU which is
> >> +	 * about to go offline, was the last active CPU in the whole timer
> >> +	 * migration hierarchy and now delegates handling of the hierarchy to
> >> +	 * this CPU.
> >
> > I'm failing here=E2=80=A6
>=20
> If the CPU is idle, check whether the recalculation of @tmc->wakeup
> is required. @tmc->wakeup_recalc is set, when the last active CPU
> went offline. The last active CPU delegated the handling of the timer
> migration hierarchy to another (this) CPU by updating this flag and
> sending a reschedule.
>=20
> Better?

So the last CPU going offline had to be the migrator because otherwise
it wouldn't matter?

=E2=80=A6
> >> +
> >> +	if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstat=
e.state)) {
> >
> > This one appears wrong, too. The curstate is not getting updated during
> > retry.
>=20
> See the answer above.

Yes, and I think the do { } while should work here, too.

> >> +	 * data->nextexp was set by tmigr_update_events() and contains the
> >> +	 * expiry of the first global event which needs to be handled
> >> +	 */
> >> +	if (data->nextexp !=3D KTIME_MAX) {
> >> +		WARN_ON_ONCE(group->parent);
> >> +		/*
> >> +		 * Top level path - If this CPU is about going offline, wake
> >> +		 * up some random other CPU so it will take over the
> >> +		 * migrator duty and program its timer properly. Ideally
> >> +		 * wake the CPU with the closest expiry time, but that's
> >> +		 * overkill to figure out.
> >> +		 *
> >> +		 * Set wakeup_recalc of remote CPU, to make sure the complete
> >> +		 * idle hierarchy with enqueued timers is reevaluated.
> >> +		 */
> >> +		if (!(this_cpu_ptr(&tmigr_cpu)->online)) {
> >> +			struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> >> +			unsigned int cpu =3D smp_processor_id();
> >> +			struct tmigr_cpu *tmc_resched;
> >> +
> >> +			cpu =3D cpumask_any_but(cpu_online_mask, cpu);
> >> +			tmc_resched =3D per_cpu_ptr(&tmigr_cpu, cpu);
> >> +
> >> +			raw_spin_unlock(&tmc->lock);
> >> +
> >> +			raw_spin_lock(&tmc_resched->lock);
> >> +			tmc_resched->wakeup_recalc =3D true;
> >> +			raw_spin_unlock(&tmc_resched->lock);
> >> +
> >> +			raw_spin_lock(&tmc->lock);
> >> +			smp_send_reschedule(cpu);
> >
> > This whole thing confuses me.
> > If the CPU goes offline, it needs to get removed from the migration
> > hierarchy and this is it. Everything else is handled by the migrator. If
> > the migrator is going offline then it needs wake a random CPU and make
> > sure it takes the migrator role. I am confused by the whole ::wakeup and
> > ::wakeup_recalc thingy.
> >
>=20
> wakeup_recalc is required to indicate, that the CPU was chosen as the
> new migrator CPU when the last active CPU in timer migration hierarchy
> went offline.

Aha! I suspected this. So this is more like need_new_migrator.

=E2=80=A6
> Hopefully this is now clear?

yes.

> Thanks,
>=20
> 	Anna-Maria

Sebastian
