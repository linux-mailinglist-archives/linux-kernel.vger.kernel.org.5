Return-Path: <linux-kernel+bounces-37720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F88683B45D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACDC1C21EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981413540E;
	Wed, 24 Jan 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWqsZXR1"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1C1353E4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133557; cv=none; b=aOQPJzHm26Pu/Qd1Z++G3A2cWE+GpNqChfkhKg+xZ/6vR5PjK3rOEuWIACGU+uWg34wY5UOMy/laSGh8LrJNgyS4JN1il9RjOAwG/49l4Z0CK3auZs+7EelwQncHkYk4dyvsz0woB2wS71CaRWtWsj6P7KXfoNaFa0EBDFUGrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133557; c=relaxed/simple;
	bh=VLQeOlfpZxjdT3U1gi97jd8DeMuITFLgRbpN/EoAAxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIIgiGM5LKfqXx10O6T6Me8CYeNPs45vX9p7G+5SPSE0JPTXSe+00IFtzCOSmYADX8944rlTCpe6qdLddtQ4pY16FEyiY6nAzpeL77T7dwi0o6u0Oi8P5NX+8fWWJ2CGcrdy8c/4/lmgzPxxhT6iV+PDd6o8lXPQW1022u6PpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qWqsZXR1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ec3535225so19780785e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706133554; x=1706738354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/x0xwLfqu5z8NcxBEe9tr7BWnY9CY/mlR8s5sFbWe8A=;
        b=qWqsZXR1p2tjSW/M06QXN4L9rd2Ayq89AEgW5QSvjAi8irwFB3Pf+VIQvpbH9rZnLZ
         nq0adDdbHVihyDhDlZtZQoDMmuLCCBGuSx+gsZr5UXEjDO3KwJWnyXExOBgXeJTHhmat
         zfqchhgH/g+qUp3O7a6u444pVAsfwOYzLuDmN9i1ENLuAebSsYkbqDTYtTouHZsq4u0n
         f77ubd61cxffFmbL8JWCo3oEuHEsorbQRRQbR65SCALwlmSgbQrYJFAY2+w/0XQGkgOQ
         O3R2tkZxp+SNDH6ZabxHJeZ0V8vKgHKl5EeQlpvbhdB6VvhDBN6IizdVQA5EYChulL5C
         9UsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706133554; x=1706738354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x0xwLfqu5z8NcxBEe9tr7BWnY9CY/mlR8s5sFbWe8A=;
        b=okyk3TGLuq2xYnnhvjnJoHYMGB8Dita9da+xRqgJB6XRus/ExM7Hb5cBTP4aWQ1+QR
         KhGjPCt9NprhpwD6BPUlUNJU8giNxeBrJEwZSU/vPHgjYKiifmH1k4ZH0nMF7kbgDDoD
         vm9PdLkHCHqhGFUrW9pGIBKuFOUMIhvPw11Mhyk9K807QYdYoNW5MeaeWihHOdSge1N8
         rAcEGfv0Gw+f+VEmaOgE2tImpQRhOlxWeqEYUDK7pH91tfQQgiTf39668al2WxRJiGwY
         EaK4kOMTVCdzuMN7PtcVouq1p9obJUWt64AovTmUCx3JCQjw/du3BvkE0afmq3108lv6
         +dPg==
X-Gm-Message-State: AOJu0Yy+tsRlBjCi2Hf3MGsMmaH2Hpd5nexyWUerVGhP6/vjAqkeO7KP
	PYIZPo9T9R3ctnFqwbkicqvHKvSMxSktKxy/FYUo/yCeE5RAp5AD0ewAFg8DDUA=
X-Google-Smtp-Source: AGHT+IHw30SWTJoZ+FFFZrE09mSB+uTZpDsgzB9o0ZyoA20fyJ1GgKZ55NN4s2uwVcHBe7cWeYm64A==
X-Received: by 2002:a05:600c:3286:b0:40e:70f2:5754 with SMTP id t6-20020a05600c328600b0040e70f25754mr1016294wmp.250.1706133554110;
        Wed, 24 Jan 2024 13:59:14 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:92d0:e652:43b1:5e6a? ([2a05:6e02:1041:c10:92d0:e652:43b1:5e6a])
        by smtp.googlemail.com with ESMTPSA id o9-20020a05600c4fc900b0040ec66021a7sm380550wmq.1.2024.01.24.13.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 13:59:13 -0800 (PST)
Message-ID: <7c8b9bc2-94f8-46f7-8143-a78c834142ef@linaro.org>
Date: Wed, 24 Jan 2024 22:59:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: enable temperature driven fan
 control on Rock 5B
Content-Language: en-US
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-3-5879275db36f@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240125-rk-dts-additions-v1-3-5879275db36f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/01/2024 21:30, Alexey Charkov wrote:
> This enables thermal monitoring on Radxa Rock 5B and links the PWM
> fan as an active cooling device managed automatically by the thermal
> subsystem, with a target SoC temperature of 55C
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 9b7bf6cec8bd..c4c94e0b6163 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -52,7 +52,7 @@ led_rgb_b {
>   
>   	fan: pwm-fan {
>   		compatible = "pwm-fan";
> -		cooling-levels = <0 95 145 195 255>;
> +		cooling-levels = <0 120 150 180 210 240 255>;
>   		fan-supply = <&vcc5v0_sys>;
>   		pwms = <&pwm1 0 50000 0>;
>   		#cooling-cells = <2>;
> @@ -180,6 +180,25 @@ &cpu_l3 {
>   	cpu-supply = <&vdd_cpu_lit_s0>;
>   };
>   
> +&package_thermal {
> +	polling-delay = <1000>;
> +
> +	trips {
> +		package_fan: package-fan {
> +			temperature = <55000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map-fan {
> +			trip = <&package_fan>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
>   &i2c0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c0m2_xfer>;
> @@ -738,6 +757,10 @@ regulator-state-mem {
>   	};
>   };
>   
> +&tsadc {
> +	status = "okay";
> +};
> +
>   &uart2 {
>   	pinctrl-0 = <&uart2m0_xfer>;
>   	status = "okay";
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


