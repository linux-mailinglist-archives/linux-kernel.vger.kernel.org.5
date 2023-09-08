Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC7798A43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbjIHP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbjIHP62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:58:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CB3A1BF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:58:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784C0D75;
        Fri,  8 Sep 2023 08:59:01 -0700 (PDT)
Received: from [10.57.5.217] (unknown [10.57.5.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 400363F67D;
        Fri,  8 Sep 2023 08:58:20 -0700 (PDT)
Message-ID: <6cd40359-7a1c-a16e-cd2a-74bf6053f75e@arm.com>
Date:   Fri, 8 Sep 2023 16:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-13-james.morse@arm.com>
 <192aa189-8b08-c8c1-15dc-722e196493f4@intel.com>
 <5f5c2ca9-4a27-616f-1838-0740ced4525f@arm.com>
 <4006d76c-f3de-3484-844a-f54f692ece50@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <4006d76c-f3de-3484-844a-f54f692ece50@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/25/23 00:01, Reinette Chatre wrote:
> On 8/24/2023 9:55 AM, James Morse wrote:
>> On 09/08/2023 23:35, Reinette Chatre wrote:
>>> On 7/28/2023 9:42 AM, James Morse wrote:
>>>> resctrl_arch_rmid_read() could be called by resctrl in process context,
>>>> and then called by the PMU driver from irq context on the same CPU.
>>>
>>> The changelog is written as a bug report of current behavior.
>>> This does not seem to describe current but instead planned future behavior.
>>
>> I pulled this patch from much later in the tree as it's about to be a problem in this
>> series. I haven't yet decided if its an existing bug in resctrl....
>>
>> ... it doesn't look like this can affect the path through mon_event_read(), as
>> generic_exec_single() masks interrupts.
>> But an incoming IPI from mon_event_read can corrupt the values for the limbo worker, which
>> at the worst would result in early re-use. And the MBM overflow worker ... which would
>> corrupt the value seen by user-space.
>> free_rmid() is equally affected, the outcome for limbo is the same spurious delay or early
>> re-use.
> 
> Apologies but these races are not obvious to me. Let me take the first, where the
> race could be between mon_event_read() and the limbo worker. From what I can tell
> mon_event_read() can be called from user space when creating a new monitoring
> group or when viewing data associated with a monitoring group. In both cases
> rdtgroup_mutex is held from the time user space triggers the request until
> all IPIs are completed. Compare that with the limbo worker, cqm_handle_limbo(),
> that also obtains rdtgroup_mutex before it attempts to do its work.
> Considering this example I am not able to see how an incoming IPI from
> mon_event_read() can interfere with the limbo worker since both
> holding rdtgroup_mutex prevents them from running concurrently.
> 
> Similarly, the MBM overflow worker takes rdtgroup_mutex, and free_rmid()
> is run with rdtgroup_mutex held.

Yes, sorry -I'd forgotten about that! I'll need to dig into this again.

Part of the problem is I'm looking at this from a different angle - something I haven't described properly: the resctrl_arch_ calls shouldn't depend on lock that is private to resctrl.

This allows for multiple callers, (e.g. resctrl_pmu that I haven't posted yet), and allows MPAM's
overflow interrupt to eventually be something resctrl could support.
It also allows the resctrl_arch_ calls to have lockdep asserts for their dependencies.

Yes the resctrl_mutex is what prevents this from being a problem today.
(I haven't yet looked at how Peter's series solves the same problem.)

... it may be possible to move this patch back of the 'fold' to live with the PMU code ...


>> I'll change the commit messages to describe that, and float this earlier in the series.
>> The backport will be a problem. This applies cleanly to v6.1.46, but for v5.15.127 there
>> are at least 13 dependencies ... its probably not worth trying to fix as chances are
>> no-one is seeing this happen in reality.

I'll remove that wording around this and mention the mutex.

[...]

>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> index f0670795b446..62350bbd23e0 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> @@ -266,23 +279,35 @@ int :/(struct rdt_resource *r, struct rdt_domain *d,
>>>>   {
>>>>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>>   	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>>>> +	u64 start_msr_val, old_msr_val, msr_val, chunks;
>>>>   	struct arch_mbm_state *am;
>>>> -	u64 msr_val, chunks;
>>>> -	int ret;
>>>> +	int ret = 0;
>>>>   
>>>>   	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>>>>   		return -EINVAL;
>>>>   
>>>> +interrupted:
>>>> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>>>> +	if (am)
>>>> +		start_msr_val = atomic64_read(&am->prev_msr);
>>>> +
>>>>   	ret = __rmid_read(rmid, eventid, &msr_val);
>>>>   	if (ret)
>>>>   		return ret;
>>>>   
>>>>   	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>>>>   	if (am) {
>>>> -		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>>>> -						 hw_res->mbm_width);
>>>> -		chunks = get_corrected_mbm_count(rmid, am->chunks);
>>>> -		am->prev_msr = msr_val;
>>>> +		old_msr_val = atomic64_cmpxchg(&am->prev_msr, start_msr_val,
>>>> +					       msr_val);
>>>> +		if (old_msr_val != start_msr_val)
>>>> +			goto interrupted;
>>>> +
>>
>>> hmmm ... what if interruption occurs here?
>>
>> This is after the MSR write/read, so this function can't get a torn value from the
>> hardware. (e.g. reads the wrong RMID). The operations on struct arch_mbm_state are atomic,
>> so are still safe if the function becomes re-entrant.
>>
>> If the re-entrant call accessed the same RMID and the same counter, its atomic64_add()
>> would be based on the prev_msr value this call read - because the above cmpxchg succeeded.
>>
>> (put another way:)
>> The interrupting call returns a lower value, consistent with the first call not having
>> finished yet. The interrupted call returns the correct value, which is larger than it
>> read, because it completed after the interrupting call.

> I see, thank you. If this does end up being needed for a future
> concurrency issue, could you please add a comment describing
> this behavior where a later call can return a lower value and
> why that is ok? It looks to me, as accomplished with the use of
> atomic64_add(), as though this scenario would
> end with the correct arch_mbm_state even though the members
> are not updated atomically as a unit.

Sure my stab at that is:
/*
  * At this point the hardware values have been read without
  * being interrupted. Interrupts that occur later will read
  * the updated am->prev_msr and safely increment am->chunks
  * with the new data using atomic64_add().
  */


Thanks,

James
