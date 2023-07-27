Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5E7642E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjG0AWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjG0AWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29D819B5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690417308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DNn/LZUJS32/scZrimiNriOR4WinuQhjPdO24euRKzc=;
        b=goI9bAqmX2lCTnbe0rd3ZxCoZQNIV9mdS8/tG/YgAqYNVjt8VXYGOASF0T/t9mQiqfJGiT
        +SNizM2ZQRViY7vT5XdroWeLpPCQWd0qdO0F6l37oayaz9YsqxW+O4BiQCFgN2tstzSdL8
        FSYVnv990L96gB3dh2aQl4ajfHLTaPg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-HxyUzRBvPUiWkLLsENQVeQ-1; Wed, 26 Jul 2023 20:21:44 -0400
X-MC-Unique: HxyUzRBvPUiWkLLsENQVeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15B491011596;
        Thu, 27 Jul 2023 00:21:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58F0D2166B25;
        Thu, 27 Jul 2023 00:21:42 +0000 (UTC)
Date:   Thu, 27 Jul 2023 08:21:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomem: remove __weak ioremap_cache helper
Message-ID: <ZMG4kw3k1cCGTL2L@MiWiFi-R3L-srv>
References: <20230726145432.1617809-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726145432.1617809-1-arnd@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 07/26/23 at 04:54pm, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> No portable code calls into this function any more, and on
> architectures that don't use or define their own, it causes
> a warning:
> 
> kernel/iomem.c:10:22: warning: no previous prototype for 'ioremap_cache' [-Wmissing-prototypes]
>    10 | __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
> 
> Fold it into the only caller that uses it on architectures
> without the #define.
> 
> Note that the fallback to ioremap is probably still wrong on
> those architectures, but this is what it's always done there.

Do we need to add a definition of ioremap_cache in asm-generic/io.h like
ioremap_wc|wt?

#ifndef ioremap_cache
#define ioremap_cahce ioremap
#endif

Unless it's for sure that drivers calling ioremap_cache are only built in
on those architecures defining it. Or we just want to see the breakage
on those ARCH-es so that they will add their own definition.

Not sure if I missed anything when understanding this.

drivers/acpi/apei/bert.c:       boot_error_region = ioremap_cache(bert_tab->address, region_len);
drivers/acpi/apei/einj.c:       trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
drivers/acpi/apei/einj.c:       trigger_tab = ioremap_cache(trigger_paddr, table_size);
drivers/acpi/apei/erst.c:       erst_erange.vaddr = ioremap_cache(erst_erange.base,
drivers/firmware/efi/memmap.c: * Setup a mapping of the EFI memory map using ioremap_cache(). This
drivers/firmware/meson/meson_sm.c:      return ioremap_cache(sm_phy_base, size);
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:                adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
drivers/gpu/drm/hyperv/hyperv_drm_drv.c:        hv->vram = ioremap_cache(hv->mem->start, hv->fb_size);
drivers/gpu/drm/ttm/ttm_bo_util.c:                      map->virtual = ioremap_cache(res, size);
drivers/gpu/drm/ttm/ttm_bo_util.c:                      vaddr_iomem = ioremap_cache(mem->bus.offset,
drivers/hv/hv.c:                /* Mask out vTOM bit. ioremap_cache() maps decrypted */
drivers/hv/hv.c:                        = (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
drivers/hv/hv.c:                /* Mask out vTOM bit. ioremap_cache() maps decrypted */
drivers/hv/hv.c:                        = (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
drivers/mtd/devices/bcm47xxsflash.c:            b47s->window = ioremap_cache(res->start, resource_size(res));
drivers/mtd/maps/pxa2xx-flash.c:        info->map.cached = ioremap_cache(info->map.phys, info->map.size);
drivers/soc/fsl/qbman/qman_ccsr.c:      void __iomem *tmpp = ioremap_cache(addr, sz);
drivers/video/fbdev/hyperv_fb.c:        fb_virt = ioremap_cache(par->mem->start, screen_fb_size);
include/acpi/acpi_io.h:       return ioremap_cache(phys, size);

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/iomem.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/iomem.c b/kernel/iomem.c
> index 9682471e64717..dc2120776e1c3 100644
> --- a/kernel/iomem.c
> +++ b/kernel/iomem.c
> @@ -5,18 +5,14 @@
>  #include <linux/mm.h>
>  #include <linux/ioremap.h>
>  
> -#ifndef ioremap_cache
> -/* temporary while we convert existing ioremap_cache users to memremap */
> -__weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
> -{
> -	return ioremap(offset, size);
> -}
> -#endif
> -
>  #ifndef arch_memremap_wb
>  static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
>  {
> +#ifdef ioremap_cache
>  	return (__force void *)ioremap_cache(offset, size);
> +#else
> +	return (__force void *)ioremap(offset, size);
> +#endif
>  }
>  #endif
>  
> -- 
> 2.39.2
> 

