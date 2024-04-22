Return-Path: <linux-kernel+bounces-153086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4AD8AC8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8BC281021
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838565490E;
	Mon, 22 Apr 2024 09:24:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D274CB55
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777894; cv=none; b=b8zMNv5Pq201xV1rVuz6ZU7t0PvkUVMsSXtve/2FYqT7Cqdqxctlw1QxWSq0t7805JsIJ3PoYdzBTfhcQdEAihXFZfVuMMR+UgiyXo5I+NA+SYKCQD/Xpap557baSlThy0yWYufXnyZ7XM62cnrN59chiX+zTXguxe+VYu1Gcss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777894; c=relaxed/simple;
	bh=zKQ3k2gwW1Opf720YnuU+x5Yj7lv17laarSd6ecAee8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sffvBl9oNLiJ3/1x+hkPJSov9nRigEZpZvPk7iY7Zc5y36qiPh+0F1KBZdQZa2G3LaBPgSurnnJGhhWGu0bdZQH2iQIA+DzdKVL5KxaPk5k9k6YDGn3QaVV2PcQrJRMB3p3sjFYEPpZPy6HidFKYkrLmZlljo28BTSZf25CAl4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9FE0339;
	Mon, 22 Apr 2024 02:25:19 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C93D3F64C;
	Mon, 22 Apr 2024 02:24:49 -0700 (PDT)
Date: Mon, 22 Apr 2024 10:24:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
	rostedt@goodmis.org, ardb@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH 1/1] arm64: optimize code duplication in
 arch_static_branch/_jump function
Message-ID: <ZiYs3itsmdOmuPq4@FVFF77S0Q05N>
References: <20240422063853.3568733-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422063853.3568733-1-dongtai.guo@linux.dev>

On Mon, Apr 22, 2024 at 02:38:53PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Extracted the jump table definition code from the arch_static_branch and
> arch_static_branch_jump functions into a macro JUMP_TABLE_ENTRY to reduce
> code duplication and improve readability.

The commit title says this is an optimization, but the commit message says this
is a cleanup (and this clearly is not an optimization).

This seems to be copying what x86 did in commit:

  e1aa35c4c4bc71e4 ("jump_label, x86: Factor out the __jump_table generation")

.. where the commit message is much clearer.

> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  arch/arm64/include/asm/jump_label.h | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index 6aafbb789991..69407b70821e 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -15,16 +15,19 @@
>  
>  #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
>  
> +#define JUMP_TABLE_ENTRY				\
> +	 ".pushsection	__jump_table, \"aw\"	\n\t"	\
> +	 ".align	3			\n\t"	\
> +	 ".long		1b - ., %l[l_yes] - .	\n\t"	\
> +	 ".quad		%c0 - .			\n\t"	\
> +	 ".popsection				\n\t"
> +
>  static __always_inline bool arch_static_branch(struct static_key * const key,
>  					       const bool branch)
>  {
>  	asm goto(
>  		"1:	nop					\n\t"
> -		 "	.pushsection	__jump_table, \"aw\"	\n\t"
> -		 "	.align		3			\n\t"
> -		 "	.long		1b - ., %l[l_yes] - .	\n\t"
> -		 "	.quad		%c0 - .			\n\t"
> -		 "	.popsection				\n\t"
> +		JUMP_TABLE_ENTRY
>  		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);

If we really need to factor this out, I'd prefer that the JUMP_TABLE_ENTRY()
macro took the label and key as arguments, similar to what we do for
_ASM_EXTABLE_*().

Mark.

>  
>  	return false;
> @@ -37,11 +40,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
>  {
>  	asm goto(
>  		"1:	b		%l[l_yes]		\n\t"
> -		 "	.pushsection	__jump_table, \"aw\"	\n\t"
> -		 "	.align		3			\n\t"
> -		 "	.long		1b - ., %l[l_yes] - .	\n\t"
> -		 "	.quad		%c0 - .			\n\t"
> -		 "	.popsection				\n\t"
> +		JUMP_TABLE_ENTRY
>  		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
>  
>  	return false;
> -- 
> 2.34.1
> 
> 

