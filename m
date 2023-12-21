Return-Path: <linux-kernel+bounces-8659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC0281BAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6825528D4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4259930;
	Thu, 21 Dec 2023 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PVVrDZW8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF662812;
	Thu, 21 Dec 2023 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DF4A1C0008;
	Thu, 21 Dec 2023 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703172364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnimU0svkWDNRKLCz0ZHPlRmfQ2Z7rDvpCfZmcxrsRA=;
	b=PVVrDZW8xJ8POwGPVj8PmC3/ImUj1UkPGA2n10kyjrVPwnsbr49JHOiasX5HibWVMGoPVD
	Dp8D1cj2DYgjaGFsv3bUuEsUjLpT5yskbduq7VJ+NeiKYiVxKZJmoAhhkeulSd0729r2Dg
	/nPjzT+NiDc9HznVjwzGGrNng9opes3zrTD3f972m0kq+dTQcD0qq43P+WtShk0eBKZB5x
	lZzwS7JwMHBSNEMg3jMVoOpnOKjF4sxmUlnwSt3HK4L4IZipz0V4QBy/GmHEg4ShUTnwdV
	xAT7a3nzHojAC1XjgJgY+Lg5zxdso+Il1ydaz0DrQG+x7eLxWBd2EpwO9C3V4A==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Tawfik Bayouk
 <tawfik.bayouk@mobileye.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 00/22] Add support for the Mobileye EyeQ5 SoC
In-Reply-To: <ZYRR7zIZax7yUgsZ@alpha.franken.de>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <878r5vctdg.fsf@BL-laptop> <ZYNhbQjMbAH6I0kI@alpha.franken.de>
 <87frzwasxo.fsf@BL-laptop> <ZYRR7zIZax7yUgsZ@alpha.franken.de>
Date: Thu, 21 Dec 2023 16:26:02 +0100
Message-ID: <87a5q3bmr9.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Thomas Bogendoerfer <tsbogend@alpha.franken.de> writes:

> On Thu, Dec 21, 2023 at 08:57:55AM +0100, Gregory CLEMENT wrote:
>> I do not oppose the addition of a new platform, even though, like
>> Jiaxun, I would prefer to avoid duplicating code. The only thing
>> preventing the use of the same kernel for EyeQ5 and other platforms is
>> the starting address.
>
> there shouldn't be code duplication.
>
> My rough idea would be something like

Thanks for the feedback, I am going to test it.

>
> diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
> index af2967bffb73..d683993ed331 100644
> --- a/arch/mips/Kbuild
> +++ b/arch/mips/Kbuild
> @@ -17,6 +17,7 @@ obj- := $(platform-y)
>  # mips object files
>  # The object files are linked as core-y files would be linked
>  
> +obj-y += generic/
>  obj-y += kernel/
>  obj-y += mm/
>  obj-y += net/
> diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
> index e37a59bae0a6..56011d738441 100644
> --- a/arch/mips/generic/Makefile
> +++ b/arch/mips/generic/Makefile
> @@ -4,9 +4,9 @@
>  # Author: Paul Burton <paul.burton@mips.com>
>  #
>  
> -obj-y += init.o
> -obj-y += irq.o
> -obj-y += proc.o
> +obj-$(CONFIG_MACH_GENERIC_CORE) += init.o
> +obj-$(CONFIG_MACH_GENERIC_CORE) += irq.o
> +obj-$(CONFIG_MACH_GENERIC_CORE) += proc.o
>  
>  obj-$(CONFIG_YAMON_DT_SHIM)            += yamon-dt.o
>  obj-$(CONFIG_LEGACY_BOARD_SEAD3)       += board-sead3.o
>
> so everyboady needing these parts of a generic kernel is able
> to take it.
>
>> Therefore, if it were possible to have a relocatable kernel, this
>> issue would disappear.
>
> yes. There is support for relocatable kernel, so what are we missing
> there ?

But in arch/mips/generic/Platform we have:

load-$(CONFIG_MIPS_GENERIC)    += 0xffffffff80100000

So, the load address is defined during compilation; for example, I don't
think there is such a mechanism currently for ARM. hat's what I mean by
'relocatable,' but perhaps it's not exactly what you have in mind.

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

