Return-Path: <linux-kernel+bounces-37717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C81883B454
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954711C216F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02E135A4C;
	Wed, 24 Jan 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCh6EnZA"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F9135A43
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133386; cv=none; b=dWHarlpwdNUhQl6tHI8gWd5DVyrxdAqp5bHvsJrdW0v22DtT/iJJyxp+WZOWmc8jeEw8P7zI9ZaylU6gdbQqzeHPMgmXTSV8PHZSPEo2eQ4T+zchKGWKtcflhebUBbCEtaKmSEVRrLxdIyAPnsVDWbohVfTlZRtqLQoREZMMFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133386; c=relaxed/simple;
	bh=EX6Xg97fogggPujr6zF1z3ZA6WLr4oyUt8u/YA6aViQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omkZeQmn832BsxYURLoyj+OpbayHxODA6+LBwvOIn2Xsf45oAJ+GcT4uPCBUWW3kxJXfD4YdBC89oMqHu7S+XrEdVeFKkNnjqnlpur5+NHOuRbX8QOZ6R2UUHq3VNu+m+iWdblIjz7yIVzpCeOSoaUded3bp3Xd5+iqNAMTXzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XCh6EnZA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so70984005e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706133383; x=1706738183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EdTvmEU+xHHgmqyOex/ty2VAc9Q/TL690DSs8BPGiJc=;
        b=XCh6EnZA0UiaYLgZLRKmSpqj3EPnyE3W9n3UdYIOFdqRs0SZ8aUFBzipHSNjs8ZuS8
         YmY3cmXmWMDxiw4iQ36kZL1zM2ujUaeGyTl0zAk4KnjB1gRXMiXMZuFzxK4FsZdos1Rs
         iBHmvlIuI+DZJBYByaEJ9QM/nAfESFWnfG3NpgXEL71wnCQc4KLHnlkIi7U5IjaS3w4y
         WgC4T1GqOfo5qTrU2UoMR05wCfXLhE6u6czl6IPzkJf5/dlKUHmB5DMbLwIvqCm78Z1k
         0OCdRu9p/m0AVi1kdcVy7solcKxGXpOFPt9RWgEhrt+ObqLsOfWDxfG5Ra7w0B8v+f/W
         gqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706133383; x=1706738183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdTvmEU+xHHgmqyOex/ty2VAc9Q/TL690DSs8BPGiJc=;
        b=q81VbS93nbRmggpxgSaesZ0vMheNX9xJOVSISV+q7LnbS9lb7qztm/ltl/p0NMK+V5
         Czqll+DskmnfauR69B9hFk547jlraFCu5X5ppo5IB2Zbksn77Z1S6FcE9O0Qcwqe21sq
         l6fbqrhLT/sd1hvd0MftESi4sENHbjlwkFYfhdn1nX8vIvEDNqo3DdMGJ7e6z1Q+f8Ut
         cCJub2nMjfviy07rGWCCh2W1E35aEmUvEjgJvzl4PSs6mKZP68bAv/T321iASAQynqAC
         fdAZoxwGgdd28by+xPUKhR9BeP+FnMjpptI3jv8beGtcxaFrliuI2Zt1foW8FZyJB0zG
         v8Xg==
X-Gm-Message-State: AOJu0YyBH6riGL5k8jozDFIRSYS35ZQTLMT/p9p9lnDu8eWxenZpPJTF
	44GGh4puBnnY12aTWLpjUgaLH5tbzaDhxsB7h0bwlTK1owJdF6FmpzMw3hOzQ+E=
X-Google-Smtp-Source: AGHT+IGFN1yZ6bkhyyR0G3nSuRypLXrxZfSyl7bbfq6gvKvNiRN9o22JGYpQGM1U0hToOzmUoKPSdg==
X-Received: by 2002:a05:600c:4ed2:b0:40e:bfca:f1b8 with SMTP id g18-20020a05600c4ed200b0040ebfcaf1b8mr996061wmq.54.1706133382771;
        Wed, 24 Jan 2024 13:56:22 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:92d0:e652:43b1:5e6a? ([2a05:6e02:1041:c10:92d0:e652:43b1:5e6a])
        by smtp.googlemail.com with ESMTPSA id t15-20020a05600c198f00b0040e395cd20bsm377273wmq.7.2024.01.24.13.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 13:56:22 -0800 (PST)
Message-ID: <245f5692-be30-4216-8b13-988092793732@linaro.org>
Date: Wed, 24 Jan 2024 22:56:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-2-5879275db36f@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240125-rk-dts-additions-v1-2-5879275db36f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/01/2024 21:30, Alexey Charkov wrote:
> Include thermal zones information in device tree for rk3588 variants

There is an energy model for the CPUs. But finding out the sustainable 
power may be a bit tricky. So I suggest to remove everything related to 
the power allocator in this change and propose a dedicated change with 
all the power configuration (which includes proper k_p* coefficients to 
be set from userspace to have a flat mitigation figure).

That implies removing the "contribution" properties in this description.

Some comments below but definitively this version is close to be ok.


> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 165 ++++++++++++++++++++++++++++++
>   1 file changed, 165 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 36b1b7acfe6a..131b9eb21398 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/ata/ahci.h>
> +#include <dt-bindings/thermal/thermal.h>
>   
>   / {
>   	compatible = "rockchip,rk3588";
> @@ -2228,6 +2229,170 @@ tsadc: tsadc@fec00000 {
>   		status = "disabled";
>   	};
>   
> +	thermal_zones: thermal-zones {
> +		/* sensor near the center of the whole chip */
> +		package_thermal: package-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 0>;
> +
> +			trips {
> +				package_crit: package-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 0 and 1 */
> +		bigcore0_thermal: bigcore0-thermal {
> +			polling-delay-passive = <20>;

20ms seems very short, is this value on purpose? Or just picked up 
arbitrarily?

If it is possible, perhaps you should profile the temperature of these 
thermal zones (CPUs ones). There is a tool in 
<linuxdir>/tools/thermal/thermometer to do that.

You can measure with 10ms sampling rate when running for instance 
dhrystone pinned on b0 and b1, then on b2 and b3. And finally on the 
small cluster.

But if you don't have spare time and 20 is ok for you. Then it is fine 
for me too.

Some nits below.

> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 1>;
> +
> +			trips {
> +				bigcore0_alert0: bigcore0-alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore0_alert1: bigcore0-alert1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore0_crit: bigcore0-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&bigcore0_alert1>;
> +					cooling-device =
> +						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 2 and 3 */
> +		bigcore2_thermal: bigcore2-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 2>;
> +
> +			trips {
> +				bigcore2_alert0: bigcore2-alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore2_alert1: bigcore2-alert1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore2_crit: bigcore2-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map1 {

s/map1/mpa0/

> +					trip = <&bigcore2_alert1>;
> +					cooling-device =
> +						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between the four A55 cores */
> +		little_core_thermal: littlecore-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 3>;
> +
> +			trips {
> +				littlecore_alert0: littlecore-alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				littlecore_alert1: littlecore-alert1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				littlecore_crit: littlecore-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map2 {

s/map2/map0/

> +					trip = <&littlecore_alert1>;
> +					cooling-device =
> +						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};
> +			};
> +		};
> +
> +		/* sensor near the PD_CENTER power domain */
> +		center_thermal: center-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 4>;
> +
> +			trips {
> +				center_crit: center-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu_thermal: gpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 5>;
> +
> +			trips {
> +				gpu_crit: gpu-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		npu_thermal: npu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 6>;
> +
> +			trips {
> +				npu_crit: npu-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>   	saradc: adc@fec10000 {
>   		compatible = "rockchip,rk3588-saradc";
>   		reg = <0x0 0xfec10000 0x0 0x10000>;
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


