Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54F97BA1F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjJEPGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjJEPFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:05:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4853D11797
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:41:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D171C15;
        Thu,  5 Oct 2023 07:41:44 -0700 (PDT)
Received: from [10.57.2.146] (unknown [10.57.2.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78BC73F641;
        Thu,  5 Oct 2023 07:41:03 -0700 (PDT)
Message-ID: <9e4e5536-05bb-4309-8d08-7158f9e7e8af@arm.com>
Date:   Thu, 5 Oct 2023 15:41:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/mm: Hoist synchronization out of set_ptes() loop
Content-Language: en-GB
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231005140730.2191134-1-ryan.roberts@arm.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231005140730.2191134-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 15:07, Ryan Roberts wrote:
> set_ptes() sets a physically contiguous block of memory (which all
> belongs to the same folio) to a contiguous block of ptes. The arm64
> implementation of this previously just looped, operating on each
> individual pte. But the __sync_icache_dcache() and mte_sync_tags()
> operations can both be hoisted out of the loop so that they are
> performed once for the contiguous set of pages (which may be less than
> the whole folio). This should result in minor performance gains.
> 
> __sync_icache_dcache() already acts on the whole folio, and sets a flag
> in the folio so that it skips duplicate calls. But by hoisting the call,
> all the pte testing is done only once.
> 
> mte_sync_tags() operates on each individual page with its own loop. But
> by passing the number of pages explicitly, we can rely solely on its
> loop and do the checks only once. This approach also makes it robust for
> the future, rather than assuming if a head page of a compound page is
> being mapped, then the whole compound page is being mapped, instead we
> explicitly know how many pages are being mapped. The old assumption may
> not continue to hold once the "anonymous large folios" feature is
> merged.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> v2 fixes the invocations of __set_pte_at() to pass nr_pages rather than order.
> Thanks to Steven Price for pointing that out.
> 
>  arch/arm64/include/asm/mte.h     |  4 ++--
>  arch/arm64/include/asm/pgtable.h | 27 +++++++++++++++++----------
>  arch/arm64/kernel/mte.c          |  4 ++--
>  3 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 4cedbaa16f41..91fbd5c8a391 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -90,7 +90,7 @@ static inline bool try_page_mte_tagging(struct page *page)
>  }
> 
>  void mte_zero_clear_page_tags(void *addr);
> -void mte_sync_tags(pte_t pte);
> +void mte_sync_tags(pte_t pte, unsigned int nr_pages);
>  void mte_copy_page_tags(void *kto, const void *kfrom);
>  void mte_thread_init_user(void);
>  void mte_thread_switch(struct task_struct *next);
> @@ -122,7 +122,7 @@ static inline bool try_page_mte_tagging(struct page *page)
>  static inline void mte_zero_clear_page_tags(void *addr)
>  {
>  }
> -static inline void mte_sync_tags(pte_t pte)
> +static inline void mte_sync_tags(pte_t pte, unsigned int nr_pages)
>  {
>  }
>  static inline void mte_copy_page_tags(void *kto, const void *kfrom)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7f7d9b1df4e5..68984ba9ce2a 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -325,8 +325,7 @@ static inline void __check_safe_pte_update(struct mm_struct *mm, pte_t *ptep,
>  		     __func__, pte_val(old_pte), pte_val(pte));
>  }
> 
> -static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
> -				pte_t *ptep, pte_t pte)
> +static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
>  {
>  	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
>  		__sync_icache_dcache(pte);
> @@ -339,20 +338,18 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	 */
>  	if (system_supports_mte() && pte_access_permitted(pte, false) &&
>  	    !pte_special(pte) && pte_tagged(pte))
> -		mte_sync_tags(pte);
> -
> -	__check_safe_pte_update(mm, ptep, pte);
> -
> -	set_pte(ptep, pte);
> +		mte_sync_tags(pte, nr_pages);
>  }
> 
>  static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pte, unsigned int nr)
>  {
>  	page_table_check_ptes_set(mm, ptep, pte, nr);
> +	__sync_cache_and_tags(pte, nr);
> 
>  	for (;;) {
> -		__set_pte_at(mm, addr, ptep, pte);
> +		__check_safe_pte_update(mm, ptep, pte);
> +		set_pte(ptep, pte);
>  		if (--nr == 0)
>  			break;
>  		ptep++;
> @@ -531,18 +528,28 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>  #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
>  #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
> 
> +static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	__sync_cache_and_tags(pte, nr);
> +	__check_safe_pte_update(mm, ptep, pte);
> +	set_pte(ptep, pte);
> +}
> +
>  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  			      pmd_t *pmdp, pmd_t pmd)
>  {
>  	page_table_check_pmd_set(mm, pmdp, pmd);
> -	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
> +	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd),
> +						PMD_SIZE >> PAGE_SHIFT);
>  }
> 
>  static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
>  			      pud_t *pudp, pud_t pud)
>  {
>  	page_table_check_pud_set(mm, pudp, pud);
> -	return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
> +	return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud),
> +						PUD_SIZE >> PAGE_SHIFT);
>  }
> 
>  #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 4edecaac8f91..2fb5e7a7a4d5 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -35,10 +35,10 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
>  EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
>  #endif
> 
> -void mte_sync_tags(pte_t pte)
> +void mte_sync_tags(pte_t pte, unsigned int nr_pages)
>  {
>  	struct page *page = pte_page(pte);
> -	long i, nr_pages = compound_nr(page);
> +	unsigned int i;
> 
>  	/* if PG_mte_tagged is set, tags have already been initialised */
>  	for (i = 0; i < nr_pages; i++, page++) {
> --
> 2.25.1
> 

