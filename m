Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1314763855
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjGZOGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGZOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:06:48 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B599211F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1690380403;
        bh=wRb0WEVgqXpXeU+WbFQ1+WXns6gURJtIo6sThDwsDsE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PhpC3EDS/ZghKNgrgkVWCx9xeXTrrUAL5Yu+YHCQdmua22KQ0S2X4syHVgHVUat+Y
         T/LiTf5h/2vuXndQRWEaNIxFBMZQs9mRlrSk5llMoKNHjc4Xjv99JsGc1hOt9bx03u
         BSchp0Xt1TzScbwGq/VsDgbjs+Kqb7toznVSzbL9xL+1RasFonFm4VVD6aEWcNheKP
         Aj7FOS16fxKh3QhutDxFzWBT10NNNsS20/yG0SCMmyPmiHHxWsHBSimWGZxAkN79FN
         D8KWw6noCJwlmXZlFVqZ/4+U5rhlXM3gMgzKpZAEiOQwQSEBzqClleF2l7RXuTyTNG
         1tMtPGVTN3QvA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4R9wgQ65KVz1Jjq;
        Wed, 26 Jul 2023 10:06:42 -0400 (EDT)
Message-ID: <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
Date:   Wed, 26 Jul 2023 10:07:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Content-Language: en-US
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 04:04, Shrikanth Hegde wrote:
> 
> 
> On 7/26/23 1:00 AM, Mathieu Desnoyers wrote:
>> Allow select_task_rq to consider a cpu as idle for 1ms after that cpu
>> has exited the idle loop.
>>
>> This speeds up the following hackbench workload on a 192 cores AMD EPYC
>> 9654 96-Core Processor (over 2 sockets):
>>
>> hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
>>
>> from 49s to 34s. (30% speedup)
>>
>> My working hypothesis for why this helps is: queuing more than a single
>> task on the runqueue of a cpu which just exited idle rather than
>> spreading work over other idle cpus helps power efficiency on systems
>> with large number of cores.
>>
>> This was developed as part of the investigation into a weird regression
>> reported by AMD where adding a raw spinlock in the scheduler context
>> switch accelerated hackbench.
>>
>> It turned out that changing this raw spinlock for a loop of 10000x
>> cpu_relax within do_idle() had similar benefits.
>>
>> This patch achieve a similar effect without the busy-waiting by
>> introducing a runqueue state sampling the sched_clock() when exiting
>> idle, which allows select_task_rq to consider "as idle" a cpu which has
>> recently exited idle.
>>
>> This patch should be considered "food for thoughts", and I would be glad
>> to hear feedback on whether it causes regressions on _other_ workloads,
>> and whether it helps with the hackbench workload on large Intel system
>> as well.
>>
>> Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
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
>> Cc: x86@kernel.org
>> ---
>>   kernel/sched/core.c  | 4 ++++
>>   kernel/sched/sched.h | 3 +++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a68d1276bab0..d40e3a0a5ced 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6769,6 +6769,7 @@ void __sched schedule_idle(void)
>>   	 * TASK_RUNNING state.
>>   	 */
>>   	WARN_ON_ONCE(current->__state);
>> +	WRITE_ONCE(this_rq()->idle_end_time, sched_clock());
>>   	do {
>>   		__schedule(SM_NONE);
>>   	} while (need_resched());
>> @@ -7300,6 +7301,9 @@ int idle_cpu(int cpu)
>>   {
>>   	struct rq *rq = cpu_rq(cpu);
>>   
>> +	if (sched_clock() < READ_ONCE(rq->idle_end_time) + IDLE_CPU_DELAY_NS)
> 
> 
> Wouldn't this hurt the latency badly? Specially on a loaded system with
> a workload that does a lot of wakeup.

Good point !

Can you try your benchmark replacing the if () statement above by:

+       if (sched_clock() < READ_ONCE(rq->idle_end_time) + IDLE_CPU_DELAY_NS &&
+           READ_ONCE(rq->nr_running) <= 4)
+               return 1;

It speeds up the hackbench test-case even more here. It's now 30s, and it should
improve tail latency.

Thanks,

Mathieu


> 
> ran schbench on a 50% loaded system with stress-ng. (there could be a better benchmark to measure latency)
> I see that latency takes a hit. specially tail latencies.full log below with different schbench groups.
> 
> 		     6.5-rc3		6.5-rc3+this patch
> 
> Groups: 1
> 50.0th:                 14.0              13.0
> 75.0th:                 16.0              16.0
> 90.0th:                 19.5              20.0
> 95.0th:                 53.0              226.0
> 99.0th:                 1969.0            2165.0
> 99.5th:                 2912.0            2648.0
> 99.9th:                 4680.0            4142.0
> 
> Groups: 2
> 50.0th:                 15.5              15.5
> 75.0th:                 18.0              19.5
> 90.0th:                 25.5              497.0
> 95.0th:                 323.0             1384.0
> 99.0th:                 2055.0            3144.0
> 99.5th:                 2972.0            4014.0
> 99.9th:                 6026.0            6560.0
> 
> Groups: 4
> 50.0th:                 18.0              18.5
> 75.0th:                 21.5              26.0
> 90.0th:                 56.0              940.5
> 95.0th:                 678.0             1896.0
> 99.0th:                 2484.0            3756.0
> 99.5th:                 3224.0            4616.0
> 99.9th:                 4960.0            6824.0
> 
> Groups: 8
> 50.0th:                 23.5              25.5
> 75.0th:                 30.5              421.5
> 90.0th:                 443.5             1722.0
> 95.0th:                 1410.0            2736.0
> 99.0th:                 3942.0            5496.0
> 99.5th:                 5232.0            7016.0
> 99.9th:                 7996.0            8896.0
> 
> Groups: 16
> 50.0th:                 33.5              41.5
> 75.0th:                 49.0              752.0
> 90.0th:                 1067.5            2332.0
> 95.0th:                 2093.0            3468.0
> 99.0th:                 5048.0            6728.0
> 99.5th:                 6760.0            7624.0
> 99.9th:                 8592.0            9504.0
> 
> Groups: 32
> 50.0th:                 60.0              79.0
> 75.0th:                 456.5             1712.0
> 90.0th:                 2788.0            3996.0
> 95.0th:                 4544.0            5768.0
> 99.0th:                 8444.0            9104.0
> 99.5th:                 9168.0            9808.0
> 99.9th:                 11984.0           12448.0
> 
> 
>> +		return 1;
>> +
>>   	if (rq->curr != rq->idle)
>>   		return 0;
>>   
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 81ac605b9cd5..8932e198a33a 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -97,6 +97,8 @@
>>   # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
>>   #endif
>>   
>> +#define IDLE_CPU_DELAY_NS	1000000		/* 1ms */
>> +
>>   struct rq;
>>   struct cpuidle_state;
>>   
>> @@ -1010,6 +1012,7 @@ struct rq {
>>   
>>   	struct task_struct __rcu	*curr;
>>   	struct task_struct	*idle;
>> +	u64			idle_end_time;
>>   	struct task_struct	*stop;
>>   	unsigned long		next_balance;
>>   	struct mm_struct	*prev_mm;

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

