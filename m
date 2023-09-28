Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874D07B17E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjI1JzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjI1JzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:55:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E4D3126
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:55:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C978F1FB;
        Thu, 28 Sep 2023 02:55:41 -0700 (PDT)
Received: from [10.34.100.121] (e126645.nice.arm.com [10.34.100.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59F913F59C;
        Thu, 28 Sep 2023 02:55:01 -0700 (PDT)
Message-ID: <4534b7b5-7127-27d9-8264-6703497dcb81@arm.com>
Date:   Thu, 28 Sep 2023 11:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] sched/topology: change behaviour of sysctl
 sched_energy_aware based on the platform
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
        pauld@redhat.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, vschneid@redhat.com, qperret@google.com
References: <20230926100046.405188-1-sshegde@linux.vnet.ibm.com>
 <caab4d10-3ed6-faa7-5435-3086f3878537@arm.com>
 <d054e362-4a11-ee36-ddb6-870d88278e78@linux.vnet.ibm.com>
 <8ac1576c-909b-ec6b-930d-0683ca288bf9@arm.com>
 <46353945-fced-9b69-b334-3b7ae50c957c@linux.vnet.ibm.com>
 <a226058c-5a14-fc57-c371-7db3d96f9b20@arm.com>
In-Reply-To: <a226058c-5a14-fc57-c371-7db3d96f9b20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/23 11:25, Pierre Gondois wrote:
> Hello Shrikanth, Dietmar,
> 
> On 9/27/23 19:08, Shrikanth Hegde wrote:
>>
>>
>> On 9/27/23 6:44 PM, Dietmar Eggemann wrote:
>>> Ah, BTW s/quentin.perret@arm.com/qperret@google.com
>>>
>>> On 27/09/2023 10:14, Shrikanth Hegde wrote:
>>>>
>>>>
>>>> On 9/27/23 2:59 AM, Dietmar Eggemann wrote:
>>>>> On 26/09/2023 12:00, Shrikanth Hegde wrote:
>>>
>>> [...]
>>>
>>>>>> At present, though platform doesn't support EAS, this sysctl returns 1
>>>>>> and it ends up calling rebuild of sched domain on write to 1 and
>>>>>
>>>>> sched domains are not rebuild in this case, i.e.
>>>>> partition_sched_domains_locked() does not call detach_destroy_domains()
>>>>> or build_sched_domains(). Only build_perf_domains() is called which
>>>>> bails out if !sysctl_sched_energy_aware or one of the EAS conditions is
>>>>> not true.
>>>>>
>>>>
>>>> ok. that's because it goes to match1 and match2 right?
>>>
>>> yes.
>>>
>>> [...]
>>>
>>>>>> @@ -231,6 +289,14 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>>>>>>    		return -EPERM;
>>>>>>
>>>>>>    	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>>>>>> +	if (!sched_is_eas_possible(cpu_active_mask)) {
>>>>>
>>>>> This is using `cpu_active_mask` so EAS can only be disabled system-wide.
>>>>>
>>>>> So I experimented with an exclusive cpuset setup creating a symmetric
>>>>> (cs1) and an asymmetric (cs2) island on my Juno with its cpumask = [l B
>>>>> B l l l] (l - little CPU, B - Big CPU).
>>>>>
>>>>> root@juno:~# cd /sys/fs/cgroup/cpuset
>>>>> root@juno:/sys/fs/cgroup/cpuset# mkdir cs1
>>>>> root@juno:/sys/fs/cgroup/cpuset# echo 1 > cs1/cpuset.cpu_exclusive
>>>>> root@juno:/sys/fs/cgroup/cpuset# echo 0 > cs1/cpuset.mems
>>>>> root@juno:/sys/fs/cgroup/cpuset# echo 4,5 > cs1/cpuset.cpus
>>>>> root@juno:/sys/fs/cgroup/cpuset# mkdir cs2
>>>>> root@juno:/sys/fs/cgroup/cpuset# echo 1 > cs2/cpuset.cpu_exclusive
>>>>> root@juno:/sys/fs/cgroup/cpuset# echo 0 > cs2/cpuset.mems
>>>>> root@juno:/sys/fs/cgroup/cpuset# echo 0-3 > cs2/cpuset.cpus
>>>>> root@juno:/sys/fs/cgroup/cpuset# echo 0 > cpuset.sched_load_balance
>>>>>
>>>>> [ 3021.761278] root_domain 0-3: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
>>>>> cpus=0,3-5 nr_pstate=5 }
>>>>>
>>>>> root@juno:~# echo 0 > /proc/sys/kernel/sched_energy_aware
>>>>>
>>>>> log messages:
>>>>> ...
>>>>> [ 3143.538583] rd 4-5: Disabling EAS
>>>>> [ 3143.549569] rd 0-3: Disabling EAS
>>>>> [ 3143.560681] sched_energy_set: stopping EAS
>>>>> ...
>>>>>
>>>>> root@juno:~# echo 1 > /proc/sys/kernel/sched_energy_aware
>>>>>
>>>>> log messages:
>>>>> ...
>>>>> [ 3223.277521] root_domain 0-3: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
>>>>> cpus=0,3-5 nr_pstate=5 }
>>>>> [ 3223.293409] sched_energy_set: starting EAS
>>>>>
>>>>> Seems still to work correctly.
>>>>
>>>> I see that can be a issue. using first cpu here check to asymmetric cpu capacity.
>>>> It would have worked here, since the first group had asymmetry. ( l B B l ).
>>>> It wouldn't have worked if the first group had like ( l l ) and second group has ( l B B l )
>>>
>>> Yeah, that's true.
>>>
>>>     sched_is_eas_possible(const struct cpumask *cpu_mask)
>>>
>>>       !per_cpu(sd_asym_cpucapacity, cpumask_first(cpu_mask));
>>>
>>> cpusets cs1=[0,5] and cs2=[1-4] as such an example.
>>>
>>
>> right.
>>
>>>
>>>> Instead of cpu_active_mask, I can make use of ndoms_cur and doms_cur[i] logic to
>>>> traverse through possible doms, and if none of the domains have asymmetric cpu capacity
>>>> return false.  Does that look right?
>>>
>>>     rebuild_sched_domains()
>>>
>>>       rebuild_sched_domains_locked()
>>>
>>>         ndoms = generate_sched_domains(&doms, &attr)
>>>
>>> You would need generate_sched_domains() in sched_energy_aware_handler()?
>>>
>>
>> clearly I didnt think through this. ndoms_cur and doms_cur are updated at the end.
>> So If EAS is possible at boot, this would fail.
>>
>>
>> What  sched_is_eas_possible needs is if there is asymmetric cpu topology.
>> Simpler loop of all CPU's and checking if there any of them have sd_asym_cpucapacity might do,
>> though it goes through all CPU's, Since these functions are not in hot path
>> So it should not affect any performance. Something like below would work?
>>
>> 	bool any_asym_capacity = false;
>>
>>           /* EAS is enabled for asymmetric CPU capacity topologies. */
>>           for_each_cpu(i, cpu_mask) {
>>                   if (per_cpu(sd_asym_cpucapacity, i)) {
>>                           any_asym_capacity = true;
>>                           break;
>>                   }
>>           }
>>           if (!any_asym_capacity) {
>>                   if (sched_debug()) {
>>                           pr_info("rd %*pbl: Checking EAS, CPUs do not have asymmetric capacities\n",
>>                                   cpumask_pr_args(cpu_mask));
>>                   }
>>                   return false;
>>           }
>>
> 
> FYIW I could reproduce the issue mentioned above, and the suggested bit
> seems to solve it.
> 
>>
>>
>>>>> [...]
>>>>>
>>>>>> @@ -458,6 +487,8 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>>>>>>    	return !!pd;
>>>>>>
>>>>>>    free:
>>>>>> +	if (sched_debug())
>>>>>> +		pr_warn("rd %*pbl: Disabling EAS", cpumask_pr_args(cpu_map));
>>>>>
>>>>> Shouldn't this be used in condition `if (!sysctl_sched_energy_aware)`?
>>>>> Otherwise we have 2 warnings when the other conditions which leads to
>>>>> `goto free` aren't met.
>>>> Since sched_energy_set has the info messages about start and stop of EAS, maybe
>>>> this debug is not needed. Will remove it. Doing it only `if (!sysctl_sched_energy_aware)`
>>>
>>> OK.
>>>
>>>> also doesn't seem correct, as calling free in this function would free the perf_domains.
>>>
>>> But !sched_is_eas_possible() also does `goto free` and in there we we
>>> emit pr_info's indicating why EAS isn't possible right now.
>>>
>>> When issuing a:
>>>
>>> # echo 0 > /proc/sys/kernel/sched_energy_aware
>>>
>>> we would see in the logs:
>>>
>>> ...
>>> [  416.325324] rd 0-5: sysctl_sched_energy_aware is N   <-- (*)
>>> [  416.337844] sched_energy_set: stopping EAS
>>> ...
>>>
>>> but maybe (*) is not necessary ...
> 
> I m not sure I understand 100% the point, but it seems to me that when
> changing sysctl_sched_energy_aware's value, either:
> - EAS is not possible, and sched_is_eas_possible() will output the reason why
>     (i.e. "Checking EAS, [...]")
> - EAS was deactivated by the user, and it is possible to check the value of
>     sysctl_sched_energy_aware. So there would be no need to have an additional
>     message "Checking EAS, sysclt sched_energy_aware set to N"
> 
> When build_perf_domains() is called while rebuilding the sched domains, it is also
> possible to check sched_energy_aware's value and understand why EAS is not enabled.
> 
>>
>> ok. I think we can add similar info message in if(!sysctl_sched_energy_aware) like below?
>> Would that be enough?
>>
>>           if (!sysctl_sched_energy_aware) {
>>                   if (sched_debug()) {
>>                           pr_info("rd %*pbl: Checking EAS, sysclt sched_energy_aware set to N\n",
>>                                   cpumask_pr_args(cpu_map));
>>                   }
> 
> (No need for brackets here, just in case)
> 
>>                   goto free;
>>           }
>>
>> and remove the below one.
>>           if (sched_debug())
>>                   pr_warn("rd %*pbl: Disabling EAS", cpumask_pr_args(cpu_map));
>>
>>
>> So there will be these "Checking EAS" and if possible, "starting EAS" or "stopping EAS" message.
> 
> 
> I will rebase the patch removing the EM complexity and check it/resend it,
> like this the 2 patches could go together:
> https://lore.kernel.org/lkml/20221121094336.3250917-1-pierre.gondois@arm.com/

The patch actually seems to apply cleanly on v6.6-rc3, and the complexity of
find_energy_efficient_cpu() seems to be the same as what it was when the patch
was sent, so I believe you can:
- Rebase your patch on top of it
- Provide a pointer to it in the changelog to mention the dependency
- Remove this bit in the commit message of your patch:
"It takes most of the cases into account except one where EM complexity is
too high as the code was bit tricky to separate that."

Regards,
Pierre
