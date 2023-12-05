Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240898043AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjLEBBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEBBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:01:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D224101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:01:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B7FC433C7;
        Tue,  5 Dec 2023 01:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701738084;
        bh=87+opENFHVxb4r8vWzTfPZbzUsfLV0xi8qw1aguD08c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eayp4XkNfs4A+5kiHvcgyT8erJMahBuKlXkjRI+zG9MhS/KzQOEAR4XnJ6MXkOgoZ
         5fOITSZSmSGMeDXUrsaWreX4882T8jzHitfh5M0S/B8YTyFtVxQjw8UFFYgYwCW5y7
         SHsNo7cCman4adEx0/NH/V7+Lg3GKcNw9JDZ6CA/3x8bpViRjuvjCBjYhzCLPGjZOH
         n9fJYT7SUehfCMbcw44fXoOQ9EMn5EbRWzcSP4kGP+DAc4xMR1FAqQT19x5IjCsU7z
         kGSz8tPdAidqknvhfhpzm5etbx9dzc4pFnXeB9T3i3vcNQyP5sNevP6oy6blq1RWgb
         DQKIkMWmh2oJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B1A76CE1147; Mon,  4 Dec 2023 17:01:21 -0800 (PST)
Date:   Mon, 4 Dec 2023 17:01:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
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
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
Message-ID: <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
 <87wmu2ywrk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmu2ywrk.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:53:19AM +0100, Thomas Gleixner wrote:
> Paul!
> 
> On Tue, Nov 21 2023 at 07:19, Paul E. McKenney wrote:
> > On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:
> >> Right now, the use of cond_resched() is basically a whack-a-mole game where
> >> we need to whack all the mole loops with the cond_resched() hammer. As
> >> Thomas said, this is backwards. It makes more sense to just not preempt in
> >> areas that can cause pain (like holding a mutex or in an RCU critical
> >> section), but still have the general kernel be fully preemptable.
> >
> > Which is quite true, but that whack-a-mole game can be ended without
> > getting rid of build-time selection of the preemption model.  Also,
> > that whack-a-mole game can be ended without eliminating all calls to
> > cond_resched().
> 
> Which calls to cond_resched() should not be eliminated?

The ones which, if eliminated, will result in excessive latencies.

This question is going to take some time to answer.  One type of potential
issue is where the cond_resched() precedes something like mutex_lock(),
where that mutex_lock() takes the fast path and preemption follows
shortly thereafter.  It would clearly have been better to have preempted
before acquisition.

Another is the aforementioned situations where removing the cond_resched()
increases latency.  Yes, capping the preemption latency is a wonderful
thing, and the people I chatted with are all for that, but it is only
natural that there would be a corresponding level of concern about the
cases where removing the cond_resched() calls increases latency.

There might be others as well.  These are the possibilities that have
come up thus far.

> They all suck and keeping some of them is just counterproductive as
> again people will sprinkle them all over the place for the very wrong
> reasons.

Yes, but do they suck enough and are they counterproductive enough to
be useful and necessary?  ;-)

> > Additionally, if the end goal is to be fully preemptible as in eventually
> > eliminating lazy preemption, you have a lot more convincing to do.
> 
> That's absolutely not the case. Even RT uses the lazy mode to prevent
> overeager preemption for non RT tasks.

OK, that is very good to hear.

> The whole point of the exercise is to keep the kernel always fully
> preemptible, but only enforce the immediate preemption at the next
> possible preemption point when necessary.
> 
> The decision when it is necessary is made by the scheduler and not
> delegated to the whim of cond/might_resched() placement.

I am not arguing that the developer placing a given cond_resched()
always knows best, but you have some work to do to convince me that the
scheduler always knows best.

> That is serving both worlds best IMO:
> 
>   1) LAZY preemption prevents the negative side effects of overeager
>      preemption, aka. lock contention and pointless context switching.
> 
>      The whole thing behaves like a NONE kernel unless there are
>      real-time tasks or a task did not comply to the lazy request within
>      a given time.

Almost, give or take the potential issues called out above for the
possible downsides of removing all of the cond_resched() invocations.

>   2) It does not prevent the scheduler from making decisions to preempt
>      at the next possible preemption point in order to get some
>      important computation on the CPU.
> 
>      A NONE kernel sucks vs. any sporadic [real-time] task. Just run
>      NONE and watch the latencies. The latencies are determined by the
>      interrupted context, the placement of the cond_resched() call and
>      the length of the loop which is running.
> 
>      People have complained about that and the only way out for them is
>      to switch to VOLUNTARY or FULL preemption and thereby paying the
>      price for overeager preemption.
> 
>      A price which you don't want to pay for good reasons but at the
>      same time you care about latencies in some aspects and the only
>      answer you have for that is cond_resched() or similar which is not
>      an answer at all.

All good points, but none of them are in conflict with the possibility
of leaving some cond_resched() calls behind if they ar needed.

>   3) Looking at the initial problem Ankur was trying to solve there is
>      absolutely no acceptable solution to solve that unless you think
>      that the semantically invers 'allow_preempt()/disallow_preempt()'
>      is anywhere near acceptable.

I am not arguing for allow_preempt()/disallow_preempt(), so for that
argument, you need to find someone else to argue with.  ;-)

							Thanx, Paul
