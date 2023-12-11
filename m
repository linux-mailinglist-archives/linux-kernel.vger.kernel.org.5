Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E667380D0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbjLKQR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjLKQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:17:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 895E01BDB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:17:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5A1916F2;
        Mon, 11 Dec 2023 08:18:08 -0800 (PST)
Received: from [10.57.73.30] (unknown [10.57.73.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAF1B3F738;
        Mon, 11 Dec 2023 08:17:20 -0800 (PST)
Message-ID: <d8523f4a-97e0-4d04-8656-661c59f22504@arm.com>
Date:   Mon, 11 Dec 2023 16:17:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/39] mm/rmap: introduce and use
 hugetlb_add_file_rmap()
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
 <20231211155652.131054-4-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-4-david@redhat.com>
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
> Right now we're using page_dup_file_rmap() in some cases where "ordinary"
> rmap code would have used page_add_file_rmap(). So let's introduce and
> use hugetlb_add_file_rmap() instead. We won't be adding a
> "hugetlb_dup_file_rmap()" functon for the fork() case, as it would be
> doing the same: "dup" is just an optimization for "add".
> 
> What remains is a single page_dup_file_rmap() call in fork() code.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/rmap.h | 7 +++++++
>  mm/hugetlb.c         | 6 +++---
>  mm/migrate.c         | 2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index d85bd1d4de04..91178d1aa028 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -213,6 +213,13 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  
> +static inline void hugetlb_add_file_rmap(struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> +
> +	atomic_inc(&folio->_entire_mapcount);
> +}
> +
>  static inline void hugetlb_remove_rmap(struct folio *folio)
>  {
>  	atomic_dec(&folio->_entire_mapcount);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ef48ae673890..57e898187931 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5408,7 +5408,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  			 * sleep during the process.
>  			 */
>  			if (!folio_test_anon(pte_folio)) {
> -				page_dup_file_rmap(&pte_folio->page, true);
> +				hugetlb_add_file_rmap(pte_folio);
>  			} else if (page_try_dup_anon_rmap(&pte_folio->page,
>  							  true, src_vma)) {
>  				pte_t src_pte_old = entry;
> @@ -6279,7 +6279,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	if (anon_rmap)
>  		hugetlb_add_new_anon_rmap(folio, vma, haddr);
>  	else
> -		page_dup_file_rmap(&folio->page, true);
> +		hugetlb_add_file_rmap(folio);
>  	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
>  				&& (vma->vm_flags & VM_SHARED)));
>  	/*
> @@ -6730,7 +6730,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  		goto out_release_unlock;
>  
>  	if (folio_in_pagecache)
> -		page_dup_file_rmap(&folio->page, true);
> +		hugetlb_add_file_rmap(folio);
>  	else
>  		hugetlb_add_new_anon_rmap(folio, dst_vma, dst_addr);
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4cb849fa0dd2..de9d94b99ab7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -252,7 +252,7 @@ static bool remove_migration_pte(struct folio *folio,
>  				hugetlb_add_anon_rmap(folio, vma, pvmw.address,
>  						      rmap_flags);
>  			else
> -				page_dup_file_rmap(new, true);
> +				hugetlb_add_file_rmap(folio);
>  			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte,
>  					psize);
>  		} else

