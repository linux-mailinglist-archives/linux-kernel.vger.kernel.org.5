Return-Path: <linux-kernel+bounces-3992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A02F817668
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6451F243A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281A33D556;
	Mon, 18 Dec 2023 15:56:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB03D546
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FCBA2F4;
	Mon, 18 Dec 2023 07:57:11 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84CD13F5A1;
	Mon, 18 Dec 2023 07:56:25 -0800 (PST)
Message-ID: <5ea33aec-86f8-489c-937b-77a53fca20ce@arm.com>
Date: Mon, 18 Dec 2023 15:56:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/39] mm/memory: page_add_file_rmap() ->
 folio_add_file_rmap_[pte|pmd]()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-9-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-9-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2023 15:56, David Hildenbrand wrote:
> Let's convert insert_page_into_pte_locked() and do_set_pmd(). While at it,
> perform some folio conversion.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 6a5540ba3c65..70754fd65788 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1859,12 +1859,14 @@ static int validate_page_before_insert(struct page *page)
>  static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
>  			unsigned long addr, struct page *page, pgprot_t prot)
>  {
> +	struct folio *folio = page_folio(page);
> +
>  	if (!pte_none(ptep_get(pte)))
>  		return -EBUSY;
>  	/* Ok, finally just insert the thing.. */
> -	get_page(page);
> +	folio_get(folio);
>  	inc_mm_counter(vma->vm_mm, mm_counter_file(page));
> -	page_add_file_rmap(page, vma, false);
> +	folio_add_file_rmap_pte(folio, page, vma);
>  	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
>  	return 0;
>  }
> @@ -4409,6 +4411,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
>  
>  vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  {
> +	struct folio *folio = page_folio(page);
>  	struct vm_area_struct *vma = vmf->vma;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> @@ -4418,8 +4421,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
>  		return ret;
>  
> -	page = compound_head(page);
> -	if (compound_order(page) != HPAGE_PMD_ORDER)
> +	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
>  		return ret;
>  
>  	/*
> @@ -4428,7 +4430,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	 * check.  This kind of THP just can be PTE mapped.  Access to
>  	 * the corrupted subpage should trigger SIGBUS as expected.
>  	 */
> -	if (unlikely(PageHasHWPoisoned(page)))
> +	if (unlikely(folio_test_has_hwpoisoned(folio)))
>  		return ret;
>  
>  	/*
> @@ -4452,7 +4454,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>  
>  	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
> -	page_add_file_rmap(page, vma, true);
> +	folio_add_file_rmap_pmd(folio, page, vma);
>  
>  	/*
>  	 * deposit and withdraw with pmd lock held


