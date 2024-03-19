Return-Path: <linux-kernel+bounces-107329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0DD87FB21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC3E28288E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC17E0FB;
	Tue, 19 Mar 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkJym5mj"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1A7D3F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841950; cv=none; b=KnV3ztVksACnuvf1QoyKTMYET8xseggOUghEOcPheI7k8WzQdaOvKLtpTS/y04yKmtjMWULHjohT6o87EtGlJFKDbr6J5OwUOgc0aPxRVJX+FgN5HJI4GdLrPW5xeh0c17/6hYFvdq7dnPGBUH7os4VwHTdi4ciqNBG1Yy2lzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841950; c=relaxed/simple;
	bh=GBn2DTXzIExCHBi5QRFqEjOBO93zlSboxWgc4rPCncY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1CGjC56LvsgaGBNmV/ZAVYPl/TXYkm3TYNUGVleoxhRZ/J6aJ86FrRHQRFdeQxdK06Dm6VyaBpnypwn147bBDxcgFKHhY5j0XbMimMqJmtka0Lu7T4gp9hcemBkQucu6wtjjr/QLFEtsbygi2Qvm5MmDH3yaHnE/0QRfdqPrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FkJym5mj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60a0a54869bso48079417b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710841947; x=1711446747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6LcXKMDysqMRqbalBzfZO3pv8QVanE6pMSkVm/ZUmU=;
        b=FkJym5mj45ia5WYaUoejisQWBJcjOG01oDb84UZ0dr06rhdQL5Xf+v28nPjWMtph3u
         gVKl91Qr9vVxjliiYzl19DnGrCxAcfd1hhJcDbSGi3Dfhp0jqxrKMshvi0hWyjGaNIfk
         T4PycqH9uaDKxqdvy9xt4LyBzVmXmoO5OAYzWcboYA20Bll2RDkYuRwlO0tai7PKMszD
         9S7LSQ/heiW9j++oJxDXwcs1bNbv2OtDML9vnQ3Sku0jnXC+LhZBWBOKUOtXtiHGKfsN
         L8ySfnsTNbmDDRzAMA1weymtsIHSUXsxDmNCsJ2zIsSPKwYSunP80SKNHRm1/XjmW2W9
         yH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841947; x=1711446747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6LcXKMDysqMRqbalBzfZO3pv8QVanE6pMSkVm/ZUmU=;
        b=PgO2pysveAQ3sEoDKiXAKS3Nga9MXRsOFJJF+EpMNzenOF8jqnrIvxc4pkn7/5Zg9E
         ZH3UgkbFRB4/YinUKF6/47zeobB+i1qkXERdvxUQA0h/BKhA7V9cC/LvcbEX0oNAu1wl
         kKKiDQcZ3qY0mkJJca31Tgc3HZIjGT8WldWArQoMYz5kKTgVYcCub/iBORoRg5eBWQTS
         dnpUra/SC0SFGXdLLUHMMas8WANcCdADT3PmMooHSp0zSu/R9ZSBW8KvroqsqGJ3xW18
         GHO+Ho8FAs3rkr8sHJ/VVfJ9goski9IP13Id/nzm1kdqzjgcDYAYYCe4xrGhwSDxn6DY
         SGHA==
X-Forwarded-Encrypted: i=1; AJvYcCWs1+7KUB4nmuLHY4ocjfpHJLA5vMZb8P7U5PDI9Bu/93CrxFoX56sI+m7uA3tgOSpbOyctu7R1INyMe7ZbEtuAFCLDz6wbmTURyC0q
X-Gm-Message-State: AOJu0YwR/ZmSVHmfB+w7PmJTm+4dLyy/Apvyd03+j/UY6Rsyz86jJhfk
	2fsC6IHGbxCIwr3pDgqdF23gx58Z4fLa8fPU6ezI9jXVe5qwMFrUE0AccluIDLebTg8IxOUPVt/
	w4+1Vnr5AMpxHDJwp6DW/1vYBkHXUs9g2RrB7xg==
X-Google-Smtp-Source: AGHT+IFTqEoL7jp7hhkfRsn7rpaBt243clxqWrclDc1Z7lnJmPK+XyJkd/EUhpiMA9iu8JUpLTB8zbYI2fio+utI0IA=
X-Received: by 2002:a0d:e7c2:0:b0:610:e891:838c with SMTP id
 q185-20020a0de7c2000000b00610e891838cmr279556ywe.7.1710841947304; Tue, 19 Mar
 2024 02:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319091020.15137-1-quic_kbajaj@quicinc.com> <20240319091020.15137-3-quic_kbajaj@quicinc.com>
In-Reply-To: <20240319091020.15137-3-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 11:52:15 +0200
Message-ID: <CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABFBcRt-9BQaCberg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qdu1000-idp: enable USB nodes
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Amrit Anand <quic_amrianan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 11:11, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Enable both USB controllers and associated hsphy and qmp phy
> nodes on QDU1000 IDP. Add the usb type B port linked with the
> DWC3 USB controller switched to OTG mode and tagged with
> usb-role-switch.
>
> Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 65 ++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index 89b84fb0f70a..26442e707b5e 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -46,6 +46,33 @@ ppvar_sys: ppvar-sys-regulator {
>                 regulator-boot-on;
>         };
>
> +       usb_conn_gpio: usb-conn-gpio {
> +               compatible = "gpio-usb-b-connector";

If this board has only a USB-B connector, can it really handle USB 3.0?

> +               vbus-gpio =  <&pm8150_gpios 7 GPIO_ACTIVE_HIGH>;
> +               id-gpio = <&tlmm 42 GPIO_ACTIVE_HIGH>;
> +               vbus-supply = <&vbus_supply_regulator>;
> +
> +               pinctrl-0 = <&usb_vbus_det_default
> +                            &usb_id_det_default>;
> +               pinctrl-names = "default";
> +
> +               port {
> +                       usb_port0_connector: endpoint {
> +                               remote-endpoint = <&usb_1_dwc3_hs>;
> +                       };
> +               };
> +       };
> +
> +       vbus_supply_regulator: vbus-supply-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vbus_supply";
> +
> +               gpio = <&tlmm 43 GPIO_ACTIVE_HIGH>;
> +               pinctrl-0 = <&usb_vbus_boost_default>;
> +               pinctrl-names = "default";
> +               enable-active-high;
> +       };
> +
>         vph_pwr: vph-pwr-regulator {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vph_pwr";
> @@ -239,6 +266,16 @@ vreg_l18a_1p2: ldo18 {
>         };
>  };
>
> +&pm8150_gpios {
> +       usb_vbus_det_default: usb-vbus-det-default {
> +               pins = "gpio7";
> +               function = "normal";
> +               input-enable;
> +               bias-pull-up;
> +               power-source = <0>;
> +       };
> +};
> +
>  &qup_i2c1_data_clk {
>         drive-strength = <2>;
>         bias-pull-up;
> @@ -500,3 +537,31 @@ &tlmm {
>  &uart7 {
>         status = "okay";
>  };
> +
> +&usb_1 {
> +       status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +       dr_mode = "otg";

Nit: this is the default setting.

> +       usb-role-switch;
> +};
> +
> +&usb_1_dwc3_hs {
> +       remote-endpoint = <&usb_port0_connector>;
> +};
> +
> +&usb_1_hsphy {
> +       vdda-pll-supply = <&vreg_l8a_0p91>;
> +       vdda18-supply = <&vreg_l14a_1p8>;
> +       vdda33-supply = <&vreg_l2a_2p3>;
> +
> +       status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +       vdda-phy-supply = <&vreg_l8a_0p91>;
> +       vdda-pll-supply = <&vreg_l3a_1p2>;
> +
> +       status = "okay";
> +};
> --
> 2.42.0
>
>


-- 
With best wishes
Dmitry

