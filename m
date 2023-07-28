Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CEE7671DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjG1Qcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjG1Qco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:32:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C23AA30FA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:32:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BAD92F4;
        Fri, 28 Jul 2023 09:33:25 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0B6A3F67D;
        Fri, 28 Jul 2023 09:32:39 -0700 (PDT)
Message-ID: <cabf6ebd-1fba-d73f-b281-12f70d53ef55@arm.com>
Date:   Fri, 28 Jul 2023 17:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
 <20230525180209.19497-15-james.morse@arm.com>
 <201aff6a-7bd0-e0e6-5ee8-1b9eab223cb0@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <201aff6a-7bd0-e0e6-5ee8-1b9eab223cb0@intel.com>
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

On 15/06/2023 23:13, Reinette Chatre wrote:
> On 5/25/2023 11:01 AM, James Morse wrote:
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
>> in use, and there are there are no housekeeping CPUs in the necessary
>> domain.
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
>> to a user-space syscall that frees an rmid. This opportunistically
>> reads the llc occupancy counter on the current domain to see if the
>> RMID is over the dirty threshold. This has to disable preemption to
>> avoid reading the wrong domain's value. Disabling pre-emption here
>> prevents resctrl_arch_rmid_read() from sleeping.
>>
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
>> index 6ba40495589a..fb33100e172b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -491,7 +481,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>>  		set_bit(idx, d->rmid_busy_llc);
>>  		entry->busy++;
>>  	}
>> -	put_cpu();
>>  
>>  	if (entry->busy)
>>  		rmid_limbo_count++;
> 
> Would entry->busy ever be 0 after this change?

Good point - the domains list can never be empty!


>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index ff7452f644e4..b961936decfa 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -234,7 +234,12 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>>   * @eventid:		eventid to read, e.g. L3 occupancy.
>>   * @val:		result of the counter read in bytes.
>>   *
>> - * Call from process context on a CPU that belongs to domain @d.
>> + * Some architectures need to sleep when first programming some of the counters.
>> + * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
>> + *  for a short period of time). Call from a non-migrateable process context on
>> + * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
>> + * schedule_work_on(). This function can be called with interrupts masked,
>> + * e.g. using smp_call_function_any(), but may concistently return an error.
>>   *
> 
> concistently -> consistently?
> 
>>   * Return:
>>   * 0 on success, or -EIO, -EINVAL etc on error.
>> @@ -243,6 +248,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>>  			   u64 *val);
>>  
>> +/**
>> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
>> + *
>> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP, this function will generate a
>> + * warning when resctrl_arch_rmid_read() is called from an invalid context.
> 
> No need to say "this function" 
> Could this comment be more specific about which contexts are invalid instead of
> just referring to it as "invalid context". This seems to expect the reader to
> already know what an invalid context would be. 

I thought the implementation was enough - the comment was intended to say this does
nothing unless you select that build option. I've changed it to:
| * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
| * resctrl_arch_rmid_read() is called with preemption disabled.


>> + */
>> +static inline void resctrl_arch_rmid_read_context_check(void)
>> +{
>> +	if (!irqs_disabled())
>> +		might_sleep();
>> +}

> Could you please elaborate why the "!irqs_disabled()" is needed?

It's a question of what the interface should support.
It needs to support being called via IPI because that is going to happen on NOHZ_FULL
platforms. In this case the platforms where the MPAM code needs to sleep will have to
return an error. For folk that see this in practice: they need at least one housekeeping
CPU per domain.

Outside that the function shouldn't be called with pre-emption disabled, as that would
prevent it from sleeping, but the lockdep annotations that check for pre-emption also go
off when interrupts are masked, hence the slightly funny check.

It's documented against resctrl_arch_rmid_read():
| * Some architectures need to sleep when first programming some of the counters.
| * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
| *  for a short period of time). Call from a non-migrateable process context on
| * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
| * schedule_work_on(). This function can be called with interrupts masked,
| * e.g. using smp_call_function_any(), but may consistently return an error.


Thanks,

James
