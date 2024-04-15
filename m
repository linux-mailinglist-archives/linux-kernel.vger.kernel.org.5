Return-Path: <linux-kernel+bounces-144767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC348A4A76
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3961C21EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAE63C087;
	Mon, 15 Apr 2024 08:36:09 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AEF3BBED;
	Mon, 15 Apr 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170168; cv=none; b=hrrB3Dh06WrJ2k/u77kpBM7KiV/zADY5SeXdhAPWcd6XM+VpopBfcYQa5CC1gxKu1hUV9AdAPxfRQj0Qb2D8DLlejx/r2BS5KP8B9TNRA/BTZuKaXhkf/lT7Rvjy9HFJEIX11CADLa7w0APF5gE4fzrLl8LTq0YHd8ij5nSuqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170168; c=relaxed/simple;
	bh=3pn1236NH8HERFeQ80zUKBBGeBNC3NuW3A04K3Vi/pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9eWsKF4Jhzrgd+SGA9TD1+x2htjUjQ66Ir46QumPOReA+8ZS0MWxOIM0tN0W7Oc+Fgyw5FMv7+RyHR14JMTRI4caPu5nsOs39e6w0gzQnN27rhLRSvkVOEbhJOtp0u+fagwr9GWORAFUvVz9OaO/+JsdAEm/Asw7Sxs8ydsJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rwHob-0004hw-00; Mon, 15 Apr 2024 10:35:49 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 7D228C05B3; Mon, 15 Apr 2024 10:34:56 +0200 (CEST)
Date: Mon, 15 Apr 2024 10:34:56 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] MIPS: Guard some macros with __ASSEMBLY__ in asm.h
Message-ID: <ZhzmsE/jH3/sx0X6@alpha.franken.de>
References: <20240326-asm-guard-v1-1-fe0c140a5aea@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-asm-guard-v1-1-fe0c140a5aea@flygoat.com>

On Tue, Mar 26, 2024 at 11:41:45AM +0000, Jiaxun Yang wrote:
> There are some assembly macros with very generic naming
> being defined asm.h. They are clashing with other macros
> from C code.
> 
> Guard them with __ASSEMBLY__ to prevent futher clashes.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/linux-mips/8d78894-dd89-9f4d-52bb-1b873c50be9c@linux-m68k.org/
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/asm.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
> index 2e99450f4228..87ff609b53fe 100644
> --- a/arch/mips/include/asm/asm.h
> +++ b/arch/mips/include/asm/asm.h
> @@ -37,6 +37,7 @@
>  #define CFI_SECTIONS
>  #endif
>  
> +#ifdef __ASSEMBLY__
>  /*
>   * LEAF - declare leaf routine
>   */
> @@ -122,6 +123,8 @@ symbol		=	value
>  #define ASM_PRINT(string)
>  #endif
>  
> +#endif /* __ASSEMBLY__ */
> +
>  /*
>   * Stack alignment
>   */
> 
> ---
> base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
> change-id: 20240326-asm-guard-dddeb2321d69
> 
> Best regards,
> -- 
> Jiaxun Yang <jiaxun.yang@flygoat.com>

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

