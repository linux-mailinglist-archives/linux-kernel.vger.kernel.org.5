Return-Path: <linux-kernel+bounces-165189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47788B894B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C2E1C2166C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405017F7CE;
	Wed,  1 May 2024 11:35:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B4864A98;
	Wed,  1 May 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563340; cv=none; b=chuEALxUr7UIuOnQF+8Rfz68J8tzwZnXAIFLuL/FqZwK6hNLkpbjo8OnIZfrexVxUTWg8NcIefCK4bUzcNUG+9oTpWkSqGDHvSFAYAxjjFyx5V1a25jhJchgC+LXMOgWE7jChzxRMO+iW4ZZU9lXNHPxT/SkIxXgDGoJC8XkmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563340; c=relaxed/simple;
	bh=/9Gt92MX4NTEbr32xrQETEyuVad3B2YH4vYh9uQ2Flg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT3008sXPl9O1FzyJzY4THwJA4zEJ6/LGYJm61mvTrba5jZTXKXIBe+yQFSiXFJno3S+tBejNhy8ZX9dYx6NvaFqIrUxe7OR9EofwwoWfvfdZV2Cgv9HxtsAF091bsepXctr1ubeV5Jf7RAcxjRU/R4ukGl2zNCO/Z5JCpzg5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 561EC339;
	Wed,  1 May 2024 04:36:04 -0700 (PDT)
Received: from [10.57.65.146] (unknown [10.57.65.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADA683F793;
	Wed,  1 May 2024 04:35:36 -0700 (PDT)
Message-ID: <9fb15315-6317-4bf4-a736-a8a44288b0c2@arm.com>
Date: Wed, 1 May 2024 12:35:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240430133138.732088-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240430133138.732088-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Zi Yan, I'm hoping you might have some input on the below...


On 30/04/2024 14:31, Ryan Roberts wrote:
> __split_huge_pmd_locked() can be called for a present THP, devmap or
> (non-present) migration entry. It calls pmdp_invalidate()
> unconditionally on the pmdp and only determines if it is present or not
> based on the returned old pmd.
> 
> But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
> unconditionally sets the PMD_PRESENT_INVALID flag, which causes future
> pmd_present() calls to return true - even for a swap pmd. Therefore any
> lockless pgtable walker could see the migration entry pmd in this state
> and start interpretting the fields (e.g. pmd_pfn()) as if it were
> present, leading to BadThings (TM). GUP-fast appears to be one such
> lockless pgtable walker.
> 
> While the obvious fix is for core-mm to avoid such calls for non-present
> pmds (pmdp_invalidate() will also issue TLBI which is not necessary for
> this case either), all other arches that implement pmd_mkinvalid() do it
> in such a way that it is robust to being called with a non-present pmd.

OK the plot thickens; The tests I wrote to check that pmd_mkinvalid() is safe for swap entries fails on x86_64. See below...

> So it is simpler and safer to make arm64 robust too. This approach means
> we can even add tests to debug_vm_pgtable.c to validate the required
> behaviour.
> 
> This is a theoretical bug found during code review. I don't have any
> test case to trigger it in practice.
> 
> Cc: stable@vger.kernel.org
> Fixes: 53fa117bb33c ("arm64/mm: Enable THP migration")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> Hi all,
> 
> v1 of this fix [1] took the approach of fixing core-mm to never call
> pmdp_invalidate() on a non-present pmd. But Zi Yan highlighted that only arm64
> suffers this problem; all other arches are robust. So his suggestion was to
> instead make arm64 robust in the same way and add tests to validate it. Despite
> my stated reservations in the context of the v1 discussion, having thought on it
> for a bit, I now agree with Zi Yan. Hence this post.
> 
> Andrew has v1 in mm-unstable at the moment, so probably the best thing to do is
> remove it from there and have this go in through the arm64 tree? Assuming there
> is agreement that this approach is right one.
> 
> This applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
> 
> [1] https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.roberts@arm.com/
> 
> Thanks,
> Ryan
> 
> 
>  arch/arm64/include/asm/pgtable.h | 12 +++++--
>  mm/debug_vm_pgtable.c            | 61 ++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index afdd56d26ad7..7d580271a46d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -511,8 +511,16 @@ static inline int pmd_trans_huge(pmd_t pmd)
> 
>  static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>  {
> -	pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
> -	pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
> +	/*
> +	 * If not valid then either we are already present-invalid or we are
> +	 * not-present (i.e. none or swap entry). We must not convert
> +	 * not-present to present-invalid. Unbelievably, the core-mm may call
> +	 * pmd_mkinvalid() for a swap entry and all other arches can handle it.
> +	 */
> +	if (pmd_valid(pmd)) {
> +		pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
> +		pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
> +	}
> 
>  	return pmd;
>  }
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 65c19025da3d..7e9c387d06b0 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -956,6 +956,65 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_HUGETLB_PAGE */
> 
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#if !defined(__HAVE_ARCH_PMDP_INVALIDATE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
> +static void __init swp_pmd_mkinvalid_tests(struct pgtable_debug_args *args)
> +{

Printing various values at different locations in this function for debug:

> +	unsigned long max_swap_offset;
> +	swp_entry_t swp_set, swp_clear, swp_convert;
> +	pmd_t pmd_set, pmd_clear;
> +
> +	/*
> +	 * See generic_max_swapfile_size(): probe the maximum offset, then
> +	 * create swap entry will all possible bits set and a swap entry will
> +	 * all bits clear.
> +	 */
> +	max_swap_offset = swp_offset(pmd_to_swp_entry(swp_entry_to_pmd(swp_entry(0, ~0UL))));
> +	swp_set = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offset);
> +	swp_clear = swp_entry(0, 0);
> +
> +	/* Convert to pmd. */
> +	pmd_set = swp_entry_to_pmd(swp_set);
> +	pmd_clear = swp_entry_to_pmd(swp_clear);

[    0.702163] debug_vm_pgtable: [swp_pmd_mkinvalid_tests  ]: valid: pmd_set=f800000000000000, pmd_clear=7fffffffffffe00

> +
> +	/*
> +	 * Sanity check that the pmds are not-present, not-huge and swap entry
> +	 * is recoverable without corruption.
> +	 */
> +	WARN_ON(pmd_present(pmd_set));
> +	WARN_ON(pmd_trans_huge(pmd_set));
> +	swp_convert = pmd_to_swp_entry(pmd_set);
> +	WARN_ON(swp_type(swp_set) != swp_type(swp_convert));
> +	WARN_ON(swp_offset(swp_set) != swp_offset(swp_convert));
> +	WARN_ON(pmd_present(pmd_clear));
> +	WARN_ON(pmd_trans_huge(pmd_clear));
> +	swp_convert = pmd_to_swp_entry(pmd_clear);
> +	WARN_ON(swp_type(swp_clear) != swp_type(swp_convert));
> +	WARN_ON(swp_offset(swp_clear) != swp_offset(swp_convert));
> +
> +	/* Now invalidate the pmd. */
> +	pmd_set = pmd_mkinvalid(pmd_set);
> +	pmd_clear = pmd_mkinvalid(pmd_clear);

[    0.704452] debug_vm_pgtable: [swp_pmd_mkinvalid_tests  ]: invalid: pmd_set=f800000000000000, pmd_clear=7ffffffffe00e00

> +
> +	/*
> +	 * Since its a swap pmd, invalidation should effectively be a noop and
> +	 * the checks we already did should give the same answer. Check the
> +	 * invalidation didn't corrupt any fields.
> +	 */
> +	WARN_ON(pmd_present(pmd_set));
> +	WARN_ON(pmd_trans_huge(pmd_set));
> +	swp_convert = pmd_to_swp_entry(pmd_set);

[    0.706461] debug_vm_pgtable: [swp_pmd_mkinvalid_tests  ]: set: swp=7c03ffffffffffff (1f, 3ffffffffffff), convert=7c03ffffffffffff (1f, 3ffffffffffff)

> +	WARN_ON(swp_type(swp_set) != swp_type(swp_convert));
> +	WARN_ON(swp_offset(swp_set) != swp_offset(swp_convert));
> +	WARN_ON(pmd_present(pmd_clear));
> +	WARN_ON(pmd_trans_huge(pmd_clear));
> +	swp_convert = pmd_to_swp_entry(pmd_clear);

[    0.708841] debug_vm_pgtable: [swp_pmd_mkinvalid_tests  ]: clear: swp=0 (0, 0), convert=ff8 (0, ff8)

> +	WARN_ON(swp_type(swp_clear) != swp_type(swp_convert));
> +	WARN_ON(swp_offset(swp_clear) != swp_offset(swp_convert));

This line fails on x86_64.

The logs show that the offset is indeed being corrupted by pmd_mkinvalid(); 0 -> 0xff8.

I think this is due to x86's pmd_mkinvalid() assuming the pmd is present; pmd_flags() and pmd_pfn() do all sorts of weird and wonderful things.

So does this take us full circle? Are we now back to modifying the core-mm to never call pmd_mkinvalid() on a non-present entry? If so, then I guess we should remove the arm64 fix from for-next/fixes.

> +}
> +#else
> +static void __init swp_pmd_mkinvalid_tests(struct pgtable_debug_args *args) { }
> +#endif /* !__HAVE_ARCH_PMDP_INVALIDATE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
> +
>  static void __init pmd_thp_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
> @@ -982,6 +1041,8 @@ static void __init pmd_thp_tests(struct pgtable_debug_args *args)
>  	WARN_ON(!pmd_trans_huge(pmd_mkinvalid(pmd_mkhuge(pmd))));
>  	WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))));
>  #endif /* __HAVE_ARCH_PMDP_INVALIDATE */
> +
> +	swp_pmd_mkinvalid_tests(args);
>  }
> 
>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> --
> 2.25.1
> 


