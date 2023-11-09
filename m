Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68FB7E637D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjKIF6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKIF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:58:03 -0500
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E462584
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:58:00 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 149FF1853C7;
        Thu,  9 Nov 2023 06:57:57 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1699509477; bh=MqstqUFo3qRv+8y+mXLmx8o+smjOl1Gu/3uTh1tvguk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SuUObiBlSA+XEm5UZOimSToNBpZfq9DztUUstHKz+4/E2RThJkDBa2wJufa9yW/HU
         IRzuGND92QCaB3roo+xW9l59udkTQ+vMAdqp1NMWmB41bypMbv5gTpZ8bmyXJ/ouQv
         NIDg5Jh8vp1wc5dzJdOQjKptEmd7hX5NtS6uvsE9Ae4voxU89AZyj1hUR6/ICJ7NDv
         wlWAEJ3928JqvdcpAkW0kUgixAApSBDpgwqwwXLvOI0xZT4rsjO6ruwAC/tW3yGekW
         bDIjGR/pk7hxzcRT5xTpSPA1oZdfSDVKbzYHAIS5GGz+Z/CwAB/XbCjMOlHVdOr9hq
         iYkfvEQokAKew==
Date:   Thu, 9 Nov 2023 06:57:56 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ramon Fried <ramon@neureality.ai>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] arm64: DMA zone above 4GB
Message-ID: <20231109065756.01e7272a@meshulam.tesarici.cz>
In-Reply-To: <9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il>
References: <9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Baruch,

On Wed,  8 Nov 2023 19:30:22 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> My platform RAM starts at 32GB. It has no RAM under 4GB. zone_sizes_init()
> puts the entire RAM in the DMA zone as follows:
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000800000000-0x00000008bfffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> 
> Consider a bus with this 'dma-ranges' property:
> 
>   #address-cells = <2>;
>   #size-cells = <2>;
>   dma-ranges = <0x00000000 0xc0000000 0x00000008 0x00000000 0x0 0x40000000>;
> 
> Devices under this bus can see 1GB of DMA range between 3GB-4GB. This
> range is mapped to CPU memory at 32GB-33GB.

Thank you for this email. I have recently expressed my concerns about
the possibility of such setups in theory (physical addresses v. DMA
addresses). Now it seems we have a real-world example where this is
actually happening.

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
> 
> Is there any better suggestion to make DMA buffer allocations work on
> this hardware?

Yes, but not any time soon. My idea was to abandon the various DMA
zones in the MM subsystem and replace them with a more flexible system
based on "allocation constraints".

I'm afraid there's not much the current Linux kernel can do for you.

Petr T

> Thanks
> ---
>  arch/arm64/mm/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
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
>  
>  #ifdef CONFIG_ZONE_DMA
>  	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
>  	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
>  	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
> -	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> +	arm64_dma_phys_limit = of_dma_get_max_cpu_address(NULL) + 1;
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif
>  #ifdef CONFIG_ZONE_DMA32

