Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3595D7FB8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjK1KxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343995AbjK1KxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:53:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F53189
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:53:22 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701168800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=b+nmSGDUEGGbpS4OWXh0DOTLqhAcww6OfuIQLAIqmSk=;
        b=fHlZqCBdJXpCeUuNADw2Y84vgaVgAH+Z4kKjzUmk+9zW1l9XJjgLVK4ovgOTTGMQxwekNI
        FpS8iuVbWQbbYmjvLUdEMuGklceDgIwQg7L/nG6+yKtJ9PibTiuWFb8LCdgNAR1YyG0Iql
        4S8gbjpOB+ke2l21VnQkFQ7qWiZrlINghV/DZsoTNFh/EIkYi+djv4Ry1n+F0EPebK0OMi
        cLpoaNE/tuzjgs0SbQGT7t3a4GmdL9QLo84KJESv89zpQQnYB5czrK+rB8OFQeqVCUqoyW
        m2qlXuUzihqtNqLp2eUfWEdOUAjvygGMGs6C5m/SbZDNmyYwUh3ZSIGTvv22bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701168800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=b+nmSGDUEGGbpS4OWXh0DOTLqhAcww6OfuIQLAIqmSk=;
        b=BfRS4p2OwGfCsN9elxynun7sb8wovaOBqBu8g8+QVG8f+qwRNSKESsGNnr9IJqr8twaRc1
        tubk7Mo6hW8tMNAA==
To:     paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
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
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
In-Reply-To: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
Date:   Tue, 28 Nov 2023 11:53:19 +0100
Message-ID: <87wmu2ywrk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul!

On Tue, Nov 21 2023 at 07:19, Paul E. McKenney wrote:
> On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:
>> Right now, the use of cond_resched() is basically a whack-a-mole game where
>> we need to whack all the mole loops with the cond_resched() hammer. As
>> Thomas said, this is backwards. It makes more sense to just not preempt in
>> areas that can cause pain (like holding a mutex or in an RCU critical
>> section), but still have the general kernel be fully preemptable.
>
> Which is quite true, but that whack-a-mole game can be ended without
> getting rid of build-time selection of the preemption model.  Also,
> that whack-a-mole game can be ended without eliminating all calls to
> cond_resched().

Which calls to cond_resched() should not be eliminated?

They all suck and keeping some of them is just counterproductive as
again people will sprinkle them all over the place for the very wrong
reasons.

> Additionally, if the end goal is to be fully preemptible as in eventually
> eliminating lazy preemption, you have a lot more convincing to do.

That's absolutely not the case. Even RT uses the lazy mode to prevent
overeager preemption for non RT tasks.

The whole point of the exercise is to keep the kernel always fully
preemptible, but only enforce the immediate preemption at the next
possible preemption point when necessary.

The decision when it is necessary is made by the scheduler and not
delegated to the whim of cond/might_resched() placement.

That is serving both worlds best IMO:

  1) LAZY preemption prevents the negative side effects of overeager
     preemption, aka. lock contention and pointless context switching.

     The whole thing behaves like a NONE kernel unless there are
     real-time tasks or a task did not comply to the lazy request within
     a given time.

  2) It does not prevent the scheduler from making decisions to preempt
     at the next possible preemption point in order to get some
     important computation on the CPU.

     A NONE kernel sucks vs. any sporadic [real-time] task. Just run
     NONE and watch the latencies. The latencies are determined by the
     interrupted context, the placement of the cond_resched() call and
     the length of the loop which is running.

     People have complained about that and the only way out for them is
     to switch to VOLUNTARY or FULL preemption and thereby paying the
     price for overeager preemption.

     A price which you don't want to pay for good reasons but at the
     same time you care about latencies in some aspects and the only
     answer you have for that is cond_resched() or similar which is not
     an answer at all.

  3) Looking at the initial problem Ankur was trying to solve there is
     absolutely no acceptable solution to solve that unless you think
     that the semantically invers 'allow_preempt()/disallow_preempt()'
     is anywhere near acceptable.

Thanks,

        tglx
