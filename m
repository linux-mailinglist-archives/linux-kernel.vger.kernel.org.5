Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01D4752A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGMRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGMRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:53:14 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3968271F;
        Thu, 13 Jul 2023 10:53:12 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 5EE5814DBB9;
        Thu, 13 Jul 2023 19:53:09 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1689270789; bh=bPL0dJQsO71F+7x2c6oBcd15kYFwAiWbA6uxbyrkpGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EkihYalIeEcrIel7VgAhcpVNo9/pboyyZekjWK0jOnc5F1ahW2sgtlX2s4G3xz2aa
         7/pVJP13bkUSQtOnx/qTC561TvfhmkpEWgCjkNF0dnKtNeOHHWOPNueuVhTFgK2ELk
         wUOXEGu3hH49hYFoW2UWlnrBscc4Wib4CIVTdHzIxE5HMHeeuN7aydOSwzOTqbpdDv
         gD5Bsyr0BRxuvTKvkDlRDW5xFxEeTF4ZsC7VFVRP05INsvS0TzW3gxx20lzeEnkYdG
         ce/RvNC6zV5zfoC3oip2w9zTQ1heZ9+LR1nTdovemvPME96D6qgBeJM/SIEWJ77vyR
         +exPMHF3hrfBg==
Date:   Thu, 13 Jul 2023 19:53:07 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR ARM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        iommu@lists.linux.dev (open list:XEN SWIOTLB SUBSYSTEM),
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 3/8] swiotlb: separate memory pool data from other
 allocator data
Message-ID: <20230713195307.08d68b01@meshulam.tesarici.cz>
In-Reply-To: <e309b4a88ffb306c88a3b3cfe5e57483d73d20bc.1689261692.git.petr.tesarik.ext@huawei.com>
References: <cover.1689261692.git.petr.tesarik.ext@huawei.com>
        <e309b4a88ffb306c88a3b3cfe5e57483d73d20bc.1689261692.git.petr.tesarik.ext@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 17:23:14 +0200
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> Carve out memory pool specific fields from struct io_tlb_mem. The original
> struct now contains shared data for the whole allocator, while the new
> struct io_tlb_pool contains data that is specific to one memory pool of
> (potentially) many.
> 
> Allocate both structures together for restricted DMA pools to keep the
> error cleanup path simple.
> 
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> ---
>  include/linux/device.h  |   2 +-
>  include/linux/swiotlb.h |  47 +++++++----
>  kernel/dma/swiotlb.c    | 181 +++++++++++++++++++++++++---------------
>  3 files changed, 147 insertions(+), 83 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index bbaeabd04b0d..d9754a68ba95 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -625,7 +625,7 @@ struct device_physical_location {
>   * @dma_pools:	Dma pools (if dma'ble device).
>   * @dma_mem:	Internal for coherent mem override.
>   * @cma_area:	Contiguous memory area for dma allocations
> - * @dma_io_tlb_mem: Pointer to the swiotlb pool used.  Not for driver use.
> + * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
>   * @archdata:	For arch-specific additions.
>   * @of_node:	Associated device tree node.
>   * @fwnode:	Associated device node supplied by platform firmware.
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 39313c3a791a..d669e11e2827 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -62,8 +62,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
>  #ifdef CONFIG_SWIOTLB
>  
>  /**
> - * struct io_tlb_mem - IO TLB Memory Pool Descriptor
> - *
> + * struct io_tlb_pool - IO TLB memory pool descriptor
>   * @start:	The start address of the swiotlb memory pool. Used to do a quick
>   *		range check to see if the memory was in fact allocated by this
>   *		API.
> @@ -73,15 +72,36 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
>   * @vaddr:	The vaddr of the swiotlb memory pool. The swiotlb memory pool
>   *		may be remapped in the memory encrypted case and store virtual
>   *		address for bounce buffer operation.
> - * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
> - *		@end. For default swiotlb, this is command line adjustable via
> - *		setup_io_tlb_npages.
> + * @nslabs:	The number of IO TLB slots between @start and @end. For the
> + *		default swiotlb, this can be adjusted with a boot parameter,
> + *		see setup_io_tlb_npages().
> + * @used:	The number of used IO TLB slots.
> + * @late_alloc:	%true if allocated using the page allocator.
> + * @nareas:	Number of areas in the pool.
> + * @area_nslabs: Number of slots in each area.
> + * @areas:	Array of memory area descriptors.
> + * @slots:	Array of slot descriptors.
> + */
> +struct io_tlb_pool {
> +	phys_addr_t start;
> +	phys_addr_t end;
> +	void *vaddr;
> +	unsigned long nslabs;
> +	unsigned long used;

Oops. This member should not be re-introduced here after I removed it
with commit efa76afdde16...

I'm going to fix this in a v5, but I don't think it's critical enough
to make an immediate resend.

Petr T
