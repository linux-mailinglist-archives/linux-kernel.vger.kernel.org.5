Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A77A5BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjISIEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjISIEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:04:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A36119
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:03:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31ff985e292so3519312f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695110635; x=1695715435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37ycrR3zHzHC4wpgKEajHtJ3wBSuAl9mnzunftgHE3M=;
        b=DBclhoQqI5VvOhzMfMSnfnbDdx9OXojQfmInbRxKi820OpTpt2ROsmTJebxROCmSWZ
         UYITvoFsQe+6C/Yaq5TiAm4YA1EBr7aWEQEmohzcJI5ScRutPdMARw7TIfdIWbyU+vVs
         /qHmZWNprKli78+A2NTySAxBLinkvxKSXVy63aMTqF18QZWma/wfgv4giRgxnaH+xK6X
         C0apD2FyeQ7Ev1RrXaHZOVjAQ+eK6p7YwCrGaA7hcx659bx5U8xSr0Lvmq9Y0n9Phb7B
         WRyzfRQ6XSxdhEPN/7CLtFvVMI2xE0h+e2VBfzWDRU0vUyBgWbMV/am6EDIU3+iltFgw
         UJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695110635; x=1695715435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37ycrR3zHzHC4wpgKEajHtJ3wBSuAl9mnzunftgHE3M=;
        b=fp8XngMngrLsskVY5/ooJ5BoYWfkST/EUAe1VUoEH7gFSjNcnjaLe2IJdOxYEgvisQ
         0ZXe1BjaucO8DMEDH+7/77WpadKSdQC2/yGdhkFjL6NKsT+IXpyeXYniFrN7tTmJ/NaF
         TopoA1kx28t4Nn281RV9/SqYcbXtvi+0fEAal1vkZtxFHloTkUgu7zffkKjrzT2yJyZG
         B8orLMerEyPhDlrscamUHUx+FdID5HzHoX1iHWGR/z/DpNrjEbPd2DEvK9vL/TaQ851V
         MdShqGxHuiyImFwND8y2RvW7SE3ctRtLXJVrW7lGNZs0mAD3WV32R6vFmlFs7xF3V5WC
         uU1w==
X-Gm-Message-State: AOJu0YweiV4jVA9laCTt6y9TOXGo65dJuDEA0OLcnsIeTJGCS49vGQ2A
        rR12VFWpAS0uZ3SBJdiZe0w=
X-Google-Smtp-Source: AGHT+IHDmmgMMVudA4IPBHzjhC7RAdaQlhq/xBwb8qOyIknqfG67jKZkUxUjpG+saQz4rc5ZNKfQ9w==
X-Received: by 2002:a5d:5149:0:b0:319:62e0:f2fe with SMTP id u9-20020a5d5149000000b0031962e0f2femr9407366wrt.36.1695110634362;
        Tue, 19 Sep 2023 01:03:54 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4c8f000000b0030647449730sm14834844wrs.74.2023.09.19.01.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:03:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 19 Sep 2023 10:03:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ZQlV5l4pbKunQJug@gmail.com>
References: <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 18 Sept 2023 at 16:42, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > What about the following:
> >
> >    1) Keep preemption count and the real preemption points enabled
> >       unconditionally.
> 
> Well, it's certainly the simplest solution, and gets rid of not just
> the 'rep string' issue, but gets rid of all the cond_resched() hackery
> entirely.
> 
> >       20 years ago this was a real issue because we did not have:
> >
> >        - the folding of NEED_RESCHED into the preempt count
> >
> >        - the cacheline optimizations which make the preempt count cache
> >          pretty much always cache hot
> >
> >        - the hardware was way less capable
> >
> >       I'm not saying that preempt_count is completely free today as it
> >       obviously adds more text and affects branch predictors, but as the
> >       major distros ship with DYNAMIC_PREEMPT enabled it is obviously an
> >       acceptable and tolerable tradeoff.
> 
> Yeah, the fact that we do presumably have PREEMPT_COUNT enabled in most 
> distros does speak for just admitting that the PREEMPT_NONE / VOLUNTARY 
> approach isn't actually used, and is only causing pain.

The macro-behavior of NONE/VOLUNTARY is still used & relied upon in server 
distros - and that's the behavior that enterprise distros truly cared 
about.

Micro-overhead of NONE/VOLUNTARY vs. FULL is nonzero but is in the 'noise' 
category for all major distros I'd say.

And that's what Thomas's proposal achieves: keep the nicely execution-batched 
NONE/VOLUNTARY scheduling behavior for SCHED_OTHER tasks, while having the 
latency advantages of fully-preemptible kernel code for RT and critical 
tasks.

So I'm fully on board with this. It would reduce the number of preemption 
variants to just two: regular kernel and PREEMPT_RT. Yummie!

> >    2) When the scheduler wants to set NEED_RESCHED due it sets
> >       NEED_RESCHED_LAZY instead which is only evaluated in the return to
> >       user space preemption points.
> 
> Is this just to try to emulate the existing PREEMPT_NONE behavior?

Yes: I'd guesstimate that the batching caused by timeslice-laziness that is 
naturally part of NONE/VOLUNTARY resolves ~90%+ of observable 
macro-performance regressions between NONE/VOLUNTARY and PREEMPT/RT.

> If the new world order is that the time slice is always honored, then the 
> "this might be a latency issue" goes away. Good.
> 
> And we'd also get better coverage for the *debug* aim of "might_sleep()" 
> and CONFIG_DEBUG_ATOMIC_SLEEP, since we'd rely on PREEMPT_COUNT always 
> existing.
> 
> But because the latency argument is gone, the "might_resched()" should 
> then just be removed entirely from "might_sleep()", so that might_sleep() 
> would *only* be that DEBUG_ATOMIC_SLEEP thing.

Correct. And that's even a minor code generation advantage, as we wouldn't 
have these additional hundreds of random/statistical preemption checks.

> That argues for your suggestion too, since we had a performance issue due 
> to "might_sleep()" _not_ being just a debug thing, and pointlessly 
> causing a reschedule in a place where reschedules were _allowed_, but 
> certainly much less than optimal.
> 
> Which then caused that fairly recent commit 4542057e18ca ("mm: avoid 
> 'might_sleep()' in get_mmap_lock_carefully()").

4542057e18ca is arguably kind of a workaround though - and with the 
preempt_count + NEED_RESCHED_LAZY approach we'd have both the latency 
advantages *and* the execution-batching performance advantages of 
NONE/VOLUNTARY that 4542057e18ca exposed.

> However, that does bring up an issue: even with full preemption, there 
> are certainly places where we are *allowed* to schedule (when the preempt 
> count is zero), but there are also some places that are *better* than 
> other places to schedule (for example, when we don't hold any other 
> locks).
> 
> So, I do think that if we just decide to go "let's just always be 
> preemptible", we might still have points in the kernel where preemption 
> might be *better* than in others points.

So in the broadest sense we have 3 stages of pending preemption:

   NEED_RESCHED_LAZY
   NEED_RESCHED_SOON
   NEED_RESCHED_NOW

And we'd transition:

  - from    0 -> SOON when an eligible task is woken up,
  - from LAZY -> SOON when current timeslice is exhausted,
  - from SOON -> NOW  when no locks/resources are held.

  [ With a fast-track for RT or other urgent tasks to enter NOW immediately. ]

On the regular kernels it's probably not worth modeling the SOON/NOW split, 
as we'd have to track the depth of sleeping locks as well, which we don't 
do right now.

On PREEMPT_RT the SOON/NOW distinction possibly makes sense, as there we 
are aware of locking depth already and it would be relatively cheap to 
check for it on natural 0-preempt_count boundaries.


> But none of might_resched(), might_sleep() _or_ cond_resched() are 
> necessarily that kind of "this is a good point" thing. They come from a 
> different background.

Correct, they come from two sources:

 - They are hundreds of points that we know are 'technically correct' 
   preemption points, and they break up ~90% of long latencies by brute 
   force & chance.

 - Explicitly identified problem points that added a cond_resched() or its 
   equivalent. These are rare and also tend to bitrot, because *removing* 
   them is always more risky than adding them, so they tend to accumulate.

> So what I think what you are saying is that we'd have the following 
> situation:
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

I'd even argue that we only need two preemption modes, and that 'fully 
preemptible low-latency desktop' is an artifact of poor latencies on 
PREEMPT_NONE.

Ie. in the long run - after a careful period of observing performance 
regressions and other dragons - we'd only have *two* preemption modes left:

   !PREEMPT_RT     # regular kernel. Single default behavior.
   PREEMPT_RT=y    # -rt kernel, because rockets, satellites & cars matter.

Any other application level preemption preferences can be expressed via 
scheduling policies & priorities.

Nothing else. We don't need PREEMPT_DYNAMIC, PREEMPT_VOLUNTARY or 
PREEMPT_NONE in any of their variants, probably not even as runtime knobs.

People who want shorter timeslices can set shorter timeslices, and people 
who want immediate preemption of certain tasks can manage priorities.

>  - but the "timeslice over" case would always set the preempt-count-bit, 
> regardless of any config, and would guarantee that we have reasonable 
> latencies.

Yes. Probably a higher nice-priority task becoming runnable would cause 
immediate preemption too, in addition to RT tasks.

Ie. the execution batching would be for same-priority groups of SCHED_OTHER 
tasks.

> This all makes cond_resched() (and might_resched()) pointless, and
> they can just go away.

Yep.

> Then the question becomes whether we'd want to introduce a *new* concept, 
> which is a "if you are going to schedule, do it now rather than later, 
> because I'm taking a lock, and while it's a preemptible lock, I'd rather 
> not sleep while holding this resource".

Something close to this concept is naturally available on PREEMPT_RT 
kernels, which only use a single central lock primitive (rt_mutex), but it 
would have be added explicitly for regular kernels.

We could do the following intermediate step:

 - Remove all the random cond_resched() points such as might_sleep()
 - Turn all explicit cond_resched() points into 'ideal point to reschedule'.

 - Maybe even rename it from cond_resched() to resched_point(), to signal 
   the somewhat different role.

While cond_resched() and resched_point() are not 100% matches, they are 
close enough, as most existing cond_resched() points were added to places 
that cause the least amount of disruption with held resources.

But I think it would be better to add resched_point() as a new API, and add 
it to places where there's a performance benefit. Clean slate, 
documentation, and all that.

> I suspect we want to avoid that for now, on the assumption that it's 
> hopefully not a problem in practice (the recently addressed problem with 
> might_sleep() was that it actively *moved* the scheduling point to a bad 
> place, not that scheduling could happen there, so instead of optimizing 
> scheduling, it actively pessimized it). But I thought I'd mention it.
> 
> Anyway, I'm definitely not opposed. We'd get rid of a config option that 
> is presumably not very widely used, and we'd simplify a lot of issues, 
> and get rid of all these badly defined "cond_preempt()" things.

I think we can get rid of *all* the preemption model Kconfig knobs, except 
PREEMPT_RT. :-)

Thanks,

	Ingo
