Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F153B763F14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGZSzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjGZSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:55:41 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF22720
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1690397731;
        bh=GoAWwHa/TyZ/4FOOmKYbnXSi58WIxY4Ka+P9O0yMH+E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S6S5IXH9NmKzROLRovAketUjf89cg1ZfVd/go/bWKjYYzm3u2fJ+tdFhoLEKH/sDK
         /CyJ/ZeOAO2b5XxsXrURuNzf6VOfKiEPJFLy88zyR4MI6/8jQan3ZuDqzU+sp3a2Mi
         XdldMYoLglWNZFdc5kaMjhWRFOOKc58JSo2GvadEjcunvjhZda/KE3D7t75+0lIKrq
         2W2wPHX98wStavLU6u9QP+nqV5pBoBehjnnz1PTBUzrIpt7pyGAPcSBOtbo8yCTM3M
         agGHYeZPVIM7LoBuqHzuetVK1XP+RIVxLzzbC9yEYn4hJ59K3e025+YrkzjvvR8ng+
         KRFMT+UjngWzA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RB34g3jX4z1K6L;
        Wed, 26 Jul 2023 14:55:31 -0400 (EDT)
Message-ID: <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
Date:   Wed, 26 Jul 2023 14:56:19 -0400
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
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
 <cab82676-27fd-b4e1-2cd8-3d8d26b44aa0@linux.vnet.ibm.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <cab82676-27fd-b4e1-2cd8-3d8d26b44aa0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 13:40, Shrikanth Hegde wrote:
> 
> 
> On 7/26/23 7:37 PM, Mathieu Desnoyers wrote:
>> On 7/26/23 04:04, Shrikanth Hegde wrote:
>>>
>>>
>>> On 7/26/23 1:00 AM, Mathieu Desnoyers wrote:
>>>> Allow select_task_rq to consider a cpu as idle for 1ms after that cpu
>>>> has exited the idle loop.
>>>>
>>>> This speeds up the following hackbench workload on a 192 cores AMD EPYC
>>>> 9654 96-Core Processor (over 2 sockets):
>>>>
>>>> hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
>>>>
>>>> from 49s to 34s. (30% speedup)
>>>>
>>>> My working hypothesis for why this helps is: queuing more than a single
>>>> task on the runqueue of a cpu which just exited idle rather than
>>>> spreading work over other idle cpus helps power efficiency on systems
>>>> with large number of cores.
>>>>
>>>> This was developed as part of the investigation into a weird regression
>>>> reported by AMD where adding a raw spinlock in the scheduler context
>>>> switch accelerated hackbench.
> 
> Do you have SMT here? What is the system utilization when you are running
> this workload?

Yes, SMT is enabled, which brings the number of logical cpus to 384.

CPU utilization (through htop):

* 6.4.4:                                           27500%
* 6.4.4 with the extend-idle+nr_running<=4 patch:  30500%

> 
>>>>
>>>> It turned out that changing this raw spinlock for a loop of 10000x
>>>> cpu_relax within do_idle() had similar benefits.
>>>>
>>>> This patch achieve a similar effect without the busy-waiting by
>>>> introducing a runqueue state sampling the sched_clock() when exiting
>>>> idle, which allows select_task_rq to consider "as idle" a cpu which has
>>>> recently exited idle.
>>>>
>>>> This patch should be considered "food for thoughts", and I would be glad
>>>> to hear feedback on whether it causes regressions on _other_ workloads,
>>>> and whether it helps with the hackbench workload on large Intel system
>>>> as well.
>>>>
>>>> Link:
>>>> https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Valentin Schneider <vschneid@redhat.com>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Ben Segall <bsegall@google.com>
>>>> Cc: Mel Gorman <mgorman@suse.de>
>>>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>>> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
>>>> Cc: Aaron Lu <aaron.lu@intel.com>
>>>> Cc: x86@kernel.org
>>>> ---
>>>>    kernel/sched/core.c  | 4 ++++
>>>>    kernel/sched/sched.h | 3 +++
>>>>    2 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index a68d1276bab0..d40e3a0a5ced 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -6769,6 +6769,7 @@ void __sched schedule_idle(void)
>>>>         * TASK_RUNNING state.
>>>>         */
>>>>        WARN_ON_ONCE(current->__state);
>>>> +    WRITE_ONCE(this_rq()->idle_end_time, sched_clock());
>>>>        do {
>>>>            __schedule(SM_NONE);
>>>>        } while (need_resched());
>>>> @@ -7300,6 +7301,9 @@ int idle_cpu(int cpu)
>>>>    {
>>>>        struct rq *rq = cpu_rq(cpu);
>>>>    +    if (sched_clock() < READ_ONCE(rq->idle_end_time) +
>>>> IDLE_CPU_DELAY_NS)
>>>
>>>
>>> Wouldn't this hurt the latency badly? Specially on a loaded system with
>>> a workload that does a lot of wakeup.
>>
>> Good point !
>>
>> Can you try your benchmark replacing the if () statement above by:
>>
>> +       if (sched_clock() < READ_ONCE(rq->idle_end_time) +
>> IDLE_CPU_DELAY_NS &&
>> +           READ_ONCE(rq->nr_running) <= 4)
>> +               return 1;
> 
> 
> Tried with this change. I think it does help in reducing latency compared to
> earlier specially till 95th percentile.

For the records, I also tried with nr_running <= 2 and still had decent performance
(32s with nr_running <= 2 instead of 30s for nr_running <= 4). It did drop with
nr_running <= 1 (40s). nr_running <= 5 was similar to 4, and performances start
degrading with nr_running <= 8 (31s).

So it might be interesting to measure the latency with nr_running <= 2 as well.
Perhaps nr_running <= 2 would be a good compromise between throughput and tail
latency.

>                                                                                  
>                  6.5-rc3      6.5-rc3+RFC_Patch     6.5-rc3_RFC_Patch
>                                                       + nr<4
> 4 Groups
> 50.0th:          18.00                18.50           18.50
> 75.0th:          21.50                26.00           23.50
> 90.0th:          56.00                940.50          501.00
> 95.0th:          678.00               1896.00         1392.00
> 99.0th:          2484.00              3756.00         3708.00
> 99.5th:          3224.00              4616.00         5088.00
> 99.9th:          4960.00              6824.00         8068.00
> 8 Groups
> 50.0th:          23.50                25.50           23.00
> 75.0th:          30.50                421.50          30.50
> 90.0th:          443.50               1722.00         741.00
> 95.0th:          1410.00              2736.00         1670.00
> 99.0th:          3942.00              5496.00         4032.00
> 99.5th:          5232.00              7016.00         5064.00
> 99.9th:          7996.00              8896.00         8012.00
> 16 Groups
> 50.0th:          33.50                41.50           32.50
> 75.0th:          49.00                752.00          47.00
> 90.0th:          1067.50              2332.00         994.50
> 95.0th:          2093.00              3468.00         2117.00
> 99.0th:          5048.00              6728.00         5568.00
> 99.5th:          6760.00              7624.00         6960.00
> 99.9th:          8592.00              9504.00         11104.00
> 32 Groups
> 50.0th:          60.00                79.00           53.00
> 75.0th:          456.50               1712.00         209.50
> 90.0th:          2788.00              3996.00         2752.00
> 95.0th:          4544.00              5768.00         5024.00
> 99.0th:          8444.00              9104.00         10352.00
> 99.5th:          9168.00              9808.00         12720.00
> 99.9th:          11984.00             12448.00        17624.00

[...]

>>>>    @@ -1010,6 +1012,7 @@ struct rq {
>>>>          struct task_struct __rcu    *curr;
>>>>        struct task_struct    *idle;
>>>> +    u64            idle_end_time;
> 
> There is clock_idle already in the rq. Can that be used for the same?

Good point! And I'll change my use of "sched_clock()" in idle_cpu() for a
proper "sched_clock_cpu(cpu_of(rq))", which will work better on systems
without constant tsc.

The updated patch:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..1c7d5bd2968b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7300,6 +7300,10 @@ int idle_cpu(int cpu)
  {
  	struct rq *rq = cpu_rq(cpu);
  
+	if (READ_ONCE(rq->nr_running) <= IDLE_CPU_DELAY_MAX_RUNNING &&
+	    sched_clock_cpu(cpu_of(rq)) < READ_ONCE(rq->clock_idle) + IDLE_CPU_DELAY_NS)
+		return 1;
+
  	if (rq->curr != rq->idle)
  		return 0;
  
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 81ac605b9cd5..57a49a5524f0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -97,6 +97,9 @@
  # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
  #endif
  
+#define IDLE_CPU_DELAY_NS		1000000		/* 1ms */
+#define IDLE_CPU_DELAY_MAX_RUNNING	4
+
  struct rq;
  struct cpuidle_state;

And using it now brings the hackbench wall time at 28s :)

Thanks,

Mathieu

> 
>>>>        struct task_struct    *stop;
>>>>        unsigned long        next_balance;
>>>>        struct mm_struct    *prev_mm;
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

