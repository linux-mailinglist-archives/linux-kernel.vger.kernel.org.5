Return-Path: <linux-kernel+bounces-15882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFBE8234EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8C1F25657
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADF1CA8F;
	Wed,  3 Jan 2024 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="ktbiLOTW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F881CA89
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from localhost (unknown [10.0.8.3])
	by mail.tkos.co.il (Postfix) with ESMTP id 5FDCA440A92;
	Wed,  3 Jan 2024 20:47:20 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1704307640;
	bh=TGqtNSqQzaT3LW4imqj4e0okddD35ScBH/nof2tytVY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=ktbiLOTWNHgYgoCMfabqvXLREuUI2x8zEHaLTHh6OnWDmRkQDb2xY8v2A1AA2Wbz/
	 3iJv8lAtSOR3TaD2Jzc18AvIWc3wQNy+u7nqvv7A8M7TqIq0FsezN9kSK3ujqfjguP
	 8RwFrT7lxIn7d04/f0AJ+9gYfwr3NAYJC8hJc+EBchZcEqrqGK1S/1UClae6I4cWbx
	 B01MUQsACIjNa4GLJ5Oq3cuMGagKdXhzceak8a3MmNQdlNDZtfRUX2RBpbv9sUS2v5
	 SgCZ8ErxMTQGC/iFTd5oTCkNicjxAq00JzY+4/7rDXUJGvqTsToFTPsn7MPBdYPjCv
	 eTNJ2TtesVe9Q==
References: <20240103170002.1793197-1-enachman@marvell.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Baruch Siach <baruch@tkos.co.il>
To: Elad Nachman <enachman@marvell.com>
Cc: catalin.marinas@arm.com, will@kernel.org, thunder.leizhen@huawei.com,
 bhe@redhat.com, akpm@linux-foundation.org, yajun.deng@linux.dev,
 chris.zjh@huawei.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: mm: Fix SOCs with DDR starting above zero
Date: Wed, 03 Jan 2024 20:47:17 +0200
In-reply-to: <20240103170002.1793197-1-enachman@marvell.com>
Message-ID: <87r0iy45ho.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Elad,

On Wed, Jan 03 2024, Elad Nachman wrote:
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

For an alternative approach see

  https://lore.kernel.org/all/cover.1703683642.git.baruch@tkos.co.il/

baruch

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


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

