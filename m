Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBAB7DD04F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbjJaPSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJaPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:18:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7C2D42;
        Tue, 31 Oct 2023 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LiGcsZom1SDIM8uQ4Ed6vqC5uJcrUXeqZ5iXIeC2l7o=; b=Ml3LC6caKciiFHyY6MmqiBqFHs
        bhw7TUF04hGZjiUrRva9q7Irr+byF9CA/JF7tb26o1gDHhQwwtle3FZGMIgOm8C+B4Nvbrq42OmMP
        B20iF5kpj1IY6vgyEB7e2h5e3GwAmBLofTowO0GeyCIxXRgOSuYro7NQgFPGswNPfm7AQbr8GPIF1
        NqMoRjcoxwvOh17LPcGlqI2rnlSaYKL52nijAD0l9keKRYaC/4+CGWfqkLyAhsDRvhFLl9GQA9CIB
        DQgbVeKRqDzhpzXRMI+YGce8/TbOTCfRJAxYmi/zqzRhJplkMupWtZ4Y+LfzMh6CXWRcynfAOO6Zx
        YlV7vpsA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxqU2-004tmF-1S;
        Tue, 31 Oct 2023 15:16:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 191FB300478; Tue, 31 Oct 2023 16:16:46 +0100 (CET)
Date:   Tue, 31 Oct 2023 16:16:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Matz <matz@suse.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, ubizjak@gmail.com
Subject: Re: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
Message-ID: <20231031151645.GB15024@noisy.programming.kicks-ass.net>
References: <20231027144050.110601-1-frederic@kernel.org>
 <20231027144050.110601-3-frederic@kernel.org>
 <20231027192026.GG26550@noisy.programming.kicks-ass.net>
 <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
 <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
 <20231030082138.GJ26550@noisy.programming.kicks-ass.net>
 <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop>
 <20231031095202.GC35651@noisy.programming.kicks-ass.net>
 <alpine.LSU.2.20.2310311357450.15233@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.2310311357450.15233@wotan.suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:16:34PM +0000, Michael Matz wrote:

> > Mostly my problem is that GCC generates such utter shite when you
> > mention volatile. See, the below patch changes the perfectly fine and
> > non-broken:
> > 
> > 0148  1d8:      49 83 06 01             addq   $0x1,(%r14)
> 
> What is non-broken here that is ...
> 
> > into:
> > 
> > 0148  1d8:	49 8b 06             	mov    (%r14),%rax
> > 014b  1db:	48 83 c0 01          	add    $0x1,%rax
> > 014f  1df:	49 89 06             	mov    %rax,(%r14)
> 
> ... broken here?  (Sure code size and additional register use, but I don't 
> think you mean this with broken).

The point was that the code was perfectly fine without adding the
volatile, and adding volatile makes it worse.

> > For absolutely no reason :-(
> 
> The reason is simple (and should be obvious): to adhere to the abstract 
> machine regarding volatile.  When x is volatile then x++ consists of a 
> read and a write, in this order.  The easiest way to ensure this is to 
> actually generate a read and a write instruction.  Anything else is an 
> optimization, and for each such optimization you need to actively find an 
> argument why this optimization is correct to start with (and then if it's 
> an optimization at all).  In this case the argument needs to somehow 
> involve arguing that an rmw instruction on x86 is in fact completely 
> equivalent to the separate instructions, from read cycle to write cycle 
> over all pipeline stages, on all implementations of x86.  I.e. that a rmw 
> instruction is spec'ed to be equivalent.
> 
> You most probably can make that argument in this specific case, I'll give 
> you that.  But why bother to start with, in a piece of software that is 
> already fairly complex (the compiler)?  It's much easier to just not do 
> much anything with volatile accesses at all and be guaranteed correct.
> Even more so as the software author, when using volatile, most likely is 
> much more interested in correct code (even from a abstract machine 
> perspective) than micro optimizations.

There's a pile of situations where a RmW instruction is actively
different vs a load-store split, esp for volatile variables that are
explicitly expected to change asynchronously.

The original RmW instruction is IRQ-safe, while the load-store version
is not. If an interrupt lands in between the load and store and also
modifies the variable then the store after interrupt-return will
over-write said modification.

These are not equivalent.

In this case that's not relevant because the increment happens to happen
with IRQs disabled. But the point is that these forms are very much not
equivalent.

> > At least clang doesn't do this, it stays:
> > 
> > 0403  413:      49 ff 45 00             incq   0x0(%r13)
> > 
> > irrespective of the volatile.
> 
> And, are you 100% sure that this is correct?  Even for x86 CPU 
> pipeline implementations that you aren't intimately knowing about? ;-)

It so happens that the x86 architecture does guarantee RmW ops are
IRQ-safe or locally atomic. SMP/concurrent loads will observe either
pre or post but no intermediate state as well.

> But all that seems to be a side-track anyway, what's your real worry with  
> the code sequence generated by GCC?

In this case it's sub-optimal code, both larger and possibly slower for
having two memops.

The reason to have volatile is because that's what Linux uses to
dis-allow store-tearing, something that doesn't happen in this case. A
suitably insane but conforming compiler could compile a non-volatile
memory increment into something insane like:

	load byte-0, r1
	increment r1
	store r1, byte-0
	jno done
	load byte-1, r1
	increment ri
	store r1, byte 1
	jno done
	...
done:

We want to explicitly dis-allow this.

I know C has recently (2011) grown this _Atomic thing, but that has
other problems.
