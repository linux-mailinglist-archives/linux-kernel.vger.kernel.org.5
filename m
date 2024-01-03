Return-Path: <linux-kernel+bounces-15816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CEA8233B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5981C23CA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6058E1CA9F;
	Wed,  3 Jan 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2IlVFI5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D11CA98
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 17:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CF6C433C7;
	Wed,  3 Jan 2024 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704303938;
	bh=/4dVKaf541G+sc8duQTMeRs7/R1QzyO3O6dn3yMRbxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2IlVFI57SKaomPzPJssiMq1AJk53XApMfLbYpHz22r+d5EUB698Eaos7tveBNH0M
	 s18IXtYBuAs7LOt9cNZ/iLPRI5LsqICqh8jUVal/Ypw+8pzCEKZbwgO+BLLGAwRGH1
	 K8HIi9PyJEfKtENqKywnPBQuhAqSEJuuoFiMedY6Knjh8X6F4Tt2nZTzsSYJGqSJ/t
	 /8gyc5UhjVQWoXRgbm8hFgQKBJ/UIxQnkBO6DjLFd7d9lIrxjZyaZ93flP4XY90H3U
	 aPqSawycIs0b4CvYy0VLU1yVQB8rAb2NjMGu21cAW96mfkjILf3N+SyhiLZRexg6hO
	 GbmbeUK2YqBNg==
Date: Wed, 3 Jan 2024 17:45:32 +0000
From: Will Deacon <will@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: catalin.marinas@arm.com, thunder.leizhen@huawei.com, bhe@redhat.com,
	akpm@linux-foundation.org, yajun.deng@linux.dev,
	chris.zjh@huawei.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: mm: Fix SOCs with DDR starting above zero
Message-ID: <20240103174531.GE5954@willie-the-truck>
References: <20240103170002.1793197-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103170002.1793197-1-enachman@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 03, 2024 at 07:00:02PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Some SOCs, like the Marvell AC5/X/IM, have a combination
> of DDR starting at 0x2_0000_0000 coupled with DMA controllers
> limited to 31 and 32 bit of addressing.
> This requires to properly arrange ZONE_DMA and ZONE_DMA32 for
> these SOCs, so swiotlb and coherent DMA allocation would work
> properly.
> Change initialization so device tree dma zone bits are taken as
> function of offset from DRAM start, and when calculating the
> maximal zone physical RAM address for physical DDR starting above
> 32-bit, combine the physical address start plus the zone mask
> passed as parameter.
> This creates the proper zone splitting for these SOCs:
> 0..2GB for ZONE_DMA
> 2GB..4GB for ZONE_DMA32
> 4GB..8GB for ZONE_NORMAL
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  arch/arm64/mm/init.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 74c1db8ce271..8288c778916e 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -115,20 +115,21 @@ static void __init arch_reserve_crashkernel(void)
>  
>  /*
>   * Return the maximum physical address for a zone accessible by the given bits
> - * limit. If DRAM starts above 32-bit, expand the zone to the maximum
> - * available memory, otherwise cap it at 32-bit.
> + * limit. If DRAM starts above 32-bit, expand the zone to the available memory
> + * start limited by the zone bits mask, otherwise cap it at 32-bit.
>   */
>  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>  {
>  	phys_addr_t zone_mask = DMA_BIT_MASK(zone_bits);
>  	phys_addr_t phys_start = memblock_start_of_DRAM();
> +	phys_addr_t phys_end = memblock_end_of_DRAM();
>  
>  	if (phys_start > U32_MAX)
> -		zone_mask = PHYS_ADDR_MAX;
> +		zone_mask = phys_start | zone_mask;
>  	else if (phys_start > zone_mask)
>  		zone_mask = U32_MAX;
>  
> -	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
> +	return min(zone_mask, phys_end - 1) + 1;
>  }
>  
>  static void __init zone_sizes_init(void)
> @@ -140,7 +141,16 @@ static void __init zone_sizes_init(void)
>  
>  #ifdef CONFIG_ZONE_DMA
>  	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
> -	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
> +	/*
> +	 * When calculating the dma zone bits from the device tree, subtract
> +	 * the DRAM start address, in case it does not start from address
> +	 * zero. This way. we pass only the zone size related bits to
> +	 * max_zone_phys(), which will add them to the base of the DRAM.
> +	 * This prevents miscalculations on arm64 SOCs which combines
> +	 * DDR starting above 4GB with memory controllers limited to
> +	 * 32-bits or less:
> +	 */
> +	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL) - memblock_start_of_DRAM());
>  	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
>  	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);

Hmm, I'm a bit worried this could regress other platforms since you seem
to be assuming that DMA address 0 corresponds to the physical start of
DRAM. What if that isn't the case?

In any case, we should try hard to avoid different behaviour between DT
and ACPI here.

Will

