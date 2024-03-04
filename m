Return-Path: <linux-kernel+bounces-90323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29F86FD97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626B21F23935
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09636AE9;
	Mon,  4 Mar 2024 09:25:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35122625
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544351; cv=none; b=qk6456zD/ekTAYmtMpypsogQ22yl80y9eZu/kZA6b9pnn/kklupeuFx5uSgWRDd3KirfX43mqUYoTOaTKrUzrjGyAtXJdpHpQvnXqorHavXDbJs3tSSidmkZwUlAqDJOGakEqPoJgkCewfXxvT6PqaGMFpmtOfl+2b96/rgcP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544351; c=relaxed/simple;
	bh=ic27iaOnAF3Qn641ghW2HZlaLuyYlteyfKsexO9dBQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUtQraSU1ZD3a9gF7OXOBO5avpPHFll5wkn+mZLJHpl3wUyCIQZdMC5+oKQIsLGeC7DorgDWRNT87v1pC+ucu7kN/JdSuv54hxEzg3ECOElcDiogUokVYJ/fMYBuoh2t0r4NDSrnDQrsnqq6yKrf1VUAmjRreV2b4Rfz1YrVkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B862E1FB;
	Mon,  4 Mar 2024 01:26:25 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02EB3F762;
	Mon,  4 Mar 2024 01:25:47 -0800 (PST)
Date: Mon, 4 Mar 2024 09:25:38 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
	ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: head: remove unnecessary instructions from
 __relocate_kernel
Message-ID: <ZeWThcOa-cW2Ax5a@FVFF77S0Q05N>
References: <20240302145210.65919-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302145210.65919-1-puranjay12@gmail.com>

On Sat, Mar 02, 2024 at 02:52:10PM +0000, Puranjay Mohan wrote:
> Formerly, we had to access the RELA and RELR tables via the kernel
> mapping that was being relocated, and so deriving the start and end
> addresses was done by loading __rela_offset in x9 and then adding the
> actual virtual offset of the kernel to it.
> 
> d7bea550279d ("arm64: head: use relative references to the RELA and RELR
> tables") changed this to load the entries via the ID map as we map the
> entire kernel image via the ID map.
> 
> The two instructions for finding the actual virtual offset were left by
> that commit, so remove them now as they are unnecessary and add runtime
> overhead.

These instructions are already gone in linux-next; they're removed by commit:

  734958ef0b5497b1 ("arm64: head: move relocation handling to C code")

.. so this patch isn't necessary.

> Fixes: d7bea550279d ("arm64: head: use relative references to the RELA and RELR tables")

As a heads-up for future patches, while this would be a cleanup it is not a
fix, and wouldn't need a fixes tag.

Mark.

> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm64/kernel/head.S | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index cab7f91949d8..90db196f7c19 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -787,8 +787,6 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
>  	 */
>  	adr_l	x9, __rela_start
>  	adr_l	x10, __rela_end
> -	mov_q	x11, KIMAGE_VADDR		// default virtual offset
> -	add	x11, x11, x23			// actual virtual offset
>  
>  0:	cmp	x9, x10
>  	b.hs	1f
> 
> base-commit: 5ad3cb0ed525b80c7f66c32b49a68c1f3510bec9
> -- 
> 2.42.0
> 

