Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06E78761E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbjHXQzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242777AbjHXQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:55:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3AEC199D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:54:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A39031007;
        Thu, 24 Aug 2023 09:55:38 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70AE13F740;
        Thu, 24 Aug 2023 09:54:55 -0700 (PDT)
Message-ID: <55dba278-b4a8-4b5a-d5c6-feba81e5d5d4@arm.com>
Date:   Thu, 24 Aug 2023 17:54:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 08/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
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
 <20230728164254.27562-9-james.morse@arm.com>
 <74e8de12-f35d-d7e7-7b0f-56546ab8e0d2@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <74e8de12-f35d-d7e7-7b0f-56546ab8e0d2@intel.com>
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

Hi Fenghua,

On 15/08/2023 03:59, Fenghua Yu wrote:
> On 7/28/23 09:42, James Morse wrote:
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


>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 44addc0126fc..c268aa5925c7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -379,6 +379,48 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
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
>> +}
>> +
> 
> resctrl_find_cleanest_closid() is not empty on x86 after compiled although it's very
> short. After all, the function is irrelevant to x86 and could be completely empty on x86.
> 
> If put the function in
> #ifdef CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID
> resctrl_find_cleanest_closid()
> ...
> #else
> resctrl_find_cleanest_closid() {}
> #endif
> 
> It's fully empty on x86.

I think you forgot the return type. You'd still need to return an error in the stub -
which is what the existing function will be reduced to by the compilers dead code elimination.

Here is the existing function on x86:
| 0000000000000680 <resctrl_find_cleanest_closid>:
|  680:   f3 0f 1e fa             endbr64
|  684:   b8 fb ff ff ff          mov    $0xfffffffb,%eax
|  689:   e9 00 00 00 00          jmp    68e <resctrl_find_cleanest_closid+0xe>
|  68e:   66 90                   xchg   %ax,%ax
|  690:   90                      nop
|  691:   90                      nop
[and quite a few more nops]

and here is the stub you propose:
| int resctrl_find_cleanest_closid_as_a_stub(void)
| {
| 	return -EIO;
| }

which builds as:
| 00000000000006a0 <resctrl_find_cleanest_closid_as_a_stub>:
|  6a0:   f3 0f 1e fa             endbr64
|  6a4:   b8 fb ff ff ff          mov    $0xfffffffb,%eax
|  6a9:   e9 00 00 00 00          jmp    6ae <resctrl_find_cleanest_closid_as_a_s>
|  6ae:   66 90                   xchg   %ax,%ax
|  6b0:   90                      nop
|  6b1:   90                      nop
[and quite a few more nops]

The only difference is the #ifdeffery makes this hard to read, and means CI systems need
extra Kconfig files to get good coverage of this code.

It's not the 90s anymore: we no-one wants to see an #ifdef!


James
