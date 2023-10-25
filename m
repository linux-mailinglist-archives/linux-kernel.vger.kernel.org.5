Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17B7D72AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjJYR42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjJYR4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:56:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48AC418C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:56:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A3BFC15;
        Wed, 25 Oct 2023 10:57:04 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 677EE3F738;
        Wed, 25 Oct 2023 10:56:20 -0700 (PDT)
Message-ID: <890b7d07-575d-c18c-bd65-ea71c3472000@arm.com>
Date:   Wed, 25 Oct 2023 18:56:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-11-james.morse@arm.com>
 <2b5e62a3-3b5c-c98a-6b5e-909a021a8d4e@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <2b5e62a3-3b5c-c98a-6b5e-909a021a8d4e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 05/10/2023 21:13, Moger, Babu wrote:
> On 9/14/2023 12:21 PM, James Morse wrote:
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>> used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be
>> dirty, and held in limbo.
>>
>> Instead of allocating the first free CLOSID, on architectures where
>> CONFIG_RESCTRL_RMID_DEPENDS_ON_COSID is enabled, search
>> closid_num_dirty_rmid[] to find the cleanest CLOSID.
>>
>> The CLOSID found is returned to closid_alloc() for the free list
>> to be updated.

>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index ad6e874d9ed2..f06d3d3e0808 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -558,5 +558,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>   void __init thread_throttle_mode_init(void);
>>   void __init mbm_config_rftype_init(const char *config);
>>   void rdt_staged_configs_clear(void);
>> +bool closid_allocated(unsigned int closid);
>> +int resctrl_find_cleanest_closid(void);
>>     #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 0c783301d106..0bbed8c62d42 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -388,6 +388,48 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>>       return ERR_PTR(-ENOSPC);
>>   }
>>   +/**
>> + * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
>> + *                                  RMID are clean, or the CLOSID that has
>> + *                                  the most clean RMID.
>> + *
>> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
>> + * may not be able to allocate clean RMID. To avoid this the allocator will
>> + * choose the CLOSID with the most clean RMID.
>> + *
>> + * When the CLOSID and RMID are independent numbers, the first free CLOSID will
>> + * be returned.
>> + */
>> +int resctrl_find_cleanest_closid(void)
>> +{
>> +    u32 cleanest_closid = ~0, iter_num_dirty;
> 
> Just naming num_dirty should have been fine.  I will leave it you.

That was to make it obvious its something to do with the loop, so the value can't be
relied on outside that. I'll rename it and move the declaration into the loop, that way
its out of scope if someone tries to use it later.


>> +    int i = 0;
>> +
>> +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +    if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> +        return -EIO;
>> +
>> +    for (i = 0; i < closids_supported(); i++) {
>> +        if (closid_allocated(i))
>> +            continue;
>> +
>> +        iter_num_dirty = closid_num_dirty_rmid[i];
>> +        if (iter_num_dirty == 0)
>> +            return i;
>> +
>> +        if (cleanest_closid == ~0)
>> +            cleanest_closid = i;
>> +
>> +        if (iter_num_dirty < closid_num_dirty_rmid[cleanest_closid])
>> +            cleanest_closid = i;
>> +    }
>> +
>> +    if (cleanest_closid == ~0)
>> +        return -ENOSPC;
>> +    return cleanest_closid;
> 
> Line before the return looks clean.
> 
> *       if (cleanest_closid == ~0)
> +        return -ENOSPC;
> +
> +    return cleanest_closid;

Sure,


Thanks,

James
