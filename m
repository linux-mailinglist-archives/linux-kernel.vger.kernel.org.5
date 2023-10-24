Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0D7D5B00
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbjJXS7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjJXS7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:59:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C49A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:59:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F82C433C7;
        Tue, 24 Oct 2023 18:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698173973;
        bh=u5EeMKr3/pha+PNMYLOK1O+oeVWMMovczszv8DjeabU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lrOn28fGOR0s8kW7p1Vu2z2bQbmiUwNdPW/HfxGOiN28GwgeFzRwqT8duEDGRWPtE
         aPhokm7AC4Th7pOd66Wr9ryvofd0bG93CBlHBSG8fWiNXCDN9V3eiXfiWhSLvkkVZD
         bgzfNnZggZzIhAfaCfl3pUDaCJvW0I9PONw5JlR+mNuPeB8wqY/kZqzzaswh7jkHD1
         yLqKdZvSE342LwkrThREOLsu9BcjudlVqJWFhE8vp7Au//iFT00mrcPYzFwIxTRPpL
         WsGdP3VGKzJw9GqyE1P7D6VXpM/eVOZPmdB5Zvj20dQEFXYOR9xdLPmaD5v4E1lXKd
         HORHaMOVwgf+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B183FCE11D0; Tue, 24 Oct 2023 11:59:32 -0700 (PDT)
Date:   Tue, 24 Oct 2023 11:59:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <73ecce1c-d321-4579-b892-13b1e0a0620a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4c7d06b9-8f5b-43ff-a2d6-86f54116da52@paulmck-laptop>
 <87cyx4cj36.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyx4cj36.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 02:15:25PM +0200, Thomas Gleixner wrote:
> Paul!
> 
> On Thu, Oct 19 2023 at 12:13, Paul E. McKenney wrote:
> > On Thu, Oct 19, 2023 at 02:21:35AM +0200, Thomas Gleixner wrote:
> >> The important point is that at the very end the scheduler has the
> >> ultimate power to say: "Not longer Mr. Nice Guy" without the risk of any
> >> random damage due to the fact that preemption count is functional, which
> >> makes your life easier as well as you admitted already. But that does
> >> not mean you can eat the cake and still have it. :)
> >
> > Which is exactly why I need rcu_read_lock() to map to preempt_disable()
> > and rcu_read_unlock() to preempt_enable().  ;-)
> 
> After reading back in the thread, I think we greatly talked past each
> other mostly due to the different expectations and the resulting
> dependencies which seem to be hardwired into our brains.
> 
> I'm pleading guilty as charged as I failed completely to read your
> initial statement
> 
>  "The key thing to note is that from RCU's viewpoint, with this change,
>   all kernels are preemptible, though rcu_read_lock() readers remain
>   non-preemptible."
> 
> with that in mind and instead of dissecting it properly I committed the
> fallacy of stating exactly the opposite, which obviously reflects only
> the point of view I'm coming from.
> 
> With a fresh view, this turns out to be a complete non-problem because
> there is no semantical dependency between the preemption model and the
> RCU flavour.

Agreed, and been there and done that myself, as you well know!  ;-)

> The unified kernel preemption model has the following properties:
> 
>   1) It provides full preemptive multitasking.
> 
>   2) Preemptability is limited by implicit and explicit mechanisms.
> 
>   3) The ability to avoid overeager preemption for SCHED_OTHER tasks via
>      the PREEMPT_LAZY mechanism.
> 
>      This emulates the NONE/VOLUNTARY preemption models which
>      semantically provide collaborative multitasking.
> 
>      This emulation is not breaking the semantical properties of full
>      preemptive multitasking because the scheduler still has the ability
>      to enforce immediate preemption under consideration of #2.
> 
>      Which in turn is a prerequiste for removing the semantically
>      ill-defined cond/might_resched() constructs.
> 
> The compile time selectable RCU flavour (preemptible/non-preemptible) is
> not imposing a semantical change on this unified preemption model.
> 
> The selection of the RCU flavour is solely affecting the preemptability
> (#2 above). Selecting non-preemptible RCU reduces preemptability by
> adding an implicit restriction via mapping rcu_read_lock()
> to preempt_disable().
> 
> IOW, the current upstream enforcement of RCU_PREEMPT=n when PREEMPTION=n
> is only enforced by the the lack of the full preempt counter in
> PREEMPTION=n configs. Once the preemption counter is always enabled this
> hardwired dependency goes away.
> 
> Even PREEMPT_DYNAMIC should just work with RCU_PREEMPT=n today because
> with PREEMPT_DYNAMIC the preemption counter is unconditionally
> available.
> 
> So that makes these hardwired dependencies go away in practice and
> hopefully soon from our mental models too :)

The real reason for tying RCU_PREEMPT to PREEMPTION back in the day was
that there were no real-world uses of RCU_PREEMPT not matching PREEMPTION,
so those combinations were ruled out in order to reduce the number of
rcutorture scenarios.

But now it appears that we do have a use case for PREEMPTION=y and
RCU_PREEMPT=n, plus I have access to way more test hardware, so that
the additional rcutorture scenarios are less of a testing burden.

> RT will keep its hard dependency on RCU_PREEMPT in the same way it
> depends hard on forced interrupt threading and other minor details to
> enable the spinlock substitution.

"other minor details".  ;-)

Making PREEMPT_RT select RCU_PREEMPT makes sense to me!

> >> That said, I completely understand your worries about the consequences,
> >> but please take the step back and look at it from a conceptual point of
> >> view.
> >
> > Conceptual point of view?  That sounds suspiciously academic.
> 
> Hehehe.
> 
> > Who are you and what did you do with the real Thomas Gleixner?  ;-)
> 
> The point I'm trying to make is not really academic, it comes from a
> very practical point of view. As you know for almost two decades I'm
> mostly busy with janitoring and mopping up the kernel.
> 
> A major takeaway from this eclectic experience is that there is a
> tendency to implement very specialized solutions for different classes
> of use cases.
> 
> The reasons to do so in the first place:
> 
>  1) Avoid breaking the existing and established solutions:
> 
>     E.g. the initial separation of x8664 and i386
> 
>  2) Enforcement due to dependencies on mechanisms, which are
>     considered "harmful" for particular use cases
> 
>     E.g. Preemptible RCU, which is separate also due to #1
> 
>  3) Because we can and something is sooo special
> 
>     You probably remember the full day we both spent in a room with SoC
>     people to make them understand that their SoCs are not so special at
>     all. :)

   4) Because we don't see a use for a given combination, and we
      want to keep test time down to a dull roar, as noted above.

> So there are perfectly valid reasons (#1, #2) to separate things, but we
> really need to go back from time to time and think hard about the
> question whether a particular separation is still justified. This is
> especially true when dependencies or prerequisites change.
> 
> But in many cases we just keep going, take the separation as set in
> stone forever and add features and workarounds on all ends without
> rethinking whether we could unify these things for the better. The real
> bad thing about this is that the more we add to the separation the
> harder consolidation or unification becomes.
> 
> Granted that my initial take of consolidating on preemptible RCU might
> be too brisk or too naive, but I still think that with the prospect of
> an unified preemption model it's at least worth to have a very close
> look at this question.
> 
> Not asking such questions or dismissing them upfront is a real danger
> for the long term sustainability and maintainability of the kernel in my
> opinion. Especially when the few people who actively "janitor" these
> things are massively outnumbered by people who indulge in
> specialization. :)

Longer term, I do agree in principle with the notion of simplifying the
Linux-kernel RCU implementation by eliminating the PREEMPT_RCU=n code.
In the near term practice, here are the reasons for holding off on
this consolidation:

1.	Preemptible RCU needs more work for datacenter deployments,
	as mentioned earlier.  I also reiterate that if you only have
	a few thousand (or maybe even a few tens of thousand) servers,
	preemptible RCU will be just fine for you.  Give or take the
	safety criticality of your application.

2.	RCU priority boosting has not yet been really tested and tuned
	for systems that are adequately but not generously endowed with
	memory.  Boost too soon and you needlessly burning cycles and
	preempt important tasks.  Boost too late and it is OOM for you!

3.	To the best of my knowledge, the scheduler doesn't take memory
	footprint into account.  In particular, if a long-running RCU
	reader is preempted in a memory-naive fashion, all we gain
	is turning a potentially unimportant latency outlier into a
	definitely important OOM.

4.	There are probably a few gotchas that I haven't thought of or
	that I am forgetting.  More likely, more than a few.  As always!

But to your point, yes, these are things that we should be able to do
something about, given appropriate time and effort.  My guess is five
years, with the long pole being the reliability.  Preemptible RCU has
been gone through line by line recently, which is an extremely good
thing and an extremely welcome change from past practice, but that is
just a start.  That effort was getting people familiar with the code,
and should not be mistaken for a find-lots-of-bugs review session,
let alone a find-all-bugs review session.

> That said, the real Thomas Gleixner and his grumpy self are still there,
> just slightly tired of handling the slurry brush all day long :)

Whew!!!  Good to hear that the real Thomas Gleixner is still with us!!! ;-)

							Thanx, Paul
