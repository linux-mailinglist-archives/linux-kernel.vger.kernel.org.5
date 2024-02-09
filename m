Return-Path: <linux-kernel+bounces-59269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6D84F452
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64C11C2531F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9D28DBC;
	Fri,  9 Feb 2024 11:11:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C0288D9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477081; cv=none; b=ljdjD63aT0QcFo1hqUXhH4nQopj4EdKAZ46kMZcD8fzSmip7XqLqWX0Hqbgon923oGXZMgFiYoYLBrG+CySQ9tiZsc6DpZMjs+u0RI0fRs06CniLImSWy6MUPf97ibhYe/98jYHB3orsRPIDZ6GAA1bGZkM5GDCvpq9rT3+Ob6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477081; c=relaxed/simple;
	bh=YOqOwkuAEGeXh3W/ozSHwWeZ88PIMKCEKNwcOky05P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fod3g8iwjx2ViNEjMdTmlsIdUyyxCpv8008/yC6JmHBFWZuzd5Hsgv6ZJMEa3u/uuwRRDvEnc+aGf1Q9d5QjvDgWER5QqE7QGHK79mxGu2hcu1zbmZTteXQ835Pt405XHpxEVCx6W1QkM3XI8Srv0QG+BNpycVFuV8whgx+QQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A393DA7;
	Fri,  9 Feb 2024 03:12:01 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8332B3F762;
	Fri,  9 Feb 2024 03:11:17 -0800 (PST)
Date: Fri, 9 Feb 2024 11:11:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Fangrui Song <maskray@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
Message-ID: <ZcYIOZdYMyvFQH5u@FVFF77S0Q05N.cambridge.arm.com>
References: <20240206074552.541154-1-maskray@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206074552.541154-1-maskray@google.com>

On Mon, Feb 05, 2024 at 11:45:52PM -0800, Fangrui Song wrote:
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

This looks reasonable to me, and works with the toolchains I've tried, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> Changes from
> arm64: jump_label: use constraint "S" instead of "i" (https://lore.kernel.org/all/20240131065322.1126831-1-maskray@google.com/)
> 
> * Use "Si" as Ard suggested to support Clang<19
> * Make branch a separate operand
> 
> Changes from v1:
> 
> * Use asmSymbolicName for readability
> ---
>  arch/arm64/include/asm/jump_label.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index 48ddc0f45d22..b7716b215f91 100644
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
> 2.43.0.594.gd9cf4e227d-goog
> 
> 

