Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411077DD103
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjJaPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbjJaPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:55:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CF4DA;
        Tue, 31 Oct 2023 08:55:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5D93E1F74D;
        Tue, 31 Oct 2023 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698767722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGDnUmq+DoNfYWfUHq3dmosfieRm74PPa/1eL0fCpDU=;
        b=UHtwX61pI7PonsdkBZwtiC+/18y3vUFI+sSv2ogbkVQcYvY9qikprRT8OSNuZgKdTn80g3
        iKMtMU8tzSxUE6d51l7ZRaNtyvbiBTnOowUWbsF7HVjvJc8ee+Y10zN8bZyhhnSvp1lPdO
        bcSMz/5y726xEJbvLLdDtl3gg3j8VbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698767722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGDnUmq+DoNfYWfUHq3dmosfieRm74PPa/1eL0fCpDU=;
        b=WinZk0QEnluiWfhEUGTEQiQgq58+wuZhRAAt1BxVah5Wq1OzhB9SZOCmRysMm65ltLiYI3
        yEpFxMkh28CHstBg==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8E3C02C23B;
        Tue, 31 Oct 2023 15:55:20 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id C366F64A1; Tue, 31 Oct 2023 15:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id BFE2963F8;
        Tue, 31 Oct 2023 15:55:20 +0000 (UTC)
Date:   Tue, 31 Oct 2023 15:55:20 +0000 (UTC)
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
In-Reply-To: <20231031151645.GB15024@noisy.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.20.2310311523290.15233@wotan.suse.de>
References: <20231027144050.110601-1-frederic@kernel.org> <20231027144050.110601-3-frederic@kernel.org> <20231027192026.GG26550@noisy.programming.kicks-ass.net> <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop> <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop> <20231030082138.GJ26550@noisy.programming.kicks-ass.net> <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop> <20231031095202.GC35651@noisy.programming.kicks-ass.net> <alpine.LSU.2.20.2310311357450.15233@wotan.suse.de>
 <20231031151645.GB15024@noisy.programming.kicks-ass.net>
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

Hello,

On Tue, 31 Oct 2023, Peter Zijlstra wrote:

> > > For absolutely no reason :-(
> > 
> > The reason is simple (and should be obvious): to adhere to the abstract 
> > machine regarding volatile.  When x is volatile then x++ consists of a 
> > read and a write, in this order.  The easiest way to ensure this is to 
> > actually generate a read and a write instruction.  Anything else is an 
> > optimization, and for each such optimization you need to actively find an 
> > argument why this optimization is correct to start with (and then if it's 
> > an optimization at all).  In this case the argument needs to somehow 
> > involve arguing that an rmw instruction on x86 is in fact completely 
> > equivalent to the separate instructions, from read cycle to write cycle 
> > over all pipeline stages, on all implementations of x86.  I.e. that a rmw 
> > instruction is spec'ed to be equivalent.
> > 
> > You most probably can make that argument in this specific case, I'll give 
> > you that.  But why bother to start with, in a piece of software that is 
> > already fairly complex (the compiler)?  It's much easier to just not do 
> > much anything with volatile accesses at all and be guaranteed correct.
> > Even more so as the software author, when using volatile, most likely is 
> > much more interested in correct code (even from a abstract machine 
> > perspective) than micro optimizations.
> 
> There's a pile of situations where a RmW instruction is actively
> different vs a load-store split, esp for volatile variables that are
> explicitly expected to change asynchronously.
> 
> The original RmW instruction is IRQ-safe, while the load-store version
> is not. If an interrupt lands in between the load and store and also
> modifies the variable then the store after interrupt-return will
> over-write said modification.
> 
> These are not equivalent.

Okay, then there you have it.  Namely that LLVM has a bug (but see next 
paragraph).  For volatile x, x++ _must_ expand to a separate read and 
write, because the abstract machine of C says so.  If a RmW isn't 
equivalent to that, then it can't be used in this situation.  If you 
_have_ to use a RmW for other reasons like interrupt safety, then a 
volatile variable is not the way to force this, as C simply doesn't have 
that concept and hence can't talk about it.  (Of course it can't, as not 
all architectures could implement such, if it were required).

(If an RmW merely gives you more guarantees than a split load-store then 
of course LLVM doesn't have a bug, but you said not-equivalent, so I'm 
assuming the worst, that RmW also has fewer (other) guarantees)

> > > At least clang doesn't do this, it stays:
> > > 
> > > 0403  413:      49 ff 45 00             incq   0x0(%r13)
> > > 
> > > irrespective of the volatile.
> > 
> > And, are you 100% sure that this is correct?  Even for x86 CPU 
> > pipeline implementations that you aren't intimately knowing about? ;-)
> 
> It so happens that the x86 architecture does guarantee RmW ops are
> IRQ-safe or locally atomic. SMP/concurrent loads will observe either
> pre or post but no intermediate state as well.

So, are RMW ops a strict superset (vis the guarantees they give) of split 
load-store?  If so we can at least say that using RMW is a valid 
optimization :)  Still, an optmization only.

> > But all that seems to be a side-track anyway, what's your real worry with  
> > the code sequence generated by GCC?
> 
> In this case it's sub-optimal code, both larger and possibly slower for
> having two memops.
> 
> The reason to have volatile is because that's what Linux uses to
> dis-allow store-tearing, something that doesn't happen in this case. A
> suitably insane but conforming compiler could compile a non-volatile
> memory increment into something insane like:
> 
> 	load byte-0, r1
> 	increment r1
> 	store r1, byte-0
> 	jno done
> 	load byte-1, r1
> 	increment ri
> 	store r1, byte 1
> 	jno done
> 	...
> done:
> 
> We want to explicitly dis-allow this.

Yeah, I see.  Within C you don't have much choice than volatile for this 
:-/  Funny thing: on some architectures this is actually what is generated 
sometimes, even if it has multi-byte loads/stores.  This came up 
recently on the gcc list and the byte-per-byte sequence was faster ;-) 
(it was rather: load-by-bytes, form whole value via shifts, increment, 
store-by-bytes)
Insane codegen for insane micro-architectures!

> I know C has recently (2011) grown this _Atomic thing, but that has 
> other problems.

Yeah.

So, hmm, I don't quite know what to say, you're between a rock and a hard 
place, I guess.  You have to use volatile for its effects but then are 
unhappy about its effects :)

If you can confirm the above about validity of the optimization, then at 
least there'd by a point for adding a peephole in GCC for this, even if 
current codegen isn't a bug, but I still wouldn't hold my breath.  
volatile is so ... ewww, it's best left alone.


Ciao,
Michael.
