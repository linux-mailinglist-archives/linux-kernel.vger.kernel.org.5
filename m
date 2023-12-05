Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F4805402
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345041AbjLEMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjLEMWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:22:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27B3EC6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:22:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 609DD139F;
        Tue,  5 Dec 2023 04:23:27 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A123F5A1;
        Tue,  5 Dec 2023 04:22:39 -0800 (PST)
Message-ID: <3c03d009-6a46-4321-a38b-9707b4558618@arm.com>
Date:   Tue, 5 Dec 2023 12:22:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/39] mm/huge_memory: batch rmap operations in
 __split_huge_pmd_locked()
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-16-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231204142146.91437-16-david@redhat.com>
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

On 04/12/2023 14:21, David Hildenbrand wrote:
> Let's use folio_add_anon_rmap_ptes(), batching the rmap operations.
> 
> While at it, use more folio operations (but only in the code branch we're
> touching), use VM_WARN_ON_FOLIO(), and pass RMAP_COMPOUND instead of

You mean RMAP_EXCLUSIVE?

> manually setting PageAnonExclusive.
> 
> We should never see non-anon pages on that branch: otherwise, the
> existing page_add_anon_rmap() call would have been flawed already.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cb33c6e0404cf..2c037ab3f4916 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2099,6 +2099,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long haddr, bool freeze)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> +	struct folio *folio;
>  	struct page *page;
>  	pgtable_t pgtable;
>  	pmd_t old_pmd, _pmd;
> @@ -2194,16 +2195,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>  	} else {
>  		page = pmd_page(old_pmd);
> +		folio = page_folio(page);
>  		if (pmd_dirty(old_pmd)) {
>  			dirty = true;
> -			SetPageDirty(page);
> +			folio_set_dirty(folio);
>  		}
>  		write = pmd_write(old_pmd);
>  		young = pmd_young(old_pmd);
>  		soft_dirty = pmd_soft_dirty(old_pmd);
>  		uffd_wp = pmd_uffd_wp(old_pmd);
>  
> -		VM_BUG_ON_PAGE(!page_count(page), page);
> +		VM_WARN_ON_FOLIO(!folio_ref_count(folio), folio);
> +		VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  
>  		/*
>  		 * Without "freeze", we'll simply split the PMD, propagating the
> @@ -2220,11 +2223,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		 *
>  		 * See page_try_share_anon_rmap(): invalidate PMD first.
>  		 */
> -		anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
> +		anon_exclusive = PageAnonExclusive(page);
>  		if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
>  			freeze = false;
> -		if (!freeze)
> -			page_ref_add(page, HPAGE_PMD_NR - 1);
> +		if (!freeze) {
> +			rmap_t rmap_flags = RMAP_NONE;
> +
> +			folio_ref_add(folio, HPAGE_PMD_NR - 1);
> +			if (anon_exclusive)
> +				rmap_flags = RMAP_EXCLUSIVE;

nit: I'd be inclined to make this |= since you're accumulating optional falgs.
Yes, its the only one so it still works as is...

> +			folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
> +						 vma, haddr, rmap_flags);
> +		}
>  	}
>  
>  	/*
> @@ -2267,8 +2277,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
>  			if (write)
>  				entry = pte_mkwrite(entry, vma);
> -			if (anon_exclusive)
> -				SetPageAnonExclusive(page + i);
>  			if (!young)
>  				entry = pte_mkold(entry);
>  			/* NOTE: this may set soft-dirty too on some archs */
> @@ -2278,7 +2286,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  				entry = pte_mksoft_dirty(entry);
>  			if (uffd_wp)
>  				entry = pte_mkuffd_wp(entry);
> -			page_add_anon_rmap(page + i, vma, addr, RMAP_NONE);
>  		}
>  		VM_BUG_ON(!pte_none(ptep_get(pte)));
>  		set_pte_at(mm, addr, pte, entry);

