Return-Path: <linux-kernel+bounces-35856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5AA83976E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF8D1F2A760
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46E81AB0;
	Tue, 23 Jan 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="on7or3cB"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0278181211
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033837; cv=none; b=XyGQMofLaQy2CYIz4aKaO+BSqvdkwdgebG0ugm5N/ayW/EeJ2l/VNpMcF7/SlHTxhTjOeDtCJWszKkuZ7RWgJBnEWK1cvnTXJQxUpxZ8ujKbDbDwUWV24+DmeQFkWghsdMWtv8Y5ddwiB8CKjwhk7bBkA07NNWfgcU2NEfQcKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033837; c=relaxed/simple;
	bh=Ccx47b6sXcVyQO9LDJmxlFrgnkozfAfUvosgSzbATlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7nTjGikm0ixCeU7q5Uv1eFq157L5K6yibBWsEqiQ3GY6brZS/FNEi8/V7eeqChCPKgnzgsk/qcTI32qACdgutlLJp4nThbDcMWv0dg+ElSEX63gEICPxsWtvSdny7C6Y8pLjHiTJ6lsyT/DuMwMJoTboVoEYApQ6tiE2+lTLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=on7or3cB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so6228364e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706033832; x=1706638632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ViK3zpE7z9Tw+fShvSLPYbG8Lqe0Ik2/WW/otH2INw=;
        b=on7or3cBx4clQ+UFv085IAKwa0WckQfd6EqBQIUe1pF6NvaPNTQx8tALdgbfpaCrMY
         dFvbf4nK/o1CZDmR2CMsZLVDTR2Gq3UweBlPC6DFbmIKeLI+kTA3RdI3fMpKE0DV+fzs
         bYqoCSalE97C2Sq0OIIcCsDn0dyRtRSei+VV26rh+zE4RnR27I74kjlOyCez7F9zpRcQ
         guu2R6Nkkko67/R5eUN2R6r3IOYirF6iMMd/tup0IiegzjzEYNlfBCD/yJfIBYEHwXoA
         cd/3MjpGiyhioYIVafbZLPtzyMsizRc5LsYnqXQAL+asg8NwGpyoN5Pn2+Cv33ow/2l7
         0nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706033832; x=1706638632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ViK3zpE7z9Tw+fShvSLPYbG8Lqe0Ik2/WW/otH2INw=;
        b=urMhApC0mQf8D2QpdRCmIsq7l1XAuf8e86i1AW36jv5gOZDrG/PzdOTmNAS1Q+0/pC
         v+53lH/G+I4uGM4c7k32JT4rWl4Ly/b9nqVjNYHmB6pRYs6rRJ3oZPCZor2rZlxjgr3d
         v7vI1/nZ4F5EOk5sIu9hFMPjtT79w91aGi0DbYenw1TeMa6ZYUK3sbeMlNFdhm2QNDi6
         ip2+GgCn/YOsaqmUNelT7yMrz0WmoC/L62ROMzuifrNln6ZomyEiAywRcV5l5a0NzlO4
         4VeYzsb9maKH/NbYt86x17nvcmBCza0ez3kz1tUcrkQMZ/gci5LU8y3mtP3MKfBJbKz8
         SKFA==
X-Gm-Message-State: AOJu0YwAB3o0R3900+ZOdbTQ/SO0kKpKsdRd/GC96Ntvg9B0dtGUoPQT
	A2Ze1NDES0bgRLRSF+8aW8ze7zqS2uNcIZOWXKtsyKAJDLBONRmCSWs/Kyepncc=
X-Google-Smtp-Source: AGHT+IHHe71fO10rCDTM+bdz78wDkuWt3Um/e7HUY1ykImzpBs/ZJwrv8MOAYjXhGWwBlRJbhVgBtg==
X-Received: by 2002:a19:4f07:0:b0:50e:e3e5:40f9 with SMTP id d7-20020a194f07000000b0050ee3e540f9mr2346243lfb.27.1706033831964;
        Tue, 23 Jan 2024 10:17:11 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z14-20020a056512308e00b0050e7a098a75sm2351099lfd.196.2024.01.23.10.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:17:11 -0800 (PST)
Message-ID: <9af6d68f-ccc0-4d2b-ab59-77864a628bb4@linaro.org>
Date: Tue, 23 Jan 2024 19:17:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] arm64: dts: qcom: x1e80100: Add USB nodes
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
 <20240123-x1e80100-dts-missing-nodes-v4-6-072dc2f5c153@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123-x1e80100-dts-missing-nodes-v4-6-072dc2f5c153@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 12:01, Abel Vesa wrote:
> Add nodes for all USB controllers and their PHYs for X1E80100 platform.
> 
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 435 ++++++++++++++++++++++++++++++++-
>   1 file changed, 432 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 2b6c55a486b2..593ead89706c 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -5,11 +5,13 @@
>   
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
> +#include <dt-bindings/clock/qcom,x1e80100-tcsr.h>
>   #include <dt-bindings/dma/qcom-gpi.h>
>   #include <dt-bindings/interconnect/qcom,icc.h>
>   #include <dt-bindings/interconnect/qcom,x1e80100-rpmh.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>   #include <dt-bindings/power/qcom,rpmhpd.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -734,9 +736,9 @@ gcc: clock-controller@100000 {
>   				 <0>,
>   				 <0>,
>   				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>;
> +				 <&usb_1_ss0_qmpphy QMP_USB43DP_USB3_PIPE_CLK>,
> +				 <&usb_1_ss1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>,
> +				 <&usb_1_ss2_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>   
>   			power-domains = <&rpmhpd RPMHPD_CX>;
>   			#clock-cells = <1>;
> @@ -2492,6 +2494,126 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
>   			};
>   		};
>   
> +		usb_1_ss0_hsphy: phy@fd3000 {
> +			compatible = "qcom,x1e80100-snps-eusb2-phy",
> +				     "qcom,sm8550-snps-eusb2-phy";
> +			reg = <0 0x00fd3000 0 0x154>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&tcsr TCSR_USB2_1_CLKREF_EN>;
> +			clock-names = "ref";

You use this exact same clock for all HS PHYs. Are you sure?

> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb_1_ss0_qmpphy: phy@fd5000 {
> +			compatible = "qcom,x1e80100-qmp-usb3-dp-phy";
> +			reg = <0 0x00fd5000 0 0x4000>;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "ref",
> +				      "com_aux",
> +				      "usb3_pipe";
> +
> +			power-domains = <&gcc GCC_USB_0_PHY_GDSC>;

This is likely RPMHPD_MX(A/C)

[...]

> +			usb_1_ss2_dwc3: usb@a000000 {
> +				compatible = "snps,dwc3";
> +				reg = <0 0x0a000000 0 0xcd00>;
> +				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x14a0 0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				snps,usb3_lpm_capable;
> +				phys = <&usb_1_ss2_hsphy>,
> +				       <&usb_1_ss2_qmpphy QMP_USB43DP_USB3_PHY>;
> +				phy-names = "usb2-phy",
> +				            "usb3-phy";

Should this be marked dma-coherent?

Konrad

