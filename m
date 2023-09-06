Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD3793D7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbjIFNOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjIFNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:14:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E0DCE2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dlfLGTra2/Vr9tNq9nX/R6Uf8c35js0cF92plr4gIlQ=; b=BQJJFfM1Dw8zD04634kUN9/ZEh
        /B4QCQ/MWy5vomTAWazPUZ9R+g/qwyReIqmXNj4BICwlW+CVcpqkh1fLs8bfqGZqLE6WBRkfYc9JP
        90luWDYgNXGl1jxpVSfdvHZG1IG0MCQWDu9oxzNcSPQ4twzCQ4/cDJy7sP5KQmn12hSaqnOciOTwF
        TCuSZM1gb4pruIYSoFv5AWdxitENzWDGteziV6FSjaRBlvaKjsDSC4a4ECaxdjYwSiwwc3RiXzZMe
        KIkFyxSssB09qkXD4I7iUvm6RRz9Hr4RdWn3rEPRtO8Z69QrF3qnAcML5YBiWk14LbohpjXRGnX1b
        bX02AYcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdsM1-002bh2-F9; Wed, 06 Sep 2023 13:13:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AFF8300422; Wed,  6 Sep 2023 15:13:57 +0200 (CEST)
Date:   Wed, 6 Sep 2023 15:13:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
Message-ID: <20230906131356.GG38741@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 08:52:26PM -0400, Daniel Jordan wrote:

> We're investigating the other benchmarks, but here's what I've found so far
> with SPEC CPU.  Some schedstats showed that eevdf is tick-preemption happy
> (patches below).  These stats were taken over 1 minute near the middle of a ~26
> minute benchmark (502.gcc_r).
> 
>     Base: v6.5-rc4-based kernel
>     EEVDF: Base + the latest EEVDF patches from tip/sched/core
> 
>     schedstat                     Base            EEVDF
> 
>     sched                    1,243,911        3,947,251
> 
>     tick_check_preempts     12,899,049
>     tick_preempts            1,022,998
> 
>     check_deadline                           15,878,463
>     update_deadline                           3,895,530
>     preempt_deadline                          3,751,580
> 
> In both kernels, tick preemption is primarily what drives schedule()s.
> Preemptions happen over three times more often for EEVDF because in the base,
> tick preemption happens after a task has run through its ideal timeslice as a
> fraction of sched_latency (so two tasks sharing a CPU each get 12ms on a server
> with enough CPUs, sched_latency being 24ms), whereas with eevdf, a task's base
> slice determines when it gets tick-preempted, and that's 3ms by default.  It
> seems SPEC CPU isn't liking the increased scheduling of EEVDF in a cpu-bound
> load like this.  When I set the base_slice_ns sysctl to 12000000, the
> regression disappears.
> 
> I'm still thinking about how to fix it. 

EEVDF fundamentally supports per task request/slice sizes, which is the
primary motivator for finally finishing these patches.

So the plan is to extend sched_setattr() to allow tasks setting their
own ideal slice length. But we're not quite there yet.

Having just returned from PTO the mailbox is an utter trainwreck, but
I'll try and refresh those few patches this week for consideration.

In the meantime I think you found the right knob to twiddle.
