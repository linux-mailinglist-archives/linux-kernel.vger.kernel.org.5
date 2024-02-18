Return-Path: <linux-kernel+bounces-70415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A3E859775
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4309A281540
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814B16BFB5;
	Sun, 18 Feb 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RQ8gFkLv"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EC290F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708267562; cv=none; b=MYcVUA9c794dxJ8S6hSfoqxM6qLl+8TiS85vHpg78rxv9bg+ib61QmRcFjCMmLQn1w64HLIaBYzPd0Qs5nXPwzfAudpIU0l380GPY4HhYpOvEwGu4unEczlP3QqwPLbMl6w43zZ09KAH75awCw0OSvkd+qfZVAHpbIYAdYoYmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708267562; c=relaxed/simple;
	bh=wyFLzV+ri2uRUi854Yd0XA5zNEHVGKCGn+uVjUHbpjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=poZam+S8U6vgVUrs77zhezq8xZcrs0i2y0xC9zVoWMI12MxdkAh+WSH+eojnhsOQ2jIA2TCCAL6e3pAJcwHOvjy1RJj8c3YO4iKhH2NuJ3PpsxoB7tNOaHbrs7pM7FNTzp1WA0R4j7LmarM0GxEla7kznjspmfsVYgBAHx0LqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RQ8gFkLv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d32f74833so488807f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 06:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708267559; x=1708872359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFOUsdi1q/qmLzWp9P59hV2oj95gxZqgxWokouB56lM=;
        b=RQ8gFkLvgNClA1U4p3yUhFp3fpPL0/yomRg3yPuPPcb/3PCV0BIAFqpbfw316GqGU1
         f4w5JVnYxH3uHITPp2eC6cutF0pp94xdUdBQUWAAWHaol3ddxtz6IIIREVRu1KdjBp3i
         jcTrZzlDNec6p6GfrNxxQnT9nTC7lEWLfOPv19q3ERiFuIZZ9acBI1TsX8kyAUrgH7vI
         ARTZs3BuED+b2zELTapj4HRgGRfx9M3YZQcVWbwOwrMycwgJjg+8slwQLlzFK6b2o0+p
         deFOF7wAA82KfRPNPub4jIj7Ux3o6ZAqOBvl/P0dK0yln0NNRcdBUKR1yqYmJ+EijNS2
         4aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708267559; x=1708872359;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFOUsdi1q/qmLzWp9P59hV2oj95gxZqgxWokouB56lM=;
        b=dh3urmUV3lIi4Y/J4L0Jiu+ye611Kpf6XPdzIjqaQPzmL5T6nfvSqM028bsIXMYJe/
         h0VwxJOmgR5p+IyT/NUwLbjq8w94ApzQKyVohR5Y2UQp6YwCe1s7gJJL51tFjjxRGRwQ
         srfXsjmtdLd6GHDGgpU2jBxAx7ZSnyagatR6nrAYRtW4HpAzxqu0OnkqIFnmmOAqC7aK
         ZPpVlZR/IWv4lYzgLs6TyjxVKRx9J1TXIdjVv7uRS90eoQJgQ0YC97u0hFr86Uwhgtiq
         OLbs3F1jAx0dnpvcr+eSUi80VJP5IugRF6rQWE4I/6aI3BAW81MuhoXKOjrkXRoYn1+/
         Nfuw==
X-Forwarded-Encrypted: i=1; AJvYcCWgChcw8kiMTQY3MHd7DHNh9uS54hlDyZeGnOpcBPlhRagad3gIE/adcBkSwa0k1OYDBivVW/7uvPissbk3GLHJKJo4DoG9jSd3SC3U
X-Gm-Message-State: AOJu0YxiX0zScVqJIGp8vAcuRg+TxqW1SJhyb7oZJNHq3vOJDvOUxKux
	8b/JOLWgojjkRYZnMoMyRi02D5dI8PXy0LL8vNBAmq3bKyzZRZBjDEBvZbRgKbM=
X-Google-Smtp-Source: AGHT+IH6juOWUVF5mSSCBL/h8RJpoyuxR048quiTI7J9R2Og4fjno5FaI5hZzIPql6B1gykLI0etMA==
X-Received: by 2002:adf:fe0f:0:b0:33c:e35b:7a59 with SMTP id n15-20020adffe0f000000b0033ce35b7a59mr6875395wrr.48.1708267559672;
        Sun, 18 Feb 2024 06:45:59 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d4ec3000000b0033ce06c303csm7453944wrv.40.2024.02.18.06.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 06:45:59 -0800 (PST)
Message-ID: <38ae8cf6-1daf-4c36-8431-95e01fcc906f@tuxon.dev>
Date: Sun, 18 Feb 2024 16:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] ARM: dts: microchip: sama5d29_curiosity: Add
 power-supply properties for sdmmc nodes
Content-Language: en-US
To: Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240206120322.88907-1-mihai.sain@microchip.com>
 <20240206120322.88907-7-mihai.sain@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240206120322.88907-7-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.02.2024 14:03, Mihai Sain wrote:
> The sdmmc0 and sdmmc1 controllers are powered from 3.3V regulator.

Same here (for SDMMC0), according to
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/UserGuides/SAMA5D29-Curiosity-EV07R15A-Users-Guide-DS60001822.pdf

> Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.
> The sdmmc controller from SAMA5D2 MPU has support for
> IO voltage signaling/switching required by the UHS sd-card.
> In order to avoid the issues from the tuning procedure required by
> the UHS cards, keep the vqmmc at 3V3 to use the sd high-speed mode.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> index 6b02b7bcfd49..4a86597d089a 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> @@ -504,6 +504,8 @@ &sdmmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sdmmc0_default>;
>  	disable-wp;
> +	vmmc-supply = <&vdd_3v3>;
> +	vqmmc-supply = <&vdd_3v3>;
>  	status = "okay";
>  };
>  
> @@ -512,6 +514,8 @@ &sdmmc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sdmmc1_default>;
>  	disable-wp;
> +	vmmc-supply = <&vdd_3v3>;
> +	vqmmc-supply = <&vdd_3v3>;
>  	status = "okay";
>  };
>  

