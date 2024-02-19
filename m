Return-Path: <linux-kernel+bounces-71147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA5585A14F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53D31F226BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA028DCA;
	Mon, 19 Feb 2024 10:48:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182E528DC6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339717; cv=none; b=XeD+NWncq0MdGQQk+h59FReI5+y/cCAy53HThuuxnLXQUMO2S9pkHTvTT4qGJdyzG49XBMWVqBPq7OoBGfkAFjS6PhzLsIAZgnEAyoUnnwaWBieh2TXG5KtFIKvkm5s4CBafYnKCVXpEbL57rjcK7vftuskt9ybBlIO+rEulw/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339717; c=relaxed/simple;
	bh=C1GsjsFw5uaZhBTJ8BwnJ+MEAALKzYl16o3lM+wB1o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfCT5Wid6ZSy+WWXDY/QXNM+MUbOmuKBn+nRKsbbCuvTwTOZwI2gZtUOSsezW3TpTWkAVeGIgHLBpcrlpe+fSeCMCvkF8iisbEsTjqW2ycvc0JtjEwyQ/nrXO9L33KRkdi74sB/DipCEHHeJPoPwufr+ac47kdliZBUHJYq9KRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 475EFFEC;
	Mon, 19 Feb 2024 02:49:14 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DBDA3F762;
	Mon, 19 Feb 2024 02:48:33 -0800 (PST)
Date: Mon, 19 Feb 2024 10:48:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: skseofh@gmail.com
Cc: catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add early fixmap initialization flag
Message-ID: <ZdMx-svsHgrfguxX@FVFF77S0Q05N>
References: <20240217140326.2367186-1-skseofh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217140326.2367186-1-skseofh@gmail.com>

On Sat, Feb 17, 2024 at 11:03:26PM +0900, skseofh@gmail.com wrote:
> From: Daero Lee <skseofh@gmail.com>
> 
> early_fixmap_init may be called multiple times. Since there is no
> change in the page table after early fixmap initialization, an
> initialization flag was added.

Why is that better?

We call early_fixmap_init() in two places:

* early_fdt_map()
* setup_arch()

.. and to get to setup_arch() we *must* have gone through early_fdt_map(),
since __primary_switched() calls that before going to setup_arch().

So AFAICT we can remove the second call to early_fixmap_init() in setup_arch(),
and rely on the earlier one in early_fdt_map().

Mark.

> 
> Signed-off-by: Daero Lee <skseofh@gmail.com>
> ---
>  arch/arm64/mm/fixmap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index c0a3301203bd..fbdd5f30f3a1 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -32,6 +32,8 @@ static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
>  static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>  
> +static int early_fixmap_initialized __initdata;
> +
>  static inline pte_t *fixmap_pte(unsigned long addr)
>  {
>  	return &bm_pte[BM_PTE_TABLE_IDX(addr)][pte_index(addr)];
> @@ -100,10 +102,15 @@ void __init early_fixmap_init(void)
>  	unsigned long addr = FIXADDR_TOT_START;
>  	unsigned long end = FIXADDR_TOP;
>  
> +	if (early_fixmap_initialized)
> +		return;
> +
>  	pgd_t *pgdp = pgd_offset_k(addr);
>  	p4d_t *p4dp = p4d_offset(pgdp, addr);
>  
>  	early_fixmap_init_pud(p4dp, addr, end);
> +
> +	early_fixmap_initialized = 1;
>  }
>  
>  /*
> -- 
> 2.25.1
> 

