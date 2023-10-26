Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55CD7D7F52
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjJZJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:08:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44A7D128;
        Thu, 26 Oct 2023 02:08:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3912F4;
        Thu, 26 Oct 2023 02:08:43 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F10D3F738;
        Thu, 26 Oct 2023 02:07:58 -0700 (PDT)
Message-ID: <6709d44b-39c3-414d-b0f9-fe217bb32876@arm.com>
Date:   Thu, 26 Oct 2023 11:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/schedutil: rework performance estimation
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org,
        viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
References: <20231013151450.257891-1-vincent.guittot@linaro.org>
 <20231013151450.257891-2-vincent.guittot@linaro.org>
 <d76b75cf-04d8-411d-ad92-b7de4dd0f43b@arm.com>
 <CAKfTPtC77NKhz2QKwM68kS8Z9CsB8y588VER8aJeBLRwpdGALA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtC77NKhz2QKwM68kS8Z9CsB8y588VER8aJeBLRwpdGALA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2023 15:58, Vincent Guittot wrote:
> On Fri, 20 Oct 2023 at 11:48, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 13/10/2023 17:14, Vincent Guittot wrote:

[...]

>>> A new sugov_effective_cpu_perf() interface is also available to compute
>>> the final performance level that is targeted for the CPU after applying
>>> some cpufreq headroom and taking into account all inputs.
>>>
>>> With these 2 functions, schedutil is now able to decide when it must go
>>> above uclamp hints. It now also have a generic way to get the min
>>> perfromance level.
>>>
>>> The dependency between energy model and cpufreq governor and its headroom
>>> policy doesn't exist anymore.
>>
>> But the dependency that both are doing the same thing still exists, right?
> 
> For the energy model itself, it is now fully removed; only EAS still
> has to estimate which perf level will be selected by schedutil but it
> uses now a schedutil function without having to care about headroom
> and cpufreq governor policy

I see now. (1) replaces (2) so only schedutil and EAS, EM dependency is
gone.

compute_energy()

  max_util = eenv_pd_max_util()

                 sugov_effective_cpu_perf()

                     actual = map_util_perf(actual)   (1)


  energy = em_cpu_energy(..., max_util, ...);

               max_util = map_util_perf(max_util)     (2)

[...]

>>>  unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>>> -                              enum cpu_util_type type,
>>> -                              struct task_struct *p)
>>> +                              unsigned long *min,
>>> +                              unsigned long *max)
>>
>> FREQUENCY_UTIL relates to *min != NULL and *max != NULL
>>
>> ENERGY_UTIL relates to *min == NULL and *max == NULL
>>
>> so both must be either NULL or !NULL.
>>
>> Calling it with one equa NULL and the other with !NULL should be
>> undefined, right?
> 
> At now there is no user but one could consider only asking for min or
> max. So I would not say undefined but unused

OK.

[...]

>>> -      * OTOH, for energy computation we need the estimated running time, so
>>> -      * include util_dl and ignore dl_bw.
>>> -      */
>>> -     if (type == ENERGY_UTIL)
>>> -             util += dl_util;
>>> +     if (util >= scale) {
>>> +             if (max)
>>> +                     *max = scale;
>>
>> But that means that ucamp_max cannot constrain a system in which the
>> 'util > ucamp_max'. I guess that's related to you saying uclamp_min is a
>> hard req and uclamp_max is a soft req. I don't think that's in sync with
>> the rest of the uclamp_max implantation.
> 
> That's a mistake, I made a shortcut here. I wanted to save the
> scale_irq_capacity() step but forgot to update max 1st.
> 
> Will fix it

I see.

[...]

>> effective_cpu_util for FREQUENCY_UTIL (i.e. (*min != NULL && *max !=
>> NULL)) is slightly different.
>>
>>   missing:
>>
>>   if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt)
>>     return max
>>
>>   probably moved into sugov_effective_cpu_perf() (which is only called
>>   for `FREQUENCY_UTIL`) ?
> 
> yes, it's in sugov_effective_cpu_perf()

OK.

[...]

>>> @@ -306,7 +329,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
>>>   */
>>>  static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
>>>  {
>>> -     if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
>>> +     if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
>>
>> bw_min is more than DL right?
> 
> yes
> 
> Interruptions are preempting DL so we should include them
> And now that we can take into account uclamp_min, use it when
> computing the min perf parameter of cpufreq_driver_adjust_perf()

OK.
