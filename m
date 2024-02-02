Return-Path: <linux-kernel+bounces-50055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426B8473C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B431C239CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39831474A0;
	Fri,  2 Feb 2024 15:56:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2AF1474A7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889410; cv=none; b=GJGSdQ+SBPoPhgfhJc/tzFQ1u116FZQZHniLsKEYFGaBJoPxn5K1EgY5JPxrB6iBWWB2/OlP0swsGE92JZ1132OYUz2P9DO+1tlSTnsEXM/VtBWtx9eOtjqpDft+lfmX76xBJP3GfaMF44b4LSsSXirUteTdcBz6pAwqaBESGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889410; c=relaxed/simple;
	bh=dahtuyjDRHri9WwVOjAn6Bjcc8J+qhEPsGjjMokJuwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZhrlnTBdO8GQua80zVGq/BUdISVJ8oAlyWU2nuQq0kmHBym4Mnr3ZUucfNjBCee69RIfS645y90bdezNczzQLKime+V+wzS7T19nFMrOgsd2KZlFOFsQHPwGH4ZvcnBsbztXPNo+hpD+nZi3/pM1Wm7RELV9aKllgp8JUbxbTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEEB9DA7;
	Fri,  2 Feb 2024 07:57:29 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A81C3F5A1;
	Fri,  2 Feb 2024 07:56:46 -0800 (PST)
Date: Fri, 2 Feb 2024 15:56:43 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Fangrui Song <maskray@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Peter Smith <peter.smith@arm.com>,
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraints "Si" instead of "i"
Message-ID: <Zb0Qu5lR0iZUqImb@e133380.arm.com>
References: <20240201223545.728028-1-maskray@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201223545.728028-1-maskray@google.com>

On Thu, Feb 01, 2024 at 02:35:45PM -0800, Fangrui Song wrote:
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
> 
> ---
> Changes from
> arm64: jump_label: use constraint "S" instead of "i" (https://lore.kernel.org/all/20240131065322.1126831-1-maskray@google.com/)
> 
> * Use "Si" as Ard suggested to support Clang<19
> * Make branch a separate operand
> ---
>  arch/arm64/include/asm/jump_label.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index 48ddc0f45d22..1f7d529be608 100644
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
> +		 "	.quad		%0 + %1 - .		\n\t"
>  		 "	.popsection				\n\t"
> -		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +		 :  :  "Si"(key), "i"(branch) :  : l_yes);

Is the meaning of multi-alternatives well defined if different arguments
specify different numbers of alternatives?  The GCC documentation says:

https://gcc.gnu.org/onlinedocs/gcc/Multi-Alternative.html:

-8<-

[...] All operands for a single instruction must have the same number of
alternatives.

->8-

Also, I still think it may be redundant to move the addition inside the
asm, so long as Clang is happy with the symbol having an offset.

I.e., leave the .quad the same and revert to the one-liner

-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		 :  :  "Si"(&((char *)key)[branch]) :  : l_yes);

This remains a bit nasty, but splitting the arguments and adding them
inside the asm is not really any cleaner.  Changing the way this works
doesn't seem relevant to what this patch is fixing (and apologies if I
created confusion here...)

>  
>  	return false;
>  l_yes:
> @@ -40,9 +44,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
>  		 "	.pushsection	__jump_table, \"aw\"	\n\t"
>  		 "	.align		3			\n\t"
>  		 "	.long		1b - ., %l[l_yes] - .	\n\t"
> -		 "	.quad		%c0 - .			\n\t"
> +		 "	.quad		%0 + %1 - .		\n\t"
>  		 "	.popsection				\n\t"
> -		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +		 :  :  "Si"(key), "i"(branch) :  : l_yes);

Ditto.

[...]

Cheers
---Dave

