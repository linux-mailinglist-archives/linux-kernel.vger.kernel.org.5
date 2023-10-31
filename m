Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B117DD450
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjJaRLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjJaRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:10:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085283;
        Tue, 31 Oct 2023 10:10:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12165C433C7;
        Tue, 31 Oct 2023 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698772255;
        bh=Th4ywlyLRr/0sxbHZGZwsaz5cKdSrO4tkd9cgckdNZE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eiySwqxXDBXb8eJrdT0Q907b8uHZJAClu3lLh+zZsE1Tr3tTgOKNkoDeK7v0eS03Q
         v1S5D6/F1Ar93gX0LVDM9JrfcuHe02duLFNplSZdvtotNL3bYg9a6cBnzvUevdXRpQ
         gfrNCReNjaTx/VnPThSzB+G2HwHG+pWLn+bQQJsoW3LOIxc6dAeOMaDGAbJeER9Ir8
         HV7LIQRYYXDn3ohi4joM8cQ2FRSUp58TDFvrd/40MIX1q5oetrhsINOE2WWkWw6JOA
         2K0CeqC5CskInyezSg9LmIiE6wFQnmQsYBUcGAVqfPnYwxlZ8cL5gpHvoGpIABSh70
         6hBwp8irRMg2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A7223CE0B6B; Tue, 31 Oct 2023 10:10:54 -0700 (PDT)
Date:   Tue, 31 Oct 2023 10:10:54 -0700
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
Message-ID: <e59205b8-d12c-42ba-b0c8-55103a42e917@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
 <20231030082138.GJ26550@noisy.programming.kicks-ass.net>
 <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop>
 <20231031095202.GC35651@noisy.programming.kicks-ass.net>
 <alpine.LSU.2.20.2310311357450.15233@wotan.suse.de>
 <20231031151645.GB15024@noisy.programming.kicks-ass.net>
 <alpine.LSU.2.20.2310311523290.15233@wotan.suse.de>
 <20231031162353.GF15024@noisy.programming.kicks-ass.net>
 <alpine.LSU.2.20.2310311624500.15233@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.2310311624500.15233@wotan.suse.de>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 04:49:56PM +0000, Michael Matz wrote:
> Hey,
> 
> On Tue, 31 Oct 2023, Peter Zijlstra wrote:
> 
> > > equivalent to that, then it can't be used in this situation.  If you 
> > > _have_ to use a RmW for other reasons like interrupt safety, then a 
> > > volatile variable is not the way to force this, as C simply doesn't have 
> > > that concept and hence can't talk about it.  (Of course it can't, as not 
> > > all architectures could implement such, if it were required).
> > 
> > Yeah, RISC archs typically lack the RmW ops. I can understand C not
> > mandating their use. However, on architectures that do have them, using
> > them makes a ton of sense.
> > 
> > For us living in the real world, this C abstract machine is mostly a
> > pain in the arse :-)
> 
> Believe me, without it you would live in a world where only languages like 
> ECMA script or Rust existed, without any reliable spec at all ("it's 
> obvious, the language should behave like this-and-that compiler from 2010 
> implements it! Or was it 2012?").  Even if it sometimes would make life 
> easier without (also for compilers!), at least you _have_ an arse to feel 
> pain in! :-)  Ahem.

You mean like Rust volatiles considering conflicting accesses to be
data races?  That certainly leads me to wonder how a Rust-language device
driver is supposed to interoperate with Rust-language device firmware.

They currently propose atomics and things like the barrier() asm to make
that work, and their definition of atomic might just allow it.

> > > So, hmm, I don't quite know what to say, you're between a rock and a hard 
> > > place, I guess.  You have to use volatile for its effects but then are 
> > > unhappy about its effects :)
> > 
> > Notably, Linux uses a *ton* of volatile and there has historically been
> > a lot of grumbling about the GCC stance of 'stupid' codegen the moment
> > it sees volatile.
> > 
> > It really would help us (the Linux community) if GCC were to be less
> > offended by the whole volatile thing and would try to generate better
> > code.
> > 
> > Paul has been on the C/C++ committee meetings and keeps telling me them
> > folks hate volatile with a passion up to the point of proposing to
> > remove it from the language or somesuch. But the reality is that Linux
> > very heavily relies on it and _Atomic simply cannot replace it.
> 
> Oh yeah, I agree.  People trying to get rid of volatile are misguided.  
> Of course one can try to capture all the individual aspects of it, and 
> make individual language constructs for them (_Atomic is one).  It makes 
> arguing about and precisely specifying the aspects much easier.  But it 
> also makes the feature-interoperability matrix explode and the language 
> more complicated in areas that were already arcane to start with.

Agreed, and I have personally witnessed some primal-scream therapy
undertaken in response to attempts to better define volatile.

> But it's precisely _because_ of the large-scale feature set of volatile 
> and the compilers wish to cater for the real world, that it's mostly left 
> alone, as is, as written by the author.  Sure, one can wish for better 
> codegen related to volatile.  But it's a slippery slope: "here I have 
> volatile, because I don't want optimizations to happen." - "but here I 
> want a little optimization to happen" - "but not these" - ... It's ... not 
> so easy :)

And to your point, there really have been optimization bugs that have
broken volatile.  So I do very much appreciate your careful attention
to this matter.

> In this specific case I think we have now sufficiently argued that 
> "load-modify-store --> rmw" on x86 even for volatile accesses is a correct 
> transformation (and one that has sufficiently local effects that our heads 
> don't explode while thinking about all consequences).  You'd have to do 
> that for each and every transformation where volatile stuff is involved, 
> just so to not throw out the baby with the water.

Understood!

> > > If you can confirm the above about validity of the optimization, then at 
> > > least there'd by a point for adding a peephole in GCC for this, even if 
> > > current codegen isn't a bug, but I still wouldn't hold my breath.  
> > > volatile is so ... ewww, it's best left alone.
> > 
> > Confirmed, and please, your SMP computer only works becuase of volatile,
> > it *is* important.
> 
> Agreed.

Good to hear!!!

							Thanx, Paul
