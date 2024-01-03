Return-Path: <linux-kernel+bounces-15684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4CA823041
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9BD285B15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6771B291;
	Wed,  3 Jan 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3TJTsC8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBF1B286
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C9DC433C8;
	Wed,  3 Jan 2024 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704294783;
	bh=QX+nMwXVzn0gGxlE1K2IkvWpvmG5/KS1sk6RCZ0yiIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3TJTsC8iSmtmbvbPqzz3uRI6cNoJFiZq0ejCKH357+uluHEWBWnFIvZH/LsmU50J
	 5CTshTIDIkC36IeAp5RKK+zyw42DrsEU1LXXy90j1nn1mR4R3ObVyCeaLieOIgcABt
	 /d5hFyGgkDUyn+KUh2LFSO1DBEjj89Plug9yiEM5dDvV11IdUoiONSPDrFroAVW8XG
	 zfFvVfhQyorewe+y17GRIh2aowzfRCxdh4pi7R+MLhn9Vsr9G37uXCQxoKw2ENAQeb
	 zO2UoMrT5gdhC+9fw+SN2ufKi2iVG33g2EZ2h5l9eU90wHyvZRSn1qBiS5IU9QKlbJ
	 ebY6TXHOBtAuw==
Date: Wed, 3 Jan 2024 23:00:20 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 10/12] riscv: mm: Make asid_bits a local variable
Message-ID: <ZZV2hKLKtqjhEdvY@xhacker>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
 <20240102220134.3229156-11-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240102220134.3229156-11-samuel.holland@sifive.com>

On Tue, Jan 02, 2024 at 02:00:47PM -0800, Samuel Holland wrote:
> This variable is only used inside asids_init().

This is due to patch9, so can be folded into patch9.

> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> (no changes since v1)
> 
>  arch/riscv/mm/context.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index b5170ac1b742..43a8bc2d5af4 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -20,7 +20,6 @@
>  
>  DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>  
> -static unsigned long asid_bits;
>  static unsigned long num_asids;
>  
>  static atomic_long_t current_version;
> @@ -226,7 +225,7 @@ static inline void set_mm(struct mm_struct *prev,
>  
>  static int __init asids_init(void)
>  {
> -	unsigned long old;
> +	unsigned long asid_bits, old;
>  
>  	/* Figure-out number of ASID bits in HW */
>  	old = csr_read(CSR_SATP);
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

