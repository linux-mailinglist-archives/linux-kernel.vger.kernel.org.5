Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFFC7F3234
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjKUPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjKUPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:19:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E3BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:19:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F76AC433C8;
        Tue, 21 Nov 2023 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700579953;
        bh=K3sSRhtDf+fwZgA5mkg5Iue5aOfsePsvpgVGRWm9MOw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AJkJFmKTk3kZp2Nhtst+eqRQzgw6PQ+XkIGQaZksdF50rSe4nCfdicUzkfsZ9xj3Y
         r+9VX2YZLiP0kmij9QHNoR4mehJ7RKvrlJaCXBYFDUAirhyV0HjQMlBTIyNZ/gUS24
         AHiMYihwNpSIdaFFObrHcIiWNcqh8fAwY9JTzqzkCVc80gqD5MWH/lkd70S9hmVXBp
         XF3+bipFXYDNPcmzm4TQ7AWvRkRxBTJUVjRRSs7e2N+MS/FJTgmgcH7vlTnMsHPANq
         gUdAEftCyHnzkcnFYu9YxKTGMgHD93uDwxTZgDWhwOwzHc3deg0o3S/gFwLsVUfPFh
         c4xbjk7FEa/Hg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 17035CE04BD; Tue, 21 Nov 2023 07:19:13 -0800 (PST)
Date:   Tue, 21 Nov 2023 07:19:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
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
Message-ID: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-48-ankur.a.arora@oracle.com>
 <20231107192703.1c493431@gandalf.local.home>
 <b8c1ae88-5c12-488c-a7af-42119ebd55d2@paulmck-laptop>
 <20231120224356.7e9e5423@gandalf.local.home>
 <29984609-14e1-4ce4-864b-87932ba3245a@paulmck-laptop>
 <20231121100030.3546b702@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121100030.3546b702@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:
> On Mon, 20 Nov 2023 21:04:28 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > How about like this, where "Y" means allowed and "N" means not allowed:
> > 
> > 			Non-Preemptible RCU	Preemptible RCU
> > 
> > NONE:				Y			Y
> > 
> > VOLUNTARY:			Y			Y
> > 
> > PREEMPT:			N			Y
> > 
> > PREEMPT_RT:			N			Y
> > 
> > 
> > We need preemptible RCU for NONE and VOLUNTARY, as you say,
> > to allow CONFIG_PREEMPT_DYNAMIC to continue to work.  (OK, OK,
> > CONFIG_PREEMPT_DYNAMIC is no longer, but appears to be unconditional.)
> > But again, I don't see why anyone would want (much less need)
> > non-preemptible RCU in the PREEMPT and PREEMPT_RT cases.  And if it is
> > neither wanted nor needed, there is no point in enabling it, much less
> > testing it.
> > 
> > Or am I missing a use case in there somewhere?
> 
> As Ankur replied, this is just an RFC, not the main goal. I'm talking about
> the end product which will get rid of the PREEMPT_NONE, PREEMPT_VOLUNTARY
> and PREEMPT conifgs, and there will *only* be the PREEMPT_DYNAMIC and
> PREEMPT_RT.
> 
> And yes, this is going to be a slow and long processes, to find and fix all
> regressions. I too am concerned about the latency that this may add. I'm
> thinking we could have NEED_RESCHED_LAZY preempt when there is no mutex or
> other semi critical section held (like migrate_disable()).

Indeed.  For one thing, you have a lot of work to do to demonstrate
that this would actually be a good thing.  For example, what is so
horribly bad about selecting minimal preemption (NONE and/or VOLUNTARY)
at build time???

> Right now, the use of cond_resched() is basically a whack-a-mole game where
> we need to whack all the mole loops with the cond_resched() hammer. As
> Thomas said, this is backwards. It makes more sense to just not preempt in
> areas that can cause pain (like holding a mutex or in an RCU critical
> section), but still have the general kernel be fully preemptable.

Which is quite true, but that whack-a-mole game can be ended without
getting rid of build-time selection of the preemption model.  Also,
that whack-a-mole game can be ended without eliminating all calls to
cond_resched().

Additionally, if the end goal is to be fully preemptible as in eventually
eliminating lazy preemption, you have a lot more convincing to do.
For but one example, given the high cost of the additional context
switches that will visit on a number of performance-sensitive workloads.

So what exactly are you guys trying to accomplish here?  ;-)

							Thanx, Paul
