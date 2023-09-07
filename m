Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6208279741B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbjIGPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbjIGPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:33:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B6BB1FC2;
        Thu,  7 Sep 2023 08:32:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC4CC1042;
        Thu,  7 Sep 2023 00:48:11 -0700 (PDT)
Received: from [10.57.92.126] (unknown [10.57.92.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 507E33F7B4;
        Thu,  7 Sep 2023 00:47:32 -0700 (PDT)
Message-ID: <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
Date:   Thu, 7 Sep 2023 08:48:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/23 22:18, Qais Yousef wrote:
> Hi Lukasz
> 
> On 09/06/23 10:18, Lukasz Luba wrote:
>> Hi Qais,
>>
>> On 8/28/23 00:31, Qais Yousef wrote:
>>> Since the introduction of EAS and schedutil, we had two magic 0.8 and 1.25
>>> margins applied in fits_capacity() and apply_dvfs_headroom().
>>>
>>> As reported two years ago in
>>>
>>> 	https://lore.kernel.org/lkml/1623855954-6970-1-git-send-email-yt.chang@mediatek.com/
>>>
>>> these values are not good fit for all systems and people do feel the need to
>>> modify them regularly out of tree.
>>
>> That is true, in Android kernel those are known 'features'. Furthermore,
>> in my game testing it looks like higher margins do help to shrink
>> number of dropped frames, while on other types of workloads (e.g.
>> those that you have in the link above) the 0% shows better energy.
> 
> Do you keep margins high for all types of CPU? I think the littles are the
> problematic ones which higher margins helps as this means you move away from
> them quickly.

That's true, for the Littles higher margins helps to evacuate tasks
sooner. I have experiments showing good results with 60% margin on
Littles, while on Big & Mid 20%, 30%. The Littles still have also
tasks in cgroups cpumask which are quite random, so they cannot
migrate, but have a bit higher 'idle time' headroom.


> 
>>
>> I remember also the results from MTK regarding the PELT HALF_LIFE
>>
>> https://lore.kernel.org/all/0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com/
>>
>> The numbers for 8ms half_life where showing really nice improvement
>> for the 'min fps' metric. I got similar with higher margin.
>>
>> IMO we can derive quite important information from those different
>> experiments:
>> More sustainable workloads like "Yahoo browser" don't need margin.
>> More unpredictable workloads like "Fortnite" (shooter game with 'open
>> world') need some decent margin.
> 
> Yeah. So the point is that while we should have a sensible default, but there
> isn't a one size fits all. But the question is how the user/sysadmin should
> control this? This series is what I propose of course :)
> 
> I also think the current forced/fixed margin values enforce a policy that is
> clearly not a good default on many systems. With no alternative in hand but to
> hack their own solutions.

I see.

> 
>>
>> The problem is that the periodic task can be 'noisy'. The low-pass
> 
> Hehe. That's because they're not really periodic ;-)

They are periodic in a sense, they wake up every 16ms, but sometimes
they have more work. It depends what is currently going in the game
and/or sometimes the data locality (might not be in cache).

Although, that's for games, other workloads like youtube play or this
one 'Yahoo browser' (from your example) are more 'predictable' (after
the start up period). And I really like the potential energy saving
there :)

> 
> I think the model of a periodic task is not suitable for most workloads. All
> of them are dynamic and how much they need to do at each wake up can very
> significantly over 10s of ms.

Might be true, the model was built a few years ago when there wasn't
such dynamic game scenario with high FPS on mobiles. This could still
be tuned with your new design IIUC (no need extra hooks in Android).

> 
>> filter which is our exponentially weighted moving avg PELT will
>> 'smooth' the measured values. It will block sudden 'spikes' since
>> they are high-frequency changes. Those sudden 'spikes' are
>> the task activations where we need to compute a bit longer, e.g.
>> there was explosion in the game. The 25% margin helps us to
>> be ready for this 'noisy' task - the CPU frequency is higher
>> (and capacity). So if a sudden need for longer computation
>> is seen, then we have enough 'idle time' (~25% idle) to serve this
>> properly and not loose the frame.
>>
>> The margin helps in two ways for 'noisy' workloads:
>> 1. in fits_capacity() to avoid a CPU which couldn't handle it
>>     and prefers CPUs with higher capacity
>> 2. it asks for longer 'idle time' e.g. 25-40% (depends on margin) to
>>     serve sudden computation need
>>
>> IIUC, your proposal is to:
>> 1. extend the low-pass filter to some higher frequency, so we
>>     could see those 'spikes' - that's the PELT HALF_LIFE boot
>>     parameter for 8ms
> 
> That's another way to look at it, yes. We can control how reactive we'd like
> the system to be for changes.

Which make sense in context to what I said above (newer gaming).

> 
>> 1.1. You are likely to have a 'gift' from the Util_est
>>       which picks the max util_avg values and maintains them
>>       for a while. That's why the 8ms PELT information can last longer
>>       and you can get higher frequency and longer idle time.
> 
> This is probably controversial statement. But I am not in favour of util_est.
> I need to collect the data, but I think we're better with 16ms PELT HALFLIFE as
> default instead. But I will need to do a separate investigation on that.

I like util_est, sometimes it helps ;)

> 
>> 2. Plumb in this new idea of dvfs_update_delay as the new
>>     'margin' - this I don't understand
>>
>> For the 2. I don't see that the dvfs HW characteristics are best
>> for this problem purpose. We can have a really fast DVFS HW,
>> but we need some decent spare idle time in some workloads, which
>> are two independent issues IMO. You might get the higher
>> idle time thanks to 1.1. but this is a 'side effect'.
>>
>> Could you explain a bit more why this dvfs_update_delay is
>> crucial here?
> 
> I'm not sure why you relate this to idle time. And the word margin is a bit
> overloaded here. so I suppose you're referring to the one we have in
> map_util_perf() or apply_dvfs_headroom(). And I suppose you assume this extra
> headroom will result in idle time, but this is not necessarily true IMO.
> 
> My rationale is simply that DVFS based on util should follow util_avg as-is.
> But as pointed out in different discussions happened elsewhere, we need to
> provide a headroom for this util to grow as if we were to be exact and the task
> continues to run, then likely the util will go above the current OPP before we
> get a chance to change it again. If we do have an ideal hardware that takes

Yes, this is another requirement to have +X% margin. When the tasks are
growing, we don't know their final util_avg and we give them a bit more
cycles.
IMO we have to be ready always for such situation in the scheduler,
haven't we?

> 0 time to change frequency, then this headroom IMO is not needed because
> frequency will follow us as util grows. Assuming here that util updates
> instantaneously as the task continues to run.
> 
> So instead of a constant 25% headroom; I redefine this to be a function of the
> hardware delay. If we take a decision now to choose which OPP, then it should
> be based on util_avg value after taking into account how much it'll grow before
> we take the next decision (which the dvfs_update_delay). We don't need any more
> than that.
> 
> Maybe we need to take into account how often we call update_load_avg(). I'm not
> sure about this yet.
> 
> If the user wants to have faster response time, then the new knobs are the way
> to control that. But the headroom should be small enough to make sure we don't
> overrun until the next decision point. Not less, and not more.

For ideal workloads (rt-app) or those 'calm' yes, we could save energy
(as you pointed for this 0% margin energy values). I do like this 10%
energy saving in some DoU scenarios. I couldn't catch the idea with
feeding the dvfs response information into this equation. We might
discuss this offline ;)

Cheers,
Lukasz
