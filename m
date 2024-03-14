Return-Path: <linux-kernel+bounces-103088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349D87BAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D4F1C21B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9433F6D1B5;
	Thu, 14 Mar 2024 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQ0D63s8"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041616D1A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410547; cv=none; b=SANqMxCFf8MUUfBQWGZ3N8O91GsJM+vB6lNllvQ1xUqNNgNIvMe7N4WCrRx+G5ZrW+cRsemjGAGmJ4/6+YB66irdIy0otLHb3w3Di5kvhj/OJLuqEccA3EEMH0gyxWu7g0SAQkZNZV01QO3335j+GXrLJZcY2udP980DY5mkq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410547; c=relaxed/simple;
	bh=JpUcI29deeFUiVLFVWQx+YC17SdHXIIkn3hGw3jMbmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0jGievpzTxvjHGASfbUjCFq8ebrWCOZeviJ+cvz6Jw2ZI2g3rGYhnPJY6T3psOXOlsJycuhCNIOdLeh0gS5kthBJW8z3Ya48L1/peI8q6oYrtkKjz+E/RtqAM1g/qqfMcQiLa3V8DLGVfLiv6K2fSDcuKM4zFDXyj0GQPe8Oxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JQ0D63s8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51320ca689aso939496e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710410544; x=1711015344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVCfYz9oIySfeLjhpRglcwU9GXWcLEvHNoQGqzXrLb0=;
        b=JQ0D63s8krTuE1UYeh/HGXwQQm5wN0gZn4Yp07RPqEa5skRCXlLjWUEK5fDWKP+t2W
         0z0RRawgSewaz5IYNy9c8430DFfdXpjnAQ+YffAtBdUTasZWRhSirN8w1TD/xh96oTZK
         TQ0P+q8vW4oFnj1Sl3C3Z08Jan//waZenQTmhHTdBHO+VHBsmjy651hjhHYEAw0tFlMw
         ffmE0+imL6eT1d/yZ1jxP+uu7ZWIfSKel/wS2xFbP0HACAGDpfc3ydW1CjbOYhrmfaUe
         xXl3y7bqFPCcnrS91h3kaScwYZp63OLqD+81MRTU5bp/icxmcYxAgtz2NMyogW9eBz7H
         /aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410544; x=1711015344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVCfYz9oIySfeLjhpRglcwU9GXWcLEvHNoQGqzXrLb0=;
        b=VuhrHhMaVWDjS91Zd4XjJ3zhjMjFkUhf62IQbFYrl1F0akzINqkxXElXDpZNQBTFDC
         0i6pXZN1mREMxZYgHGY/jVfPqS9H821jv8H2qi1OVxwqSKQ/PcWNpxDdK9FooEKh/755
         dBOeuL2phvMDrGMHVqQp871yAdXJIKy8rhuAvBY5cj8apYNfh4xSAhP5SbAxuYoCiw1u
         muJcSy990/ZykjnCg2VsiRUefXNA48SGyLmUhNz/sUiMrGG7v3Ar18h6txjeRXwYxmFG
         4nQ9A3Ck0MZ7Ml5A0RHxhkEWW9askQys6W4FFgfnNexkKQ0itnkMB0vS7qec4jPsTYle
         /URQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP1iNJ+2U9rUfi6NtcGkQ0JxdZi7w3UEc2Yj4VTU4Z1yZPR9awzvX0w7+THigztmPq95AWMgPxYTOl8r8QqoDtsMRkInTHKSxObF5M
X-Gm-Message-State: AOJu0YyyZhcNrzK4TNZ7QJ2LO6cO6XVTX0FTxPXtwMZ01OQY1yiICv5w
	uV2nOLqsid1zuOBLiV75mElNX3S9OhnKg0CVzXK/BmXsFaXvWS8DrU5evrd2OJM=
X-Google-Smtp-Source: AGHT+IGlBqvWSjPadbAZx49QcdSGc2n6I1bU76B+EPDyxGHGYorXVB/0f39xhCheAMS5uLJCjQetAg==
X-Received: by 2002:a19:4307:0:b0:513:9f14:8f73 with SMTP id q7-20020a194307000000b005139f148f73mr934909lfa.36.1710410544124;
        Thu, 14 Mar 2024 03:02:24 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b00513a9d149a7sm202192lfs.302.2024.03.14.03.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 03:02:23 -0700 (PDT)
Message-ID: <c213a3c0-004a-427e-9a19-037eab196ca4@linaro.org>
Date: Thu, 14 Mar 2024 11:02:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: qcom: msm8974: Add Samsung Galaxy Note 3
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Adam Honse <calcprogrammer1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz>
 <20240310-samsung-hlte-v1-2-e9b55bf98a48@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240310-samsung-hlte-v1-2-e9b55bf98a48@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/24 15:13, Luca Weiss wrote:
> From: Adam Honse <calcprogrammer1@gmail.com>
> 
> Add the devicetree for this "phablet" using the Snapdragon 800 SoC.
> 
> Signed-off-by: Adam Honse <calcprogrammer1@gmail.com>
> [luca@z3ntu.xyz: clean up, prepare for upstream]
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm/boot/dts/qcom/Makefile                    |   1 +
>   .../boot/dts/qcom/qcom-msm8974-samsung-hlte.dts    | 403 +++++++++++++++++++++
>   2 files changed, 404 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
> index 9cc1e14e6cd0..845af12d15a2 100644
> --- a/arch/arm/boot/dts/qcom/Makefile
> +++ b/arch/arm/boot/dts/qcom/Makefile
> @@ -39,6 +39,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>   	qcom-msm8960-cdp.dtb \
>   	qcom-msm8960-samsung-expressatt.dtb \
>   	qcom-msm8974-lge-nexus5-hammerhead.dtb \
> +	qcom-msm8974-samsung-hlte.dtb \
>   	qcom-msm8974-sony-xperia-rhine-amami.dtb \
>   	qcom-msm8974-sony-xperia-rhine-honami.dtb \
>   	qcom-msm8974pro-fairphone-fp2.dtb \
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dts
> new file mode 100644
> index 000000000000..e03227a49b67
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dts
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "qcom-msm8974.dtsi"
> +#include "pm8841.dtsi"
> +#include "pm8941.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +
> +/ {
> +	model = "Samsung Galaxy Note 3";
> +	compatible = "samsung,hlte", "qcom,msm8974";
> +	chassis-type = "handset";
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_3; /* SDC3 SD card slot */
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_pin_a>;

property-n
property-names

> +
> +		key-home {
> +			label = "home_key";

"Home Key" etc.

> +
> +		pm8941_l20: l20 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +
> +			regulator-allow-set-load;
> +			regulator-system-load = <200000>;

regulator-min-microvolt = <2950000>;
regulator-max-microvolt = <2950000>;
regulator-system-load = <200000>;
regulator-allow-set-load;


[...]

Konrad

