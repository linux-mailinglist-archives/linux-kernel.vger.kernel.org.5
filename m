Return-Path: <linux-kernel+bounces-21755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FB8293D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546041C256D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D974A364C8;
	Wed, 10 Jan 2024 06:48:02 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD5364A9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D475E0003;
	Wed, 10 Jan 2024 06:47:48 +0000 (UTC)
Message-ID: <d6be9a6a-4eab-49bd-8e4e-774646994cd3@ghiti.fr>
Date: Wed, 10 Jan 2024 07:47:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: only flush icache when it has VM_EXEC set
Content-Language: en-US
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>, Jisheng Zhang
 <jszhang@kernel.org>, Andrew Waterman <andrew@sifive.com>
References: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Yangyu,

On 09/01/2024 19:48, Yangyu Chen wrote:
> As I-Cache flush on current RISC-V needs to send IPIs to every CPU cores
> in the system is very costly, limiting flush_icache_mm to be called only
> when vma->vm_flags has VM_EXEC can help minimize the frequency of these
> operations. It improves performance and reduces disturbances when


Which platform did you test this patchset? Do you have any measurement 
of the performance improvements?


> copy_from_user_page is needed such as profiling with perf.
>
> For I-D coherence concerns, it will not fail if such a page adds VM_EXEC
> flags in the future since we have checked it in the __set_pte_at function.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>   arch/riscv/include/asm/cacheflush.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 3cb53c4df27c..915f532dc336 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -33,8 +33,11 @@ static inline void flush_dcache_page(struct page *page)
>    * so instead we just flush the whole thing.
>    */
>   #define flush_icache_range(start, end) flush_icache_all()
> -#define flush_icache_user_page(vma, pg, addr, len) \
> -	flush_icache_mm(vma->vm_mm, 0)
> +#define flush_icache_user_page(vma, pg, addr, len)	\
> +do {							\
> +	if (vma->vm_flags & VM_EXEC)			\
> +		flush_icache_mm(vma->vm_mm, 0);		\
> +} while (0)
>   
>   #ifdef CONFIG_64BIT
>   #define flush_cache_vmap(start, end)	flush_tlb_kernel_range(start, end)


Otherwise, it looks good to me, so you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


