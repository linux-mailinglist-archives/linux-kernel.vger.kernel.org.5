Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF37BFE66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjJJNt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjJJNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:49:55 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED07E91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1696945790;
        bh=eAfyGGfJOuVrL8HicEi18Nqp3PFUp8dPfG7VSb+fiUE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s4ES6kyL/RDaZnGzHQnxo6HgvKhsZnNoQ319amA4QBOeAXyiJGVW14ufftsqA+1co
         aq5J/Bwu1e1Pn2pp33KQBECCYXiKRj7mDUoDk133cl+qkLNDWuCyQOatGdO4T0ELvY
         gJJuVn559t90epc8w9xWFa3kxr+oPpFiAUc7uiZkHG/pQKc1g5H05V4Iy/y0XAcse4
         hczuMu5iDcj8gIbrvFRTe6SlNJSIHLutXDsfoxssYOD4RkU2t+WnzMkE7v0LaGOTn9
         8TpMYnPaU+VgZiDkJUqipbkuJFOc1Vcglb4L1mMqYpBLlLMBPVL0rovNw+0WfPt3DJ
         Hkk3WLAwNaiAQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4S4cht4XxXz1X0Q;
        Tue, 10 Oct 2023 09:49:50 -0400 (EDT)
Message-ID: <ebe4e40f-37df-40a9-9dfc-7f2a458151bd@efficios.com>
Date:   Tue, 10 Oct 2023 09:49:54 -0400
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
 <ZSOMOhhkPIFmvz97@chenyu5-mobl2.ccr.corp.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZSOMOhhkPIFmvz97@chenyu5-mobl2.ccr.corp.intel.com>
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

On 2023-10-09 01:14, Chen Yu wrote:
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
> 
> Although LOAD_AVG_MAX is not the max possible load_avg, we still want to find
> a proper threshold to decide if the CPU is almost idle. The LOAD_AVG_MAX
> based threshold is modified a little bit:
> 
> The theory is, if there is only 1 task on the CPU, and that task has a nice
> of 0, the task runs 50 us every 1000 us, then this CPU is regarded as almost
> idle.
> 
> The load_sum of the task is:
> 50 * (1 + y + y^2 + ... + y^n)
> The corresponding avg_load of the task is approximately
> NICE_0_WEIGHT * load_sum / LOAD_AVG_MAX = 50.
> So:
> 
> /* which is close to LOAD_AVG_MAX/1000 = 47 */
> #define ALMOST_IDLE_CPU_LOAD   50

Sorry to be slow at understanding this concept, but this whole "load" 
value is still somewhat magic to me.

Should it vary based on CONFIG_HZ_{100,250,300,1000}, or is it 
independent ? Where is it documented that the load is a value in "us" 
out of a window of 1000 us ?

And with this value "50", it would cover the case where there is only a 
single task taking less than 50us per 1000us, and cases where the sum 
for the set of tasks on the runqueue is taking less than 50us per 1000us 
overall.

> 
> static bool
> almost_idle_cpu(int cpu, struct task_struct *p)
> {
>         if (!sched_feat(WAKEUP_BIAS_PREV_IDLE))
>                 return false;
>         return cpu_load_without(cpu_rq(cpu), p) <= ALMOST_IDLE_CPU_LOAD;
> }
> 
> Tested this on Intel Xeon Platinum 8360Y, Ice Lake server, 36 core/package,
> total 72 core/144 CPUs. Slight improvement is observed in hackbench socket mode:
> 
> socket mode:
> hackbench -g 16 -f 20 -l 480000 -s 100
> 
> Before patch:
> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> Each sender will pass 480000 messages of 100 bytes
> Time: 81.084
> 
> After patch:
> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> Each sender will pass 480000 messages of 100 bytes
> Time: 78.083
> 
> 
> pipe mode:
> hackbench -g 16 -f 20 --pipe  -l 480000 -s 100
> 
> Before patch:
> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> Each sender will pass 480000 messages of 100 bytes
> Time: 38.219
> 
> After patch:
> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> Each sender will pass 480000 messages of 100 bytes
> Time: 38.348
> 
> It suggests that, if the workload has larger working-set/cache footprint, waking up
> the task on its previous CPU could get more benefit.

In those tests, what is the average % of idleness of your cpus ?

Thanks,

Mathieu

> 
> thanks,
> Chenyu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

