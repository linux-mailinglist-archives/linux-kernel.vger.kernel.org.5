Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEA7DCF10
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbjJaOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjJaOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:16:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C6101;
        Tue, 31 Oct 2023 07:16:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B60ED21AC1;
        Tue, 31 Oct 2023 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698761796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1DPyubupoPQN73YGtcNTutaeN3pRw7nAotqztrut50=;
        b=ph1zRWBKluhacuBqyjQIBw/46RbVjstdg9Kl0h43OpiYDRdduupdG6Azf4o4zAtMeLBPEN
        tOR3Q2glLkUIs7BknEur/BBWpCUDCL9IdgVS0DA91qszslp6hg9OrSB9dLHx0wyjiAb/Pg
        sHbJUwpKMXe4UEENW41VDIP7jTg8fI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698761796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1DPyubupoPQN73YGtcNTutaeN3pRw7nAotqztrut50=;
        b=ocHg07GBqvanbx4T5IVuISSH+5OBJoaY5aijbvVUAtUNUzvxd+/o3x6nXjWwztaCwYO2e4
        a3iCq1In3YlHJmAg==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DFD622CE02;
        Tue, 31 Oct 2023 14:16:34 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id 21B116782; Tue, 31 Oct 2023 14:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id 1F96D6050;
        Tue, 31 Oct 2023 14:16:35 +0000 (UTC)
Date:   Tue, 31 Oct 2023 14:16:34 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
In-Reply-To: <20231031095202.GC35651@noisy.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.20.2310311357450.15233@wotan.suse.de>
References: <20231027144050.110601-1-frederic@kernel.org> <20231027144050.110601-3-frederic@kernel.org> <20231027192026.GG26550@noisy.programming.kicks-ass.net> <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop> <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop> <20231030082138.GJ26550@noisy.programming.kicks-ass.net> <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop> <20231031095202.GC35651@noisy.programming.kicks-ass.net>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 31 Oct 2023, Peter Zijlstra wrote:

(I can't say anything about the WRITE_ONCE/rcu code, just about the below 
codegen part)

> Welcome is not the right word. What bugs me most is that this was never
> raised when this code was written :/
> 
> Mostly my problem is that GCC generates such utter shite when you
> mention volatile. See, the below patch changes the perfectly fine and
> non-broken:
> 
> 0148  1d8:      49 83 06 01             addq   $0x1,(%r14)

What is non-broken here that is ...

> into:
> 
> 0148  1d8:	49 8b 06             	mov    (%r14),%rax
> 014b  1db:	48 83 c0 01          	add    $0x1,%rax
> 014f  1df:	49 89 06             	mov    %rax,(%r14)

... broken here?  (Sure code size and additional register use, but I don't 
think you mean this with broken).

> For absolutely no reason :-(

The reason is simple (and should be obvious): to adhere to the abstract 
machine regarding volatile.  When x is volatile then x++ consists of a 
read and a write, in this order.  The easiest way to ensure this is to 
actually generate a read and a write instruction.  Anything else is an 
optimization, and for each such optimization you need to actively find an 
argument why this optimization is correct to start with (and then if it's 
an optimization at all).  In this case the argument needs to somehow 
involve arguing that an rmw instruction on x86 is in fact completely 
equivalent to the separate instructions, from read cycle to write cycle 
over all pipeline stages, on all implementations of x86.  I.e. that a rmw 
instruction is spec'ed to be equivalent.

You most probably can make that argument in this specific case, I'll give 
you that.  But why bother to start with, in a piece of software that is 
already fairly complex (the compiler)?  It's much easier to just not do 
much anything with volatile accesses at all and be guaranteed correct.
Even more so as the software author, when using volatile, most likely is 
much more interested in correct code (even from a abstract machine 
perspective) than micro optimizations.

> At least clang doesn't do this, it stays:
> 
> 0403  413:      49 ff 45 00             incq   0x0(%r13)
> 
> irrespective of the volatile.

And, are you 100% sure that this is correct?  Even for x86 CPU 
pipeline implementations that you aren't intimately knowing about? ;-)

But all that seems to be a side-track anyway, what's your real worry with  
the code sequence generated by GCC?


Ciao,
Michael.
