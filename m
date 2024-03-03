Return-Path: <linux-kernel+bounces-89728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCD786F4CA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5571F21D87
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8AEF9EC;
	Sun,  3 Mar 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i9j3UdCw"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE1DDCD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468451; cv=none; b=ArEbw9b33WMtxki1OMY3H9qDKqAHypBO3qNkqHNzBcy0gMCljs8iT4N65dZooVnKj7dGbz5Cckg6MWFrn+hFjw8iFqFhGDjL0rIL9t1ecJeHSbNkVsGreSk3X7DmP8ziZjitht+id61xUZ7kVO7q3U5W6TdS1GmVnI2eL+BL9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468451; c=relaxed/simple;
	bh=ie061LENUD0zBdDlewZewpA9Ylp6l3STHYJtKnOroog=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PCfvoBNiBdnvKZFS+4388M9iXHgh62mX/Q5dH5nbvORLHoHJI9Gm0PmXKowupf5T3jHDafU74Tmfvi/1mUqswmLVSfaYoB7KjyU4JYQA9rM6QVV+slQThWrrcooWzWMVLDclGsgR0xn2BZKyo+j+/knccUN+WRZHyLCNajLi0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i9j3UdCw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412dda84216so3290245e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 04:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709468448; x=1710073248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vc2uBM9o+piyOkEM24AeBHy2SzwmaERQqvELLRhZ1Is=;
        b=i9j3UdCwuBfTacPKv+Zml8UipbK+A6r84OYQjEv2PNATL9kO3YjKPOcSvuGhZ7PuBE
         6Nbx0yfhXbajx81Q3UGnyyOfhDgYZ7If2QFa1SdzS8GPQOxKeQdPOyyJjK0J+tHB4wtF
         63TDmna1QDB4RND6GINQb9mQ8szd8+F7sl6SMYOoLeUjABDwR/04LQUY3uqyChSZk8cn
         ivcQ5cFWEbksi5liOGfm9n0Oa5agK5lDeO2SnWN4961EMEWj8LQFI17NDXK+aRHJ8jBL
         dxrfBWMS7mMUIxLZ1Z6mUkPFbrK5ut7xoTuBASp/KOe4/U9fr7MeZPOOLGuX6vAjl84z
         JsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709468448; x=1710073248;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vc2uBM9o+piyOkEM24AeBHy2SzwmaERQqvELLRhZ1Is=;
        b=sQSK99LDCGXjUJRcn0Bop9R35PeFzBFlJ0BOKs9kfWNZ0LnzRvAi3ZJUyveoT0Uvqz
         G9U1/9ZHC/Gt7TP2tEHLeOVUpRPH8lOLJHUo0bRbhCvwE6chtkfCw+T7+Dcx2nRF9q6O
         T6iasv1YDkiwtoH4RAa7xKwxg48Bdc66s6zgNFFzk1BEJOXZ396GHgDsqcWQU4ebvtQC
         5Q8WxLPOMnsdv6zld436kUinGeYENWxh0XRMo3WMnAD2ZpTDGUVMeVQifCLeJhQT6zve
         GE+TMIrK7A1fGUvqpaip051rKnDS/yYivzchv1iQAEQ9TUIfwX5++s683kVYQ0a5UBva
         I8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXPuhYv+igK/QwjVxd3RyCn7D+u1o1rdexnJ5z+rRH8hgNUXGzu0e8zg3dT7BPXWtLomeapYjkEHN3dpjujyrmyJED8QeoYkjRGtPbN
X-Gm-Message-State: AOJu0YwqTvOm2sQ3XHAcJG8r6me8C7fCzr4LstDkrwcyGXxM8rSzg/fC
	12zuwXfzvMPVVZ9GIHJlZdX08//cUOdbhRApLUxRgB0QUK5tu6kB1FZkMy5We9gUZ15dNv5ftdi
	6
X-Google-Smtp-Source: AGHT+IHLZ4QWY38Lf8oPCRxwk+l+R/Eh0/ewB5WuOQhn76FiE8GJwjR/nN3XAQGqIy5nmomYs3q1Rw==
X-Received: by 2002:a5d:4ad2:0:b0:33d:8751:2288 with SMTP id y18-20020a5d4ad2000000b0033d87512288mr4684524wrs.13.1709468447558;
        Sun, 03 Mar 2024 04:20:47 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id dw2-20020a0560000dc200b0033ddfba0c67sm9477927wrb.41.2024.03.03.04.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 04:20:47 -0800 (PST)
Message-ID: <824558b5-f83a-40f6-8ae7-bc38051d4058@tuxon.dev>
Date: Sun, 3 Mar 2024 14:20:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/39] ARM: at91: pm: add sam9x7 SoC init config
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 linux@armlinux.org.uk, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172713.672537-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223172713.672537-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:27, Varshini Rajendran wrote:
> Add SoC init config for sam9x7 family.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  arch/arm/mach-at91/Makefile |  1 +
>  arch/arm/mach-at91/sam9x7.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 arch/arm/mach-at91/sam9x7.c
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 794bd12ab0a8..7d8a7bc44e65 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
>  obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
>  obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
> +obj-$(CONFIG_SOC_SAM9X7)	+= sam9x7.o
>  obj-$(CONFIG_SOC_SAMA5)		+= sama5.o sam_secure.o
>  obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
>  obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
> diff --git a/arch/arm/mach-at91/sam9x7.c b/arch/arm/mach-at91/sam9x7.c
> new file mode 100644
> index 000000000000..d998fb327860
> --- /dev/null
> +++ b/arch/arm/mach-at91/sam9x7.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Setup code for SAM9X7.
> + *
> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/system_misc.h>

This one could be removed.

> +
> +#include "generic.h"
> +
> +static void __init sam9x7_init(void)
> +{
> +	of_platform_default_populate(NULL, NULL, NULL);
> +
> +	sam9x7_pm_init();
> +}
> +
> +static const char *const sam9x7_dt_board_compat[] __initconst = {

you can add a space after * for clarity, e.g.:

static const char * const sam9x7_dt_board_compat[] __initconst = {

> +	"microchip,sam9x7",
> +	NULL
> +};
> +
> +DT_MACHINE_START(sam9x7_dt, "Microchip SAM9X7")
> +	/* Maintainer: Microchip */
> +	.init_machine	= sam9x7_init,
> +	.dt_compat	= sam9x7_dt_board_compat,
> +MACHINE_END

