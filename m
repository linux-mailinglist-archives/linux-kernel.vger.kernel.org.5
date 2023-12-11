Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FED980D0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbjLKQQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344862AbjLKQPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:15:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2E97D67
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:15:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F16E16F3;
        Mon, 11 Dec 2023 08:16:09 -0800 (PST)
Received: from [10.57.73.30] (unknown [10.57.73.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43F1E3F738;
        Mon, 11 Dec 2023 08:15:21 -0800 (PST)
Message-ID: <3acd2e94-7ae4-4272-8e43-b496c0d26e55@arm.com>
Date:   Mon, 11 Dec 2023 16:15:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/39] mm/rmap: introduce and use hugetlb_remove_rmap()
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-3-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-3-david@redhat.com>
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
> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
> For example, hugetlb currently only supports entire mappings, and treats
> any mapping as mapped using a single "logical PTE". Let's move it out
> of the way so we can overhaul our "ordinary" rmap.
> implementation/interface.
> 
> Let's introduce and use hugetlb_remove_rmap() and remove the hugetlb
> code from page_remove_rmap(). This effectively removes one check on the
> small-folio path as well.
> 
> Note: all possible candidates that need care are page_remove_rmap() that
>       pass compound=true.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/rmap.h |  5 +++++
>  mm/hugetlb.c         |  4 ++--
>  mm/rmap.c            | 17 ++++++++---------
>  3 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 0bfea866f39b..d85bd1d4de04 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -213,6 +213,11 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  
> +static inline void hugetlb_remove_rmap(struct folio *folio)
> +{
> +	atomic_dec(&folio->_entire_mapcount);
> +}
> +
>  static inline void __page_dup_rmap(struct page *page, bool compound)
>  {
>  	if (compound) {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 305f3ca1dee6..ef48ae673890 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5676,7 +5676,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  					make_pte_marker(PTE_MARKER_UFFD_WP),
>  					sz);
>  		hugetlb_count_sub(pages_per_huge_page(h), mm);
> -		page_remove_rmap(page, vma, true);
> +		hugetlb_remove_rmap(page_folio(page));
>  
>  		spin_unlock(ptl);
>  		tlb_remove_page_size(tlb, page, huge_page_size(h));
> @@ -5987,7 +5987,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  		/* Break COW or unshare */
>  		huge_ptep_clear_flush(vma, haddr, ptep);
> -		page_remove_rmap(&old_folio->page, vma, true);
> +		hugetlb_remove_rmap(old_folio);
>  		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
>  		if (huge_pte_uffd_wp(pte))
>  			newpte = huge_pte_mkuffd_wp(newpte);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 80d42c31281a..4e60c1f38eaa 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1482,13 +1482,6 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  
>  	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  
> -	/* Hugetlb pages are not counted in NR_*MAPPED */
> -	if (unlikely(folio_test_hugetlb(folio))) {
> -		/* hugetlb pages are always mapped with pmds */
> -		atomic_dec(&folio->_entire_mapcount);
> -		return;
> -	}
> -
>  	/* Is page being unmapped by PTE? Is this its last map to be removed? */
>  	if (likely(!compound)) {
>  		last = atomic_add_negative(-1, &page->_mapcount);
> @@ -1846,7 +1839,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			dec_mm_counter(mm, mm_counter_file(&folio->page));
>  		}
>  discard:
> -		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
> +		if (unlikely(folio_test_hugetlb(folio)))
> +			hugetlb_remove_rmap(folio);
> +		else
> +			page_remove_rmap(subpage, vma, false);
>  		if (vma->vm_flags & VM_LOCKED)
>  			mlock_drain_local();
>  		folio_put(folio);
> @@ -2199,7 +2195,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			 */
>  		}
>  
> -		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
> +		if (unlikely(folio_test_hugetlb(folio)))
> +			hugetlb_remove_rmap(folio);
> +		else
> +			page_remove_rmap(subpage, vma, false);
>  		if (vma->vm_flags & VM_LOCKED)
>  			mlock_drain_local();
>  		folio_put(folio);

