Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9007E3686
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjKGIQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjKGIQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:16:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CC8DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qInQP3okHG5W4uFJcSe4n5S3W2Ar2OKl9hckzkM1FQw=; b=BV21XkCtxsTYioh+ti4R0wlQhG
        7m54NdviFl3WhA9zK+z1lh3Q2FoPKLnnWzVi6b2lCbW5V1xE5WWzqcC1/KhhPi/wH7sp1P/Xu7XvD
        G+QNg3yXN00P+qR6rDUOv96VkdSzovLwjSbCE2fEBlRoyzYPE1y+WA+Hg7Do2jtIIvQSI2acmyRHp
        JR2RONxrGKvN+DXW67RudNE98haXCO/s/FYwEy5MxE2IoLi5cmMDTRoAUuKxFkNd9EUgAgLw+IegT
        8zixzVz02pzdE7opXeWtGC1BuLwodFZ8S2G2qDSJYbeafTXtJsCbxpPCEl+bOvCReVQrzlT0NZg7Q
        O5VU5OwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0HFi-00B99D-Bp; Tue, 07 Nov 2023 08:16:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B137F30049D; Tue,  7 Nov 2023 09:16:02 +0100 (CET)
Date:   Tue, 7 Nov 2023 09:16:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Message-ID: <20231107081602.GP8262@noisy.programming.kicks-ass.net>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <20231106154042.GH3818@noisy.programming.kicks-ass.net>
 <9a7222ed-88f8-4a3f-9d83-09b7fb977c27@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a7222ed-88f8-4a3f-9d83-09b7fb977c27@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 05:29:49PM +0100, Daniel Bristot de Oliveira wrote:
> On 11/6/23 16:40, Peter Zijlstra wrote:
> > On Sat, Nov 04, 2023 at 11:59:24AM +0100, Daniel Bristot de Oliveira wrote:
> >> Add an interface for fair server setup on debugfs.
> >>
> >> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
> >>
> >>  - fair_server_runtime: set runtime in ns
> >>  - fair_server_period: set period in ns
> >>  - fair_server_defer: on/off for the defer mechanism
> >>
> > 
> > This then leaves /proc/sys/kernel/sched_rt_{period,runtime}_us to be the
> > total available bandwidth control, right?
> 
> right, but thinking aloud... given that the per-cpu files are already allocating the
> bandwidth on the dl_rq, the spare time for fair scheduler is granted.
> 
> Still, we can have them there as a safeguard to not overloading the deadline
> scheduler... (thinking aloud 2) as long as global is a thing... as we get away
> from it, that global limitation will make less sense - still better to have a form
> of limitation so people are aware of bandwidth until there.

Yeah, so having a limit on the deadline thing seems prudent as a way to
model system overhead. I mean 100% sounds nice, but then all the models
also assume no interrupts, no scheduler or migration overhead etc.. So
setting a slightly lower max seems far more realistic to me.

That said, the period/bandwidth thing is now slightly odd, as we really
only care about the utilization. But whatever. One thing at a time.

> > But then shouldn've we also rip out the throttle thingy right quick?
> > 
> 
> I was thinking about moving the entire throttling machinery inside CONFIG_RT_GROUP_SCHED
> for now, because GROUP_SCHED depends on it, no?

Yes. Until we can delete all that code we'll have to keep some of that.

> With the next step on moving the dl server as the base for the
> hierarchical scheduling...  That will rip out the
> CONFIG_RT_GROUP_SCHED... with a thing with a per-cpu interface.
> 
> Does it make sense?

I'm still not sure how to deal with affinities and deadline servers for
RT.

There's a bunch of issues and I thing we've only got some of them solved.

The semi-partitioned thing (someone was working on that, I think you
know the guy), solves DL 'entities' having affinities.

But the problem of FIFO is that they don't have inherent bandwidth. This
in turn means that any server for FIFO needs to be minimally concurrent,
otherwise you hand out bandwidth to lower priority tasks that the higher
priority task might want etc.. (Andersson's group has papers here).

Specifically, imagine a server with U=1.5 and 3 tasks, a high prio task
that requires .8 a medium prio task that requires .6 and a low prio task
that soaks up whatever it can get its little grubby paws on.

Then with minimal concurreny this works out nicely, high gets .8, mid
gets .6 and low gets the remaining .1.

If OTOH you don't limit concurrency and let them all run concurrently,
you can end up with the situation where they each get .5. Which is
obviously fail.

Add affinities here though and you're up a creek, how do you distribute
utilization between the slices, what slices, etc.. You say given them a
per-cpu cgroup interface, and have them configure it themselves, but
that's a god-aweful thing to ask userspace to do.

Ideally, I'd delete all of FIFO, it's such a horrid trainwreck, a total
and abysmal failure of a model -- thank you POSIX :-(
