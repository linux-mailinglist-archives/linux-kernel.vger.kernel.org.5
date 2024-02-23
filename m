Return-Path: <linux-kernel+bounces-78332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6742861206
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD28B23DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE737D418;
	Fri, 23 Feb 2024 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="B04g03eJ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373871097D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692970; cv=none; b=hygEeYtMqsAGbsdjkxuEM1MsFpcYOFqFNZGvfkuzz+i0JtewPBk3PjNyaxqV/43sw8VpN+rCdEVG7o8+mEqbeGoXDrnBk8kGtOMTjBRTtoI+jQkyqk5ErKLeG0wt3Q6q1yv+4xnDrftWiPqHUKR31lN+M1LJ5wZa6c8iburCJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692970; c=relaxed/simple;
	bh=9WxyGLInQ3+YuB9kRb+g/z8l++WsWG2igx2CN6r29RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mn9TS+Q8+zzQDqTFlZZc4hK5tSOteXGfaYd7zWkYxqOpTo3ym7elDhlwFdOOnjZnXVd9v4KPaotEG7q3FnjDrCEP7yot7UHLvrUmuyeKVuUpLq2Qc0r4ixtSPgLQAAL4H49/JxjobuR8M1Zd5KQ90/EXQv/4Qsn8H1vRZkk7JbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=B04g03eJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5654621d62dso780530a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708692966; x=1709297766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUZL8CRCk1GBYfD5pXoX8ZuzGzgzEHs69yLAocERd8Q=;
        b=B04g03eJYgr4T7Bf7cU3FA80u+v5XMOMrinfq/457CEUFzEDIVWC8vDc4PHfUFnqM4
         Y2A4GrImw6ufNqDp8h5M3zcI2KYTWcTg//WlZzwJMOqq7jYysLg/Kolkxp+2gMDPlnYy
         Baq9HQMYZg12ZbTyxrg9WxDRGJBJJulXoRNN+Ld9cd0nyc4Dh3UuOyLBQfrMJE5FXgmN
         lGdrEoTMaGwYwjabW6Y/zJ2MrFeTDRo46jz4ckfaLJrNKObQp+VMxVi8M9qTm7E+URDz
         jxjGNRdNE/AsmiYLu8VoNWttjTarHZQqb7vmlFMg7pAlf+LSoEamoJnx8AJJqacWFziQ
         4Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708692966; x=1709297766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUZL8CRCk1GBYfD5pXoX8ZuzGzgzEHs69yLAocERd8Q=;
        b=iJZjuRjzikOH09pv9Ya7b0V7JopcvcfLTm85PdoRi+Qycqlu+FwwcDzQxTANrmAVY7
         BYwejIm9dsI+eSJDV5C0w5nBrbObaBI75/+zW4UVJT12l/f8LCDKAstzo6ClNAVh8sl/
         ER82p6saoMPeHXhqbKphHGV73hFCGOFxZfIl0Nfvpi/suE3SqzXHujjOISU0Av9RItR3
         BqeYrmzxBpAJP8EYvRL5395n2lTvyTt0YqIEWmXjbm9WzzIM8kS8RHDmyaT7AgmNxcL2
         NPFZ/S+wF9r2VIuKXToieoR4qAHKMSSqn6pl/gzPsH60oBN+p+Pm1+hfDxWu+Cmqtf1p
         0euQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNmZQVKKtedmd0FjM3oQjklFnJgk0d8BQypGU+5PNozsWzYqqBwxEtbFP6Lg6tBLqLGXQquhcZACzSIbEr1U+uNM2bQL1RZeJzFJfn
X-Gm-Message-State: AOJu0Yw/h1K5xfprl+fJ7XqsKpGUp088u3ZOy/bal6y+snG06/t3un4h
	6as+FFtA2eAsyx8HPHQqbcPT1ek500zm7+bnDG+9mHad0PT5QdJZlszLORD8b+8=
X-Google-Smtp-Source: AGHT+IEBxqrq/uM9YGzHqm8hnB8YTe/HM75AdxogZRRxZMYLQxSBRuY8Nkl0XdQyWscyjUUe6IiScQ==
X-Received: by 2002:a17:906:b2d5:b0:a3f:c6f1:24d with SMTP id cf21-20020a170906b2d500b00a3fc6f1024dmr1117832ejb.25.1708692966275;
        Fri, 23 Feb 2024 04:56:06 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.99])
        by smtp.gmail.com with ESMTPSA id rs6-20020a170907890600b00a3e43b7e7b4sm6167282ejc.143.2024.02.23.04.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 04:56:05 -0800 (PST)
Message-ID: <2063e4a0-4287-4b02-b7d1-d762c4a69966@tuxon.dev>
Date: Fri, 23 Feb 2024 14:56:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ARM: dts: microchip: sama7g5: add sama7g5
 compatible
Content-Language: en-US
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-b4-sama5d2-flexcom-yaml-v2-0-7e96c60c7701@microchip.com>
 <20240223-b4-sama5d2-flexcom-yaml-v2-1-7e96c60c7701@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223-b4-sama5d2-flexcom-yaml-v2-1-7e96c60c7701@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Balakrishnan,

On 23.02.2024 11:16, Balakrishnan Sambath wrote:
> Add sama7g5 flexcom specific compatible in DT with fallbacks.

Can you also take care of lan966x and sam9x60?

Thank you,
Claudiu Beznea

> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/sama7g5.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
> index 269e0a3ca269..6496a4ca376f 100644
> --- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
> @@ -698,7 +698,7 @@ sha: crypto@e1814000 {
>  		};
>  
>  		flx0: flexcom@e1818000 {
> -			compatible = "atmel,sama5d2-flexcom";
> +			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
>  			reg = <0xe1818000 0x200>;
>  			clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
>  			#address-cells = <1>;
> @@ -723,7 +723,7 @@ uart0: serial@200 {
>  		};
>  
>  		flx1: flexcom@e181c000 {
> -			compatible = "atmel,sama5d2-flexcom";
> +			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
>  			reg = <0xe181c000 0x200>;
>  			clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
>  			#address-cells = <1>;
> @@ -747,7 +747,7 @@ i2c1: i2c@600 {
>  		};
>  
>  		flx3: flexcom@e1824000 {
> -			compatible = "atmel,sama5d2-flexcom";
> +			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
>  			reg = <0xe1824000 0x200>;
>  			clocks = <&pmc PMC_TYPE_PERIPHERAL 41>;
>  			#address-cells = <1>;
> @@ -791,7 +791,7 @@ tdes: crypto@e2014000 {
>  		};
>  
>  		flx4: flexcom@e2018000 {
> -			compatible = "atmel,sama5d2-flexcom";
> +			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
>  			reg = <0xe2018000 0x200>;
>  			clocks = <&pmc PMC_TYPE_PERIPHERAL 42>;
>  			#address-cells = <1>;
> @@ -817,7 +817,7 @@ uart4: serial@200 {
>  		};
>  
>  		flx7: flexcom@e2024000 {
> -			compatible = "atmel,sama5d2-flexcom";
> +			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
>  			reg = <0xe2024000 0x200>;
>  			clocks = <&pmc PMC_TYPE_PERIPHERAL 45>;
>  			#address-cells = <1>;
> @@ -911,7 +911,7 @@ tcb0: timer@e2814000 {
>  		};
>  
>  		flx8: flexcom@e2818000 {
> -			compatible = "atmel,sama5d2-flexcom";
> +			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
>  			reg = <0xe2818000 0x200>;
>  			clocks = <&pmc PMC_TYPE_PERIPHERAL 46>;
>  			#address-cells = <1>;
> @@ -935,7 +935,7 @@ i2c8: i2c@600 {
>  		};
>  
>  		flx9: flexcom@e281c000 {
> -			compatible = "atmel,sama5d2-flexcom";
> +			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
>  			reg = <0xe281c000 0x200>;
>  			clocks = <&pmc PMC_TYPE_PERIPHERAL 47>;
>  			#address-cells = <1>;
> @@ -959,7 +959,7 @@ i2c9: i2c@600 {
>  		};
>  
>  		flx11: flexcom@e2824000 {
> -			compatible = "atmel,sama5d2-flexcom";
> +			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
>  			reg = <0xe2824000 0x200>;
>  			clocks = <&pmc PMC_TYPE_PERIPHERAL 49>;
>  			#address-cells = <1>;
> 

