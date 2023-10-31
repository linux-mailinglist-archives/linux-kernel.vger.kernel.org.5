Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06E57DD183
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344836AbjJaQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbjJaQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:24:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCD4F5;
        Tue, 31 Oct 2023 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v/CK60RnmTzQkU5gQA5qKkb6Qyt3ppDzv6Lk+OdmbjM=; b=hljEqshcvR0IR3gQTFPeGPK6qo
        ijZV1UvLaxMwoqE/sKXg+PT1e7Alstz54A7mHAPGxSFFSxM7V8a2kgt7sgvwqMBdBoenv9RsKXBbe
        rP7Tp/mssCTCAZ6lUyLbq5QjwdZksIoKnIJJmWeHVDadDtfBgmdWJWGCdEGD7alZU4UqvOgT2SbJ5
        dUYsrjdJzSqvsZ/MLdveTT4BJ7k73eOx+SDPWxq6wSXzNx2M8q30zNInR8ldsEPMzAyhptsuwFqDv
        MBy8Wg1EjNeDiNN4/3P+K8oeaVUGFhkO1sRS+JaRdxJ46U5TaGTMNZjXZYxLUH+A1eyvOpSBb/Usw
        eIriSapQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxrX0-00B5Ij-If; Tue, 31 Oct 2023 16:23:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC4CA300473; Tue, 31 Oct 2023 17:23:53 +0100 (CET)
Date:   Tue, 31 Oct 2023 17:23:53 +0100
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
Message-ID: <20231031162353.GF15024@noisy.programming.kicks-ass.net>
References: <20231027192026.GG26550@noisy.programming.kicks-ass.net>
 <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
 <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
 <20231030082138.GJ26550@noisy.programming.kicks-ass.net>
 <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop>
 <20231031095202.GC35651@noisy.programming.kicks-ass.net>
 <alpine.LSU.2.20.2310311357450.15233@wotan.suse.de>
 <20231031151645.GB15024@noisy.programming.kicks-ass.net>
 <alpine.LSU.2.20.2310311523290.15233@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.2310311523290.15233@wotan.suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 03:55:20PM +0000, Michael Matz wrote:

> > There's a pile of situations where a RmW instruction is actively
> > different vs a load-store split, esp for volatile variables that are
> > explicitly expected to change asynchronously.
> > 
> > The original RmW instruction is IRQ-safe, while the load-store version
> > is not. If an interrupt lands in between the load and store and also
> > modifies the variable then the store after interrupt-return will
> > over-write said modification.
> > 
> > These are not equivalent.
> 
> Okay, then there you have it.  Namely that LLVM has a bug (but see next 
> paragraph).  For volatile x, x++ _must_ expand to a separate read and 
> write, because the abstract machine of C says so.  If a RmW isn't 
> equivalent to that, then it can't be used in this situation.  If you 
> _have_ to use a RmW for other reasons like interrupt safety, then a 
> volatile variable is not the way to force this, as C simply doesn't have 
> that concept and hence can't talk about it.  (Of course it can't, as not 
> all architectures could implement such, if it were required).

Yeah, RISC archs typically lack the RmW ops. I can understand C not
mandating their use. However, on architectures that do have them, using
them makes a ton of sense.

For us living in the real world, this C abstract machine is mostly a
pain in the arse :-)

> (If an RmW merely gives you more guarantees than a split load-store then 
> of course LLVM doesn't have a bug, but you said not-equivalent, so I'm 
> assuming the worst, that RmW also has fewer (other) guarantees)

RmW is strict superset of load-store, and as such not equivalent :-)

Specifically, using volatile degrades the guarantees -- which is counter
intuitive.

> So, are RMW ops a strict superset (vis the guarantees they give) of split 
> load-store?  If so we can at least say that using RMW is a valid 
> optimization :)  Still, an optmization only.

This.

> > > But all that seems to be a side-track anyway, what's your real worry with  
> > > the code sequence generated by GCC?
> > 
> > In this case it's sub-optimal code, both larger and possibly slower for
> > having two memops.
> > 
> > The reason to have volatile is because that's what Linux uses to
> > dis-allow store-tearing, something that doesn't happen in this case. A
> > suitably insane but conforming compiler could compile a non-volatile
> > memory increment into something insane like:
> > 
> > 	load byte-0, r1
> > 	increment r1
> > 	store r1, byte-0
> > 	jno done
> > 	load byte-1, r1
> > 	increment ri
> > 	store r1, byte 1
> > 	jno done
> > 	...
> > done:
> > 
> > We want to explicitly dis-allow this.
> 
> Yeah, I see.  Within C you don't have much choice than volatile for this 
> :-/  Funny thing: on some architectures this is actually what is generated 
> sometimes, even if it has multi-byte loads/stores.  This came up 
> recently on the gcc list and the byte-per-byte sequence was faster ;-) 
> (it was rather: load-by-bytes, form whole value via shifts, increment, 
> store-by-bytes)
> Insane codegen for insane micro-architectures!

*groan*

> > I know C has recently (2011) grown this _Atomic thing, but that has 
> > other problems.
> 
> Yeah.
> 
> So, hmm, I don't quite know what to say, you're between a rock and a hard 
> place, I guess.  You have to use volatile for its effects but then are 
> unhappy about its effects :)

Notably, Linux uses a *ton* of volatile and there has historically been
a lot of grumbling about the GCC stance of 'stupid' codegen the moment
it sees volatile.

It really would help us (the Linux community) if GCC were to be less
offended by the whole volatile thing and would try to generate better
code.

Paul has been on the C/C++ committee meetings and keeps telling me them
folks hate volatile with a passion up to the point of proposing to
remove it from the language or somesuch. But the reality is that Linux
very heavily relies on it and _Atomic simply cannot replace it.

> If you can confirm the above about validity of the optimization, then at 
> least there'd by a point for adding a peephole in GCC for this, even if 
> current codegen isn't a bug, but I still wouldn't hold my breath.  
> volatile is so ... ewww, it's best left alone.

Confirmed, and please, your SMP computer only works becuase of volatile,
it *is* important.
