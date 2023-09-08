Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A77984F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbjIHJo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjIHJoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:44:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BA4019A8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 02:44:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0507D75;
        Fri,  8 Sep 2023 02:44:58 -0700 (PDT)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8CEA3F64C;
        Fri,  8 Sep 2023 02:44:18 -0700 (PDT)
Message-ID: <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
Date:   Fri, 8 Sep 2023 11:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Lu, Aaron" <aaron.lu@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20230804090858.7605-1-rui.zhang@intel.com>
 <20230814031432.GA574314@ziqianlu-dell>
 <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
Content-Language: en-US
In-Reply-To: <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rui,

On 8/14/23 10:30, Zhang, Rui wrote:
> On Mon, 2023-08-14 at 11:14 +0800, Aaron Lu wrote:
>> Hi Rui,
>>
>> On Fri, Aug 04, 2023 at 05:08:58PM +0800, Zhang Rui wrote:
>>> Problem statement
>>> -----------------
>>> When using cgroup isolated partition to isolate cpus including
>>> cpu0, it
>>> is observed that cpu0 is woken up frequenctly but doing nothing.
>>> This is
>>> not good for power efficiency.
>>>
>>> <idle>-0     [000]   616.491602: hrtimer_cancel:
>>> hrtimer=0xffff8e8fdf623c10
>>> <idle>-0     [000]   616.491608: hrtimer_start:
>>> hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0
>>> expires=615996000000 softexpires=615996000000
>>> <idle>-0     [000]   616.491616: rcu_utilization:      Start
>>> context switch
>>> <idle>-0     [000]   616.491618: rcu_utilization:      End context
>>> switch
>>> <idle>-0     [000]   616.491637: tick_stop:            success=1
>>> dependency=NONE
>>> <idle>-0     [000]   616.491637: hrtimer_cancel:
>>> hrtimer=0xffff8e8fdf623c10
>>> <idle>-0     [000]   616.491638: hrtimer_start:
>>> hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0
>>> expires=616420000000 softexpires=616420000000
>>>
>>> The above pattern repeats every one or multiple ticks, results in
>>> total
>>> 2000+ wakeups on cpu0 in 60 seconds, when running workload on the
>>> cpus that are not in the isolated partition.
>>>
>>> Rootcause
>>> ---------
>>> In NOHZ mode, an active cpu either sends an IPI or touches the idle
>>> cpu's polling flag to wake it up, so that the idle cpu can pull
>>> tasks
>>> from the busy cpu. The logic for selecting the target cpu is to use
>>> the
>>> first idle cpu that presents in both nohz.idle_cpus_mask and
>>> housekeeping_cpumask.
>>>
>>> In the above scenario, when cpu0 is in the cgroup isolated
>>> partition,
>>> its sched domain is deteched, but it is still available in both of
>>> the
>>> above cpumasks. As a result, cpu0
>>
>> I saw in nohz_balance_enter_idle(), if a cpu is isolated, it will not
>> set itself in nohz.idle_cpus_mask and thus should not be chosen as
>> ilb_cpu. I wonder what's stopping this from working?
> 
> One thing I forgot to mention is that the problem is gone if we offline
> and re-online those cpus. In that case, the isolated cpus are removed
> from the nohz.idle_cpus_mask in sched_cpu_deactivate() and are never
> added back.
> 
> At runtime, the cpus can be removed from the nohz.idle_cpus_mask in
> below case only
> 	trigger_load_balance()
> 	        if (unlikely(on_null_domain(rq) || !cpu_active(cpu_of(rq))))
> 	                return;
> 	        nohz_balancer_kick(rq);
> 			nohz_balance_exit_idle()
> 
> My understanding is that if a cpu is in nohz.idle_cpus_mask when it is
> isolated, there is no chance to remove it from that mask later, so the
> check in nohz_balance_enter_idle() does not help.


As you mentioned, once a CPU is isolated, its rq->nohz_tick_stopped is
never updated. Instead of avoiding isolated CPUs at each find_new_ilb() call
as this patch does, maybe it would be better to permanently remove these CPUs
from nohz.idle_cpus_mask. This would lower the number of checks done.
This could be done with something like:
@@ -11576,6 +11586,20 @@ void nohz_balance_enter_idle(int cpu)
           */
          rq->has_blocked_load = 1;
   
+       /* If we're a completely isolated CPU, we don't play: */
+       if (on_null_domain(rq)) {
+               if (cpumask_test_cpu(rq->cpu, nohz.idle_cpus_mask)) {
+                       cpumask_clear_cpu(rq->cpu, nohz.idle_cpus_mask);
+                       atomic_dec(&nohz.nr_cpus);
+               }
+
+               /*
+                * Set nohz_tick_stopped on isolated CPUs to avoid keeping the
+                * value that was stored when rebuild_sched_domains() was called.
+                */
+               rq->nohz_tick_stopped = 1;
+       }
+
          /*
           * The tick is still stopped but load could have been added in the
           * meantime. We set the nohz.has_blocked flag to trig a check of the
@@ -11585,10 +11609,6 @@ void nohz_balance_enter_idle(int cpu)
          if (rq->nohz_tick_stopped)
                  goto out;
   
-       /* If we're a completely isolated CPU, we don't play: */
-       if (on_null_domain(rq))
-               return;
-
          rq->nohz_tick_stopped = 1;
   
          cpumask_set_cpu(cpu, nohz.idle_cpus_mask);

Otherwise I could reproduce the issue and the patch was solving it, so:
Tested-by: Pierre Gondois <pierre.gondois@arm.com>





Also, your patch doesn't aim to solve that, but I think there is an issue
when updating cpuset.cpus when an isolated partition was already created:

// Create an isolated partition containing CPU0
# mkdir cgroup
# mount -t cgroup2 none cgroup/
# mkdir cgroup/Testing
# echo "+cpuset" > cgroup/cgroup.subtree_control
# echo "+cpuset" > cgroup/Testing/cgroup.subtree_control
# echo 0 > cgroup/Testing/cpuset.cpus
# echo isolated > cgroup/Testing/cpuset.cpus.partition

// CPU0's sched domain is detached:
# ls /sys/kernel/debug/sched/domains/cpu0/
# ls /sys/kernel/debug/sched/domains/cpu1/
domain0  domain1

// Change the isolated partition to be CPU1
# echo 1 > cgroup/Testing/cpuset.cpus

// CPU[0-1] sched domains are not updated:
# ls /sys/kernel/debug/sched/domains/cpu0/
# ls /sys/kernel/debug/sched/domains/cpu1/
domain0  domain1

Regards,
Pierre

