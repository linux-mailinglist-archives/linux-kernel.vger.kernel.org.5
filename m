Return-Path: <linux-kernel+bounces-58090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C785184E12D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667081F2B887
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66335762D8;
	Thu,  8 Feb 2024 12:49:52 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363242EB1A;
	Thu,  8 Feb 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396592; cv=none; b=VK+Jl4dZL3Wb2OVurMHDOP+5ROoJApImEaE6MuGG4pRPQ/IvsXc+MRS1EQqeuVQv7roMQmG5eaMtL9ozg9etxAyh5+hg95/e99DCIWcCR4LNoxsi/IyNlJRAVkBpkacX1HGMgT1rYK0e6FeLh+/owbMMY41loTO3+z78o2gVVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396592; c=relaxed/simple;
	bh=UYSlbZmLjurXnUNDON8vfhJ+CuykhF4aVAA+Uan4bzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBI1eSoXgVupoaaOFMA+MOQREfe0UcOtDGqnbU/CJJ3jCCHI02uBgDldFcxh7BDshypd+DWhqlqsevuO78j/Ewz78InuDW3/F5xhMiswFA3NyZrxab5DhzmCB1n59q1Grd1I7ZZZytTNQLtNbtG3AKrZRQmN1F6Jsothyjra9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rY3Mr-000329-00; Thu, 08 Feb 2024 13:19:01 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id A3824C0267; Thu,  8 Feb 2024 13:14:17 +0100 (CET)
Date: Thu, 8 Feb 2024 13:14:17 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 01/14] MIPS: spaces: Define a couple of handy macros
Message-ID: <ZcTFmUtV/mzeIBTx@alpha.franken.de>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
 <20240205153503.574468-2-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205153503.574468-2-gregory.clement@bootlin.com>

On Mon, Feb 05, 2024 at 04:34:47PM +0100, Gregory CLEMENT wrote:
> Define KSEGX_SIZE to represent the size of each KSEG segment.
> 
> Introduce CKSEG0ADDR_OR_64BIT and CKSEG1ADDR_OR_64BIT to get an XPHYS
> address in 64bits and CKSEG[01]ADDR() in 32 bits mode.
> 
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  arch/mips/include/asm/addrspace.h           | 5 +++++
>  arch/mips/include/asm/mach-generic/spaces.h | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
> index 59a48c60a065c..03a5e2c8b5dc9 100644
> --- a/arch/mips/include/asm/addrspace.h
> +++ b/arch/mips/include/asm/addrspace.h
> @@ -47,6 +47,11 @@
>   */
>  #define KSEGX(a)		((_ACAST32_(a)) & _ACAST32_(0xe0000000))
>  
> +/*
> + * Gives the size of each kernel segment
> + */
> +#define KSEGX_SIZE		0x20000000

well this is the KSEG size for 32bit and defined in a common section,
so better use CSEGX_SIZE

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

