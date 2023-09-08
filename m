Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6077985D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbjIHK0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbjIHK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:26:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DFF1FED;
        Fri,  8 Sep 2023 03:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N3+t8AC87+GXvBm9cdZpJKK3yOTv/78nWpJ6dlIfDa0=; b=Th5ZyKTKqzzqxstqwSNtJKoZr7
        Y7TDoWvYSb+3NZjyYF/Kw2vGPYdd4TqEywZaQ/E1INYgIba7cGVtys7zIYXfSdpb5G2jQWztC3U7Y
        yXA5RxIUA8KzhGg2D+NDBAD3Pj1cOSC1zOoIvYFfP2WNWRWammfPgqZDsYFHQQpSKVwaApeNuaz8Q
        hRD8l2Zt58kp3tfxduXCfDrQkfly5l0tKIy3/ojK4ZhKeTZaiqAI90S+Loz4jjtwuoStgIAOO+tr+
        mXo5ICn1LcnYzJdgKVFjWjYOOmCxqkZkn5vQUofKMCUU/lNELp1dKwwtKa/z8ETCUeOA/MACgCx24
        MglYuTug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeYfm-002RO0-1h;
        Fri, 08 Sep 2023 10:25:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D90F30057E; Fri,  8 Sep 2023 12:25:11 +0200 (CEST)
Date:   Fri, 8 Sep 2023 12:25:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230908102511.GA24372@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:17:25AM +0100, Qais Yousef wrote:

> Just to be clear, my main issue here with the current hardcoded values of the
> 'margins'. And the fact they go too fast is my main problem.

So I stripped the whole margin thing from my reply because I didn't want
to comment on that yet, but yes, I can see how those might be a problem,
and you're changing them into something dynamic, not just removing them.

The tunables is what I worry most about. The moment we expose knobs it
becomes really hard to change things later.

> UTIL_EST_FASTER moves in one direction. And it's a constant response too, no?

The idea of UTIL_EST_FASTER was that we run a PELT sum on the current
activation runtime, all runtime since wakeup and take the max of this
extra sum and the regular thing.

On top of that this extra PELT sum can/has a time multiplier and thus
ramps up faster (this multiplies could be per task). Nb.:

	util_est_fast = faster_est_approx(delta * 2);

is a state-less expression -- by making

	util_est_fast = faster_est_approx(delta * curr->se.faster_mult);

only the current task is affected.

> I didn't get the per-task configurability part. AFAIU we can't turn off these
> sched-features if they end up causing power issues. That what makes me hesitant
> about them. 

See above, the extra sum is (fundamentally) per task, the multiplier
could be per task, if you set the multiplier to <=1, you'll never gain on
the existing sum and the max filter makes that the feature is
effectively disabled for the one task.

It of course gets us the problem of how to set the new multiplier... ;-)

> There's a bias towards perf. But some systems prefer to save power
> at the expense of perf. There's a lot of grey areas in between to what
> perceived as a suitable trade-off for perf vs power. There are cases like above
> where actually you can lower freqs without hit on perf. But most of the time
> it's a trade-off; and some do decide to drop perf in favour of power. Keep in
> mind battery capacity differs between systems with the same SoC even. Some ship
> to enable more perf, others are more constrained and opt to be more efficient.

It always depends on the workload too -- you want different trade-offs
for different tasks.

> > I'm *really* hesitant on adding all these mostly random knobs -- esp.
> > without strong justification -- which you don't present. You mostly seem
> > to justify things with: people do random hack, we should legitimize them
> > hacks.
> 
> I share your sentiment and I am trying to find out what's the right thing to do
> really. I am open to explore other territories. But from what I see there's
> a real need to give users the power to tune how responsive their system needs
> to be. I can't see how we can have one size that fits all here given the
> different capabilities of the systems and the desired outcome (I want more perf
> vs more efficiency).

This is true; but we also cannot keep adding random knobs. Knobs that
are very specific are hard constraints we've got to live with. Take for
instance uclamp, that's not something we can ever get rid of I think
(randomly picking on uclamp, not saying I'm hating on it).

From an actual interface POV, the unit-less generic energy-vs-perf knob
is of course ideal, one global and one per task and then we can fill out
the details as we see fit.  System integrators (you say users, but
really, not a single actual user will use any of this) can muck about
and see what works for them.

(even hardware has these things today, we get 0-255 values that do
'something' uarch specific)

> The problem is that those 0.8 and 1.25 margins forces unsuitable default. The
> case I see the most is it is causing wasting power that tuning it down regains
> this power at no perf cost or small one. Others actually do tune it for faster
> response, but I can't cover this case in detail. All I know is lower end
> systems do struggle as they don't have enough oomph. I also saw comparison on
> phoronix where schedutil is not doing as good still - which tells me it seems
> server systems do prefer to ramp up faster too. I think that PELT thread is
> a variation of the same problem.
> 
> So one of the things I saw is a workload where it spends majority of the time
> in 600-750 util_avg range. Rarely ramps up to max. But the workload under uses
> the medium cores and runs at a lot higher freqs than it really needs on bigs.
> We don't end up utilizing our resources properly.

So that is actually a fairly solid argument for changing things up, if
the margin causes us to neglect mid cores then that needs fixing. But I
don't think that means we need a tunable. After all, the system knows it
has 3 capacities, it just needs to be better at mapping workloads to
them.

It knows how much 'room' there is between a mid and a large. If 1.25*mid
> large we in trouble etc..

> There's a question that I'm struggling with if I may ask. Why is it perceived
> our constant response time (practically ~200ms to go from 0 to max) as a good
> fit for all use cases? Capability of systems differs widely in terms of what
> performance you get at say a util of 512. Or in other words how much work is
> done in a unit of time differs between system, but we still represent that work
> in a constant way. A task ran for 10ms on powerful System A would have done
> a lot more work than running on poor System B for the same 10ms. But util will
> still rise the same for both cases. If someone wants to allow this task to be
> able to do more on those 10ms, it seems natural to be able to control this
> response time. It seems this thinking is flawed for some reason and I'd
> appreciate a help to understand why. I think a lot of us perceive this problem
> this way.

I think part of the problem is that todays servers are tomorrow's
smartphones. Back when we started all this PELT nonsense computers in
general were less powerful than they are now, yet todays servers are no
less busy than they were back then.

Give us compute, we'll fill it.

Now, smartphones in particular are media devices, but a large part of
the server farms are indirectly interactive too, you don't want your
search query to take too long, or your bookface page stuck loading, or
you twatter message about your latest poop not being insta read by your
mates.

That is, much of what we do with the computers, ever more powerful or
not, is eventually measured in human time perception.

So yeah, 200ms.

Remember, all this PELT nonsense was created for cgroups, to distribute
shared between CPUs as load demanded. I think for that purpose it still
sorta makes sense.

Ofc we've added a few more users over time, because if you have this
data, might as well use it etc. I'm not sure we really sat down and
analyzed if the timing all made sense.

And as I argued elsewhere, PELT is a running average, but DVFS might be
better suited with a max filter.

> Happy to go and try to dig more info if this is still not clear enough.

So I'm not generally opposed to changing things -- but I much prefer to
have an actual problem driving that change :-)
