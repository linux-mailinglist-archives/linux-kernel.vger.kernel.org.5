Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00A67EC58D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344107AbjKOOkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbjKOOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:40:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47130A9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:40:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 631081FB;
        Wed, 15 Nov 2023 06:40:59 -0800 (PST)
Received: from [10.57.40.146] (unknown [10.57.40.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0E523F641;
        Wed, 15 Nov 2023 06:40:08 -0800 (PST)
Message-ID: <0164d185-12db-478a-93fd-b07d5fe00599@arm.com>
Date:   Wed, 15 Nov 2023 14:40:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
        ryan.roberts@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@suse.com, shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
References: <20231114014313.67232-1-v-songbaohua@oppo.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231114014313.67232-1-v-songbaohua@oppo.com>
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

On 14/11/2023 01:43, Barry Song wrote:
> This patch makes MTE tags saving and restoring support large folios,
> then we don't need to split them into base pages for swapping out
> on ARM64 SoCs with MTE.
> 
> arch_prepare_to_swap() should take folio rather than page as parameter
> because we support THP swap-out as a whole.
> 
> Meanwhile, arch_swap_restore() should use page parameter rather than
> folio as swap-in always works at the granularity of base pages right
> now.
> 
> arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
> who needed it.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM!

Reviewed: Steven Price <steven.price@arm.com>

Although one NIT below you might want to fix.

> ---
>  rfc v3:
>  * move arch_swap_restore() to take page rather than folio according to
>  the discussion with Ryan and Steven;
>  * fix some other issues commented by Ryan
> 
>  rfc v2:
>  https://lore.kernel.org/lkml/20231104093423.170054-1-v-songbaohua@oppo.com/
>  rfc v1:
>  https://lore.kernel.org/lkml/20231102223643.7733-1-v-songbaohua@oppo.com/
> 
>  arch/arm64/include/asm/pgtable.h | 21 ++++----------------
>  arch/arm64/mm/mteswap.c          | 34 ++++++++++++++++++++++++++++++++
>  include/linux/huge_mm.h          | 12 -----------
>  include/linux/pgtable.h          |  4 ++--
>  mm/memory.c                      |  2 +-
>  mm/page_io.c                     |  2 +-
>  mm/shmem.c                       |  2 +-
>  mm/swap_slots.c                  |  2 +-
>  mm/swapfile.c                    |  2 +-
>  9 files changed, 45 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b19a8aee684c..c3eef11c1a9e 100644
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
> -
>  /*
>   * Outside of a few very special situations (e.g. hibernation), we always
>   * use broadcast TLB invalidation instructions, therefore a spurious page
> @@ -1036,12 +1030,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
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
> +extern int arch_prepare_to_swap(struct folio *folio);
>  
>  #define __HAVE_ARCH_SWAP_INVALIDATE
>  static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> @@ -1057,11 +1047,8 @@ static inline void arch_swap_invalidate_area(int type)
>  }
>  
>  #define __HAVE_ARCH_SWAP_RESTORE
> -static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> -{
> -	if (system_supports_mte())
> -		mte_restore_tags(entry, &folio->page);
> -}
> +#define arch_swap_restore arch_swap_restore
> +extern void arch_swap_restore(swp_entry_t entry, struct page *page);
>  
>  #endif /* CONFIG_ARM64_MTE */
>  
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index a31833e3ddc5..75c2836e8240 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -68,6 +68,12 @@ void mte_invalidate_tags(int type, pgoff_t offset)
>  	mte_free_tag_storage(tags);
>  }
>  
> +static inline void __mte_invalidate_tags(struct page *page)
> +{
> +	swp_entry_t entry = page_swap_entry(page);
> +	mte_invalidate_tags(swp_type(entry), swp_offset(entry));

NIT: checkpatch will complain there should be blank line between these
two lines (declarations are followed by a blank line).

Steve

> +}
> +
>  void mte_invalidate_tags_area(int type)
>  {
>  	swp_entry_t entry = swp_entry(type, 0);
> @@ -83,3 +89,31 @@ void mte_invalidate_tags_area(int type)
>  	}
>  	xa_unlock(&mte_pages);
>  }
> +
> +int arch_prepare_to_swap(struct folio *folio)
> +{
> +	int err;
> +	long i;
> +
> +	if (system_supports_mte()) {
> +		long nr = folio_nr_pages(folio);
> +
> +		for (i = 0; i < nr; i++) {
> +			err = mte_save_tags(folio_page(folio, i));
> +			if (err)
> +				goto out;
> +		}
> +	}
> +	return 0;
> +
> +out:
> +	while (i--)
> +		__mte_invalidate_tags(folio_page(folio, i));
> +	return err;
> +}
> +
> +void arch_swap_restore(swp_entry_t entry, struct page *page)
> +{
> +	if (system_supports_mte())
> +		mte_restore_tags(entry, page);
> +}
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index fa0350b0812a..f83fb8d5241e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -400,16 +400,4 @@ static inline int split_folio(struct folio *folio)
>  	return split_folio_to_list(folio, NULL);
>  }
>  
> -/*
> - * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
> - * limitations in the implementation like arm64 MTE can override this to
> - * false
> - */
> -#ifndef arch_thp_swp_supported
> -static inline bool arch_thp_swp_supported(void)
> -{
> -	return true;
> -}
> -#endif
> -
>  #endif /* _LINUX_HUGE_MM_H */
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index af7639c3b0a3..87e3140a55ca 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -897,7 +897,7 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>   * prototypes must be defined in the arch-specific asm/pgtable.h file.
>   */
>  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> -static inline int arch_prepare_to_swap(struct page *page)
> +static inline int arch_prepare_to_swap(struct folio *folio)
>  {
>  	return 0;
>  }
> @@ -914,7 +914,7 @@ static inline void arch_swap_invalidate_area(int type)
>  #endif
>  
>  #ifndef __HAVE_ARCH_SWAP_RESTORE
> -static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> +static inline void arch_swap_restore(swp_entry_t entry, struct page *page)
>  {
>  }
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f18ed4a5497..fad238dd38e7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4022,7 +4022,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	 * when reading from swap. This metadata may be indexed by swap entry
>  	 * so this must be called before swap_free().
>  	 */
> -	arch_swap_restore(entry, folio);
> +	arch_swap_restore(entry, page);
>  
>  	/*
>  	 * Remove the swap entry and conditionally try to free up the swapcache.
> diff --git a/mm/page_io.c b/mm/page_io.c
> index cb559ae324c6..0fd832474c1d 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  	 * Arch code may have to preserve more data than just the page
>  	 * contents, e.g. memory tags.
>  	 */
> -	ret = arch_prepare_to_swap(&folio->page);
> +	ret = arch_prepare_to_swap(folio);
>  	if (ret) {
>  		folio_mark_dirty(folio);
>  		folio_unlock(folio);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 91e2620148b2..7d32e50da121 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1892,7 +1892,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	 * Some architectures may have to restore extra metadata to the
>  	 * folio after reading from swap.
>  	 */
> -	arch_swap_restore(swap, folio);
> +	arch_swap_restore(swap, &folio->page);
>  
>  	if (shmem_should_replace_folio(folio, gfp)) {
>  		error = shmem_replace_folio(&folio, gfp, info, index);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0bec1f705f8e..2325adbb1f19 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>  	entry.val = 0;
>  
>  	if (folio_test_large(folio)) {
> -		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
> +		if (IS_ENABLED(CONFIG_THP_SWAP))
>  			get_swap_pages(1, &entry, folio_nr_pages(folio));
>  		goto out;
>  	}
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4bc70f459164..6450e0279e35 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1784,7 +1784,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  	 * when reading from swap. This metadata may be indexed by swap entry
>  	 * so this must be called before swap_free().
>  	 */
> -	arch_swap_restore(entry, page_folio(page));
> +	arch_swap_restore(entry, page);
>  
>  	/* See do_swap_page() */
>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));

