Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641BB75992D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGSPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjGSPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:08:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84AD62128;
        Wed, 19 Jul 2023 08:07:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891802F4;
        Wed, 19 Jul 2023 08:08:07 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.76.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B7843F6C4;
        Wed, 19 Jul 2023 08:07:21 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:07:16 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <ZLf8JHjrdgmlWQAz@e126311.manchester.arm.com>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:24:32PM +0100, Qais Yousef wrote:
> On 07/18/23 13:02, Kajetan Puchalski wrote:
> > Hi Qais,
> > 
> > On Tue, Jul 11, 2023 at 06:58:14PM +0100, Qais Yousef wrote:
> > > Hi Kajetan
> > > 
> > > On 01/05/23 14:51, Kajetan Puchalski wrote:
> > > 
> > > [...]
> > > 
> > > > @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
> > > >  			     struct cpuidle_device *dev)
> > > >  {
> > > >  	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> > > > +	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
> > > >  	int i;
> > > >  
> > > >  	memset(cpu_data, 0, sizeof(*cpu_data));
> > > > +	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> > > 
> > > Given that utilization is invariant, why do we set the threshold based on
> > > cpu capacity?
> > 
> > Conceptually, the threshold is meant to represent a level at which the
> > core is considered 'utilized'. I appreciate the definitions here can get
> > a little fuzzy but I think of it as "generally doing a non-insignificant
> > amount of work" even if there are currently no tasks scheduled on the core.
> > This comes in handy in real-world workloads where the core will go
> > through multiple cycles of busy-idle-busy-idle within each second.
> > The intention here is to be able to distinguish a scenario of "going
> > into idle for a few us because of the nature of the workload" from
> > "going into idle for longer because there is no workload".
> > 
> > I set the threshold based on capacity because I think conceptually it
> > makes more sense to say "every CPU is consireded to be utilized if the
> > util is above X% of its capacity" than to effectively have a varying
> > percentage based on the size of the core. 60 util is not that
> > much work for a 1024-util big core but it's almost half the capacity of
> > a little one, using a percentage/shift on capacity lets us account for that
> > while using a raw value would not.
> 
> Thanks for the explanation.
> 
> I did try the busy perspective, but I think I still view this as 60util means
> we've are running on average for X ms. which I think what matters more than how
> much this is of a work to the big core. I look at this; we still have few ms
> worth of runtime on the CPU and it's not worth going to deeper idle state
> yet.
> 
> I can appreciate you think that this percentage of runtime should be lower for
> smaller cores. My doubt (which again is not backed by real problem - so I'm not
> questioning but rather trying to understand :)) is that if this becomes too low
> is it better than letting usual TEO logic to operate. The series in its current
> shape is great and offers good improvement already, no doubt :)

No worries! In my experience it does tend to be better than just letting
the metrics logic operate as the metrics logic is pretty much just
reasonably good maths-based guessing and it relies on making mistakes
before adjusting - the util approach tries to just not make those
mistakes. Again, too shallow decisions most of the time are perfectly
fine, too deep decisions are an actual problem for both power and
performance.

> By the way, by default big will get a threshold of 16, the little will get
> a threshold of around 2. I think the latter will translate to few hundreds of
> us of activity (haven't done proper measurement to be honest, so this could be
> off but I don't think  by much).

Yeah that sounds about right but I don't think that's really an issue -
I'm pretty sure a case could be made to just never use deep idle on
littles anyway. Having some threshold above 0 at least accounts for the
"the phone is in your pocket" scenario. Because littles tend to run
many small background tasks over time in my testing they end up getting
tons of too deep decisions that mess things up so avoiding it tends
to be more beneficial. Especially I saw better results in UI benchmarks
like Jankbench that mainly run on littles.

> > 
> > There's also very practical issues but I'll describe those below.
> > 
> > > I'm not sure if this is a problem, but on little cores this threshold would be
> > > too low. Given that util is invariant - I wondered if we need to have a single
> > > threshold for all type of CPUs instead. Have you tried something like that
> > > while developing the patch?
> > 
> > Yes, the problem there is that it's very difficult to define what "too low"
> > actually means :)
> 
> target residency maybe?

Target residency refers to how long the cpu stays in idle, we're talking
about a threshold determining the avg util at which we allow deeper
idle in the first place. I don't think one really impacts the other? I
don't think we can really extrapolate from avg util the precise amount
of time we have until the next wakeup on the CPU apart from the
"probably soon" that the threshold is meant to determine.

> > Namely, do we define 'too low' based on the effects it has on
> > performance in terms of latency, on the resulting power usage or on the
> > prediction accuracy? In terms of the prediction accuracy, how do we
> > weigh the two possible types of mispredictions? I'll just try to explain
> > my thinking and how I got to my conclusions.
> > 
> > Based on my tests, on the types of platforms we both work with our
> > state0/wfi is very power efficient to stay in, very power efficient
> > to enter/exit and also very fast so it has very little impact on
> > latency. On the other hand, state1 is power efficient to *stay in* but
> > very costly to enter/exit in terms of *both* power and latency. The
> > effect this has is that there's many cases where going through a cycle
> > of busy-state1-busy-state1-busy and so on will actually use up more
> > power than if you only kept the core in wfi.
> > 
> > I had some tests done with effectively making the governor do "return 0"
> > in state selection, never using any state1 and the results were still
> > pretty good, only slightly worse than e.g. menu. The problem there was
> > that not using state1 on big cores would not leave them time to cool
> > down and we'd burn through the thermal budget too quickly then tank the
> > performance.
> > 
> > I don't have the numbers on hand but even completely disabling state1 on
> > the entire little cluster will work perfectly fine - your latency for
> > tasks that run on littles will improve and the thermal budget/power
> > won't take a particularly noticeable hit because of how small they are
> > in the first place.
> > 
> > This is why the governor is intentionally skewed towards shallower
> > states, they just work better most of the time. If you try to skew it
> > the other way the results just come out much worse because even a
> > relatively small amount of mispredicted state1 entries can completely
> > nullify any benefits that selecting state1 could bring.
> > 
> > The percentage approach does make the threshold for littles pretty small
> > but as desccribed above that's perfectly fine, could say a feature not a
> > bug :) If we tried setting a fixed one across all CPUs then we'd need to
> 
> I didn't think it's a bug. But it seemed too low, hence the question.
> I actually thought a single value is enough for all CPUs since util is
> invariant and the tipping point where TEO normal predictions should work should
> be the same.

Makes sense of course, I was saying it in the sense of "yes it's
intentionally that low" :)
From what I recall when I was testing it higher thresholds just didn't
work as well for the activity on the littles but could be
platform-specifc, always worth testing I suppose.

> Thanks for the detailed explanation :)
> 
> > pick one high enough for the big cores which would end up being too high
> > for the littles, lead to excessive state1 entries and all the issues
> > I've just described. TLDR: there's just more downsides on the other side.
> 
> This is an artifact of the shifting algorithm you used to derive it. It is not
> a real restriction. But I appreciate that simple approach proved to be good
> enough, and I have nothing against it.

True but even without the shifting just putting in a fixed number across
all clusters would have the same effect I'm pretty sure. E.g. if we go
with 16 that's fine for the big cluster but will let through a big chunk
of the too deep sleeps on the littles. If we pick 5 it's better for the
littles but suddenly the big cores which tend to get bigger-util tasks
will almost never go into deep idle.

> > 
> > In development I just had a sysctl to set the threshold shift and iirc I
> > tested values from 3 to 10-12 eventually arriving at 6 being the one
> > with best results across different metrics and benchmarks. If you're
> > backporting the patch somewhere and have a specific platform feel free
> > to test it with different shift values, it's possible that different
> > platforms will behave differently with this. I doubt there's any
> > appetite to make the shift tweakable at runtime rather than a
> > compile-time constant but if you'd like to push for that I'm happy to
> > sign off on it, would work just as well as it does now.
> 
> These patches are in GKI. So we'll if there are uncaught problems I guess :)

More testing platform is always a good idea, maybe we'll find some new
things out :)

> 
> No appetite for a knob, but the very low value for littles did strike me and
> thought I better ask at least. Today's littles are too tiny for their own good
> and it seemed the threshold could end up being too aggressive especially in low
> activity state. You effectively are saying that if we have few 100us of
> activity, normal TEO predictions based on timers are no good and better to stay
> shallower anyway.

It probably would be too aggressive if our state0 was a polling state
like on Intel cores, here we're very much leveraging the fact that arm
wfi is already very efficient. This makes it possible to afford multiple
'too shallow' sleeps that give us better latency + not a big power
difference as opposed to the 'too deep' ones that seriously harm both.

> Note that due to NOHZ, if we go to idle for an extended period the util value
> might not decay for a while and miss some opportunities. Especially that when
> it next wakes up, it's enough for this wake up to run for few 100s us to block
> a deeper state before going back to sleep for extended period of time.

That's true, again a tradeoff that usually comes out better - it's much
better overall to miss a deep sleep opportunity than to go into deep
idle and then not hit the residency.

> But we shall see. I got the answer I was looking for for now.

You're welcome, good luck!

> 
> Thanks for the help!
> 
> --
> Qais Yousef
