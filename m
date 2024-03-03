Return-Path: <linux-kernel+bounces-89729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BBC86F4CB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C11F21DFF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B0A10A01;
	Sun,  3 Mar 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="C6reyuFr"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6815101C1
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468476; cv=none; b=unDTdqyY7wM5hI9UltTRcU6rOd2aBF8PsRE2NhyZqUVja+NT8bY9aq0jLycfq69ofpahS6cfFG0roQxycohUYsIn26TQ0kKcK9E8YtD+OJN1mCwWkt7mdsF9nJgSShP2laco//EdRrS2Ted1QSHVov/Z/H3sglKch+KILh7z7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468476; c=relaxed/simple;
	bh=+AjCBkW4gkpvH/e2j2T2ltEFC1H/go0g9gAg46E/NBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CU1KIDUM94WoqGnuRVO1Fm7gt9YLDRubq4Wi18LrPeKyRFS0h80657N9H0T2e88bmq6Pp5hnlslQkjo/GHCF2HVxetVATGDz8n7mzgYqTnK1ZicKJcePniSrVjStrVG7s7aMcoDRYBRG4zxaq5qwT2F9rrcAzJD1kCYx6odZeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=C6reyuFr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e1207bba1so2731754f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 04:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709468473; x=1710073273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDnEAy0pAbQJrgpo4wTbJR5x2HUNb3fFgJPTxRDHJ8w=;
        b=C6reyuFrOKzJKbFVIdJVgGbZQCPjSSU+dnPZRXX4goo9fAE4HnUmmbbBkCc1bYFYYM
         6K2wnqaRbPN/182Vbbkm5aUpbryuQ0Dt1Lpucgco2OkHovEFjGwjIernpmIF3JI27PeU
         QR1VU41ADBV/Q+T3co02D0jfnEypfWEOQMj1Jzvj3AjZY9tcKcuLYTwRF9djMXvgBXOo
         SUK8EV5wnjOqpLPfWlp0N8uuqzq9dQtPGz1BsdwowvZt16TWuNP5qqGgpuWVF6obVZXf
         WZF00kAnDd6Ch9iOYRc/L9z/X1n1aDpWneHq0PiaUi0dQ2YollP/MexdFOic8rkE4VV4
         JARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709468473; x=1710073273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDnEAy0pAbQJrgpo4wTbJR5x2HUNb3fFgJPTxRDHJ8w=;
        b=qLxFWdRCN/kqAV0z+x1OYSG2vwqpCReO7xYTMXwfld8c95BbMy42bEjn6LEnLd6KSn
         E7Oz5ckAp6uJScuKvofOT0/p1sIxBniAqvnKoBGtqLCBpwCdlGsdHwYppVuW+bfukdLU
         XNcWRni8iYmmCFqqzCqEUVG9pXmpkxfTIOV7ndDH+XoUsFGzZChMk5i7xFvfjIzPkrKD
         xhGKiPlRtL2B2hzY3xpBNiYa3bEQfkQ/lzKLaF3UUUh5gKyuRjYo6ZDjEEGmP/Nt0zdS
         CynBJ4HkOvBd85pG02sHfOsgH8RaplUY4ci4O0GNdKHORDpfptGbyhXm2Ytnh3bKr0s7
         WuZg==
X-Forwarded-Encrypted: i=1; AJvYcCWFAS/FqimC+8R/Q3C5AUyfWiLLMxjzS46ObaKm/WckylFdQUXPLAUtXFoaXIn2cmRadcrCAUlUVo/JyUlJDaLDz0D3GL7+IIK4ckBq
X-Gm-Message-State: AOJu0Yx7llpj7dPvsT7vv0Sxrioeul+T/8kE/AbHnQZe3xP0j0nVuND9
	qquMGFe7b2HBwt8jFIl8FuTFVoj/OLfq9aR2UpNE/hsfhO1NBAzG2NPEUDsOtAA=
X-Google-Smtp-Source: AGHT+IGKoczi43rEP+/na2g7kDMMbjQH9azs0dGCmXX9wN3QD0VbMk1T6oRuaWKht+wVBisq27bEDg==
X-Received: by 2002:a5d:6283:0:b0:33d:1153:f41a with SMTP id k3-20020a5d6283000000b0033d1153f41amr3810677wru.20.1709468473077;
        Sun, 03 Mar 2024 04:21:13 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id dw2-20020a0560000dc200b0033ddfba0c67sm9477927wrb.41.2024.03.03.04.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 04:21:12 -0800 (PST)
Message-ID: <ec00b007-a521-46a1-9b9e-1bd138b46522@tuxon.dev>
Date: Sun, 3 Mar 2024 14:21:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/39] ARM: at91: add support in SoC driver for new
 sam9x7
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172722.672592-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223172722.672592-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:27, Varshini Rajendran wrote:
> Add support for SAM9X7 SoC in the SoC driver.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> Changes in v4:
> - Sorted the entries alphabetically as per comment from Claudiu
> - Updated EXID
> Note: Did not remove the Reviewed-by tag since the changes were only
> cosmetic and did not affect functionality
> ---
>  drivers/soc/atmel/soc.c | 23 +++++++++++++++++++++++
>  drivers/soc/atmel/soc.h |  9 +++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> index cc9a3e107479..cae3452cbc60 100644
> --- a/drivers/soc/atmel/soc.c
> +++ b/drivers/soc/atmel/soc.c
> @@ -101,6 +101,29 @@ static const struct at91_soc socs[] __initconst = {
>  		 AT91_CIDR_VERSION_MASK, SAM9X60_D6K_EXID_MATCH,
>  		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
>  #endif
> +#ifdef CONFIG_SOC_SAM9X7
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X72_EXID_MATCH,
> +		 "sam9x72", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X70_EXID_MATCH,
> +		 "sam9x70", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1G_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 1Gb DDR3L SiP ", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 512Mb DDR2 SiP", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 128Mb DDR2 SiP", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 2Gb DDR3L SiP", "sam9x7"),

Could you keep these sorted after SoC name and memory size? E.g. see
sama7g5 entries, sama5dX entries.

> +#endif
>  #ifdef CONFIG_SOC_SAMA5
>  	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>  		 AT91_CIDR_VERSION_MASK, SAMA5D21CU_EXID_MATCH,
> diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
> index 7a9f47ce85fb..fc4157c5f6e3 100644
> --- a/drivers/soc/atmel/soc.h
> +++ b/drivers/soc/atmel/soc.h
> @@ -44,6 +44,7 @@ at91_soc_init(const struct at91_soc *socs);
>  #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
>  #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
>  #define SAM9X60_CIDR_MATCH		0x019b35a0
> +#define SAM9X7_CIDR_MATCH		0x09750020
>  #define SAMA7G5_CIDR_MATCH		0x00162100
>  
>  #define AT91SAM9M11_EXID_MATCH		0x00000001
> @@ -74,6 +75,14 @@ at91_soc_init(const struct at91_soc *socs);
>  #define SAMA7G54_D2G_EXID_MATCH		0x00000020
>  #define SAMA7G54_D4G_EXID_MATCH		0x00000028
>  
> +#define SAM9X70_EXID_MATCH		0x00000005
> +#define SAM9X72_EXID_MATCH		0x00000004
> +#define SAM9X75_D1G_EXID_MATCH		0x00000018
> +#define SAM9X75_D2G_EXID_MATCH		0x00000020
> +#define SAM9X75_D1M_EXID_MATCH		0x00000003
> +#define SAM9X75_D5M_EXID_MATCH		0x00000010
> +#define SAM9X75_EXID_MATCH		0x00000000

Could you keep this chunk after SAM9X60_* one to have some kind of
alphanumerical sort?

> +
>  #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
>  #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
>  #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0

