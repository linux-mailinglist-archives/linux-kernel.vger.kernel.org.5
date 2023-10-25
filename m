Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646067D72B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjJYR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJYR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:57:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C6F318C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:57:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E9F1477;
        Wed, 25 Oct 2023 10:58:06 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6ADE3F738;
        Wed, 25 Oct 2023 10:57:19 -0700 (PDT)
Message-ID: <5f8c45cc-780e-92ca-4b99-6dcfd6db4d01@arm.com>
Date:   Wed, 25 Oct 2023 18:57:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 21/24] x86/resctrl: Allow overflow/limbo handlers to be
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-22-james.morse@arm.com>
 <a7b99b15-5c26-3a73-b41d-c64b59126f8e@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <a7b99b15-5c26-3a73-b41d-c64b59126f8e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 03/10/2023 22:22, Reinette Chatre wrote:
> On 9/14/2023 10:21 AM, James Morse wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index c54fa86e4ef9..bd7f60bf49fe 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -60,11 +60,15 @@
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
>> + * Returns >= nr_cpu_ids if no CPUs are available.

> It may be helpful to add that the function can only fail if exclude_cpu is
> *not* RESCTRL_PICK_ANY_CPU. That helps to understand the sparse error checking.

Assuming you don't give it an empty mask, that should be true ... but I've missed a
difference between the two helpers use of cpumask_any() when combining them....

It now looks like this:
|/**
| * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
| *                              aren't marked nohz_full
| * @mask:       The mask to pick a CPU from.
| * @exclude_cpu:The CPU to avoid picking.
| *
| * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
| * CPUs that don't use nohz_full, these are preferred. Pass
| * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
| *
| * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
| */
|static inline unsigned int
|cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
|{
|        unsigned int cpu, hk_cpu;
|
|        if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
|                cpu = cpumask_any(mask);
|        else
|                cpu = cpumask_any_but(mask, exclude_cpu);
|
|        /* If the CPU picked isn't marked nohz_full, we're done */
|        if (cpu <= nr_cpu_ids && !tick_nohz_full_cpu(cpu))
|                return cpu;
|
|        /* Try to find a CPU that isn't nohz_full to use in preference */
|        hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
|        if (hk_cpu == exclude_cpu)
|                hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
|
|        if (hk_cpu < nr_cpu_ids)
|                cpu = hk_cpu;
|
|        return cpu;
|}

This also has to check cpu is in range before passing it to tick_nohz_full_cpu().


>> @@ -73,6 +77,9 @@ static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>>  		return cpu;
>>  
> 
> It is not obvious from this hunk but I cannot see how this would work
> on a system without any nohz_full CPUs.
> 
> At this point the function looks like:
> 
> 	cpu = cpumask_any(mask);
> 	if (!tick_nohz_full_cpu(cpu))
> 		return cpu;
> 
> I expected exclude_cpu to be taken into account. If I understand correctly
> exclude_cpu can be picked by cpumask_any() and as long as it is not
> a nohz_full CPU it would be returned.

Yup, I missed this when combining the functions, fixed as above...



>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 9c6d4b0970e2..208e46ba7368 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -807,22 +808,31 @@ void cqm_handle_limbo(struct work_struct *work)
>>  	__check_limbo(d, false);
>>  
>>  	if (has_busy_rmid(d)) {
>> -		cpu = cpumask_any_housekeeping(&d->cpu_mask);
>> +		cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
>>  		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
>>  	}
>>  
>>  	mutex_unlock(&rdtgroup_mutex);
>>  }
>>  
>> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
>> +/**
>> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
>> + *                             domain.
>> + * @delay_ms:      How far in the future the handler should run.
>> + * @exclude_cpu:   Which CPU the handler should not run on,
>> + *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
>> + */

> arch/x86/kernel/cpu/resctrl/monitor.c:824: info: Scanning doc for function cqm_setup_limbo_handler
> arch/x86/kernel/cpu/resctrl/monitor.c:832: warning: Function parameter or member 'dom' not described in 'cqm_setup_limbo_handler'

What tool outputs this? I've run 'make ARCH=x86 htmldocs', which outputs a tonne of stuff,
but I've never found lines about resctrl in there:
| morse@eglon:~/kernel/mpam/build_x86_64$ make ARCH=x86 htmldocs &> tee  output.log
| morse@eglon:~/kernel/mpam/build_x86_64$ cat output.log | grep resctrl
| morse@eglon:~/kernel/mpam/build_x86_64$


Thanks,

James
