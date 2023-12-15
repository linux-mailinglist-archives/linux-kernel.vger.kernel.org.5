Return-Path: <linux-kernel+bounces-410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5258140B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C45B22289
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0037753B8;
	Fri, 15 Dec 2023 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wq/eSfl0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958B5382
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0100b6c8-24db-fbcf-d45e-763cfccfa0c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702611371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpaFUdbfUitlBbUA7pCVBPmS1ZL+EP7wZGITln4D6fk=;
	b=Wq/eSfl0IZkDAtdSi4h8+oGZUBuXpj6uqZkf5dNj5VaI62kdn/+Cp6fFUngIgohR/aHuzX
	yBi0P7Zz0EDhmlyhaj+uu96xgDdIFcmmaaFbiI00WzEmwKr5oM60RP3my+TCTtYxENcVEN
	SEk0f8WW2KE0+591RkqhnoqAgfWPV/Q=
Date: Fri, 15 Dec 2023 11:36:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] mm: HVO: introduce helper function to update and
 flush pgtable
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: willy@infradead.org, wangkefeng.wang@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, catalin.marinas@arm.com, will@kernel.org,
 mike.kravetz@oracle.com, akpm@linux-foundation.org, anshuman.khandual@arm.com
References: <20231214073912.1938330-1-sunnanyong@huawei.com>
 <20231214073912.1938330-2-sunnanyong@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231214073912.1938330-2-sunnanyong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2023/12/14 15:39, Nanyong Sun wrote:
> Add pmd/pte update and tlb flush helper function to update page
> table. This refactoring patch is designed to facilitate each
> architecture to implement its own special logic in preparation
> for the arm64 architecture to follow the necessary break-before-make
> sequence when updating page tables.
>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>   mm/hugetlb_vmemmap.c | 55 ++++++++++++++++++++++++++++++++++----------
>   1 file changed, 43 insertions(+), 12 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 87818ee7f01d..49e8b351def3 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -45,6 +45,37 @@ struct vmemmap_remap_walk {
>   	unsigned long		flags;
>   };
>   
> +#ifndef vmemmap_update_pmd
> +static inline void vmemmap_update_pmd(unsigned long start,
> +				      pmd_t *pmd, pte_t *pgtable)
> +{
> +	pmd_populate_kernel(&init_mm, pmd, pgtable);
> +}
> +#endif
> +
> +#ifndef vmemmap_update_pte
> +static inline void vmemmap_update_pte(unsigned long addr,
> +				      pte_t *pte, pte_t entry)
> +{
> +	set_pte_at(&init_mm, addr, pte, entry);
> +}
> +#endif
> +
> +#ifndef flush_tlb_vmemmap_all
> +static inline void flush_tlb_vmemmap_all(void)
> +{
> +	flush_tlb_all();
> +}
> +#endif
> +
> +#ifndef flush_tlb_vmemmap_range
> +static inline void flush_tlb_vmemmap_range(unsigned long start,
> +					   unsigned long end)
> +{
> +	flush_tlb_kernel_range(start, end);
> +}
> +#endif

I'd like to rename both tlb-flush helpers to vmemmap_flush_tlb_all/range
since other helpers all are prefixed with "vmemmap". It'll be more
consistent for me.

Otherwise LGTM. Thanks.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

> +
>   static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
>   {
>   	pmd_t __pmd;
> @@ -87,9 +118,9 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
>   
>   		/* Make pte visible before pmd. See comment in pmd_install(). */
>   		smp_wmb();
> -		pmd_populate_kernel(&init_mm, pmd, pgtable);
> +		vmemmap_update_pmd(start, pmd, pgtable);
>   		if (flush)
> -			flush_tlb_kernel_range(start, start + PMD_SIZE);
> +			flush_tlb_vmemmap_range(start, start + PMD_SIZE);
>   	} else {
>   		pte_free_kernel(&init_mm, pgtable);
>   	}
> @@ -217,7 +248,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>   	} while (pgd++, addr = next, addr != end);
>   
>   	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
> -		flush_tlb_kernel_range(start, end);
> +		flush_tlb_vmemmap_range(start, end);
>   
>   	return 0;
>   }
> @@ -263,15 +294,15 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
>   
>   		/*
>   		 * Makes sure that preceding stores to the page contents from
> -		 * vmemmap_remap_free() become visible before the set_pte_at()
> -		 * write.
> +		 * vmemmap_remap_free() become visible before the
> +		 * vmemmap_update_pte() write.
>   		 */
>   		smp_wmb();
>   	}
>   
>   	entry = mk_pte(walk->reuse_page, pgprot);
>   	list_add(&page->lru, walk->vmemmap_pages);
> -	set_pte_at(&init_mm, addr, pte, entry);
> +	vmemmap_update_pte(addr, pte, entry);
>   }
>   
>   /*
> @@ -310,10 +341,10 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
>   
>   	/*
>   	 * Makes sure that preceding stores to the page contents become visible
> -	 * before the set_pte_at() write.
> +	 * before the vmemmap_update_pte() write.
>   	 */
>   	smp_wmb();
> -	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> +	vmemmap_update_pte(addr, pte, mk_pte(page, pgprot));
>   }
>   
>   /**
> @@ -576,7 +607,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
>   	}
>   
>   	if (restored)
> -		flush_tlb_all();
> +		flush_tlb_vmemmap_all();
>   	if (!ret)
>   		ret = restored;
>   	return ret;
> @@ -744,7 +775,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
>   			break;
>   	}
>   
> -	flush_tlb_all();
> +	flush_tlb_vmemmap_all();
>   
>   	list_for_each_entry(folio, folio_list, lru) {
>   		int ret = __hugetlb_vmemmap_optimize_folio(h, folio,
> @@ -760,7 +791,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
>   		 * allowing more vmemmap remaps to occur.
>   		 */
>   		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
> -			flush_tlb_all();
> +			flush_tlb_vmemmap_all();
>   			free_vmemmap_page_list(&vmemmap_pages);
>   			INIT_LIST_HEAD(&vmemmap_pages);
>   			__hugetlb_vmemmap_optimize_folio(h, folio,
> @@ -769,7 +800,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
>   		}
>   	}
>   
> -	flush_tlb_all();
> +	flush_tlb_vmemmap_all();
>   	free_vmemmap_page_list(&vmemmap_pages);
>   }
>   


