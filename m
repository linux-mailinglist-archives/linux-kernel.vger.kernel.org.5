Return-Path: <linux-kernel+bounces-70414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5CA859774
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6D21C208CC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B12D6BFB3;
	Sun, 18 Feb 2024 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WV1nVZWE"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA7C1E535
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708267545; cv=none; b=Pg6J8TW6I8waLLqFbDmaHb/lVEz7iz0EfGznqKeqH+IrqPHsNoKzRCj6VUahgjxPTRQ8JBmWgqFoGazv0sFqyn8u7qlm11HqIHf25OUu0hT43IWP3R20C8bSb5JbOsRlXcZIp1i0aYhP9HsgpL5fEaYoPwHtblY4D9O/JmVlLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708267545; c=relaxed/simple;
	bh=yIDkTtx9RVSoUsvPQmKTkP7pTyCPq17T0cDn2ADBGsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GHYKDzPn0HU20g+xl6uwsF5p/xEHAFxgFLBgeZigL9QOfQZVkIRojo9vTBE8/lAVmk27+uco85kj725HNyFZ9bQaMlDBXN8iZSHly9krtW/RxwQ+D10yYVn4Acvr0SJ2kZlUtTAnasFc7iYw6n0rADRDSvkyoUtf1iOApcEzSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WV1nVZWE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so1916199f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 06:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708267542; x=1708872342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTHSXd8Sr1XB4EP/AH61MHY8vs5XT3VAgaFFnPg74g8=;
        b=WV1nVZWECI6tGv30cevPLtofaEeTbR5WpFmhz5/+JEmiBxEUaLhWP8Pezxy8zrLoch
         8wO/zJwXqeYeNgVaFE3uOciDQa4gk8avwzWAryngi+hpDMHPjnUKazb15eM83nqawOqb
         /DI4O6a+b8rXRknlwKQBcmzMz0YWp03aiHRM/IpqiBjAmzOVxvsNgTf+XrzmttDibmks
         tAvRAcEMiSTMfvW5PoLTKf40UiEl5cioIBodREx4n1u2/Fxsmu45s4gyh460maT1pOpn
         N4tQN1x8cLUhhC8PvJQcPcQwTyEH7kxFW+5g3g0SasCgJ2+cc7mg4WtFenVMPvsFkj4u
         uN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708267542; x=1708872342;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTHSXd8Sr1XB4EP/AH61MHY8vs5XT3VAgaFFnPg74g8=;
        b=R+vEeMg2OzgEmDOZFRUXZPhcjMgyV6D9830YinclTkRXt8pkR5EN2fng+3lvBs//YG
         SqzsuXy2E8ZsIUmfhVBy0Bu7mtcW0LBDqebe1qb5FhO7w6hhEEybYAuNxgOODaJ5HHQa
         qXlTIVTQeD6aJaFFBaADIKk6+4Qt9hO3gWhPy7lYWTBaUjIMBZ23RdaZY9RmuvozQLbr
         GvRDJzyDwzJTBjJGt4fah2k8hGm489XRqTN9Awxw59xU6ny5VMty17dys/Zs+b1G0ewB
         +Gm6terdRbY+tnvFztg3AGnM85Fb1MwoH461WVLRk2Gm1oEa/TxjfQapZoohK2y03TxG
         OhUA==
X-Forwarded-Encrypted: i=1; AJvYcCW4BcV6NMlIRcQTB1oIVLt8XN/CVOg+Tgqp2nMj4I9tEnMuIak9ReNwzu3Nq7guoblQ+G/SuoMG9C6/nWVxuA0TdNwlntHofdVsdEJn
X-Gm-Message-State: AOJu0Yz1oiWVXLCcaxPntVnGte4NgTUoDnq6RHrjazowlH7dnHQfqdIG
	FFVnElCBcnXGfdHu+16vnc4ALw5BnTWS4wDXtrs+lhxmelUDqLEG2oEHKkaXlGo=
X-Google-Smtp-Source: AGHT+IHBHpp1lfwvyBS3L4upY43mkbFCMLr9PLEgtpXuyBPUTH81W1N5uyRiW53YqIu0pHD0MuEzbA==
X-Received: by 2002:a05:6000:188f:b0:33d:1d45:1a55 with SMTP id a15-20020a056000188f00b0033d1d451a55mr5809371wri.8.1708267541918;
        Sun, 18 Feb 2024 06:45:41 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d4ec3000000b0033ce06c303csm7453944wrv.40.2024.02.18.06.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 06:45:41 -0800 (PST)
Message-ID: <c7486f71-56ef-4ba8-9764-54245d906958@tuxon.dev>
Date: Sun, 18 Feb 2024 16:45:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] ARM: dts: microchip: sama5d27_wlsom1_ek: Add
 power-supply property for sdmmc0 node
Content-Language: en-US
To: Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240206120322.88907-1-mihai.sain@microchip.com>
 <20240206120322.88907-6-mihai.sain@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240206120322.88907-6-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.02.2024 14:03, Mihai Sain wrote:
> The sdmmc0 controller is powered from 3.3V regulator.

Same here. SDMMC0 data lines are powered by VDDSDHC which could be 1v8/3v3.

[1]
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/UserGuides/SAMA5D2-Wireless-SOM1-Kit-User%27s-Guide-50002931d.pdf

> Add vmmc-supply and vqmmc-supply properties to sdmmc0 node.
> The sdmmc controller from SAMA5D2 MPU has support for
> IO voltage signaling/switching required by the UHS sd-card.
> In order to avoid the issues from the tuning procedure required by
> the UHS cards, keep the vqmmc at 3V3 to use the sd high-speed mode.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
> index 15239834d886..7b36e1970bb7 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
> @@ -199,6 +199,8 @@ &sdmmc0 {
>  	bus-width = <4>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sdmmc0_default>;
> +	vmmc-supply = <&vdd_3v3>;
> +	vqmmc-supply = <&vdd_3v3>;
>  	status = "okay";
>  };
>  

