Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF54812ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444039AbjLNLjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444128AbjLNLjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:39:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AC891FD3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:39:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F42BC15;
        Thu, 14 Dec 2023 03:39:49 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E76F73F738;
        Thu, 14 Dec 2023 03:39:00 -0800 (PST)
Message-ID: <b077b38f-b42c-f679-1e08-70b55d116e17@arm.com>
Date:   Thu, 14 Dec 2023 11:38:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
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
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-22-james.morse@arm.com>
 <9084cb79-22bd-4cb3-b48d-f0d8d71aa47c@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <9084cb79-22bd-4cb3-b48d-f0d8d71aa47c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/11/2023 17:48, Reinette Chatre wrote:
> On 10/25/2023 11:03 AM, James Morse wrote:
>> When a CPU is taken offline resctrl may need to move the overflow or
>> limbo handlers to run on a different CPU.
>>
>> Once the offline callbacks have been split, cqm_setup_limbo_handler()
>> will be called while the CPU that is going offline is still present
>> in the cpu_mask.
>>
>> Pass the CPU to exclude to cqm_setup_limbo_handler() and
>> mbm_setup_overflow_handler(). These functions can use a variant of
>> cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
>> need excluding.
>>
>> A subsequent patch moves these calls to be before CPUs have been removed,
>> so this exclude_cpus behaviour is temporary.
> 
> Note "A subsequent patch". Please do go over your entire series. I may not
> have noticed all.

Yup, I've searched the git-log and removed those paragraphs from the x86 patches in my tree.


>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index c4c1e1909058..f5fff2f0d866 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -61,19 +61,36 @@
>>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>>   *			        aren't marked nohz_full
>>   * @mask:	The mask to pick a CPU from.
>> + * @exclude_cpu:The CPU to avoid picking.
>>   *
>> - * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
>> - * nohz_full, these are preferred.
>> + * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
>> + * CPUs that don't use nohz_full, these are preferred. Pass
>> + * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
>> + *
>> + * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
>>   */
>> -static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>> +static inline unsigned int
>> +cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>  {
>>  	unsigned int cpu, hk_cpu;
>>  
>> -	cpu = cpumask_any(mask);
>> -	if (!tick_nohz_full_cpu(cpu))
>> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
>> +		cpu = cpumask_any(mask);
>> +	else
>> +		cpu = cpumask_any_but(mask, exclude_cpu);
>> +
>> +	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
>> +		return cpu;
> 
> It is not clear to me how cpumask_any_but() failure is handled.
> 
> cpumask_any_but() returns ">= nr_cpu_ids if no cpus set" ...

It wasn't a satisfiable request, there are no CPUs for this domain other than the one that
was excluded. cpumask_any_but() also describes its errors as "returns >= nr_cpu_ids if no
CPUs are available".

The places this can happen in resctrl are:
cqm_setup_limbo_handler(), where it causes the schedule_delayed_work_on() call to be skipped.
mbm_setup_overflow_handler(), which does similar.

These two cases are triggered from resctrl_offline_cpu() when the last CPU in a domain is
going offline, and the domain is about to be free()d. This is how the limbo/overflow
'threads' stop.


>> +
>> +	/* If the CPU picked isn't marked nohz_full, we're done */
> 
> Please don't impersonate code.
> 
>> +	if (cpu <= nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>>  		return cpu;
> 
> Is this intended to be "cpu < nr_cpu_ids"?

Yes, fixed - thanks!


> But that would have
> code continue ... so maybe it needs explicit error check of
> cpumask_any_but() failure with an earlier exit?

I'm not sure what the problem you refer to here is.
If 'cpu' is valid, and not marked nohz_full, nothing more needs doing.
If 'cpu' is invalid or a CPU marked nohz_full, then a second attempt is made to find a
housekeeping CPU into 'hk_cpu'. If the second attempt is valid, it's used in preference.

An error is returned if the request couldn't be satisfied, i.e. an empty mask was passed,
or the only CPU set in the mask was excluded.
There is a second attempt in this case for a housekeeping CPU - but that will fail too.
As above, this only happens when CPUs are going offline, and this error is handled by the
caller.


Thanks,

James
