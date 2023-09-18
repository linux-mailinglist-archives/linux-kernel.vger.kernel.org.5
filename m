Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF027A5643
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjIRXmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:42:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411AA97
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:42:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695080524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rePywX70u1l099NFRoIXI5wv5YY67gKP41Oe7hYYkP0=;
        b=3Dmr8ysylahzf5XeGeumuyeMHGfF30BJUzGTpMD5I/df9cweiV9hAoWSSEe5KxfHElFV2s
        fY1FgmcLJ5LdzXtyyRdHeNS6CwhYAPi6zQR2WftLhqI196suuv50DgSPYcE7eF74z4eA0D
        anzYgdinfT8kih6ioS5NFRuNEvhjGwfnhI2qj5FND6kVDYstgO55CtezMWM4l0j+Lp+7eF
        7SCOqiI5C/3PzRQaX1KpjzSjQOFZOTRU+KYgzjnwOBQIsTuVdjFrZio9JRmK9Eb3N7tWiM
        RijTgHJ0fZqcUo613OUdffu+sd+UOu1/gLQ8bJi+y+f4K9gmKVM1T364PdVJ+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695080524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rePywX70u1l099NFRoIXI5wv5YY67gKP41Oe7hYYkP0=;
        b=U8X/NNZ3aq+zu3FRVGWiJ2NKOWYcJ4IcbLLVXFOy3cDw5Kbz9oKowqfNUxBKkd1V2tB3lG
        CRU2+wJ2NkEC0mBA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
Date:   Tue, 19 Sep 2023 01:42:03 +0200
Message-ID: <87cyyfxd4k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12 2023 at 10:26, Peter Zijlstra wrote:
> On Mon, Sep 11, 2023 at 10:04:17AM -0700, Ankur Arora wrote:
>> > The problem with the REP prefix (and Xen hypercalls) is that
>> > they're long running instructions and it becomes fundamentally
>> > impossible to put a cond_resched() in.
>> >
>> >> Yes. I'm starting to think that that the only sane solution is to
>> >> limit cases that can do this a lot, and the "instruciton pointer
>> >> region" approach would certainly work.
>> >
>> > From a code locality / I-cache POV, I think a sorted list of
>> > (non overlapping) ranges might be best.
>> 
>> Yeah, agreed. There are a few problems with doing that though.
>> 
>> I was thinking of using a check of this kind to schedule out when
>> it is executing in this "reschedulable" section:
>>         !preempt_count() && in_resched_function(regs->rip);
>> 
>> For preemption=full, this should mostly work.
>> For preemption=voluntary, though this'll only work with out-of-line
>> locks, not if the lock is inlined.
>> 
>> (Both, should have problems with __this_cpu_* and the like, but
>> maybe we can handwave that away with sparse/objtool etc.)
>
> So one thing we can do is combine the TIF_ALLOW_RESCHED with the ranges
> thing, and then only search the range when TIF flag is set.
>
> And I'm thinking it might be a good idea to have objtool validate the
> range only contains simple instructions, the moment it contains control
> flow I'm thinking it's too complicated.

Can we take a step back and look at the problem from a scheduling
perspective?

The basic operation of a non-preemptible kernel is time slice
scheduling, which means that a task can run more or less undisturbed for
a full time slice once it gets on the CPU unless it schedules away
voluntary via a blocking operation.

This works pretty well as long as everything runs in userspace as the
preemption points in the return to user space path are independent of
the preemption model.

These preemption points handle both time slice exhaustion and priority
based preemption.

With PREEMPT=NONE these are the only available preemption points.

That means that kernel code can run more or less indefinitely until it
schedules out or returns to user space, which is obviously not possible
for kernel threads.

To prevent starvation the kernel gained voluntary preemption points,
i.e. cond_resched(), which has to be added manually to code as a
developer sees fit.

Later we added PREEMPT=VOLUNTARY which utilizes might_resched() as
additional preemption points. might_resched() utilizes the existing
might_sched() debug points, which are in code paths which might block on
a contended resource. These debug points are mostly in core and
infrastructure code and are in code paths which can block anyway. The
only difference is that they allow preemption even when the resource is
uncontended.

Additionally we have PREEMPT=FULL which utilizes every zero transition
of preeempt_count as a potential preemption point.

Now we have the situation of long running data copies or data clear
operations which run fully in hardware, but can be interrupted. As the
interrupt return to kernel mode does not preempt in the NONE and
VOLUNTARY cases, new workarounds emerged. Mostly by defining a data
chunk size and adding cond_reched() again.

That's ugly and does not work for long lasting hardware operations so we
ended up with the suggestion of TIF_ALLOW_RESCHED to work around
that. But again this needs to be manually annotated in the same way as a
IP range based preemption scheme requires annotation.

TBH. I detest all of this.

Both cond_resched() and might_sleep/sched() are completely random
mechanisms as seen from time slice operation and the data chunk based
mechanism is just heuristics which works as good as heuristics tend to
work. allow_resched() is not any different and IP based preemption
mechanism are not going to be any better.

The approach here is: Prevent the scheduler to make decisions and then
mitigate the fallout with heuristics.

That's just backwards as it moves resource control out of the scheduler
into random code which has absolutely no business to do resource
control.

We have the reverse issue observed in PREEMPT_RT. The fact that spinlock
held sections became preemtible caused even more preemption activity
than on a PREEMPT=FULL kernel. The worst side effect of that was
extensive lock contention.

The way how we addressed that was to add a lazy preemption mode, which
tries to preserve the PREEMPT=FULL behaviour when the scheduler wants to
preempt tasks which all belong to the SCHED_OTHER scheduling class. This
works pretty well and gains back a massive amount of performance for the
non-realtime throughput oriented tasks without affecting the
schedulability of real-time tasks at all. IOW, it does not take control
away from the scheduler. It cooperates with the scheduler and leaves the
ultimate decisions to it.

I think we can do something similar for the problem at hand, which
avoids most of these heuristic horrors and control boundary violations.

The main issue is that long running operations do not honour the time
slice and we work around that with cond_resched() and now have ideas
with this new TIF bit and IP ranges.

None of that is really well defined in respect to time slices. In fact
its not defined at all versus any aspect of scheduling behaviour.

What about the following:

   1) Keep preemption count and the real preemption points enabled
      unconditionally. That's not more overhead than the current
      DYNAMIC_PREEMPT mechanism as long as the preemption count does not
      go to zero, i.e. the folded NEED_RESCHED bit stays set.

      From earlier experiments I know that the overhead of preempt_count
      is minimal and only really observable with micro benchmarks.
      Otherwise it ends up in the noise as long as the slow path is not
      taken.

      I did a quick check comparing a plain inc/dec pair vs. the
      DYMANIC_PREEMPT inc/dec_and_test+NOOP mechanism and the delta is
      in the non-conclusive noise.

      20 years ago this was a real issue because we did not have:

       - the folding of NEED_RESCHED into the preempt count
       
       - the cacheline optimizations which make the preempt count cache
         pretty much always cache hot

       - the hardware was way less capable

      I'm not saying that preempt_count is completely free today as it
      obviously adds more text and affects branch predictors, but as the
      major distros ship with DYNAMIC_PREEMPT enabled it is obviously an
      acceptable and tolerable tradeoff.

   2) When the scheduler wants to set NEED_RESCHED due it sets
      NEED_RESCHED_LAZY instead which is only evaluated in the return to
      user space preemption points.

      As NEED_RESCHED_LAZY is not folded into the preemption count the
      preemption count won't become zero, so the task can continue until
      it hits return to user space.

      That preserves the existing behaviour.

   3) When the scheduler tick observes that the time slice is exhausted,
      then it folds the NEED_RESCHED bit into the preempt count which
      causes the real preemption points to actually preempt including
      the return from interrupt to kernel path.

      That even allows the scheduler to enforce preemption for e.g. RT
      class tasks without changing anything else.

      I'm pretty sure that this gets rid of cond_resched(), which is an
      impressive list of instances:

	./drivers	 392
	./fs		 318
	./mm		 189
	./kernel	 184
	./arch		  95
	./net		  83
	./include	  46
	./lib		  36
	./crypto	  16
	./sound		  16
	./block		  11
	./io_uring	  13
	./security	  11
	./ipc		   3

      That list clearly documents that the majority of these
      cond_resched() invocations is in code which neither should care
      nor should have any influence on the core scheduling decision
      machinery.

I think it's worth a try as it just fits into the existing preemption
scheme, solves the issue of long running kernel functions, prevents
invalid preemption and can utilize the existing instrumentation and
debug infrastructure.

Most importantly it gives control back to the scheduler and does not
make it depend on the mercy of cond_resched(), allow_resched() or
whatever heuristics sprinkled all over the kernel.

To me this makes a lot of sense, but I might be on the completely wrong
track. Se feel free to tell me that I'm completely nuts and/or just not
seeing the obvious.

Thanks,

        tglx
