Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE547EE135
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjKPNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjKPNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:14:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B66C19A3;
        Thu, 16 Nov 2023 05:13:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E72F41595;
        Thu, 16 Nov 2023 05:14:41 -0800 (PST)
Received: from [10.57.3.57] (unknown [10.57.3.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05F2C3F73F;
        Thu, 16 Nov 2023 05:13:52 -0800 (PST)
Message-ID: <64f78eec-61fb-447f-bbba-706bd5a54cd7@arm.com>
Date:   Thu, 16 Nov 2023 13:14:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/schedutil: rework performance estimation
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     wyes.karny@amd.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, vschneid@redhat.com, bristot@redhat.com,
        bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, beata.michalska@arm.com,
        linux-kernel@vger.kernel.org, qyousef@layalina.io,
        viresh.kumar@linaro.org, mingo@redhat.com, mgorman@suse.de
References: <20231026170913.32605-1-vincent.guittot@linaro.org>
 <20231026170913.32605-2-vincent.guittot@linaro.org>
 <83d6a790-3d18-4922-850b-b60e88761786@arm.com>
 <CAKfTPtCLc3z6k9MwW6XKHjbh78AFrAg1T1MONYtf8N8GGR6fGQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtCLc3z6k9MwW6XKHjbh78AFrAg1T1MONYtf8N8GGR6fGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I know that there is v3, but just to respond to this below.

On 10/31/23 09:48, Vincent Guittot wrote:
> Hi Lukasz,
> 
> On Mon, 30 Oct 2023 at 18:45, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Vincent,
>>
>> On 10/26/23 18:09, Vincent Guittot wrote:
>>> The current method to take into account uclamp hints when estimating the
>>> target frequency can end into situation where the selected target
>>> frequency is finally higher than uclamp hints whereas there are no real
>>> needs. Such cases mainly happen because we are currently mixing the
>>> traditional scheduler utilization signal with the uclamp performance
>>> hints. By adding these 2 metrics, we loose an important information when
>>> it comes to select the target frequency and we have to make some
>>> assumptions which can't fit all cases.
>>>
>>> Rework the interface between the scheduler and schedutil governor in order
>>> to propagate all information down to the cpufreq governor.
>>>
>>> effective_cpu_util() interface changes and now returns the actual
>>> utilization of the CPU with 2 optional inputs:
>>> - The minimum performance for this CPU; typically the capacity to handle
>>>     the deadline task and the interrupt pressure. But also uclamp_min
>>>     request when available.
>>> - The maximum targeting performance for this CPU which reflects the
>>>     maximum level that we would like to not exceed. By default it will be
>>>     the CPU capacity but can be reduced because of some performance hints
>>>     set with uclamp. The value can be lower than actual utilization and/or
>>>     min performance level.
>>
>> You have probably missed my question in the last v1 patch set.
> 
> Yes, sorry
> 
>>
>> The description above needs a bit of clarification, since looking at the
>> patches some dark corners are introduced IMO:
>>
>> Currently, we have a less aggressive power saving policy than this
>> proposal.
>>
>> The questions:
>> What if the PD has 4 CPUs, the max util found is 500 and is from a CPU
>> w/ uclamp_max, but there is another CPU with normal utilization 499?
>> What should be the final frequency for that PD?
> 
> We now follow the same sequence everywhere which can be summarized by:
> 
> for each cpu sharing the same frequency domain:
>      util = cpu_util(cpu)
>      eff_util = effective_cpu_util(util, &min, &max)
>      eff_util = sugov_effective_cpu_perf(eff_util, min, max) which
> applies the dvfs headroom if needed
>      max_util = max(max_util, eff_util);
> 
> EAS anticipates the impact of the waking task on utilization and max
> but the end result is the same as above once the task is enqueued so I
> didn't show it for simplicity
> 
> Coming back to your example
>    CPU0 has uclamp_max = 500 and an actual utilization above 500. Its
> eff_util will be 500
>    CPU1 doesn't have uclamp_max constraint and an actual utilization of
> 499 which will be increase with dvfs headroom to 623 in
> sugov_effective_cpu_perf()
> 
> The final max util will be 623
> 
> With the current implementation we apply the dvfs headroom to the
> final max_util (which is the CPU0 with uclamp_max == 500) whereas we
> now apply the dvfs headroom on each CPU inside
> sugov_effective_cpu_perf()
> 
> The main difference is that if CPU1 has an actual utilization of 400,
> the max_util of the frequency domain will be 500 whereas it is 625
> after applying dvfs headroom with current implementation
> 
>>
>> In current design, where we care more about 'delivered performance
>> to the tasks' than power saving, the +20% would be applied for the
>> frequency. Therefore if that CPU with 499 util doesn't have uclamp_max,
>> it would get a decent amount of idle time for its tasks (to compensate
>> some workload variation).
> 
> CPU1 with 499 still gets its 25% margin or I missed something in your example ?

You understood this correctly. I don't have more questions. It should
than work OK.

Thanks,
Lukasz
