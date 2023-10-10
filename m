Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AAA7BFEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjJJOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjJJOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:18:17 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787059E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1696947494;
        bh=pDq4qxRg+JDKbt6A3zg3sl0h9OYtvpHQpRjhoQVHgkQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wBzhrcLRPhk/lO3OMIM9xksoJjNax5xHGK80gEk9VMgotNspH3CfL8aAgiBY/tuG5
         OpBrORnHPP54j7Yamd+U8yv1W4HUiNshmI3SiexNhDRxPWvzUpz7AhwGVxeTCLi6ip
         qxcUhVaBq7FQRnfM7GST3ws4aKRptKvawTSSGIUbZ7EDuuevbFM7OywsuxcdAv1czb
         z+48k7vSC2Dpmv33SjNOP9g6p6+MLqIbvRUKOJkWHeBF1HDkgtJ7mdADrhnqwH/AAO
         O5VM+LgNj0E2mwZ9KJk6z9BaT10bHQJ0eIrJsHAQ8m7CCbSY9cFqsy8srlOcz6TCyC
         CkvjoovbPyJjA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4S4dKf2Gvhz1XBF;
        Tue, 10 Oct 2023 10:18:14 -0400 (EDT)
Message-ID: <54d3a982-86e2-4317-a08f-a4eec0374227@efficios.com>
Date:   Tue, 10 Oct 2023 10:18:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/fair: Bias runqueue selection towards almost
 idle prev CPU
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
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
 <ZSORUczD6tp2fbe7@chenyu5-mobl2.ccr.corp.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZSORUczD6tp2fbe7@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-09 01:36, Chen Yu wrote:
> On 2023-09-30 at 07:45:38 -0400, Mathieu Desnoyers wrote:
>> On 9/30/23 03:11, Chen Yu wrote:
>>> Hi Mathieu,
>>>
>>> On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
>>>> Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
>>>> select_task_rq towards the previous CPU if it was almost idle
>>>> (avg_load <= 0.1%).
>>>
>>> Yes, this is a promising direction IMO. One question is that,
>>> can cfs_rq->avg.load_avg be used for percentage comparison?
>>> If I understand correctly, load_avg reflects that more than
>>> 1 tasks could have been running this runqueue, and the
>>> load_avg is the direct proportion to the load_weight of that
>>> cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
>>> that load_avg can reach, it is the sum of
>>> 1024 * (y + y^1 + y^2 ... )
>>>
>>> For example,
>>> taskset -c 1 nice -n -20 stress -c 1
>>> cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
>>>     .load_avg                      : 88763
>>>     .load_avg                      : 1024
>>>
>>> 88763 is higher than LOAD_AVG_MAX=47742
>>
>> I would have expected the load_avg to be limited to LOAD_AVG_MAX somehow,
>> but it appears that it does not happen in practice.
>>
>> That being said, if the cutoff is really at 0.1% or 0.2% of the real max,
>> does it really matter ?
>>
>>> Maybe the util_avg can be used for precentage comparison I suppose?
>> [...]
>>> Or
>>> return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?
>>
>> Unfortunately using util_avg does not seem to work based on my testing.
>> Even at utilization thresholds at 0.1%, 1% and 10%.
>>
>> Based on comments in fair.c:
>>
>>   * CPU utilization is the sum of running time of runnable tasks plus the
>>   * recent utilization of currently non-runnable tasks on that CPU.
>>
>> I think we don't want to include currently non-runnable tasks in the
>> statistics we use, because we are trying to figure out if the cpu is a
>> idle-enough target based on the tasks which are currently running, for the
>> purpose of runqueue selection when waking up a task which is considered at
>> that point in time a non-runnable task on that cpu, and which is about to
>> become runnable again.
>>
>>
> 
> Based on the discussion, another effort to inhit task migration is to make
> WA_BIAS prefers previous CPU rather than the current CPU. However it did not
> show much difference with/without this change applied. I think this is because
> although wake_affine_weight() chooses the previous CPU, in select_idle_sibling()
> it would still prefer the current CPU to the previous CPU if no idle CPU is detected.
> Based on this I did the following changes in select_idle_sibling():
> 
> 1. When the system is underloaded, change the sequence of idle CPU checking.
>     If both the target and previous CPU are idle, choose previous CPU first.

Are you suggesting that the patch below be used in combination with my 
"almost_idle" approach, or as a replacement ?

I've tried my workload with only your patch, and the performances were 
close to the baseline (bad). With both patches combined, the 
performances are as good as with my almost_idle patch. This workload on 
my test machine has cpus at about 50% idle with the baseline.

> 
> 2. When the system is overloaded, and all CPUs are busy, choose the previous
>     CPU over the target CPU.
> 
> hackbench -g 16 -f 20 -l 480000 -s 100
> 
> Before the patch:
> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> Each sender will pass 480000 messages of 100 bytes
> Time: 81.076
> 
> After the patch:
> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> Each sender will pass 480000 messages of 100 bytes
> Time: 77.527
> 
> track the task migration count in 10 seconds:
> kretfunc:select_task_rq_fair
> {
>          $p = (struct task_struct *)args->p;
>          if ($p->comm == "hackbench") {
>                  if ($p->thread_info.cpu == retval) {
>                          @wakeup_prev = count();
>                  } else if (retval == cpu) {
>                          @wakeup_curr = count();
>                  } else {
>                          @wakeup_migrate = count();
>                  }
>          }
> }
> 
> Before the patch:
> @wakeup_prev: 8369160
> @wakeup_curr: 3624480
> @wakeup_migrate: 523936
> 
> After the patch
> @wakeup_prev: 15465952
> @wakeup_curr: 214540
> @wakeup_migrate: 65020
> 
> The percentage of wakeup on previous CPU has been increased from
> 8369160 / (8369160 + 3624480 + 523936) = 66.85% to
> 15465952 / (15465952 + 214540 + 65020) = 98.22%.

Those results are interesting. I wonder if this change negatively 
affects other workloads though.

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e2a69af8be36..9131cb359723 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7264,18 +7264,20 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	 */
>   	lockdep_assert_irqs_disabled();
>   
> -	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> -	    asym_fits_cpu(task_util, util_min, util_max, target))
> -		return target;
> -
>   	/*
>   	 * If the previous CPU is cache affine and idle, don't be stupid:
> +	 * The previous CPU is checked prio to the target CPU to inhibit

prio -> prior

Thanks,

Mathieu

> +	 * costly task migration.
>   	 */
>   	if (prev != target && cpus_share_cache(prev, target) &&
>   	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>   	    asym_fits_cpu(task_util, util_min, util_max, prev))
>   		return prev;
>   
> +	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> +	    asym_fits_cpu(task_util, util_min, util_max, target))
> +		return target;
> +
>   	/*
>   	 * Allow a per-cpu kthread to stack with the wakee if the
>   	 * kworker thread and the tasks previous CPUs are the same.
> @@ -7342,6 +7344,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	if ((unsigned)i < nr_cpumask_bits)
>   		return i;
>   
> +	 /* if all CPUs are busy, prefer previous CPU to inhibit migration */
> +	if (prev != target && cpus_share_cache(prev, target))
> +		return prev;
> +
>   	return target;
>   }
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

