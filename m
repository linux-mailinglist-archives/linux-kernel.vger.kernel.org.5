Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890E27E0238
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjKCLbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCLbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:31:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0CB9D4D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:31:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C77B2F4;
        Fri,  3 Nov 2023 04:32:02 -0700 (PDT)
Received: from [10.57.71.183] (unknown [10.57.71.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D77033F67D;
        Fri,  3 Nov 2023 04:31:17 -0700 (PDT)
Message-ID: <6641a14b-e3fb-4e9e-bb95-b0306827294b@arm.com>
Date:   Fri, 3 Nov 2023 11:31:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     Steven.Price@arm.com, akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com
References: <73aad98e-de4c-4021-af3c-db67e06cdb70@arm.com>
 <20231102223643.7733-1-v-songbaohua@oppo.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231102223643.7733-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 22:36, Barry Song wrote:
>> But, yes, it would be nice to fix that! And if I've understood the problem
>> correctly, it doesn't sound like it should be too hard? Is this something you
>> are volunteering for?? :)
> 
> Unfornately right now I haven't a real hardware with MTE which can run the latest
> kernel. but i have written a RFC, it will be nice to get someone to test it. Let
> me figure out if we can get someone :-)

OK, let me know if you find someone. Otherwise I can have a hunt around to see
if I can test it.

> 
> [RFC PATCH] arm64: mm: swap: save and restore mte tags for large folios
> 
> This patch makes MTE tags saving and restoring support large folios,
> then we don't need to split them into base pages for swapping on
> ARM64 SoCs with MTE.
> 
> ---
>  arch/arm64/include/asm/pgtable.h | 21 ++++-----------------
>  arch/arm64/mm/mteswap.c          | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7f7d9b1df4e5..b12783dca00a 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -45,12 +45,6 @@
>  	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -static inline bool arch_thp_swp_supported(void)
> -{
> -	return !system_supports_mte();
> -}
> -#define arch_thp_swp_supported arch_thp_swp_supported

IIRC, arm64 was the only arch implementing this, so perhaps it should be ripped
out from the core code now?

> -
>  /*
>   * Outside of a few very special situations (e.g. hibernation), we always
>   * use broadcast TLB invalidation instructions, therefore a spurious page
> @@ -1028,12 +1022,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  #ifdef CONFIG_ARM64_MTE
>  
>  #define __HAVE_ARCH_PREPARE_TO_SWAP
> -static inline int arch_prepare_to_swap(struct page *page)
> -{
> -	if (system_supports_mte())
> -		return mte_save_tags(page);
> -	return 0;
> -}
> +#define arch_prepare_to_swap arch_prepare_to_swap
> +extern int arch_prepare_to_swap(struct page *page);

I think it would be better to modify this API to take a folio explicitly. The
caller already has the folio.

>  
>  #define __HAVE_ARCH_SWAP_INVALIDATE
>  static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> @@ -1049,11 +1039,8 @@ static inline void arch_swap_invalidate_area(int type)
>  }
>  
>  #define __HAVE_ARCH_SWAP_RESTORE
> -static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> -{
> -	if (system_supports_mte())
> -		mte_restore_tags(entry, &folio->page);
> -}
> +#define arch_swap_restore arch_swap_restore
> +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
>  
>  #endif /* CONFIG_ARM64_MTE */
>  
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index a31833e3ddc5..e5637e931e4f 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -83,3 +83,23 @@ void mte_invalidate_tags_area(int type)
>  	}
>  	xa_unlock(&mte_pages);
>  }
> +
> +int arch_prepare_to_swap(struct page *page)
> +{
> +	if (system_supports_mte()) {
> +		struct folio *folio = page_folio(page);
> +		long i, nr = folio_nr_pages(folio);
> +		for (i = 0; i < nr; i++)
> +			return mte_save_tags(folio_page(folio, i));

This will return after saving the first page of the folio! You will need to add
each page in a loop, and if you get an error at any point, you will need to
remove the pages that you already added successfully, by calling
arch_swap_invalidate_page() as far as I can see. Steven can you confirm?

> +	}
> +	return 0;
> +}
> +
> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> +{
> +	if (system_supports_mte()) {
> +		long i, nr = folio_nr_pages(folio);
> +		for (i = 0; i < nr; i++)
> +			mte_restore_tags(entry, folio_page(folio, i));

swap-in currently doesn't support large folios - everything is a single page
folio. So this isn't technically needed. But from the API POV, it seems
reasonable to make this change - except your implementation is broken. You are
currently setting every page in the folio to use the same tags as the first
page. You need to increment the swap entry for each page.

Thanks,
Ryan


> +	}
> +}

