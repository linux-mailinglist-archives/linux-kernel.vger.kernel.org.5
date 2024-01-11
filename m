Return-Path: <linux-kernel+bounces-23668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDD782AFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2DE3B244F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F232C88;
	Thu, 11 Jan 2024 13:39:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731B32C6C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 948C02F4;
	Thu, 11 Jan 2024 05:39:47 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3DF23F73F;
	Thu, 11 Jan 2024 05:39:00 -0800 (PST)
Date: Thu, 11 Jan 2024 13:38:55 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: Rename ARM64_WORKAROUND_2966298
Message-ID: <ZZ_vb3DDfhia-TAY@FVFF77S0Q05N.cambridge.arm.com>
References: <20240110-arm-errata-a510-v1-0-d02bc51aeeee@kernel.org>
 <20240110-arm-errata-a510-v1-1-d02bc51aeeee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110-arm-errata-a510-v1-1-d02bc51aeeee@kernel.org>

On Wed, Jan 10, 2024 at 11:29:20AM -0600, Rob Herring wrote:
> In preparation to apply ARM64_WORKAROUND_2966298 for multiple errata,
> rename the kconfig and capability. No functional change.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

This looks good to me.

I applied this atop v6.7 and checked that with and without
CONFIG_ARM64_ERRATUM_2966298 selected the Kconfig bits looked right and the
kernel built cleanly and booted. I don't have a Cortex-A520 to test on, but I
cannot see any reason this would have a functional change.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/Kconfig             | 4 ++++
>  arch/arm64/kernel/cpu_errata.c | 4 ++--
>  arch/arm64/kernel/entry.S      | 2 +-
>  arch/arm64/tools/cpucaps       | 2 +-
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b071a00425d..ba9f6ceddbbe 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1037,8 +1037,12 @@ config ARM64_ERRATUM_2645198
>  
>  	  If unsure, say Y.
>  
> +config ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> +	bool
> +
>  config ARM64_ERRATUM_2966298
>  	bool "Cortex-A520: 2966298: workaround for speculatively executed unprivileged load"
> +	select ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
>  	default y
>  	help
>  	  This option adds the workaround for ARM Cortex-A520 erratum 2966298.
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index e29e0fea63fb..cb5e0622168d 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -713,10 +713,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		MIDR_FIXED(MIDR_CPU_VAR_REV(1,1), BIT(25)),
>  	},
>  #endif
> -#ifdef CONFIG_ARM64_ERRATUM_2966298
> +#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
>  	{
>  		.desc = "ARM erratum 2966298",
> -		.capability = ARM64_WORKAROUND_2966298,
> +		.capability = ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD,
>  		/* Cortex-A520 r0p0 - r0p1 */
>  		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
>  	},
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index a6030913cd58..544ab46649f3 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -428,7 +428,7 @@ alternative_else_nop_endif
>  	ldp	x28, x29, [sp, #16 * 14]
>  
>  	.if	\el == 0
> -alternative_if ARM64_WORKAROUND_2966298
> +alternative_if ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
>  	tlbi	vale1, xzr
>  	dsb	nsh
>  alternative_else_nop_endif
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index b98c38288a9d..3781ad1d0b26 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -84,7 +84,6 @@ WORKAROUND_2077057
>  WORKAROUND_2457168
>  WORKAROUND_2645198
>  WORKAROUND_2658417
> -WORKAROUND_2966298
>  WORKAROUND_AMPERE_AC03_CPU_38
>  WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>  WORKAROUND_TSB_FLUSH_FAILURE
> @@ -100,3 +99,4 @@ WORKAROUND_NVIDIA_CARMEL_CNP
>  WORKAROUND_QCOM_FALKOR_E1003
>  WORKAROUND_REPEAT_TLBI
>  WORKAROUND_SPECULATIVE_AT
> +WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> 
> -- 
> 2.43.0
> 
> 

