Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0C475FAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGXPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGXPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:33:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0170B1;
        Mon, 24 Jul 2023 08:33:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A35DFEC;
        Mon, 24 Jul 2023 08:34:30 -0700 (PDT)
Received: from [10.34.100.101] (e126645.nice.arm.com [10.34.100.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04D383F67D;
        Mon, 24 Jul 2023 08:33:44 -0700 (PDT)
Message-ID: <18b0d54b-f8d2-ff38-f5c8-697dc838e3ce@arm.com>
Date:   Mon, 24 Jul 2023 17:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
Content-Language: en-US
To:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Qais Yousef <qyousef@layalina.io>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, guohua.yan@unisoc.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230719130527.8074-1-xuewen.yan@unisoc.com>
 <20230721221944.dthg3tf25j4qgc2z@airbuntu>
 <CAB8ipk8b8ZfwXN7KK-zFVPQ-8i37h64v-wz2ErB3AANaZ9w7aA@mail.gmail.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAB8ipk8b8ZfwXN7KK-zFVPQ-8i37h64v-wz2ErB3AANaZ9w7aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 05:36, Xuewen Yan wrote:
> On Sat, Jul 22, 2023 at 7:02 AM Qais Yousef <qyousef@layalina.io> wrote:
>>
>> On 07/19/23 21:05, Xuewen Yan wrote:
>>> When cpufreq's policy is single, there is a scenario that will
>>> cause sg_policy's next_freq to be unable to update.
>>>
>>> When the cpu's util is always max, the cpufreq will be max,
>>> and then if we change the policy's scaling_max_freq to be a
>>> lower freq, indeed, the sg_policy's next_freq need change to
>>> be the lower freq, however, because the cpu_is_busy, the next_freq
>>> would keep the max_freq.
>>>
>>> For example:
>>> The cpu7 is single cpu:
>>>
>>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do done&
>>> [1] 4737
>>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # taskset -p 80 4737
>>> pid 4737's current affinity mask: ff
>>> pid 4737's new affinity mask: 80
>>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
>>> 2301000
>>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_cur_freq
>>> 2301000
>>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 > scaling_max_freq
>>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
>>> 2171000
>>>
>>> At this time, the sg_policy's next_freq would keep 2301000.
>>>
>>> To prevent the case happen, add the judgment of the need_freq_update flag.
>>>
>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>>> Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
>>> Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
>>> ---
>>>   kernel/sched/cpufreq_schedutil.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>> index 4492608b7d7f..458d359f5991 100644
>>> --- a/kernel/sched/cpufreq_schedutil.c
>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>> @@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>>>         * Except when the rq is capped by uclamp_max.
>>>         */
>>>        if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
>>> -         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
>>> +         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
>>> +         !sg_policy->need_freq_update) {
>>
>> What about sugov_update_single_perf()? It seems to have the same problem, no?
> 
> There is no problem in sugov_update_single_perf, because the next_freq
> is updated by drivers, maybe the next_freq is not used when using
> sugov_update_single_perf..
> 
> But  for the last_freq_update_time, I think there are some problems
> when using sugov_update_single_perf:
> Now, there is no judgment condition for the update of the
> last_freq_update_time. That means the last_freq_update_time is always
> updated in sugov_update_single_perf.
> And in sugov_should_update_freq: it would judge the
> freq_update_delay_ns. As a result, If we use the
> sugov_update_single_perf, the cpu frequency would only be periodically
> updated according to freq_update_delay_ns.
> Maybe we should judge the cpufreq_driver_adjust_perf's return value,
> if the freq is not updated, the last_freq_update_time also does not
> have to update.
> 
> Just like:
> ---
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 458d359f5991..10f18b054f01 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -381,6 +381,7 @@ static void sugov_update_single_perf(struct
> update_util_data *hook, u64 time,
>          struct sugov_cpu *sg_cpu = container_of(hook, struct
> sugov_cpu, update_util);
>          unsigned long prev_util = sg_cpu->util;
>          unsigned long max_cap;
> +       bool freq_updated;
> 
>          /*
>           * Fall back to the "frequency" path if frequency invariance is not
> @@ -407,10 +408,11 @@ static void sugov_update_single_perf(struct
> update_util_data *hook, u64 time,
>              sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
>                  sg_cpu->util = prev_util;
> 
> -       cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> +       freq_updated = cpufreq_driver_adjust_perf(sg_cpu->cpu,
> map_util_perf(sg_cpu->bw_dl),
>                                     map_util_perf(sg_cpu->util), max_cap);
> 
> -       sg_cpu->sg_policy->last_freq_update_time = time;
> +       if (freq_updated)
> +               sg_cpu->sg_policy->last_freq_update_time = time;
>   }
> 

Hello Xuewen,
FWIW, the patch and explanation for sugov_update_single_perf() seem sensible to
me. Just a comment about cpufreq_driver_adjust_perf() and
(struct cpufreq_driver)->adjust_perf(): wouldn't their prototype need to be
updated (i.e. not return void) to do the change suggested above ?

Regards,
Pierre

> 
> BR
> Thanks!
> 
> ---
> xuewen
>>
>> LGTM otherwise.
>>
>>
>> Cheers
>>
>> --
>> Qais Yousef
>>
>>>                next_f = sg_policy->next_freq;
>>>
>>>                /* Restore cached freq as next_freq has changed */
>>> --
>>> 2.25.1
>>>
> 
