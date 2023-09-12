Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1CF79D3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjILOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbjILOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:34:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52F1F12E;
        Tue, 12 Sep 2023 07:34:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42403C15;
        Tue, 12 Sep 2023 07:35:17 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1EF33F5A1;
        Tue, 12 Sep 2023 07:34:38 -0700 (PDT)
Message-ID: <ecbd165e-4213-8dd4-d5b5-309256cc64a9@arm.com>
Date:   Tue, 12 Sep 2023 16:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
 <7839dd5f-e7fd-7065-934d-436d012ac9d6@arm.com>
 <20230826200829.gnha7xcrjbyipjr2@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230826200829.gnha7xcrjbyipjr2@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 22:08, Qais Yousef wrote:
> On 08/21/23 18:39, Dietmar Eggemann wrote:
>> On 20/08/2023 23:06, Qais Yousef wrote:
>>> DVFS headroom is applied after we calculate the effective_cpu_util()
>>> which is where we honour uclamp constraints. It makes more sense to
>>> apply the headroom there once and let all users naturally get the right
>>> thing without having to sprinkle the call around in various places.
>>
>> uclamp is applied in effective_cpu_util(..., FREQUENCY_UTIL, ...) which
>> IMHO currently has 2 power callers: (1) schedutil: sugov_get_util() and
>> (2) EAS: eenv_pd_max_util()
>>
>>> Before this fix running
>>>
>>> 	uclampset -M 800 cat /dev/zero > /dev/null
>>>
>>> Will cause the test system to run at max freq of 2.8GHz. After the fix
>>> it runs at 2.2GHz instead which is the correct value that matches the
>>> capacity of 800.
>>
>> IMHO, a system at util = 800 (w/o uclamp) would also run at 2.8Ghz since
>> we would call map_util_to_perf() on 800, no matter from where we call it.
> 
> Sorry, I would very strongly disagree here. What you're saying the effective
> range of uclamp_max is 800 and anything above that will always go to max. How
> can this be acceptable?

No that's not what I wanted to say here.

I wanted to highlight the different treatment of `(1) a task with
(natural) util = 800` and `(2) a task with uclamp_max = 800`.

(1) util = 800

util = (1.25 * 800 * (1024 - irq) / 1024 + ...

        <-      ->
        uclamped(cfs+rt+headroom(cfs+rt))


(2) uclamp_max = 800

util = (800 * (1024 - irq) / 1024 + ...

        <->
        uclamped(cfs+rt+headroom(cfs+rt))

So for (1) the scheduler would ask for more than in (2).

That's essentially the same question which was raised here:

https://lkml.kernel.org/r/CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com

>>> Note that similar problem exist for uclamp_min. If util was 50, and
>>> uclamp_min is 100. Since we apply_dvfs_headroom() after apply uclamp
>>> constraints, we'll end up with util of 125 instead of 100. IOW, we get
>>> boosted twice, first time by uclamp_min, and second time by dvfs
>>> headroom.
>>
>> I see what you want to change here but:
>>
>> So far we have `util -> uclamp -> map_util_to_perf()`
> 
> :-O
> 
> So when I set the system uclamp_max to 800 it will still run at max; and this
> is normal?!!

No that's an issue (A) as well. But the diff between (1) and (2) is IMHO a
new issue introduced by this patch-set.

>> which is fine when we see uclamp as an entity which constrains util, not
>> the util after being mapped to a capacity constraint.
> 
> -ENOPARSE.

What I meant is 'clamping the util' before scheduler hands over to
'cpufreq' is fine:

    util -> uclamp -> map_util_to_perf()
               
    scheduler    -->|<-- cpufreq

I do understand that you guys are already discussing a new
cpufreq_give_me_freq_for_this_utilization_ctx() between EM and CPUfreq
in the other thread of this patch to maybe sort out (A).

[...]
