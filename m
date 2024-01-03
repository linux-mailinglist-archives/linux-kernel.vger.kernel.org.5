Return-Path: <linux-kernel+bounces-15681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDCB823036
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89421C2361A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B01A727;
	Wed,  3 Jan 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp7oRgzy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114D1A718
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6BEC433C8;
	Wed,  3 Jan 2024 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704294640;
	bh=NkRRzJNtkIaqD3FKoHNbeRWvalOUr4JWu2/1EIqaoKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tp7oRgzysGa93W3YGZKULOpHNoDKsXBqBy7chiOvQRihBgJAypspwLbYkCRdMiPS1
	 CG2X/bi28oBBjMJHWtgVvI62dmPslcmBad0n8Pbi/SSbAjHtVk6TRZv935ARL7q6oM
	 vax735NBXLFbcWKHhd4LlzguyudA7vws5JovhRyOFYNwdRSI+aEoqs73RZApf6Em2s
	 jHX0dEp9SRH8GF/4vXA/HVrRoXsmyrEPU9v0IsyLLWD3CxgcflqJ8imWZunQyfM8KZ
	 LOLlWOcdGlDfjBpcKFsym0/Nzet30kg3hM8pkILeE01GnkyOGInXsc8j3HYsmqfKPs
	 EDq1ZBCvZqcKw==
Date: Wed, 3 Jan 2024 22:57:58 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 04/12] riscv: Only send remote fences when some other
 CPU is online
Message-ID: <ZZV19owFbjOzgG89@xhacker>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
 <20240102220134.3229156-5-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240102220134.3229156-5-samuel.holland@sifive.com>

On Tue, Jan 02, 2024 at 02:00:41PM -0800, Samuel Holland wrote:
> If no other CPU is online, a local cache or TLB flush is sufficient.
> These checks can be constant-folded when SMP is disabled.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v4:
>  - New patch for v4
> 
>  arch/riscv/mm/cacheflush.c | 4 +++-
>  arch/riscv/mm/tlbflush.c   | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 47c485bc7df0..f7933ae88a55 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -21,7 +21,9 @@ void flush_icache_all(void)
>  {
>  	local_flush_icache_all();
>  
> -	if (riscv_use_sbi_for_rfence())
> +	if (num_online_cpus() < 2)

with patch5, I think it's better to short cut for !SMP, I.E
if (!IS_ENABLED(CONFIG_SMP) || num_online_cpus()) < 2)

so that the UP case can avoid a atomic read and check

> +		return;
> +	else if (riscv_use_sbi_for_rfence())
>  		sbi_remote_fence_i(NULL);
>  	else
>  		on_each_cpu(ipi_remote_fence_i, NULL, 1);
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 2f18fe6fc4f3..37b3c93e3c30 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -73,7 +73,9 @@ static void __ipi_flush_tlb_all(void *info)
>  
>  void flush_tlb_all(void)
>  {
> -	if (riscv_use_sbi_for_rfence())
> +	if (num_online_cpus() < 2)

ditto

> +		local_flush_tlb_all();
> +	else if (riscv_use_sbi_for_rfence())
>  		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
>  	else
>  		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

