Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46A768625
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjG3PJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjG3PJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6697CD;
        Sun, 30 Jul 2023 08:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D59360C8F;
        Sun, 30 Jul 2023 15:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1FCC433C8;
        Sun, 30 Jul 2023 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690729752;
        bh=i6Um7zwUZZ/IUCCNWHWQm1K0RmCrv6YoXL840drPBtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSXTirDFqcdHZajDAdeX7GgivtbJKzcJP5uxaNpQ+w/VjAWOfWX+i1vrV3DogWOzn
         jORLxUbv02r/Pi2n2b2KdXTclN1vOTq0uS7ww11tObMCillIzytcYht19AxNl5WQoP
         npfpLOgugUwd6BkZnX0FcQ0maRffqzwzWUGoqd1TMDnQmJscVlSdi7oddYcHv3vlas
         4VMzslRoC6CalNO9Vq6nvQDILfjgsEc3vaarMlQmfbz4DnOX39U/AKhddSWzQPJNll
         uBDPhE2cXZSOoO41gtoKr1i1q4W19zBOjiABB8QxLLh9lXbQCkbwp+4fjI7pmHJ0h/
         Nkqs0KM1XvyRg==
Date:   Sun, 30 Jul 2023 22:57:32 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
Message-ID: <ZMZ6XB6gX2kFd/Nt@xhacker>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 09:34:26PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Introduce support for nonstandard noncoherent systems in the RISC-V
> architecture. It enables function pointer support to handle cache
> management in such systems.
> 
> This patch adds a new configuration option called
> "RISCV_NONSTANDARD_CACHE_OPS." This option is a boolean flag that
> depends on "RISCV_DMA_NONCOHERENT" and enables the function pointer
> support for cache management in nonstandard noncoherent systems.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
> ---
> v9 -> v10
> * Added __ro_after_init compiler attribute for noncoherent_cache_ops
> * Renamed clean -> wback
> * Renamed inval -> inv
> * Renamed flush -> wback_inv
> 
> v8 -> v9
> * New patch
> ---
>  arch/riscv/Kconfig                       |  7 ++++
>  arch/riscv/include/asm/dma-noncoherent.h | 28 +++++++++++++++
>  arch/riscv/mm/dma-noncoherent.c          | 43 ++++++++++++++++++++++++
>  arch/riscv/mm/pmem.c                     | 13 +++++++
>  4 files changed, 91 insertions(+)
>  create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d9e451ac862a..42c86b13c5e1 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -265,6 +265,13 @@ config RISCV_DMA_NONCOHERENT
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select DMA_DIRECT_REMAP
>  
> +config RISCV_NONSTANDARD_CACHE_OPS
> +	bool
> +	depends on RISCV_DMA_NONCOHERENT
> +	help
> +	  This enables function pointer support for non-standard noncoherent
> +	  systems to handle cache management.

Per Documentation/riscv/patch-acceptance.rst:

"we'll only consider patches for extensions that either:

- Have been officially frozen or ratified by the RISC-V Foundation, or
- Have been implemented in hardware that is widely available, per standard
  Linux practice."

I'm not sure which item this patch series belongs to.

> +
>  config AS_HAS_INSN
>  	def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(comma) t0$(comma) zero)
>  
> diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
> new file mode 100644
> index 000000000000..969cf1f1363a
> --- /dev/null
> +++ b/arch/riscv/include/asm/dma-noncoherent.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +
> +#ifndef __ASM_DMA_NONCOHERENT_H
> +#define __ASM_DMA_NONCOHERENT_H
> +
> +#include <linux/dma-direct.h>
> +
> +/*
> + * struct riscv_cache_ops - Structure for CMO function pointers

can we reword this line as
"struct riscv_nonstd_cache_ops - Structure for non-standard CMO function
pointers" to explictly note this is only for non-standard CMO.

> + *
> + * @wback: Function pointer for cache writeback
> + * @inv: Function pointer for invalidating cache
> + * @wback_inv: Function pointer for flushing the cache (writeback + invalidating)
> + */
> +struct riscv_cache_ops {
> +	void (*wback)(phys_addr_t paddr, unsigned long size);
> +	void (*inv)(phys_addr_t paddr, unsigned long size);
> +	void (*wback_inv)(phys_addr_t paddr, unsigned long size);
> +};
> +
> +extern struct riscv_cache_ops noncoherent_cache_ops;
> +
> +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops *ops);
> +
> +#endif	/* __ASM_DMA_NONCOHERENT_H */
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index b9a9f57e02be..4c2e3f1cdfe6 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -9,13 +9,26 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/mm.h>
>  #include <asm/cacheflush.h>
> +#include <asm/dma-noncoherent.h>
>  
>  static bool noncoherent_supported;
>  
> +struct riscv_cache_ops noncoherent_cache_ops __ro_after_init = {
> +	.wback = NULL,
> +	.inv = NULL,
> +	.wback_inv = NULL,
> +};
> +
>  static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
>  {
>  	void *vaddr = phys_to_virt(paddr);
>  
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +	if (unlikely(noncoherent_cache_ops.wback)) {

I'm worried about the performance impact here.
For unified kernel Image reason, RISCV_NONSTANDARD_CACHE_OPS will be
enabled by default, so standard CMO and T-HEAD's CMO platform's
performance will be impacted, because even an unlikely is put
here, the check action still needs to be done.

> +		noncoherent_cache_ops.wback(paddr, size);
> +		return;
> +	}
> +#endif
>  	ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>  }
>  
> @@ -23,6 +36,13 @@ static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
>  {
>  	void *vaddr = phys_to_virt(paddr);
>  
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +	if (unlikely(noncoherent_cache_ops.inv)) {
> +		noncoherent_cache_ops.inv(paddr, size);
> +		return;
> +	}
> +#endif
> +
>  	ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
>  }
>  
> @@ -30,6 +50,13 @@ static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
>  {
>  	void *vaddr = phys_to_virt(paddr);
>  
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +	if (unlikely(noncoherent_cache_ops.wback_inv)) {
> +		noncoherent_cache_ops.wback_inv(paddr, size);
> +		return;
> +	}
> +#endif
> +
>  	ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
>  }
>  
> @@ -50,6 +77,13 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
>  	void *flush_addr = page_address(page);
>  
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +	if (unlikely(noncoherent_cache_ops.wback_inv)) {
> +		noncoherent_cache_ops.wback_inv(page_to_phys(page), size);
> +		return;
> +	}
> +#endif
> +
>  	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
>  }
>  
> @@ -75,3 +109,12 @@ void riscv_noncoherent_supported(void)
>  	     "Non-coherent DMA support enabled without a block size\n");
>  	noncoherent_supported = true;
>  }
> +
> +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops *ops)
> +{
> +	if (!ops)
> +		return;
> +
> +	noncoherent_cache_ops = *ops;
> +}
> +EXPORT_SYMBOL_GPL(riscv_noncoherent_register_cache_ops);
> diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
> index 089df92ae876..c5fc5ec96f6d 100644
> --- a/arch/riscv/mm/pmem.c
> +++ b/arch/riscv/mm/pmem.c
> @@ -7,15 +7,28 @@
>  #include <linux/libnvdimm.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/dma-noncoherent.h>
>  
>  void arch_wb_cache_pmem(void *addr, size_t size)
>  {
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +	if (unlikely(noncoherent_cache_ops.wback)) {
> +		noncoherent_cache_ops.wback(virt_to_phys(addr), size);
> +		return;
> +	}
> +#endif
>  	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
>  }
>  EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
>  
>  void arch_invalidate_pmem(void *addr, size_t size)
>  {
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +	if (unlikely(noncoherent_cache_ops.inv)) {
> +		noncoherent_cache_ops.inv(virt_to_phys(addr), size);
> +		return;
> +	}
> +#endif
>  	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
>  }
>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
