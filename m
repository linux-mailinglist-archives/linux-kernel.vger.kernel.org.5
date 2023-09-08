Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5244B797F92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjIHARf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjIHARe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:17:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7142E19BD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:17:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso17542615e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694132248; x=1694737048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmx2nZAg7akpVBQYgNz9ZZPVxPTh8tFgVJob486R9+I=;
        b=nsdQ0Ue64AJfAa8e0b8laOf+vZ8iq3KZkHwl9Xu/tt74w33EGxOct16A1Z+tDbka+7
         Y5jeHKqBCeTkKneN6OyoWY3lLQsnqhp55DKENoWPx3hQiKEpy9wZVWtBSX7GfaGVymXZ
         akTN8Uu+zxYdmeKicOwM8qkAlP/xrtcZY06yTpBbeLRkUG8Jk6wuiQlhTcWEtRhcHK69
         GB1rsGRlKgxJTDQIkhS8J1cyPN8pCZM4qV/7P3I24//ZiCwyzg/3EDWpYgskMIAf/Gbl
         gUKxyRbxy38qKsj1QcVK8oIvwQUUvChe46q6VuLaquNY/0sJ7bcKWc21274zPhRZ4vbC
         LpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694132248; x=1694737048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmx2nZAg7akpVBQYgNz9ZZPVxPTh8tFgVJob486R9+I=;
        b=SEiarpc5Ea3RGIqunmV2WRBGNEUQPHZErjn+H5k+3tN585bMKBzm2uDqXAQ6YHzByt
         T8KEDGE2r113bXy+kOpr9GHKNz3bplmIvbM7plbIEMBCwZzKxmA6HvS70TbWgU6KVb4m
         H/HcEUOQPsYZ15mRE1j+9uYHFCRPFJ1X144KGqV5y82TBpUsagv67dGGUdpnOhBObhcI
         SHx+t/2DwarmFnwM4F+F/t87+Y247vF2rK7BqJnH5IHR9MhaeoYNVHgY4iW/IO7qJj2e
         9BOHHPY/XI0c1DB6DrQ1es5u7u1nuwUaX3EH3OThb8TC5tcM1o+GJCWcPPhRxpAPXWXK
         mUJw==
X-Gm-Message-State: AOJu0Yxj4TH94joUbogVLMT3mn9vOlYUdh4e7/m2z8sqJk93ceR2RxZw
        +y94a3EFjQg9t3C2Oj4gPIwaMQ==
X-Google-Smtp-Source: AGHT+IHZtn7wR+TcrUFja8bsT3+S5oQGyWjlJqtIJzpsWXmRe9/U1lD9gshpzoSOd2G9UOnNYdijnQ==
X-Received: by 2002:a5d:6245:0:b0:314:2f3e:dca5 with SMTP id m5-20020a5d6245000000b003142f3edca5mr515542wrv.28.1694132247722;
        Thu, 07 Sep 2023 17:17:27 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b003180fdf5589sm616017wrr.6.2023.09.07.17.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 17:17:27 -0700 (PDT)
Date:   Fri, 8 Sep 2023 01:17:25 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907130805.GE10955@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 15:08, Peter Zijlstra wrote:
> On Mon, Aug 28, 2023 at 12:31:56AM +0100, Qais Yousef wrote:
> 
> > Equally recent discussion in PELT HALFLIFE thread highlighted the need for
> > a way to tune system response time to achieve better perf, power and thermal
> > characteristic for a given system
> > 
> > 	https://lore.kernel.org/lkml/20220829055450.1703092-1-dietmar.eggemann@arm.com/
> > 
> 
> > To further help tune the system, we introduce PELT HALFLIFE multiplier as
> > a boot time parameter. This parameter has an impact on how fast we migrate, so
> > should compensate for whoever needed to tune fits_capacity(); and it has great
> > impact on default response_time_ms. Particularly it gives a natural faster rise
> > time when the system gets busy, AND fall time when the system goes back to
> > idle. It is coarse grain response control that can be coupled with finer grain
> > control via schedutil's response_time_ms.
> 
> You're misrepresenting things... The outcome of that thread above was

Sorry if I did. My PoV might have gotten skewed. I'm not intending to mislead
for sure. I actually was hesitant about adding the PELT patch initially, but
it did feel that the two topics are connected. Margins are causing problems
because they end up wasting power. So there's a desire to slow current response
down. But this PELT story wanted to speed things up. And this polar opposite is
what I think the distilled problem.

> that PELT halftime was not the primary problem. Specifically:
> 
>   https://lore.kernel.org/lkml/424e2c81-987d-f10e-106d-8b4c611768bc@arm.com/
> 
> mentions that the only thing that gaming nonsense cares about is DVFS
> ramp-up.
> 
> None of the other PELT users mattered one bit.

I actually latched to Vincent response about a boot time parameter makes sense.

Just to be clear, my main issue here with the current hardcoded values of the
'margins'. And the fact they go too fast is my main problem.

The way I saw PELT fits in this story is to help lower end systems who don't
have a lot of oomph. For reasonably powerful system; I don't see a necessity to
change this and DVFS is what matters, I agree.

It was my attempt to draw a full picture and cover the full spectrum. I don't
think PELT halfllife plays a role in powerful systems. But under-powered ones,
I think it will help; and that's why I was depicting it as coarse grain
control.

I think I did try to present similar arguments on that thread.

> 
> Also, ISTR a fair amount of this was workload dependent. So a solution
> that has per-task configurability -- like UTIL_EST_FASTER, seems more
> suitable.

But for the 0.8 and 1.25 margin problems, actually the problem is that 25% is
too aggressive/fast and wastes power. I'm actually slowing things down as
a result of this series. And I'm expecting some not to be happy about it on
their systems. The response_time_ms was my way to give back control. I didn't
see how I can make things faster and slower at the same time without making
decisions on behalf of the user/sysadmin.

So the connection I see between PELT and the margins or headrooms in
fits_capacity() and map_util_perf()/dvfs_headroom is that they expose the need
to manage the perf/power trade-off of the system.

Particularly the default is not good for the modern systems, Cortex-X is too
powerful but we still operate within the same power and thermal budgets.

And what was a high end A78 is a mid core today. So if you look at today's
mobile world topology we really have a tiy+big+huge combination of cores. The
bigs are called mids, but they're very capable. Fits capacity forces migration
to the 'huge' cores too soon with that 80% margin. While the 80% might be too
small for the tiny ones as some workloads really struggle there if they hang on
for too long. It doesn't help that these systems ship with 4ms tick. Something
more to consider changing I guess.

And the 25% headroom forces near max frequency to be used when the workload is
happily hovering in the 750 region. I did force the frequency to be lower and
the workload is happily running - we don't need the extra 25% headroom
enforced unconditionally.

UTIL_EST_FASTER moves in one direction. And it's a constant response too, no?
I didn't get the per-task configurability part. AFAIU we can't turn off these
sched-features if they end up causing power issues. That what makes me hesitant
about them. There's a bias towards perf. But some systems prefer to save power
at the expense of perf. There's a lot of grey areas in between to what
perceived as a suitable trade-off for perf vs power. There are cases like above
where actually you can lower freqs without hit on perf. But most of the time
it's a trade-off; and some do decide to drop perf in favour of power. Keep in
mind battery capacity differs between systems with the same SoC even. Some ship
to enable more perf, others are more constrained and opt to be more efficient.

Sorry I didn't explain things well in the cover letter.

> I'm *really* hesitant on adding all these mostly random knobs -- esp.
> without strong justification -- which you don't present. You mostly seem
> to justify things with: people do random hack, we should legitimize them
> hacks.

I share your sentiment and I am trying to find out what's the right thing to do
really. I am open to explore other territories. But from what I see there's
a real need to give users the power to tune how responsive their system needs
to be. I can't see how we can have one size that fits all here given the
different capabilities of the systems and the desired outcome (I want more perf
vs more efficiency).

> Like the last time around, I want the actual problem explained. The
> problem is not that random people on the internet do random things to
> their kernel.

The problem is that those 0.8 and 1.25 margins forces unsuitable default. The
case I see the most is it is causing wasting power that tuning it down regains
this power at no perf cost or small one. Others actually do tune it for faster
response, but I can't cover this case in detail. All I know is lower end
systems do struggle as they don't have enough oomph. I also saw comparison on
phoronix where schedutil is not doing as good still - which tells me it seems
server systems do prefer to ramp up faster too. I think that PELT thread is
a variation of the same problem.

So one of the things I saw is a workload where it spends majority of the time
in 600-750 util_avg range. Rarely ramps up to max. But the workload under uses
the medium cores and runs at a lot higher freqs than it really needs on bigs.
We don't end up utilizing our resources properly.

Happy to go and dig for more data/info if this is not good enough :)

There's a question that I'm struggling with if I may ask. Why is it perceived
our constant response time (practically ~200ms to go from 0 to max) as a good
fit for all use cases? Capability of systems differs widely in terms of what
performance you get at say a util of 512. Or in other words how much work is
done in a unit of time differs between system, but we still represent that work
in a constant way. A task ran for 10ms on powerful System A would have done
a lot more work than running on poor System B for the same 10ms. But util will
still rise the same for both cases. If someone wants to allow this task to be
able to do more on those 10ms, it seems natural to be able to control this
response time. It seems this thinking is flawed for some reason and I'd
appreciate a help to understand why. I think a lot of us perceive this problem
this way.

Hopefully uclamp will help address these issues in a better way. ADPF gives
apps a way to access it reasonably now. Unity announced support for ADPF, so
hopefully games and other workloads can learn to be smarter overtime. But the
spectrum of workloads to cover is still big, and adoption will take time. And
there are still lessons to be learnt and improvements to make. I expect this
effort to take time before it's the norm.  And thinking of desktop systems;
distros like Debian for example still don't enable uclamp by default on their
kernels. I sent asking to enable it and it got added to wishlist.. Actually
even schedutil is not enabled by default on my Pine64 running Armbian nor on my
Mac Mini with M1 chip running Asahi Linux Ubuntu.  You'd think big.LITTLE
systems should have EAS written all over them, but not sure if this is
accidental omission or ondemand is actually perceived as better. I think my
intel systems also don't run schedutil by default still too.  They're not
waking up on lan now to double check though (yep, saving power :D).

Happy to go and try to dig more info if this is still not clear enough.


Thanks!

--
Qais Yousef
