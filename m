Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9A677253A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjHGNPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjHGNPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:15:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE01E5A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:15:17 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKGx96wp0z1KCNY;
        Mon,  7 Aug 2023 21:14:05 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 21:15:14 +0800
CC:     <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v9 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Chen Yu <yu.c.chen@intel.com>
References: <20230719092838.2302-1-yangyicong@huawei.com>
 <20230719092838.2302-3-yangyicong@huawei.com>
 <ZLpVZmI8FrQtsfRH@chenyu5-mobl2>
 <ac8d1fef-ebe2-021f-b621-208c619cc2ea@huawei.com>
 <ZM0nYEB4m883KfIy@chenyu5-mobl2>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <c6f93f10-fea5-a734-9a78-64aa9ff44adb@huawei.com>
Date:   Mon, 7 Aug 2023 21:15:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ZM0nYEB4m883KfIy@chenyu5-mobl2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/5 0:29, Chen Yu wrote:
> Hi Yicong,
> 
> On 2023-08-01 at 20:06:56 +0800, Yicong Yang wrote:
>> Hi Chenyu,
>>
>> Sorry for the late reply. Something's wrong and cause this didn't appear
>> in my mail box. I check it out on the LKML.
>>
>  
> No worries : )
> 
>> On 2023/7/21 17:52, Chen Yu wrote:
>>> Hi Yicong,
>>>
>>> Thanks for sending this version!
>>>
>>> On 2023-07-19 at 17:28:38 +0800, Yicong Yang wrote:
>>>> From: Barry Song <song.bao.hua@hisilicon.com>
>>>>
>>>> For platforms having clusters like Kunpeng920, CPUs within the same cluster
>>>> have lower latency when synchronizing and accessing shared resources like
>>>> cache. Thus, this patch tries to find an idle cpu within the cluster of the
>>>> target CPU before scanning the whole LLC to gain lower latency. This
>>>> will be implemented in 3 steps in select_idle_sibling():
>>>> 1. When the prev_cpu/recent_used_cpu are good wakeup candidates, use them
>>>>    if they're sharing cluster with the target CPU. Otherwise record them
>>>>    and do the scanning first.
>>>> 2. Scanning the cluster prior to the LLC of the target CPU for an
>>>>    idle CPU to wakeup.
>>>> 3. If no idle CPU found after scanning and the prev_cpu/recent_used_cpu
>>>>    can be used, use them.
>>>>
>>>> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
>>>> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
>>>>
>>>> With this patch, We noticed enhancement on tbench and netperf within one
>>>> numa or cross two numa on 6.5-rc1:
>>>> tbench results (node 0):
>>>>              baseline                    patched
>>>>   1:        325.9673        378.9117 (   16.24%)
>>>>   4:       1311.9667       1501.5033 (   14.45%)
>>>>   8:       2629.4667       2961.9100 (   12.64%)
>>>>  16:       5259.1633       5928.0833 (   12.72%)
>>>>  32:      10368.6333      10566.8667 (    1.91%)
>>>>  64:       7868.7700       8182.0100 (    3.98%)
>>>> 128:       6528.5733       6801.8000 (    4.19%)
>>>> tbench results (node 0-1):
>>>>               vanilla                    patched
>>>>   1:        329.2757        380.8907 (   15.68%)
>>>>   4:       1327.7900       1494.5300 (   12.56%)
>>>>   8:       2627.2133       2917.1233 (   11.03%)
>>>>  16:       5201.3367       5835.9233 (   12.20%)
>>>>  32:       8811.8500      11154.2000 (   26.58%)
>>>>  64:      15832.4000      19643.7667 (   24.07%)
>>>> 128:      12605.5667      14639.5667 (   16.14%)
>>>> netperf results TCP_RR (node 0):
>>>>              baseline                    patched
>>>>   1:      77302.8667      92172.2100 (   19.24%)
>>>>   4:      78724.9200      91581.3100 (   16.33%)
>>>>   8:      79168.1296      91091.7942 (   15.06%)
>>>>  16:      81079.4200      90546.5225 (   11.68%)
>>>>  32:      82201.5799      78910.4982 (   -4.00%)
>>>>  64:      29539.3509      29131.4698 (   -1.38%)
>>>> 128:      12082.7522      11956.7705 (   -1.04%)
>>>> netperf results TCP_RR (node 0-1):
>>>>              baseline                    patched
>>>>   1:      78340.5233      92101.8733 (   17.57%)
>>>>   4:      79644.2483      91326.7517 (   14.67%)
>>>>   8:      79557.4313      90737.8096 (   14.05%)
>>>>  16:      79215.5304      90568.4542 (   14.33%)
>>>>  32:      78999.3983      85460.6044 (    8.18%)
>>>>  64:      74198.9494      74325.4361 (    0.17%)
>>>> 128:      27397.4810      27757.5471 (    1.31%)
>>>> netperf results UDP_RR (node 0):
>>>>              baseline                    patched
>>>>   1:      95721.9367     111546.1367 (   16.53%)
>>>>   4:      96384.2250     110036.1408 (   14.16%)
>>>>   8:      97460.6546     109968.0883 (   12.83%)
>>>>  16:      98876.1687     109387.8065 (   10.63%)
>>>>  32:     104364.6417     105241.6767 (    0.84%)
>>>>  64:      37502.6246      37451.1204 (   -0.14%)
>>>> 128:      14496.1780      14610.5538 (    0.79%)
>>>> netperf results UDP_RR (node 0-1):
>>>>              baseline                    patched
>>>>   1:      96176.1633     111397.5333 (   15.83%)
>>>>   4:      94758.5575     105681.7833 (   11.53%)
>>>>   8:      94340.2200     104138.3613 (   10.39%)
>>>>  16:      95208.5285     106714.0396 (   12.08%)
>>>>  32:      74745.9028     100713.8764 (   34.74%)
>>>>  64:      59351.4977      73536.1434 (   23.90%)
>>>> 128:      23755.4971      26648.7413 (   12.18%)
>>>>
>>>> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
>>>> in the code has not been tested but it supposed to work.
>>>>
>>>> Chen Yu also noticed this will improve the performance of tbench and
>>>> netperf on a 24 CPUs Jacobsville machine, there are 4 CPUs in one
>>>> cluster sharing L2 Cache.
>>>>
>>>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>>>> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
>>>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>>>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>>>> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
>>>> ---
>>>>  kernel/sched/fair.c     | 59 +++++++++++++++++++++++++++++++++++++----
>>>>  kernel/sched/sched.h    |  1 +
>>>>  kernel/sched/topology.c | 12 +++++++++
>>>>  3 files changed, 67 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index b3e25be58e2b..d91bf64f81f5 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -7012,6 +7012,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>>  		}
>>>>  	}
>>>>  
>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
>>>> +		struct sched_group *sg = sd->groups;
>>>> +
>>>> +		if (sg->flags & SD_CLUSTER) {
>>>> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target + 1) {
>>>> +				if (!cpumask_test_cpu(cpu, cpus))
>>>> +					continue;
>>>> +
>>>> +				if (has_idle_core) {
>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>>> +					if ((unsigned int)i < nr_cpumask_bits)
>>>> +						return i;
>>>> +				} else {
>>>> +					if (--nr <= 0)
>>>> +						return -1;
>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
>>>> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
>>>> +						return idle_cpu;
>>>> +				}
>>>> +			}
>>>> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
>>>> +		}
>>>> +	}
>>>> +
>>>>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>>>>  		if (has_idle_core) {
>>>>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>>> @@ -7019,7 +7043,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>>  				return i;
>>>>  
>>>>  		} else {
>>>> -			if (!--nr)
>>>> +			if (--nr <= 0)
>>>>  				return -1;
>>>>  			idle_cpu = __select_idle_cpu(cpu, p);
>>>>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>>>> @@ -7121,7 +7145,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>>  	bool has_idle_core = false;
>>>>  	struct sched_domain *sd;
>>>>  	unsigned long task_util, util_min, util_max;
>>>> -	int i, recent_used_cpu;
>>>> +	int i, recent_used_cpu, prev_aff = -1;
>>>>  
>>>>  	/*
>>>>  	 * On asymmetric system, update task utilization because we will check
>>>> @@ -7148,8 +7172,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>>  	 */
>>>>  	if (prev != target && cpus_share_cache(prev, target) &&
>>>>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>>>> -	    asym_fits_cpu(task_util, util_min, util_max, prev))
>>>> -		return prev;
>>>> +	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
>>>> +		if (!static_branch_unlikely(&sched_cluster_active))
>>>> +			return prev;
>>>> +
>>>> +		if (cpus_share_resources(prev, target))
>>>> +			return prev;
>>>
>>> I have one minor question, previously Peter mentioned that he wants to get rid of the
>>> percpu sd_share_id, not sure if he means that not using it in select_idle_cpu()
>>> or remove that variable completely to not introduce extra space? 
>>> Hi Peter, could you please give us more hints on this? thanks.
>>>
>>> If we wants to get rid of this variable, would this work?
>>>
>>> 	if ((sd->groups->flags & SD_CLUSTER) &&
>>> 	    cpumask_test_cpu(prev, sched_group_span(sd->groups))
>>> 		return prev
>>>
>>
>> In the current implementation, nop, we haven't deferenced the @sd yet and we don't
>> need to if scanning is not needed.
>>
>> Since we're on the quick path without scanning here, I wonder it'll be a bit more
>> efficient to use a per-cpu id rather than deference the rcu and do the bitmap
>> computation.
>>
> 
> Dereference is a memory barrier and the bitmap is of one operation/instruction which
> should not have too much overhead. But anyway I've tested this patch on Jacobsville
> and the data looks OK to me:
> 
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	6-threads	 1.00 (  0.84)	 -0.32 (  0.71)
> TCP_RR          	12-threads	 1.00 (  0.35)	 +1.52 (  0.42)
> TCP_RR          	18-threads	 1.00 (  0.31)	 +3.89 (  0.38)
> TCP_RR          	24-threads	 1.00 (  0.87)	 -0.34 (  0.75)
> TCP_RR          	30-threads	 1.00 (  5.84)	 +0.71 (  4.85)
> TCP_RR          	36-threads	 1.00 (  4.84)	 +0.24 (  3.30)
> TCP_RR          	42-threads	 1.00 (  3.75)	 +0.26 (  3.56)
> TCP_RR          	48-threads	 1.00 (  1.51)	 +0.45 (  1.28)
> UDP_RR          	6-threads	 1.00 (  0.65)	+10.12 (  0.63)
> UDP_RR          	12-threads	 1.00 (  0.20)	 +9.91 (  0.25)
> UDP_RR          	18-threads	 1.00 ( 11.13)	+16.77 (  0.49)
> UDP_RR          	24-threads	 1.00 ( 12.38)	 +2.52 (  0.98)
> UDP_RR          	30-threads	 1.00 (  5.63)	 -0.34 (  4.38)
> UDP_RR          	36-threads	 1.00 ( 19.12)	 -0.89 (  3.30)
> UDP_RR          	42-threads	 1.00 (  2.96)	 -1.41 (  3.17)
> UDP_RR          	48-threads	 1.00 ( 14.08)	 -0.77 ( 10.77)
> 
> Good improvement in several cases. No regression is detected.
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	6-threads	 1.00 (  0.41)	 +1.63 (  0.17)
> loopback        	12-threads	 1.00 (  0.18)	 +4.39 (  0.12)
> loopback        	18-threads	 1.00 (  0.43)	+10.42 (  0.18)
> loopback        	24-threads	 1.00 (  0.38)	 +1.24 (  0.38)
> loopback        	30-threads	 1.00 (  0.24)	 +0.60 (  0.14)
> loopback        	36-threads	 1.00 (  0.17)	 +0.63 (  0.17)
> loopback        	42-threads	 1.00 (  0.26)	 +0.76 (  0.08)
> loopback        	48-threads	 1.00 (  0.23)	 +0.91 (  0.10)
> 
> Good improvement in 18-threads case. No regression is detected.
> 
> hackbench
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1-groups	 1.00 (  0.52)	 +9.26 (  0.57)
> process-pipe    	2-groups	 1.00 (  1.55)	 +6.92 (  0.56)
> process-pipe    	4-groups	 1.00 (  1.36)	 +4.80 (  3.78)
> process-sockets 	1-groups	 1.00 (  2.16)	 -6.35 (  1.10)
> process-sockets 	2-groups	 1.00 (  2.34)	 -6.35 (  5.52)
> process-sockets 	4-groups	 1.00 (  0.35)	 -5.64 (  1.19)
> threads-pipe    	1-groups	 1.00 (  0.82)	 +8.00 (  0.00)
> threads-pipe    	2-groups	 1.00 (  0.47)	 +6.91 (  0.50)
> threads-pipe    	4-groups	 1.00 (  0.45)	 +8.92 (  2.27)
> threads-sockets 	1-groups	 1.00 (  1.02)	 -4.13 (  2.30)
> threads-sockets 	2-groups	 1.00 (  0.34)	 -1.86 (  2.39)
> threads-sockets 	4-groups	 1.00 (  1.51)	 -3.99 (  1.59)
> 
> Pros and cons for hackbench. There is improvement for pipe mode, but
> slight regression on sockets mode. I think this is within acceptable range.
> 
> schbench
> ========
> case            	load    	baseline(std%)	compare%( std%)
> normal          	1-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
> normal          	2-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
> normal          	4-mthreads	 1.00 (  3.82)	 +0.00 (  3.82)
> 
> There is impact to schbench at all, and the results are quite stable.
> 
> For the whole series:
> 
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> 

Thanks for testing.

Yicong.

