Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB12805B6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjLEQdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLEQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1499E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701793993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Xds3fAvToGQIVWFsgXFyi6xVuBYRGtZw+KF/mTH9UoA=;
        b=Bx0CoS9BJ32zlm3Ns0iJWEwhcJkPdIdjwKckghJjYYGONLoi3kJMohOu9BqtOyCC1cWP9W
        /t4SuB/31RhDcvAhULD+CcQhq9ztWqrtcDnOVqr4HXlQ6/uRAXHe7Khfe55WdrYQEn4N7/
        HTQh+0jKEjCCkv5o1nxOfMxo0DCz+7U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-Jti9pkvEP9ySLog5CmYYag-1; Tue, 05 Dec 2023 11:33:00 -0500
X-MC-Unique: Jti9pkvEP9ySLog5CmYYag-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332e71b8841so4600453f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793953; x=1702398753;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xds3fAvToGQIVWFsgXFyi6xVuBYRGtZw+KF/mTH9UoA=;
        b=sX45RDFQmApY5GrjLUPbbtZHXn+1oicA0P01wfZAQDzgbLZFWQwnlwmfIab7uaqNo6
         PaGIzTC4duAJJK6isPphL9szgKFeTMalkV9cfnaOkt76JdHQug32/Ou+Cpz7DR3i6ets
         8Tm/BpOaSiYuj11hdj2ARwTFRy1kYD30x7MF0IxANo3t84SOPe7iGoet0qMQjS5o74ze
         oWZK7n9PPs3/vu5DcSA6q2AmimaIidqsRB33na707A4I47L+8WzVFP2MYiTnXKybXJuo
         oCldDqcoL/3e9x7Y+lG4alhokzSJ6zQiV27xy2BxNEcKIjAsCLrXW9zzrXh3bN1sjZ9Z
         /HLg==
X-Gm-Message-State: AOJu0YwB8y0a871GNbjcfKFtcpWRciDBwuYawPrYddTDPzNd+pwfQfZJ
        eoazPTBIhCihOpOrhx0wZbGS/Yw7YYA4oV8yuLXpc1x+L1nD/B7b61f5UzH2dedwmOq4+gRVNXK
        Zk5RZyvx88+zp5+tcUAF/x0Ui
X-Received: by 2002:adf:a319:0:b0:333:26aa:d598 with SMTP id c25-20020adfa319000000b0033326aad598mr4721398wrb.39.1701793952836;
        Tue, 05 Dec 2023 08:32:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECUH/R5Wa1oQN4nofKueCsKfolnSAkjvKlg7u+nnwhtot1z//CoG/drN+otbXgpPHbXQULJQ==
X-Received: by 2002:adf:a319:0:b0:333:26aa:d598 with SMTP id c25-20020adfa319000000b0033326aad598mr4721358wrb.39.1701793952304;
        Tue, 05 Dec 2023 08:32:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id b14-20020adff90e000000b0033346fe9b9bsm6701420wrr.83.2023.12.05.08.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 08:32:31 -0800 (PST)
Message-ID: <71040a8c-4ea1-4f21-8ac8-65f7c25c217e@redhat.com>
Date:   Tue, 5 Dec 2023 17:32:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-5-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231204102027.57185-5-ryan.roberts@arm.com>
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

On 04.12.23 11:20, Ryan Roberts wrote:
> Introduce the logic to allow THP to be configured (through the new sysfs
> interface we just added) to allocate large folios to back anonymous
> memory, which are larger than the base page size but smaller than
> PMD-size. We call this new THP extension "multi-size THP" (mTHP).
> 
> mTHP continues to be PTE-mapped, but in many cases can still provide
> similar benefits to traditional PMD-sized THP: Page faults are
> significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending on
> the configured order), but latency spikes are much less prominent
> because the size of each page isn't as huge as the PMD-sized variant and
> there is less memory to clear in each page fault. The number of per-page
> operations (e.g. ref counting, rmap management, lru list management) are
> also significantly reduced since those ops now become per-folio.
> 
> Some architectures also employ TLB compression mechanisms to squeeze
> more entries in when a set of PTEs are virtually and physically
> contiguous and approporiately aligned. In this case, TLB misses will
> occur less often.
> 
> The new behaviour is disabled by default, but can be enabled at runtime
> by writing to /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled
> (see documentation in previous commit). The long term aim is to change
> the default to include suitable lower orders, but there are some risks
> around internal fragmentation that need to be better understood first.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

In general, looks good to me, some comments/nits. And the usual "let's 
make sure we don't degrade order-0 and keep that as fast as possible" 
comment.

> ---
>   include/linux/huge_mm.h |   6 ++-
>   mm/memory.c             | 106 ++++++++++++++++++++++++++++++++++++----
>   2 files changed, 101 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index bd0eadd3befb..91a53b9835a4 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>   
>   /*
> - * Mask of all large folio orders supported for anonymous THP.
> + * Mask of all large folio orders supported for anonymous THP; all orders up to
> + * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
> + * (which is a limitation of the THP implementation).
>    */
> -#define THP_ORDERS_ALL_ANON	BIT(PMD_ORDER)
> +#define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>   
>   /*
>    * Mask of all large folio orders supported for file THP.
> diff --git a/mm/memory.c b/mm/memory.c
> index 3ceeb0f45bf5..bf7e93813018 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4125,6 +4125,84 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	return ret;
>   }
>   
> +static bool pte_range_none(pte_t *pte, int nr_pages)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		if (!pte_none(ptep_get_lockless(pte + i)))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> +{
> +	gfp_t gfp;
> +	pte_t *pte;
> +	unsigned long addr;
> +	struct folio *folio;
> +	struct vm_area_struct *vma = vmf->vma;
> +	unsigned long orders;
> +	int order;

Nit: reverse christmas tree encouraged ;)

> +
> +	/*
> +	 * If uffd is active for the vma we need per-page fault fidelity to
> +	 * maintain the uffd semantics.
> +	 */
> +	if (userfaultfd_armed(vma))

Nit: unlikely()

> +		goto fallback;
> +
> +	/*
> +	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
> +	 * for this vma. Then filter out the orders that can't be allocated over
> +	 * the faulting address and still be fully contained in the vma.
> +	 */
> +	orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
> +					  BIT(PMD_ORDER) - 1);
> +	orders = thp_vma_suitable_orders(vma, vmf->address, orders);

Comment: Both will eventually loop over all orders, correct? Could 
eventually be sped up in the future.

Nit: the orders = ... order = ... looks like this might deserve a helper 
function that makes this easier to read.

Nit: Why call thp_vma_suitable_orders if the orders are already 0? 
Again, some helper might be reasonable where that is handled internally.

Comment: For order-0 we'll always perform a function call to both 
thp_vma_allowable_orders() / thp_vma_suitable_orders(). We should 
perform some fast and efficient check if any <PMD THP are even enabled 
in the system / for this VMA, and in that case just fallback before 
doing more expensive checks.

> +
> +	if (!orders)
> +		goto fallback;
> +
> +	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> +	if (!pte)
> +		return ERR_PTR(-EAGAIN);
> +
> +	order = first_order(orders);
> +	while (orders) {
> +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +		vmf->pte = pte + pte_index(addr);
> +		if (pte_range_none(vmf->pte, 1 << order))
> +			break;

Comment: Likely it would make sense to scan only once and determine the 
"largest none range" around that address, having the largest suitable 
order in mind.

> +		order = next_order(&orders, order);
> +	}
> +
> +	vmf->pte = NULL;

Nit: Can you elaborate why you are messing with vmf->pte here? A simple 
helper variable will make this code look less magical. Unless I am 
missing something important :)

> +	pte_unmap(pte);
> +
> +	gfp = vma_thp_gfp_mask(vma);
> +
> +	while (orders) {
> +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +		folio = vma_alloc_folio(gfp, order, vma, addr, true);
> +		if (folio) {
> +			clear_huge_page(&folio->page, addr, 1 << order);
> +			return folio;
> +		}
> +		order = next_order(&orders, order);
> +	}
> +

Queestion: would it make sense to combine both loops? I suspect memory 
allocations with pte_offset_map()/kmao are problematic.

> +fallback:
> +	return vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +}
> +#else
> +#define alloc_anon_folio(vmf) \
> +		vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
> +#endif
> +
>   /*
>    * We enter with non-exclusive mmap_lock (to exclude vma changes,
>    * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -4132,6 +4210,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>    */
>   static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   {
> +	int i;
> +	int nr_pages = 1;
> +	unsigned long addr = vmf->address;
>   	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct folio *folio;

Nit: reverse christmas tree :)

> @@ -4176,10 +4257,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   	/* Allocate our own private page. */
>   	if (unlikely(anon_vma_prepare(vma)))
>   		goto oom;
> -	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +	folio = alloc_anon_folio(vmf);
> +	if (IS_ERR(folio))
> +		return 0;
>   	if (!folio)
>   		goto oom;
>   
> +	nr_pages = folio_nr_pages(folio);
> +	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
> +
>   	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>   		goto oom_free_page;
>   	folio_throttle_swaprate(folio, GFP_KERNEL);
> @@ -4196,12 +4282,13 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   	if (vma->vm_flags & VM_WRITE)
>   		entry = pte_mkwrite(pte_mkdirty(entry), vma);
>   
> -	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> -			&vmf->ptl);
> +	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>   	if (!vmf->pte)
>   		goto release;
> -	if (vmf_pte_changed(vmf)) {
> -		update_mmu_tlb(vma, vmf->address, vmf->pte);
> +	if ((nr_pages == 1 && vmf_pte_changed(vmf)) ||
> +	    (nr_pages  > 1 && !pte_range_none(vmf->pte, nr_pages))) {
> +		for (i = 0; i < nr_pages; i++)
> +			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);

Comment: separating the order-0 case from the other case might make this 
easier to read.

>   		goto release;
>   	}
>   
> @@ -4216,16 +4303,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   		return handle_userfault(vmf, VM_UFFD_MISSING);
>   	}
>   
> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -	folio_add_new_anon_rmap(folio, vma, vmf->address);
> +	folio_ref_add(folio, nr_pages - 1);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +	folio_add_new_anon_rmap(folio, vma, addr);
>   	folio_add_lru_vma(folio, vma);
>   setpte:
>   	if (uffd_wp)
>   		entry = pte_mkuffd_wp(entry);
> -	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> +	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr_pages);
>   
>   	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> +	update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr_pages);
>   unlock:
>   	if (vmf->pte)
>   		pte_unmap_unlock(vmf->pte, vmf->ptl);

Benchmarking order-0 allocations might be interesting. There will be 
some added checks + multiple loops/conditionals for order-0 that could 
be avoided by having two separate code paths. If we can't measure a 
difference, all good.

-- 
Cheers,

David / dhildenb

