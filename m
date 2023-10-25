Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9E7D72AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJYR4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:56:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B192B138
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:56:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC5F41FB;
        Wed, 25 Oct 2023 10:56:48 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF32A3F738;
        Wed, 25 Oct 2023 10:56:03 -0700 (PDT)
Message-ID: <d5842ad2-12d2-5f1f-2fcc-0bec49646d06@arm.com>
Date:   Wed, 25 Oct 2023 18:55:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 24/24] x86/resctrl: Separate arch and fs resctrl locks
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
 <20230914172138.11977-25-james.morse@arm.com>
 <9d4282af-7237-0c26-7c48-e2b9e2fb7795@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <9d4282af-7237-0c26-7c48-e2b9e2fb7795@intel.com>
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

On 03/10/2023 22:28, Reinette Chatre wrote:
> On 9/14/2023 10:21 AM, James Morse wrote:
>> resctrl has one mutex that is taken by the architecture specific code,
>> and the filesystem parts. The two interact via cpuhp, where the
>> architecture code updates the domain list. Filesystem handlers that
>> walk the domains list should not run concurrently with the cpuhp
>> callback modifying the list.
>>
>> Exposing a lock from the filesystem code means the interface is not
>> cleanly defined, and creates the possibility of cross-architecture
>> lock ordering headaches. The interaction only exists so that certain
>> filesystem paths are serialised against CPU hotplug. The CPU hotplug
>> code already has a mechanism to do this using cpus_read_lock().
>>
>> MPAM's monitors have an overflow interrupt, so it needs to be possible
>> to walk the domains list in irq context. RCU is ideal for this,
>> but some paths need to be able to sleep to allocate memory.
>>
>> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
>> of a cpuhp callback, cpus_read_lock() must always be taken first.
>> rdtgroup_schemata_write() already does this.
>>
>> Most of the filesystem code's domain list walkers are currently
>> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
>> The exceptions are rdt_bit_usage_show() and the mon_config helpers
>> which take the lock directly.
>>
>> Make the domain list protected by RCU. An architecture-specific
>> lock prevents concurrent writers. rdt_bit_usage_show() could
>> walk the domain list using RCU, but to keep all the filesystem
>> operations the same, this is changed to call cpus_read_lock().
>> The mon_config helpers send multiple IPIs, take the cpus_read_lock()
>> in these cases.
>>
>> The other filesystem list walkers need to be able to sleep.
>> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
>> cpuhp callbacks can't be invoked when file system operations are
>> occurring.
>>
>> Add lockdep_assert_cpus_held() in the cases where the
>> rdtgroup_kn_lock_live() call isn't obvious.

> One place that does not seem to have this annotation that
> I think is needed is within get_domain_from_cpu(). Starting
> with this series it is called from resctrl_offline_cpu()
> called via CPU hotplug code. From now on extra care needs to be
> taken when trying to call it from anywhere else.

Excellent! This shows that the overflow/limbo threads are now exposed to CPUs going
offline while they run - I'll fix that.

But, this gets called via IPI from rdt_ctrl_update(), and lockdep can't know who the IPI
came from to check the lock was held, so it triggers false positives. This one will look a
bit funny:
|       /*
|        * Walking r->domains, ensure it can't race with cpuhp.
|        * Because this is called via IPI by rdt_ctrl_update(), assertions
|        * about locks this thread holds will lead to false positives. Check
|        * someone is holding the CPUs lock.
|        */
|       if (IS_ENABLED(CONFIG_LOCKDEP))
|               lockdep_is_cpus_held();


>> Resctrl's domain online/offline calls now need to take the
>> rdtgroup_mutex themselves.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 1a10f567bbe5..8fd0510d767b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -25,8 +25,15 @@
>>  #include <asm/resctrl.h>
>>  #include "internal.h"
>>  
>> -/* Mutex to protect rdtgroup access. */
>> -DEFINE_MUTEX(rdtgroup_mutex);
>> +/*
>> + * rdt_domain structures are kfree()d when their last CPU goes offline,
>> + * and allocated when the first CPU in a new domain comes online.
>> + * The rdt_resource's domain list is updated when this happens. Readers of
>> + * the domain list must either take cpus_read_lock(), or rely on an RCU
>> + * read-side critical section, to avoid observing concurrent modification.
>> + * All writers take this mutex:
>> + */
>> +static DEFINE_MUTEX(domain_list_lock);
>>  
> 
> I assume that you have not followed the SNC work. Please note that in 
> that work the domain list is split between a monitoring domain list and
> control domain list. I expect this lock would cover both and both would
> be rcu lists?

It's on my list to read through, but too much arm stuff comes up for me to get to it.
I agree that one write-lock to protect both RCU lists makes sense, those would only ever
be modified together. The case I have for needing to walk the list without taking a lock
only applies to the monitors - but keeping the rules the same makes it easier to think about.


>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index b4ed4e1b4938..0620dfc72036 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c

>> @@ -535,7 +541,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>  	int cpu;
>>  
>>  	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
>> -	lockdep_assert_held(&rdtgroup_mutex);
>> +	lockdep_assert_cpus_held();
>>  
> 
> Only now is that comment accurate. Could it be moved to this patch?

Before this patch resctrl_arch_offline_cpu() took the mutex, if this thread held the
mutex, then cpuhp would get blocked in resctrl_arch_offline_cpu() until it was released.
What has changed is how that mutual-exclusion is provided, but the comment describes why
mutual-exclusion is needed.



>> @@ -3801,6 +3832,13 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  	domain_destroy_mon_state(d);
>>  }
>>  
>> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>> +{
>> +	mutex_lock(&rdtgroup_mutex);
>> +	_resctrl_offline_domain(r, d);
>> +	mutex_unlock(&rdtgroup_mutex);
>> +}
>> +

> This seems unnecessary. Why not keep resctrl_offline_domain() as-is and just
> take the lock within it?

For offline there is nothing in it, but ....


>> @@ -3870,12 +3908,23 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  	return 0;
>>  }
>>  
>> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>> +{
>> +	int err;
>> +
>> +	mutex_lock(&rdtgroup_mutex);
>> +	err = _resctrl_online_domain(r, d);
>> +	mutex_unlock(&rdtgroup_mutex);
>> +
>> +	return err;
>> +}
>> +
> 
> Same here.

resctrl_online_domain() has four exit paths, like this they can just return an error, and
the locking is taken care of here to keep the churn down.
But it's just preference - I've changed it to do this with a handful of gotos.


Thanks,

James
