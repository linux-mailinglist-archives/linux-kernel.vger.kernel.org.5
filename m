Return-Path: <linux-kernel+bounces-163093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0998B6560
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AE72833DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B002319069E;
	Mon, 29 Apr 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE1ScLev"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8017798F;
	Mon, 29 Apr 2024 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429014; cv=none; b=rCucBmI1BRERp1V7Yl0ZKORdv7/4LSCSEjXb7OtWvgsHLtrtsHF64h4BOtf5allvqdKGi9c3GPIohkZ4x1rKAP/xwPPkVM2cGT7iuLT3Ynz0QPtlo8hKmpTc+BDkjSCv+dgBAK81vhQVJzXJrqAzcqJCIv98GBqTmbGH/UHQVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429014; c=relaxed/simple;
	bh=sM12wNpxyClzIujECU2Q2Xq0Fp03wR6ElrAkPU8LTJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0EPSmQ5BpBtQg1zoVNxP6H1v6ZDa7yKS8SALHqOWc/IqySRPRKReQcUYWOP6knpfm9m9pRlaf25CoLHEjjnlAh1Z6qXbYRhkPQ1N+fi7OCKMm18pxkZJTW8oIjtpgdpxIL/ymneR/L92M1tOolKwMYyecX6gxj1zkuMWPI8/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE1ScLev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF9AC113CD;
	Mon, 29 Apr 2024 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714429013;
	bh=sM12wNpxyClzIujECU2Q2Xq0Fp03wR6ElrAkPU8LTJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AE1ScLevghQRxQ4qCrFsi9uVrMVHe0DLu4Fi/opB2QweZCJaOCcNoj2YYHHt9thz9
	 OcNY7C5Z3n0iQWyNGzwz56muSCRYaNXZ8oBvZSXpMnzO+MgjyRx2jIF2hB5Y/cmyTo
	 m/wpaUuexq+73sniwy1mApDi33fXdLHpVnz03b44dFGEr9mNhZTSv7PDS69z9ySIDh
	 jP3ikArks0EEvjdH8fM536Qivg8+lYUYPQXlFc8MlpW2w9VAKb+9rbjeSryEb4prFF
	 PxAA0zNei5LqRS91RkxXZJGXGOUVPG4obGjO1WWzq1ErlpDec91w5ye2wl5xuAn1PH
	 2PKJqWxdYTT4g==
Date: Mon, 29 Apr 2024 15:16:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <20240429221650.GA3666021@dev-arch.thelio-3990X>
References: <20240426222940.work.884-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426222940.work.884-kees@kernel.org>

On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> Add some stuff that got missed along the way:
> 
> - CONFIG_UNWIND_PATCH_PAC_INTO_SCS=y so SCS vs PAC is hardware
>   selectable.
> 
> - CONFIG_X86_KERNEL_IBT=y while a default, just be sure.
> 
> - CONFIG_CFI_CLANG=y for x86 and arm64. (And disable FINEIBT since
>   it isn't as secure as straight KCFI.)
> 
> - CONFIG_PAGE_TABLE_CHECK=y for userspace mapping sanity.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Seems reasonable to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One comment below.

> ---
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: llvm@lists.linux.dev
> ---
>  arch/arm64/configs/hardening.config | 5 +++++
>  arch/x86/configs/hardening.config   | 9 +++++++++
>  kernel/configs/hardening.config     | 4 ++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/configs/hardening.config b/arch/arm64/configs/hardening.config
> index b0e795208998..e8a18fec7a3e 100644
> --- a/arch/arm64/configs/hardening.config
> +++ b/arch/arm64/configs/hardening.config
> @@ -5,6 +5,7 @@ CONFIG_ARM64_SW_TTBR0_PAN=y
>  
>  # Software Shadow Stack or PAC
>  CONFIG_SHADOW_CALL_STACK=y
> +CONFIG_UNWIND_PATCH_PAC_INTO_SCS=y
>  
>  # Pointer authentication (ARMv8.3 and later). If hardware actually supports
>  # it, one can turn off CONFIG_STACKPROTECTOR_STRONG with this enabled.
> @@ -20,3 +21,7 @@ CONFIG_ARM64_E0PD=y
>  
>  # Available in ARMv8.7 and later.
>  CONFIG_ARM64_EPAN=y
> +
> +# Enable Kernel Control Flow Integrity (currently Clang only).
> +CONFIG_CFI_CLANG=y
> +# CONFIG_CFI_PERMISSIVE is not set

Should this be a part of kernel/configs/hardening.config because RISC-V
supports it (and 32-bit ARM will soon too)?

> diff --git a/arch/x86/configs/hardening.config b/arch/x86/configs/hardening.config
> index 7b497f3b7bc3..b47e5f411dd3 100644
> --- a/arch/x86/configs/hardening.config
> +++ b/arch/x86/configs/hardening.config
> @@ -10,5 +10,14 @@ CONFIG_INTEL_IOMMU_DEFAULT_ON=y
>  CONFIG_INTEL_IOMMU_SVM=y
>  CONFIG_AMD_IOMMU=y
>  
> +# Enforce CET Indirect Branch Tracking in the kernel.
> +CONFIG_X86_KERNEL_IBT=y
> +
> +# Enable Kernel Control Flow Integrity (currently Clang only), but disable
> +# weaker FINEIBT landing pads.
> +CONFIG_CFI_CLANG=y
> +# CONFIG_CFI_PERMISSIVE is not set
> +# CONFIG_FINEIBT is not set
> +
>  # Enable CET Shadow Stack for userspace.
>  CONFIG_X86_USER_SHADOW_STACK=y
> diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
> index 7a5bbfc024b7..4be0de1f085c 100644
> --- a/kernel/configs/hardening.config
> +++ b/kernel/configs/hardening.config
> @@ -23,6 +23,10 @@ CONFIG_SLAB_FREELIST_HARDENED=y
>  CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
>  CONFIG_RANDOM_KMALLOC_CACHES=y
>  
> +# Sanity check userspace page table mappings.
> +CONFIG_PAGE_TABLE_CHECK=y
> +CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
> +
>  # Randomize kernel stack offset on syscall entry.
>  CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
>  
> -- 
> 2.34.1
> 

