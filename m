Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA806762B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjGZGUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjGZGUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:20:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2041982
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:20:29 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9kFV4SFLzCrVn;
        Wed, 26 Jul 2023 14:17:02 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:20:24 +0800
Message-ID: <3149f5f8-7878-dfe1-5745-870fddcc1108@huawei.com>
Date:   Wed, 26 Jul 2023 14:20:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <mawupeng1@huawei.com>, <catalin.marinas@arm.com>,
        <akpm@linux-foundation.org>, <sudaraja@codeaurora.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>
Subject: Re: [RFC PATCH] arm64: mm: Fix kernel page tables incorrectly deleted
 during memory removal
Content-Language: en-US
To:     <david@redhat.com>, <anshuman.khandual@arm.com>, <will@kernel.org>
References: <20230717115150.1806954-1-mawupeng1@huawei.com>
 <20230721103628.GA12601@willie-the-truck>
 <35a0dad6-4f3b-f2c3-f835-b13c1e899f8d@huawei.com>
 <c49c5f19-99d3-0a1f-88c6-03f60587b38c@arm.com>
 <732e0db0-eb41-6c58-85b7-46257b4ba0b7@redhat.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <732e0db0-eb41-6c58-85b7-46257b4ba0b7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/24 14:11, David Hildenbrand wrote:
> On 24.07.23 07:54, Anshuman Khandual wrote:
>>
>>
>> On 7/24/23 06:55, mawupeng wrote:
>>>
>>> On 2023/7/21 18:36, Will Deacon wrote:
>>>> On Mon, Jul 17, 2023 at 07:51:50PM +0800, Wupeng Ma wrote:
>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>
>>>>> During our test, we found that kernel page table may be unexpectedly
>>>>> cleared with rodata off. The root cause is that the kernel page is
>>>>> initialized with pud size(1G block mapping) while offline is memory
>>>>> block size(MIN_MEMORY_BLOCK_SIZE 128M), eg, if 2G memory is hot-added,
>>>>> when offline a memory block, the call trace is shown below,
> 
> Is someone adding memory in 2 GiB granularity and then removing parts of it in 128 MiB granularity? That would be against what we support using the add_memory() / offline_and_remove_memory() API and that driver should be fixed instead.

Yes, this kind of situation.

The problem occurs in the following scenarios:
1. use mem=xxG to reserve memory.
2. add_momory to online memory.
3. offline part of the memroy via offline_and_remove_memory.

During my research, ACPI memory removal use memory_subsys_offline to offline memory section and
this will not delete page table entry which do not trigger this kind of problem.

So I understand what you are talking about.
1. 3rd-party driver shouldn't use add_memory/offline_and_remove_memory to online/offline memory.
   If it have to use, this can be achieved by driver.
2. memory_subsys_offline is perfered to do such thing.

Should we update the doc to describe this kind of limitation?

> 
> Or does this trigger only when a hotplugged memory block falls into the same 2 GiB area as boot memor> 
>>>>>
>>>>>   offline_and_remove_memory
>>>>>      try_remove_memory
>>>>>        arch_remove_memory
>>>>>         __remove_pgd_mapping
>>>>>           unmap_hotplug_range
>>>>>             unmap_hotplug_p4d_range
>>>>>               unmap_hotplug_pud_range
>>>>>                 if (pud_sect(pud))
>>>>>                   pud_clear(pudp);
> 
> Which drivers triggers that? In-tree is only virtio-mem and dax/kmem. Both add and remove memory in the same granularity.

It is 3rd-party driver. which use try to offline part of(128M) movable memory and this lead to the problem.

> 
> For example, virtio-mem will only call add_memory(memory_block_size()) to then offline_and_remove_memory(memory_block_size()).
> 
> Could that trigger it as well?
> 
>>>> Sorry, but I'm struggling to understand the problem here. If we're adding
>>>> and removing a 2G memory region, why _wouldn't_ we want to use large 1GiB
>>>> mappings?
>>>
>>>> Or are you saying that only a subset of the memory is removed,
>>>> but we then accidentally unmap the whole thing?
>>> Yes, umap a subset but the whole thing page table entry is removed.
>>>
> 
> Can we have some more details about the user and how to trigger it?
> 
>>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>>> index 95d360805f8a..44c724ce4f70 100644
>>>>> --- a/arch/arm64/mm/mmu.c
>>>>> +++ b/arch/arm64/mm/mmu.c
>>>>> @@ -44,6 +44,7 @@
>>>>>   #define NO_BLOCK_MAPPINGS    BIT(0)
>>>>>   #define NO_CONT_MAPPINGS    BIT(1)
>>>>>   #define NO_EXEC_MAPPINGS    BIT(2)    /* assumes FEAT_HPDS is not used */
>>>>> +#define NO_PUD_MAPPINGS        BIT(3)
>>>>>     int idmap_t0sz __ro_after_init;
>>>>>   @@ -344,7 +345,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>>>>            */
>>>>>           if (pud_sect_supported() &&
>>>>>              ((addr | next | phys) & ~PUD_MASK) == 0 &&
>>>>> -            (flags & NO_BLOCK_MAPPINGS) == 0) {
>>>>> +            (flags & (NO_BLOCK_MAPPINGS | NO_PUD_MAPPINGS)) == 0) {
>>>>>               pud_set_huge(pudp, phys, prot);
>>>>>                 /*
>>>>> @@ -1305,7 +1306,7 @@ struct range arch_get_mappable_range(void)
>>>>>   int arch_add_memory(int nid, u64 start, u64 size,
>>>>>               struct mhp_params *params)
>>>>>   {
>>>>> -    int ret, flags = NO_EXEC_MAPPINGS;
>>>>> +    int ret, flags = NO_EXEC_MAPPINGS | NO_PUD_MAPPINGS;
>>>> I think we should allow large mappings here and instead prevent partial
>>>> removal of the block, if that's what is causing the issue.
>>> This could solve this problem.
>>> Or we can prevent  partial removal? Or rebulid page table entry which is not removed?
>>
>> + David Hildenbrand <david@redhat.com>
>>
>> Splitting the block mapping and rebuilding page table entry to reflect non-removed
>> areas will require additional information such as flags and pgtable alloc function
>> as in __create_pgd_mapping(), which need to be passed along, depending on whether
>> it's tearing down vmemmap (would not have PUD block map) or linear mapping. But I
>> am just wondering if we have to go in that direction at all or just prevent partial
>> memory block removal as suggested by Will.
>>
>> - arch_remove_memory() does not have return type, core MM hotremove would not fail
>>    because arch_remove_memory() failed or warned
>>
>> - core MM hotremove does check_hotplug_memory_range() which ensures the range and
>>    start address are memory_block_size_bytes() aligned
>>
>> - Default memory_block_size_bytes() is dependent on SECTION_SIZE_BITS which on arm64
>>    now can be less than PUD_SIZE triggering this problem.
>>
>>     #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
>>
>>     unsigned long __weak memory_block_size_bytes(void)
>>     {
>>              return MIN_MEMORY_BLOCK_SIZE;
>>     }
>>     EXPORT_SYMBOL_GPL(memory_block_size_bytes);
>>
>> - We would need to override memory_block_size_bytes() on arm64 to accommodate such
>>    scenarios here
>>
>> Something like this might work (built but not tested)
>>
>> commit 2eb8dc0d08dfe0b2a3bb71df93b12f7bf74a2ca6 (HEAD)
>> Author: Anshuman Khandual <anshuman.khandual@arm.com>
>> Date:   Mon Jul 24 06:45:34 2023 +0100
>>
>>      arm64/mm: Define memory_block_size_bytes()
>>           Define memory_block_size_bytes() on arm64 platforms to set minimum hot plug
>>      and remove granularity as PUD_SIZE in case where MIN_MEMORY_BLOCK_SIZE just
>>      falls below PUD_SIZE. Otherwise a complete PUD block mapping will be teared
>>      down while unmapping MIN_MEMORY_BLOCK_SIZE range.
>>           Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 95d360805f8a..1918459b3460 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1157,6 +1157,17 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>   }
>>     #ifdef CONFIG_MEMORY_HOTPLUG
>> +unsigned long memory_block_size_bytes(void)
>> +{
>> +       /*
>> +        * Linear mappings might include PUD based block mappings which
>> +        * cannot be teared down in part during memory hotremove. Hence
>> +        * PUD_SIZE needs to be the minimum granularity, for memory hot
>> +        * removal in case MIN_MEMORY_BLOCK_SIZE falls below.
>> +        */
>> +       return max_t(unsigned long, MIN_MEMORY_BLOCK_SIZE, PUD_SIZE);
>> +}
>> +
>>   void vmemmap_free(unsigned long start, unsigned long end,
>>                  struct vmem_altmap *altmap)
>>   {
>>
> 
> OH god no. That would seriously degrade memory hotplug capabilities in virtual environments (especially, virtio-mem and DIMMS).
> 
> If someone adds memory in 128 MiB chunks and removes memory in 128 MiB chunks, that has to be working.
> 
> Removing boot memory is blocked via register_memory_notifier(&prevent_bootmem_remove_nb);
> 
