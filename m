Return-Path: <linux-kernel+bounces-165584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02898B8E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB981C218B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B217C9B;
	Wed,  1 May 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyJQWB/C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17A14A81;
	Wed,  1 May 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581198; cv=none; b=HMdSavHMr9e5MVqZfjL8lSsu4RwmJIFCoad1df9Gp3dKrrF8nRccM6mrqPqelWgEG+OO9Uj0o6mwfL5WoW0WLpOICmB9NxYRy/Fo+XWXYZLw4XrQKtsk1ATOsMyFLyDQUEK/4YPQbsPPOpALCBdvXhT+cU2pHhhgXrJMKxKZBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581198; c=relaxed/simple;
	bh=YsbiyCkWKx45NRwGZjUByWsT1FcLXkinPMoGZRzJENY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2wQY/cmCB6SqcgKNafKW+dGiWj0lDV92LwPG6gIsZ5YvFyP1os2Pp1dPU/55ayktpzfmxdfqHH8uuzNkjZlNeI1FHSH6r4BgYC3pnjMC4VscWBy4FXIMEzPjtshK4L0cdjkPN/A5NKdogrkr6czPj4vtVzn+oq0JoWRLg1Mx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyJQWB/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9843DC072AA;
	Wed,  1 May 2024 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714581197;
	bh=YsbiyCkWKx45NRwGZjUByWsT1FcLXkinPMoGZRzJENY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyJQWB/C/UPy4hQuJX7qWfmVqfUZv95MxBh5sX9ggF10yALKt3+gJ4E59JuVdphYn
	 +PmVOsc9zIbTDydsLQoRwu32kcNi9awZ4m3i1xCWZsJf1guGKFWK/WTZ9s4jYZJIXS
	 T6YNrqkcpcK0TXH8s1N4YpzOOTcTZBy0JMufDRmwywwcsqwU6Hl3roNxLh9K1KOLrz
	 NWunAfeQyYBTe/LSnFu9WE3dg8+4WscGoLSUgRR1+C0F4me78dC07h6wx2sv6zDiD6
	 sIcNZ1h7xp7TjjXv1LPwkarBqN2efPN0ZOUbEZbr+cpSNdsyxTu/NUc1rznKDJibJt
	 fw65B/KbapeVg==
Date: Wed, 1 May 2024 09:33:14 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>, Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Make FineIBT mode Kconfig selectable
Message-ID: <20240501163314.GA2472577@dev-arch.thelio-3990X>
References: <20240501000218.work.998-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501000218.work.998-kees@kernel.org>

On Tue, Apr 30, 2024 at 05:02:22PM -0700, Kees Cook wrote:
> Since FineIBT performs checking at the destination, it is weaker against
> attacks that can construct arbitrary executable memory contents. As such,
> some system builders want to run with FineIBT disabled by default. Allow
> the "cfi=kcfi" boot param mode to be selectable through Kconfig via the
> newly introduced CONFIG_CFI_AUTO_DEFAULT.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

I verified that flipping the configuration does indeed change the
default and that 'cfi=' could still be used to override whatever choice
was made at compile time. This patch was a perfect excuse to put my new
CET enabled test machine to work.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

CFI_DEFAULT_AUTO reads a little bit better to me personally but I am not
looking to get into painting today :)

> ---
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/Kconfig              | 9 +++++++++
>  arch/x86/include/asm/cfi.h    | 2 +-
>  arch/x86/kernel/alternative.c | 8 ++++----
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4fff6ed46e90..d5cf52d2f6a8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2424,6 +2424,15 @@ config STRICT_SIGALTSTACK_SIZE
>  
>  	  Say 'N' unless you want to really enforce this check.
>  
> +config CFI_AUTO_DEFAULT
> +	bool "Attempt to use FineIBT by default at boot time"
> +	depends on FINEIBT
> +	default y
> +	help
> +	  Attempt to use FineIBT by default at boot time. If enabled,
> +	  this is the same as booting with "cfi=auto". If disabled,
> +	  this is the same as booting with "cfi=kcfi".
> +
>  source "kernel/livepatch/Kconfig"
>  
>  endmenu
> diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
> index 7cd752557905..31d19c815f99 100644
> --- a/arch/x86/include/asm/cfi.h
> +++ b/arch/x86/include/asm/cfi.h
> @@ -93,7 +93,7 @@
>   *
>   */
>  enum cfi_mode {
> -	CFI_DEFAULT,	/* FineIBT if hardware has IBT, otherwise kCFI */
> +	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */
>  	CFI_OFF,	/* Taditional / IBT depending on .config */
>  	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
>  	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 45a280f2161c..e8d0892d89cf 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -902,8 +902,8 @@ void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
>  
>  #endif /* CONFIG_X86_KERNEL_IBT */
>  
> -#ifdef CONFIG_FINEIBT
> -#define __CFI_DEFAULT	CFI_DEFAULT
> +#ifdef CONFIG_CFI_AUTO_DEFAULT
> +#define __CFI_DEFAULT	CFI_AUTO
>  #elif defined(CONFIG_CFI_CLANG)
>  #define __CFI_DEFAULT	CFI_KCFI
>  #else
> @@ -1011,7 +1011,7 @@ static __init int cfi_parse_cmdline(char *str)
>  		}
>  
>  		if (!strcmp(str, "auto")) {
> -			cfi_mode = CFI_DEFAULT;
> +			cfi_mode = CFI_AUTO;
>  		} else if (!strcmp(str, "off")) {
>  			cfi_mode = CFI_OFF;
>  			cfi_rand = false;
> @@ -1271,7 +1271,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
>  		      "FineIBT preamble wrong size: %ld", fineibt_preamble_size))
>  		return;
>  
> -	if (cfi_mode == CFI_DEFAULT) {
> +	if (cfi_mode == CFI_AUTO) {
>  		cfi_mode = CFI_KCFI;
>  		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
>  			cfi_mode = CFI_FINEIBT;
> -- 
> 2.34.1
> 

