Return-Path: <linux-kernel+bounces-44069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D049841CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DD51F27D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040EC53E3A;
	Tue, 30 Jan 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLAI3Ozq"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100E55E54
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600963; cv=none; b=stzN0JCabnUKUfwknnY4IiL8i/QcmLllVRWGziQ1Mvy26IrprE9NWvt7NSCbPyfGXOM6aRcAt/zyZBwRNR7oshgjQv40b+p4VLhMVUH+sCtwQwe1ZR/I5Pal5z1ajOKjQy67Utenkd/1dffowk18VtQv1fT00yAqlHXDeM5ZkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600963; c=relaxed/simple;
	bh=W7EdgnKkjMwfQrVjMkuKi/Np1ROI0dXe8/JY64Hyjnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQ/Vycon9XPCypuz5JPMmcm/uFD5XOK8FxOTa4MLMIohO2f5OI8fSgdMuL1y+CDeVdxt3zOHFoS9mPUdPe7tEIPX72yDzxju2t7MD5izZyuslGtPUkkyMj/1bAM9S7Yce5Sc1R0m3lPNI5NOnt0IU+T05PmlhMBZgyWNT6Wt8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLAI3Ozq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55790581457so4166280a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706600959; x=1707205759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uxspv7T9EX1JvzDaKvkxxJalTAmoTENXDL7KG2k5zvk=;
        b=gLAI3OzqufLCU0iMF/nuv1F5M8xRMOLml0GmmeH3KaXcGZMhVI/Yb3fS1YsHFlbtXS
         lXK3BFY4P7H7MbVM+T9vVbPbkjY/QKSm0muidPbFVlNHW0wnBuQl3ImicLsX87Ff3Ldk
         H1ZdhCTQnv25zKwIz1s+nuYlNvv3oKTgWY+bo69SmEVVTyhs4dQzv9mfDcogreLtI1ky
         R23XI7o8zguOTJVE2XrHNWU9uN77xvRYLTu8eF6SVC4dd/DJjvyrjStX3GCFhx3kB4mR
         5IoQwEUcJwIVX5RsCE/boaMYo33q6kR/Dib2nJdoa6EGAy9+n828V7xIz9XvUxelfKtj
         VaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600959; x=1707205759;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxspv7T9EX1JvzDaKvkxxJalTAmoTENXDL7KG2k5zvk=;
        b=maXp99Vrm0A7gfQAQUyE82lGKSczsdPiHUiguxNq9wxdcHsxc87xTb+NMyVlgf/Ibn
         bUA0sc+UAnmXz8Fsri6FcJCCQDh79FgJbFyW1nT+wVZH7R7ZnooaHEQJEFCtG029YNsI
         AR77uQxvHnbig3ZQzyK++K5vqDW5GnweX/ZrLifK1AcLWgyYea5TfXmnqGLiYdHQChiR
         XYL/pwy8oqpxLb1bnlJGVfRP7IAxZGGNbJSu/+qCmPmZZEsC3LcjKCIqlpE5s8rAr6sP
         Yd5D93p0IrY1KvsE3qjoEceM6tRgSLMzlc/+iuV1pAW+6y/Q5XbKGy7RW68BBb3Jlwyw
         dpIw==
X-Gm-Message-State: AOJu0YwobKDdAAkt34noO7lr6T2fb4jmcVtSRtycXxzFWt8uKlAmxNxq
	Im8buM8CLRkKecxdvNfVBdrewo8Hxff+EHJBur6r1AAZV8TrYDrLUrsLHZ3vhE4=
X-Google-Smtp-Source: AGHT+IG1xXX60P1E9wvgTOwUcYJgL8esE8Tn4P1CwLs2NJhb1wxXIfMRpHq7hOsXi2L9gkTKKPCiCA==
X-Received: by 2002:a05:6402:27d1:b0:55f:1311:bebb with SMTP id c17-20020a05640227d100b0055f1311bebbmr3059008ede.26.1706600959660;
        Mon, 29 Jan 2024 23:49:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fj11-20020a0564022b8b00b0055c69e0751fsm4501758edb.3.2024.01.29.23.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 23:49:19 -0800 (PST)
Message-ID: <97ff8fd2-14b7-427e-8ca2-8da42bfcb53e@linaro.org>
Date: Tue, 30 Jan 2024 08:49:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: qcom: msm8960: Add gsbi3 node
Content-Language: en-US
To: guptarud@gmail.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240129-expressatt_mxt224s_touchscreen-v1-0-fb8552e1c32c@gmail.com>
 <20240129-expressatt_mxt224s_touchscreen-v1-1-fb8552e1c32c@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240129-expressatt_mxt224s_touchscreen-v1-1-fb8552e1c32c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 03:43, Rudraksha Gupta via B4 Relay wrote:
> From: Rudraksha Gupta <guptarud@gmail.com>
> 
> Copy gsbi3 node from qcom-apq8064.dtsi and set appropriate properties
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi | 29 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      | 27 +++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi
> new file mode 100644
> index 000000000000..c74c6625d276
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +&msmgpio {
> +	i2c3_pins: i2c3 {
> +		mux {
> +			pins = "gpio16", "gpio17";
> +			function = "gsbi3";
> +		};
> +
> +		pinconf {
> +			pins = "gpio16", "gpio17";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +	};
> +
> +	i2c3_pins_sleep: i2c3_pins_sleep {


No underscores in node names.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


> +		mux {
> +			pins = "gpio16", "gpio17";
> +			function = "gpio";
> +		};
> +
> +		pinconf {
> +			pins = "gpio16", "gpio17";
> +			drive-strength = <2>;
> +			bias-bus-hold;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
> index f420740e068e..62a5a9622e82 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
> @@ -359,5 +359,32 @@ usb_hs1_phy: phy {
>  				};
>  			};
>  		};
> +
> +		gsbi3: gsbi@16200000 {
> +			status = "disabled";

Please order the properties according to DTS coding style:
https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node


Best regards,
Krzysztof


