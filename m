Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB37F3254
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjKUP0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjKUP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:26:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487B3122
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:26:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9ABC433C7;
        Tue, 21 Nov 2023 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700580406;
        bh=6ASntq+NzGJvktLNPEkxn4FWCB31PpZ1eITUabEWgKw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jMWVh0eFzUUtt7SAyphyKaz8HhM9f+Nkl6I+seXNjiwzoRat6R6hIYirSDEO/6sd3
         nvNv6tUy0KjZRU7cP7ws2TZYRtMdrCVV1Mjle7LiN6fQolVBRYzzAHXQtNARBPWJ1K
         qdKIapd/gf5/yoG4UnK8SRqG2ftnidrY+Z3if7QxznX11tgoks/oX0fJ/nDGGvxHVB
         4GHqJtP1AEQb1ssvp2TGQ4IgmsI3EtXheTrUJiJTvvmIcoHdMHZvW244G78TqUcUZj
         VDD24RpKGqpQrfAn5sKOFh5hK321BioJSfdGWHLD1SnGT5k6roxLFCi2A0FkNphOAw
         COv/RqmCcCUng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5C1E7CE04BD; Tue, 21 Nov 2023 07:26:46 -0800 (PST)
Date:   Tue, 21 Nov 2023 07:26:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [RFC PATCH 57/86] coccinelle: script to remove cond_resched()
Message-ID: <4f028628-3ea2-4f27-add5-27a0a64ed16c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <7d85fbde-fc8d-44b4-802e-376a475891e6@paulmck-laptop>
 <878r6r3cv0.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r6r3cv0.fsf@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:16:19PM -0800, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Tue, Nov 07, 2023 at 03:07:53PM -0800, Ankur Arora wrote:
> >> Rudimentary script to remove the straight-forward subset of
> >> cond_resched() and allies:
> >>
> >> 1)  if (need_resched())
> >> 	  cond_resched()
> >>
> >> 2)  expression*;
> >>     cond_resched();  /* or in the reverse order */
> >>
> >> 3)  if (expression)
> >> 	statement
> >>     cond_resched();  /* or in the reverse order */
> >>
> >> The last two patterns depend on the control flow level to ensure
> >> that the complex cond_resched() patterns (ex. conditioned ones)
> >> are left alone and we only pick up ones which are only minimally
> >> related the neighbouring code.
> >
> > This series looks to get rid of stall warnings for long in-kernel
> > preempt-enabled code paths, which is of course a very good thing.
> > But removing all of the cond_resched() calls can actually increase
> > scheduling latency compared to the current CONFIG_PREEMPT_NONE=y state,
> > correct?
> 
> Not necessarily.
> 
> If TIF_NEED_RESCHED_LAZY is set, then we let the current task finish
> before preempting. If that task runs for arbitrarily long (what Thomas
> calls the hog problem) -- currently we allow them to run for upto one
> extra tick (which might shorten/become a tunable.)

Agreed, and that is the easy case.  But getting rid of the cond_resched()
calls really can increase scheduling latency of this patchset compared
to status-quo mainline.

> If TIF_NEED_RESCHED is set, then it gets folded the same it does now
> and preemption happens at the next safe preemption point.
> 
> So, I guess the scheduling latency would always be bounded but how much
> latency a task would incur would be scheduler policy dependent.
> 
> This is early days, so the policy (or really the rest of it) isn't set
> in stone but having two levels of preemption -- immediate and
> deferred -- does seem to give the scheduler greater freedom of policy.

"Give the scheduler freedom!" is a wonderful slogan, but not necessarily
a useful one-size-fits-all design principle.  The scheduler does not
and cannot know everything, after all.

> Btw, are you concerned about the scheduling latencies in general or the
> scheduling latency of a particular set of tasks?

There are a lot of workloads out there with a lot of objective functions
and constraints, but it is safe to say that both will be important, as
will other things, depending on the workload.

But you knew that already, right?  ;-)

> > If so, it would be good to take a measured approach.  For example, it
> > is clear that a loop that does a cond_resched() every (say) ten jiffies
> > can remove that cond_resched() without penalty, at least in kernels built
> > with either CONFIG_NO_HZ_FULL=n or CONFIG_PREEMPT=y.  But this is not so
> > clear for a loop that does a cond_resched() every (say) ten microseconds.
> 
> True. Though both of those loops sound bad :).

Yes, but do they sound bad enough to be useful in the real world?  ;-)

> Yeah, and as we were discussing offlist, the question is the comparative
> density of preempt_dec_and_test() is true vs calls to cond_resched().
> 
> And if they are similar then we could replace cond_resched() quiescence
> reporting with ones in preempt_enable() (as you mention elsewhere in the
> thread.)

Here is hoping that something like that can help.

I am quite happy with the thought of reducing the number of cond_resched()
invocations, but not at the expense of the Linux kernel failing to do
its job.

							Thanx, Paul
