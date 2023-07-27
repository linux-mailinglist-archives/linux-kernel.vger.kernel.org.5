Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069E27650ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjG0KWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjG0KWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36EF1FF2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690453291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MJqIOj0aTLpKwiOIwjqrsLWHCLvCY9+iQH6WiTtMN+I=;
        b=P7+i3TvLBXT5zcMn5dYcKZwYRJxJfVLWJc0stuQjlXxu4jMreJkVG8Ft8Xn6i44qIB9PUH
        8afuyU8KqwyNkaYI5rd16rGV1CUb6OvZ7BqDoVzxWLv5BbK3Xqbr0w1XyDOdUmRdrJ26J/
        okL0rVgUa1BBtDdLcRmPAqswrVhm1fs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-9BByjHR_Oh65h4lTCxXxWQ-1; Thu, 27 Jul 2023 06:21:28 -0400
X-MC-Unique: 9BByjHR_Oh65h4lTCxXxWQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2987A800159;
        Thu, 27 Jul 2023 10:21:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BFF1492B02;
        Thu, 27 Jul 2023 10:21:27 +0000 (UTC)
Date:   Thu, 27 Jul 2023 18:21:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomem: remove __weak ioremap_cache helper
Message-ID: <ZMJFJIZrf5tRANLm@MiWiFi-R3L-srv>
References: <20230726145432.1617809-1-arnd@kernel.org>
 <ZMG4kw3k1cCGTL2L@MiWiFi-R3L-srv>
 <95ce8aa7-46fc-405c-acec-e94e8f93d186@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ce8aa7-46fc-405c-acec-e94e8f93d186@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/23 at 10:18am, Arnd Bergmann wrote:
> On Thu, Jul 27, 2023, at 02:21, Baoquan He wrote:
> > On 07/26/23 at 04:54pm, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> No portable code calls into this function any more, and on
> >> architectures that don't use or define their own, it causes
> >> a warning:
> >> 
> >> kernel/iomem.c:10:22: warning: no previous prototype for 'ioremap_cache' [-Wmissing-prototypes]
> >>    10 | __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
> >> 
> >> Fold it into the only caller that uses it on architectures
> >> without the #define.
> >> 
> >> Note that the fallback to ioremap is probably still wrong on
> >> those architectures, but this is what it's always done there.
> >
> > Do we need to add a definition of ioremap_cache in asm-generic/io.h like
> > ioremap_wc|wt?
> >
> > #ifndef ioremap_cache
> > #define ioremap_cahce ioremap
> > #endif
> 
> No, we really want to eliminate ioremap_cache() from the API,
> not make it more visible.

Got it now, thanks a lot for explanation.

> 
> > Unless it's for sure that drivers calling ioremap_cache are only built in
> > on those architecures defining it. Or we just want to see the breakage
> > on those ARCH-es so that they will add their own definition.
> 
> Right now, it's only possible to call ioremap_cache() on the couple
> of architectures that explicitly declare this in their asm/io.h header
> (arm, arm64, ia64, loongarch, mips, powerpc, sh, x86, and xtensa).
> 
> I think we could also go ahead and remove it from sh and xtensa.

Agree, if no actual need of ioremap_cache() on sh and xtensa.

> 
> > Not sure if I missed anything when understanding this.
> >
> > drivers/acpi/apei/bert.c:       boot_error_region = 
> > ioremap_cache(bert_tab->address, region_len);
> > drivers/acpi/apei/einj.c:       trigger_tab = 
> > ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
> > drivers/acpi/apei/einj.c:       trigger_tab = 
> > ioremap_cache(trigger_paddr, table_size);
> > drivers/acpi/apei/erst.c:       erst_erange.vaddr = 
> > ioremap_cache(erst_erange.base,
> > include/acpi/acpi_io.h:       return ioremap_cache(phys, size);
> 
> acpi is used on x86, arm64 ia64, and loongarch
> 
> > drivers/firmware/meson/meson_sm.c:      return 
> > ioremap_cache(sm_phy_base, size);
> 
> arm/arm64 specific
> 
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:                
> > adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
> > drivers/gpu/drm/hyperv/hyperv_drm_drv.c:        hv->vram = 
> > ioremap_cache(hv->mem->start, hv->fb_size);
> > drivers/gpu/drm/ttm/ttm_bo_util.c:                      map->virtual = 
> > ioremap_cache(res, size);
> > drivers/gpu/drm/ttm/ttm_bo_util.c:                      vaddr_iomem = 
> > ioremap_cache(mem->bus.offset,
> 
> All guardeded with an x86 check
> 
> > drivers/hv/hv.c:                /* Mask out vTOM bit. ioremap_cache() 
> > maps decrypted */
> > drivers/hv/hv.c:                        = (void *)ioremap_cache(base, 
> > HV_HYP_PAGE_SIZE);
> > drivers/hv/hv.c:                /* Mask out vTOM bit. ioremap_cache() 
> > maps decrypted */
> > drivers/hv/hv.c:                        = (void *)ioremap_cache(base, 
> > HV_HYP_PAGE_SIZE);
> > drivers/video/fbdev/hyperv_fb.c:        fb_virt = 
> > ioremap_cache(par->mem->start, screen_fb_size);
> 
> x86 and arm64 specific
> 
> > drivers/mtd/devices/bcm47xxsflash.c:            b47s->window = 
> > ioremap_cache(res->start, resource_size(res));
> > drivers/mtd/maps/pxa2xx-flash.c:        info->map.cached = 
> > ioremap_cache(info->map.phys, info->map.size);
> > drivers/soc/fsl/qbman/qman_ccsr.c:      void __iomem *tmpp = 
> > ioremap_cache(addr, sz);
> 
> arm/arm64 specific.
> 
> There is also one more caller in mips that gets used by dmi:
> 
> arch/mips/include/asm/dmi.h:#define dmi_early_remap(x, l)		ioremap_cache(x, l)
> arch/mips/include/asm/dmi.h:#define dmi_remap(x, l)			ioremap_cache(x, l)
> 
>       Arnd
> 

