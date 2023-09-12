Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1A79D3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbjILOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjILOdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:33:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1875110D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:33:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09747C15;
        Tue, 12 Sep 2023 07:33:42 -0700 (PDT)
Received: from [10.34.100.121] (e126645.nice.arm.com [10.34.100.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78E2A3F5A1;
        Tue, 12 Sep 2023 07:33:03 -0700 (PDT)
Message-ID: <c8baa176-e4cd-41f6-35a9-c69f89b32e79@arm.com>
Date:   Tue, 12 Sep 2023 16:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Lu, Aaron" <aaron.lu@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
References: <20230804090858.7605-1-rui.zhang@intel.com>
 <20230814031432.GA574314@ziqianlu-dell>
 <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
 <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
 <20230911114218.GA334545@ziqianlu-dell>
 <0d1c440becca151db3f3b05b3fb2c63fe69c2904.camel@intel.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <0d1c440becca151db3f3b05b3fb2c63fe69c2904.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rui and Aaron,

On 9/11/23 18:23, Zhang, Rui wrote:
> On Mon, 2023-09-11 at 19:42 +0800, Aaron Lu wrote:
>> Hi Pierre,
>>
>> On Fri, Sep 08, 2023 at 11:43:50AM +0200, Pierre Gondois wrote:
>>> Hello Rui,
>>>
>>> On 8/14/23 10:30, Zhang, Rui wrote:
>>>> On Mon, 2023-08-14 at 11:14 +0800, Aaron Lu wrote:
>>>>> Hi Rui,
>>>>>
>>>>> On Fri, Aug 04, 2023 at 05:08:58PM +0800, Zhang Rui wrote:
>>>>>> Problem statement
>>>>>> -----------------
>>>>>> When using cgroup isolated partition to isolate cpus
>>>>>> including
>>>>>> cpu0, it
>>>>>> is observed that cpu0 is woken up frequenctly but doing
>>>>>> nothing.
>>>>>> This is
>>>>>> not good for power efficiency.
>>>>>>
>>>>>> <idle>-0     [000]   616.491602: hrtimer_cancel:
>>>>>> hrtimer=0xffff8e8fdf623c10
>>>>>> <idle>-0     [000]   616.491608: hrtimer_start:
>>>>>> hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0
>>>>>> expires=615996000000 softexpires=615996000000
>>>>>> <idle>-0     [000]   616.491616: rcu_utilization:      Start
>>>>>> context switch
>>>>>> <idle>-0     [000]   616.491618: rcu_utilization:      End
>>>>>> context
>>>>>> switch
>>>>>> <idle>-0     [000]   616.491637: tick_stop:
>>>>>> success=1
>>>>>> dependency=NONE
>>>>>> <idle>-0     [000]   616.491637: hrtimer_cancel:
>>>>>> hrtimer=0xffff8e8fdf623c10
>>>>>> <idle>-0     [000]   616.491638: hrtimer_start:
>>>>>> hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0
>>>>>> expires=616420000000 softexpires=616420000000
>>>>>>
>>>>>> The above pattern repeats every one or multiple ticks,
>>>>>> results in
>>>>>> total
>>>>>> 2000+ wakeups on cpu0 in 60 seconds, when running workload on
>>>>>> the
>>>>>> cpus that are not in the isolated partition.
>>>>>>
>>>>>> Rootcause
>>>>>> ---------
>>>>>> In NOHZ mode, an active cpu either sends an IPI or touches
>>>>>> the idle
>>>>>> cpu's polling flag to wake it up, so that the idle cpu can
>>>>>> pull
>>>>>> tasks
>>>>>> from the busy cpu. The logic for selecting the target cpu is
>>>>>> to use
>>>>>> the
>>>>>> first idle cpu that presents in both nohz.idle_cpus_mask and
>>>>>> housekeeping_cpumask.
>>>>>>
>>>>>> In the above scenario, when cpu0 is in the cgroup isolated
>>>>>> partition,
>>>>>> its sched domain is deteched, but it is still available in
>>>>>> both of
>>>>>> the
>>>>>> above cpumasks. As a result, cpu0
>>>>>
>>>>> I saw in nohz_balance_enter_idle(), if a cpu is isolated, it
>>>>> will not
>>>>> set itself in nohz.idle_cpus_mask and thus should not be chosen
>>>>> as
>>>>> ilb_cpu. I wonder what's stopping this from working?
>>>>
>>>> One thing I forgot to mention is that the problem is gone if we
>>>> offline
>>>> and re-online those cpus. In that case, the isolated cpus
>>>> are removed
>>>> from the nohz.idle_cpus_mask in sched_cpu_deactivate() and are
>>>> never
>>>> added back.
>>>>
>>>> At runtime, the cpus can be removed from the nohz.idle_cpus_mask
>>>> in
>>>> below case only
>>>>          trigger_load_balance()
>>>>                  if (unlikely(on_null_domain(rq) ||
>>>> !cpu_active(cpu_of(rq))))
>>>>                          return;
>>>>                  nohz_balancer_kick(rq);
>>>>                          nohz_balance_exit_idle()
>>>>
>>>> My understanding is that if a cpu is in nohz.idle_cpus_mask when
>>>> it is
>>>> isolated, there is no chance to remove it from that mask later,
>>>> so the
>>>> check in nohz_balance_enter_idle() does not help.
>>>
>>>
>>> As you mentioned, once a CPU is isolated, its rq->nohz_tick_stopped
>>> is
>>> never updated. Instead of avoiding isolated CPUs at each
>>> find_new_ilb() call
>>> as this patch does, maybe it would be better to permanently remove
>>> these CPUs
>>> from nohz.idle_cpus_mask. This would lower the number of checks
>>> done.
>>
>> I agree.
> 
> Sounds reasonable to me.
> 
>>
>>> This could be done with something like:
>>> @@ -11576,6 +11586,20 @@ void nohz_balance_enter_idle(int cpu)
>>>            */
>>>           rq->has_blocked_load = 1;
>>> +       /* If we're a completely isolated CPU, we don't play: */
>>> +       if (on_null_domain(rq)) {
>>> +               if (cpumask_test_cpu(rq->cpu, nohz.idle_cpus_mask))
>>> {
>>> +                       cpumask_clear_cpu(rq->cpu,
>>> nohz.idle_cpus_mask);
>>> +                       atomic_dec(&nohz.nr_cpus);
>>> +               }
>>> +
>>
>>
>>> +               /*
>>> +                * Set nohz_tick_stopped on isolated CPUs to avoid
>>> keeping the
>>> +                * value that was stored when
>>> rebuild_sched_domains() was called.
>>> +                */
>>> +               rq->nohz_tick_stopped = 1;
>>
>> It's not immediately clear to me what the above comment and code
>> mean,
>> maybe that's because I know very little about sched domain related
>> code.
>> Other than this, your change looks good to me.
>>
> 
> If we set rq->nohz_tick_stopped for the isolated cpu, next time when we
> invoke nohz_balance_exit_idle(), we clear rq->nohz_tick_stopped and
> decrease nohz.nr_cpus (for the second time). This seems like a problem.
> 
> In the current code, when rq->nohz_tick_stopped is set, it means the
> cpu is in the nohz.idle_cpus_mask, and the code above breaks this
> assumption.


Yes right indeed,
This happens when putting a CPU offline (as you mentioned earlier,
putting a CPU offline clears the CPU in the idle_cpus_mask).

The load balancing related variables are unused if a CPU has a NULL
rq as it cannot pull any task. Ideally we should clear them once,
when attaching a NULL sd to the CPU.

The following snipped should do that and solve the issue you mentioned:
--- snip ---
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -9,8 +9,10 @@
  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
  extern void nohz_balance_enter_idle(int cpu);
  extern int get_nohz_timer_target(void);
+extern void nohz_clean_sd_state(int cpu);
  #else
  static inline void nohz_balance_enter_idle(int cpu) { }
+static inline void nohz_clean_sd_state(int cpu) { }
  #endif
  
  #ifdef CONFIG_NO_HZ_COMMON
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be58e2b..6fcabe5d08f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11525,6 +11525,9 @@ void nohz_balance_exit_idle(struct rq *rq)
  {
         SCHED_WARN_ON(rq != this_rq());
  
+       if (on_null_domain(rq))
+               return;
+
         if (likely(!rq->nohz_tick_stopped))
                 return;
  
@@ -11551,6 +11554,17 @@ static void set_cpu_sd_state_idle(int cpu)
         rcu_read_unlock();
  }
  
+void nohz_clean_sd_state(int cpu) {
+       struct rq *rq = cpu_rq(cpu);
+
+       rq->nohz_tick_stopped = 0;
+       if (cpumask_test_cpu(cpu, nohz.idle_cpus_mask)) {
+               cpumask_clear_cpu(cpu, nohz.idle_cpus_mask);
+               atomic_dec(&nohz.nr_cpus);
+       }
+       set_cpu_sd_state_idle(cpu);
+}
+
  /*
   * This routine will record that the CPU is going idle with tick stopped.
   * This info will be used in performing idle load balancing in the future.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b2646ec4..d31137b5f0ce 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2584,8 +2584,10 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
                 static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
  
         rcu_read_lock();
-       for_each_cpu(i, cpu_map)
+       for_each_cpu(i, cpu_map) {
                 cpu_attach_domain(NULL, &def_root_domain, i);
+               nohz_clean_sd_state(i);
+       }
         rcu_read_unlock();
  }

--- snip ---

Regards,
Pierre

> 
>>
>>> +       }
>>> +
>>>           /*
>>>            * The tick is still stopped but load could have been
>>> added in the
>>>            * meantime. We set the nohz.has_blocked flag to trig a
>>> check of the
>>> @@ -11585,10 +11609,6 @@ void nohz_balance_enter_idle(int cpu)
>>>           if (rq->nohz_tick_stopped)
>>>                   goto out;
>>> -       /* If we're a completely isolated CPU, we don't play: */
>>> -       if (on_null_domain(rq))
>>> -               return;
>>> -
>>>           rq->nohz_tick_stopped = 1;
>>>           cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
>>>
>>> Otherwise I could reproduce the issue and the patch was solving it,
>>> so:
>>> Tested-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> Thanks for testing, really appreciated!
>>>
>>>
>>>
>>>
>>>
>>> Also, your patch doesn't aim to solve that, but I think there is an
>>> issue
>>> when updating cpuset.cpus when an isolated partition was already
>>> created:
>>>
>>> // Create an isolated partition containing CPU0
>>> # mkdir cgroup
>>> # mount -t cgroup2 none cgroup/
>>> # mkdir cgroup/Testing
>>> # echo "+cpuset" > cgroup/cgroup.subtree_control
>>> # echo "+cpuset" > cgroup/Testing/cgroup.subtree_control
>>> # echo 0 > cgroup/Testing/cpuset.cpus
>>> # echo isolated > cgroup/Testing/cpuset.cpus.partition
>>>
>>> // CPU0's sched domain is detached:
>>> # ls /sys/kernel/debug/sched/domains/cpu0/
>>> # ls /sys/kernel/debug/sched/domains/cpu1/
>>> domain0  domain1
>>>
>>> // Change the isolated partition to be CPU1
>>> # echo 1 > cgroup/Testing/cpuset.cpus
>>>
>>> // CPU[0-1] sched domains are not updated:
>>> # ls /sys/kernel/debug/sched/domains/cpu0/
>>> # ls /sys/kernel/debug/sched/domains/cpu1/
>>> domain0  domain1
>>>
> Interesting. Let me check and get back to you later on this. :)
> 
> thanks,
> rui
