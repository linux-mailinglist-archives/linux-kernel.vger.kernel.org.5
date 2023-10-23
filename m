Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C267D3A58
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjJWPEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjJWPEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:04:43 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA210E2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698073475;
        bh=sDRdFc5BSFXVvCn+U20zgOqgig9pshAjBSzon0L8ejg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JKe8XE5uQdUmcZRiPXBh6E0nCm7tDivCEs8ciX3zmC8j6iE6MK9m9HP23/u9r9L8s
         i1iki/byqqXZuyaOGyIS/PT0kq7N9jcgPG+Ed8JZbDOXZmTZ0umiEINq83PdXSv4Cc
         Sr8We8rVUQaLkKhnNO53dwnCMUwGnndeW+u2JseAIHMJR4IyvAaoqswZPuc/vGu3FN
         Bd9LEn2Tc61G5sKBqjEKQIKqWX918rFC3ebrbeYzvjIjT2Tmqb2+zlv4fWOM0VQgJb
         +Y7fyfSAoU5JQ2blarpxP1ZcVEZYBqEL2F1ACfFziPJAfXv+8HV+0nzyw2PDTk9Jge
         fCV8Le3PNdKnQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SDdl70Tb2z1YjT;
        Mon, 23 Oct 2023 11:04:35 -0400 (EDT)
Message-ID: <c79ac631-61c7-4953-a657-74047a264029@efficios.com>
Date:   Mon, 23 Oct 2023 11:04:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY
 feature (v2)
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
 <f40522de-b71d-4848-8aa3-5b87d38bb847@arm.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <f40522de-b71d-4848-8aa3-5b87d38bb847@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-23 10:11, Dietmar Eggemann wrote:
> On 19/10/2023 18:05, Mathieu Desnoyers wrote:

[...]
>>   
>> +static unsigned long scale_rt_capacity(int cpu);
>> +
>> +/*
>> + * Returns true if adding the task utilization to the estimated
>> + * utilization of the runnable tasks on @cpu does not exceed the
>> + * capacity of @cpu.
>> + *
>> + * This considers only the utilization of _runnable_ tasks on the @cpu
>> + * runqueue, excluding blocked and sleeping tasks. This is achieved by
>> + * using the runqueue util_est.enqueued.
>> + */
>> +static inline bool task_fits_remaining_cpu_capacity(unsigned long task_util,
>> +						    int cpu)
> 
> This is almost like the existing task_fits_cpu(p, cpu) (used in Capacity
> Aware Scheduling (CAS) for Asymmetric CPU capacity systems) except the
> latter only uses `util = task_util_est(p)` and deals with uclamp as well
> and only tests whether p could fit on the CPU.

This is indeed a major difference between how asym capacity check works 
and what is introduced here:

asym capacity check only checks whether the given task theoretically 
fits in the cpu if that cpu was completely idle, without considering the 
current cpu utilization.

My approach is to consider the current util_est of the cpu to check 
whether the task fits in the remaining capacity.

I did not want to use the existing task_fits_cpu() helper because the 
notions of uclamp bounds appear to be heavily tied to the fact that it 
checks whether the task fits in an _idle_ runqueue, whereas the check I 
am introducing here is much more restrictive: it checks that the task 
fits on the runqueue within the remaining capacity.

> 
> Or like find_energy_efficient_cpu() (feec(), used in
> Energy-Aware-Scheduling (EAS)) which uses cpu_util(cpu, p, cpu, 0) to get:
> 
>    max(util_avg(CPU + p), util_est(CPU + p))

I've tried using cpu_util(), but unfortunately anything that considers 
blocked/sleeping tasks in its utilization total does not work for my 
use-case.

 From cpu_util():

  * CPU utilization is the sum of running time of runnable tasks plus the
  * recent utilization of currently non-runnable tasks on that CPU.

> 
> feec()
>      ...
>      for (; pd; pd = pd->next)
>          ...
>          util = cpu_util(cpu, p, cpu, 0);
>          ...
>          fits = util_fits_cpu(util, util_min, util_max, cpu)
>                                     ^^^^^^^^^^^^^^^^^^
>                                    not used when uclamp is not active (1)
>              ...
>              capacity = capacity_of(cpu)
>              fits = fits_capacity(util, capacity)
>              if (!uclamp_is_used()) (1)
>                  return fits
> 
> So not introducing new functions like task_fits_remaining_cpu_capacity()
> in this area and using existing one would be good.

If the notion of uclamp is not tied to the way asym capacity check is 
done against a theoretically idle runqueue, I'd be OK with using this, 
but so far both appear to be very much tied.

When I stumbled on this fundamental difference between asym cpu capacity 
check and the check introduced here, I've started wondering whether the 
asym cpu capacity check would benefit from considering the target cpu 
current utilization as well.

> 
>> +{
>> +	unsigned long total_util;
>> +
>> +	if (!sched_util_fits_capacity_active())
>> +		return false;
>> +	total_util = READ_ONCE(cpu_rq(cpu)->cfs.avg.util_est.enqueued) + task_util;
>> +	return fits_capacity(total_util, scale_rt_capacity(cpu));
> 
> Why not use:
> 
> static unsigned long capacity_of(int cpu)
>      return cpu_rq(cpu)->cpu_capacity;
> 
> which is maintained in update_cpu_capacity() as scale_rt_capacity(cpu)?

The reason for preferring scale_rt_capacity(cpu) over capacity_of(cpu) 
is that update_cpu_capacity() only runs periodically every 
balance-interval, therefore providing a coarse-grained remaining 
capacity approximation with respect to irq, rt, dl, and thermal utilization.

If it turns out that being coarse-grained is good enough, we may be able 
to save some cycles by using capacity_of(), but not without carefully 
considering the impacts of being imprecise.

> 
> [...]
> 
>> @@ -7173,7 +7200,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>   	if (recent_used_cpu != prev &&
>>   	    recent_used_cpu != target &&
>>   	    cpus_share_cache(recent_used_cpu, target) &&
>> -	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>> +	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu) ||
>> +	    task_fits_remaining_cpu_capacity(task_util, recent_used_cpu)) &&
>>   	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
>>   	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
>>   		return recent_used_cpu;
>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>> index ee7f23c76bd3..9a84a1401123 100644
>> --- a/kernel/sched/features.h
>> +++ b/kernel/sched/features.h
>> @@ -97,6 +97,12 @@ SCHED_FEAT(WA_BIAS, true)
>>   SCHED_FEAT(UTIL_EST, true)
>>   SCHED_FEAT(UTIL_EST_FASTUP, true)
> 
> IMHO, asymmetric CPU capacity systems would have to disable the sched
> feature UTIL_FITS_CAPACITY. Otherwise CAS could deliver different
> results. task_fits_remaining_cpu_capacity() and asym_fits_cpu() work
> slightly different.

I don't think they should be mutually exclusive. We should look into the 
differences between those two more closely to make them work nicely 
together instead. For instance, why does asym capacity only consider 
whether tasks fit in a theoretically idle runqueue, when it could use 
the current utilization of the runqueue to check that the task fits in 
the remaining capacity ?

Unfortunately I don't have a machine with asym cpu to test locally.

Thanks for your feedback !

Mathieu


> 
> [...]
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

