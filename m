Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB87A62FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjISMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:31:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C08F2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:31:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695126660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQsM7CS8A5K1O59yEJkuhXKlnkKW3IXCC2xPBJ00QNo=;
        b=A0ZZ5dsfFYZko3dqxpQPOFISG9yS9n62vEDeKl271/LvR7gr5lQdzYJ4A2Fszj9j5RYSFW
        hB3DeetfK8ox8+JViTwp77C8/1dnPKOBSZKih0uTyARAWwUT3b+ScPU1Yx1umETttO69xu
        U57NWPdvIt5yPHD4rpIklJVGLgaws9esFjApOhHSO7E57kghjdb2vUwJfti84gPx8UGe/b
        yAMRniDvCmZltGIiHbywLNqMwpBamTuPn7Vp20equuBORH7WJXfZVPrI/A/4S/UG7TDZ+A
        UuyJo3e5Xypzkl62Fc4EYIfCof04nDlUfGMmI1eP8BgSCbLYYQZA3+l+dKpt0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695126660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQsM7CS8A5K1O59yEJkuhXKlnkKW3IXCC2xPBJ00QNo=;
        b=UhKD+HVhfUPqJzIkP04bseo16VJiqHJX/fU4qSiyot1c4K8kcqFtuSg0jiUgsx5ghWDf7L
        Z8/O7kpKflGcB1BQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
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
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
Date:   Tue, 19 Sep 2023 14:30:59 +0200
Message-ID: <87led2wdj0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus!

On Mon, Sep 18 2023 at 18:57, Linus Torvalds wrote:
> On Mon, 18 Sept 2023 at 16:42, Thomas Gleixner <tglx@linutronix.de> wrote:
>>    2) When the scheduler wants to set NEED_RESCHED due it sets
>>       NEED_RESCHED_LAZY instead which is only evaluated in the return to
>>       user space preemption points.
>
> Is this just to try to emulate the existing PREEMPT_NONE behavior?

To some extent yes.

> If the new world order is that the time slice is always honored, then
> the "this might be a latency issue" goes away. Good.

That's the point.

> And we'd also get better coverage for the *debug* aim of
> "might_sleep()" and CONFIG_DEBUG_ATOMIC_SLEEP, since we'd rely on
> PREEMPT_COUNT always existing.
>
> But because the latency argument is gone, the "might_resched()" should
> then just be removed entirely from "might_sleep()", so that
> might_sleep() would *only* be that DEBUG_ATOMIC_SLEEP thing.

True. And this gives the scheduler the flexibility to enforce preemption
under certain conditions, e.g. when a task with RT scheduling class or a
task with a sporadic event handler is woken up. That's what VOLUNTARY
tries to achieve with all the might_sleep()/might_resched() magic.

> That argues for your suggestion too, since we had a performance issue
> due to "might_sleep()" _not_ being just a debug thing, and pointlessly
> causing a reschedule in a place where reschedules were _allowed_, but
> certainly much less than optimal.
>
> Which then caused that fairly recent commit 4542057e18ca ("mm: avoid
> 'might_sleep()' in get_mmap_lock_carefully()").

Awesome.

> However, that does bring up an issue: even with full preemption, there
> are certainly places where we are *allowed* to schedule (when the
> preempt count is zero), but there are also some places that are
> *better* than other places to schedule (for example, when we don't
> hold any other locks).
>
> So, I do think that if we just decide to go "let's just always be
> preemptible", we might still have points in the kernel where
> preemption might be *better* than in others points.
>
> But none of might_resched(), might_sleep() _or_ cond_resched() are
> necessarily that kind of "this is a good point" thing. They come from
> a different background.

They are subject to subsystem/driver specific preferences and therefore
biased towards a certain usage scenario, which is not necessarily to the
benefit of everyone else.

> So what I think what you are saying is that we'd have the following situation:
>
>  - scheduling at "return to user space" is presumably always a good thing.
>
> A non-preempt-count bit NEED_RESCHED_LAZY (or TIF_RESCHED, or
> whatever) would cover that, and would give us basically the existing
> CONFIG_PREEMPT_NONE behavior.
>
> So a config variable (either compile-time with PREEMPT_NONE or a
> dynamic one with DYNAMIC_PREEMPT set to none) would make any external
> wakeup only set that bit.
>
> And then a "fully preemptible low-latency desktop" would set the
> preempt-count bit too.

Correct.

>  - but the "timeslice over" case would always set the
> preempt-count-bit, regardless of any config, and would guarantee that
> we have reasonable latencies.

Yes. That's the reasoning.

> This all makes cond_resched() (and might_resched()) pointless, and
> they can just go away.

:)

So the decision matrix would be:

                Ret2user        Ret2kernel      PreemptCnt=0

NEED_RESCHED       Y                Y               Y 
LAZY_RESCHED       Y                N               N

That is completely independent of the preemption model and the
differentiation of the preemption models happens solely at the scheduler
level:

PREEMPT_NONE sets only LAZY_RESCHED unless it needs to enforce the time
slice where it sets NEED_RESCHED.

PREEMPT_VOLUNTARY extends the NONE model so that the wakeup of RT class
tasks or sporadic event tasks sets NEED_RESCHED too.

PREEMPT_FULL always sets NEED_RESCHED like today.

We should be able merge the PREEMPT_NONE/VOLUNTARY behaviour so that we
only end up with two variants or even subsume PREEMPT_FULL into that
model because that's what is closer to the RT LAZY preempt behaviour,
which has two goals:

      1) Make low latency guarantees for RT workloads

      2) Preserve the throughput for non-RT workloads

But in any case this decision happens solely in the core scheduler code
and nothing outside of it needs to be changed.

So we not only get rid of the cond/might_resched() muck, we also get rid
of the static_call/static_key machinery which drives PREEMPT_DYNAMIC.
The only place which still needs that runtime tweaking is the scheduler
itself.

Though it just occured to me that there are dragons lurking:

arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
arch/um/Kconfig:        select ARCH_NO_PREEMPT

So we have four architectures which refuse to enable preemption points,
i.e. the only model they allow is NONE and they rely on cond_resched()
for breaking large computations.

But they support PREEMPT_COUNT, so we might get away with a reduced
preemption point coverage:

                Ret2user        Ret2kernel      PreemptCnt=0

NEED_RESCHED       Y                N               Y 
LAZY_RESCHED       Y                N               N

i.e. the only difference is that Ret2kernel is not a preemption
point. That's where the scheduler tick enforcement of the time slice
happens.

It still might work out good enough and if not then it should not be
real rocket science to add that Ret2kernel preemption point to cure it.

> Then the question becomes whether we'd want to introduce a *new*
> concept, which is a "if you are going to schedule, do it now rather
> than later, because I'm taking a lock, and while it's a preemptible
> lock, I'd rather not sleep while holding this resource".
>
> I suspect we want to avoid that for now, on the assumption that it's
> hopefully not a problem in practice (the recently addressed problem
> with might_sleep() was that it actively *moved* the scheduling point
> to a bad place, not that scheduling could happen there, so instead of
> optimizing scheduling, it actively pessimized it). But I thought I'd
> mention it.

I think we want to avoid that completely and if this becomes an issue,
we rather be smart about it at the core level.

It's trivial enough to have a per task counter which tells whether a
preemtible lock is held (or about to be acquired) or not. Then the
scheduler can take that hint into account and decide to grant a
timeslice extension once in the expectation that the task leaves the
lock held section soonish and either returns to user space or schedules
out. It still can enforce it later on.

We really want to let the scheduler decide and rather give it proper
hints at the conceptual level instead of letting developers make random
decisions which might work well for a particular use case and completely
suck for the rest. I think we wasted enough time already on those.

> Anyway, I'm definitely not opposed. We'd get rid of a config option
> that is presumably not very widely used, and we'd simplify a lot of
> issues, and get rid of all these badly defined "cond_preempt()"
> things.

Hmm. Didn't I promise a year ago that I won't do further large scale
cleanups and simplifications beyond printk.

Maybe I get away this time with just suggesting it. :)

Thanks,

        tglx
