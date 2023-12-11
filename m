Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6427080D0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344468AbjLKQOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344462AbjLKQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:14:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2F06119
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:14:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAF0516F2;
        Mon, 11 Dec 2023 08:15:11 -0800 (PST)
Received: from [10.57.73.30] (unknown [10.57.73.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBE4A3F738;
        Mon, 11 Dec 2023 08:14:23 -0800 (PST)
Message-ID: <f8d92149-bc38-4d16-9ed2-ed5d81859b10@arm.com>
Date:   Mon, 11 Dec 2023 16:14:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/39] mm/rmap: rename hugepage_add* to hugetlb_add*
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-2-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 15:56, David Hildenbrand wrote:
> Let's just call it "hugetlb_".
> 
> Yes, it's all already inconsistent and confusing because we have a lot
> of "hugepage_" functions for legacy reasons. But "hugetlb" cannot possibly
> be confused with transparent huge pages, and it matches "hugetlb.c" and
> "folio_test_hugetlb()". So let's minimize confusion in rmap code.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/rmap.h | 4 ++--
>  mm/hugetlb.c         | 8 ++++----
>  mm/migrate.c         | 4 ++--
>  mm/rmap.c            | 8 ++++----
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index af6a32b6f3e7..0bfea866f39b 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -208,9 +208,9 @@ void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
>  
> -void hugepage_add_anon_rmap(struct folio *, struct vm_area_struct *,
> +void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address, rmap_t flags);
> -void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
> +void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  
>  static inline void __page_dup_rmap(struct page *page, bool compound)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6feb3e0630d1..305f3ca1dee6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5285,7 +5285,7 @@ hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long add
>  	pte_t newpte = make_huge_pte(vma, &new_folio->page, 1);
>  
>  	__folio_mark_uptodate(new_folio);
> -	hugepage_add_new_anon_rmap(new_folio, vma, addr);
> +	hugetlb_add_new_anon_rmap(new_folio, vma, addr);
>  	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(old))
>  		newpte = huge_pte_mkuffd_wp(newpte);
>  	set_huge_pte_at(vma->vm_mm, addr, ptep, newpte, sz);
> @@ -5988,7 +5988,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  		/* Break COW or unshare */
>  		huge_ptep_clear_flush(vma, haddr, ptep);
>  		page_remove_rmap(&old_folio->page, vma, true);
> -		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
> +		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
>  		if (huge_pte_uffd_wp(pte))
>  			newpte = huge_pte_mkuffd_wp(newpte);
>  		set_huge_pte_at(mm, haddr, ptep, newpte, huge_page_size(h));
> @@ -6277,7 +6277,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		goto backout;
>  
>  	if (anon_rmap)
> -		hugepage_add_new_anon_rmap(folio, vma, haddr);
> +		hugetlb_add_new_anon_rmap(folio, vma, haddr);
>  	else
>  		page_dup_file_rmap(&folio->page, true);
>  	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
> @@ -6732,7 +6732,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  	if (folio_in_pagecache)
>  		page_dup_file_rmap(&folio->page, true);
>  	else
> -		hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
> +		hugetlb_add_new_anon_rmap(folio, dst_vma, dst_addr);
>  
>  	/*
>  	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 35a88334bb3c..4cb849fa0dd2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -249,8 +249,8 @@ static bool remove_migration_pte(struct folio *folio,
>  
>  			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
>  			if (folio_test_anon(folio))
> -				hugepage_add_anon_rmap(folio, vma, pvmw.address,
> -						       rmap_flags);
> +				hugetlb_add_anon_rmap(folio, vma, pvmw.address,
> +						      rmap_flags);
>  			else
>  				page_dup_file_rmap(new, true);
>  			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte,
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 846fc79f3ca9..80d42c31281a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2625,8 +2625,8 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
>   *
>   * RMAP_COMPOUND is ignored.
>   */
> -void hugepage_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> -			    unsigned long address, rmap_t flags)
> +void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> +		unsigned long address, rmap_t flags)
>  {
>  	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  
> @@ -2637,8 +2637,8 @@ void hugepage_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  			 PageAnonExclusive(&folio->page), folio);
>  }
>  
> -void hugepage_add_new_anon_rmap(struct folio *folio,
> -			struct vm_area_struct *vma, unsigned long address)
> +void hugetlb_add_new_anon_rmap(struct folio *folio,
> +		struct vm_area_struct *vma, unsigned long address)
>  {
>  	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
>  	/* increment count (starts at -1) */

