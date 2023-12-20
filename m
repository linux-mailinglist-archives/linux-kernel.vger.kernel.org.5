Return-Path: <linux-kernel+bounces-7434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8476981A7E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FA71F23B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C18248780;
	Wed, 20 Dec 2023 21:15:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D61DFF8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79F0220004;
	Wed, 20 Dec 2023 21:15:00 +0000 (UTC)
Message-ID: <594df6bc-0207-46f6-aa81-dcf1f3665917@ghiti.fr>
Date: Wed, 20 Dec 2023 22:14:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: put va_kernel_xip_pa_offset into CONFIG_XIP_KERNEL
Content-Language: en-US
To: Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
 alexghiti@rivosinc.com, anup@brainfault.org, samitolvanen@google.com,
 rppt@kernel.org, panqinglin2020@iscas.ac.cn,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231220103428.61758-1-cuiyunhui@bytedance.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231220103428.61758-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Yunhui,

On 20/12/2023 11:34, Yunhui Cui wrote:
> opitmize the kernel_mapping_pa_to_va() and kernel_mapping_va_to_pa().
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   arch/riscv/include/asm/page.h | 33 ++++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 5488ecc337b6..0d2b479d02cd 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -113,8 +113,8 @@ struct kernel_mapping {
>   	unsigned long va_pa_offset;
>   	/* Offset between kernel mapping virtual address and kernel load address */
>   	unsigned long va_kernel_pa_offset;
> -	unsigned long va_kernel_xip_pa_offset;
>   #ifdef CONFIG_XIP_KERNEL
> +	unsigned long va_kernel_xip_pa_offset;
>   	uintptr_t xiprom;
>   	uintptr_t xiprom_sz;
>   #endif
> @@ -134,12 +134,25 @@ extern phys_addr_t phys_ram_base;
>   #else
>   void *linear_mapping_pa_to_va(unsigned long x);
>   #endif
> -#define kernel_mapping_pa_to_va(y)	({					\
> -	unsigned long _y = (unsigned long)(y);					\
> -	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
> -		(void *)(_y + kernel_map.va_kernel_xip_pa_offset) :		\
> -		(void *)(_y + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
> -	})
> +
> +#ifdef CONFIG_XIP_KERNEL
> +#define kernel_mapping_pa_to_va(y)							\
> +	(((unsigned long)(y) < phys_ram_base) ?						\
> +		(void *)((unsigned long)(y) + kernel_map.va_kernel_xip_pa_offset) :	\
> +		(void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset + XIP_OFFSET))
> +
> +#define kernel_mapping_va_to_pa(y)						\
> +	(((unsigned long)(y) < kernel_map.virt_addr + XIP_OFFSET) ?		\
> +		((unsigned long)(y) - kernel_map.va_kernel_xip_pa_offset) :	\
> +		((unsigned long)(y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET))
> +#else
> +#define kernel_mapping_pa_to_va(y)						\
> +	((void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset + XIP_OFFSET))
> +
> +#define kernel_mapping_va_to_pa(y)						\
> +	((unsigned long)(y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET)
> +#endif
> +
>   #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
>   
>   #ifndef CONFIG_DEBUG_VIRTUAL
> @@ -147,12 +160,6 @@ void *linear_mapping_pa_to_va(unsigned long x);
>   #else
>   phys_addr_t linear_mapping_va_to_pa(unsigned long x);
>   #endif
> -#define kernel_mapping_va_to_pa(y) ({						\
> -	unsigned long _y = (unsigned long)(y);					\
> -	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
> -		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
> -		(_y - kernel_map.va_kernel_pa_offset - XIP_OFFSET);		\
> -	})
>   
>   #define __va_to_pa_nodebug(x)	({						\
>   	unsigned long _x = x;							\


Not sure using #ifdef optimizes anything since the compiler should do 
the same with the IS_ENABLED(CONFIG_XIP_KERNEL) and it does not really 
improve the readability of this file which is already overloaded with 
#ifdef, so I don't think this change is needed.

Thanks,

Alex


