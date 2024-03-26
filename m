Return-Path: <linux-kernel+bounces-118358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBCC88B977
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2502A1F3E289
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFEE5D758;
	Tue, 26 Mar 2024 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="RqZXpf/X"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714533FD;
	Tue, 26 Mar 2024 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711427784; cv=none; b=aF6Q/yE+SnYJZqRE7EfAWygyJhdmo+xD+8lvabcujkxHLPbyqfKkF8Hxcr+ylglZk/qxiLrqN3Zpe858g7+D01PQRiYbjrSlMOpm77qPK+3zaMnZKPs4o9ncBcGt72OaYhCTKEmJtUwO2pJrqcBIs3ti/aH+UCeqFpSL0MjDMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711427784; c=relaxed/simple;
	bh=ZEC6sKLqIkQccXzPYnYYsEVVK+HsHTS1ecytu2JLpc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TsDDNl1kjTFJc1Q5QQrHoItqav8Rmj31SDWrBO/0gWuegwS+zebwXZq/iUTcJ9qL7KFpXP5JQSN5RiHOQyx4YZKkNEOGBxvTXtA4tqyaqDyDgY6xADh5LSBBnnSKVF3eEbPN6Tm4/c3pHQaEws9V8XBPMn0TAE2WwGHEbf/L1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=RqZXpf/X; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1711427777;
	bh=8i9XYJmK9q6diP6s8+fki5DH3YDE5cf+HG71ptTgJww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RqZXpf/XEd2DQAqrOAyyChkhsjN//XvytOil84PZUBgXY9hHzNFAingFLe+BzFt1D
	 yzyVzmKOX+Kt6a+hPcLuArO2y2NergxLFpXS77YUvJR4lLL1LivI6SKbwzb10m1zPI
	 dzZPX1mmpV6RxURztJaSB5iozDy4hcyKXpTf4LKEBzZt6iwsv2dg1HmMvii8vYbB/e
	 xtPekiVoy/r7O8YSoD4F4JIctNxctthxieEB1ZyJCIheJsq4WhpVrndODbUAi4JTMm
	 2RVG3sVom+hHcVwPJZ3AzC86fa/HtO54MHFAEB/9tMJ6DSvB2l5oJy5PpYq4h5pyuL
	 R2JrEYHzgZDGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3cSd4DgDz4wcs;
	Tue, 26 Mar 2024 15:36:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Geoff Levand <geoff@infradead.org>,
 Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 430/638] powerpc/ps3: Fix lv1 hcall assembly for
 ELFv2 calling convention
In-Reply-To: <20240324230116.1348576-431-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
 <20240324230116.1348576-431-sashal@kernel.org>
Date: Tue, 26 Mar 2024 15:36:15 +1100
Message-ID: <87wmppip8g.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sasha Levin <sashal@kernel.org> writes:
> From: Nicholas Piggin <npiggin@gmail.com>
>
> [ Upstream commit 6735fef14c1f089ae43fd6d43add818b7ff682a8 ]
>
> Stack-passed parameters begin at a different offset in the caller's
> stack in the ELFv2 ABI.
>
> Reported-by: Geoff Levand <geoff@infradead.org>
> Fixes: 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian builds")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Tested-by: Geoff Levand <geoff@infradead.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://msgid.link/20231227072405.63751-2-npiggin@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/powerpc/include/asm/ppc_asm.h  |  6 ++++--
>  arch/powerpc/platforms/ps3/hvcall.S | 18 +++++++++---------
>  2 files changed, 13 insertions(+), 11 deletions(-)

This commit is OK on its own, but it doesn't have any effect unless the
full series up to 914d081ead11 ("Revert "powerpc/ps3_defconfig: Disable
PPC64_BIG_ENDIAN_ELF_ABI_V2"") is backported.

I don't think the full series warrants backporting, it's really enabling
a new feature (ELFv2 build for ps3).

So IMHO please drop this patch from 6.6, 6.7, 6.8.

cheers

> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index e7792aa135105..041ee25955205 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -201,11 +201,13 @@
>  
>  #ifdef CONFIG_PPC64_ELF_ABI_V2
>  #define STK_GOT		24
> -#define __STK_PARAM(i)	(32 + ((i)-3)*8)
> +#define STK_PARAM_AREA	32
>  #else
>  #define STK_GOT		40
> -#define __STK_PARAM(i)	(48 + ((i)-3)*8)
> +#define STK_PARAM_AREA	48
>  #endif
> +
> +#define __STK_PARAM(i)	(STK_PARAM_AREA + ((i)-3)*8)
>  #define STK_PARAM(i)	__STK_PARAM(__REG_##i)
>  
>  #ifdef CONFIG_PPC64_ELF_ABI_V2
> diff --git a/arch/powerpc/platforms/ps3/hvcall.S b/arch/powerpc/platforms/ps3/hvcall.S
> index 509e30ad01bb4..59ea569debf47 100644
> --- a/arch/powerpc/platforms/ps3/hvcall.S
> +++ b/arch/powerpc/platforms/ps3/hvcall.S
> @@ -714,7 +714,7 @@ _GLOBAL(_##API_NAME)				\
>  	std	r4, 0(r11);			\
>  	ld	r11, -16(r1);			\
>  	std	r5, 0(r11);			\
> -	ld	r11, 48+8*8(r1);		\
> +	ld	r11, STK_PARAM_AREA+8*8(r1);	\
>  	std	r6, 0(r11);			\
>  						\
>  	ld	r0, 16(r1);			\
> @@ -746,22 +746,22 @@ _GLOBAL(_##API_NAME)				\
>  	mflr	r0;				\
>  	std	r0, 16(r1);			\
>  						\
> -	std	r10, 48+8*7(r1);		\
> +	std	r10, STK_PARAM_AREA+8*7(r1);	\
>  						\
>  	li	r11, API_NUMBER;		\
>  	lv1call;				\
>  						\
> -	ld	r11, 48+8*7(r1);		\
> +	ld	r11, STK_PARAM_AREA+8*7(r1);	\
>  	std	r4, 0(r11);			\
> -	ld	r11, 48+8*8(r1);		\
> +	ld	r11, STK_PARAM_AREA+8*8(r1);	\
>  	std	r5, 0(r11);			\
> -	ld	r11, 48+8*9(r1);		\
> +	ld	r11, STK_PARAM_AREA+8*9(r1);	\
>  	std	r6, 0(r11);			\
> -	ld	r11, 48+8*10(r1);		\
> +	ld	r11, STK_PARAM_AREA+8*10(r1);	\
>  	std	r7, 0(r11);			\
> -	ld	r11, 48+8*11(r1);		\
> +	ld	r11, STK_PARAM_AREA+8*11(r1);	\
>  	std	r8, 0(r11);			\
> -	ld	r11, 48+8*12(r1);		\
> +	ld	r11, STK_PARAM_AREA+8*12(r1);	\
>  	std	r9, 0(r11);			\
>  						\
>  	ld	r0, 16(r1);			\
> @@ -777,7 +777,7 @@ _GLOBAL(_##API_NAME)				\
>  	li      r11, API_NUMBER;		\
>  	lv1call;				\
>  						\
> -	ld	r11, 48+8*8(r1);		\
> +	ld	r11, STK_PARAM_AREA+8*8(r1);	\
>  	std	r4, 0(r11);			\
>  						\
>  	ld	r0, 16(r1);			\
> -- 
> 2.43.0

