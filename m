Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D2480D1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbjLKQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbjLKQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:29:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6925FE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:29:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4249D1007;
        Mon, 11 Dec 2023 08:29:56 -0800 (PST)
Received: from [10.57.73.30] (unknown [10.57.73.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53B433F738;
        Mon, 11 Dec 2023 08:29:08 -0800 (PST)
Message-ID: <fea2113f-1ac6-4968-88a6-674ef7800ef2@arm.com>
Date:   Mon, 11 Dec 2023 16:29:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/39] mm/rmap: introduce and use
 hugetlb_try_share_anon_rmap()
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
 <20231211155652.131054-6-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-6-david@redhat.com>
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
> Note that try_to_unmap_one() does not need care. Easy to spot because
> among all that nasty hugetlb special-casing in that function, we're not
> using set_huge_pte_at() on the anon path -- well, and that code assumes
> that we would want to swapout.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/rmap.h | 23 +++++++++++++++++++++++
>  mm/rmap.c            | 15 ++++++++++-----
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index ca42b3db5688..4c0650e9f6db 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -228,6 +228,29 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
>  	return 0;
>  }
>  
> +/* See page_try_share_anon_rmap() */
> +static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +	VM_WARN_ON_FOLIO(!PageAnonExclusive(&folio->page), folio);
> +
> +	/* Paired with the memory barrier in try_grab_folio(). */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> +		smp_mb();
> +
> +	if (unlikely(folio_maybe_dma_pinned(folio)))
> +		return -EBUSY;
> +	ClearPageAnonExclusive(&folio->page);
> +
> +	/*
> +	 * This is conceptually a smp_wmb() paired with the smp_rmb() in
> +	 * gup_must_unshare().
> +	 */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> +		smp_mb__after_atomic();
> +	return 0;
> +}
> +
>  static inline void hugetlb_add_file_rmap(struct folio *folio)
>  {
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 4e60c1f38eaa..e210ac1b73de 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2147,13 +2147,18 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  				       !anon_exclusive, subpage);
>  
>  			/* See page_try_share_anon_rmap(): clear PTE first. */
> -			if (anon_exclusive &&
> -			    page_try_share_anon_rmap(subpage)) {
> -				if (folio_test_hugetlb(folio))
> +			if (folio_test_hugetlb(folio)) {
> +				if (anon_exclusive &&
> +				    hugetlb_try_share_anon_rmap(folio)) {
>  					set_huge_pte_at(mm, address, pvmw.pte,
>  							pteval, hsz);
> -				else
> -					set_pte_at(mm, address, pvmw.pte, pteval);
> +					ret = false;
> +					page_vma_mapped_walk_done(&pvmw);
> +					break;
> +				}
> +			} else if (anon_exclusive &&
> +				   page_try_share_anon_rmap(subpage)) {
> +				set_pte_at(mm, address, pvmw.pte, pteval);
>  				ret = false;
>  				page_vma_mapped_walk_done(&pvmw);
>  				break;

