Return-Path: <linux-kernel+bounces-138304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29D89EF91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406B81F23CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978915956E;
	Wed, 10 Apr 2024 10:06:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0985158DDC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743606; cv=none; b=m/DJm928HEjIpGkQSG0CWsa50T/Mi9pmlKWNXj6c0onYkNj3SE+esiMZTZrw7/rvAHFdZ1dG7KP+2QombjJv/9pzxtUC7v04l3JpfLXKJXgzdSgb0lUCEQzaPhajq/ajaQ+XanPPWmDIB6twM3ZGIoQ4rNLrQe1cPBnvWoB3YrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743606; c=relaxed/simple;
	bh=YHgIvGOrtETZLZaSnSGl4Xnu//QgnyOgU0yQOdUrV1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arJQ4QL0BFTw7HU7GRnYdCaxwxeWB9npqnYHk6oL7AnHftjBRmT3Xj9gIlj0Zbnq/2uG95X/uNGrxNYG6rhm45kKn37yI29xfbvL4zni/rQQBGYo5lCvMFB7bXy/uTJP1ad5JWjW0HEt+KLHMCl1+OZ0biRkRD2SpPikmj7CpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE1CA139F;
	Wed, 10 Apr 2024 03:07:13 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.17.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 374D63F6C4;
	Wed, 10 Apr 2024 03:06:42 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:06:39 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: Re: [PATCH v2 2/4] arm64: mm: Batch dsb and isb when populating
 pgtables
Message-ID: <ZhZkr7PHB6ppksWv@FVFF77S0Q05N>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404143308.2224141-3-ryan.roberts@arm.com>

On Thu, Apr 04, 2024 at 03:33:06PM +0100, Ryan Roberts wrote:
> After removing uneccessary TLBIs, the next bottleneck when creating the
> page tables for the linear map is DSB and ISB, which were previously
> issued per-pte in __set_pte(). Since we are writing multiple ptes in a
> given pte table, we can elide these barriers and insert them once we
> have finished writing to the table.
> 
> Execution time of map_mem(), which creates the kernel linear map page
> tables, was measured on different machines with different RAM configs:
> 
>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> ---------------|-------------|-------------|-------------|-------------
>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> ---------------|-------------|-------------|-------------|-------------
> before         |   77   (0%) |  431   (0%) | 1727   (0%) |  3796   (0%)
> after          |   13 (-84%) |  162 (-62%) |  655 (-62%) |  1656 (-56%)
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Tested-by: Eric Chanudet <echanude@redhat.com>
> ---
>  arch/arm64/include/asm/pgtable.h |  7 ++++++-
>  arch/arm64/mm/mmu.c              | 13 ++++++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index afdd56d26ad7..105a95a8845c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -271,9 +271,14 @@ static inline pte_t pte_mkdevmap(pte_t pte)
>  	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
>  }
>  
> -static inline void __set_pte(pte_t *ptep, pte_t pte)
> +static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
>  {
>  	WRITE_ONCE(*ptep, pte);
> +}
> +
> +static inline void __set_pte(pte_t *ptep, pte_t pte)
> +{
> +	__set_pte_nosync(ptep, pte);
>  
>  	/*
>  	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index fd91b5bdb514..dc86dceb0efe 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -178,7 +178,11 @@ static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  	do {
>  		pte_t old_pte = __ptep_get(ptep);
>  
> -		__set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
> +		/*
> +		 * Required barriers to make this visible to the table walker
> +		 * are deferred to the end of alloc_init_cont_pte().
> +		 */
> +		__set_pte_nosync(ptep, pfn_pte(__phys_to_pfn(phys), prot));
>  
>  		/*
>  		 * After the PTE entry has been populated once, we
> @@ -234,6 +238,13 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  	} while (addr = next, addr != end);
>  
>  	pte_clear_fixmap();
> +
> +	/*
> +	 * Ensure all previous pgtable writes are visible to the table walker.
> +	 * See init_pte().
> +	 */
> +	dsb(ishst);
> +	isb();

Hmm... currently the call to pte_clear_fixmap() alone should be sufficient,
since that needs to update the PTE for the fixmap slot, then do maintenance for
that.

So we could avoid the addition of the dsb+isb here, and have a comment:

	/*
	 * Note: barriers and maintenance necessary to clear the fixmap slot
	 * ensure that all previous pgtable writes are visible to the table
	 * walker.
	 */
	pte_clear_fixmap();

.. which'd be fine as long as we keep this fixmap clearing rather than trying
to do that lazily as in patch 4.

Mark.

>  }
>  
>  static pmd_t *init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
> -- 
> 2.25.1
> 

