Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D0F7DCF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbjJaOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbjJaOnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:43:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B094FC;
        Tue, 31 Oct 2023 07:43:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EB0C433C7;
        Tue, 31 Oct 2023 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698763398;
        bh=66H98ojSE2UwXLJ24lU6oCRIUNq2Jb+IHbwCuZbB8TY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eGR5BWYv6XFZNxTD5fRj3kTzBpnaoPAJ/PTVG0FFXt+YYXsKJo1wgK1PN41f1Le1i
         x/842rZAkDr/D7vTwTRr4kAeJNM9wU09m//BHCh+7RP/DeXUpgAOFgfXrK6gOdLWb7
         +IXYhCcKqjlNYG32xrmzqmi4LuAsdnBxttv5OXKMxfufuNSSxTBredT/+6/4dK7Bdb
         JNuyoOCqI99bYOi5mZqfKOTFtaAD3er27HBTAldfdsEDUO6PKwy+zMQNkOqMBMQPuR
         DM60W7qPoTvtMs4xMx4LQYaVnmljoseZSitkQUJ9loR+fn32v9ZMjUV884acgfRXOy
         stbGC7DEEAoQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6B32DCE0DD0; Tue, 31 Oct 2023 07:43:18 -0700 (PDT)
Date:   Tue, 31 Oct 2023 07:43:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michael Matz <matz@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <a3a2015f-7610-45f7-87af-f8b4fdfc7e24@paulmck-laptop>
Reply-To: paulmck@kernel.org
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:16:34PM +0000, Michael Matz wrote:
> Hello,
> 
> On Tue, 31 Oct 2023, Peter Zijlstra wrote:
> 
> (I can't say anything about the WRITE_ONCE/rcu code, just about the below 
> codegen part)
> 
> > Welcome is not the right word. What bugs me most is that this was never
> > raised when this code was written :/
> > 
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
> 
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

I suspect that Peter cares because the code in question is on a fast
path within the scheduler.

> > At least clang doesn't do this, it stays:
> > 
> > 0403  413:      49 ff 45 00             incq   0x0(%r13)
> > 
> > irrespective of the volatile.
> 
> And, are you 100% sure that this is correct?  Even for x86 CPU 
> pipeline implementations that you aren't intimately knowing about? ;-)

Me, I am not even sure that the load-increment-store is always faithfully
executed by the hardware.  ;-)

> But all that seems to be a side-track anyway, what's your real worry with  
> the code sequence generated by GCC?

Again, my guess is that Peter cares deeply about the speed of the fast
path on which this increment occurs.

							Thanx, Paul
