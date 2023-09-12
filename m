Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F979C988
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjILIOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjILIOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:14:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5236810C3;
        Tue, 12 Sep 2023 01:14:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C31C433CA;
        Tue, 12 Sep 2023 08:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694506453;
        bh=WcZtaGkqHKbm5o/8W3nvSSv5FuHAVyX3MpMpnPsL/0c=;
        h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
        b=C8EVGg3sEa4s2hRrayFXZ1I+jDWksSLL3if5dCWrOcVBKUk8GZ8utCZWTL221cQ2D
         e/mJtgRwXrZoRI3Hvnc0roaRWLB5sK141GFVpnH33evgyQCJC3+taCbMpM1dZmzIEN
         tHUjnAc2zeEzyttPnqQ7HOaymRe2Zi6/OWLBq2ja0Nxnq6szibvfFqM7TzrU+Ho1Xy
         aaq8MT4ZFdoCH5OucNS/eky/bze77CbV9LnasPZrr7RqFH03rpTt+z0Si4TeH4PSIH
         /JeiztajGUfZQn4Y5bAWioiCLLCJVSwHb/aemHoO/lzctjG+1RoDDTcF2A0MJt2bOX
         3eueL9guc3jKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 80B62CE093C; Tue, 12 Sep 2023 01:14:12 -0700 (PDT)
Date:   Tue, 12 Sep 2023 01:14:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver>
 <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911235452.xhtnt7ply7ayr53x@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wrote:
> > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wrote:
> > > > > (Adding Paul & Shanker to Cc list.. please see below for why)
> > > > > 
> > > > > Apologies on the late response, I was away and have been struggling to
> > > > > get a working PPC32 test environment.
> > > > > 
> > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > > > > > 	Hi Liam,
> > > > > > 
> > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > The current implementation of append may cause duplicate data and/or
> > > > > > > incorrect ranges to be returned to a reader during an update.  Although
> > > > > > > this has not been reported or seen, disable the append write operation
> > > > > > > while the tree is in rcu mode out of an abundance of caution.
> > > > > 
> > > > > ...
> > > > > > > 
> 
> ...
> 
> > > > > > RCU-related configs:
> > > > > > 
> > > > > >     $ grep RCU .config
> > > > > >     # RCU Subsystem
> > > > > >     CONFIG_TINY_RCU=y

I must have been asleep last time I looked at this.  I was looking at
Tree RCU.  Please accept my apologies for my lapse.  :-/

However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I would
have said the same thing, albeit after looking at a lot less RCU code.

TL;DR:

1.	Try making the __setup_irq() function's call to mutex_lock()
	instead be as follows:

	if (!mutex_trylock(&desc->request_mutex))
		mutex_lock(&desc->request_mutex);

	This might fail if __setup_irq() has other dependencies on a
	fully operational scheduler.

2.	Move that ppc32 call to __setup_irq() much later, most definitely
	after interrupts have been enabled and the scheduler is fully
	operational.  Invoking mutex_lock() before that time is not a
	good idea.  ;-)

For more detail, please read on!

> > > > > >     # CONFIG_RCU_EXPERT is not set
> > > > > >     CONFIG_TINY_SRCU=y
> > > > > >     # end of RCU Subsystem
> > > > > >     # RCU Debugging
> > > > > >     # CONFIG_RCU_SCALE_TEST is not set
> > > > > >     # CONFIG_RCU_TORTURE_TEST is not set
> > > > > >     # CONFIG_RCU_REF_SCALE_TEST is not set
> > > > > >     # CONFIG_RCU_TRACE is not set
> > > > > >     # CONFIG_RCU_EQS_DEBUG is not set
> > > > > >     # end of RCU Debugging
> > > > > 
> > > > > I used the configuration from debian 8 and ran 'make oldconfig' to build
> > > > > my kernel.  I have attached the configuration.
> 
> ...
> 
> > > > > It appears to be something to do with struct maple_tree sparse_irqs.  If
> > > > > you drop the rcu flag from that maple tree, then my configuration boots
> > > > > without the warning.
> > > > > 
> > > > > I *think* this is because we will reuse a lot more nodes.  And I *think*
> > > > > the rcu flag is not needed, since there is a comment about reading the
> > > > > tree being protected by the mutex sparse_irq_lock within the
> > > > > kernel/irq/irqdesc.c file.  Shanker, can you comment on that?
> > > > > 
> > > > > I wonder if there is a limit to the number of RCU free events before
> > > > > something is triggered to flush them out which could trigger IRQ
> > > > > enabling? Paul, could this be the case?
> > > > 
> > > > Are you asking if call_rcu() will re-enable interrupts in the following
> > > > use case?
> > > > 
> > > > 	local_irq_disable();
> > > > 	call_rcu(&p->rh, my_cb_func);
> > > > 	local_irq_enable();
> 
> I am not.
> 
> ...
> 
> > > > 
> > > > Or am I missing your point?
> > > 
> > > This is very early in the boot sequence when interrupts have not been
> > > enabled.  What we are seeing is a WARN_ON() that is triggered by
> > > interrupts being enabled before they should be enabled.
> > > 
> > > I was wondering if, for example, I called call_rcu() a lot *before*
> > > interrupts were enabled, that something could trigger that would either
> > > enable interrupts or indicate the task needs rescheduling?
> > 
> > You aren't doing call_rcu() enough to hit OOM, are you?  The actual RCU
> > callback invocations won't happen until some time after the scheduler
> > starts up.
> 
> I am not, it's just a detection of IRQs being enabled early.
> 
> > 
> > > Specifically the rescheduling part is suspect.  I tracked down the call
> > > to a mutex_lock() which calls cond_resched(), so could rcu be
> > > 'encouraging' the rcu window by a reschedule request?
> > 
> > During boot before interrupts are enabled, RCU has not yet spawned any of
> > its kthreads.  Therefore, all of its attempts to do wakeups would notice
> > a NULL task_struct pointer and refrain from actually doing the wakeup.
> > If it did do the wakeup, you would see a NULL-pointer exception.  See
> > for example, invoke_rcu_core_kthread(), though that won't happen unless
> > you booted with rcutree.use_softirq=0.
> > 
> > Besides, since when did doing a wakeup enable interrupts?  That would
> > make it hard to do wakeups from hardware interrupt handlers, not?
> 
> Taking the mutex lock in kernel/irq/manage.c __setup_irq() is calling a
> cond_resched().
> 
> >From what Michael said [1] in this thread, since something has already
> set TIF_NEED_RESCHED, it will eventually enable interrupts on us.
> 
> I've traced this to running call_rcu() in kernel/rcu/tiny.c and
> is_idle_task(current) is true, which means rcu runs:
> 		/* force scheduling for rcu_qs() */                                                                     
>                 resched_cpu(0);
> 
> the task is set idle in sched_init() -> init_idle() and never changed,
> afaict.

Yes, because RCU eventually needs a context switch in order to make
a grace period happen.  And Maple Tree isn't the only thing invoking
call_rcu() early, so this has been in place for a very long time.

> Removing the RCU option from the maple tree in kernel/irq/irqdesc.c
> fixes the issue by avoiding the maple tree running call_rcu().  I am not
> sure on the locking of the tree so I feel this change may cause other
> issues...also it's before lockdep_init(), so any issue I introduce may
> not be detected.
> 
> When CONFIG_DEBUG_ATOMIC_SLEEP is configured, it seems that rcu does the
> same thing, but the IRQs are not enabled on return.  So, resched_cpu(0)
> is called, but the IRQs warning of enabled isn't triggered.  I failed to
> find a reason why.

Here you mean IRQs being enabled upon return from __setup_irq(), correct?

But yes, __setup_irq() does call mutex_lock().  Which will call
preempt_schedule_common() via might_sleep() and __cond_resched(), even
though that is clearly a very bad thing this early.  And let's face it,
the whole purpose of mutex_lock() is to block when needed.  And a big
purpose of that might_sleep() is to yell at people invoking this with
interrupts disabled.

And most of the wrappers around __setup_irq() look to be intended
for much later, after interrupts have been enabled.  One exception is
setup_percpu_irq(), which says that it is for "the early boot process",
whenever that might be.  But this is only invoked from mips in v6.5.

The __request_percpu_irq() function is wrappered by request_percpu_irq(),
and its header comment suggests that it is to be called after there are
multiple CPUs.  I am not seeing a call that is obviously from ppc32,
but there are a number of drivers using this with which I am unfamiliar.

The request_percpu_nmi() has to be followed up on each CPU using
prepare_percpu_nmi() and enable_percpu_nmi(), so it is not clear that
it is useful to invoke this before interrupts are enabled.  But this is
used by ARM, not ppc32 from what I can see.

So even though I am not seeing how ppc32 invokes __setup_irq() early,
your testing clearly indicates that it is doing so.

> I am not entirely sure what makes ppc32 different than other platforms
> in that the initial task is configured to an idle task and the first
> call to call_rcu (tiny!) would cause the observed behaviour.

Maybe something like this in __setup_irq(), right before the
mutex_lock()?

	WARN_ON_ONCE(irqs_disabled());

This will dump the stack trace showing how __setup_irq() is being invoked
in early boot on ppc32.

Again, given that __setup_irq() invokes mutex_lock(), invoking this
function in its current form before interrupts have been enabled is a
bad idea.

> Non-tiny rcu calls (as I am sure you know, but others may not)
> kernel/rcu/tree.c which in turn calls __call_rcu_common().  That
> function is far more complex than the tiny version.  Maybe it's part of
> why we see different behaviour based on platforms?  I don't see an idle
> check in that version of call_rcu().

Tree RCU can rely on the grace-period kthread starting up later in boot.
This kthread will handle any need for a grace period from early boot
invocation of call_rcu().  Tiny RCU does not have such a kthread, hence
the resched_cpu().  Which is fine, as long as nothing (incorrectly!)
invokes a blocking operation before the scheduler has been initialized.

> Or maybe PPC32 has something set incorrectly to cause this failure in
> early boot and I've just found something that needs to be set
> differently?

This might be a failure of imagination on my part, but I certainly don't
see why ppc32 should expect to get away with invoking __setup_irq()
anywhere near that early!  ;-)

But if ppc32 cannot be adjusted so as to invoke __setup_irq() later,
the following change to __setup_irq() might work:

	if (!mutex_trylock(&desc->request_mutex))
		mutex_lock(&desc->request_mutex);

The reason for "might" rather than "will" is that __setup_irq() might
well have other dependencies on the scheduler being up and running.

It would be cleaner for that ppc32 call to __setup_irq() to be moved
later, after the scheduler is up and running.

> > But why not put some WARN_ON_ONCE(!irqs_disabled()) calls in the areas
> > of greatest suspicion, starting from the stack trace generated by that
> > mutex_lock()?  A stray interrupt-enable could be pretty much anywhere.
> > 
> > But where are those call_rcu() invocations?  Before rcu_init()?
> 
> During init_IRQ(), which is after rcu_init() but before rcu_init_nohz(),
> srcu_init(), and softirq_init() in init/main.c start_kernel().

That is a perfectly legal time and place for a call_rcu() invocation.
It is also legal before rcu_init(), but it has to be late enough that
things like per-CPU variables are accessible.  Which is still very early.

> > Presumably before init is spawned and the early_init() calls.
> > 
> > And what is the RCU-related Kconfig and boot-parameter setup?
> 
> The .config was attached to the email I sent, and it matches what was
> quoted above in the "RCU-related configs" section.
> 
> [1] https://lore.kernel.org/linux-mm/87v8cv22jh.fsf@mail.lhotse/

Again, apologies for having misread that .config snippet!!!

							Thanx, Paul
