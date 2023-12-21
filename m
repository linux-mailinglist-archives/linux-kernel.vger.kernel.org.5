Return-Path: <linux-kernel+bounces-8596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8381B9F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27132889B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89C0539E2;
	Thu, 21 Dec 2023 14:56:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD17360B4;
	Thu, 21 Dec 2023 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rGKSr-0002PV-00; Thu, 21 Dec 2023 15:55:57 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id AD3D4C0A2B; Thu, 21 Dec 2023 15:38:20 +0100 (CET)
Date: Thu, 21 Dec 2023 15:38:20 +0100
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v5 01/22] MIPS: compressed: Use correct instruction for
 64 bit code
Message-ID: <ZYRN3FMH4od3QX+i@alpha.franken.de>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <20231212163459.1923041-2-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212163459.1923041-2-gregory.clement@bootlin.com>

On Tue, Dec 12, 2023 at 05:34:33PM +0100, Gregory CLEMENT wrote:
> The code clearing BSS already use macro or use correct instruction
> depending if the CPU is 32 bits or 64 bits. However, a few
> instructions remained 32 bits only.
> 
> By using the accurate MACRO, it is now possible to deal with memory
> address beyond 32 bits. As a side effect, when using 64bits processor,
> it also divides the loop number needed to clear the BSS by 2.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  arch/mips/boot/compressed/head.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
> index 5795d0af1e1b2..d237a834b85ee 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -25,8 +25,8 @@
>  	/* Clear BSS */
>  	PTR_LA	a0, _edata
>  	PTR_LA	a2, _end
> -1:	sw	zero, 0(a0)
> -	addiu	a0, a0, 4
> +1:	PTR_S	zero, 0(a0)
> +	PTR_ADDIU a0, a0, PTRSIZE
>  	bne	a2, a0, 1b
>  
>  	PTR_LA	a0, (.heap)	     /* heap address */
> -- 
> 2.42.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

