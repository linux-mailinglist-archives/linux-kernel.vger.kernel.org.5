Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36D875EB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGXFyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGXFyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:54:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 048121AD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 22:54:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2DDDE0;
        Sun, 23 Jul 2023 22:55:27 -0700 (PDT)
Received: from [10.162.41.7] (a077893.blr.arm.com [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E157F3F67D;
        Sun, 23 Jul 2023 22:54:40 -0700 (PDT)
Message-ID: <c49c5f19-99d3-0a1f-88c6-03f60587b38c@arm.com>
Date:   Mon, 24 Jul 2023 11:24:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] arm64: mm: Fix kernel page tables incorrectly deleted
 during memory removal
Content-Language: en-US
To:     mawupeng <mawupeng1@huawei.com>, will@kernel.org,
        David Hildenbrand <david@redhat.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        sudaraja@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
References: <20230717115150.1806954-1-mawupeng1@huawei.com>
 <20230721103628.GA12601@willie-the-truck>
 <35a0dad6-4f3b-f2c3-f835-b13c1e899f8d@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <35a0dad6-4f3b-f2c3-f835-b13c1e899f8d@huawei.com>
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



On 7/24/23 06:55, mawupeng wrote:
> 
> On 2023/7/21 18:36, Will Deacon wrote:
>> On Mon, Jul 17, 2023 at 07:51:50PM +0800, Wupeng Ma wrote:
>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>
>>> During our test, we found that kernel page table may be unexpectedly
>>> cleared with rodata off. The root cause is that the kernel page is
>>> initialized with pud size(1G block mapping) while offline is memory
>>> block size(MIN_MEMORY_BLOCK_SIZE 128M), eg, if 2G memory is hot-added,
>>> when offline a memory block, the call trace is shown below,
>>>
>>>  offline_and_remove_memory
>>>     try_remove_memory
>>>       arch_remove_memory
>>>        __remove_pgd_mapping
>>>          unmap_hotplug_range
>>>            unmap_hotplug_p4d_range
>>>              unmap_hotplug_pud_range
>>>                if (pud_sect(pud))
>>>                  pud_clear(pudp);
>> Sorry, but I'm struggling to understand the problem here. If we're adding
>> and removing a 2G memory region, why _wouldn't_ we want to use large 1GiB
>> mappings?
> 
>> Or are you saying that only a subset of the memory is removed,
>> but we then accidentally unmap the whole thing?
> Yes, umap a subset but the whole thing page table entry is removed.
> 
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 95d360805f8a..44c724ce4f70 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -44,6 +44,7 @@
>>>  #define NO_BLOCK_MAPPINGS	BIT(0)
>>>  #define NO_CONT_MAPPINGS	BIT(1)
>>>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>>> +#define NO_PUD_MAPPINGS		BIT(3)
>>>  
>>>  int idmap_t0sz __ro_after_init;
>>>  
>>> @@ -344,7 +345,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>>  		 */
>>>  		if (pud_sect_supported() &&
>>>  		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
>>> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>>> +		    (flags & (NO_BLOCK_MAPPINGS | NO_PUD_MAPPINGS)) == 0) {
>>>  			pud_set_huge(pudp, phys, prot);
>>>  
>>>  			/*
>>> @@ -1305,7 +1306,7 @@ struct range arch_get_mappable_range(void)
>>>  int arch_add_memory(int nid, u64 start, u64 size,
>>>  		    struct mhp_params *params)
>>>  {
>>> -	int ret, flags = NO_EXEC_MAPPINGS;
>>> +	int ret, flags = NO_EXEC_MAPPINGS | NO_PUD_MAPPINGS;
>> I think we should allow large mappings here and instead prevent partial
>> removal of the block, if that's what is causing the issue.
> This could solve this problem.
> Or we can prevent  partial removal? Or rebulid page table entry which is not removed?

+ David Hildenbrand <david@redhat.com>

Splitting the block mapping and rebuilding page table entry to reflect non-removed
areas will require additional information such as flags and pgtable alloc function
as in __create_pgd_mapping(), which need to be passed along, depending on whether
it's tearing down vmemmap (would not have PUD block map) or linear mapping. But I
am just wondering if we have to go in that direction at all or just prevent partial
memory block removal as suggested by Will.

- arch_remove_memory() does not have return type, core MM hotremove would not fail
  because arch_remove_memory() failed or warned

- core MM hotremove does check_hotplug_memory_range() which ensures the range and
  start address are memory_block_size_bytes() aligned

- Default memory_block_size_bytes() is dependent on SECTION_SIZE_BITS which on arm64
  now can be less than PUD_SIZE triggering this problem.

	#define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)

	unsigned long __weak memory_block_size_bytes(void)
	{
        	return MIN_MEMORY_BLOCK_SIZE;
	}
	EXPORT_SYMBOL_GPL(memory_block_size_bytes);

- We would need to override memory_block_size_bytes() on arm64 to accommodate such
  scenarios here

Something like this might work (built but not tested)

commit 2eb8dc0d08dfe0b2a3bb71df93b12f7bf74a2ca6 (HEAD)
Author: Anshuman Khandual <anshuman.khandual@arm.com>
Date:   Mon Jul 24 06:45:34 2023 +0100

    arm64/mm: Define memory_block_size_bytes()
    
    Define memory_block_size_bytes() on arm64 platforms to set minimum hot plug
    and remove granularity as PUD_SIZE in case where MIN_MEMORY_BLOCK_SIZE just
    falls below PUD_SIZE. Otherwise a complete PUD block mapping will be teared
    down while unmapping MIN_MEMORY_BLOCK_SIZE range.
    
    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 95d360805f8a..1918459b3460 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1157,6 +1157,17 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+unsigned long memory_block_size_bytes(void)
+{
+       /*
+        * Linear mappings might include PUD based block mappings which
+        * cannot be teared down in part during memory hotremove. Hence
+        * PUD_SIZE needs to be the minimum granularity, for memory hot
+        * removal in case MIN_MEMORY_BLOCK_SIZE falls below.
+        */
+       return max_t(unsigned long, MIN_MEMORY_BLOCK_SIZE, PUD_SIZE);
+}
+
 void vmemmap_free(unsigned long start, unsigned long end,
                struct vmem_altmap *altmap)
 {
