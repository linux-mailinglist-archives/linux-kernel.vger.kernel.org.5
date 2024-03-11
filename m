Return-Path: <linux-kernel+bounces-99279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C673D8785D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE75281B35
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC94482E5;
	Mon, 11 Mar 2024 16:56:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066A53E0D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176170; cv=none; b=flqxy0xpUuiC/LjQyEoW3/PnxrfBY1Ug8xrX8cSI6HYSqdFXKRqI53pQrLk2TSKf/x9iOim0q98egfy5YSpWNPT9E6t5HoN2j3t3FuOgFJqzGPB8U9mPaiBOxJcSrHvXXZyuJogAQv+26FysIsFRXiJztpyoRLZjH7J/wnddon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176170; c=relaxed/simple;
	bh=iVbrXEh86PG2ScBwA5U67Zu+kmuCtBYhi9GDJBy218Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz0F0P9Gjt4xiWSf9qT9z542empm8DDWoQxrrswa7JMvrW5G5mbc/+ttOdCkNILbgt85JnjKv81OvW9xU4XGFSOA4AZEpD+McSC8barce8o958FeRHWfOAIvGpx6JKB/sJj0r945a1TaPF2GuDZK5MKTEiPUVk6Y4fa5/Le7lZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58538FEC;
	Mon, 11 Mar 2024 09:56:44 -0700 (PDT)
Received: from [10.57.68.246] (unknown [10.57.68.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03BDB3F64C;
	Mon, 11 Mar 2024 09:56:00 -0700 (PDT)
Message-ID: <01c61b90-df90-4819-978b-414bb717ef64@arm.com>
Date: Mon, 11 Mar 2024 16:55:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/5] arm64: mm: swap: support THP_SWAP on hardware
 with MTE
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com,
 steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, Barry Song
 <v-songbaohua@oppo.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Peter Collingbourne <pcc@google.com>, Peter Xu <peterx@redhat.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Hugh Dickins <hughd@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-2-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240304081348.197341-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 08:13, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Commit d0637c505f8a1 ("arm64: enable THP_SWAP for arm64") brings up
> THP_SWAP on ARM64, but it doesn't enable THP_SWP on hardware with
> MTE as the MTE code works with the assumption tags save/restore is
> always handling a folio with only one page.
> 
> The limitation should be removed as more and more ARM64 SoCs have
> this feature. Co-existence of MTE and THP_SWAP becomes more and
> more important.
> 
> This patch makes MTE tags saving support large folios, then we don't
> need to split large folios into base pages for swapping out on ARM64
> SoCs with MTE any more.
> 
> arch_prepare_to_swap() should take folio rather than page as parameter
> because we support THP swap-out as a whole. It saves tags for all
> pages in a large folio.
> 
> As now we are restoring tags based-on folio, in arch_swap_restore(),
> we may increase some extra loops and early-exitings while refaulting
> a large folio which is still in swapcache in do_swap_page(). In case
> a large folio has nr pages, do_swap_page() will only set the PTE of
> the particular page which is causing the page fault.
> Thus do_swap_page() runs nr times, and each time, arch_swap_restore()
> will loop nr times for those subpages in the folio. So right now the
> algorithmic complexity becomes O(nr^2).
> 
> Once we support mapping large folios in do_swap_page(), extra loops
> and early-exitings will decrease while not being completely removed
> as a large folio might get partially tagged in corner cases such as,
> 1. a large folio in swapcache can be partially unmapped, thus, MTE
> tags for the unmapped pages will be invalidated;
> 2. users might use mprotect() to set MTEs on a part of a large folio.
> 
> arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
> who needed it.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 19 ++------------
>  arch/arm64/mm/mteswap.c          | 43 ++++++++++++++++++++++++++++++++
>  include/linux/huge_mm.h          | 12 ---------
>  include/linux/pgtable.h          |  2 +-
>  mm/page_io.c                     |  2 +-
>  mm/swap_slots.c                  |  2 +-
>  6 files changed, 48 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 401087e8a43d..7a54750770b8 100644
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
> @@ -1095,12 +1089,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  #ifdef CONFIG_ARM64_MTE
>  
>  #define __HAVE_ARCH_PREPARE_TO_SWAP
> -static inline int arch_prepare_to_swap(struct page *page)
> -{
> -	if (system_supports_mte())
> -		return mte_save_tags(page);
> -	return 0;
> -}
> +extern int arch_prepare_to_swap(struct folio *folio);
>  
>  #define __HAVE_ARCH_SWAP_INVALIDATE
>  static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> @@ -1116,11 +1105,7 @@ static inline void arch_swap_invalidate_area(int type)
>  }
>  
>  #define __HAVE_ARCH_SWAP_RESTORE
> -static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> -{
> -	if (system_supports_mte())
> -		mte_restore_tags(entry, &folio->page);
> -}
> +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
>  
>  #endif /* CONFIG_ARM64_MTE */
>  
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index a31833e3ddc5..295836fef620 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -68,6 +68,13 @@ void mte_invalidate_tags(int type, pgoff_t offset)
>  	mte_free_tag_storage(tags);
>  }
>  
> +static inline void __mte_invalidate_tags(struct page *page)
> +{
> +	swp_entry_t entry = page_swap_entry(page);
> +
> +	mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> +}
> +
>  void mte_invalidate_tags_area(int type)
>  {
>  	swp_entry_t entry = swp_entry(type, 0);
> @@ -83,3 +90,39 @@ void mte_invalidate_tags_area(int type)
>  	}
>  	xa_unlock(&mte_pages);
>  }
> +
> +int arch_prepare_to_swap(struct folio *folio)
> +{
> +	long i, nr;
> +	int err;
> +
> +	if (!system_supports_mte())
> +		return 0;
> +
> +	nr = folio_nr_pages(folio);
> +
> +	for (i = 0; i < nr; i++) {
> +		err = mte_save_tags(folio_page(folio, i));
> +		if (err)
> +			goto out;
> +	}
> +	return 0;
> +
> +out:
> +	while (i--)
> +		__mte_invalidate_tags(folio_page(folio, i));
> +	return err;
> +}
> +
> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)

I'm still not a fan of the fact that entry could be anywhere within folio.

> +{
> +	if (system_supports_mte()) {

nit: if you do:

if (!system_supports_mte())
	return;

It will be consistent with arch_prepare_to_swap() and reduce the indentation of
the main body.

> +		long i, nr = folio_nr_pages(folio);
> +
> +		entry.val -= swp_offset(entry) & (nr - 1);

This assumes that folios are always stored in swap with natural alignment. Is
that definitely a safe assumption? My swap-out series is currently ensuring that
folios are swapped-out naturally aligned, but that is an implementation detail.

Your cover note for swap-in says that you could technically swap in a large
folio without it having been swapped-out large. If you chose to do that in
future, this would break, right? I don't think it's good to couple the swap
storage layout to the folio order that you want to swap into. Perhaps that's an
argument for passing each *page* to this function with its exact, corresponding
swap entry?

> +		for (i = 0; i < nr; i++) {
> +			mte_restore_tags(entry, folio_page(folio, i));
> +			entry.val++;
> +		}
> +	}
> +}
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index de0c89105076..e04b93c43965 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -535,16 +535,4 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
>  #define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
>  #define split_folio(f) split_folio_to_order(f, 0)
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
> index e1b22903f709..bfcfe3386934 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1106,7 +1106,7 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>   * prototypes must be defined in the arch-specific asm/pgtable.h file.
>   */
>  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> -static inline int arch_prepare_to_swap(struct page *page)
> +static inline int arch_prepare_to_swap(struct folio *folio)
>  {
>  	return 0;
>  }
> diff --git a/mm/page_io.c b/mm/page_io.c
> index ae2b49055e43..a9a7c236aecc 100644
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
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 90973ce7881d..53abeaf1371d 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -310,7 +310,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>  	entry.val = 0;
>  
>  	if (folio_test_large(folio)) {
> -		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
> +		if (IS_ENABLED(CONFIG_THP_SWAP))
>  			get_swap_pages(1, &entry, folio_nr_pages(folio));
>  		goto out;
>  	}


