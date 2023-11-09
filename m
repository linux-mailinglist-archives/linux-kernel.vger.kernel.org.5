Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C8C7E6FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjKIRAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjKIRAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:00:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF9E41FCB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:00:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E133106F;
        Thu,  9 Nov 2023 09:00:48 -0800 (PST)
Received: from arm.com (RQ4T19M611.cambridge.arm.com [10.1.27.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E5E63F7C5;
        Thu,  9 Nov 2023 09:00:02 -0800 (PST)
Date:   Thu, 9 Nov 2023 17:00:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ramon Fried <ramon@neureality.ai>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] arm64: DMA zone above 4GB
Message-ID: <ZU0QEL9ByWNYVki1@arm.com>
References: <9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 07:30:22PM +0200, Baruch Siach wrote:
> My platform RAM starts at 32GB. It has no RAM under 4GB. zone_sizes_init()
> puts the entire RAM in the DMA zone as follows:
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000800000000-0x00000008bfffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty

This was a concious decision with commit 791ab8b2e3db ("arm64: Ignore
any DMA offsets in the max_zone_phys() calculation"). The prior code
seemed a bit of a hack and it also did not play well with zone_dma_bits
(as you noticed as well).

> Consider a bus with this 'dma-ranges' property:
> 
>   #address-cells = <2>;
>   #size-cells = <2>;
>   dma-ranges = <0x00000000 0xc0000000 0x00000008 0x00000000 0x0 0x40000000>;
> 
> Devices under this bus can see 1GB of DMA range between 3GB-4GB. This
> range is mapped to CPU memory at 32GB-33GB.

Is this on real hardware or just theoretical for now (the rest of your
email implies it's real)? Normally I'd expected the first GB (or first
two) of RAM from 32G to be aliased to the lower 32-bit range for the CPU
view as well, not just for devices. You'd then get a ZONE_DMA without
having to play with DMA offsets.

> Current zone_sizes_init() code considers 'dma-ranges' only when it maps
> to RAM under 4GB, because zone_dma_bits is limited to 32. In this case
> 'dma-ranges' is ignored in practice, since DMA/DMA32 zones are both
> assumed to be located under 4GB. The result is that the stmmac driver
> DMA buffers allocation GFP_DMA32 flag has no effect. As a result DMA
> buffer allocations fail.
> 
> The patch below is a crude workaround hack. It makes the  DMA zone
> cover the 1GB memory area that is visible to stmmac DMA as follows:
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]
> ...
> [    0.000000] software IO TLB: mapped [mem 0x000000083bfff000-0x000000083ffff000] (64MB)
> 
> With this hack the stmmac driver works on my platform with no
> modification.
> 
> Clearly this can't be the right solutions. zone_dma_bits is now wrong for
> one. It probably breaks other code as well.

zone_dma_bits ends up as 36 if I counted correctly. So DMA_BIT_MASK(36)
is 0xf_ffff_ffff and the phys_limit for your device is below this mask,
so dma_direct_optimal_gfp_mask() does end up setting GFP_DMA. However,
looking at how it sets GFP_DMA32, it is obvious that the code is not set
up for such configurations. I'm also not a big fan of zone_dma_bits
describing a mask that goes well above what the device can access.

A workaround would be for zone_dma_bits to become a *_limit and sort out
all places where we compare masks with masks derived from zone_dma_bits
(e.g. cma_in_zone(), dma_direct_supported()). Alternatively, take the
DMA offset into account when comparing the physical address
corresponding to zone_dma_bits and keep zone_dma_bits small (phys offset
subtracted, so in your case it would be 30 rather than 36).

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 74c1db8ce271..5fe826ac3a5f 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -136,13 +136,13 @@ static void __init zone_sizes_init(void)
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
>  	unsigned int __maybe_unused acpi_zone_dma_bits;
>  	unsigned int __maybe_unused dt_zone_dma_bits;
> -	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
> +	phys_addr_t __maybe_unused dma32_phys_limit = DMA_BIT_MASK(32) + 1;

This effectively gets rid of ZONE_DMA32 for your scenario. It's probably
the right approach. I wouldn't worry about a GFP_DMA32 in such platform
configurations. If a device has a DMA offset, don't bother checking
whether its mask is 32-bit.

>  #ifdef CONFIG_ZONE_DMA
>  	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
>  	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
>  	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
> -	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> +	arm64_dma_phys_limit = of_dma_get_max_cpu_address(NULL) + 1;
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif
>  #ifdef CONFIG_ZONE_DMA32

This would need to work for ACPI as well, so use the max of
acpi_iort_dma_get_max_cpu_address() and of_dma_get_max_cpu_address().
The zone_dma_bits would than be derived from the arm64_dma_phys_limit
rather than the other way around.

However, other than correctly defining the zones, we'd need to decide
what the DMA mask actually is (bits from an offset or it includes the
offset), whether we need to switch to a limit instead.

-- 
Catalin
