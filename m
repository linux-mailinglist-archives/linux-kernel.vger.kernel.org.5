Return-Path: <linux-kernel+bounces-89733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362DE86F4D3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEDC284481
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D8F9EB;
	Sun,  3 Mar 2024 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="M4oO5JF8"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B6DDCD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468580; cv=none; b=rl5DeOFOIT4zDrKQd/n8KbsyKzGGqdZr/jXeA3oTlRcJ7rehNseDpOKKbp4a2ZMn54ZYrl5osw1GG26FOjPDnvTlmkTiDX0eQH+P7A6XmT9itTjEiqWdstaqRnUc/rKN4hb18bD8VLw5kc9x0JmGJoWZAhMxc3PeGooET1Bo7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468580; c=relaxed/simple;
	bh=4HSdjhgt89PyAQnl5dX/ZsylJZ+jxcXe7e1vtWAzq3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G684tBwRgv2Q/oJQVrNGaSjCfvRGXAVHW/c7lbBOtmuEhzLIWkveUlToBe9/f2vsCRceYMmZmDsJje9XDqN5jsbrZqtpW4fhrdPeQyXp0hjUK0JBGpxgIlMfOkPDoC+9tX79wCled+W1cbcxHXV956eDyqSfOnqhtAHtVvjh4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=M4oO5JF8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412dda84216so3299505e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709468577; x=1710073377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ou/tGaHqYVjVF6opqyGq7ns0+oqZs5ikOrwDcp0TRrU=;
        b=M4oO5JF8Ew6Q7XKnlID8lOBGJ6Jf5TTStx8UftwlY+vfYL6BoXXUjAUZxwcTUvZNOA
         h1yQX5dRoYKI8Jnkf8HdELVhbOB2CCEUS09JYK0V5/RZEaBxuC8WXXoCtFYL9QYmqekm
         lGJq0mE5vf0CrStJsG/cCzpRxIKroPSVFH/q9VNrt3sP/EWOYqs2PDOuNwPQva5kW5II
         6diTzIbU3HhE+EzpcDX+bpcCzAqx3qwUtqao0HrGchiUb/Z9m8vGTCp5lX+b/3Gxt6Z6
         YbbcqtrA8taV6CvN9f1wW5U1aJ4w1xBmNpLFnfvw78mPMnYhwxgkz2rRnIqhJdnx8ISq
         XRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709468577; x=1710073377;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ou/tGaHqYVjVF6opqyGq7ns0+oqZs5ikOrwDcp0TRrU=;
        b=RBxNnb2S0cZaRHcNuPgUtFAL+VtiRurjjePFFuq+Rjasso9SIZM2pPef70m2f3BoZ6
         rdAdCGUh4Q53OLhql/Geb5yalOEobUD3vslku/+MYzxDo88EpX3g5rG/BD1f7tiIaqhk
         FvnHdAlii3HE4e3ul9MqLvRWXxI/Wq/rlIO6Algw9JFCuOqoBMaa2AAe3fP2GqKYfWgH
         JE2xv0AHJPOk5KYhl32sU5kgzBJaM9C0GASXd/ZUR/wFO/Ya++hqAIa4P6aeoLPwX4c5
         A0tYre773LCS9IGu6FpsgCCNDdkQ9EEsECUZXNBhIx9RJiC4HcgtZsN0nJLvbyv2eS+0
         2s1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2gnVHgPNnGwHyeytlflPmNFv+z6tKdWfKBKf49ly/N+swuAIzwWAiecwN0h9GXGQcpuZ1EK75Mnzv/K+NsY+jJDaLQkHTx96+gsX3
X-Gm-Message-State: AOJu0YwvFRprC+B8H10XS3yVvC51WlWrf9FgDRs9hUWHEtHuHy930xnc
	PsEZWKv5XZBHSQdTQPpwKWuoeKiK7ncNscJI/V5saysv4YkjKTVG1BueQEPH5so=
X-Google-Smtp-Source: AGHT+IEdPxxmfyaALGdbTHOMcBwf96DPPDKyUQwf5YjWErgOforbZ/XB2j9J6MxcpbeQSzScGEGIoQ==
X-Received: by 2002:adf:ab07:0:b0:33d:2071:9b85 with SMTP id q7-20020adfab07000000b0033d20719b85mr4125139wrc.19.1709468576867;
        Sun, 03 Mar 2024 04:22:56 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id dw2-20020a0560000dc200b0033ddfba0c67sm9477927wrb.41.2024.03.03.04.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 04:22:56 -0800 (PST)
Message-ID: <5bea6d90-41bf-41ec-aa43-f7921f522d40@tuxon.dev>
Date: Sun, 3 Mar 2024 14:22:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 35/39] ARM: at91: Kconfig: add config flag for SAM9X7
 SoC
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 linux@armlinux.org.uk, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223173035.673386-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223173035.673386-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:30, Varshini Rajendran wrote:
> Add config flag for sam9x7 SoC.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> ---
> Changes in v4:
> - Updated Reviewed-by tag
> ---
>  arch/arm/mach-at91/Kconfig | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index a8c022b4c053..49d38a3a47de 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -141,11 +141,28 @@ config SOC_SAM9X60
>  	help
>  	  Select this if you are using Microchip's SAM9X60 SoC
>  
> +config SOC_SAM9X7
> +	bool "SAM9X7"
> +	depends on ARCH_MULTI_V5
> +	select ATMEL_AIC5_IRQ
> +	select ATMEL_PM if PM
> +	select ATMEL_SDRAMC

This flag doesn't exist anymore.

> +	select CPU_ARM926T
> +	select HAVE_AT91_USB_CLK
> +	select HAVE_AT91_GENERATED_CLK
> +	select HAVE_AT91_SAM9X60_PLL
> +	select MEMORY
> +	select PINCTRL_AT91
> +	select SOC_SAM_V4_V5
> +	select SRAM if PM
> +	help
> +	  Select this if you are using Microchip's SAM9X7 SoC
> +
>  comment "Clocksource driver selection"
>  
>  config ATMEL_CLOCKSOURCE_PIT
>  	bool "Periodic Interval Timer (PIT) support"
> -	depends on SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
> +	depends on SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
>  	default SOC_AT91SAM9 || SOC_SAMA5
>  	select ATMEL_PIT
>  	help
> @@ -155,7 +172,7 @@ config ATMEL_CLOCKSOURCE_PIT
>  
>  config ATMEL_CLOCKSOURCE_TCB
>  	bool "Timer Counter Blocks (TCB) support"
> -	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
> +	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
>  	select ATMEL_TCB_CLKSRC
>  	help
>  	  Select this to get a high precision clocksource based on a
> @@ -166,7 +183,7 @@ config ATMEL_CLOCKSOURCE_TCB
>  
>  config MICROCHIP_CLOCKSOURCE_PIT64B
>  	bool "64-bit Periodic Interval Timer (PIT64B) support"
> -	default SOC_SAM9X60 || SOC_SAMA7
> +	default SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA7
>  	select MICROCHIP_PIT64B
>  	help
>  	  Select this to get a high resolution clockevent (SAM9X60) or

