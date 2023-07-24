Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E24D75EB46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGXGMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGXGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F3E63
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690179103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzX6sMsWd1Xa4P9aMwHiVVCrxSpSp5y8mDZqQ97ppFk=;
        b=gZlQ/KNnHMJEZTHeMTmMkD4XAP94apIO3/wpoJQsDHqJZwQWQlXTzSN6GN7wrG4svfzGLo
        1ulakWN/FU6QGyJTi9o+XqVAbj+Qn4VC3XVqwJlWwfNcjpTXigw60CLLp3Avh03JJcPeBZ
        uIR33bwQrCh5fjPygWvasSObiFxRkf0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-ZF0Vrs3gOK67-ZjI8d6rLw-1; Mon, 24 Jul 2023 02:11:40 -0400
X-MC-Unique: ZF0Vrs3gOK67-ZjI8d6rLw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbe590234aso23930155e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690179099; x=1690783899;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzX6sMsWd1Xa4P9aMwHiVVCrxSpSp5y8mDZqQ97ppFk=;
        b=YdPxBxfBbClHcSmmZZLFKq8vEvOxNfBZGFY3MwPqW3Mf/0oZqM39VbyQityOAOzig3
         Zoly1FbyJgUifbUEP2n7WfMjLS+RdTpdcl4vONCJrMC73tKpKO5wuX13W50P20sF4rT4
         hQNiZ0v9Ox4jdCF7cxs0G191tvFcBeAgYWfQB0xsfSZcnN1EKqG3q85XmECV/8i3fnkf
         2H+1n42OAdNhRJHIW9YIlFYzsLjdVDS2AfpzSwSNLh8Mr7fP+EtvnURZZH2aBp/JtZkk
         Ckz2d5CebSjo2VG2JLYX2uEsxKrPK36bSG9LKzQvafw9w1fqBQipJZXpetIfi290DgDt
         anJA==
X-Gm-Message-State: ABy/qLZUi4DC1gPoleH6XAa8WFal33u2Z/dKeap9s6dbqxNlxQl4Zzh1
        iPE7wv1ervSff2A2XTUyGGwqfuj6cJ5BX9ux4wyvNe6oFdWThRH8TPmzp8rUbqc0nEN74Ffm5Ml
        1o2Z6Zbhjr+XrRTlZbOlcjuXj
X-Received: by 2002:a7b:ce8b:0:b0:3fb:f0ef:4669 with SMTP id q11-20020a7bce8b000000b003fbf0ef4669mr7034796wmj.17.1690179099627;
        Sun, 23 Jul 2023 23:11:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEeo9IYf/xJhqgogtwMskzdi/GmaWsfUMRZidSGGwJcR4TUwnzSStl4LPa8+LpfNw94G3TFaQ==
X-Received: by 2002:a7b:ce8b:0:b0:3fb:f0ef:4669 with SMTP id q11-20020a7bce8b000000b003fbf0ef4669mr7034772wmj.17.1690179099181;
        Sun, 23 Jul 2023 23:11:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:d000:62f2:4df0:704a:e859? (p200300d82f45d00062f24df0704ae859.dip0.t-ipconnect.de. [2003:d8:2f45:d000:62f2:4df0:704a:e859])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcd0b000000b003fbfc61d36asm9419673wmj.5.2023.07.23.23.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 23:11:38 -0700 (PDT)
Message-ID: <732e0db0-eb41-6c58-85b7-46257b4ba0b7@redhat.com>
Date:   Mon, 24 Jul 2023 08:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        mawupeng <mawupeng1@huawei.com>, will@kernel.org
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        sudaraja@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
References: <20230717115150.1806954-1-mawupeng1@huawei.com>
 <20230721103628.GA12601@willie-the-truck>
 <35a0dad6-4f3b-f2c3-f835-b13c1e899f8d@huawei.com>
 <c49c5f19-99d3-0a1f-88c6-03f60587b38c@arm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] arm64: mm: Fix kernel page tables incorrectly deleted
 during memory removal
In-Reply-To: <c49c5f19-99d3-0a1f-88c6-03f60587b38c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.23 07:54, Anshuman Khandual wrote:
> 
> 
> On 7/24/23 06:55, mawupeng wrote:
>>
>> On 2023/7/21 18:36, Will Deacon wrote:
>>> On Mon, Jul 17, 2023 at 07:51:50PM +0800, Wupeng Ma wrote:
>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>
>>>> During our test, we found that kernel page table may be unexpectedly
>>>> cleared with rodata off. The root cause is that the kernel page is
>>>> initialized with pud size(1G block mapping) while offline is memory
>>>> block size(MIN_MEMORY_BLOCK_SIZE 128M), eg, if 2G memory is hot-added,
>>>> when offline a memory block, the call trace is shown below,

Is someone adding memory in 2 GiB granularity and then removing parts of 
it in 128 MiB granularity? That would be against what we support using 
the add_memory() / offline_and_remove_memory() API and that driver 
should be fixed instead.

Or does this trigger only when a hotplugged memory block falls into the 
same 2 GiB area as boot memory?

>>>>
>>>>   offline_and_remove_memory
>>>>      try_remove_memory
>>>>        arch_remove_memory
>>>>         __remove_pgd_mapping
>>>>           unmap_hotplug_range
>>>>             unmap_hotplug_p4d_range
>>>>               unmap_hotplug_pud_range
>>>>                 if (pud_sect(pud))
>>>>                   pud_clear(pudp);

Which drivers triggers that? In-tree is only virtio-mem and dax/kmem. 
Both add and remove memory in the same granularity.

For example, virtio-mem will only call add_memory(memory_block_size()) 
to then offline_and_remove_memory(memory_block_size()).

Could that trigger it as well?

>>> Sorry, but I'm struggling to understand the problem here. If we're adding
>>> and removing a 2G memory region, why _wouldn't_ we want to use large 1GiB
>>> mappings?
>>
>>> Or are you saying that only a subset of the memory is removed,
>>> but we then accidentally unmap the whole thing?
>> Yes, umap a subset but the whole thing page table entry is removed.
>>

Can we have some more details about the user and how to trigger it?

>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index 95d360805f8a..44c724ce4f70 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -44,6 +44,7 @@
>>>>   #define NO_BLOCK_MAPPINGS	BIT(0)
>>>>   #define NO_CONT_MAPPINGS	BIT(1)
>>>>   #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>>>> +#define NO_PUD_MAPPINGS		BIT(3)
>>>>   
>>>>   int idmap_t0sz __ro_after_init;
>>>>   
>>>> @@ -344,7 +345,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>>>   		 */
>>>>   		if (pud_sect_supported() &&
>>>>   		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
>>>> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>>>> +		    (flags & (NO_BLOCK_MAPPINGS | NO_PUD_MAPPINGS)) == 0) {
>>>>   			pud_set_huge(pudp, phys, prot);
>>>>   
>>>>   			/*
>>>> @@ -1305,7 +1306,7 @@ struct range arch_get_mappable_range(void)
>>>>   int arch_add_memory(int nid, u64 start, u64 size,
>>>>   		    struct mhp_params *params)
>>>>   {
>>>> -	int ret, flags = NO_EXEC_MAPPINGS;
>>>> +	int ret, flags = NO_EXEC_MAPPINGS | NO_PUD_MAPPINGS;
>>> I think we should allow large mappings here and instead prevent partial
>>> removal of the block, if that's what is causing the issue.
>> This could solve this problem.
>> Or we can prevent  partial removal? Or rebulid page table entry which is not removed?
> 
> + David Hildenbrand <david@redhat.com>
> 
> Splitting the block mapping and rebuilding page table entry to reflect non-removed
> areas will require additional information such as flags and pgtable alloc function
> as in __create_pgd_mapping(), which need to be passed along, depending on whether
> it's tearing down vmemmap (would not have PUD block map) or linear mapping. But I
> am just wondering if we have to go in that direction at all or just prevent partial
> memory block removal as suggested by Will.
> 
> - arch_remove_memory() does not have return type, core MM hotremove would not fail
>    because arch_remove_memory() failed or warned
> 
> - core MM hotremove does check_hotplug_memory_range() which ensures the range and
>    start address are memory_block_size_bytes() aligned
> 
> - Default memory_block_size_bytes() is dependent on SECTION_SIZE_BITS which on arm64
>    now can be less than PUD_SIZE triggering this problem.
> 
> 	#define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
> 
> 	unsigned long __weak memory_block_size_bytes(void)
> 	{
>          	return MIN_MEMORY_BLOCK_SIZE;
> 	}
> 	EXPORT_SYMBOL_GPL(memory_block_size_bytes);
> 
> - We would need to override memory_block_size_bytes() on arm64 to accommodate such
>    scenarios here
> 
> Something like this might work (built but not tested)
> 
> commit 2eb8dc0d08dfe0b2a3bb71df93b12f7bf74a2ca6 (HEAD)
> Author: Anshuman Khandual <anshuman.khandual@arm.com>
> Date:   Mon Jul 24 06:45:34 2023 +0100
> 
>      arm64/mm: Define memory_block_size_bytes()
>      
>      Define memory_block_size_bytes() on arm64 platforms to set minimum hot plug
>      and remove granularity as PUD_SIZE in case where MIN_MEMORY_BLOCK_SIZE just
>      falls below PUD_SIZE. Otherwise a complete PUD block mapping will be teared
>      down while unmapping MIN_MEMORY_BLOCK_SIZE range.
>      
>      Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 95d360805f8a..1918459b3460 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1157,6 +1157,17 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>   }
>   
>   #ifdef CONFIG_MEMORY_HOTPLUG
> +unsigned long memory_block_size_bytes(void)
> +{
> +       /*
> +        * Linear mappings might include PUD based block mappings which
> +        * cannot be teared down in part during memory hotremove. Hence
> +        * PUD_SIZE needs to be the minimum granularity, for memory hot
> +        * removal in case MIN_MEMORY_BLOCK_SIZE falls below.
> +        */
> +       return max_t(unsigned long, MIN_MEMORY_BLOCK_SIZE, PUD_SIZE);
> +}
> +
>   void vmemmap_free(unsigned long start, unsigned long end,
>                  struct vmem_altmap *altmap)
>   {
> 

OH god no. That would seriously degrade memory hotplug capabilities in 
virtual environments (especially, virtio-mem and DIMMS).

If someone adds memory in 128 MiB chunks and removes memory in 128 MiB 
chunks, that has to be working.

Removing boot memory is blocked via 
register_memory_notifier(&prevent_bootmem_remove_nb);

-- 
Cheers,

David / dhildenb

