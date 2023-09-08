Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E45798A44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbjIHP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbjIHP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:58:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8481D1BF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:58:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 358281007;
        Fri,  8 Sep 2023 08:59:04 -0700 (PDT)
Received: from [10.57.5.217] (unknown [10.57.5.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034FF3F7B4;
        Fri,  8 Sep 2023 08:58:22 -0700 (PDT)
Message-ID: <9d69d0ca-212d-9b1b-3001-9f56731e48fd@arm.com>
Date:   Fri, 8 Sep 2023 16:58:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
 <20230728164254.27562-15-james.morse@arm.com>
 <4a0f777e-5dec-296e-c326-61e3630c3608@intel.com>
 <b842c00b-7537-a14a-1a2a-a9a17b98bbce@arm.com>
 <5c0a3df6-3b1c-ff99-194e-3c7901ffa716@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <5c0a3df6-3b1c-ff99-194e-3c7901ffa716@intel.com>
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

On 8/25/23 00:02, Reinette Chatre wrote:
> On 8/24/2023 9:56 AM, James Morse wrote:
>> On 09/08/2023 23:36, Reinette Chatre wrote:
>>> On 7/28/2023 9:42 AM, James Morse wrote:
>>>> MPAM's cache occupancy counters can take a little while to settle once
>>>> the monitor has been configured. The maximum settling time is described
>>>> to the driver via a firmware table. The value could be large enough
>>>> that it makes sense to sleep. To avoid exposing this to resctrl, it
>>>> should be hidden behind MPAM's resctrl_arch_rmid_read().
>>>>
>>>> resctrl_arch_rmid_read() may be called via IPI meaning it is unable
>>>> to sleep. In this case resctrl_arch_rmid_read() should return an error
>>>> if it needs to sleep. This will only affect MPAM platforms where
>>>> the cache occupancy counter isn't available immediately, nohz_full is
>>>> in use, and there are there are no housekeeping CPUs in the necessary
>>>> domain.
>>>>
>>>> There are three callers of resctrl_arch_rmid_read():
>>>> __mon_event_count() and __check_limbo() are both called from a
>>>> non-migrateable context. mon_event_read() invokes __mon_event_count()
>>>> using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
>>>> rdtgroup_mutex() is held, meaning this cannot race with the resctrl
>>>> cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
>>>> also adds work to a per-cpu workqueue.
>>>>
>>>> The remaining call is add_rmid_to_limbo() which is called in response
>>>> to a user-space syscall that frees an RMID. This opportunistically
>>>> reads the LLC occupancy counter on the current domain to see if the
>>>> RMID is over the dirty threshold. This has to disable preemption to
>>>> avoid reading the wrong domain's value. Disabling pre-emption here
>>>> prevents resctrl_arch_rmid_read() from sleeping.
>>>>
>>>> add_rmid_to_limbo() walks each domain, but only reads the counter
>>>> on one domain. If the system has more than one domain, the RMID will
>>>> always be added to the limbo list. If the RMIDs usage was not over the
>>>> threshold, it will be removed from the list when __check_limbo() runs.
>>>> Make this the default behaviour. Free RMIDs are always added to the
>>>> limbo list for each domain.
>>>>
>>>> The user visible effect of this is that a clean RMID is not available
>>>> for re-allocation immediately after 'rmdir()' completes, this behaviour
>>>> was never portable as it never happened on a machine with multiple
>>>> domains.
>>>>
>>>> Removing this path allows resctrl_arch_rmid_read() to sleep if its called
>>>> with interrupts unmasked. Document this is the expected behaviour, and
>>>> add a might_sleep() annotation to catch changes that won't work on arm64.
>>
>>
>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>> index 660752406174..f7311102e94c 100644
>>>> --- a/include/linux/resctrl.h
>>>> +++ b/include/linux/resctrl.h
>>>> @@ -245,6 +250,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>>>   			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>>>>   			   u64 *val);
>>>>   
>>>> +/**
>>>> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
>>>> + *
>>>> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
>>>> + * resctrl_arch_rmid_read() is called with preemption disabled.
>>>> + */
>>>> +static inline void resctrl_arch_rmid_read_context_check(void)
>>>> +{
>>>> +	if (!irqs_disabled())
>>>> +		might_sleep();
>>>> +}
>>
>>> Apologies but even after rereading the patch as well as your response to
>>> the previous patch version several times I am not able to understand why the
>>> code is looking like above. If, like according to the comment above, a
>>> warning should be generated with preemption disabled, then should it not
>>> just be "might_sleep()" without the "!irqs_disabled()" check?
>>
>> This would be simpler. But for NOHZ_FULL you wanted to keep the IPI, so the contract with
>> resctrl_arch_rmid_read() is that if interrupts are unmasked, it can sleep.
> 
> Thank you. This appears to be the key. Could you please add this
> information to resctrl_arch_rmid_read_context_check()'s description?

That comment now reads:
  * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
  *
  * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
  * resctrl_arch_rmid_read() is called with preemption disabled.
  *
  * The contract with resctrl_arch_rmid_read() is that if interrupts
  * are unmasked, it can sleep. This allows NOHZ_FULL systems to use an
  * IPI, (and fail if the call needed to sleep), while most of the time
  * the work is scheduled, allowing the call to sleep.



Thanks,

James
