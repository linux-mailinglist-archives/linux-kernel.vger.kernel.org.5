Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCB7FA436
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjK0PQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjK0PQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:16:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BECCAA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701098182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=o1OXRXgH1rWrRktsR3slBjqAkr3OAo4k1a/STq0C0Qs=;
        b=IKrhKFi0lXFA274vcPAAZDGT2NX529jW6M50mvOio4cnrb/hJQWfUl3WY6ILspZwTzd2HT
        +rYRODFr66g+tJHo6zNMuT5+XWU2hNQUq3QfE8+83ZPEA3OJdoPdue7cbakfunGEMo8y+2
        oi1FCmSgSvPz5XXpkgMM+cA+Mx1IwRo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-LP6_FjRVNXu0aJYKyQxwPg-1; Mon, 27 Nov 2023 10:16:21 -0500
X-MC-Unique: LP6_FjRVNXu0aJYKyQxwPg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332f5ff511aso1655363f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098180; x=1701702980;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1OXRXgH1rWrRktsR3slBjqAkr3OAo4k1a/STq0C0Qs=;
        b=FafVESIMcZ4Ai17KN0BWfh+rfW212ul+cy80WJGaTBKtc73yQN4pvCgh7WyiWDTPVB
         8q+HSjqJ8kdCmZr/QUpxs/ZLRAAhcM1TEksgcCajQtYQp3wD7fKD8nu6VmMRNAgq+kgh
         HuPS9TkjimYfiGnJV3hMuKdQ9rCrjNnuvC2e13r3Rb4HzoBSQGWrt57yyMz+Phbghgpk
         aAFITPFJG7cQDzM2y/Dfbk/FHPEy4GT2ObgeRwXNIUaKeO7C5p+0s1kaEn0wMsbQ3XRx
         dtwCHFmZ1LxfO1xJ669pOckWnDWig6kgiwPkhvAfV4JPvbbbxySe3e8HUIEn9okiCA4M
         avVQ==
X-Gm-Message-State: AOJu0YwZQydcULOhKe1LbMyBQ1PPJmNcl4Y9dGa3s1EWmBpWqWYR9+3m
        XbZJ5sRDTPfKkHSR13ge0Wn/owWq0F+3U/7QyuyxQHyLZ5USCBHIENh2D0N72oJSWab2LGXFjGm
        cIxXgliHuWkShNRzqMPWgugW2
X-Received: by 2002:a5d:4c44:0:b0:332:eb19:9520 with SMTP id n4-20020a5d4c44000000b00332eb199520mr7667128wrt.20.1701098180022;
        Mon, 27 Nov 2023 07:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzQsFhBN5+Rm7TrL4q2+K20IuTilKu8zrGTb/WG4m6sixc1+hiVZv4o7JOJ3sxL3PitYzrAA==
X-Received: by 2002:a5d:4c44:0:b0:332:eb19:9520 with SMTP id n4-20020a5d4c44000000b00332eb199520mr7667094wrt.20.1701098179584;
        Mon, 27 Nov 2023 07:16:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id h4-20020adfa4c4000000b0032d8eecf901sm12397781wrb.3.2023.11.27.07.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:16:19 -0800 (PST)
Message-ID: <c7512dd7-5009-4230-a29e-ea13c2e3be3e@redhat.com>
Date:   Mon, 27 Nov 2023 16:16:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] mm/memory_hotplug: introduce
 MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
 <20231127082023.2079810-2-sumanthk@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231127082023.2079810-2-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.23 09:20, Sumanth Korikkar wrote:
> Introduce  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory notifiers to
> prepare the transition of memory to and from a physically accessible
> state. This enhancement is crucial for implementing the "memmap on
> memory" feature for s390 in a subsequent patch.
> 
> Platforms such as x86 can support physical memory hotplug via ACPI. When
> there is physical memory hotplug, ACPI event leads to the memory
> addition with the following callchain:
> acpi_memory_device_add()
>    -> acpi_memory_enable_device()
>       -> __add_memory()
> 
> After this, the hotplugged memory is physically accessible, and altmap
> support prepared, before the "memmap on memory" initialization in
> memory_block_online() is called.
> 
> On s390, memory hotplug works in a different way. The available hotplug
> memory has to be defined upfront in the hypervisor, but it is made
> physically accessible only when the user sets it online via sysfs,
> currently in the MEM_GOING_ONLINE notifier. This is too late and "memmap
> on memory" initialization is performed before calling MEM_GOING_ONLINE
> notifier.
> 
> During the memory hotplug addition phase, altmap support is prepared and
> during the memory onlining phase s390 requires memory to be physically
> accessible and then subsequently initiate the "memmap on memory"
> initialization process.
> 
> The memory provider will handle new MEM_PREPARE_ONLINE /
> MEM_FINISH_OFFLINE notifications and make the memory accessible.
> 
> The mhp_flag MHP_OFFLINE_INACCESSIBLE is introduced and is relevant when
> used along with MHP_MEMMAP_ON_MEMORY, because the altmap cannot be
> written (e.g., poisoned) when adding memory -- before it is set online.
> This allows for adding memory with an altmap that is not currently made
> available by a hypervisor. When onlining that memory, the hypervisor can
> be instructed to make that memory accessible via the new notifiers and
> the onlining phase will not require any memory allocations, which is
> helpful in low-memory situations.
> 
> All architectures ignore unknown memory notifiers.  Therefore, the
> introduction of these new notifiers does not result in any functional
> modifications across architectures.
> 
> Suggested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---

[...]

>   };
>   
>   /*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7a5fc89a8652..ac7cfc09502d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1083,8 +1083,25 @@ void adjust_present_page_count(struct page *page, struct memory_group *group,
>   		group->present_kernel_pages += nr_pages;
>   }
>   
> +static void page_init_poison_with_resched(unsigned long start_pfn, unsigned long nr_pages)
> +{
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +	unsigned long pfn, cur_nr_pages;
> +
> +	/* Poison struct pages because they are now uninitialized again. */
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += cur_nr_pages) {
> +		cond_resched();
> +
> +		/* Select all remaining pages up to the next section boundary */
> +		cur_nr_pages =
> +			min(end_pfn - pfn, SECTION_ALIGN_UP(pfn + 1) - pfn);
> +		page_init_poison(pfn_to_page(pfn),
> +				 sizeof(struct page) * cur_nr_pages);
> +	}
> +}
> +
>   int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
> -			      struct zone *zone)
> +			      struct zone *zone, bool mhp_off_inaccessible)
>   {
>   	unsigned long end_pfn = pfn + nr_pages;
>   	int ret, i;
> @@ -1092,7 +1109,14 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
>   	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
>   	if (ret)
>   		return ret;
> -
> +	/*
> +	 * Memory block is accessible at this stage and hence poison the struct
> +	 * pages now.  If the memory block is accessible during memory hotplug
> +	 * addition phase, then page poisining is already performed in
> +	 * sparse_add_section().
> +	 */
> +	if (mhp_off_inaccessible)
> +		page_init_poison_with_resched(pfn, nr_pages);

Can you elaborate why a simple page_init_poison() as for 
sparse_add_section() is insufficient?

Apart from that looks good.

Ideally, we'd be updating altmap->inaccessible as we online/offline 
memory. But then, we'd have to remember MHP_OFFLINE_INACCESSIBLE somehow 
differently.

-- 
Cheers,

David / dhildenb

