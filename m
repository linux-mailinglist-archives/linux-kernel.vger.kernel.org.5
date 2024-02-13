Return-Path: <linux-kernel+bounces-62760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8C852558
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B921C240F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7F2BB1D;
	Tue, 13 Feb 2024 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5yttsII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973092C68A;
	Tue, 13 Feb 2024 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784068; cv=none; b=W7gpCJOcx1i8IxejSyd9zppSlZsQJIznaQk01DldJvn7gdlPRiWD8U9E+avb+0PFf293Sf2a8iRgJkm1UXLJjg951p1dYUjmo4eVdVDU+NliPHr2f6IEnZhXa4tXSr8Q73hyo80eJO9YNOOGsOrl3YK5a6N++GBygG7WVN0BO6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784068; c=relaxed/simple;
	bh=M66w+pWxehuYBk+Cb8hsy1oktPUqPTiWP+21qBuk88E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8nxQxjVi5Kq+XBjFQCLxJXd4oCaPZEGqK+dmjjT5IoPDBRxlH7Tiy5hcM2jMCP+jKLrjUNfs4jvzDRGfUR5MlVswKIz6xfcDHuxhI/8f5tIz8LJJIm7FGq1GZ02bLbTTTz99ev8Ueq5M/oRXdUXnmLiGhMeXhnnv1C51iFccqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5yttsII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1B0C433C7;
	Tue, 13 Feb 2024 00:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707784068;
	bh=M66w+pWxehuYBk+Cb8hsy1oktPUqPTiWP+21qBuk88E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5yttsIIDOKZHldhQet6OkDAFharrNZeoVhDnkgZKtYlpNE1XBBEEkfTSn6zhjvZJ
	 q6qujD8hH7dl0s5SIoOgoFwxdeiZ9Rjn2wtDSsGi+kFLUPJ9jMIhzIQwEbuXVvsJBQ
	 C5+uA0TQhiDqsJt7ub4cRTU8zhTlVZ4kyltx2CUTtUMicxBvONZ6yTVtzCkCAzY0QW
	 2Gk3OW2JEuEneFjLbQo7G1KVx2zUuQkatNkbw5d8RYhDftYmJxznAEi6j4gEIkU746
	 lWTSUVecHsUkUxZONZDZwl3pP1555PC1MbdGY5lOa8Obbr5lPBllYaZtewrw2goQmB
	 Sy8mqpQD81dkw==
Date: Mon, 12 Feb 2024 17:27:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: masahiroy@kernel.org, nicolas@fjasle.eu, mark.rutland@arm.com,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Use -fmin-function-alignment when available
Message-ID: <20240213002746.GB3272429@dev-arch.thelio-3990X>
References: <20240212145355.1050-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212145355.1050-1-petr.pavlu@suse.com>

Hi Petr,

On Mon, Feb 12, 2024 at 03:53:55PM +0100, Petr Pavlu wrote:
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
> ---
>  Makefile                       |  7 ++++++-
>  arch/Kconfig                   |  8 ++++++++
>  include/linux/compiler_types.h | 10 +++++-----
>  kernel/exit.c                  |  5 ++++-
>  4 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7e0b2ad98905..9516e43f6e45 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -974,7 +974,12 @@ export CC_FLAGS_CFI
>  endif
>  
>  ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
> -KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
> +# Set the minimal function alignment. Try to use the newer GCC option
> +# -fmin-function-alignment, or fall back to -falign-funtions. See also
> +# CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT.
> +KBUILD_CFLAGS += $(call cc-option, \
> +	-fmin-function-alignment=$(CONFIG_FUNCTION_ALIGNMENT), \
> +	-falign-functions=$(CONFIG_FUNCTION_ALIGNMENT))
>  endif
>  
>  # arch Makefile may override CC so keep this after arch Makefile is included
> diff --git a/arch/Kconfig b/arch/Kconfig
> index a5af0edd3eb8..e2448f927fae 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1507,4 +1507,12 @@ config FUNCTION_ALIGNMENT
>  	default 4 if FUNCTION_ALIGNMENT_4B
>  	default 0
>  
> +config CC_HAS_SANE_FUNCTION_ALIGNMENT
> +	# Detect availability of the GCC option -fmin-function-alignment which
> +	# guarantees minimal alignment for all functions. GCC 13 and older have
> +	# only -falign-functions which the compiler ignores for cold functions
> +	# and this hence requires extra care in the kernel. Clang provides
> +	# strict alignment always when using -falign-functions.
> +	def_bool $(cc-option, -fmin-function-alignment=8) || CC_IS_CLANG
> +

I think this configuration should be split into something like
CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT that has the cc-option check then
CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT can depend on that configuration
or Clang as you have it here, so that we can drop the cc-option check in
the main Makefile and have it be:

ifdef CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT
KBUILD_CFLAGS += -fmin-function-alignment=$(CONFIG_FUNCTION_ALIGNMENT)
else
KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
endif

It is wasteful to call cc-option twice in my opinion, especially if we
are checking it in Kconfig.

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

