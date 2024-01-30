Return-Path: <linux-kernel+bounces-45212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D155842D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7AD1F25AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C8864CE9;
	Tue, 30 Jan 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ6FfnWb"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389837B3FD;
	Tue, 30 Jan 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643679; cv=none; b=KpZZcEx1Z4IsO2kd71FSp0UDmcatCgkCN/DBsgwviqflz+imEE+J4Mb0JCSBlCyZKhIzM7Y4S/5D6/dXCnp2HwNqF965kFgb5gvMsHrLyiklcUAzYTfcaoUS4Mdlq/9j5GFtV1FBYlQLDDQ4cq/BBm3dvOVpOlpG612jYE50TEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643679; c=relaxed/simple;
	bh=ZakAYJ6X0FFXo6NSxcBi61+Uh2uav76kYOltLGTxBIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrmpZ2LN4OH/Ao97Ephh201//jYKUOiLRQrzXjINf4j8TsjHbe7raKFBju//vPtRnaJLkWoTDqyFdzji1H3+5bEY4zmoqYhE0xTAPiFBdFGRhzB1NvfzZLesK8Db2KAAXqL+c1rmtEKcTnt5QAPpNGXu6uw3tp5jc4g/Glg0AIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ6FfnWb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f13b682d4so3276778a12.1;
        Tue, 30 Jan 2024 11:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706643676; x=1707248476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV2jTL1wgNtNZ2OFkWSlg5EStCwbj+Bl8szw2VZf79I=;
        b=UJ6FfnWbVA8IckTAu+GQL/uFxMTC8YdDTsTCdl5z6UVfHxhv1pe/ucr6f0W/FzqymA
         dX5M58u9HzrIdAZDpOneNU5CvF9sFmYFLEQZ2vqUWtsxRB89P5xl+pBQGHBy6CCJqKrS
         8gsjVygp9Q7VyR2bx+F7bue2NSXZsgcYlMDzIXHjTt+xekyb5tYfMw5CurJkgVHH1qCz
         ElwaJiOWlCbsgJvBBaIN/k7MqdZovV18DTRj0tcnDqxZMSZcQS51mTMF4LavugZVuHBE
         k/L9NDj+2nnKo9nO37gpgznQVa+ZXe7e2suAQtz3HaILXi5Cy2TuOJDjkWovVO1unF9n
         +eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643676; x=1707248476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV2jTL1wgNtNZ2OFkWSlg5EStCwbj+Bl8szw2VZf79I=;
        b=OUEr/D4OVZ3H4nzrLqXQwH26N0VIZ0hw8cijLTxdF8Xh9mHCYDAURbTRA3Lc/dte53
         vn63FXIrzOQ3hJjUrM3hmbpVEJXHbmbFJs9FbmDcAwQzR5dTjU0dgBf//FDu5TxC+rtT
         BzYcXKPtbsTn+r5+nOyBawZKkorRGNju5kvuHjHgLXcpWTeSWxa7XdVBJeRqmXOI0tsL
         IXjquKybrL8c3YLL/HZ5mC7dG6Ad4wjkLemUOZgmFBTS4MN0tneKDaxaMPS+F8OKYXpU
         /mb2Tr4ttdMN3lcdL0NLidI6FuviWKF6paEkM6L1Ci5E6MmJFXHvCf4W2Sr4Av+2YO0S
         JO9Q==
X-Gm-Message-State: AOJu0YwwubX1iV1o2v42EhU6Gp47XJI4uXW80oz3VoY9B0kVOy9KrpFe
	XtZlX4Kp0QgRa4cHPc16teULlt/5rldAVS6RZJWv9UycP5IGiOoLJYsPsfRs
X-Google-Smtp-Source: AGHT+IEVIjesSyztYMsiKeNJdYkDMf1U0WWfhSyU1fnCnWNWHFxpNaNAcQzT6VdSd3W0piensaNZ3A==
X-Received: by 2002:a05:6402:40c4:b0:55f:7a8:fdf1 with SMTP id z4-20020a05640240c400b0055f07a8fdf1mr4814703edb.29.1706643676208;
        Tue, 30 Jan 2024 11:41:16 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id i36-20020a0564020f2400b0055effc1e4basm2448375eda.24.2024.01.30.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:41:15 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Aren Moynihan <aren@peacevolution.org>
Cc: Miles Alan <m@milesalan.com>, Ondrej Jirman <megi@xff.cz>,
 Aren Moynihan <aren@peacevolution.org>, Chen-Yu Tsai <wens@csie.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH 3/4] arm64: dts: sun50i-a64-pinephone: add multicolor led node
Date: Tue, 30 Jan 2024 20:41:14 +0100
Message-ID: <4864457.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20240128204740.2355092-3-aren@peacevolution.org>
References:
 <20240128204740.2355092-1-aren@peacevolution.org>
 <20240128204740.2355092-3-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne nedelja, 28. januar 2024 ob 21:45:09 CET je Aren Moynihan napisal(a):
> The red, green, and blue leds currently in the device tree represent a
> single rgb led on the front of the PinePhone.
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> 
>  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi    | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index ad2476ee01e4..6eab61a12cd8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -39,21 +39,21 @@ chosen {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		led-0 {
> +		led0: led-0 {
>  			function = LED_FUNCTION_INDICATOR;
>  			color = <LED_COLOR_ID_BLUE>;
>  			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
>  			retain-state-suspended;
>  		};
>  
> -		led-1 {
> +		led1: led-1 {
>  			function = LED_FUNCTION_INDICATOR;
>  			color = <LED_COLOR_ID_GREEN>;
>  			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
>  			retain-state-suspended;
>  		};
>  
> -		led-2 {
> +		led2: led-2 {
>  			function = LED_FUNCTION_INDICATOR;
>  			color = <LED_COLOR_ID_RED>;
>  			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
> @@ -61,6 +61,13 @@ led-2 {
>  		};
>  	};
>  
> +	multi-led {
> +		compatible = "leds-group-multicolor";
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_INDICATOR;

Does it make sense to have function specified here and above? Example
specifies it only in multi-led node.

Best regards,
Jernej

> +		leds = <&led0>, <&led1>, <&led2>;
> +	};
> +
>  	reg_ps: ps-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "ps";
> 





