Return-Path: <linux-kernel+bounces-87040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF486CE89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C31AB298BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18470AD1;
	Thu, 29 Feb 2024 15:56:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6270AD6;
	Thu, 29 Feb 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222210; cv=none; b=XK46t64yDjZrBaE823AqliVeg5Kba//QrizNNnzRCoysWuRLrvT7DKYs/tSz8YVvA1VtuZAX7bIJRikz4uk6ruwnhdJqwGA1NS+cHD+oHfk70tLxP/7PT2FzOnlbe/dXmS+gr9ufq63VAUNGuTJcSs5hTya1Uzihmio1AaELi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222210; c=relaxed/simple;
	bh=NSsjwYacVaMu1w7Lnxw+r+og5NN001gTRxc21cDBn5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASTZXkp8Uft2kF1w9RY3giqKR1kseQU8wjGnobydA4Ghd0oqG5XzQibJitQZR+TE0yX+WBfw81Z+H2c4WY4OunbU39kPwMAiP/7GD7U2jI40Dfrd+F6+O3eqbKkwq7EyOdqltXI1JCOtCoWunaS2Ldlr2UnuGxmnlMJYQ7MovNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D93441FB;
	Thu, 29 Feb 2024 07:57:26 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.68.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D02F33F6C4;
	Thu, 29 Feb 2024 07:56:45 -0800 (PST)
Date: Thu, 29 Feb 2024 15:56:40 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Fangrui Song <maskray@google.com>, Ard Biesheuvel <ardb@kernel.org>,
	Will Deacon <will@kernel.org>, peterz@infradead.org,
	jpoimboe@kernel.org, jbaron@akamai.com, catalin.marinas@arm.com,
	nathan@kernel.org, linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.7 07/26] arm64: jump_label: use constraints
 "Si" instead of "i"
Message-ID: <ZeCpOPDi18OBEclz@FVFF77S0Q05N>
References: <20240229154851.2849367-1-sashal@kernel.org>
 <20240229154851.2849367-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229154851.2849367-7-sashal@kernel.org>

On Thu, Feb 29, 2024 at 10:48:26AM -0500, Sasha Levin wrote:
> From: Fangrui Song <maskray@google.com>
> 
> [ Upstream commit f9daab0ad01cf9d165dbbbf106ca4e61d06e7fe8 ]

That upstream patch caused issues and was subsequently reverted in commit:

  a6b3eb304a82c29665a0ab947cfe276f6d29f523
  ("Revert "arm64: jump_label: use constraints "Si" instead of "i""")

Please drop this; it'll break stable in the same way, and it wasn't necessary
to backport in the first place.

As an aside, that revert has been upstream since v6.8-rc4, ~2.5 weeks ago; it's
unfortunate for the broken patch to be AUTOSEL'd now! It'd be good if something
could automatically check for reverts in mainline...

Mark.

> The generic constraint "i" seems to be copied from x86 or arm (and with
> a redundant generic operand modifier "c"). It works with -fno-PIE but
> not with -fPIE/-fPIC in GCC's aarch64 port.
> 
> The machine constraint "S", which denotes a symbol or label reference
> with a constant offset, supports PIC and has been available in GCC since
> 2012 and in Clang since 7.0. However, Clang before 19 does not support
> "S" on a symbol with a constant offset [1] (e.g.
> `static_key_false(&nf_hooks_needed[pf][hook])` in
> include/linux/netfilter.h), so we use "i" as a fallback.
> 
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Link: https://github.com/llvm/llvm-project/pull/80255 [1]
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Link: https://lore.kernel.org/r/20240206074552.541154-1-maskray@google.com
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/include/asm/jump_label.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index 48ddc0f45d228..b7716b215f91a 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -15,6 +15,10 @@
>  
>  #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
>  
> +/*
> + * Prefer the constraint "S" to support PIC with GCC. Clang before 19 does not
> + * support "S" on a symbol with a constant offset, so we use "i" as a fallback.
> + */
>  static __always_inline bool arch_static_branch(struct static_key * const key,
>  					       const bool branch)
>  {
> @@ -23,9 +27,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
>  		 "	.pushsection	__jump_table, \"aw\"	\n\t"
>  		 "	.align		3			\n\t"
>  		 "	.long		1b - ., %l[l_yes] - .	\n\t"
> -		 "	.quad		%c0 - .			\n\t"
> +		 "	.quad		(%[key] - .) + %[bit0]  \n\t"
>  		 "	.popsection				\n\t"
> -		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +		 :  :  [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);
>  
>  	return false;
>  l_yes:
> @@ -40,9 +44,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
>  		 "	.pushsection	__jump_table, \"aw\"	\n\t"
>  		 "	.align		3			\n\t"
>  		 "	.long		1b - ., %l[l_yes] - .	\n\t"
> -		 "	.quad		%c0 - .			\n\t"
> +		 "	.quad		(%[key] - .) + %[bit0]  \n\t"
>  		 "	.popsection				\n\t"
> -		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +		 :  :  [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);
>  
>  	return false;
>  l_yes:
> -- 
> 2.43.0
> 

