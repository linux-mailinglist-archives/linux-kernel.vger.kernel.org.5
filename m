Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892CC7CFAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbjJSN2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345767AbjJSN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:28:05 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E92F115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697722079;
        bh=Z9L+1D2JVb2TUsnVn/selNOeUc20SWXPYg2qBqeWdfk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ns+yUv7Mlq/9bq8pHfctJiJtxXUy+i9gUi5piJsiFE6uGNDtbGyUUxwOyLup9I5z2
         4UFYKhW2NCUEuYKw4K8QsuSXpgp9LWMIa2snE1lGnI1AaOC1+0vmEO7BHxZChBMDSk
         7K3VvmrPK6rtEbOEjAeOXJ9xQmsWk5I2UaHdXKLgm6M7ZFsRdmTgx+MHiKJ6OlZLle
         mkGwI+/9xVhdpPPNKup0DN2bADKlws8pPewb50qlfzjSA1tgjHWKBN223X0oxtGoid
         QKKSqILy9nfg5erTW1Ytl/mBy2gQoU1t0i2VjmqJUpJiVSjnpAKBav9MO+zaaI1m6T
         i1kA0Sw2l9EiQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SB7nV74wFz1YRZ;
        Thu, 19 Oct 2023 09:27:58 -0400 (EDT)
Message-ID: <25e778e2-d91a-4f4d-9f6b-ff144eab3211@efficios.com>
Date:   Thu, 19 Oct 2023 09:28:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY feature
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231018204511.1563390-1-mathieu.desnoyers@efficios.com>
 <20231018204511.1563390-2-mathieu.desnoyers@efficios.com>
 <ZTEUjBgthYhz7NXm@chenyu5-mobl2.ccr.corp.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZTEUjBgthYhz7NXm@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-19 07:35, Chen Yu wrote:
> On 2023-10-18 at 16:45:10 -0400, Mathieu Desnoyers wrote:
>> Introduce the UTIL_FITS_CAPACITY scheduler feature. The runqueue
>> selection picks the previous, target, or recent runqueues if they have
>> enough remaining capacity to enqueue the task before scanning for an
>> idle cpu.
>>
>> This feature is introduced in preparation for the SELECT_BIAS_PREV
>> scheduler feature. Its performance benefits are noticeable when combined
>> with the SELECT_BIAS_PREV feature.
>>
>> The following benchmarks only cover the UTIL_FITS_CAPACITY feature.
>> Those are performed on a v6.5.5 kernel with mitigations=off.
>>
>> The following hackbench workload on a 192 cores AMD EPYC 9654 96-Core
>> Processor (over 2 sockets) keeps relatively the same wall time (49s).
>>
>> hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
>>
>> We can observe that the number of migrations is reduced significantly
>> with this patch (improvement):
>>
>> Baseline:      117M cpu-migrations  (9.355 K/sec)
>> With patch:     67M cpu-migrations  (5.470 K/sec)
>>
>> The task-clock utilization is reduced (degradation):
>>
>> Baseline:      253.275 CPUs utilized
>> With patch:    223.130 CPUs utilized
>>
>> The number of context-switches is increased (degradation):
>>
>> Baseline:      445M context-switches (35.516 K/sec)
>> With patch:    581M context-switches (47.548 K/sec)
>>
>> So the improvement due to reduction of migrations is countered by the
>> degradation in CPU utilization and context-switches. The following
>> SELECT_BIAS_PREV feature will address this.
>>
>> Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
>> Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
>> Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
>> Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
>> Link: https://lore.kernel.org/lkml/f6dc1652-bc39-0b12-4b6b-29a2f9cd8484@amd.com/
>> Link: https://lore.kernel.org/lkml/20230822113133.643238-1-mathieu.desnoyers@efficios.com/
>> Link: https://lore.kernel.org/lkml/20230823060832.454842-1-aaron.lu@intel.com/
>> Link: https://lore.kernel.org/lkml/20230905171105.1005672-1-mathieu.desnoyers@efficios.com/
>> Link: https://lore.kernel.org/lkml/cover.1695704179.git.yu.c.chen@intel.com/
>> Link: https://lore.kernel.org/lkml/20230929183350.239721-1-mathieu.desnoyers@efficios.com/
>> Link: https://lore.kernel.org/lkml/20231012203626.1298944-1-mathieu.desnoyers@efficios.com/
>> Link: https://lore.kernel.org/lkml/20231017221204.1535774-1-mathieu.desnoyers@efficios.com/
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
>> Cc: Aaron Lu <aaron.lu@intel.com>
>> Cc: Chen Yu <yu.c.chen@intel.com>
>> Cc: Tim Chen <tim.c.chen@intel.com>
>> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
>> Cc: Gautham R . Shenoy <gautham.shenoy@amd.com>
>> Cc: x86@kernel.org
>> ---
>>   kernel/sched/fair.c     | 49 ++++++++++++++++++++++++++++++++++++-----
>>   kernel/sched/features.h |  6 +++++
>>   kernel/sched/sched.h    |  5 +++++
>>   3 files changed, 54 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1d9c2482c5a3..8058058afb11 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4497,6 +4497,37 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>>   	trace_sched_util_est_se_tp(&p->se);
>>   }
>>   
>> +/*
>> + * Returns true if adding the task utilization to the estimated
>> + * utilization of the runnable tasks on @cpu does not exceed the
>> + * capacity of @cpu.
>> + *
>> + * This considers only the utilization of _runnable_ tasks on the @cpu
>> + * runqueue, excluding blocked and sleeping tasks. This is achieved by
>> + * using the runqueue util_est.enqueued, and by estimating the capacity
>> + * of @cpu based on arch_scale_cpu_capacity and arch_scale_thermal_pressure
>> + * rather than capacity_of() because capacity_of() considers
>> + * blocked/sleeping tasks in other scheduler classes.
>> + *
>> + * The utilization vs capacity comparison is done without the margin
>> + * provided by fits_capacity(), because fits_capacity() is used to
>> + * validate whether the utilization of a task fits within the overall
>> + * capacity of a cpu, whereas this function validates whether the task
>> + * utilization fits within the _remaining_ capacity of the cpu, which is
>> + * more precise.
>> + */
>> +static inline bool task_fits_remaining_cpu_capacity(unsigned long task_util,
>> +						    int cpu)
>> +{
>> +	unsigned long total_util, capacity;
>> +
>> +	if (!sched_util_fits_capacity_active())
>> +		return false;
>> +	total_util = READ_ONCE(cpu_rq(cpu)->cfs.avg.util_est.enqueued) + task_util;
>> +	capacity = arch_scale_cpu_capacity(cpu) - arch_scale_thermal_pressure(cpu);
> 
> scale_rt_capacity(cpu) could provide the remaining cpu capacity after substracted by
> the side activity(rt tasks/thermal pressure/irq time), maybe it would be more accurate?

AFAIU, scale_rt_capacity(cpu) works similarly to capacity_of(cpu) and 
considers blocked and sleeping tasks in the rq->avg_rt.util_avg and 
rq->avg_dl.util_avg. I'm not sure sure about rq->avg_irq.util_avg and 
thermal_load_avg().

This goes against what is needed here: we need a utilization that only 
considers enqueued runnable tasks (exluding blocked and sleeping tasks). 
Or am I missing something ?

> 
>> +	return total_util <= capacity;
>> +}
>> +
>>   static inline int util_fits_cpu(unsigned long util,
>>   				unsigned long uclamp_min,
>>   				unsigned long uclamp_max,
>> @@ -7124,12 +7155,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>   	int i, recent_used_cpu;
>>   
>>   	/*
>> -	 * On asymmetric system, update task utilization because we will check
>> -	 * that the task fits with cpu's capacity.
>> +	 * With the UTIL_FITS_CAPACITY feature and on asymmetric system,
>> +	 * update task utilization because we will check that the task
>> +	 * fits with cpu's capacity.
>>   	 */
>> -	if (sched_asym_cpucap_active()) {
>> +	if (sched_util_fits_capacity_active() || sched_asym_cpucap_active()) {
>>   		sync_entity_load_avg(&p->se);
>>   		task_util = task_util_est(p);
>> +	}
>> +	if (sched_asym_cpucap_active()) {
>>   		util_min = uclamp_eff_value(p, UCLAMP_MIN);
>>   		util_max = uclamp_eff_value(p, UCLAMP_MAX);
>>   	}
>> @@ -7139,7 +7173,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>   	 */
>>   	lockdep_assert_irqs_disabled();
>>   
>> -	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
>> +	if ((available_idle_cpu(target) || sched_idle_cpu(target) ||
>> +	    task_fits_remaining_cpu_capacity(task_util, target)) &&
> 
> Compared to the previous version posted here[1], when the cpu's util_est is lower than 25% of CPU
> capacity we choose the previous CPU, current version seems to be more aggressive.
> it is possible that a short running task is queued on the near 100% busy cpu while there
> is still an idle cpu in the system.
> 
> https://lore.kernel.org/lkml/20231017221204.1535774-1-mathieu.desnoyers@efficios.com/

This previous version had a somewhat arbitrary cutoff at 75% of util_est 
(25% spare capacity remaining). Yes, this new version is more 
aggressive, and indeed it does not keep room for inaccuracy of the 
util_est metric compared to real-life behavior of the task when it gets 
scheduled.

One option would be to change the comparison in 
task_fits_remaining_cpu_capacity() as follows:

-       return total_util <= capacity;
+       return fits_capacity(total_util, capacity);

"fits_capacity()" includes a 20% unused margin. Using this, the 
benchmark goes from 26s to 29s, which is not the end of the world, and 
would keep room for metric inaccuracy.

Thoughts ?

Thanks,

Mathieu

> 
> thanks,
> Chenyu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

