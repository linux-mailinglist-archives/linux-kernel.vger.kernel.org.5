Return-Path: <linux-kernel+bounces-44219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2720841EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0C51F22A76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2F60B93;
	Tue, 30 Jan 2024 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvCc+JWa"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B643605B7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605951; cv=none; b=KcnGODJHA7osy89rghJO/knN0/in3AgOxreHNj6Hnl1Ml4npS+Cgv5EppjZdESyvOAgtYtpEnZy7DuMYaQQlnkXWdMqdaxEysxBnUT+XWPa5Ak+vRpMQ50dl8b0jDORCe6k+XKUU4D2paHUoRKMYL16PCMtFWLIGfo8K7ypdekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605951; c=relaxed/simple;
	bh=rKhHZGSb+Y6aNJ+cXifm6W5LIoIisj9pyI6bNCYAugc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKH3UyJUj4N3/ux8dDjGta5WIGJ+4uXDOC7MjRqHPmOp12e0MGzuoS42N12b1uABDn5CS3SQSh1+bAFCHz54ljPFFEN+rpPPnMTTyKCYBUFtvE/ONyFXUdmt1M1c9PRZnHGcn2eghD3/yEH3ROoH8qD+AJPWoqQfJUs9UvPayKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jvCc+JWa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f1102b300so1989542a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706605948; x=1707210748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dIk06W/m1toDs3ZlWZXYAsOHgljm2ZVOiVWudPYtTEg=;
        b=jvCc+JWat5DDimHXr1Yowksm8Qho2qnuIVHpjEkrMg5msithX5x+h/8OnPKIReulG7
         QzA+TEquRGYh5tFzqEhVgfhSerfu39i9qxdBj7hrYQMgeCfE8l2kBPL79c7HNxu31c95
         wuDY2LiK/scSwAG+fNbF7oFr7DJRtc2Aru0l4rA/WfXnE8MZ0DQXT6s2Vq6Lgh0DUrvd
         3QYLNHQmuq9kKPmNYi5g/5E2a/YuGrSV1uxPir24DbKCy9qkI47u+J3PflLYtLZaKyS9
         V4JTnNgB4QGWKCDQUrXKK0AKAgiE9tXHJmAtISb26Zyz3x9opxTa0L63TOjGaysYwXX6
         s08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605948; x=1707210748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIk06W/m1toDs3ZlWZXYAsOHgljm2ZVOiVWudPYtTEg=;
        b=FuLZdX6ROI00RyG/CGMMni+VghnO7y7iUFWoDOkBd23iT8umbqC9Vi+HuqN/JUXIAT
         0NRcLTsHdiBVb/aozuuN3nV/KKLvpXBXmKDMQKpyp8alkx5wWR6KNzAqf+al4OBb/2OC
         JxJ7es1O1CpN+SGS78dsFG7IMOPFMtcUosM72ePzuXfMXPFPMnlXok8k+CiRPdIsyFAD
         dajwLums3++t7IPStW5EWrAS9ZZ2UdARB4ECx9n+QAYmwCO4QTgTY7wkVy0y3oxNvJf4
         ObPOn4x51MgWAPVmzsFNVsgdkIW8+F2t6fL7vfNm6JJuKoGfbEY2xpQAA9TyGKQJcRpa
         oxUQ==
X-Gm-Message-State: AOJu0Yz8LRoj2f/IsH4LW2ExN1o4ZrTLkczjRtiGBMzuAodrfuOm5pCc
	CEEdR5hCl3CcuZZ61/6rirfBFPb1MKgmYjW7yEeqwUzmm3PO1cI/cX8U5DUkCno=
X-Google-Smtp-Source: AGHT+IGyVMf2OkueT1e2jkuy8V6uo08rZuNEronGpcRFfv+SAzH/npoMxojClmBxEorK0G3C/NJ1Jg==
X-Received: by 2002:a17:906:e53:b0:a31:1b72:9efd with SMTP id q19-20020a1709060e5300b00a311b729efdmr6023698eji.66.1706605948445;
        Tue, 30 Jan 2024 01:12:28 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id ss6-20020a170907c00600b00a3535b76c42sm3958064ejc.15.2024.01.30.01.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:12:28 -0800 (PST)
Message-ID: <338efca2-d1fe-4adb-8275-5f570ab445d8@linaro.org>
Date: Tue, 30 Jan 2024 09:12:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] arm64: dts: exynos: gs101: enable i2c bus 12 on
 gs101-oriole
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, semen.protsenko@linaro.org,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com,
 cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240129174703.1175426-1-andre.draszik@linaro.org>
 <20240129174703.1175426-8-andre.draszik@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240129174703.1175426-8-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/29/24 17:46, André Draszik wrote:
> This bus has three USB-related devices attached to it:
>     0x25: Maxim 77759 Type-C port controller
>     0x35: Maxim 20339EWB Surge protection IC
>     0x36: Maxim 77759 Fuel gauge
>     0x57: NXP PCA9468 Battery charger
>     0x66: Maxim 77759 PMIC
>     0x69: Maxim 77759 Charger
> where the Maxim 77759 has multiple i2c slave addresses.
> 
> These don't have (upstream) Linux drivers yet, but nevertheless we can
> enable the bus so as to allow working on them (and to make i2cdetect /
> i2cdump / etc. work).
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> ---
> v2:
> * add short summary of devices attached to this bus & add TODO
> * collect Reviewed-by: tags
> ---
>  arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> index cb4d17339b6b..6ccade2c8cb4 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> @@ -72,6 +72,11 @@ eeprom: eeprom@50 {
>  	};
>  };
>  
> +&hsi2c_12 {
> +	status = "okay";
> +	/* TODO: add the devices once drivers exist */
> +};
> +
>  &pinctrl_far_alive {
>  	key_voldown: key-voldown-pins {
>  		samsung,pins = "gpa7-3";
> @@ -113,6 +118,11 @@ &usi8 {
>  	status = "okay";
>  };
>  
> +&usi12 {
> +	samsung,mode = <USI_V2_I2C>;
> +	status = "okay";
> +};
> +
>  &watchdog_cl0 {
>  	timeout-sec = <30>;
>  	status = "okay";

