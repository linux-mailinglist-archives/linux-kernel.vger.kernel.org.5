Return-Path: <linux-kernel+bounces-103180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4F87BBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FAB1F23C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C16EB6D;
	Thu, 14 Mar 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zqvo8d6T"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F96F070
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415827; cv=none; b=sT6fHel6rDkwWQuYvrjIzx8Hx2skBs6JOk1JB5bvmGt/O22+k6k0Jw6v9fxhyf8Ur3iJ2c0aDgZEIH4L3m3zaPB3xr5BDelN+oD44iJO+34UYZ/6LemdkhRbrZwAQWxd2hrt3Blw/2Er6aqsx4flm7UfzQosjk5GDofwKUIprcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415827; c=relaxed/simple;
	bh=geeaJ9XrpY7EnV7LvgPDmm4ZknarR6+u6ViCbG57IHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/ZfB86qBVasQsrkY/gRVfZk+9bFZIiio/P39N/KjILNdLqiajX2Cr2kgNjc8xhmmRo0BhSGxcFoDgi3gE2X4J9kHJMB8X3pKmmfizth0bw+sNw4p2t3eFyxL59AFZzTu9wpyaFRSeleaVlpbdREzp6OEQpR+hE+V61BDLsXETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zqvo8d6T; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4765792fc76so78974137.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710415824; x=1711020624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x5jf2VCmw1aXglJHB8Z5PT6x/rVvoN43ugLsRz/juHg=;
        b=Zqvo8d6T6ZhmEjaO7NR8uOBnDYGDgRNPL/0q3d06zP8MPUdvC+4Vxc4kV9DmgFpzuf
         F6B1emzu2b2eYYKBduXi9RRLcqwaRx5pBT18an7gdR3gZiNaMbTXseYHUOmAmpdopVuJ
         QQhUmAKT/vLr9qQCYIJJVhgVp9aVhpmAwrLikVvnzIC5KCgpsGzE6j/3jW417oThqAHp
         3yW+LykqC4Feq7nBudHwR/PYfcdUYGPIjXSRGeFtBhg/Ni+vQ0Siw/hC3ld/M4SM4UXN
         HZ0Z5DGHx5KT2Q9Hj8y8IZOjGRC5UpfwN2C4qOFDAvUtKkULJXpxQRqNubRfLMOZFt2k
         Kf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710415824; x=1711020624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5jf2VCmw1aXglJHB8Z5PT6x/rVvoN43ugLsRz/juHg=;
        b=n6DB+4KgWJn8PmiiKNn/ZhUeaPBmmSPn6AlguWVCgodiwOQtOZmzhRTdvOno4svKt3
         MgcBO+GhVbEAaqe8IqYFf79hSoSxwqdBV8cOISz3eCvnAgf145jP8XUndC4oy1UtZwEm
         /4DldsNPo9cD8Z+T6tHWNfVF2WjVR7iTP1KbYfRX27EtKC/cORepQ2Oysk3ARdclR7/L
         bfYNnLWBoV4UoqfonBQVVGn1qJeSEBKo/NFIGcJAmJh5FZWarkzkePIz8yfhLN7/HFRw
         rrSkGJvhG7V42v0C3bHH5TbtJcF+nCbnKiqKNRABeRnnXUsG/zwdoDe+ugB/uFwLeYOJ
         m+hA==
X-Forwarded-Encrypted: i=1; AJvYcCUsFwC0NSqoFmd1ZHUEf8wFU2hwbSfCAF6c9EINj1PCi1mt/cuQkE6eEIl9Te05ArY6PJ4IM7hb7lhNRi5vXug65cyr4loAMK32q/Wu
X-Gm-Message-State: AOJu0Yyct3gio5IanrTX/dqh2Pr5BI11lRJGFVLX2O4QKLQpCJC1xcKP
	0vTAt9HVWW3/zOtB8k2GXiL37M7GveTMvpF8KGgSwTNaDCzleKyRQRxrydnV5AWLk3GI62giE81
	Z4p9q5tv/3P7UvJCxX0+BdhaXtaL/2pwesAUQsQ==
X-Google-Smtp-Source: AGHT+IGvFGm119bVeOJF9Po12RVbWwG8w/gEM+FJSAHy8Fb4qExKYZgUjo6xPF5jADyADX/A5QLEpty/WiIvgrxrNKw=
X-Received: by 2002:a05:6102:2259:b0:473:213e:d4af with SMTP id
 e25-20020a056102225900b00473213ed4afmr1401196vsb.21.1710415824429; Thu, 14
 Mar 2024 04:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314112657.167006-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240314112657.167006-1-krzysztof.kozlowski@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Mar 2024 17:00:12 +0530
Message-ID: <CAFA6WYOV2Mn_1==67Yxacjp9RR2LC7dQUU4Y5Q3b=yo5yhNVyg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: apq8016-sbc: correct GPIO LEDs node names
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 16:57, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Individual LEDs in a GPIO LEDs device node are not addressable, thus
> unit address is not correct.
>
> dtc is also not happy:
>
>   Warning (unit_address_vs_reg): /leds/led@5: node has a unit name, but no reg or ranges property
>
> Reported-by: Sumit Garg <sumit.garg@linaro.org>
> Closes: https://lore.kernel.org/all/CAFA6WYNRwF7GqhBk2B7i-deT3aLxNQckhnOasjip2TYm4HZgAw@mail.gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> index 9ffad7d1f2b6..aba08424aa38 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> @@ -91,7 +91,7 @@ leds {
>
>                 compatible = "gpio-leds";
>
> -               led@1 {
> +               led-1 {
>                         label = "apq8016-sbc:green:user1";
>                         function = LED_FUNCTION_HEARTBEAT;
>                         color = <LED_COLOR_ID_GREEN>;
> @@ -100,7 +100,7 @@ led@1 {
>                         default-state = "off";
>                 };
>
> -               led@2 {
> +               led-2 {
>                         label = "apq8016-sbc:green:user2";
>                         function = LED_FUNCTION_DISK_ACTIVITY;
>                         color = <LED_COLOR_ID_GREEN>;
> @@ -109,7 +109,7 @@ led@2 {
>                         default-state = "off";
>                 };
>
> -               led@3 {
> +               led-3 {
>                         label = "apq8016-sbc:green:user3";
>                         function = LED_FUNCTION_DISK_ACTIVITY;
>                         color = <LED_COLOR_ID_GREEN>;
> @@ -118,7 +118,7 @@ led@3 {
>                         default-state = "off";
>                 };
>
> -               led@4 {
> +               led-4 {
>                         label = "apq8016-sbc:green:user4";
>                         color = <LED_COLOR_ID_GREEN>;
>                         gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
> @@ -127,7 +127,7 @@ led@4 {
>                         default-state = "off";
>                 };
>
> -               led@5 {
> +               led-5 {
>                         label = "apq8016-sbc:yellow:wlan";
>                         function = LED_FUNCTION_WLAN;
>                         color = <LED_COLOR_ID_YELLOW>;
> @@ -136,7 +136,7 @@ led@5 {
>                         default-state = "off";
>                 };
>
> -               led@6 {
> +               led-6 {
>                         label = "apq8016-sbc:blue:bt";
>                         function = LED_FUNCTION_BLUETOOTH;
>                         color = <LED_COLOR_ID_BLUE>;
> --
> 2.34.1
>

