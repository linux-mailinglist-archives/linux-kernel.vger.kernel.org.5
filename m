Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F057F36C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjKUTZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUTY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:24:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E609D12A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700594694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=hMEaDfpv+ikMyLmND0u4sTzvj6LLaz68SQyP8wyXNlM=;
        b=b1zvYbO04BeOJSGgzqJI09q9x8Gmw2YGPKJVFvb6S32C9NL5wsq994dWgQKVMiV1ACcKPE
        BO/GKClKFg0Xd2gNUGgtUkLQCmNevn+RhTA5b2UXKpyFs7DyCgl2maOJnSu+D/5ASGklV6
        fYc6GfJMV2eRF2cUGq3ZG68/6akkfvU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-B0hgjQOEPLuwi24zWsKQ6g-1; Tue, 21 Nov 2023 14:24:52 -0500
X-MC-Unique: B0hgjQOEPLuwi24zWsKQ6g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50aa6b1bea6so3863029e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700594691; x=1701199491;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMEaDfpv+ikMyLmND0u4sTzvj6LLaz68SQyP8wyXNlM=;
        b=o0BhRE0fShZhNiqZ5+R+K5fFjL0lNHJI07DMiVUQVVJtH92srdDlbw8P2POqjI2tS2
         SZIb3nNcS3wR/NFGEHKn3xK+GaRZ05sIfS6CFYeKMppW8hiPu4yO6niKBiZ2CsuKGUNf
         Rkq4yKXrBK4+aZszuJjgkr15Rf29MVKtVKLJX/O7t5QktSxPRz2INGez7jvJQNeicXdU
         Iu2qrRWWX7QNqWv6BbWJITty/vwyHGc6d/HxwyIIO+esexczSL2eNeFB9oNfAFIH2/RM
         /u9UNOblrEt1w/JxOr5ugvw03cXOPIMHMH+3l46ZQ/VnwOuwWIhm5Wr6gX6BqMizWTI4
         9Nag==
X-Gm-Message-State: AOJu0YzBjCiOcfIs6fhQQgG3XaVXMg6bRp4zYEwqZqSoXqqYI2HgTn/7
        UC9duY/Ww530CYWhmbOsJe18ZvfvSjgC2tmlvwdRASJd52k+BBugR7Jr/vQtElz5Lrc7KhmPpik
        CxzKsj+g7Y40QHn4mK+syWflc
X-Received: by 2002:a19:e00e:0:b0:50a:a33a:942f with SMTP id x14-20020a19e00e000000b0050aa33a942fmr122374lfg.65.1700594691199;
        Tue, 21 Nov 2023 11:24:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbJkJ5NofWbp97r8reFiCeRWG29zI/6Ilkga2O5SfCerpyxE6wQCQzah73J2M1c62N9P0N8A==
X-Received: by 2002:a19:e00e:0:b0:50a:a33a:942f with SMTP id x14-20020a19e00e000000b0050aa33a942fmr122359lfg.65.1700594690721;
        Tue, 21 Nov 2023 11:24:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:be00:f0e5:e79a:9640:afaa? (p200300cbc722be00f0e5e79a9640afaa.dip0.t-ipconnect.de. [2003:cb:c722:be00:f0e5:e79a:9640:afaa])
        by smtp.gmail.com with ESMTPSA id f11-20020a19380b000000b0050a6f5a186bsm1606540lfa.293.2023.11.21.11.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 11:24:50 -0800 (PST)
Message-ID: <c7b92ff8-44db-4e48-b0af-eb1b6818b16b@redhat.com>
Date:   Tue, 21 Nov 2023 20:24:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] implement "memmap on memory" feature on s390
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
 <20231117140009.5d8a509c@thinkpad-T15>
 <ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com>
 <ZVys8HF1lgbA8u0c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZVys8HF1lgbA8u0c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.23 14:13, Sumanth Korikkar wrote:
> On Fri, Nov 17, 2023 at 04:37:29PM +0100, David Hildenbrand wrote:
>>>
>>> Maybe there is also already a common code bug with that, s390 might be
>>> special but that is often also good for finding bugs in common code ...
>>
>> If it's only the page_init_poison() as noted by Sumanth, we could disable
>> that on s390x with an altmap some way or the other; should be possible.
>>
>> I mean, you effectively have your own poisoning if the altmap is effectively
>> inaccessible and makes your CPU angry on access :)
>>
>> Last but not least, support for an inaccessible altmap might come in handy
>> for virtio-mem eventually, and make altmap support eventually simpler. So
>> added bonus points.
> 
> We tried out two possibilities dealing with vmemmap altmap inaccessibilty.
> Approach 1: Add MHP_ALTMAP_INACCESSIBLE flag and pass it in add_memory()
> 
> diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> index 075094ca59b4..ab2dfcc7e9e4 100644
> --- a/drivers/s390/char/sclp_cmd.c
> +++ b/drivers/s390/char/sclp_cmd.c
> @@ -358,6 +358,13 @@ static int sclp_mem_notifier(struct notifier_block *nb,
>   		 * buddy allocator later.
>   		 */
>   		__arch_set_page_nodat((void *)__va(start), memory_block->altmap->free);
> +		/*
> +		 * Poison the struct pages after memory block is accessible.
> +		 * This is needed for only altmap. Without altmap, the struct
> +		 * pages are poisoined in sparse_add_section().
> +		 */
> +		if (memory_block->altmap->inaccessible)
> +			page_init_poison(pfn_to_page(arg->start_pfn), memory_block->altmap->free);

See below, likely it's best if the core will do that.

>   		break;
>   	case MEM_FINISH_OFFLINE:
>   		sclp_mem_change_state(start, size, 0);
> @@ -412,7 +419,7 @@ static void __init add_memory_merged(u16 rn)
>   		goto skip_add;
>   	for (addr = start; addr < start + size; addr += block_size)
>   		add_memory(0, addr, block_size,
> -			   MACHINE_HAS_EDAT1 ? MHP_MEMMAP_ON_MEMORY : MHP_NONE);
> +			   MACHINE_HAS_EDAT1 ? MHP_MEMMAP_ON_MEMORY|MHP_ALTMAP_INACCESSIBLE : MHP_NONE);
>   skip_add:
>   	first_rn = rn;
>   	num = 1;
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 7d2076583494..5c70707e706f 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -106,6 +106,11 @@ typedef int __bitwise mhp_t;
>    * implies the node id (nid).
>    */
>   #define MHP_NID_IS_MGID		((__force mhp_t)BIT(2))
> +/*
> + * Mark memmap on memory (struct pages array) as inaccessible during memory
> + * hotplug addition phase.
> + */
> +#define MHP_ALTMAP_INACCESSIBLE	((__force mhp_t)BIT(3))

If we go that path, maybe rather MHP_OFFLINE_INACCESSIBLE and document 
how this relates to/interacts with the memory notifier callbacks and the 
altmap.

Then, we can logically abstract this from altmap handling. Simply, the 
memory should not be read/written before the memory notifier was called.

In the core, you can do the poisioning for the altmap in that case after 
calling the notifier, probably in mhp_init_memmap_on_memory() as you do 
below.

>   
>   /*
>    * Extended parameters for memory hotplug:
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 744c830f4b13..9837f3e6fb95 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -25,6 +25,7 @@ struct vmem_altmap {
>   	unsigned long free;
>   	unsigned long align;
>   	unsigned long alloc;
> +	bool inaccessible;

We should then likely remember that information for the memory block, 
not the altmap.

[...]

> 
> 
> Approach 2:
> ===========
> Shouldnt kasan zero shadow mapping performed first before
> accessing/initializing memmap via page_init_poisining()?  If that is

Likely the existing way. The first access to the poisoned memmap should 
be a write, not a read. But I didn't look into the details.

Can you try reproducing?

> true, then it is a problem for all architectures and should could be
> fixed like:
> 
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7a5fc89a8652..eb3975740537 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1093,6 +1093,7 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
>   	if (ret)
>   		return ret;
> 
> +	page_init_poison(pfn_to_page(pfn), sizeof(struct page) * nr_pages);
>   	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
> 
>   	for (i = 0; i < nr_pages; i++)
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 77d91e565045..4ddf53f52075 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -906,8 +906,11 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>   	/*
>   	 * Poison uninitialized struct pages in order to catch invalid flags
>   	 * combinations.
> +	 * For altmap, do this later when onlining the memory, as it might
> +	 * not be accessible at this point.
>   	 */
> -	page_init_poison(memmap, sizeof(struct page) * nr_pages);
> +	if (!altmap)
> +		page_init_poison(memmap, sizeof(struct page) * nr_pages);
> 
>   	ms = __nr_to_section(section_nr);
>   	set_section_nid(section_nr, nid);
> 

That's too generic when it comes to other altmap users, especially DAX 
or when the altmap is accessible while memory is offlining, and we want 
to catch that.

> 
> 
> Also, if this approach is taken, should page_init_poison() be performed
> with cond_resched() as mentioned in commit d33695b16a9f
> ("mm/memory_hotplug: poison memmap in remove_pfn_range_from_zone()") ?

Likely as soon as possible after it is accessible :)


-- 
Cheers,

David / dhildenb

