Return-Path: <linux-kernel+bounces-71745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B609785A9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5788B1F225D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F0444C94;
	Mon, 19 Feb 2024 17:20:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9014B446A5;
	Mon, 19 Feb 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363244; cv=none; b=mHl+ypzMjW774JCdny3OEEQ3ll2x7Taua61IIAdcgAeAgO5wX60Qxx8nB3OaxUdKkvvCCT06CgfKTv5oaOU7bSzKpuckweFnCbqLxEuL7yyhIx7cvZ7z0aQxj15Epc18Q4jO21JYVziDpzBZeFcFHMBtqNW8/h4DdAlGWcWkJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363244; c=relaxed/simple;
	bh=kIRjLThbu45iSePonaedwx3Sv6aDBvaezx/4y8Z422c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC5XP1MKWQmx/IWg/G/E/JQcHL1urGAJ8yUKyKJLEMkF8vuZT57f3PVqVGDQaYkyU8dP3SKpBA34MjGFifC7UENz88XdbuqghfdIwJ+Pg+LMK6ttDec0S17GXGkaBv0fmdNiNq40S/b07Nnkhi4ao0W3eqrbIJ+wS0wBqAgR2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1E41FEC;
	Mon, 19 Feb 2024 09:21:21 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 061863F762;
	Mon, 19 Feb 2024 09:20:40 -0800 (PST)
Date: Mon, 19 Feb 2024 17:20:38 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: Use -fmin-function-alignment when available
Message-ID: <ZdON5rbsYFsoulxm@FVFF77S0Q05N>
References: <20240215151642.8970-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215151642.8970-1-petr.pavlu@suse.com>

On Thu, Feb 15, 2024 at 04:16:42PM +0100, Petr Pavlu wrote:
> GCC recently added option -fmin-function-alignment, which should appear
> in GCC 14. Unlike -falign-functions, this option causes all functions to
> be aligned at the specified value, including the cold ones.
> 
> Detect availability of -fmin-function-alignment and use it instead of
> -falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
> and make the workarounds for the broken function alignment conditional
> on this setting.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

I don't have a GCC 14 build to play with, but this looks sound to me.

Petr, are you able to test an arm64 kernel with this and DYNAMIC_FTRACE
enabled? i.e. build that, and check that function symbols are all aligned to 8
bytes using objdump or similar? That way we could be pretty sure there's no
other latent issue in this area.

FWIW, given the structure looks sound:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> 
> Changes since v1 [1]:
> - Check the availability of -fmin-function-alignment only in one place.
> 
> [1] https://lore.kernel.org/linux-kbuild/20240212145355.1050-1-petr.pavlu@suse.com/
> 
>  Makefile                       |  7 +++++++
>  arch/Kconfig                   | 12 ++++++++++++
>  include/linux/compiler_types.h | 10 +++++-----
>  kernel/exit.c                  |  5 ++++-
>  4 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7e0b2ad98905..6f20ab5e2e44 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -974,8 +974,15 @@ export CC_FLAGS_CFI
>  endif
>  
>  ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
> +# Set the minimal function alignment. Use the newer GCC option
> +# -fmin-function-alignment if it is available, or fall back to -falign-funtions.
> +# See also CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT.
> +ifdef CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT
> +KBUILD_CFLAGS += -fmin-function-alignment=$(CONFIG_FUNCTION_ALIGNMENT)
> +else
>  KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
>  endif
> +endif
>  
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc
> diff --git a/arch/Kconfig b/arch/Kconfig
> index a5af0edd3eb8..bd6c6335efac 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1507,4 +1507,16 @@ config FUNCTION_ALIGNMENT
>  	default 4 if FUNCTION_ALIGNMENT_4B
>  	default 0
>  
> +config CC_HAS_MIN_FUNCTION_ALIGNMENT
> +	# Detect availability of the GCC option -fmin-function-alignment which
> +	# guarantees minimal alignment for all functions, unlike
> +	# -falign-functions which the compiler ignores for cold functions.
> +	def_bool $(cc-option, -fmin-function-alignment=8)
> +
> +config CC_HAS_SANE_FUNCTION_ALIGNMENT
> +	# Set if the guaranteed alignment with -fmin-function-alignment is
> +	# available or extra care is required in the kernel. Clang provides
> +	# strict alignment always, even with -falign-functions.
> +	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
> +
>  endmenu
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 663d8791c871..f0152165e83c 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -99,17 +99,17 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-cold-label-attribute
>   *
>   * When -falign-functions=N is in use, we must avoid the cold attribute as
> - * contemporary versions of GCC drop the alignment for cold functions. Worse,
> - * GCC can implicitly mark callees of cold functions as cold themselves, so
> - * it's not sufficient to add __function_aligned here as that will not ensure
> - * that callees are correctly aligned.
> + * GCC drops the alignment for cold functions. Worse, GCC can implicitly mark
> + * callees of cold functions as cold themselves, so it's not sufficient to add
> + * __function_aligned here as that will not ensure that callees are correctly
> + * aligned.
>   *
>   * See:
>   *
>   *   https://lore.kernel.org/lkml/Y77%2FqVgvaJidFpYt@FVFF77S0Q05N
>   *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c9
>   */
> -#if !defined(CONFIG_CC_IS_GCC) || (CONFIG_FUNCTION_ALIGNMENT == 0)
> +#if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || (CONFIG_FUNCTION_ALIGNMENT == 0)
>  #define __cold				__attribute__((__cold__))
>  #else
>  #define __cold
> diff --git a/kernel/exit.c b/kernel/exit.c
> index dfb963d2f862..5a6fed4ad3df 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1920,7 +1920,10 @@ EXPORT_SYMBOL(thread_group_exited);
>   *
>   * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c11
>   */
> -__weak __function_aligned void abort(void)
> +#ifndef CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> +__function_aligned
> +#endif
> +__weak void abort(void)
>  {
>  	BUG();
>  
> 
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> -- 
> 2.35.3
> 

