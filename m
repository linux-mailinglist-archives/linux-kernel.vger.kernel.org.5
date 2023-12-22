Return-Path: <linux-kernel+bounces-9202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEC81C243
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923F4B2490A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7955CA5D;
	Fri, 22 Dec 2023 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN9vSZi6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E17A20
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A546C433C7;
	Fri, 22 Dec 2023 00:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703204329;
	bh=wXnWlAEHEZOPJbC4UL27KU2l/K7KB/ypFaTwuZco7IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oN9vSZi6WR0+cEsbFQvdq7Z2Y7QGUF10OIB3uBS9W9EPCSoYATvOsY6UStGvWgJ/J
	 sCgUM0EYjUntGMxVJYoQpz+meCT/6I4GyMNsk50dfTBxlCqLu4SbcRfGxxKzMyo+2n
	 PKQZqfDG63bZ65D42UvA1kxBRGtdo4qqqXSPxoAbL+2RuwvvH86NoGGKjRMkI4JDYl
	 6nzuUL5nBNvG09P+zRe83H/Ts6GQtthN9PtobSPlAY1l0oZihWYiIM1bSHmEIvU/eE
	 LI/lx0fLcNAOxiiLnffd6Yvb7bB/Iezn9GJggZKd0vWkIX+YhaDNiAV9DMYs3fRtoD
	 SceByWM7DlL9w==
Date: Thu, 21 Dec 2023 19:18:42 -0500
From: Guo Ren <guoren@kernel.org>
To: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, alexghiti@rivosinc.com, charlie@rivosinc.com,
	xiao.w.wang@intel.com, david@redhat.com, panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com, willy@infradead.org
Cc: linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: mm: Fixup compat mode boot failure
Message-ID: <ZYTV4tGZr6ncIpAR@gmail.com>
References: <20231219111701.1886903-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219111701.1886903-1-guoren@kernel.org>

On Tue, Dec 19, 2023 at 06:17:01AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> In COMPAT mode, the STACK_TOP is 0x80000000, but the TASK_SIZE is
> 0x7fff000. When the user stack is upon 0x7fff000, it will cause a user
> segment fault. Sometimes, it would cause boot failure when the whole
> rootfs is rv32.
> 
> Freeing unused kernel image (initmem) memory: 2236K
> Run /sbin/init as init process
> Starting init: /sbin/init exists but couldn't execute it (error -14)
> Run /etc/init as init process
> ...
> 
> Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
Abandon this patch, and here is the v2:
https://lore.kernel.org/linux-riscv/20231221154702.2267684-1-guoren@kernel.org/


> ---
>  arch/riscv/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index ab00235b018f..d2ec5e6fa331 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
>  
>  #ifdef CONFIG_COMPAT
> -#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
> +#define TASK_SIZE_32	(UL(1) << (MMAP_VA_BITS - 1))
>  #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
>  			 TASK_SIZE_32 : TASK_SIZE_64)
>  #else
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

