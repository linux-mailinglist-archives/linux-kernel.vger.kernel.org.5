Return-Path: <linux-kernel+bounces-148745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD6F8A86E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFFF282401
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855141428FF;
	Wed, 17 Apr 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxVPvVWB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5717137C33
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366148; cv=none; b=HynT1bdGdbeCyKIViqHfqu8DZOyT7ujQfbXksXOduMauOmeE11LU8QD7z6r5iFbVdI3voqj/VsQfBRPd8NEDuDTbOinSYlxzdKx/XeZ+m2KAGGTBiTy7zQALIqlVhATvRNRZpTqmPZUy8e5v+FWdTACLOxZG4fn5FvL00464Etc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366148; c=relaxed/simple;
	bh=YBktI9yCm1ignZGT3Z3vvps0C6s2j+HnGeHeqsgZil4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n24S1vsW1oMN9jv2pmAGeY7MxUxjf8QdwfUy1sEQQwrout3nueSNL8PpIEBTKQB0+3L21TPG/H8AI1/zRrPF4Zk1IkPFwS1dutsL5pGN8OkfCpx9t8f9RQyNVXqMoEBzQvAdaErwiSiSt4pWKOOgyi7agf1Hte4Z9m4pmfViC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxVPvVWB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713366144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4ZtFp0tgOCuQPu/hJIze8iiIRj9Ux902sKHGRpMIji0=;
	b=hxVPvVWBnLdkT6zGPi7RwVBcV/pEKagT1gtVJQ2GWexRlNpTBxPpHVP8PiQjZ6EtO4Heug
	V5EyA7xy5gxKj/P7UIM4q5McNvS2wyeZbtWEUFDC38ktNtHAjQDIJ09Mi0EQla5DzyWcTe
	CFWHbcGOR15TS5vCC+fcnhE5MOTNj2g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-tXtF7rE9NkKO1uOTnL7brA-1; Wed, 17 Apr 2024 11:02:23 -0400
X-MC-Unique: tXtF7rE9NkKO1uOTnL7brA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4185f944eb0so14337225e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713366142; x=1713970942;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ZtFp0tgOCuQPu/hJIze8iiIRj9Ux902sKHGRpMIji0=;
        b=T0YgBQbNkdEJEm0NQy5tG4UewtvKe3AqzjYvCRo+Fzbx2WcQhVSY1ztvlDYNvm+KXZ
         5/nFLy7HsNir9TZBi1dpv0ZPOIRVDPxZuwG1gEwEfr8vbht5wtqoL61GFJAlg29lBeBi
         /CNSVvGcnkWupgu/K2khof3NIegMGNnYwRehBrb8t9CcQMxVjHJjx+9xq3pzxveNKf3y
         idH8iGUEUMbvIZ9f7e2fKtfGlZNS+vZraG3fEGqn2Z5kCaLuq4bI5PnOK3D2x9a8Yz03
         42AGTb4w2rQvFW/BZgyGDxYJsy578kvh0o08PVG7qVjlK2b/RKXwywSDfom6RiQd/ZNf
         qfOw==
X-Forwarded-Encrypted: i=1; AJvYcCWPqzdPUVGezDIEjxMWZ6hfAsoSH10kuLu+0Y1QOLJNSolJQ9C6TPLeKYub3GlSKKF6rnBRIDTdv5cGxbj1TsIewkiFo/F+0mWDBB6B
X-Gm-Message-State: AOJu0Yy+HeMs4niZrSLYw1u3nUDD4R8d7pgmYfjcfxrqpbjfjoZ8daZF
	GEH7W0XYf47MWWeFt/Je2xVoDnW6RMXe6sDBm4fZx/9/Im3SiZktSFe4QwIZEck3Hs7WPhpYfpX
	sJmGkTYbGOttgc5SHB50JV2u4DNZsz4+ypeYDaboPVAjKLvksLubBHtnK7lCPgw==
X-Received: by 2002:a05:600c:348f:b0:418:ccd5:70aa with SMTP id a15-20020a05600c348f00b00418ccd570aamr708867wmq.10.1713366141834;
        Wed, 17 Apr 2024 08:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQdvWBV3jWjxZu2LkhsO3fQFdxKZwSRua+c7Y8q6Sxt1pY3IKVyw6pB6sqa2r3XuAEmxs7bQ==
X-Received: by 2002:a05:600c:348f:b0:418:ccd5:70aa with SMTP id a15-20020a05600c348f00b00418ccd570aamr708824wmq.10.1713366141355;
        Wed, 17 Apr 2024 08:02:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2300:653:c844:4858:570f? (p200300cbc74523000653c8444858570f.dip0.t-ipconnect.de. [2003:cb:c745:2300:653:c844:4858:570f])
        by smtp.gmail.com with ESMTPSA id cr12-20020a05600004ec00b00341ce80ea66sm17810206wrb.82.2024.04.17.08.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 08:02:20 -0700 (PDT)
Message-ID: <2062c2d1-4ebb-4a40-89f9-3083e6912301@redhat.com>
Date: Wed, 17 Apr 2024 17:02:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/vmscan: avoid split PMD-mapped THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240417141111.77855-1-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240417141111.77855-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.04.24 16:11, Lance Yang wrote:
> When the user no longer requires the pages, they would use madvise(madv_free)
> to mark the pages as lazy free. IMO, they would not typically rewrite to the
> given range.
> 
> At present, a PMD-mapped THP marked as lazyfree during shrink_folio_list()
> is unconditionally split, which may be unnecessary. If the THP is exclusively
> mapped and clean, and the PMD associated with it is also clean, then we can
> attempt to remove the PMD mapping from it. This change will improve the
> efficiency of memory reclamation in this case.
> 
> On an Intel i5 CPU, reclaiming 1GiB of PMD-mapped THPs using
> mem_cgroup_force_empty() results in the following runtimes in seconds
> (shorter is better):
> 
> --------------------------------------------
> |     Old       |      New       |  Change  |
> --------------------------------------------
> |   0.683426    |    0.049197    |  -92.80% |
> --------------------------------------------
> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   include/linux/huge_mm.h |  1 +
>   include/linux/rmap.h    |  1 +
>   mm/huge_memory.c        |  2 +-
>   mm/rmap.c               | 81 +++++++++++++++++++++++++++++++++++++++++
>   mm/vmscan.c             |  7 ++++
>   5 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7cd07b83a3d0..02a71c05f68a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -36,6 +36,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>   int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
>   		    unsigned long cp_flags);
> +inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd);
>   
>   vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>   vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 0f906dc6d280..8c2f45713351 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -100,6 +100,7 @@ enum ttu_flags {
>   					 * do a final flush if necessary */
>   	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
>   					 * caller holds it */
> +	TTU_LAZYFREE_THP	= 0x100, /* avoid split PMD-mapped THP */
>   };
>   
>   #ifdef CONFIG_MMU
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 58f2c4745d80..309fba9624c2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1801,7 +1801,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   	return ret;
>   }
>   
> -static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
> +inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
>   {
>   	pgtable_t pgtable;
>   
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..4994f9e402d4 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -77,6 +77,7 @@
>   #include <linux/mm_inline.h>
>   
>   #include <asm/tlbflush.h>
> +#include <asm/tlb.h>
>   
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/tlb.h>
> @@ -1606,6 +1607,80 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
>   #endif
>   }
>   
> +static bool __try_to_unmap_lazyfree_thp(struct vm_area_struct *vma,
> +					     unsigned long address,
> +					     struct folio *folio)
> +{
> +	spinlock_t *ptl;
> +	pmd_t *pmdp, orig_pmd;
> +	struct mmu_notifier_range range;
> +	struct mmu_gather tlb;
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct page *page;
> +	bool ret = false;
> +
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +	VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
> +	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> +	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> +
> +	/*
> +	 * If we encounter a PMD-mapped THP that marked as lazyfree, we
> +	 * will try to unmap it without splitting.
> +	 *
> +	 * The folio exclusively mapped should only have two refs:
> +	 * one from the isolation and one from the rmap.
> +	 */
> +	if (folio_entire_mapcount(folio) != 1 || folio_test_dirty(folio) ||
> +	    folio_ref_count(folio) != 2)

folio_mapcount() == 1 is a bit nicer. Bit I assume you can drop that 
completely and only check the refcount?

> +		return false;
> +
> +	pmdp = mm_find_pmd(mm, address);
> +	if (unlikely(!pmdp))
> +		return false;
> +	if (pmd_dirty(*pmdp))
> +		return false;
> +
> +	tlb_gather_mmu(&tlb, mm);
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> +				address & HPAGE_PMD_MASK,
> +				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +
> +	ptl = pmd_lock(mm, pmdp);
> +	orig_pmd = *pmdp;
> +	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
> +		goto out;
> +
> +	page = pmd_page(orig_pmd);
> +	if (unlikely(page_folio(page) != folio))
> +		goto out;
> +
> +	orig_pmd = pmdp_huge_get_and_clear(mm, address, pmdp);
> +	tlb_remove_pmd_tlb_entry(&tlb, pmdp, address);

Until this point, the page could have been pinned (including GUP-fast) 
and we might be in trouble if we drop it.

-- 
Cheers,

David / dhildenb


