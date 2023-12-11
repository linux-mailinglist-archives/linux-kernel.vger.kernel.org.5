Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BD80D194
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbjLKQ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344608AbjLKQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:25:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2895699
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:25:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2991007;
        Mon, 11 Dec 2023 08:26:41 -0800 (PST)
Received: from [10.57.73.30] (unknown [10.57.73.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E1F63F738;
        Mon, 11 Dec 2023 08:25:53 -0800 (PST)
Message-ID: <77c44f46-565e-4317-9caa-2ad887eae31f@arm.com>
Date:   Mon, 11 Dec 2023 16:25:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/39] mm/rmap: introduce and use
 hugetlb_try_dup_anon_rmap()
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
 <20231211155652.131054-5-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-5-david@redhat.com>
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
> So let's introduce and use hugetlb_try_dup_anon_rmap() to make all
> hugetlb handling use dedicated hugetlb_* rmap functions.
> 
> Note that is_device_private_page() does not apply to hugetlb.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/mm.h   | 12 +++++++++---
>  include/linux/rmap.h | 15 +++++++++++++++
>  mm/hugetlb.c         |  3 +--
>  3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b72bf25a45cf..ae547b62f325 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1964,15 +1964,21 @@ static inline bool page_maybe_dma_pinned(struct page *page)
>   *
>   * The caller has to hold the PT lock and the vma->vm_mm->->write_protect_seq.
>   */
> -static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
> -					  struct page *page)
> +static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
> +					  struct folio *folio)
>  {
>  	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
>  
>  	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
>  		return false;
>  
> -	return page_maybe_dma_pinned(page);
> +	return folio_maybe_dma_pinned(folio);
> +}
> +
> +static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
> +					  struct page *page)
> +{
> +	return folio_needs_cow_for_dma(vma, page_folio(page));
>  }
>  
>  /**
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 91178d1aa028..ca42b3db5688 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -213,6 +213,21 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  
> +/* See page_try_dup_anon_rmap() */
> +static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
> +		struct vm_area_struct *vma)
> +{
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +
> +	if (PageAnonExclusive(&folio->page)) {
> +		if (unlikely(folio_needs_cow_for_dma(vma, folio)))
> +			return -EBUSY;
> +		ClearPageAnonExclusive(&folio->page);
> +	}
> +	atomic_inc(&folio->_entire_mapcount);
> +	return 0;
> +}
> +
>  static inline void hugetlb_add_file_rmap(struct folio *folio)
>  {
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 57e898187931..378e460a6ab4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5409,8 +5409,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  			 */
>  			if (!folio_test_anon(pte_folio)) {
>  				hugetlb_add_file_rmap(pte_folio);
> -			} else if (page_try_dup_anon_rmap(&pte_folio->page,
> -							  true, src_vma)) {
> +			} else if (hugetlb_try_dup_anon_rmap(pte_folio, src_vma)) {
>  				pte_t src_pte_old = entry;
>  				struct folio *new_folio;
>  

