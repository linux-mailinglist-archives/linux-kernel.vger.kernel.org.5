Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0868C787618
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbjHXQyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbjHXQyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:54:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A4211989
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:53:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B4831007;
        Thu, 24 Aug 2023 09:54:39 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24F133F740;
        Thu, 24 Aug 2023 09:53:56 -0700 (PDT)
Message-ID: <a391442e-585f-6daf-268d-df2250aa63e3@arm.com>
Date:   Thu, 24 Aug 2023 17:53:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 06/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-GB
To:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
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
 <20230728164254.27562-7-james.morse@arm.com>
 <4d8773f7-4219-0bc5-e7df-1be81cba05e7@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <4d8773f7-4219-0bc5-e7df-1be81cba05e7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua

On 15/08/2023 03:37, Fenghua Yu wrote:
> On 7/28/23 09:42, James Morse wrote:
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>> used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be
>> dirty, and held in limbo.
>>
>> Keep track of the number of RMID held in limbo each CLOSID has. This will
>> allow a future helper to find the 'cleanest' CLOSID when allocating.
>>
>> The array is only needed when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
>> defined. This will never be the case on x86.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index de91ca781d9f..44addc0126fc 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -43,6 +43,13 @@ struct rmid_entry {
>>    */
>>   static LIST_HEAD(rmid_free_lru);
>>   
> 
> Better to add:
> 
> #if CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID
>> +/**
>> + * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
>> + * Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
>> + * Indexed by CLOSID. Protected by rdtgroup_mutex.
>> + */
>> +static int *closid_num_dirty_rmid;
> #endif
> 
> Then the global variable won't exist on x86 to avoid confusion and space.
> 
> Some code related to the CONFIG also needs to be changed accordingly.

Uh-huh, that would force me to put #ifdef warts all over the code that accesses that variable.

Modern compilers are really smart. Because this is static, the compiler is free to remove
it if there are no users. All the users are behind if(IS_ENABLED()), meaning the compilers
dead-code elimination will cull the lot, and this variable too:
morse@eglon:~/kernel/mpam/build_x86_64/fs/resctrl$ nm -s monitor.o | grep closid_num_dirty
morse@eglon:~/kernel/mpam/build_arm64/fs/resctrl$ nm -s monitor.o | grep closid_num_dirty
0000000000000000 b closid_num_dirty_rmid
morse@eglon:~/kernel/mpam/build_arm64/fs/resctrl$


Using #ifdef is not only ugly - it prevents the compiler from seeing all the code, so the
CI build systems get worse coverage.


>> +
>>   /**
>>    * @rmid_limbo_count     count of currently unused but (potentially)
>>    *     dirty RMIDs.
>> @@ -285,6 +292,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct
>> rdt_domain *d,
>>       return 0;
>>   }
>>   +static void limbo_release_entry(struct rmid_entry *entry)
>> +{
>> +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +    rmid_limbo_count--;
>> +    list_add_tail(&entry->list, &rmid_free_lru);
>> +
>> +    if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> +        closid_num_dirty_rmid[entry->closid]--;
> 
> 
> Maybe define some helpers (along with other similar ones) in resctrl.h like this:
> 
> #ifdef CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID
> static inline void closid_num_dirty_rmid_dec(struct rmid_entry *entry)
> {
>         closid_num_dirty_rmid[entry->closid]--;
> }
> ...
> #else
> static inline void closid_num_dirty_rmid_dec(struct rmid_entry *unused)
> {
> }
> ...
> #endif
> 
> Then directly call the helper here:
> 
> +        closid_num_dirty_rmid_dec(entry);
> 
> On x86 this is noop without

and the compiler knows this.


> occupy any space

Literally more lines of code.


> and cleaner code.

Maybe, this would hide the IS_ENABLED() check - but moving that out as a single use helper
would required closid_num_dirty_rmid[] to be exported from this file - which would prevent
it being optimised out. You'd get the result you were trying to avoid.


>> +}
>> +
>>   /*
>>    * Check the RMIDs that are marked as busy for this domain. If the
>>    * reported LLC occupancy is below the threshold clear the busy bit and
>> @@ -321,10 +339,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>             if (force_free || !rmid_dirty) {
>>               clear_bit(idx, d->rmid_busy_llc);
>> -            if (!--entry->busy) {
>> -                rmid_limbo_count--;
>> -                list_add_tail(&entry->list, &rmid_free_lru);
>> -            }
>> +            if (!--entry->busy)
>> +                limbo_release_entry(entry);
>>           }
>>           cur_idx = idx + 1;
>>       }
>> @@ -391,6 +407,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>>       u64 val = 0;
>>       u32 idx;
>>   +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>>       idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>>         entry->busy = 0;
>> @@ -416,9 +434,11 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>>       }
>>       put_cpu();
>>   -    if (entry->busy)
>> +    if (entry->busy) {
>>           rmid_limbo_count++;
>> -    else
>> +        if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> +            closid_num_dirty_rmid[entry->closid]++;
> 
> Ditto.
> 
>> +    } else
>>           list_add_tail(&entry->list, &rmid_free_lru);
>>   }
>>   @@ -782,13 +802,28 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned
>> long delay_ms)
>>   static int dom_data_init(struct rdt_resource *r)
>>   {
>>       u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>> +    u32 num_closid = resctrl_arch_get_num_closid(r);
>>       struct rmid_entry *entry = NULL;
>>       u32 idx;
>>       int i;
>>   +    if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>> +        int *tmp;
>> +
>> +        tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);
>> +        if (!tmp)
>> +            return -ENOMEM;
>> +
>> +        mutex_lock(&rdtgroup_mutex);

> data_init() is called in __init. No need to lock here, right?

__init code can still race with other callers - especially as there are
CPUHP_AP_ONLINE_DYN cpuhp callbacks that are expected to sleep.

This is about ensuring all accesses to those global variables are protected by the lock.
This saves me a memory ordering headache.


Thanks,

James
