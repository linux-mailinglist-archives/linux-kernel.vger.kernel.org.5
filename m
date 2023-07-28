Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5447671D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjG1QaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjG1QaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:30:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1366C3AAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:30:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E13332F4;
        Fri, 28 Jul 2023 09:30:47 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B3383F67D;
        Fri, 28 Jul 2023 09:30:01 -0700 (PDT)
Message-ID: <5ed8081e-ad27-7320-bea3-263e858efc63@arm.com>
Date:   Fri, 28 Jul 2023 17:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 21/24] x86/resctrl: Allow overflow/limbo handlers to be
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
        dfustini@baylibre.com
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-22-james.morse@arm.com>
 <d4296dd5-a3ca-3319-8cf5-489d73195a2a@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <d4296dd5-a3ca-3319-8cf5-489d73195a2a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/06/2023 23:25, Reinette Chatre wrote:
> On 5/25/2023 11:02 AM, James Morse wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 021a8956518c..9cba8fc405b9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -79,6 +79,37 @@ static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>>  	return cpu;
>>  }
>>  
>> +/**
>> + * cpumask_any_housekeeping_but() - Chose any cpu in @mask, preferring those
>> + *			            that aren't marked nohz_full, excluding
>> + *				    the provided CPU
>> + * @mask:	The mask to pick a CPU from.
>> + * @exclude_cpu:The CPU to avoid picking.
>> + *
>> + * Returns a CPU from @mask, but not @but. If there are housekeeping CPUs that
> 
> "but not @exclude_cpu"
> 
>> + * don't use nohz_full, these are preferred.
>> + * Returns >= nr_cpu_ids if no CPUs are available.
>> + */
>> +static inline unsigned int
>> +cpumask_any_housekeeping_but(const struct cpumask *mask, int exclude_cpu)
>> +{
>> +	int cpu, hk_cpu;
> 
> Should these be unsigned int?

Yup, fixed.


>> +
>> +	cpu = cpumask_any_but(mask, exclude_cpu);
>> +	if (tick_nohz_full_cpu(cpu)) {
>> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
>> +		if  (hk_cpu == exclude_cpu) {
>> +			hk_cpu = cpumask_nth_andnot(1, mask,
>> +						    tick_nohz_full_mask);
>> +		}
>> +
> 
> These braces are not necessary.

My C parser is pretty dumb, and is easily confused by things like that....


> If they are added to help readability then
> perhaps the indentation can be reduced by using an earlier:
> 
> 	if (!tick_nohz_full_cpu(cpu))
> 		return cpu;

Even better!


>> +		if (hk_cpu < nr_cpu_ids)
>> +			cpu = hk_cpu;
>> +	}
>> +
>> +	return cpu;
>> +}
>> +
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
>>  	bool				enable_cdpl2;

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index ced933694f60..ae02185f3354 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -485,7 +485,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>>  		 * setup up the limbo worker.
>>  		 */
>>  		if (!has_busy_rmid(r, d))
>> -			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
>> +			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL, -1);
> 
> Should this -1 be RESCTRL_PICK_ANY_CPU?
> 
>>  		set_bit(idx, d->rmid_busy_llc);
>>  		entry->busy++;
>>  	}
>> @@ -810,15 +810,28 @@ void cqm_handle_limbo(struct work_struct *work)
>>  	mutex_unlock(&rdtgroup_mutex);
>>  }
>>  
>> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
>> +/**
>> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
>> + *                             domain.
>> + * @delay_ms:      How far in the future the handler should run.
>> + * @exclude_cpu:   Which CPU the handler should not run on, -1 to pick any CPU.
> 
> Should -1 be RESCTRL_PICK_ANY_CPU? 
> 
>> + */
>> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
>> +			     int exclude_cpu)
>>  {
>>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>>  	int cpu;
>>  
>> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>> -	dom->cqm_work_cpu = cpu;
>> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
>> +		cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>> +	else
>> +		cpu = cpumask_any_housekeeping_but(&dom->cpu_mask,
>> +						   exclude_cpu);
>>  
>> -	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
>> +	if (cpu < nr_cpu_ids) {
>> +		dom->cqm_work_cpu = cpu;
> 
> Should cqm_work_cpu not perhaps be set to nr_cpu_ids on failure? If it keeps
> pointing to CPU that ran worker previously there may be unexpected behavior. 
> 
> Note the different behavior between cqm_setup_limbo_handler() and
> mbm_setup_overflow_handler() in this regard.

Sure,


>> +		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
>> +	}
>>  }
>>  
>>  void mbm_handle_overflow(struct work_struct *work)

>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index ecd41762d61a..089b91133e5e 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -9,6 +9,9 @@
>>  /* CLOSID value used by the default control group */
>>  #define RESCTRL_RESERVED_CLOSID		0
>>  
>> +/* Indicates no CPU needs to be excluded */
> 
> This comment seems to just be a rewrite of the macro name.

I'm more than happy to remove it!



Thanks,

James
