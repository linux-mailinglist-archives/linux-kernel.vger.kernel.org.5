Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6765C7A07EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbjINOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbjINOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:53:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F029AF9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:53:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFC651FB;
        Thu, 14 Sep 2023 07:53:55 -0700 (PDT)
Received: from [10.34.100.121] (e126645.nice.arm.com [10.34.100.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BECC3F738;
        Thu, 14 Sep 2023 07:53:17 -0700 (PDT)
Message-ID: <ea8da512-73df-59ed-6c47-912dd9ef9dba@arm.com>
Date:   Thu, 14 Sep 2023 16:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Lu, Aaron" <aaron.lu@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "tj@kernel.org" <tj@kernel.org>
References: <20230804090858.7605-1-rui.zhang@intel.com>
 <20230814031432.GA574314@ziqianlu-dell>
 <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
 <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
 <20230911114218.GA334545@ziqianlu-dell>
 <0d1c440becca151db3f3b05b3fb2c63fe69c2904.camel@intel.com>
 <c8baa176-e4cd-41f6-35a9-c69f89b32e79@arm.com>
 <a2a16c0e198a6d722b8923b0eec15dd2b32e4320.camel@intel.com>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <a2a16c0e198a6d722b8923b0eec15dd2b32e4320.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 11:23, Zhang, Rui wrote:
> Hi, Pierre,
> 
>>
>> Yes right indeed,
>> This happens when putting a CPU offline (as you mentioned earlier,
>> putting a CPU offline clears the CPU in the idle_cpus_mask).
>>
>> The load balancing related variables
> 
> including?

I meant the nohz idle variables in the load balancing, so I was referring to:
(struct sched_domain_shared).nr_busy_cpus
(struct sched_domain).nohz_idle
nohz.idle_cpus_mask
nohz.nr_cpus
(struct rq).nohz_tick_stopped

> 
>>   are unused if a CPU has a NULL
>> rq as it cannot pull any task. Ideally we should clear them once,
>> when attaching a NULL sd to the CPU.
> 
> This sounds good to me. But TBH, I don't have enough confidence to do
> so because I'm not crystal clear about how these variables are used.
> 
> Some questions about the code below.
>>
>> The following snipped should do that and solve the issue you
>> mentioned:
>> --- snip ---
>> --- a/include/linux/sched/nohz.h
>> +++ b/include/linux/sched/nohz.h
>> @@ -9,8 +9,10 @@
>>    #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>>    extern void nohz_balance_enter_idle(int cpu);
>>    extern int get_nohz_timer_target(void);
>> +extern void nohz_clean_sd_state(int cpu);
>>    #else
>>    static inline void nohz_balance_enter_idle(int cpu) { }
>> +static inline void nohz_clean_sd_state(int cpu) { }
>>    #endif
>>    
>>    #ifdef CONFIG_NO_HZ_COMMON
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b3e25be58e2b..6fcabe5d08f5 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11525,6 +11525,9 @@ void nohz_balance_exit_idle(struct rq *rq)
>>    {
>>           SCHED_WARN_ON(rq != this_rq());
>>    
>> +       if (on_null_domain(rq))
>> +               return;
>> +
>>           if (likely(!rq->nohz_tick_stopped))
>>                   return;
>>
> if we force clearing rq->nohz_tick_stopped when detaching domain, why
> bother adding the first check?

Yes you're right. I added this check for safety, but this is not
mandatory.

> 
>>    
>> @@ -11551,6 +11554,17 @@ static void set_cpu_sd_state_idle(int cpu)
>>           rcu_read_unlock();
>>    }
>>    
>> +void nohz_clean_sd_state(int cpu) {
>> +       struct rq *rq = cpu_rq(cpu);
>> +
>> +       rq->nohz_tick_stopped = 0;
>> +       if (cpumask_test_cpu(cpu, nohz.idle_cpus_mask)) {
>> +               cpumask_clear_cpu(cpu, nohz.idle_cpus_mask);
>> +               atomic_dec(&nohz.nr_cpus);
>> +       }
>> +       set_cpu_sd_state_idle(cpu);
>> +}
>> +
> 
> detach_destroy_domains
> 	cpu_attach_domain
> 		update_top_cache_domain
> 
> as we clears per_cpu(sd_llc, cpu) for the isolated cpu in
> cpu_attach_domain(), set_cpu_sd_state_idle() seems to be a no-op here,
> no?

Yes you're right, cpu_attach_domain() and nohz_clean_sd_state() calls
have to be inverted to avoid what you just described.

It also seems that the current kernel doesn't decrease nr_busy_cpus
when putting CPUs in an isolated partition. Indeed if a CPU is counted
in nr_busy_cpus, putting the CPU in an isolated partition doesn't trigger
any call to set_cpu_sd_state_idle().
So it might an additional argument.

Thanks for reading the patch,
Regards,
Pierre

> 
> thanks,
> rui
>>    /*
>>     * This routine will record that the CPU is going idle with tick
>> stopped.
>>     * This info will be used in performing idle load balancing in the
>> future.
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index d3a3b2646ec4..d31137b5f0ce 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -2584,8 +2584,10 @@ static void detach_destroy_domains(const
>> struct cpumask *cpu_map)
>>                  
>> static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
>>    
>>           rcu_read_lock();
>> -       for_each_cpu(i, cpu_map)
>> +       for_each_cpu(i, cpu_map) {
>>                   cpu_attach_domain(NULL, &def_root_domain, i);
>> +               nohz_clean_sd_state(i);
>> +       }
>>           rcu_read_unlock();
>>    }
>>
>> --- snip ---
>>
>> Regards,
>> Pierre
>>
>>>
>>>>
>>>>> +       }
>>>>> +
>>>>>            /*
>>>>>             * The tick is still stopped but load could have been
>>>>> added in the
>>>>>             * meantime. We set the nohz.has_blocked flag to trig
>>>>> a
>>>>> check of the
>>>>> @@ -11585,10 +11609,6 @@ void nohz_balance_enter_idle(int cpu)
>>>>>            if (rq->nohz_tick_stopped)
>>>>>                    goto out;
>>>>> -       /* If we're a completely isolated CPU, we don't play:
>>>>> */
>>>>> -       if (on_null_domain(rq))
>>>>> -               return;
>>>>> -
>>>>>            rq->nohz_tick_stopped = 1;
>>>>>            cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
>>>>>
>>>>> Otherwise I could reproduce the issue and the patch was solving
>>>>> it,
>>>>> so:
>>>>> Tested-by: Pierre Gondois <pierre.gondois@arm.com>
>>>
>>> Thanks for testing, really appreciated!
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Also, your patch doesn't aim to solve that, but I think there
>>>>> is an
>>>>> issue
>>>>> when updating cpuset.cpus when an isolated partition was
>>>>> already
>>>>> created:
>>>>>
>>>>> // Create an isolated partition containing CPU0
>>>>> # mkdir cgroup
>>>>> # mount -t cgroup2 none cgroup/
>>>>> # mkdir cgroup/Testing
>>>>> # echo "+cpuset" > cgroup/cgroup.subtree_control
>>>>> # echo "+cpuset" > cgroup/Testing/cgroup.subtree_control
>>>>> # echo 0 > cgroup/Testing/cpuset.cpus
>>>>> # echo isolated > cgroup/Testing/cpuset.cpus.partition
>>>>>
>>>>> // CPU0's sched domain is detached:
>>>>> # ls /sys/kernel/debug/sched/domains/cpu0/
>>>>> # ls /sys/kernel/debug/sched/domains/cpu1/
>>>>> domain0  domain1
>>>>>
>>>>> // Change the isolated partition to be CPU1
>>>>> # echo 1 > cgroup/Testing/cpuset.cpus
>>>>>
>>>>> // CPU[0-1] sched domains are not updated:
>>>>> # ls /sys/kernel/debug/sched/domains/cpu0/
>>>>> # ls /sys/kernel/debug/sched/domains/cpu1/
>>>>> domain0  domain1
>>>>>
>>> Interesting. Let me check and get back to you later on this. :)
>>>
>>> thanks,
>>> rui
> 
