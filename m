Return-Path: <linux-kernel+bounces-52810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF5849CEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0954A2810FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BE12C1A4;
	Mon,  5 Feb 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQfc5zvF"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3728DD1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143002; cv=none; b=asX86GBJigeq0cFZB1uz/Y36kCFq6mOP8uRr47exOFDF/zXqOp63FxsvFlmWlG1RBzovPmp7CyYSADd/uMKgM8jgHqKqRSewxQ/5NnQ92KXBb9NqT6o7lkRIqjsc6FK2/sWCPk2vPmWL12MgQejGKPjFbD5MDcj+g/YrC1RWNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143002; c=relaxed/simple;
	bh=5RyMVLemSkWVpyHBi0so1fiYtu5f37OhHrGEU8lWY2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roH2iwt9LRl3HaMYosBrY4AOmbggPi9iHTUSfyqayiQtLzNX5LvU3l+GmgF9kAqgDzexrm1aqpzFeF4lJ5B2RM17G2zUhRVlkGmmdPuLc+/6LVWqsNi/PEBq1Jlovv/Nr9zuxv69UHWE/voMdgOz6P7LU7pr9pNIGpngcmKcLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NQfc5zvF; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6df0f9bcdso3863498276.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707142997; x=1707747797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+5NlV443+B7q3oSMetmnKtZavUAqBXHNm5S0epsUCIU=;
        b=NQfc5zvF8fb4Iv1czlnFnsrAGQULSpqyTntEPy8R0ej0wzEa/OfOKOMfoTYEgjkwsF
         oxc5xMVesQO/nN0FJUQlYcnUdroO2tU77lx/+LWQ/ieeeLAKaC0GB/p40j2syrtiLpR5
         r1KcUOaWLgOf06uVXrojPXonDNfW11SCyF34blWNBsufyh1YJ+7t2dtKUt65cXwJlnv1
         BgETtjgFC6Aruf6oI3H5Hj5N3uN49EHQB3IxGS8J2XPoI+/0oF8xx+VdDuDSDFVrcCc2
         p+e2gvEWNzkYft7AdwSSXZtaek7+xaaN5lljO8fJsWDDSmLEXPXp9vJerMe5zGvTxnfn
         1mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707142997; x=1707747797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5NlV443+B7q3oSMetmnKtZavUAqBXHNm5S0epsUCIU=;
        b=Yc9X1xIAW2ktKqXonFrqx5xuL//LEbvbvJvsvC3pmHUca0+opu9gnzbiobLYpwtuOM
         B/T1xidHz23KYUYJrG6MBkR2Z3rZFT9JRq0JBR+wMkyXLedBmJUDYegOYiuPEJnFAPiF
         pPR4PJwwdjRxUYgmu7kOKiM1/OmgoPwuR21gyIV649uGkbrcCo49kgJKYE00v/1tjn9n
         xnCOLZ8Rste2RLKqotkbU31bAoeUdk3WrNk7aSAqtyfNEWk1IeHRsWyEIiZ8NaahExY8
         14O2w7OhQNMq0fGZPR0agrtf7JqYloH7L/0+TCvAsv5ovZZp2cKu+P5qwI3Cf2cFuMEf
         x7vQ==
X-Gm-Message-State: AOJu0YwHV7DNtjOJMnpfILmK3ZVOrfWqLySJYV5v8Iym2MJcVkhpuEJH
	pXeS3mgHnWN9+LRJQtvVQ5kyonHupTFA4UbP3ibcqQIJIg5lMBJsk0L9ZTXZhscaipWdo+1dFWv
	56k1dsjlhWdAZmY2ob+Cugn30E7y0NLzMand6+A==
X-Google-Smtp-Source: AGHT+IEUlohlidLYzYqnXenkXiTLg3hicV5YhqMEsU4zqFnIKrsU4uVbegoKrmAkB3WpX/zLBRuIrICMW8TGUvdgVxg=
X-Received: by 2002:a25:acd2:0:b0:dc2:35c1:7d9c with SMTP id
 x18-20020a25acd2000000b00dc235c17d9cmr8131574ybd.60.1707142997250; Mon, 05
 Feb 2024 06:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com> <20240205115721.1195336-6-quic_jingyw@quicinc.com>
In-Reply-To: <20240205115721.1195336-6-quic_jingyw@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 5 Feb 2024 16:23:06 +0200
Message-ID: <CAA8EJpr7tHXZHcH1Sbcy0-MCZfMxKBjaPXGdpg3cqyyFjTZOeA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] arm64: dts: qcom: add base AIM500 dtsi
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	kernel@quicinc.com, Tingwei Zhang <quic_tingweiz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 14:00, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>
> Introduce aim500 board dtsi.

So, is it a board or a module?

>
> AIM500 Series is a highly optimized family of modules designed to
> support AIoT and Generative AI applications based on sm8650p with
> PMIC and bluetooth functions etc.
>
> Co-developed-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
> Signed-off-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi | 409 +++++++++++++++++++
>  1 file changed, 409 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
> new file mode 100644
> index 000000000000..cb857da8653b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8650p.dtsi"
> +#include "pm8550.dtsi"
> +#include "pm8550b.dtsi"
> +#define PMK8550VE_SID 8
> +#include "pm8550ve.dtsi"
> +#include "pm8550vs.dtsi"
> +#include "pmk8550.dtsi"
> +
> +/ {
> +       aliases {
> +               serial1 = &uart14;
> +       };
> +
> +       vph_pwr: vph-pwr-regulator { };

Is this regulator a part of the module or a part of the carrier board?
If the latter is true, this must go to the carrier board DT file.

> +};
> +
> +&apps_rsc {
> +       regulators-0 {
> +               compatible = "qcom,pm8550-rpmh-regulators";
> +
> +               vdd-bob1-supply = <&vph_pwr>;
> +               vdd-bob2-supply = <&vph_pwr>;
> +               vdd-l2-l13-l14-supply = <&vreg_bob1>;
> +               vdd-l3-supply = <&vreg_s1c_1p2>;
> +               vdd-l5-l16-supply = <&vreg_bob1>;
> +               vdd-l6-l7-supply = <&vreg_bob1>;
> +               vdd-l8-l9-supply = <&vreg_bob1>;
> +               vdd-l11-supply = <&vreg_s1c_1p2>;
> +               vdd-l12-supply = <&vreg_s6c_1p8>;
> +               vdd-l15-supply = <&vreg_s6c_1p8>;
> +               vdd-l17-supply = <&vreg_bob2>;
> +
> +               qcom,pmic-id = "b";

[skipped]

> +
> +&qupv3_id_1 {
> +       status = "okay";
> +};

No GPI node being enabled?

> +
> +&tlmm {
> +       bt_default: bt-default-state {
> +               bt-en-pins {
> +                       pins = "gpio17";
> +                       function = "gpio";
> +                       drive-strength = <16>;
> +                       bias-disable;
> +               };
> +
> +               sw-ctrl-pins {
> +                       pins = "gpio18";
> +                       function = "gpio";
> +                       bias-pull-down;
> +               };
> +       };
> +};
> +
> +&uart14 {
> +       status = "okay";
> +
> +       bluetooth {
> +               compatible = "qcom,wcn7850-bt";
> +
> +               clocks = <&rpmhcc RPMH_RF_CLK1>;
> +
> +               vddio-supply = <&vreg_l3c_1p2>;
> +               vddaon-supply = <&vreg_l15b_1p8>;
> +               vdddig-supply = <&vreg_s3c_0p9>;
> +               vddrfa0p8-supply = <&vreg_s3c_0p9>;
> +               vddrfa1p2-supply = <&vreg_s1c_1p2>;
> +               vddrfa1p9-supply = <&vreg_s6c_1p8>;
> +
> +               max-speed = <3200000>;
> +
> +               enable-gpios = <&tlmm 17 GPIO_ACTIVE_HIGH>;
> +               swctrl-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
> +
> +               pinctrl-0 = <&bt_default>;
> +               pinctrl-names = "default";
> +       };
> +};
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

