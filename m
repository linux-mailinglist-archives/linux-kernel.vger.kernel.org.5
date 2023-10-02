Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA57B59D1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbjJBRzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbjJBRzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:55:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E90B9E;
        Mon,  2 Oct 2023 10:55:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0774CC433C8;
        Mon,  2 Oct 2023 17:55:42 +0000 (UTC)
Date:   Mon, 2 Oct 2023 13:56:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        "carlos@redhat.com" <carlos@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        "longman@redhat.com" <longman@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Message-ID: <20231002135643.4c8eefbd@gandalf.local.home>
In-Reply-To: <845039ad23d24cc687491efa95be5e0d@AcuMS.aculab.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
        <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
        <20230928103926.GI9829@noisy.programming.kicks-ass.net>
        <20230928104321.490782a7@rorschach.local.home>
        <40b76cbd00d640e49f727abbd0c39693@AcuMS.aculab.com>
        <20231002125109.55c35030@gandalf.local.home>
        <845039ad23d24cc687491efa95be5e0d@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 17:22:34 +0000
David Laight <David.Laight@ACULAB.COM> wrote:


> > And what heuristic would you use. My experience with picking "time to spin"
> > may work for one workload but cause major regressions in another workload.
> > I came to the conclusion to "hate" heuristics and NACK them whenever
> > someone suggested adding them to the rt_mutex in the kernel (back before
> > adaptive mutexes were introduced).  
> 
> Isn't that exactly what and adaptive mutex does?
> Spin 'for a bit' before sleeping.

But it's not some arbitrary time to spin. Technically, a kernel spin lock
is spinning on the heuristic of ownership. "Spin until the lock is
released" is a heuristic!

> 
> > > > The obvious problem with their implementation is that if the owner is
> > > > sleeping, there's no point in spinning. Worse, the owner may even be
> > > > waiting for the spinner to get off the CPU before it can run again. But
> > > > according to Robert, the gain in the general performance greatly
> > > > outweighed the few times this happened in practice.  
> > >
> > > Unless you can use atomics (ok for bits and linked lists) you
> > > always have the problem that userspace can't disable interrupts.
> > > So, unlike the kernel, you can't implement a proper spinlock.  
> > 
> > Why do you need to disable interrupts? If you know the owner is running on
> > the CPU, you know it's not trying to run on the CPU that is acquiring the
> > lock. Heck, there's normal spin locks outside of PREEMPT_RT that do not
> > disable interrupts. The only time you need to disable interrupts is if the
> > interrupt itself takes the spin lock, and that's just to prevent deadlocks.  
> 
> You need to disable interrupts in order to bound the time the
> spinlock is held for.
> If all you are doing is a dozen instructions (eg to remove an
> item from s list) then you really don't want an interrupt coming in
> while you have the spinlock held.

That's just noise of normal processing. What's the difference of it
happening during spinning to where it happens in normal execution?

> It isn't the cost of the ISR - that has to happen sometime, but that
> the cpu waiting for the spinlock also take the cost of the ISR.

As supposed to just going into the kernel? So it wastes some of its quota.
It's not stopping anything else from running more than normal.

> 
> A network+softint ISR can run for a long time - I'm sure I've
> seen a good fraction of a millisecond.
> You really don't want another (or many other) cpu spinning while
> that is going on.

Why not? The current user space only code does that now (and it will even
spin if the owner is preempted). What we are talking about implementing is
a big improvement to what is currently done.

> Which (to my mind) pretty much means that you always want to
> disable interrupts on a spinlock.

The benchmarks say otherwise. Sure, once in a while you may spin longer
because of an interrupt, but that's a very rare occurrence compared to
normal taking of spin locks. Disabling interrupts is an expensive
operation. The savings you get from "not waiting for a softirq to finish"
will be drowned out by the added overhead of disabling interrupts at every
acquire.

> If the architecture makes masking ISR expensive then I've seen schemes
> that let the hardware interrupt happen, then disable it and rerun later.
> 
> > > I've NFI how CONFIG_RT manages to get anything done with all
> > > the spinlocks replaced by sleep locks.
> > > Clearly there are a spinlocks that are held for far too long.
> > > But you really do want to spin most of the time.  
> > 
> > It spins as long as the owner of the lock is running on the CPU. This is
> > what we are looking to get from this patch series for user space.  
> 
> I think you'd need to detect that the cpu was in-kernel running an ISR.

For the few times that might happen, it's not worth it.

> 
> But the multithreaded audio app I was 'fixing' basically failed
> as soon as it had to sleep on one of the futex.
> The real problem was ISR while the mutex was held.
> So deciding to sleep because the lock owner isn't running (in user)
> would already be delaying things too much.

That doesn't sound like the use case we are fixing. If your audio app
failed because it had to sleep, that tells me it would fail regardless.

> 
> > 
> > Back in 2007, we had an issue with scaling on SMP machines. The RT kernel
> > with the sleeping spin locks would start to exponentially slow down with
> > the more CPUs you had. Once we hit more than 16 CPUs,  the time to boot a
> > kernel took 10s of minutes to boot RT when the normal CONFIG_PREEMPT kernel
> > would only take a couple of minutes. The more CPUs you added, the worse it
> > became.
> > 
> > Then SUSE submitted a patch to have the rt_mutex spin only if the owner of
> > the mutex was still running on another CPU. This actually mimics a real
> > spin lock (because that's exactly what they do, they spin while the owner
> > is running on a CPU). The difference between a true spin lock and an
> > rt_mutex was that the spinner would stop spinning if the owner was
> > preempted (a true spin lock owner could not be preempted).
> > 
> > After applying the adaptive spinning, we were able to scale PREEMPT_RT to
> > any number of CPUs that the normal kernel could do with just a linear
> > performance hit.  
> 
> Sounds like it was spinning for far too long at the best of times.
> But analysing these sort of latencies is hard.

It wasn't spinning at all! The problem was that all rt_mutex would
immediately sleep on any contention. This caused a ripple effect that would
increase the time locks were held and that would increase contention which
increased the time more. A very bad feedback loop.

This was all very well traced and studied. That analysis was not hard at
all. We know exactly what the cause was and why adaptive mutexes fixed the
situation. And this is why I'm excited about this current work.

-- Steve
