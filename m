Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4327812EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443988AbjLNLh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444097AbjLNLhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:37:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03CC118A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:37:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 565A9C15;
        Thu, 14 Dec 2023 03:38:42 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 485A73F738;
        Thu, 14 Dec 2023 03:37:54 -0800 (PST)
Message-ID: <cf4fa9e8-b810-35c8-d383-4ed345e0ce76@arm.com>
Date:   Thu, 14 Dec 2023 11:37:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
Content-Language: en-GB
To:     babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-15-james.morse@arm.com>
 <1d28db1a-196d-4aaf-922a-12ce31d71aa2@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <1d28db1a-196d-4aaf-922a-12ce31d71aa2@amd.com>
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

Hi Babu,

On 09/11/2023 20:42, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> MPAM's cache occupancy counters can take a little while to settle once
>> the monitor has been configured. The maximum settling time is described
>> to the driver via a firmware table. The value could be large enough
>> that it makes sense to sleep. To avoid exposing this to resctrl, it
>> should be hidden behind MPAM's resctrl_arch_rmid_read().
>>
>> resctrl_arch_rmid_read() may be called via IPI meaning it is unable
>> to sleep. In this case resctrl_arch_rmid_read() should return an error
>> if it needs to sleep. This will only affect MPAM platforms where
>> the cache occupancy counter isn't available immediately, nohz_full is
>> in use, and there are no housekeeping CPUs in the necessary domain.
>>
>> There are three callers of resctrl_arch_rmid_read():
>> __mon_event_count() and __check_limbo() are both called from a
>> non-migrateable context. mon_event_read() invokes __mon_event_count()
>> using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
>> rdtgroup_mutex() is held, meaning this cannot race with the resctrl
>> cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
>> also adds work to a per-cpu workqueue.
>>
>> The remaining call is add_rmid_to_limbo() which is called in response
>> to a user-space syscall that frees an RMID. This opportunistically
>> reads the LLC occupancy counter on the current domain to see if the
>> RMID is over the dirty threshold. This has to disable preemption to
>> avoid reading the wrong domain's value. Disabling pre-emption here
>> prevents resctrl_arch_rmid_read() from sleeping.

> I dont know what did you mean by "This has to disable preemption to
> avoid reading the wrong domain's value."

Pre-emption lets this thread be scheduled out, and potentially scheduled back in on a
different CPU, possibly in a different domain. Any code with the concept of 'this domain'
has to to ensure it can't be migrated. Disabling pre-emption is the most common way of
doing that.

Disabling pre-emption also prevents the thread from sleeping, because it can't be
scheduled out.


> Who is disabling the preemption here? Is that specific to ARM?
> Can you please make that clear? Or Am i missing something?

add_rmid_to_limbo() is calling get_cpu(), which raises the pre-empt counter.
If it only wanted the CPU number it could have just called smp_processor_id() - but that
wouldn't be safe because the thread can be migrated, meaning the cpu number can change.

All this is to ensure that cpumask_test_cpu() and resctrl_arch_rmid_read() run on the same
CPU.


Thanks,

James

>> add_rmid_to_limbo() walks each domain, but only reads the counter
>> on one domain. If the system has more than one domain, the RMID will
>> always be added to the limbo list. If the RMIDs usage was not over the
>> threshold, it will be removed from the list when __check_limbo() runs.
>> Make this the default behaviour. Free RMIDs are always added to the
>> limbo list for each domain.
>>
>> The user visible effect of this is that a clean RMID is not available
>> for re-allocation immediately after 'rmdir()' completes, this behaviour
>> was never portable as it never happened on a machine with multiple
>> domains.
>>
>> Removing this path allows resctrl_arch_rmid_read() to sleep if its called
>> with interrupts unmasked. Document this is the expected behaviour, and
>> add a might_sleep() annotation to catch changes that won't work on arm64.


>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index fa3319021881..409817b0ae2c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -464,17 +464,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>>  	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>>  
>>  	entry->busy = 0;
>> -	cpu = get_cpu();
>>  	list_for_each_entry(d, &r->domains, list) {
>> -		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
>> -			err = resctrl_arch_rmid_read(r, d, entry->closid,
>> -						     entry->rmid,
>> -						     QOS_L3_OCCUP_EVENT_ID,
>> -						     &val);
>> -			if (err || val <= resctrl_rmid_realloc_threshold)
>> -				continue;
>> -		}
>> -
>>  		/*
>>  		 * For the first limbo RMID in the domain,
>>  		 * setup up the limbo worker.
>> @@ -484,15 +474,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>>  		set_bit(idx, d->rmid_busy_llc);
>>  		entry->busy++;
>>  	}
>> -	put_cpu();
>>  
>> -	if (entry->busy) {
>> -		rmid_limbo_count++;
>> -		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> -			closid_num_dirty_rmid[entry->closid]++;
>> -	} else {
>> -		list_add_tail(&entry->list, &rmid_free_lru);
>> -	}
>> +	rmid_limbo_count++;
>> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> +		closid_num_dirty_rmid[entry->closid]++;
>>  }
>>  

