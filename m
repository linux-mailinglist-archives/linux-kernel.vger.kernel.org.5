Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0427C757B18
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGRMDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjGRMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:03:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EE591B1;
        Tue, 18 Jul 2023 05:03:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E56D2F4;
        Tue, 18 Jul 2023 05:03:46 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.79.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42BAC3F6C4;
        Tue, 18 Jul 2023 05:03:00 -0700 (PDT)
Date:   Tue, 18 Jul 2023 13:02:54 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kajetan.puchalski@arm.com
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711175814.zfavcn7xn3ia5va4@airbuntu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Tue, Jul 11, 2023 at 06:58:14PM +0100, Qais Yousef wrote:
> Hi Kajetan
> 
> On 01/05/23 14:51, Kajetan Puchalski wrote:
> 
> [...]
> 
> > @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
> >  			     struct cpuidle_device *dev)
> >  {
> >  	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> > +	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
> >  	int i;
> >  
> >  	memset(cpu_data, 0, sizeof(*cpu_data));
> > +	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> 
> Given that utilization is invariant, why do we set the threshold based on
> cpu capacity?

Conceptually, the threshold is meant to represent a level at which the
core is considered 'utilized'. I appreciate the definitions here can get
a little fuzzy but I think of it as "generally doing a non-insignificant
amount of work" even if there are currently no tasks scheduled on the core.
This comes in handy in real-world workloads where the core will go
through multiple cycles of busy-idle-busy-idle within each second.
The intention here is to be able to distinguish a scenario of "going
into idle for a few us because of the nature of the workload" from
"going into idle for longer because there is no workload".

I set the threshold based on capacity because I think conceptually it
makes more sense to say "every CPU is consireded to be utilized if the
util is above X% of its capacity" than to effectively have a varying
percentage based on the size of the core. 60 util is not that
much work for a 1024-util big core but it's almost half the capacity of
a little one, using a percentage/shift on capacity lets us account for that
while using a raw value would not.

There's also very practical issues but I'll describe those below.

> I'm not sure if this is a problem, but on little cores this threshold would be
> too low. Given that util is invariant - I wondered if we need to have a single
> threshold for all type of CPUs instead. Have you tried something like that
> while developing the patch?

Yes, the problem there is that it's very difficult to define what "too low"
actually means :)
Namely, do we define 'too low' based on the effects it has on
performance in terms of latency, on the resulting power usage or on the
prediction accuracy? In terms of the prediction accuracy, how do we
weigh the two possible types of mispredictions? I'll just try to explain
my thinking and how I got to my conclusions.

Based on my tests, on the types of platforms we both work with our
state0/wfi is very power efficient to stay in, very power efficient
to enter/exit and also very fast so it has very little impact on
latency. On the other hand, state1 is power efficient to *stay in* but
very costly to enter/exit in terms of *both* power and latency. The
effect this has is that there's many cases where going through a cycle
of busy-state1-busy-state1-busy and so on will actually use up more
power than if you only kept the core in wfi.

I had some tests done with effectively making the governor do "return 0"
in state selection, never using any state1 and the results were still
pretty good, only slightly worse than e.g. menu. The problem there was
that not using state1 on big cores would not leave them time to cool
down and we'd burn through the thermal budget too quickly then tank the
performance.

I don't have the numbers on hand but even completely disabling state1 on
the entire little cluster will work perfectly fine - your latency for
tasks that run on littles will improve and the thermal budget/power
won't take a particularly noticeable hit because of how small they are
in the first place.

This is why the governor is intentionally skewed towards shallower
states, they just work better most of the time. If you try to skew it
the other way the results just come out much worse because even a
relatively small amount of mispredicted state1 entries can completely
nullify any benefits that selecting state1 could bring.

The percentage approach does make the threshold for littles pretty small
but as desccribed above that's perfectly fine, could say a feature not a
bug :) If we tried setting a fixed one across all CPUs then we'd need to
pick one high enough for the big cores which would end up being too high
for the littles, lead to excessive state1 entries and all the issues
I've just described. TLDR: there's just more downsides on the other side.

In development I just had a sysctl to set the threshold shift and iirc I
tested values from 3 to 10-12 eventually arriving at 6 being the one
with best results across different metrics and benchmarks. If you're
backporting the patch somewhere and have a specific platform feel free
to test it with different shift values, it's possible that different
platforms will behave differently with this. I doubt there's any
appetite to make the shift tweakable at runtime rather than a
compile-time constant but if you'd like to push for that I'm happy to
sign off on it, would work just as well as it does now.


> Thanks
> 
> --
> Qais Yousef
