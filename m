Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FDD7C79DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443079AbjJLWfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443052AbjJLWfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:35:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE1D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b253Sj7wmuIogC42d3JJmtTfARbHB8IHESHD45gbU34=; b=EkygVsOH9hrpVo0xM/OUd0hcvC
        KUzmW0K+RuzaXUL/CatKX58b5V7vaZ+FvsOppmVhqAeANVAhM1n0SBINotWoS5q1PIsfG75asmC14
        0mo53qXGHGHapwOVj2oozA4WOCmE/gHvxGXBJuDmzFyYri6o7+sgdF52UlQVAl41BeJr273qJskuH
        vrC1KZi/cfxtexC8WJbhj8RJw83gISWtJQM5+TkPmD65s04ZFBG9Q83C2sj481y+/7H5U8Rz42VXZ
        gDuQEGAbMD+2bBYNwjEfIjPxV7/Nf5bScaAe/N5U9bTuiymB350GBv/vYXzAt2fjLNJ1KrYxjoJZW
        6L3uMw+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qr4GC-001sP8-RB; Thu, 12 Oct 2023 22:34:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E00830036C; Fri, 13 Oct 2023 00:34:28 +0200 (CEST)
Date:   Fri, 13 Oct 2023 00:34:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Segall <bsegall@google.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 03/15] sched/fair: Add lag based placement
Message-ID: <20231012223428.GP6307@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.794929315@infradead.org>
 <xm26fs2fhcu7.fsf@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26fs2fhcu7.fsf@bsegall-linux.svl.corp.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:15:12PM -0700, Benjamin Segall wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > @@ -4853,49 +4872,119 @@ static void
> >  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> >  {
> >  	u64 vruntime = avg_vruntime(cfs_rq);
> > +	s64 lag = 0;
> >  
> > -	/* sleeps up to a single latency don't count. */
> > -	if (!initial) {
> > -		unsigned long thresh;
> > +	/*
> > +	 * Due to how V is constructed as the weighted average of entities,
> > +	 * adding tasks with positive lag, or removing tasks with negative lag
> > +	 * will move 'time' backwards, this can screw around with the lag of
> > +	 * other tasks.
> > +	 *
> > +	 * EEVDF: placement strategy #1 / #2
> > +	 */
> 
> So the big problem with EEVDF #1 compared to #2/#3 and CFS (hacky though
> it is) is that it creates a significant perverse incentive to yield or
> spin until you see yourself be preempted, rather than just sleep (if you
> have any competition on the cpu). If you go to sleep immediately after
> doing work and happen to do so near the end of a slice (arguably what
> you _want_ to have happen overall), then you have to pay that negative
> lag in wakeup latency later, because it is maintained through any amount
> of sleep. (#1 or similar is good for reweight/migrate of course)
> 
> #2 in theory could be abused by micro-sleeping right before you are
> preempted, but that isn't something tasks can really predict, unlike
> seeing more "don't go to sleep, just spin, the latency numbers are so
> much better" nonsense.

Right, so I do have this:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=344944e06f11da25b49328825ed15fedd63036d3

That allows tasks to sleep away the lag -- with all the gnarly bits that
sleep time has. And it reliably fixes the above. However, it also
depresses a bunch of other stuff. Never a free lunch etc.

It is so far the least horrible of the things I've tried. 
