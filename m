Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24F57AC5BC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 00:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjIWWuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 18:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWWux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 18:50:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91915192
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 15:50:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695509444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9TrV3gfVcpFGzPDaVs5xEnHkuQwVZuJwyc2p1iOFNA=;
        b=j2EDbywGj7bPbhUe/eruZZniZhSxdy+ciYib1r+ScnZMyz4zVL78xV02SbNwM76HVn5YpD
        yRTCBp4rGTwoilpUfsUAPFZB4z0Kzb7BLRkO3F9TJ7vXgpYzlkcCpOXi+MTaywLcA4QBAE
        QLr/MF6wh29U1LkSRyfuEjI0cQhCEioPCFN8Q4+81vT/dlAf8ERuMNWHzVnatN/ic9E1QS
        qrtGDxQdaYm+QVizu7P585pagp+5EsntH3N0kv1Mpl1u3luvlBCYKUS2lqDIpxk0cvNrFn
        N1b0CGAze1SsBbS03fDTkBNlEBcZPOuvPjrCiaWNBXyA2lkIe05pn84UZdbmWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695509444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9TrV3gfVcpFGzPDaVs5xEnHkuQwVZuJwyc2p1iOFNA=;
        b=BPAMe5KD46XluUB/F6Hhx0U4e0qiaPPPWhS4XrTV+oQo65Rxc5UsYBHiVDEONI8Nkbfk0j
        6WXFIMOiywA/+PCw==
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
In-Reply-To: <87led2wdj0.ffs@tglx>
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
 <87led2wdj0.ffs@tglx>
Date:   Sun, 24 Sep 2023 00:50:43 +0200
Message-ID: <87h6nkh5bw.ffs@tglx>
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

On Tue, Sep 19 2023 at 14:30, Thomas Gleixner wrote:
> On Mon, Sep 18 2023 at 18:57, Linus Torvalds wrote:
>> Then the question becomes whether we'd want to introduce a *new*
>> concept, which is a "if you are going to schedule, do it now rather
>> than later, because I'm taking a lock, and while it's a preemptible
>> lock, I'd rather not sleep while holding this resource".
>>
>> I suspect we want to avoid that for now, on the assumption that it's
>> hopefully not a problem in practice (the recently addressed problem
>> with might_sleep() was that it actively *moved* the scheduling point
>> to a bad place, not that scheduling could happen there, so instead of
>> optimizing scheduling, it actively pessimized it). But I thought I'd
>> mention it.
>
> I think we want to avoid that completely and if this becomes an issue,
> we rather be smart about it at the core level.
>
> It's trivial enough to have a per task counter which tells whether a
> preemtible lock is held (or about to be acquired) or not. Then the
> scheduler can take that hint into account and decide to grant a
> timeslice extension once in the expectation that the task leaves the
> lock held section soonish and either returns to user space or schedules
> out. It still can enforce it later on.
>
> We really want to let the scheduler decide and rather give it proper
> hints at the conceptual level instead of letting developers make random
> decisions which might work well for a particular use case and completely
> suck for the rest. I think we wasted enough time already on those.

Finally I realized why cond_resched() & et al. are so disgusting. They
are scope-less and just a random spot which someone decided to be a good
place to reschedule.

But in fact the really relevant measure is scope. Full preemption is
scope based:

      preempt_disable();
      do_stuff();
      preempt_enable();

which also nests properly:

      preempt_disable();
      do_stuff()
        preempt_disable();
        do_other_stuff();
        preempt_enable();
      preempt_enable();

cond_resched() cannot nest and is obviously scope-less.

The TIF_ALLOW_RESCHED mechanism, which sparked this discussion only
pretends to be scoped.

As Peter pointed out it does not properly nest with other mechanisms and
it cannot even nest in itself because it is boolean.

The worst thing about it is that it is semantically reverse to the
established model of preempt_disable()/enable(),
i.e. allow_resched()/disallow_resched().

So instead of giving the scheduler a hint about 'this might be a good
place to preempt', providing proper scope would make way more sense:

      preempt_lazy_disable();
      do_stuff();
      preempt_lazy_enable();

That would be the obvious and semantically consistent counterpart to the
existing preemption control primitives with proper nesting support.

might_sleep(), which is in all the lock acquire functions or your
variant of hint (resched better now before I take the lock) are the
wrong place.

     hint();
     lock();
     do_stuff();
     unlock();

hint() might schedule and when the task comes back schedule immediately
again because the lock is contended. hint() does again not have scope
and might be meaningless or even counterproductive if called in a deeper
callchain.

Proper scope based hints avoid that.

      preempt_lazy_disable();
      lock();
      do_stuff();
      unlock();
      preempt_lazy_enable();
      
That's way better because it describes the scope and the task will
either schedule out in lock() on contention or provide a sensible lazy
preemption point in preempt_lazy_enable(). It also nests properly:

      preempt_lazy_disable();
      lock(A);
      do_stuff()
        preempt_lazy_disable();
        lock(B);
        do_other_stuff();
        unlock(B);
        preempt_lazy_enable();
      unlock(A);
      preempt_lazy_enable();

So in this case it does not matter wheter do_stuff() is invoked from a
lock held section or not. The scope which defines the throughput
relevant hint to the scheduler is correct in any case.

Contrary to preempt_disable() the lazy variant does neither prevent
scheduling nor preemption, but its a understandable properly nestable
mechanism.

I seriously hope to avoid it alltogether :)

Thanks,

        tglx
