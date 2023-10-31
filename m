Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A79B7DD37B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376357AbjJaQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346927AbjJaQw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780D6132;
        Tue, 31 Oct 2023 09:49:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 159411F460;
        Tue, 31 Oct 2023 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698770998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWsQIn7ZkGzO6NK5PHMSWSWR/jIKE/XBQ2VgQvF6oWU=;
        b=bnitcGCe3p+/SPIabZB6USeL/VymqpPJ4x/HtwHu9ibIjcuMhj2865GvxdFZzXXf/QL3Uj
        TewihLVBj8H7HsomFJ8uhcu/QngN4suBP6mOHJiR22TaIEBwiyVNQqtow+iwhohaVsuMKO
        UbRWSd3DJ4Vx1T9RCpC50Xh8obATvEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698770998;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWsQIn7ZkGzO6NK5PHMSWSWR/jIKE/XBQ2VgQvF6oWU=;
        b=vQb9t+qZHj89dN/KqgASgTL8JomW7MDHPiXGfIcN1cC3avRXpFFdk7IQ9XcFH3C9WXKf4x
        EaABCAWmB+iEVtDQ==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A37E32C36A;
        Tue, 31 Oct 2023 16:49:56 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id D6D9666B2; Tue, 31 Oct 2023 16:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id D442C6050;
        Tue, 31 Oct 2023 16:49:56 +0000 (UTC)
Date:   Tue, 31 Oct 2023 16:49:56 +0000 (UTC)
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
In-Reply-To: <20231031162353.GF15024@noisy.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.20.2310311624500.15233@wotan.suse.de>
References: <20231027192026.GG26550@noisy.programming.kicks-ass.net> <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop> <20231027224628.GI26550@noisy.programming.kicks-ass.net> <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
 <20231030082138.GJ26550@noisy.programming.kicks-ass.net> <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop> <20231031095202.GC35651@noisy.programming.kicks-ass.net> <alpine.LSU.2.20.2310311357450.15233@wotan.suse.de> <20231031151645.GB15024@noisy.programming.kicks-ass.net>
 <alpine.LSU.2.20.2310311523290.15233@wotan.suse.de> <20231031162353.GF15024@noisy.programming.kicks-ass.net>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Tue, 31 Oct 2023, Peter Zijlstra wrote:

> > equivalent to that, then it can't be used in this situation.  If you 
> > _have_ to use a RmW for other reasons like interrupt safety, then a 
> > volatile variable is not the way to force this, as C simply doesn't have 
> > that concept and hence can't talk about it.  (Of course it can't, as not 
> > all architectures could implement such, if it were required).
> 
> Yeah, RISC archs typically lack the RmW ops. I can understand C not
> mandating their use. However, on architectures that do have them, using
> them makes a ton of sense.
> 
> For us living in the real world, this C abstract machine is mostly a
> pain in the arse :-)

Believe me, without it you would live in a world where only languages like 
ECMA script or Rust existed, without any reliable spec at all ("it's 
obvious, the language should behave like this-and-that compiler from 2010 
implements it! Or was it 2012?").  Even if it sometimes would make life 
easier without (also for compilers!), at least you _have_ an arse to feel 
pain in! :-)  Ahem.

> > So, hmm, I don't quite know what to say, you're between a rock and a hard 
> > place, I guess.  You have to use volatile for its effects but then are 
> > unhappy about its effects :)
> 
> Notably, Linux uses a *ton* of volatile and there has historically been
> a lot of grumbling about the GCC stance of 'stupid' codegen the moment
> it sees volatile.
> 
> It really would help us (the Linux community) if GCC were to be less
> offended by the whole volatile thing and would try to generate better
> code.
> 
> Paul has been on the C/C++ committee meetings and keeps telling me them
> folks hate volatile with a passion up to the point of proposing to
> remove it from the language or somesuch. But the reality is that Linux
> very heavily relies on it and _Atomic simply cannot replace it.

Oh yeah, I agree.  People trying to get rid of volatile are misguided.  
Of course one can try to capture all the individual aspects of it, and 
make individual language constructs for them (_Atomic is one).  It makes 
arguing about and precisely specifying the aspects much easier.  But it 
also makes the feature-interoperability matrix explode and the language 
more complicated in areas that were already arcane to start with.

But it's precisely _because_ of the large-scale feature set of volatile 
and the compilers wish to cater for the real world, that it's mostly left 
alone, as is, as written by the author.  Sure, one can wish for better 
codegen related to volatile.  But it's a slippery slope: "here I have 
volatile, because I don't want optimizations to happen." - "but here I 
want a little optimization to happen" - "but not these" - ... It's ... not 
so easy :)

In this specific case I think we have now sufficiently argued that 
"load-modify-store --> rmw" on x86 even for volatile accesses is a correct 
transformation (and one that has sufficiently local effects that our heads 
don't explode while thinking about all consequences).  You'd have to do 
that for each and every transformation where volatile stuff is involved, 
just so to not throw out the baby with the water.

> > If you can confirm the above about validity of the optimization, then at 
> > least there'd by a point for adding a peephole in GCC for this, even if 
> > current codegen isn't a bug, but I still wouldn't hold my breath.  
> > volatile is so ... ewww, it's best left alone.
> 
> Confirmed, and please, your SMP computer only works becuase of volatile,
> it *is* important.

Agreed.


Ciao,
Michael.
