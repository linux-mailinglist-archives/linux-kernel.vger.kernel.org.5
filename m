Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36977D19A7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjJTXgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTXgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:36:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E307D4C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:36:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF524C433C8;
        Fri, 20 Oct 2023 23:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697845007;
        bh=AHox3vW6RLN4ZFLgXtMQXifWtp0VHjX3C9M5x6M9XC8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PGmsYM1GJukg/QYLw5TvPgWXQGifP1PADUPQZ9M2eQ6IDJS+F+6dcj/2JL8UFDyJG
         woEzcdJyLDlnTxGFPx2NwD3a0K9jdHqJviH8Ft04TvQxyX/w8Fx9RYHp7ewU/xw2LP
         QTuifMKTuwF6eykRegWMoPCvjY4fJMlQKbn0UkADme+ROZesBm+7Ii07vm6gr0tpVA
         Wxy8gHMr+lRSy+PyCvuP3b0GwC6F4+vayj5reZJfRRoN31VbWNqLOPCBpxH7cs01Yw
         66BKqEbtpx1zp1SRyxM9yYOne0kV6SINfJA4LnOUiuzA+/j9TTSDFu0BPfO/LaE7Nr
         fWcvQLheJf5+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6942ECE0D14; Fri, 20 Oct 2023 16:36:46 -0700 (PDT)
Date:   Fri, 20 Oct 2023 16:36:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ea5c18ad-c25a-43d5-b2ef-ec64117dc38e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttrngmq0.ffs@tglx>
 <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
 <8734y74g34.ffs@tglx>
 <4c7d06b9-8f5b-43ff-a2d6-86f54116da52@paulmck-laptop>
 <878r7wlx7d.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r7wlx7d.fsf@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:56:38PM -0700, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > Thomas!
> >
> > On Thu, Oct 19, 2023 at 02:21:35AM +0200, Thomas Gleixner wrote:
> >> Paul!
> >>
> >> On Wed, Oct 18 2023 at 10:19, Paul E. McKenney wrote:
> >> > On Wed, Oct 18, 2023 at 03:16:12PM +0200, Thomas Gleixner wrote:
> >> >> On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:
> >> >> In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
> >> >> remaining would be CONFIG_PREEMPT_RT, which should be renamed to
> >> >> CONFIG_RT or such as it does not really change the preemption
> >> >> model itself. RT just reduces the preemption disabled sections with the
> >> >> lock conversions, forced interrupt threading and some more.
> >> >
> >> > Again, please, no.
> >> >
> >> > There are situations where we still need rcu_read_lock() and
> >> > rcu_read_unlock() to be preempt_disable() and preempt_enable(),
> >> > repectively.  Those can be cases selected only by Kconfig option, not
> >> > available in kernels compiled with CONFIG_PREEMPT_DYNAMIC=y.
> >>
> >> Why are you so fixated on making everything hardcoded instead of making
> >> it a proper policy decision problem. See above.
> >
> > Because I am one of the people who will bear the consequences.
> >
> > In that same vein, why are you so opposed to continuing to provide
> > the ability to build a kernel with CONFIG_PREEMPT_RCU=n?  This code
> > is already in place, is extremely well tested, and you need to handle
> > preempt_disable()/preeempt_enable() regions of code in any case.  What is
> > the real problem here?
> 
> I have a somewhat related question. What ties PREEMPTION=y to PREEMPT_RCU=y?

This Kconfig block in kernel/rcu/Kconfig:

------------------------------------------------------------------------

config PREEMPT_RCU
	bool
	default y if PREEMPTION
	select TREE_RCU
	help
	  This option selects the RCU implementation that is
	  designed for very large SMP systems with hundreds or
	  thousands of CPUs, but for which real-time response
	  is also required.  It also scales down nicely to
	  smaller systems.

	  Select this option if you are unsure.

------------------------------------------------------------------------

There is no prompt string after the "bool", so it is not user-settable.
Therefore, it is driven directly off of the value of PREEMPTION, taking
the global default of "n" if PREEMPTION is not set and "y" otherwise.

You could change the second line to read:

	bool "Go ahead!  Make my day!"

or preferably something more helpful.  This change would allow a
preemptible kernel to be built with non-preemptible RCU and vice versa,
as used to be the case long ago.  However, it might be way better to drive
the choice from some other Kconfig option and leave out the prompt string.

> I see e72aeafc66 ("rcu: Remove prompt for RCU implementation") from
> 2015, stating that the only possible choice for PREEMPTION=y kernels
> is PREEMPT_RCU=y:
> 
>     The RCU implementation is chosen based on PREEMPT and SMP config options
>     and is not really a user-selectable choice.  This commit removes the
>     menu entry, given that there is not much point in calling something a
>     choice when there is in fact no choice..  The TINY_RCU, TREE_RCU, and
>     PREEMPT_RCU Kconfig options continue to be selected based solely on the
>     values of the PREEMPT and SMP options.

The main point of this commit was to reduce testing effort and sysadm
confusion by removing choices that were not necessary back then.

> As far as I can tell (which isn't all that far), TREE_RCU=y makes strictly
> stronger forward progress guarantees with respect to rcu readers (in
> that they can't be preempted.)

TREE_RCU=y is absolutely required if you want a kernel to run on a system
with more than one CPU, and for that matter, if you want preemptible RCU,
even on a single-CPU system.

> So, can PREEMPTION=y run with, say TREE_RCU=y? Or maybe I'm missing something
> obvious there.

If you meant to ask about PREEMPTION and PREEMPT_RCU, in theory, you
can run any combination:

PREEMPTION && PREEMPT_RCU:  This is what we use today for preemptible
	kernels, so this works just fine (famous last words).

PREEMPTION && !PREEMPT_RCU:  A preemptible kernel with non-preemptible
	RCU, so that rcu_read_lock() is preempt_disable() and
	rcu_read_unlock() is preempt_enable().	This should just work,
	except for the fact that cond_resched() disappears, which
	stymies some of RCU's forward-progress mechanisms.  And this
	was the topic of our earlier discussion on this thread.  The
	fixes should not be too hard.

	Of course, this has not been either tested or used for at least
	eight years, so there might be some bitrot.  If so, I will of
	course be happy to help fix it.

!PREEMPTION && PREEMPT_RCU:  A non-preemptible kernel with preemptible
	RCU.  Although this particular combination of Kconfig
	options has not been tested for at least eight years, giving
	a kernel built with CONFIG_PREEMPT_DYNAMIC=y the preempt=none
	kernel boot parameter gets you pretty close.  Again, there is
	likely to be some bitrot somewhere, but way fewer bits to rot
	than for PREEMPTION && !PREEMPT_RCU.  Outside of the current
	CONFIG_PREEMPT_DYNAMIC=y case, I don't see the need for this
	combination, but if there is a need and if it is broken, I will
	be happy to help fix it.

!PREEMPTION && !PREEMPT_RCU:  A non-preemptible kernel with non-preemptible
	RCU, which is what we use today for non-preemptible kernels built
	with CONFIG_PREEMPT_DYNAMIC=n.	So to repeat those famous last
	works, this works just fine.

Does that help, or am I missing the point of your question?

							Thanx, Paul
