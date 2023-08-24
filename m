Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21846787631
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbjHXQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbjHXQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:56:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79DE11989
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:56:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 834AE1007;
        Thu, 24 Aug 2023 09:57:00 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B4173F740;
        Thu, 24 Aug 2023 09:56:17 -0700 (PDT)
Message-ID: <b842c00b-7537-a14a-1a2a-a9a17b98bbce@arm.com>
Date:   Thu, 24 Aug 2023 17:56:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
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
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-15-james.morse@arm.com>
 <4a0f777e-5dec-296e-c326-61e3630c3608@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <4a0f777e-5dec-296e-c326-61e3630c3608@intel.com>
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

On 09/08/2023 23:36, Reinette Chatre wrote:
> On 7/28/2023 9:42 AM, James Morse wrote:
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
>> to a user-space syscall that frees an RMID. This opportunistically
>> reads the LLC occupancy counter on the current domain to see if the
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


>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 660752406174..f7311102e94c 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -236,7 +236,12 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>>   * @eventid:		eventid to read, e.g. L3 occupancy.
>>   * @val:		result of the counter read in bytes.
>>   *
>> - * Call from process context on a CPU that belongs to domain @d.
>> + * Some architectures need to sleep when first programming some of the counters.
>> + * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
>> + *  for a short period of time). Call from a non-migrateable process context on
>> + * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
>> + * schedule_work_on(). This function can be called with interrupts masked,
>> + * e.g. using smp_call_function_any(), but may consistently return an error.
> 
> Considering that smp_call_function_any() explicitly disables preemption I
> would like to learn more about why did you chose to word as "interrupts masked" vs
> "preemption disabled"?

smp_call_function_any() while it works out which CPU to run on, which may be this CPU. It
can't be migrated once it has picked the CPU to run on. But actually doing the work is
done by generic_exec_single(). This masks interrupts if calling locally, or invokes
__smp_call_single_queue() to raise the IPI. Obviously the other end of an IPI is running
with interrupts masked.

(If you wanted to schedule work on a remote CPU, that would be smp_call_on_cpu())


>>   *
>>   * Return:
>>   * 0 on success, or -EIO, -EINVAL etc on error.
>> @@ -245,6 +250,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>>  			   u64 *val);
>>  
>> +/**
>> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
>> + *
>> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
>> + * resctrl_arch_rmid_read() is called with preemption disabled.
>> + */
>> +static inline void resctrl_arch_rmid_read_context_check(void)
>> +{
>> +	if (!irqs_disabled())
>> +		might_sleep();
>> +}

> Apologies but even after rereading the patch as well as your response to
> the previous patch version several times I am not able to understand why the
> code is looking like above. If, like according to the comment above, a
> warning should be generated with preemption disabled, then should it not
> just be "might_sleep()" without the "!irqs_disabled()" check?

This would be simpler. But for NOHZ_FULL you wanted to keep the IPI, so the contract with
resctrl_arch_rmid_read() is that if interrupts are unmasked, it can sleep.

If it needs to sleep, the arch code has to check.
A bare might_sleep() would fire when called via IPI when NOHZ_FULL is enabled.

This check is about ensuring all code paths get checked for this condition, as it doesn't
matter for x86.


This results in MPAM's implementation of resctrl_arch_rmid_read() checking if interrupts
are masked before sending an IPI when it has to read the counters from a set of CPUs. In
the NOHZ_FULL case it can't do this, so it will always return an error.
Platforms needing this should be few and far between, I'm hoping people running NOHZ_FULL
on them is even rarer... they'd need to carefully select their housekeeping CPUs to make
this work.


> I understand how for MPAM you want its code to be called in two different
> contexts so I assume that the MPAM code would have two different paths,
> one that can sleep and the other that cannot, both valid. It thus sounds
> as though you want the x86 code to have context checks so that any issues
> that could impact arm can be caught on x86? In that case, should the
> x86 code also rather have two paths (one unused and the other has the
> context check)?

I did toy with having resctrl_arch_rmid_read_nosleep() and resctrl_arch_rmid_read(). But
this resulted in more code for both architectures, I felt it was simpler to just document
this requirement with this check. It's what resctrl is already doing.

resctrl_arch_rmid_read_nosleep() could be called from irq context.
resctrl_arch_rmid_read() can sleep.

On x86 resctrl_arch_rmid_read() would call resctrl_arch_rmid_read_nosleep() ... and on
arm64 the exact same thing would happen as the interrupts_disabled() check is buried deep
in the mpam driver, the resctrl glue code doesn't need to check for this.

The split approach would be simpler to document - but much more confusing as both
architectures call one helper from the other.


Thanks,

James
