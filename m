Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ABA804419
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346193AbjLEBdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEBdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:33:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B1F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:33:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403CFC433C7;
        Tue,  5 Dec 2023 01:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701740029;
        bh=vJDn2aLNSQniK14H9V73Wg+WOKYAHMcvLaKvUqrsnp4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NvNqaV3Ypx9sMrksog6NIqyZ0jIAjcre6qJ/xwMZOa/neMJfwqou7aM0ZnHzcnj2e
         igwDZfrrG9157YUVNDkTs0+Pn4oArI4V7Nhj6nx5EocZgvMdSH0hO7hDUJL7/lMSxd
         o1zVkUmLvdmXcSdD1+GQ9MeHrRUuexiUY0giJhnH6hpskNNdxA0AzUr0CYPZ1lXC9X
         LYMr70vxx6FipCC2TRP0UdBPefOx/i8RzK6bZdHxZqAMNgy+EyXbYOGBNDCM2rMEab
         azoQAi4MXRlxJYgKhk43pRnf4AZnfRtRizQ3AJYFSx6Rq3eYOqIrk2EICo+/co2wK4
         O4WPWeCo2IxXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C2AECCE1147; Mon,  4 Dec 2023 17:33:48 -0800 (PST)
Date:   Mon, 4 Dec 2023 17:33:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
Message-ID: <209f0e89-7ebd-4759-9883-21d842d0d26c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87v89lzu5a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v89lzu5a.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 06:04:33PM +0100, Thomas Gleixner wrote:
> Paul!
> 
> On Mon, Nov 20 2023 at 16:38, Paul E. McKenney wrote:
> > But...
> >
> > Suppose we have a long-running loop in the kernel that regularly
> > enables preemption, but only momentarily.  Then the added
> > rcu_flavor_sched_clock_irq() check would almost always fail, making
> > for extremely long grace periods.  Or did I miss a change that causes
> > preempt_enable() to help RCU out?
> 
> So first of all this is not any different from today and even with
> RCU_PREEMPT=y a tight loop:
> 
>     do {
>     	preempt_disable();
>         do_stuff();
>         preempt_enable();
>     }
> 
> will not allow rcu_flavor_sched_clock_irq() to detect QS reliably. All
> it can do is to force reschedule/preemption after some time, which in
> turn ends up in a QS.

True, but we don't run RCU_PREEMPT=y on the fleet.  So although this
argument should offer comfort to those who would like to switch from
forced preemption to lazy preemption, it doesn't help for those of us
running NONE/VOLUNTARY.

I can of course compensate if need be by making RCU more aggressive with
the resched_cpu() hammer, which includes an IPI.  For non-nohz_full CPUs,
it currently waits halfway to the stall-warning timeout.

> The current NONE/VOLUNTARY models, which imply RCU_PRREMPT=n cannot do
> that at all because the preempt_enable() is a NOOP and there is no
> preemption point at return from interrupt to kernel.
> 
>     do {
>         do_stuff();
>     }
> 
> So the only thing which makes that "work" is slapping a cond_resched()
> into the loop:
> 
>     do {
>         do_stuff();
>         cond_resched();
>     }

Yes, exactly.

> But the whole concept behind LAZY is that the loop will always be:
> 
>     do {
>     	preempt_disable();
>         do_stuff();
>         preempt_enable();
>     }
> 
> and the preempt_enable() will always be a functional preemption point.

Understood.  And if preempt_enable() can interact with RCU when requested,
I would expect that this could make quite a few calls to cond_resched()
provably unnecessary.  There was some discussion of this:

https://lore.kernel.org/all/0d6a8e80-c89b-4ded-8de1-8c946874f787@paulmck-laptop/

There were objections to an earlier version.  Is this version OK?

> So let's look at the simple case where more than one task is runnable on
> a given CPU:
> 
>     loop()
> 
>       preempt_disable();
> 
>       --> tick interrupt
>           set LAZY_NEED_RESCHED
> 
>       preempt_enable() -> Does nothing because NEED_RESCHED is not set
> 
>       preempt_disable();
> 
>       --> tick interrupt
>           set NEED_RESCHED
> 
>       preempt_enable()
>         preempt_schedule()
>           schedule()
>             report_QS()
> 
> which means that on the second tick a quiesent state is
> reported. Whether that's really going to be a full tick which is granted
> that's a scheduler decision and implementation detail and not really
> relevant for discussing the concept.

In my experience, the implementation details make themselves relevant
sooner or later, and often sooner...

> Now the problematic case is when there is only one task runnable on a
> given CPU because then the tick interrupt will set neither of the
> preemption bits. Which is fine from a scheduler perspective, but not so
> much from a RCU perspective.
> 
> But the whole point of LAZY is to be able to enforce rescheduling at the
> next possible preemption point. So RCU can utilize that too:
> 
> rcu_flavor_sched_clock_irq(bool user)
> {
> 	if (user || rcu_is_cpu_rrupt_from_idle() ||
> 	    !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
> 		rcu_qs();
>                 return;
> 	}
> 
>         if (this_cpu_read(rcu_data.rcu_urgent_qs))
>         	set_need_resched();
> }

Yes, that is one of the changes that would be good to make, as discussed
previously.

> So:
> 
>     loop()
> 
>       preempt_disable();
> 
>       --> tick interrupt
>             rcu_flavor_sched_clock_irq()
>                 sets NEED_RESCHED
> 
>       preempt_enable()
>         preempt_schedule()
>           schedule()
>             report_QS()
> 
> See? No magic nonsense in preempt_enable(), no cond_resched(), nothing.

Understood, but that does delay detection of that quiescent state by up
to one tick.

> The above rcu_flavor_sched_clock_irq() check for rcu_data.rcu_urgent_qs
> is not really fundamentaly different from the check in rcu_all_gs(). The
> main difference is that it is bound to the tick, so the detection/action
> might be delayed by a tick. If that turns out to be a problem, then this
> stuff has far more serious issues underneath.

Again, as I have stated before, one advantage of PREEMPT_COUNT=y is this
ability, so yes, believe it or not, I really do understand this.  ;-)

> So now you might argue that for a loop like this:
> 
>     do {
>         mutex_lock();
>         do_stuff();
>         mutex_unlock();
>     }
> 
> the ideal preemption point is post mutex_unlock(), which is where
> someone would mindfully (*cough*) place a cond_resched(), right?
> 
> So if that turns out to matter in reality and not just by academic
> inspection, then we are far better off to annotate such code with:
> 
>     do {
>         preempt_lazy_disable();
>         mutex_lock();
>         do_stuff();
>         mutex_unlock();
>         preempt_lazy_enable();
>     }
> 
> and let preempt_lazy_enable() evaluate the NEED_RESCHED_LAZY bit.

I am not exactly sure what semantics you are proposing with this pairing
as opposed to "this would be a good time to preempt in response to the
pending lazy request".  But I do agree that something like this could
replace at least a few more instance of cond_resched(), so that is good.
Not necessarily all of them, though.

> Then rcu_flavor_sched_clock_irq(bool user) can then use a two stage
> approach like the scheduler:
> 
> rcu_flavor_sched_clock_irq(bool user)
> {
> 	if (user || rcu_is_cpu_rrupt_from_idle() ||
> 	    !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
> 		rcu_qs();
>                 return;
> 	}
> 
>         if (this_cpu_read(rcu_data.rcu_urgent_qs)) {
>         	if (!need_resched_lazy()))
>                 	set_need_resched_lazy();
>                 else
>                 	set_need_resched();
> 	}
> }
> 
> But for a start I would just use the trivial
> 
>         if (this_cpu_read(rcu_data.rcu_urgent_qs))
>         	set_need_resched();
> 
> approach and see where this gets us.

Agreed, I would start with the plain set_need_resched().  This shouldn't
happen all that often, on default x86 builds nine milliseconds into the
grace period.

> With the approach I suggested to Ankur, i.e. having PREEMPT_AUTO(or
> LAZY) as a config option we can work on the details of the AUTO and
> RCU_PREEMPT=n flavour up to the point where we are happy to get rid
> of the whole zoo of config options alltogether.

I agree that some simplification should be possible and would be
desireable.

> Just insisting that RCU_PREEMPT=n requires cond_resched() and whatsoever
> is not really getting us anywhere.

Except that this is not what is happening, Thomas.  ;-)

You are asserting that all of the cond_resched() calls can safely be
eliminated.  That might well be, but more than assertion is required.
You have come up with some good ways of getting rid of some classes of
them, which is a very good and very welcome thing.  But that is not the
same as having proved that all of them may be safely removed.

							Thanx, Paul
