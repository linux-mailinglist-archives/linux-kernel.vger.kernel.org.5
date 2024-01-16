Return-Path: <linux-kernel+bounces-27124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0782EAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5402852A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51511125B2;
	Tue, 16 Jan 2024 08:23:56 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAA4125A4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8398F60002;
	Tue, 16 Jan 2024 08:23:47 +0000 (UTC)
Message-ID: <aea8222e-ec0a-4844-abd0-7fe102bc2bec@ghiti.fr>
Date: Tue, 16 Jan 2024 09:23:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: mm: still create swiotlb buffer for kmalloc()
 bouncing if required
Content-Language: en-US
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231202134224.4029-1-jszhang@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231202134224.4029-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Jisheng,

On 02/12/2023 14:42, Jisheng Zhang wrote:
> After commit f51f7a0fc2f4 ("riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC
> for !dma_coherent"), for non-coherent platforms with less than 4GB
> memory, we rely on users to pass "swiotlb=mmnn,force" kernel parameters
> to enable DMA bouncing for unaligned kmalloc() buffers. Now let's go
> further: If no bouncing needed for ZONE_DMA, let kernel automatically
> allocate 1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing on
> non-coherent platforms, so that no need to pass "swiotlb=mmnn,force"
> any more.

IIUC, DMA_BOUNCE_UNALIGNED_KMALLOC is enabled for all non-coherent 
platforms, even those with less than 4GB of memory. But the DMA bouncing 
(which is necessary to enable kmalloc-8/16/32/96...) was not enabled 
unless the user specified "swiotlb=mmnn,force" on the kernel command 
line. But does that mean that if the user did not specify 
"swiotlb=mmnn,force", the kmalloc-8/16/32/96 were enabled anyway and the 
behaviour was wrong (by lack of DMA bouncing)?

I'm trying to understand if that's a fix or an enhancement.

Thanks,

Alex


>
> The math of "1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing"
> is taken from arm64. Users can still force smaller swiotlb buffer by
> passing "swiotlb=mmnn".
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>
> since v2:
>   - fix build error if CONFIG_RISCV_DMA_NONCOHERENT=n
>
>   arch/riscv/include/asm/cache.h |  2 +-
>   arch/riscv/mm/init.c           | 16 +++++++++++++++-
>   2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> index 2174fe7bac9a..570e9d8acad1 100644
> --- a/arch/riscv/include/asm/cache.h
> +++ b/arch/riscv/include/asm/cache.h
> @@ -26,8 +26,8 @@
>   
>   #ifndef __ASSEMBLY__
>   
> -#ifdef CONFIG_RISCV_DMA_NONCOHERENT
>   extern int dma_cache_alignment;
> +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
>   #define dma_get_cache_alignment dma_get_cache_alignment
>   static inline int dma_get_cache_alignment(void)
>   {
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2e011cbddf3a..cbcb9918f721 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -162,11 +162,25 @@ static void print_vm_layout(void) { }
>   
>   void __init mem_init(void)
>   {
> +	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit);
>   #ifdef CONFIG_FLATMEM
>   	BUG_ON(!mem_map);
>   #endif /* CONFIG_FLATMEM */
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
>   	memblock_free_all();
>   
>   	print_vm_layout();

