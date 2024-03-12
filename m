Return-Path: <linux-kernel+bounces-100454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA88797C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4106728A4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732FE7CF00;
	Tue, 12 Mar 2024 15:38:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46B7C09F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257908; cv=none; b=TwRcpbslKDj41pxobyaMRkGTErHXLhEUVX039bHsjDznsK0Y8tiHO07Rren3qN4i6zKej44ZGucnr0meuWDJLQcWTbKsLLFITmmZ/Fz1rwcNoN2khEqE2aaQh0clAL7CJzK2HUGBsd2kXhhWcKg7pY5Wu2jAns1pqTYifq42I8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257908; c=relaxed/simple;
	bh=+ew1KP7lo6wFjKpRFhRTXmvsgt0nbNGzLE2XMhqglLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh512hC17v1FNYfMycXLKFBA8fKlFNNlE9kv4ZOBHHKIEolvqDfxfo6tGSRzQsjrINV1LYtTtsRvyFvJ4PmMuNv591eg5QdekD3iux0fMOlps7P2Dwhhc3XQVBGxlOrzg8FoTHit+YBcQTS0n/zF7IJDFv+o1hMjEtZy+fmLBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E94E11007;
	Tue, 12 Mar 2024 08:39:02 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.69.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C6273F762;
	Tue, 12 Mar 2024 08:38:24 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:38:02 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, quic_jiles@quicinc.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: lib: improve usercopy performance by mitigating
 data dependencies
Message-ID: <ZfB22hqeX2nHbxDU@FVFF77S0Q05N>
References: <20240312150845.1356415-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312150845.1356415-1-lizetao1@huawei.com>

On Tue, Mar 12, 2024 at 11:08:45PM +0800, Li Zetao wrote:
> In the copy_from/to_user scenario, due to the need to accurately
> calculate the number of copied bytes for fixup, it is necessary to
> increment the values of src and dst after each copy of the data.
> Therefore, this introduce RAW dependency which result in some bubble
> in pipline and degrade the IPC.
> 
> Consider updating the values of src and dst only when the copy is
> completed in the current stage to reduce data dependence. But this will
> break the function of fixup, so in order to maintain the function of
> fixup, a new variable is introduced to record the number of bytes to be
> copied in the current stage. Once an access exception occurs, the variable
> can be used to determined the final index of access exception by copying
> byte-by-byte.
> 
> Here are the test result:
>   Copy 128 bytes cost on Kunpeng-920(us):
>     Without this patch:
>     copy_from_user: 1.0187 copy_to_user: 1.1021
> 
>     With this patch:
>     copy_from_user: 0.9523 copy_to_user: 1.0159
> 
> It's about 7% improvement in copy_from/to_user()

How exactly are you testing this? Can you share your test code?

The current structure of this code (and e.g. the use of write-back addressing)
is largely force upon us by the structure of the Cortex strings functions,
which are already painful enough to read and work on. If we're going to rewrite
those I'd rather we abandoned the Cortex strings template for usercopies. 

I had previously attempted to rewrite some of these along with some functional
tests:

  https://lore.kernel.org/linux-arm-kernel/20230314115030.347976-1-mark.rutland@arm.com/

Could you give those a go?  Specifically, could you see how copy_to_user()
performs with the patch at:

  https://lore.kernel.org/linux-arm-kernel/20230314115030.347976-4-mark.rutland@arm.com/

.. if that gets you a similar benefit I'd be happy to revive the series and
give copy_from_user() similar treatment.

Thanks,
Mark.

> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  arch/arm64/include/asm/asm-uaccess.h | 14 +++---
>  arch/arm64/lib/copy_from_user.S      | 21 +++++++--
>  arch/arm64/lib/copy_template.S       | 66 +++++++++++++++++-----------
>  arch/arm64/lib/copy_to_user.S        | 22 +++++++---
>  4 files changed, 81 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index 5b6efe8abeeb..ccbde0d0c113 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -66,19 +66,17 @@ alternative_else_nop_endif
>   * This is complicated as there is no post-increment or pair versions of the
>   * unprivileged instructions, and USER() only works for single instructions.
>   */
> -	.macro user_ldp l, reg1, reg2, addr, post_inc
> -8888:		ldtr	\reg1, [\addr];
> -8889:		ldtr	\reg2, [\addr, #8];
> -		add	\addr, \addr, \post_inc;
> +	.macro user_ldp l, reg1, reg2, addr, offs_inc
> +8888:		ldtr	\reg1, [\addr, \offs_inc];
> +8889:		ldtr	\reg2, [\addr, \offs_inc + 8];
>  
>  		_asm_extable_uaccess	8888b, \l;
>  		_asm_extable_uaccess	8889b, \l;
>  	.endm
>  
> -	.macro user_stp l, reg1, reg2, addr, post_inc
> -8888:		sttr	\reg1, [\addr];
> -8889:		sttr	\reg2, [\addr, #8];
> -		add	\addr, \addr, \post_inc;
> +	.macro user_stp l, reg1, reg2, addr, offs_inc
> +8888:		sttr	\reg1, [\addr, \offs_inc];
> +8889:		sttr	\reg2, [\addr, \offs_inc + 8];
>  
>  		_asm_extable_uaccess	8888b,\l;
>  		_asm_extable_uaccess	8889b,\l;
> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> index 34e317907524..c575829b85be 100644
> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -49,7 +49,7 @@
>  	.endm
>  
>  	.macro stp1 reg1, reg2, ptr, val
> -	stp \reg1, \reg2, [\ptr], \val
> +	stp \reg1, \reg2, [\ptr, \val]
>  	.endm
>  
>  end	.req	x5
> @@ -62,12 +62,25 @@ SYM_FUNC_START(__arch_copy_from_user)
>  	ret
>  
>  	// Exception fixups
> -9997:	cmp	dst, dstin
> +9997:	sub	x7, src, srcin
> +	sub	x8, dst, dstin
> +	cmp	x7, x8
> +	b.le	no_need_to_adjust_src
> +	sub	x9, x7, x8
> +	sub	src, src, p_copy
> +	add	p_copy, p_copy, x9
> +no_need_to_adjust_src:
> +	cmp	dst, dstin
>  	b.ne	9998f
>  	// Before being absolutely sure we couldn't copy anything, try harder
> -USER(9998f, ldtrb tmp1w, [srcin])
> +calculate_bytes_copied:
> +USER(9999f, ldtrb tmp1w, [src])
>  	strb	tmp1w, [dst], #1
> -9998:	sub	x0, end, dst			// bytes not copied
> +	add	src, src, #1
> +	sub	p_copy, p_copy, #1
> +9998:	cmp	p_copy, 0
> +	b.ge	calculate_bytes_copied
> +9999:	sub	x0, end, dst			// bytes not copied
>  	ret
>  SYM_FUNC_END(__arch_copy_from_user)
>  EXPORT_SYMBOL(__arch_copy_from_user)
> diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
> index 488df234c49a..8832b9fd0257 100644
> --- a/arch/arm64/lib/copy_template.S
> +++ b/arch/arm64/lib/copy_template.S
> @@ -29,6 +29,7 @@ tmp1w	.req	w3
>  tmp2	.req	x4
>  tmp2w	.req	w4
>  dst	.req	x6
> +p_copy	.req	x16
>  
>  A_l	.req	x7
>  A_h	.req	x8
> @@ -39,6 +40,7 @@ C_h	.req	x12
>  D_l	.req	x13
>  D_h	.req	x14
>  
> +	mov	p_copy, 16
>  	mov	dst, dstin
>  	cmp	count, #16
>  	/*When memory length is less than 16, the accessed are not aligned.*/
> @@ -82,19 +84,26 @@ D_h	.req	x14
>  	* Copy up to 48 bytes of data. At this point we only need the
>  	* bottom 6 bits of count to be accurate.
>  	*/
> +	mov	p_copy, #16
>  	ands	tmp1, count, #0x30
>  	b.eq	.Ltiny15
>  	cmp	tmp1w, #0x20
>  	b.eq	1f
>  	b.lt	2f
> -	ldp1	A_l, A_h, src, #16
> -	stp1	A_l, A_h, dst, #16
> +	ldp1	A_l, A_h, src, #0
> +	stp1	A_l, A_h, dst, #0
> +	add	src, src, #16
> +	add	dst, dst, #16
>  1:
> -	ldp1	A_l, A_h, src, #16
> -	stp1	A_l, A_h, dst, #16
> +	ldp1	A_l, A_h, src, #0
> +	stp1	A_l, A_h, dst, #0
> +	add	src, src, #16
> +	add	dst, dst, #16
>  2:
> -	ldp1	A_l, A_h, src, #16
> -	stp1	A_l, A_h, dst, #16
> +	ldp1	A_l, A_h, src, #0
> +	stp1	A_l, A_h, dst, #0
> +	add	src, src, #16
> +	add	dst, dst, #16
>  .Ltiny15:
>  	/*
>  	* Prefer to break one ldp/stp into several load/store to access
> @@ -126,20 +135,23 @@ D_h	.req	x14
>  	b	.Lexitfunc
>  
>  .Lcpy_over64:
> +	mov	p_copy, #64
>  	subs	count, count, #128
>  	b.ge	.Lcpy_body_large
>  	/*
>  	* Less than 128 bytes to copy, so handle 64 here and then jump
>  	* to the tail.
>  	*/
> -	ldp1	A_l, A_h, src, #16
> -	stp1	A_l, A_h, dst, #16
> +	ldp1	A_l, A_h, src, #0
> +	stp1	A_l, A_h, dst, #0
>  	ldp1	B_l, B_h, src, #16
> -	ldp1	C_l, C_h, src, #16
> +	ldp1	C_l, C_h, src, #32
>  	stp1	B_l, B_h, dst, #16
> -	stp1	C_l, C_h, dst, #16
> -	ldp1	D_l, D_h, src, #16
> -	stp1	D_l, D_h, dst, #16
> +	stp1	C_l, C_h, dst, #32
> +	ldp1	D_l, D_h, src, #48
> +	stp1	D_l, D_h, dst, #48
> +	add	src, src, #64
> +	add	dst, dst, #64
>  
>  	tst	count, #0x3f
>  	b.ne	.Ltail63
> @@ -152,30 +164,34 @@ D_h	.req	x14
>  	.p2align	L1_CACHE_SHIFT
>  .Lcpy_body_large:
>  	/* pre-get 64 bytes data. */
> -	ldp1	A_l, A_h, src, #16
> +	ldp1	A_l, A_h, src, #0
>  	ldp1	B_l, B_h, src, #16
> -	ldp1	C_l, C_h, src, #16
> -	ldp1	D_l, D_h, src, #16
> +	ldp1	C_l, C_h, src, #32
> +	ldp1	D_l, D_h, src, #48
> +	add	src, src, #64
>  1:
>  	/*
>  	* interlace the load of next 64 bytes data block with store of the last
>  	* loaded 64 bytes data.
>  	*/
> -	stp1	A_l, A_h, dst, #16
> -	ldp1	A_l, A_h, src, #16
> +	stp1	A_l, A_h, dst, #0
> +	ldp1	A_l, A_h, src, #0
>  	stp1	B_l, B_h, dst, #16
>  	ldp1	B_l, B_h, src, #16
> -	stp1	C_l, C_h, dst, #16
> -	ldp1	C_l, C_h, src, #16
> -	stp1	D_l, D_h, dst, #16
> -	ldp1	D_l, D_h, src, #16
> +	stp1	C_l, C_h, dst, #32
> +	ldp1	C_l, C_h, src, #32
> +	stp1	D_l, D_h, dst, #48
> +	ldp1	D_l, D_h, src, #48
> +	add	src, src, #64
> +	add	dst, dst, #64
>  	subs	count, count, #64
>  	b.ge	1b
> -	stp1	A_l, A_h, dst, #16
> +	stp1	A_l, A_h, dst, #0
>  	stp1	B_l, B_h, dst, #16
> -	stp1	C_l, C_h, dst, #16
> -	stp1	D_l, D_h, dst, #16
> +	stp1	C_l, C_h, dst, #32
> +	stp1	D_l, D_h, dst, #48
> +	add	dst, dst, #64
>  
>  	tst	count, #0x3f
>  	b.ne	.Ltail63
> -.Lexitfunc:
> +.Lexitfunc: mov	p_copy, #0
> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
> index 802231772608..89db19e09ca2 100644
> --- a/arch/arm64/lib/copy_to_user.S
> +++ b/arch/arm64/lib/copy_to_user.S
> @@ -44,7 +44,7 @@
>  	.endm
>  
>  	.macro ldp1 reg1, reg2, ptr, val
> -	ldp \reg1, \reg2, [\ptr], \val
> +	ldp \reg1, \reg2, [\ptr, \val]
>  	.endm
>  
>  	.macro stp1 reg1, reg2, ptr, val
> @@ -61,13 +61,25 @@ SYM_FUNC_START(__arch_copy_to_user)
>  	ret
>  
>  	// Exception fixups
> -9997:	cmp	dst, dstin
> +9997:	sub	x7, src, srcin
> +	sub	x8, dst, dstin
> +	cmp	x7, x8
> +	b.le	no_need_to_adjust_src
> +	sub	x9, x7, x8
> +	sub	src, src, x9
> +	add	p_copy, p_copy, x9
> +no_need_to_adjust_src:
> +	cmp	dst, dstin
>  	b.ne	9998f
>  	// Before being absolutely sure we couldn't copy anything, try harder
> -	ldrb	tmp1w, [srcin]
> -USER(9998f, sttrb tmp1w, [dst])
> +calculate_bytes_copied:
> +	ldrb	tmp1w, [src], #1
> +USER(9999f, sttrb tmp1w, [dst])
>  	add	dst, dst, #1
> -9998:	sub	x0, end, dst			// bytes not copied
> +	sub	p_copy, p_copy, #1
> +9998:	cmp	p_copy, 0
> +	b.ge	calculate_bytes_copied
> +9999:	sub	x0, end, dst			// bytes not copied
>  	ret
>  SYM_FUNC_END(__arch_copy_to_user)
>  EXPORT_SYMBOL(__arch_copy_to_user)
> -- 
> 2.34.1
> 

