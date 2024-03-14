Return-Path: <linux-kernel+bounces-102966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AA887B931
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EF41C21344
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B845D732;
	Thu, 14 Mar 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hD7GlnzP"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21E15D497
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404379; cv=none; b=qXdwTiDL3U13ga8tco8e6evCiPjL5brYNw4AwYgTi3K3McgEa8Tiviak5IsWxY1cYwwpUPiI91KW5Vi79oYTtvHG7XAt7ieWKN/2MbA8utLpSoAfcgi+oJ+m+d73qpPFlfhZzw89LUgILS1vfcjaeMS/6Jd94tkjSuNrABSHdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404379; c=relaxed/simple;
	bh=IXY0wwQwDlRv4odrCfBTKygI9/tM2ICF/hkN3lASWe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb+69gSDXHPttN9vqEH6ru9aRag1Fev0t2dw5NimGdodmXmNkaw7OuHjck6qG6n+anKzOHF0IRX9MkahJNhjtSIP3woPx6nupSkzXLcx36ITuaGPHhE+/W1reZtqA6JgCSJTUfeb8QZCnn1eCJwsvNa83Rz+TX9y4lPGXLTT0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hD7GlnzP; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-475da36107bso261713137.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710404376; x=1711009176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tK+3kQqSlfPhFWBUtsWPYQNkWNEDMgLpBguwcQs2Jwk=;
        b=hD7GlnzPqf3p2Aymf1IWRETvwRF6dTbOdW5AUYuVASCPvEANVTzZgKvHCd6eP+bsXM
         Us8meQ1coa9cULZi3swGsVvu+hR0sdMtXXLHt5trciqwX4p8JoXYLVndYmfFlvvI39jj
         zttsA56270rj6TQZPPdQq+opbDp9tFUf4x/YjQqXReKlgjzHhvX7EA5KJmke/XgkW3kq
         5bsdJcADdGCCDSIlPIvIKEWzojxgQ2pPhLf/YOWPzFQ8TDLOoA2ftd8WiW63awIhvXyz
         2iC6w7rxMoKhVskJoCPUcnjop4VVN/aaaHY0TmvL4eJRjHnul/FiT4DzSpEr+CoA5P8h
         sUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710404376; x=1711009176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tK+3kQqSlfPhFWBUtsWPYQNkWNEDMgLpBguwcQs2Jwk=;
        b=s+M/jsVym1G4Icm+Bu0KJAR5+ZYCwOFVetJV7MsEdtfEP/Zb4wnGzs/icg+VATwBWX
         REYIXqab+EYQ7Hu+BEto1D+oc2i4F7x0WZmzw6/MWKZTnzODuVueRI2B8Md3QH3IhwNf
         BFuIgZUeQWnwRScc+W4kPvLEwKyGerqq4jZl/7iOXkTYLDFx20BUY/45XGHxavPJy/Rl
         2hZTgx4+8e2B5s1p0AiwmwstY2FcMvo0gO6lu9jv7OXvP5xdtLMVS+IczEukLLGx93sx
         0r32BLTBiRRfj9/1CnHyww2eq5zb6OPoTaLGOSBBYlQB0GF28NtNcDVMOjM5BKuj5b7H
         en4A==
X-Forwarded-Encrypted: i=1; AJvYcCWPuKbOznMTQwH18WwLlSu6hDJHEdgx9XWnFvGKfztGxziq1XBBE0XS4IpB8/salf/8Rwxph/1CIPYWU6/xv3QNjXcmlKu4tX1+Fn+K
X-Gm-Message-State: AOJu0YwoNS+z4COWGCGAV1EQ7hhb9I5myBe0xwv+5nVDyFvKPJ1iCo93
	pJYsoOy6C59pIvz6FucB9nD98zg1P3SQfyGmcoL/qdkPKqPznnuuSxhaQFawhCi108VMIG5Dyjm
	RyZyTw0LtAV7m9x5awrvmasAH2Cr/R6l5fyYPxw==
X-Google-Smtp-Source: AGHT+IGPQWkXK7MdgQEmauYaWdQfwjYuThqRNmj7dp6O2HGI3PntS4E9mND6iNXfPwnlSecTt+045PAaCABauVWMNJc=
X-Received: by 2002:a05:6102:508:b0:474:5f25:58a3 with SMTP id
 l8-20020a056102050800b004745f2558a3mr1176602vsa.19.1710404374994; Thu, 14 Mar
 2024 01:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org> <4a0a8db7-a2bc-4c99-94b2-c13facbd1bef@linaro.org>
In-Reply-To: <4a0a8db7-a2bc-4c99-94b2-c13facbd1bef@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Mar 2024 13:49:23 +0530
Message-ID: <CAFA6WYPh5BS_Fpi6ksAC7bwoFEyqjj1Y3EahyQxCG9Pp=KDw=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, stephan@gerhold.net, 
	caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
	jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Wed, 13 Mar 2024 at 18:30, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/03/2024 13:30, Sumit Garg wrote:
> > Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > Box Core board based on the Qualcomm APQ8016E SoC.
> >
>
> ...
>
> > +
> > +/ {
> > +     model = "Schneider Electric HMIBSC Board";
> > +     compatible = "schneider,apq8016-hmibsc", "qcom,apq8016";
> > +
> > +     aliases {
> > +             mmc0 = &sdhc_1; /* eMMC */
> > +             mmc1 = &sdhc_2; /* SD card */
> > +             serial0 = &blsp_uart1;
> > +             serial1 = &blsp_uart2;
> > +             usid0 = &pm8916_0;
> > +             i2c1 = &blsp_i2c6;
> > +             i2c3 = &blsp_i2c4;
> > +             i2c4 = &blsp_i2c3;
>
> The aliases should match schematics of the board, so I assume missing
> i2c2 is intentional, right?

Yeah that is intentional as per board schematics.

>
> > +             spi0 = &blsp_spi5;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path = "serial0";
> > +     };
> > +
> > +     memory@80000000 {
> > +             reg = <0 0x80000000 0 0x40000000>;
> > +     };
> > +
> > +     reserved-memory {
> > +             ramoops@bff00000 {
> > +                     compatible = "ramoops";
> > +                     reg = <0x0 0xbff00000 0x0 0x100000>;
> > +
> > +                     record-size = <0x20000>;
> > +                     console-size = <0x20000>;
> > +                     ftrace-size = <0x20000>;
> > +             };
> > +     };
> > +
> > +     usb2513 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> e.g. usb-hub
>

Okay, I will rename it to usb-hub.

>
>
> > +             compatible = "smsc,usb3503";
> > +             reset-gpios = <&pm8916_gpios 1 GPIO_ACTIVE_LOW>;
> > +             initial-mode = <1>;
> > +     };
> > +
> > +     usb_id: usb-id {
> > +             compatible = "linux,extcon-usb-gpio";
> > +             id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&usb_id_default>;
> > +     };
> > +
> > +     hdmi-out {
> > +             compatible = "hdmi-connector";
> > +             type = "a";
> > +
> > +             port {
> > +                     hdmi_con: endpoint {
> > +                             remote-endpoint = <&adv7533_out>;
> > +                     };
> > +             };
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +             autorepeat;
> > +
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&msm_key_volp_n_default>;
> > +
> > +             button {
> > +                     label = "Volume Up";
> > +                     linux,code = <KEY_VOLUMEUP>;
> > +                     gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> > +             };
> > +     };
> > +
> > +     leds {
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pm8916_mpps_leds>;
>
> First property is always compatible. Please apply DTS coding style rules.

Ack.

>
> > +
> > +             compatible = "gpio-leds";
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
>
> That's not a bus.
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).

I assumed earlier that W=1 is sufficient for DT schema checks but it
looks like those are two different entities. However, I added these
address and size cells properties only to get rid of warnings reported
by W=1, see below:

$ make qcom/apq8016-schneider-hmibsc.dtb W=1
  DTC     arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts:96.9-103.5:
Warning (unit_address_vs_reg): /leds/led@5: node has a unit name, but
no reg or ranges property
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts:105.9-112.5:
Warning (unit_address_vs_reg): /leds/led@6: node has a unit name, but
no reg or ranges property
<snip>

So it looks like W=1 is reporting false warnings and we should rather
rely on dtbs_check only.

>
> > +
> > +             led@5 {
> > +                     reg = <5>;
> > +                     label = "apq8016-hmibsc:green:wlan";
> > +                     function = LED_FUNCTION_WLAN;
> > +                     color = <LED_COLOR_ID_YELLOW>;
> > +                     gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "phy0tx";
> > +                     default-state = "off";
> > +             };
> > +
> > +             led@6 {
> > +                     reg = <6>;
> > +                     label = "apq8016-hmibsc:yellow:bt";
> > +                     function = LED_FUNCTION_BLUETOOTH;
> > +                     color = <LED_COLOR_ID_BLUE>;
> > +                     gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "bluetooth-power";
> > +                     default-state = "off";
> > +             };
> > +     };
> > +};
> > +
> > +&blsp_i2c3 {
> > +     status = "okay";
> > +
> > +     eeprom@50 {
> > +             compatible = "atmel,24c32";
> > +             reg = <0x50>;
> > +     };
> > +};
> > +
> > +&blsp_i2c4 {
> > +     status = "okay";
> > +
> > +     adv_bridge: bridge@39 {
> > +             status = "okay";
>
> Why do you need it? Was it disabled?
>
> And why this is before compatible? If this stays, please use DTS coding
> style rules for placement.

Okay I will remove it.

>
> > +
> > +             compatible = "adi,adv7533";
> > +             reg = <0x39>;
> > +
> > +             interrupt-parent = <&tlmm>;
> > +             interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> > +
> > +             adi,dsi-lanes = <4>;
> > +             clocks = <&rpmcc RPM_SMD_BB_CLK2>;
> > +             clock-names = "cec";
> > +
> > +             pd-gpios = <&tlmm 32 GPIO_ACTIVE_HIGH>;
> > +
> > +             avdd-supply = <&pm8916_l6>;
> > +             a2vdd-supply = <&pm8916_l6>;
> > +             dvdd-supply = <&pm8916_l6>;
> > +             pvdd-supply = <&pm8916_l6>;
> > +             v1p2-supply = <&pm8916_l6>;
> > +             v3p3-supply = <&pm8916_l17>;
> > +
> > +             pinctrl-names = "default","sleep";
> > +             pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
> > +             pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
> > +             #sound-dai-cells = <1>;
> > +
> > +             ports {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +
> > +                     port@0 {
> > +                             reg = <0>;
> > +                             adv7533_in: endpoint {
> > +                                     remote-endpoint = <&mdss_dsi0_out>;
> > +                             };
> > +                     };
> > +
> > +                     port@1 {
> > +                             reg = <1>;
> > +                             adv7533_out: endpoint {
> > +                                     remote-endpoint = <&hdmi_con>;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&blsp_i2c6 {
> > +     status = "okay";
> > +
> > +     rtc@30 {
> > +             compatible = "sii,s35390a";
> > +             reg = <0x30>;
> > +     };
> > +
> > +     eeprom@50 {
> > +             compatible = "atmel,24c256";
> > +             reg = <0x50>;
> > +     };
> > +};
> > +
> > +&blsp_spi5 {
> > +     status = "okay";
> > +     cs-gpios = <&tlmm 18 GPIO_ACTIVE_LOW>;
> > +
> > +     tpm@0 {
> > +             compatible = "tcg,tpm_tis-spi";
> > +             reg = <0>;
> > +             spi-max-frequency = <500000>;
> > +     };
> > +};
> > +
> > +&blsp_uart1 {
> > +     status = "okay";
> > +     label = "UART0";
> > +};
> > +
> > +&blsp_uart2 {
> > +     status = "okay";
> > +     label = "UART1";
> > +};
> > +
> > +&lpass {
> > +     status = "okay";
> > +};
> > +
> > +&mdss {
> > +     status = "okay";
> > +};
> > +
> > +&mdss_dsi0_out {
> > +     data-lanes = <0 1 2 3>;
> > +     remote-endpoint = <&adv7533_in>;
> > +};
> > +
> > +&pm8916_codec {
> > +     status = "okay";
> > +     qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
> > +     qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
> > +};
> > +
> > +&pm8916_resin {
> > +     status = "okay";
> > +     linux,code = <KEY_POWER>;
> > +};
> > +
> > +&pm8916_rpm_regulators {
> > +     pm8916_l17: l17 {
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +     };
> > +};
> > +
> > +&sdhc_1 {
> > +     status = "okay";
> > +};
> > +
> > +&sdhc_2 {
> > +     status = "okay";
> > +
> > +     pinctrl-names = "default", "sleep";
> > +     pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
> > +     pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
> > +
> > +     cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
> > +};
> > +
> > +&sound {
> > +     status = "okay";
>
> Is thi sneeded?

Yeah it is disabled by default.

>
> > +
> > +     pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
> > +     pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
> > +     pinctrl-names = "default", "sleep";
> > +     model = "DB410c";
> > +     audio-routing =
> > +             "AMIC2", "MIC BIAS Internal2",
> > +             "AMIC3", "MIC BIAS External1";
> > +
> > +     quaternary-dai-link {
> > +             link-name = "ADV7533";
> > +             cpu {
> > +                     sound-dai = <&lpass MI2S_QUATERNARY>;
> > +             };
> > +             codec {
> > +                     sound-dai = <&adv_bridge 0>;
> > +             };
> > +     };
> > +
> > +     primary-dai-link {
> > +             link-name = "WCD";
> > +             cpu {
> > +                     sound-dai = <&lpass MI2S_PRIMARY>;
> > +             };
> > +             codec {
> > +                     sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
> > +             };
> > +     };
> > +
> > +     tertiary-dai-link {
> > +             link-name = "WCD-Capture";
> > +             cpu {
> > +                     sound-dai = <&lpass MI2S_TERTIARY>;
> > +             };
> > +             codec {
> > +                     sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
> > +             };
> > +     };
> > +};
> > +
> > +&usb {
> > +     status = "okay";
> > +     extcon = <&usb_id>, <&usb_id>;
> > +
> > +     pinctrl-names = "default", "device";
> > +     pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
> > +     pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
> > +};
> > +
> > +&usb_hs_phy {
> > +     extcon = <&usb_id>;
> > +};
> > +
> > +&wcnss {
> > +     status = "okay";
> > +     firmware-name = "qcom/apq8016/wcnss.mbn";
> > +};
> > +
> > +&wcnss_ctrl {
> > +     firmware-name = "qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin";
> > +};
> > +
> > +&wcnss_iris {
> > +     compatible = "qcom,wcn3620";
> > +};
> > +
> > +&wcnss_mem {
> > +     status = "okay";
> > +};
> > +
> > +/* Enable CoreSight */
> > +&cti0 { status = "okay"; };
> > +&cti1 { status = "okay"; };
> > +&cti12 { status = "okay"; };
> > +&cti13 { status = "okay"; };
> > +&cti14 { status = "okay"; };
> > +&cti15 { status = "okay"; };
> > +&debug0 { status = "okay"; };
> > +&debug1 { status = "okay"; };
> > +&debug2 { status = "okay"; };
> > +&debug3 { status = "okay"; };
> > +&etf { status = "okay"; };
> > +&etm0 { status = "okay"; };
> > +&etm1 { status = "okay"; };
> > +&etm2 { status = "okay"; };
> > +&etm3 { status = "okay"; };
> > +&etr { status = "okay"; };
> > +&funnel0 { status = "okay"; };
> > +&funnel1 { status = "okay"; };
> > +&replicator { status = "okay"; };
> > +&stm { status = "okay"; };
> > +&tpiu { status = "okay"; };
> > +
> > +/*
> > + * 2mA drive strength is not enough when connecting multiple
> > + * I2C devices with different pull up resistors.
> > + */
> > +
> > +&blsp_i2c4_default {
>
> None of your overrides look like have proper alphabetical order. Please
> use alphabetical order.
>

Although these are already following the same order as
apq8016-sbc.dts, would you like the two DTS files based on the same
SoC to follow different orders?

-Sumit

>
>
> Best regards,
> Krzysztof
>

