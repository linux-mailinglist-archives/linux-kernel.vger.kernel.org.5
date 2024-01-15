Return-Path: <linux-kernel+bounces-25812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E4782D634
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801EE1C215D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB21F4F8;
	Mon, 15 Jan 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRE/BSnY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A099F4E7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5820FC433C7;
	Mon, 15 Jan 2024 09:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705311651;
	bh=+F7K07Y5fx0dIdwadJy3MnmnbVE+eGFHi4fQFk5p/hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRE/BSnY7551SxKY3LorlQ3CfD5bzcEiVuBHEQkOhH1W0kKzpggvZZHxYdTWOHz5N
	 2Egz++9BrZVhXk2fgU+TD8v194sEvcx/z1WKinPt8ERZ16jAFXV4SFTSmNV8XVLYgT
	 COpOPNP7O83+ofyZ4WOzcR/GsyfiTSGmeHXnFo4vLl5c/S+O4VCaq15ennUve1Y7WO
	 8/B25fs4qFB1KfMCd9kbm4eMCJ3L5gKT9RpWNuX9SuWevSRm/+o2BcwV/LQzHD3wY6
	 B8f+HYpfMOvWp+/qfazl8ywHuYtC1cua3EqhAr+M6WRtsrSTpVKOM07krn70BPIYug
	 Qqvmrl23RT55Q==
Date: Mon, 15 Jan 2024 17:27:59 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Waterman <andrew@sifive.com>
Subject: Re: [PATCH] RISC-V: only flush icache when it has VM_EXEC set
Message-ID: <ZaT6n+2lqTg0UFk5@xhacker>
References: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com>

On Wed, Jan 10, 2024 at 02:48:59AM +0800, Yangyu Chen wrote:
> As I-Cache flush on current RISC-V needs to send IPIs to every CPU cores
> in the system is very costly, limiting flush_icache_mm to be called only
> when vma->vm_flags has VM_EXEC can help minimize the frequency of these
> operations. It improves performance and reduces disturbances when
> copy_from_user_page is needed such as profiling with perf.

Hi Yangyu,

Since this is for "performance", can you please add the benchmark, test
platform and performance numbers in your commit msg?

thanks

> 
> For I-D coherence concerns, it will not fail if such a page adds VM_EXEC
> flags in the future since we have checked it in the __set_pte_at function.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/include/asm/cacheflush.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 3cb53c4df27c..915f532dc336 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -33,8 +33,11 @@ static inline void flush_dcache_page(struct page *page)
>   * so instead we just flush the whole thing.
>   */
>  #define flush_icache_range(start, end) flush_icache_all()
> -#define flush_icache_user_page(vma, pg, addr, len) \
> -	flush_icache_mm(vma->vm_mm, 0)
> +#define flush_icache_user_page(vma, pg, addr, len)	\
> +do {							\
> +	if (vma->vm_flags & VM_EXEC)			\
> +		flush_icache_mm(vma->vm_mm, 0);		\
> +} while (0)
>  
>  #ifdef CONFIG_64BIT
>  #define flush_cache_vmap(start, end)	flush_tlb_kernel_range(start, end)
> -- 
> 2.43.0
> 

