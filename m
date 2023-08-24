Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131CD78762E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbjHXQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242787AbjHXQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:56:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 262CF19B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:56:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25AD91007;
        Thu, 24 Aug 2023 09:56:45 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0F1C3F740;
        Thu, 24 Aug 2023 09:56:01 -0700 (PDT)
Message-ID: <5f5c2ca9-4a27-616f-1838-0740ced4525f@arm.com>
Date:   Thu, 24 Aug 2023 17:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
Content-Language: en-GB
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <192aa189-8b08-c8c1-15dc-722e196493f4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/08/2023 23:35, Reinette Chatre wrote:
> On 7/28/2023 9:42 AM, James Morse wrote:
>> resctrl_arch_rmid_read() could be called by resctrl in process context,
>> and then called by the PMU driver from irq context on the same CPU.
> 
> The changelog is written as a bug report of current behavior.
> This does not seem to describe current but instead planned future behavior.

I pulled this patch from much later in the tree as it's about to be a problem in this
series. I haven't yet decided if its an existing bug in resctrl....

... it doesn't look like this can affect the path through mon_event_read(), as
generic_exec_single() masks interrupts.
But an incoming IPI from mon_event_read can corrupt the values for the limbo worker, which
at the worst would result in early re-use. And the MBM overflow worker ... which would
corrupt the value seen by user-space.
free_rmid() is equally affected, the outcome for limbo is the same spurious delay or early
re-use.


I'll change the commit messages to describe that, and float this earlier in the series.
The backport will be a problem. This applies cleanly to v6.1.46, but for v5.15.127 there
are at least 13 dependencies ... its probably not worth trying to fix as chances are
no-one is seeing this happen in reality.


>> This could cause struct arch_mbm_state's prev_msr value to go backwards,
>> leading to the chunks value being incremented multiple times.
>>
>> The struct arch_mbm_state holds both the previous msr value, and a count
>> of the number of chunks. These two fields need to be updated atomically.
>> Similarly __rmid_read() must write to one MSR and read from another,
>> this must be proteted from re-entrance.
> 
> proteted -> protected
> 
>>
>> Read the prev_msr before accessing the hardware, and cmpxchg() the value
>> back. If the value has changed, the whole thing is re-attempted. To protect
>> the MSR, __rmid_read() will retry reads for QM_CTR if QM_EVTSEL has changed
>> from the selected value.
> 
> The latter part of the sentence does not seem to match with what the
> patch does.


>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f0670795b446..62350bbd23e0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -266,23 +279,35 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>  {
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> +	u64 start_msr_val, old_msr_val, msr_val, chunks;
>>  	struct arch_mbm_state *am;
>> -	u64 msr_val, chunks;
>> -	int ret;
>> +	int ret = 0;
>>  
>>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>>  		return -EINVAL;
>>  
>> +interrupted:
>> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>> +	if (am)
>> +		start_msr_val = atomic64_read(&am->prev_msr);
>> +
>>  	ret = __rmid_read(rmid, eventid, &msr_val);
>>  	if (ret)
>>  		return ret;
>>  
>>  	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>>  	if (am) {
>> -		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>> -						 hw_res->mbm_width);
>> -		chunks = get_corrected_mbm_count(rmid, am->chunks);
>> -		am->prev_msr = msr_val;
>> +		old_msr_val = atomic64_cmpxchg(&am->prev_msr, start_msr_val,
>> +					       msr_val);
>> +		if (old_msr_val != start_msr_val)
>> +			goto interrupted;
>> +

> hmmm ... what if interruption occurs here? 

This is after the MSR write/read, so this function can't get a torn value from the
hardware. (e.g. reads the wrong RMID). The operations on struct arch_mbm_state are atomic,
so are still safe if the function becomes re-entrant.

If the re-entrant call accessed the same RMID and the same counter, its atomic64_add()
would be based on the prev_msr value this call read - because the above cmpxchg succeeded.

(put another way:)
The interrupting call returns a lower value, consistent with the first call not having
finished yet. The interrupted call returns the correct value, which is larger than it
read, because it completed after the interrupting call.


>> +		chunks = mbm_overflow_count(start_msr_val, msr_val,
>> +					    hw_res->mbm_width);
>> +		atomic64_add(chunks, &am->chunks);
>> +
>> +		chunks = get_corrected_mbm_count(rmid,
>> +						 atomic64_read(&am->chunks));
>>  	} else {
>>  		chunks = msr_val;
>>  	}


Thanks,

James
