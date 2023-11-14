Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015AE7EB12E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjKNNrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjKNNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:47:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C06471A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:47:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2809C15;
        Tue, 14 Nov 2023 05:48:14 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AD0C3F6C4;
        Tue, 14 Nov 2023 05:47:27 -0800 (PST)
Message-ID: <e5ebfde9-7a74-4908-b0b9-db47c4e76315@arm.com>
Date:   Tue, 14 Nov 2023 13:47:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/mm: add option to prefer IOMMU ops for DMA on Xen
Content-Language: en-GB
To:     Chuck Zmudzinski <brchuckz@aol.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Julien Grall <julien@xen.org>,
        Mario Marietto <marietto2008@gmail.com>,
        Bertrand Marquis <bertrand.marquis@arm.com>
References: <20231111184538.2371-1-brchuckz.ref@aol.com>
 <20231111184538.2371-1-brchuckz@aol.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231111184538.2371-1-brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2023 6:45 pm, Chuck Zmudzinski wrote:
> Enabling the new option, ARM_DMA_USE_IOMMU_XEN, fixes this error when
> attaching the Exynos mixer in Linux dom0 on Xen on the Chromebook Snow
> (and probably on other devices that use the Exynos mixer):
> 
> [drm] Exynos DRM: using 14400000.fimd device for DMA mapping operations
> exynos-drm exynos-drm: bound 14400000.fimd (ops 0xc0d96354)
> exynos-mixer 14450000.mixer: [drm:exynos_drm_register_dma] *ERROR* Device
>                               14450000.mixer lacks support for IOMMU
> exynos-drm exynos-drm: failed to bind 14450000.mixer (ops 0xc0d97554): -22
> exynos-drm exynos-drm: adev bind failed: -22
> exynos-dp: probe of 145b0000.dp-controller failed with error -22
> 
> Linux normally uses xen_swiotlb_dma_ops for DMA for all devices when
> xen_swiotlb is detected even when Xen exposes an IOMMU to Linux. Enabling
> the new config option allows devices such as the Exynos mixer to use the
> IOMMU instead of xen_swiotlb_dma_ops for DMA and this fixes the error.
> 
> The new config option is not set by default because it is likely some
> devices that use IOMMU for DMA on Xen will cause DMA errors and memory
> corruption when Xen PV block and network drivers are in use on the system.
> 
> Link: https://lore.kernel.org/xen-devel/acfab1c5-eed1-4930-8c70-8681e256c820@netscape.net/
> 
> Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
> ---
> The reported error with the Exynos mixer is not fixed by default by adding
> a second patch to select the new option in the Kconfig definition for the
> Exynos mixer if EXYNOS_IOMMU and SWIOTLB_XEN are enabled because it is
> not certain setting the config option is suitable for all cases. So it is
> necessary to explicitly select the new config option during the config
> stage of the Linux kernel build to fix the reported error or similar
> errors that have the same cause of lack of support for IOMMU on Xen. This
> is necessary to avoid any regressions that might be caused by enabling the
> new option by default for the Exynos mixer.
>   arch/arm/mm/dma-mapping.c |  6 ++++++
>   drivers/xen/Kconfig       | 16 ++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 5409225b4abc..ca04fdf01be3 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1779,6 +1779,12 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   	if (iommu)
>   		arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
>   
> +#ifdef CONFIG_ARM_DMA_USE_IOMMU_XEN

FWIW I don't think this really needs a config option - if Xen *has* made 
an IOMMU available, then there isn't really much reason not to use it, 
and if for some reason someone really didn't want to then they could 
simply disable the IOMMU driver anyway.

> +	if (dev->dma_ops == &iommu_ops) {
> +		dev->archdata.dma_ops_setup = true;

The existing assignment is effectively unconditional by this point 
anyway, so could probably just be moved earlier to save duplicating it 
(or perhaps just make the xen_setup_dma_ops() call conditional instead 
to save the early return as well).

However, are the IOMMU DMA ops really compatible with Xen? The comments 
about hypercalls and foreign memory in xen_arch_need_swiotlb() leave me 
concerned that assuming non-coherent DMA to any old Dom0 page is OK 
might not actually work in general :/

Thanks,
Robin.

> +		return;
> +	}
> +#endif
>   	xen_setup_dma_ops(dev);
>   	dev->archdata.dma_ops_setup = true;
>   }
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index d5989871dd5d..44e1334b6acd 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -181,6 +181,22 @@ config SWIOTLB_XEN
>   	select DMA_OPS
>   	select SWIOTLB
>   
> +config ARM_DMA_USE_IOMMU_XEN
> +	bool "Prefer IOMMU DMA ops on Xen"
> +	depends on SWIOTLB_XEN
> +	depends on ARM_DMA_USE_IOMMU
> +	help
> +	  Normally on Xen, the IOMMU is used by Xen and not exposed to
> +	  Linux. Some Arm systems such as Exynos have an IOMMU that
> +	  Xen does not use so the IOMMU is exposed to Linux in those
> +	  cases. This option enables Linux to use the IOMMU instead of
> +	  using the Xen swiotlb_dma_ops for DMA on Xen.
> +
> +	  Say N here unless support for one or more devices that use
> +	  IOMMU ops instead of Xen swiotlb ops for DMA is needed and the
> +	  devices that use the IOMMU do not cause any problems on the
> +	  Xen system in use.
> +
>   config XEN_PCI_STUB
>   	bool
>   
