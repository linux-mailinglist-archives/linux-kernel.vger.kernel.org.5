Return-Path: <linux-kernel+bounces-25822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5E182D659
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB53A1F21EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D082E563;
	Mon, 15 Jan 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgPQwTTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090EDF4C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA35C433C7;
	Mon, 15 Jan 2024 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705312321;
	bh=tq1LvtkAdS6HI+mHnlrvFlhiN8d0NA5zwM1YvZL8ZFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgPQwTTe4RTIKeCVwYiJ3gZtH8k9IwZRLxoNXGyudIrDIPo/LLsrsqso1hKgHCCPq
	 3ycEzmBPIvjcFlId4OAnU/8rcFHZ8S5la9ja47trpHFwGG/xEECGvolMGVTokBMSf5
	 gauD6KYIiLtyPZhyLHM5P5l7Hi4VbI7/S7KgBk0DlqoUta773ywklm58ApKD0fuuYa
	 lj40KwuWtvA/NU3fSrmGMT2M3bXGuvhIRwJ0bQ7Il9eji6KbPt5vffEy0gRvnDU5mj
	 3jEjwqHl4/JuraOkUNVKyGJujHdmySkyx62VhL+oxI1huP7sIGyu/NRCbwpHCIndrY
	 SEWKxai0V+XHA==
Date: Mon, 15 Jan 2024 17:39:10 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: mm: still create swiotlb buffer for kmalloc()
 bouncing if required
Message-ID: <ZaT9Pi06h70LWVA+@xhacker>
References: <20231202134224.4029-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231202134224.4029-1-jszhang@kernel.org>

On Sat, Dec 02, 2023 at 09:42:24PM +0800, Jisheng Zhang wrote:
> After commit f51f7a0fc2f4 ("riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC
> for !dma_coherent"), for non-coherent platforms with less than 4GB
> memory, we rely on users to pass "swiotlb=mmnn,force" kernel parameters
> to enable DMA bouncing for unaligned kmalloc() buffers. Now let's go
> further: If no bouncing needed for ZONE_DMA, let kernel automatically
> allocate 1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing on
> non-coherent platforms, so that no need to pass "swiotlb=mmnn,force"
> any more.
> 
> The math of "1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing"
> is taken from arm64. Users can still force smaller swiotlb buffer by
> passing "swiotlb=mmnn".

and this one is missed either. let me know if there's something need to
be done for merging.

Thanks in advance,

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
> since v2:
>  - fix build error if CONFIG_RISCV_DMA_NONCOHERENT=n
> 
>  arch/riscv/include/asm/cache.h |  2 +-
>  arch/riscv/mm/init.c           | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> index 2174fe7bac9a..570e9d8acad1 100644
> --- a/arch/riscv/include/asm/cache.h
> +++ b/arch/riscv/include/asm/cache.h
> @@ -26,8 +26,8 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#ifdef CONFIG_RISCV_DMA_NONCOHERENT
>  extern int dma_cache_alignment;
> +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
>  #define dma_get_cache_alignment dma_get_cache_alignment
>  static inline int dma_get_cache_alignment(void)
>  {
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2e011cbddf3a..cbcb9918f721 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -162,11 +162,25 @@ static void print_vm_layout(void) { }
>  
>  void __init mem_init(void)
>  {
> +	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit);
>  #ifdef CONFIG_FLATMEM
>  	BUG_ON(!mem_map);
>  #endif /* CONFIG_FLATMEM */
>  
> -	swiotlb_init(max_pfn > PFN_DOWN(dma32_phys_limit), SWIOTLB_VERBOSE);
> +	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
> +	    dma_cache_alignment != 1) {
> +		/*
> +		 * If no bouncing needed for ZONE_DMA, allocate 1MB swiotlb
> +		 * buffer per 1GB of RAM for kmalloc() bouncing on
> +		 * non-coherent platforms.
> +		 */
> +		unsigned long size =
> +			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
> +		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
> +		swiotlb = true;
> +	}
> +
> +	swiotlb_init(swiotlb, SWIOTLB_VERBOSE);
>  	memblock_free_all();
>  
>  	print_vm_layout();
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

