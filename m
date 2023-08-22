Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83A8783B16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjHVHme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjHVHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:42:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1748113
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:42:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FEF011FB;
        Tue, 22 Aug 2023 00:43:10 -0700 (PDT)
Received: from [10.57.90.190] (unknown [10.57.90.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4656B3F64C;
        Tue, 22 Aug 2023 00:42:27 -0700 (PDT)
Message-ID: <a82523ae-c09a-dc3e-f966-485ad89c2b97@arm.com>
Date:   Tue, 22 Aug 2023 08:43:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] sched/tp: Add new tracepoint to track compute
 energy computation
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20230717215717.309174-1-qyousef@layalina.io>
 <20230717215717.309174-4-qyousef@layalina.io>
 <0491f666-0995-357c-0905-6c9863ee9c9f@arm.com>
 <20230821223649.aixoldq3udm2jw6t@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230821223649.aixoldq3udm2jw6t@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 23:36, Qais Yousef wrote:
> Hi Lukasz
> 
> On 08/21/23 10:04, Lukasz Luba wrote:
>> Hi Qais,
>>
>> On 7/17/23 22:57, Qais Yousef wrote:
>>> It was useful to track feec() placement decision and debug the spare
>>> capacity and optimization issues vs uclamp_max.
>>>
>>> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
>>> ---
>>>    include/trace/events/sched.h | 4 ++++
>>>    kernel/sched/core.c          | 1 +
>>>    kernel/sched/fair.c          | 7 ++++++-
>>>    3 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>>> index fbb99a61f714..20cc884f72ff 100644
>>> --- a/include/trace/events/sched.h
>>> +++ b/include/trace/events/sched.h
>>> @@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
>>>    	TP_PROTO(struct rq *rq, int change),
>>>    	TP_ARGS(rq, change));
>>> +DECLARE_TRACE(sched_compute_energy_tp,
>>> +	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy),
>>> +	TP_ARGS(p, dst_cpu, energy));
>>> +
>>>    #endif /* _TRACE_SCHED_H */
>>>    /* This part must be outside protection */
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 83e36547af17..2deca2dca625 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>>>    EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>>>    EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>>>    EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>>> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>>>    DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index c701f490ca4c..23e026393210 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -7493,11 +7493,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
>>>    {
>>>    	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
>>>    	unsigned long busy_time = eenv->pd_busy_time;
>>> +	unsigned long energy;
>>>    	if (dst_cpu >= 0)
>>>    		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
>>> -	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
>>> +	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
>>> +
>>> +	trace_sched_compute_energy_tp(p, dst_cpu, energy);
>>
>> You've probably missed to add the change that we discussed in v2:
>>
>> https://lore.kernel.org/lkml/20230221120832.x642tqohxv5nascr@airbuntu/
>>
>> The max_util and busy_time. This would help us in our tool.
> 
> Ah, I did indeed. Sorry about that. Will send v4 then.

Thanks Qais!
