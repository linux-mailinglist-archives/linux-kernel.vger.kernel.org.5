Return-Path: <linux-kernel+bounces-89727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83F86F4C9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3B71F21E0A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C982C154;
	Sun,  3 Mar 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LYynhe6P"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC6C121
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468430; cv=none; b=brWbYntUFPPRNbAEIs91Ac8YDYINmmrvj2brLw+mqVZp/R1xJsZFa6z7Ae3B8XUCE6gixFPAIAeCr4FFNFKjJtasuole1Lrz5jWt4YT0bLHE86/WMFk/ow59wg1NJfb5CPI/9XS4mJXYdWyL9sw0nL5+ribh15NFNiUdIpbxyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468430; c=relaxed/simple;
	bh=Sn5vRBB3mFJVW2VsCMYvf3o0BvfgCuzWFtmmj71sy5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngfdAWL0AoPBhR9nHSOMJHEA2ptr3J10tGLidk6MSDYShkmbDa0yL8baGH89QcMZwiBe6Iz7Vx68FdAG555ByYQj73HLeP6vQ2o7P9OdnjEykmqfN4QmRA5O4jt3NAvOtLr38MSQl5ddmllRUsHnihNGiAp8z1K5Ee9jNcieUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LYynhe6P; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e1878e357so1507969f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 04:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709468427; x=1710073227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hGP8nPJ4zBlr5ATaqe7TvqsCYAUH4huvCOpVwZCWko=;
        b=LYynhe6P9tCCgj6OdN6ZJjvZaEwJqce4E7ZNGCjoxptBsUmqvoUIDvOcoeCoVcneDz
         I/lfwxcGuaCGEl5YFzTRU2EHQ56IGOfQ9mpl+iqo5zWnmqDyZWGDWfl4yXGDgW7ybHgK
         m5MounQZotxZpqHc6FWWhKr7ZO5L8T0STxOnYr19t3a2cLis6AjSX+s1ibVQKD7kJO9Z
         EN6WhdsyX1qAtwpyzt0GbYD/CQbolhFneUXCsp9Obk6ZUQ5UtpC2GW37mYBihckLqz3w
         D/HtwLJGBFhbqWwm5Ect24Cxo4qr5wLLdretvT6Qje7a1bhrEpLfnuHE+TO0B2FAT+nM
         L2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709468427; x=1710073227;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hGP8nPJ4zBlr5ATaqe7TvqsCYAUH4huvCOpVwZCWko=;
        b=oh1h4J/1U+pQ5oNl2iJbOnB+m+5yceEkKe1G0YH9MU8ino/99zcPuHPgIGlzm6Vz6j
         HaIidblHMJvqBnIbuq7k6Dz7XQ6m/zAE7kkh4ZHTimS+9ewXRcJ68T9Nts20ob2APqlQ
         z97ja47sLj3Z7acIcAKHsxzXMeec+5j7q3+oxLUAlD/gUMBPbxlSIH7k97bUTAkdUb/D
         3MHr84miznMxuUX4S1MBzGgN/dQU15EGX1cALdC6ZO+v+VQD/eTdohv+/IRfS3T6A9Ja
         fR79o0LwKaIxD4J1H/9PSqzb5AevDrmnw0PUA1FsRw16QNWgJgE2ywQD+BijGXxxd74m
         LqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDsFLt/ip6uOdSixnUjYT2thGHd0dslr8eHVtNjd8barR+lp/8EDxkgmbUjpxioZjRMqiraG5aB1xA3R2ZH1Z7FSYvrT5hzwUtBRy2
X-Gm-Message-State: AOJu0YyPd047zaipweHRth9jQkudHhLZ8d1HIBepuhXvKadWqs/kJdZl
	Eaf7D0/L0iLq57PKHULTsUpTmUJHXs/P9Ev5ZM4+Iq80IAnk/WbiaQUUGMw0A9o=
X-Google-Smtp-Source: AGHT+IHxUFsWj6NHWvt5Qu275Mx9UvgIpyd38HOLY97zj3s/XedWNG5rR47TQkP8/pApTLAr30bO7A==
X-Received: by 2002:a5d:4fcd:0:b0:33e:656:1175 with SMTP id h13-20020a5d4fcd000000b0033e06561175mr4595946wrw.63.1709468426921;
        Sun, 03 Mar 2024 04:20:26 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id dw2-20020a0560000dc200b0033ddfba0c67sm9477927wrb.41.2024.03.03.04.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 04:20:26 -0800 (PST)
Message-ID: <024581f9-b5b7-42c2-8f6f-687dc76abe23@tuxon.dev>
Date: Sun, 3 Mar 2024 14:20:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/39] ARM: at91: pm: add support for sam9x7 SoC family
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 linux@armlinux.org.uk, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172705.672488-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20240223172705.672488-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Varshini,

On 23.02.2024 19:27, Varshini Rajendran wrote:
> Add support and pm init config for sam9x7 SoC.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-at91/generic.h |  2 ++
>  arch/arm/mach-at91/pm.c      | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index 0c3960a8b3eb..acf0b3c82a30 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -12,6 +12,7 @@
>  extern void __init at91rm9200_pm_init(void);
>  extern void __init at91sam9_pm_init(void);
>  extern void __init sam9x60_pm_init(void);
> +extern void __init sam9x7_pm_init(void);
>  extern void __init sama5_pm_init(void);
>  extern void __init sama5d2_pm_init(void);
>  extern void __init sama7_pm_init(void);
> @@ -19,6 +20,7 @@ extern void __init sama7_pm_init(void);
>  static inline void __init at91rm9200_pm_init(void) { }
>  static inline void __init at91sam9_pm_init(void) { }
>  static inline void __init sam9x60_pm_init(void) { }
> +static inline void __init sam9x7_pm_init(void) { }
>  static inline void __init sama5_pm_init(void) { }
>  static inline void __init sama5d2_pm_init(void) { }
>  static inline void __init sama7_pm_init(void) { }
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 345b91dc6627..b81556387aa3 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -233,6 +233,17 @@ static const struct of_device_id sama7g5_ws_ids[] = {
>  	{ /* sentinel */ }
>  };
>  
> +static const struct of_device_id sam9x7_ws_ids[] = {
> +	{ .compatible = "microchip,sam9x60-rtc",	.data = &ws_info[1] },

microchip,sam9x7-rtc

> +	{ .compatible = "atmel,at91rm9200-ohci",	.data = &ws_info[2] },
> +	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
> +	{ .compatible = "atmel,at91sam9g45-ehci",	.data = &ws_info[2] },
> +	{ .compatible = "usb-ehci",			.data = &ws_info[2] },

These 4 are not present in the sam9x7 dtsi.

> +	{ .compatible = "microchip,sam9x60-rtt",	.data = &ws_info[4] },

microchip,sam9x7-rtt

> +	{ .compatible = "microchip,sam9x7-gem",		.data = &ws_info[5] },
> +	{ /* sentinel */ }
> +};
> +
>  static int at91_pm_config_ws(unsigned int pm_mode, bool set)
>  {
>  	const struct wakeup_source_info *wsi;
> @@ -1135,6 +1146,7 @@ static const struct of_device_id gmac_ids[] __initconst = {
>  	{ .compatible = "atmel,sama5d2-gem" },
>  	{ .compatible = "atmel,sama5d29-gem" },
>  	{ .compatible = "microchip,sama7g5-gem" },
> +	{ .compatible = "microchip,sam9x7-gem" },

AT91_PM_IOMAP(ETHC) is not in the list of any PM mode iomaps, thus, this is
not used at the moment. You can remove it and add (proper compatibles)
when needed, if any.

>  	{ },
>  };
>  
> @@ -1362,6 +1374,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
>  	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
>  	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
>  	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
> +	{ .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
>  	{ /* sentinel */ },
>  };
>  
> @@ -1499,6 +1512,28 @@ void __init sam9x60_pm_init(void)
>  	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
>  }
>  
> +void __init sam9x7_pm_init(void)
> +{
> +	static const int modes[] __initconst = {
> +		AT91_PM_STANDBY, AT91_PM_ULP0,
> +	};
> +

You can remove this blank line.

> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_SOC_SAM9X7))
> +		return;
> +
> +	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
> +	ret = at91_dt_ramc(false);
> +	if (ret)
> +		return;
> +
> +	at91_pm_init(NULL);
> +
> +	soc_pm.ws_ids = sam9x7_ws_ids;
> +	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
> +}
> +
>  void __init at91sam9_pm_init(void)
>  {
>  	int ret;

