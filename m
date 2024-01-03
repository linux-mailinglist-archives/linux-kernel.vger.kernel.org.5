Return-Path: <linux-kernel+bounces-15686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0A9823047
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620121C2369D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA11B268;
	Wed,  3 Jan 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k39ifGsG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEDE1A720
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D84CC433C7;
	Wed,  3 Jan 2024 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704294907;
	bh=RERYlAnfEwJ6yjyyBYDUmO53kwh/sm8G92j6F6VTE+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k39ifGsG7hJqiX4VzXtNDzU7d+dMKFHWaYdlznt63uRqTUTArCSPYJgIJTe4jf+1k
	 QXsNVce+ofWLwhWwmA9EpGDuic1hESXQ2qE3jofzADEBI0+7ccSXrs/OgUYDsJEHzF
	 CQ248BfTX1PdCAk2RVXOceYWe5bMZGrlfgYxWavqSag05+l00AQezKDRFmNtj9F0/n
	 l5ci2ji3jHxOeg7sf4lderXtbRVibH3pwj/ob6ngG9BC5HnuVAG3dqI1LOyM4eRGAo
	 QaY+dxeNWj7mvuQMEtFV/UUVdSg94S47qm/w22cjcGme+BAFBuHJI7YFVp9R8nZrYC
	 LC+/S7oNw0GBg==
Date: Wed, 3 Jan 2024 23:02:24 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 12/12] riscv: mm: Always use an ASID to flush mm
 contexts
Message-ID: <ZZV3AAY3WIAq+sl9@xhacker>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
 <20240102220134.3229156-13-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240102220134.3229156-13-samuel.holland@sifive.com>

On Tue, Jan 02, 2024 at 02:00:49PM -0800, Samuel Holland wrote:
> Even if multiple ASIDs are not supported, using the single-ASID variant
> of the sfence.vma instruction preserves TLB entries for global (kernel)
> pages. So it is always more efficient to use the single-ASID code path.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v4:
>  - There is now only one copy of __flush_tlb_range()
> 
> Changes in v2:
>  - Update both copies of __flush_tlb_range()
> 
>  arch/riscv/include/asm/mmu_context.h | 2 --
>  arch/riscv/mm/context.c              | 3 +--
>  arch/riscv/mm/tlbflush.c             | 3 +--
>  3 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 7030837adc1a..b0659413a080 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -33,8 +33,6 @@ static inline int init_new_context(struct task_struct *tsk,
>  	return 0;
>  }
>  
> -DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
> -
>  #include <asm-generic/mmu_context.h>
>  
>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 3ca9b653df7d..20057085ab8a 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -18,8 +18,7 @@
>  
>  #ifdef CONFIG_MMU
>  
> -DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> -
> +static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);

One of my optimization "riscv: tlb: avoid tlb flushing if fullmm == 1"
will make use of use_asid_allocator, so could we remove this modification?

>  static unsigned long num_asids;
>  
>  static atomic_long_t current_version;
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 5ec621545c69..39d80f56d292 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -84,8 +84,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>  		if (cpumask_empty(cmask))
>  			return;
>  
> -		if (static_branch_unlikely(&use_asid_allocator))
> -			asid = cntx2asid(atomic_long_read(&mm->context.id));
> +		asid = cntx2asid(atomic_long_read(&mm->context.id));
>  	} else {
>  		cmask = cpu_online_mask;
>  	}
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

