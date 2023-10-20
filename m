Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529C67D1880
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjJTV7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJTV7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:59:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF06D5B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:59:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201EEC433C8;
        Fri, 20 Oct 2023 21:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697839184;
        bh=LJ9TGwTP0Yf1kpT07kYu5R4YBY2Xfhzc1X/zqzKAkZA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r7bFA6U9EURnDdC2UmMIP54MzcJo73i0b5f+xB0iUgRcDANtnfYsFcOol3WG8GCSg
         PTDBobB62rzUouX6Ts31fQz3YmtXXSZpT99f4+FEWdHp5VvAOgWlMZ6aORn4JgpOr6
         q+oAcc57o3ZGUvONBxXE4d7sxnjKh88dXTFoFpU+cOUp+1uw/m0NSvoZbDSOEnXEL+
         pJsDf70xYoulinLCsM/hkPPYN9KMo2xWFfyZyhGzsLxMEyPleCozx5/ONBffv6i5TN
         dh1hsW899jHFeymYUbM1lNGK4TvBYDTyY37nIW/1sLdsxHENRYwmdoFvZYbMgN2vxu
         3JzKmd1oC/aZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A79A1CE0D14; Fri, 20 Oct 2023 14:59:43 -0700 (PDT)
Date:   Fri, 20 Oct 2023 14:59:43 -0700
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
Message-ID: <d2365b4a-b2d7-4b60-8149-73d290bb41a0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttrngmq0.ffs@tglx>
 <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
 <8734y74g34.ffs@tglx>
 <4c7d06b9-8f5b-43ff-a2d6-86f54116da52@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7d06b9-8f5b-43ff-a2d6-86f54116da52@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:13:31PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 19, 2023 at 02:21:35AM +0200, Thomas Gleixner wrote:
> > On Wed, Oct 18 2023 at 10:19, Paul E. McKenney wrote:
> > > On Wed, Oct 18, 2023 at 03:16:12PM +0200, Thomas Gleixner wrote:
> > >> On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:

[ . . . ]

> > >> In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
> > >> remaining would be CONFIG_PREEMPT_RT, which should be renamed to
> > >> CONFIG_RT or such as it does not really change the preemption
> > >> model itself. RT just reduces the preemption disabled sections with the
> > >> lock conversions, forced interrupt threading and some more.
> > >
> > > Again, please, no.
> > >
> > > There are situations where we still need rcu_read_lock() and
> > > rcu_read_unlock() to be preempt_disable() and preempt_enable(),
> > > repectively.  Those can be cases selected only by Kconfig option, not
> > > available in kernels compiled with CONFIG_PREEMPT_DYNAMIC=y.
> > 
> > Why are you so fixated on making everything hardcoded instead of making
> > it a proper policy decision problem. See above.
> 
> Because I am one of the people who will bear the consequences.
> 
> In that same vein, why are you so opposed to continuing to provide
> the ability to build a kernel with CONFIG_PREEMPT_RCU=n?  This code
> is already in place, is extremely well tested, and you need to handle
> preempt_disable()/preeempt_enable() regions of code in any case.  What is
> the real problem here?

I should hasten to add that from a conceptual viewpoint, I do support
the eventual elimination of CONFIG_PREEMPT_RCU=n code, but with emphasis
on the word "eventual".  Although preemptible RCU is plenty reliable if
you are running only a few thousand servers (and maybe even a few tens
of thousands), it has some improving to do before I will be comfortable
recommending its use in a large-scale datacenters.

And yes, I know about Android deployments.  But those devices tend
to spend very little time in the kernel, in fact, many of them tend to
spend very little time powered up.  Plus they tend to have relatively few
CPUs, at least by 2020s standards.  So it takes a rather large number of
Android devices to impose the same stress on the kernel that is imposed
by a single mid-sized server.

And we are working on making preemptible RCU more reliable.  One nice
change over the past 5-10 years is that more people are getting serious
about digging into the RCU code, testing it, and reporting and fixing the
resulting bugs.  I am also continuing to make rcutorture more vicious,
and of course I am greatly helped by the easier availability of hardware
with which to test RCU.

If this level of activity continues for another five years, then maybe
preemptible RCU will be ready for large datacenter deployments.

But I am guessing that you had something in mind in addition to code
consolidation.

							Thanx, Paul
