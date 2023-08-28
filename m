Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95278A83C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjH1Iwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjH1IwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:52:24 -0400
Received: from out-251.mta0.migadu.com (out-251.mta0.migadu.com [IPv6:2001:41d0:1004:224b::fb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D171BE8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:52:20 -0700 (PDT)
Message-ID: <2be1ab83-f047-245f-68ad-62c4478914a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693212739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEJsS6jb2rjW3BlTwJdUWZlMga7O4tMNsD6ueh6tNuo=;
        b=o3l1IVK7r0+Z4CQcoBcbchRU5K6PCrcAkToafNCBk26Klx80OUlGIoybH+neXCeigVeDQ6
        esOYi1Os6Q/MdJgN51tIUDj7sgIedjc0kfYu4Fu3E96cHSbCNx27fmLWYOBzXeywvDvJvq
        STtbusveaKpFLJgPkSukqCG/0I48vz0=
Date:   Mon, 28 Aug 2023 16:52:10 +0800
MIME-Version: 1.0
Subject: Re: [v3 3/4] memblock: introduce MEMBLOCK_RSRV_NOINIT_VMEMMAP flag
To:     Mike Rapoport <rppt@kernel.org>,
        Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-4-usama.arif@bytedance.com>
 <20230828074729.GC3223@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230828074729.GC3223@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/28 15:47, Mike Rapoport wrote:
> On Fri, Aug 25, 2023 at 12:18:35PM +0100, Usama Arif wrote:
>> For reserved memory regions marked with this flag,
>> reserve_bootmem_region is not called during memmap_init_reserved_pages.
>> This can be used to avoid struct page initialization for
>> regions which won't need them, for e.g. hugepages with
>> HVO enabled.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> ---
>>   include/linux/memblock.h | 10 ++++++++++
>>   mm/memblock.c            | 32 +++++++++++++++++++++++++++-----
>>   2 files changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index f71ff9f0ec81..6d681d053880 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -40,6 +40,8 @@ extern unsigned long long max_possible_pfn;
>>    * via a driver, and never indicated in the firmware-provided memory map as
>>    * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
>>    * kernel resource tree.
>> + * @MEMBLOCK_RSRV_NOINIT_VMEMMAP: memory region for which struct pages are
>> + * not initialized (only for reserved regions).
>>    */
>>   enum memblock_flags {
>>   	MEMBLOCK_NONE		= 0x0,	/* No special request */
>> @@ -47,6 +49,8 @@ enum memblock_flags {
>>   	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>>   	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>>   	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> +	/* don't initialize struct pages associated with this reserver memory block */
>> +	MEMBLOCK_RSRV_NOINIT_VMEMMAP	= 0x10,
> The flag means that struct page shouldn't be initialized, it may be used
> not only by vmemmap optimizations.
> Please drop _VMEMMAP.

The area at where the struct pages located is vmemmap, I think the
"vmemap" suffix does not mean that it is for "vmemmap optimization",
it could specify the target which will not be initialized. For me,
MEMBLOCK_RSRV_NOINIT does not tell me what should not be initialized,
memblock itself or its struct page (aka vmemmap pages)? So maybe
the suffix is better to keep?

>
> And I agree with Muchun's remarks about the comments.
>
>
>
>>   };
>>   
>>   /**
>> @@ -125,6 +129,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>>   int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>>   int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
>>   int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
>> +int memblock_reserved_mark_noinit_vmemmap(phys_addr_t base, phys_addr_t size);
> memblock does not care about vmemmap, please drop _vmemmap here and below as well.
>    
>>   void memblock_free_all(void);
>>   void memblock_free(void *ptr, size_t size);
>> @@ -259,6 +264,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
>>   	return m->flags & MEMBLOCK_NOMAP;
>>   }
>>   
>> +static inline bool memblock_is_noinit_vmemmap(struct memblock_region *m)
> memblock_is_reserved_noinit please.
>
>> +{
>> +	return m->flags & MEMBLOCK_RSRV_NOINIT_VMEMMAP;
>> +}
>> +
>>   static inline bool memblock_is_driver_managed(struct memblock_region *m)
>>   {
>>   	return m->flags & MEMBLOCK_DRIVER_MANAGED;
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 43cb4404d94c..a9782228c840 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -991,6 +991,23 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>>   	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
>>   }
>>   
>> +/**
>> + * memblock_reserved_mark_noinit_vmemmap - Mark a reserved memory region with flag
>> + * MEMBLOCK_RSRV_NOINIT_VMEMMAP.
> this should be about what marking RSRV_NOINIT does, not what flag it uses
>
>> + * @base: the base phys addr of the region
>> + * @size: the size of the region
>> + *
>> + * struct pages will not be initialized for reserved memory regions marked with
>> + * %MEMBLOCK_RSRV_NOINIT_VMEMMAP.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +int __init_memblock memblock_reserved_mark_noinit_vmemmap(phys_addr_t base, phys_addr_t size)
>> +{
>> +	return memblock_setclr_flag(&memblock.reserved, base, size, 1,
>> +				    MEMBLOCK_RSRV_NOINIT_VMEMMAP);
>> +}
>> +
>>   static bool should_skip_region(struct memblock_type *type,
>>   			       struct memblock_region *m,
>>   			       int nid, int flags)
>> @@ -2107,13 +2124,18 @@ static void __init memmap_init_reserved_pages(void)
>>   		memblock_set_node(start, end, &memblock.reserved, nid);
>>   	}
>>   
>> -	/* initialize struct pages for the reserved regions */
>> +	/*
>> +	 * initialize struct pages for reserved regions that don't have
>> +	 * the MEMBLOCK_RSRV_NOINIT_VMEMMAP flag set
>> +	 */
>>   	for_each_reserved_mem_region(region) {
>> -		nid = memblock_get_region_node(region);
>> -		start = region->base;
>> -		end = start + region->size;
>> +		if (!memblock_is_noinit_vmemmap(region)) {
>> +			nid = memblock_get_region_node(region);
>> +			start = region->base;
>> +			end = start + region->size;
>>   
>> -		reserve_bootmem_region(start, end, nid);
>> +			reserve_bootmem_region(start, end, nid);
>> +		}
>>   	}
>>   }
>>   
>> -- 
>> 2.25.1
>>

