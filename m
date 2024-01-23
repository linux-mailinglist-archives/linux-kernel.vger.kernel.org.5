Return-Path: <linux-kernel+bounces-34968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCD6838A02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A376D1C26397
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5B57892;
	Tue, 23 Jan 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfGZpR6s"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934658115
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001054; cv=none; b=R/vOtgCsbDR2pY5J2WytNlH9meC/7U0UkwpTvEcKfoIHJNUf1TqCTAeZ5f3mlvg1Ey6T1a3+UXeKLQ6YweqdfslQ/Nhv2RdkxnGOtp0jjFa4GI3pdV7Hlwx1bI0LyShq9fC97l76inxpfiMrVGpBMAha3P/KzCmivqP5BFxBXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001054; c=relaxed/simple;
	bh=BZ8My0GcvpmmQTkr/hksEfUcA+/UHCoSU4Dx8MDQU7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjGTmWQvctBQNmKT7flpVQ984ZWUmkbGaB7ETPsbAPnCxWNrzINSCVbqmTJMSQ3pwZnUES03IWvLJoQrgfJUeZ/3rcWAkpVBksOG7/qj817J44qfDzZnnb63poGoc2EwuqXfgVjANA/H3nMAjPpVPUfQvKGq1kdeDKjyRJnD9VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfGZpR6s; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff828b93f0so34725017b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706001051; x=1706605851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XYeJgUsJ4dhpCSMzMevtmij9ksIEjuq9yqzArBiUJX8=;
        b=TfGZpR6sD4JHGWek3xCfAEqHEZtXnbbJlVEFmee1RiEVAhc7JuUA7UmkeRNK8HGOn2
         PKdlRNcZr1utqFUsbyd6I+RlwrYN3Z3EY9CrgNQTOsv9tMqBbyWaH0kWz/6s3OIDVH2l
         GrWAEd9UV2h+HKWMYvZjPCKt2o873HmZu4ekRzuFPTqzqWcJEJ7eoXbthUQ1JydODvZU
         oreFoC2bCqfOAY3L31DQCJQPiKJmea6yPKIdXIehWI9o/nF2i89izaHsyHoD1rYA5Osv
         ulybL+h1rqWQPx5u7dpuPkx3zmCyBvq+SyUlbuJL4fPVZQn+BCu5A4zYy+FXXOT9dJb3
         kuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001051; x=1706605851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYeJgUsJ4dhpCSMzMevtmij9ksIEjuq9yqzArBiUJX8=;
        b=f0nrxY7f20fvv6ntZNkSexwg6GrBj7UtRt3wTgFR4uXWyjGdQPuEYrOni+R7qH9Qvt
         YjX5nui6eLEn8ldYbqf2ChJ71eYsqTz4prjU+YF6KO/JW8Sh8qqVWmLRU6ZUi/VKq06y
         /WTsMsguTKlhpzHEM5+QlfFg2JdV//9z9QaxnHtqc+Hbe2iFpd87ZaO+ZWimmfF3tMTP
         LSbSfBGNntnWjxQ7oECIA+ATC3LowT6rv7GLKbEHmBQ4Ib+aCZqrQaZTQRd8sGNkhpZr
         QFUaGpnabspGmMA8ez2t7MSt+Mnn288yJfTu9Ylo2nidOrM6pt2eugFVO5KMqs38w4HT
         n2Ww==
X-Gm-Message-State: AOJu0YxWOClNL8Y7Kcp+HhEC1f/xbs3Z+1vNMeYzCkJmIsA9g5QeV8B7
	Kz3JNJiLJYFcAg+HEhQeUxr79qG7DMOcvMSSECkSKmap36kNT42lstHOY46yQu3d2ZOxWoMl/pK
	PMBgoiq0FLjlZL9fwEYCr2mpNHiBKDXn1c7vv9NKAC/XWRZDErwY=
X-Google-Smtp-Source: AGHT+IGlG3AYnq6/4a/xx9HGrBGsTzeOjWsIANBve5gqxs/P03+SuOwRugTcBv70x1M+IuphYx9PHRgqXyEZld08kAw=
X-Received: by 2002:a81:718a:0:b0:5ff:ab77:7913 with SMTP id
 m132-20020a81718a000000b005ffab777913mr3112754ywc.63.1706001050548; Tue, 23
 Jan 2024 01:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-topic-sm8550-upstream-hdk8550-v2-0-99fba09fbfda@linaro.org>
 <20240123-topic-sm8550-upstream-hdk8550-v2-2-99fba09fbfda@linaro.org>
In-Reply-To: <20240123-topic-sm8550-upstream-hdk8550-v2-2-99fba09fbfda@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jan 2024 11:10:39 +0200
Message-ID: <CAA8EJppi4dkB4N-YStVazfwH2quaFM6iQTv7UoOseEYQ7EEx3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8550: add support for the
 SM8550-HDK board
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 10:56, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The SM8550-HDK is an embedded development platforms for the
> Snapdragon 8 Gen 2 SoC aka SM8550, with the following features:
> - Qualcomm SM8550 SoC
> - 16GiB On-board LPDDR5
> - On-board WiFi 7 + Bluetooth 5.3/BLE
> - On-board UFS4.0
> - M.2 Key B+M Gen3x2 PCIe Slot
> - HDMI Output
> - USB-C Connector with DP Almode & Audio Accessory mode
> - Micro-SDCard Slot
> - Audio Jack with Playback and Microphone
> - 2 On-board Analog microphones
> - 2 On-board Speakers
> - 96Boards Compatible Low-Speed and High-Speed connectors [1]
>   - For Camera, Sensors and external Display cards
>   - Compatible with the Linaro Debug board [2]
> - SIM Slot for Modem
> - Debug connectors
> - 6x On-Board LEDs
>
> Product Page: [3]
>
> [1] https://www.96boards.org/specifications/
> [2] https://git.codelinaro.org/linaro/qcomlt/debugboard
> [3] https://www.lantronix.com/products/snapdragon-8-gen-2-mobile-hardware-development-kit/
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |    1 +
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 1290 +++++++++++++++++++++++++++++++
>  2 files changed, 1291 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 39889d5f8e12..42e50f2b2ec3 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -233,6 +233,7 @@ dtb-$(CONFIG_ARCH_QCOM)     += sm8450-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sm8450-qrd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sm8450-sony-xperia-nagara-pdx223.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sm8450-sony-xperia-nagara-pdx224.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sm8550-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sm8550-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sm8550-qrd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sm8650-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> new file mode 100644
> index 000000000000..66bdd6c269ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> @@ -0,0 +1,1290 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024 Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8550.dtsi"
> +#include "pm8010.dtsi"
> +#include "pm8550.dtsi"
> +#include "pm8550b.dtsi"
> +#define PMK8550VE_SID 5

Maybe the define should be moved before all include files and
separated with the blank line?

> +#include "pm8550ve.dtsi"
> +#include "pm8550vs.dtsi"
> +#include "pmk8550.dtsi"
> +#include "pmr735d_a.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. SM8550 HDK";
> +       compatible = "qcom,sm8550-hdk", "qcom,sm8550";
> +       chassis-type = "embedded";
> +
> +       aliases {
> +               serial0 = &uart7;
> +               serial1 = &uart14;
> +       };
> +
> +       wcd938x: audio-codec {
> +               compatible = "qcom,wcd9385-codec";
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wcd_default>;
> +
> +               qcom,micbias1-microvolt = <1800000>;
> +               qcom,micbias2-microvolt = <1800000>;
> +               qcom,micbias3-microvolt = <1800000>;
> +               qcom,micbias4-microvolt = <1800000>;
> +               qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +               qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +               qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +               qcom,rx-device = <&wcd_rx>;
> +               qcom,tx-device = <&wcd_tx>;
> +
> +               reset-gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
> +
> +               vdd-buck-supply = <&vreg_l15b_1p8>;
> +               vdd-rxtx-supply = <&vreg_l15b_1p8>;
> +               vdd-io-supply = <&vreg_l15b_1p8>;
> +               vdd-mic-bias-supply = <&vreg_bob1>;
> +
> +               #sound-dai-cells = <1>;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       hdmi-out {
> +               compatible = "hdmi-connector";
> +               type = "a";
> +
> +               port {
> +                       hdmi_connector_out: endpoint {
> +                               remote-endpoint = <&lt9611_out>;
> +                       };
> +               };
> +       };
> +
> +       vreg_bob_3v3: vreg-bob-3v3-regulator {

Please rename all regulator nodes to start from the word regulator-.
This allows grouping them in a logical way.

> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "VREG_BOB_3P3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               vin-supply = <&vph_pwr>;
> +       };
> +
> +       lt9611_1v2: lt9611-vdd12-regulator {
> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "LT9611_1V2";
> +               regulator-min-microvolt = <1200000>;
> +               regulator-max-microvolt = <1200000>;
> +
> +               vin-supply = <&vph_pwr>;
> +               gpio = <&tlmm 152 GPIO_ACTIVE_HIGH>;
> +
> +               enable-active-high;
> +       };
> +
> +       lt9611_3v3: lt9611-3v3-regulator {
> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "LT9611_3V3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               vin-supply = <&vreg_bob_3v3>;
> +               gpio = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +
> +               enable-active-high;
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +
> +               pinctrl-0 = <&volume_up_n>;
> +               pinctrl-names = "default";
> +
> +               key-volume-up {
> +                       label = "Volume Up";
> +                       linux,code = <KEY_VOLUMEUP>;
> +                       gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
> +                       debounce-interval = <15>;
> +                       linux,can-disable;
> +                       wakeup-source;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               led-0 {
> +                       function = LED_FUNCTION_BLUETOOTH;
> +                       color = <LED_COLOR_ID_BLUE>;
> +                       gpios = <&tlmm 159 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "bluetooth-power";
> +                       default-state = "off";
> +               };
> +
> +               led-1 {
> +                       function = LED_FUNCTION_INDICATOR;
> +                       color = <LED_COLOR_ID_GREEN>;
> +                       gpios = <&tlmm 160 GPIO_ACTIVE_HIGH>;
> +                       default-state = "off";
> +                       panic-indicator;
> +               };
> +
> +               led-2 {
> +                       function = LED_FUNCTION_WLAN;
> +                       color = <LED_COLOR_ID_ORANGE>;
> +                       gpios = <&tlmm 162 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "phy0tx";
> +                       default-state = "off";
> +               };
> +       };
> +
> +       pmic-glink {
> +               compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
> +
> +               connector@0 {
> +                       compatible = "usb-c-connector";
> +                       reg = <0>;
> +                       power-role = "dual";
> +                       data-role = "dual";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +
> +                                       pmic_glink_hs_in: endpoint {
> +                                               remote-endpoint = <&usb_1_dwc3_hs>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +
> +                                       pmic_glink_ss_in: endpoint {
> +                                               remote-endpoint = <&usb_dp_qmpphy_out>;
> +                                       };
> +                               };
> +
> +                               port@2 {
> +                                       reg = <2>;
> +
> +                                       pmic_glink_sbu: endpoint {
> +                                               remote-endpoint = <&fsa4480_sbu_mux>;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +
> +       sound {
> +               compatible = "qcom,sm8550-sndcard", "qcom,sm8450-sndcard";
> +               model = "SM8550-HDK";
> +               audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
> +                               "SpkrRight IN", "WSA_SPK2 OUT",
> +                               "IN1_HPHL", "HPHL_OUT",
> +                               "IN2_HPHR", "HPHR_OUT",
> +                               "AMIC1", "MIC BIAS1",
> +                               "AMIC2", "MIC BIAS2",
> +                               "AMIC5", "MIC BIAS4",
> +                               "TX SWR_ADC0", "ADC1_OUTPUT",
> +                               "TX SWR_ADC1", "ADC2_OUTPUT",
> +                               "TX SWR_ADC3", "ADC4_OUTPUT";
> +
> +

Single empty line, please.

> +               wcd-playback-dai-link {
> +                       link-name = "WCD Playback";
> +
> +                       cpu {
> +                               sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
> +                       };
> +
> +                       platform {
> +                               sound-dai = <&q6apm>;
> +                       };
> +               };
> +
> +               wcd-capture-dai-link {
> +                       link-name = "WCD Capture";
> +
> +                       cpu {
> +                               sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&wcd938x 1>, <&swr2 0>, <&lpass_txmacro 0>;
> +                       };
> +
> +                       platform {
> +                               sound-dai = <&q6apm>;
> +                       };
> +               };
> +
> +               wsa-dai-link {
> +                       link-name = "WSA Playback";
> +
> +                       cpu {
> +                               sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&north_spkr>, <&south_spkr>, <&swr0 0>, <&lpass_wsamacro 0>;
> +                       };
> +
> +                       platform {
> +                               sound-dai = <&q6apm>;
> +                       };
> +               };
> +
> +               va-dai-link {
> +                       link-name = "VA Capture";
> +
> +                       cpu {
> +                               sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&lpass_vamacro 0>;
> +                       };
> +
> +                       platform {
> +                               sound-dai = <&q6apm>;
> +                       };
> +               };
> +       };
> +
> +       vph_pwr: vph-pwr-regulator {
> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "vph_pwr";
> +               regulator-min-microvolt = <3700000>;
> +               regulator-max-microvolt = <3700000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +};
> +
> +&apps_rsc {
> +       regulators-0 {
> +               compatible = "qcom,pm8550-rpmh-regulators";
> +
> +               vdd-bob1-supply = <&vph_pwr>;
> +               vdd-bob2-supply = <&vph_pwr>;
> +               vdd-l1-l4-l10-supply = <&vreg_s6g_1p86>;
> +               vdd-l2-l13-l14-supply = <&vreg_bob1>;
> +               vdd-l3-supply = <&vreg_s4g_1p25>;
> +               vdd-l5-l16-supply = <&vreg_bob1>;
> +               vdd-l6-l7-supply = <&vreg_bob1>;
> +               vdd-l8-l9-supply = <&vreg_bob1>;
> +               vdd-l11-supply = <&vreg_s4g_1p25>;
> +               vdd-l12-supply = <&vreg_s6g_1p86>;
> +               vdd-l15-supply = <&vreg_s6g_1p86>;
> +               vdd-l17-supply = <&vreg_bob2>;
> +
> +               qcom,pmic-id = "b";
> +
> +               vreg_bob1: bob1 {
> +                       regulator-name = "vreg_bob1";
> +                       regulator-min-microvolt = <3296000>;
> +                       regulator-max-microvolt = <3960000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_bob2: bob2 {
> +                       regulator-name = "vreg_bob2";
> +                       regulator-min-microvolt = <2720000>;
> +                       regulator-max-microvolt = <3960000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l1b_1p8: ldo1 {
> +                       regulator-name = "vreg_l1b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2b_3p0: ldo2 {
> +                       regulator-name = "vreg_l2b_3p0";
> +                       regulator-min-microvolt = <3008000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l5b_3p1: ldo5 {
> +                       regulator-name = "vreg_l5b_3p1";
> +                       regulator-min-microvolt = <3104000>;
> +                       regulator-max-microvolt = <3104000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l6b_1p8: ldo6 {
> +                       regulator-name = "vreg_l6b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l7b_1p8: ldo7 {
> +                       regulator-name = "vreg_l7b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l8b_1p8: ldo8 {
> +                       regulator-name = "vreg_l8b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l9b_2p9: ldo9 {
> +                       regulator-name = "vreg_l9b_2p9";
> +                       regulator-min-microvolt = <2960000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l11b_1p2: ldo11 {
> +                       regulator-name = "vreg_l11b_1p2";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1504000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l12b_1p8: ldo12 {
> +                       regulator-name = "vreg_l12b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l13b_3p0: ldo13 {
> +                       regulator-name = "vreg_l13b_3p0";
> +                       regulator-min-microvolt = <3000000>;
> +                       regulator-max-microvolt = <3000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l14b_3p2: ldo14 {
> +                       regulator-name = "vreg_l14b_3p2";
> +                       regulator-min-microvolt = <3200000>;
> +                       regulator-max-microvolt = <3200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l15b_1p8: ldo15 {
> +                       regulator-name = "vreg_l15b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l16b_2p8: ldo16 {
> +                       regulator-name = "vreg_l16b_2p8";
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <2800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l17b_2p5: ldo17 {
> +                       regulator-name = "vreg_l17b_2p5";
> +                       regulator-min-microvolt = <2504000>;
> +                       regulator-max-microvolt = <2504000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-1 {
> +               compatible = "qcom,pm8550vs-rpmh-regulators";
> +
> +               vdd-l1-supply = <&vreg_s4g_1p25>;
> +               vdd-l2-supply = <&vreg_s4e_0p95>;
> +               vdd-l3-supply = <&vreg_s4e_0p95>;
> +
> +               qcom,pmic-id = "c";
> +
> +               vreg_l3c_0p9: ldo3 {
> +                       regulator-name = "vreg_l3c_0p9";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <912000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-2 {
> +               compatible = "qcom,pm8550vs-rpmh-regulators";
> +
> +               vdd-l1-supply = <&vreg_s4e_0p95>;
> +               vdd-l2-supply = <&vreg_s4e_0p95>;
> +               vdd-l3-supply = <&vreg_s4e_0p95>;
> +
> +               qcom,pmic-id = "d";
> +
> +               vreg_l1d_0p88: ldo1 {
> +                       regulator-name = "vreg_l1d_0p88";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <920000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               /* ldo2 supplies SM8550 VDD_LPI_MX */
> +       };
> +
> +       regulators-3 {
> +               compatible = "qcom,pm8550vs-rpmh-regulators";
> +
> +               vdd-l1-supply = <&vreg_s4e_0p95>;
> +               vdd-l2-supply = <&vreg_s4e_0p95>;
> +               vdd-l3-supply = <&vreg_s4g_1p25>;
> +               vdd-s4-supply = <&vph_pwr>;
> +               vdd-s5-supply = <&vph_pwr>;
> +
> +               qcom,pmic-id = "e";
> +
> +               vreg_s4e_0p95: smps4 {
> +                       regulator-name = "vreg_s4e_0p95";
> +                       regulator-min-microvolt = <904000>;
> +                       regulator-max-microvolt = <984000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s5e_1p08: smps5 {
> +                       regulator-name = "vreg_s5e_1p08";
> +                       regulator-min-microvolt = <1080000>;
> +                       regulator-max-microvolt = <1120000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l1e_0p88: ldo1 {
> +                       regulator-name = "vreg_l1e_0p88";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <880000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2e_0p9: ldo2 {
> +                       regulator-name = "vreg_l2e_0p9";
> +                       regulator-min-microvolt = <904000>;
> +                       regulator-max-microvolt = <970000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3e_1p2: ldo3 {
> +                       regulator-name = "vreg_l3e_1p2";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-4 {
> +               compatible = "qcom,pm8550ve-rpmh-regulators";
> +
> +               vdd-l1-supply = <&vreg_s4e_0p95>;
> +               vdd-l2-supply = <&vreg_s4e_0p95>;
> +               vdd-l3-supply = <&vreg_s4e_0p95>;
> +               vdd-s4-supply = <&vph_pwr>;
> +
> +               qcom,pmic-id = "f";
> +
> +               vreg_s4f_0p5: smps4 {
> +                       regulator-name = "vreg_s4f_0p5";
> +                       regulator-min-microvolt = <500000>;
> +                       regulator-max-microvolt = <700000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l1f_0p9: ldo1 {
> +                       regulator-name = "vreg_l1f_0p9";
> +                       regulator-min-microvolt = <912000>;
> +                       regulator-max-microvolt = <912000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2f_0p88: ldo2 {
> +                       regulator-name = "vreg_l2f_0p88";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <912000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3f_0p88: ldo3 {
> +                       regulator-name = "vreg_l3f_0p88";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <912000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-5 {
> +               compatible = "qcom,pm8550vs-rpmh-regulators";
> +
> +               vdd-l1-supply = <&vreg_s4g_1p25>;
> +               vdd-l2-supply = <&vreg_s4g_1p25>;
> +               vdd-l3-supply = <&vreg_s4g_1p25>;
> +               vdd-s1-supply = <&vph_pwr>;
> +               vdd-s2-supply = <&vph_pwr>;
> +               vdd-s3-supply = <&vph_pwr>;
> +               vdd-s4-supply = <&vph_pwr>;
> +               vdd-s5-supply = <&vph_pwr>;
> +               vdd-s6-supply = <&vph_pwr>;
> +
> +               qcom,pmic-id = "g";
> +
> +               vreg_s1g_1p25: smps1 {
> +                       regulator-name = "vreg_s1g_1p25";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1300000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s2g_0p85: smps2 {
> +                       regulator-name = "vreg_s2g_0p85";
> +                       regulator-min-microvolt = <800000>;
> +                       regulator-max-microvolt = <1000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s3g_0p8: smps3 {
> +                       regulator-name = "vreg_s3g_0p8";
> +                       regulator-min-microvolt = <300000>;
> +                       regulator-max-microvolt = <1004000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s4g_1p25: smps4 {
> +                       regulator-name = "vreg_s4g_1p25";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1352000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s5g_0p85: smps5 {
> +                       regulator-name = "vreg_s5g_0p85";
> +                       regulator-min-microvolt = <500000>;
> +                       regulator-max-microvolt = <1004000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s6g_1p86: smps6 {
> +                       regulator-name = "vreg_s6g_1p86";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <2000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l1g_1p2: ldo1 {
> +                       regulator-name = "vreg_l1g_1p2";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3g_1p2: ldo3 {
> +                       regulator-name = "vreg_l3g_1p2";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-6 {
> +               compatible = "qcom,pm8010-rpmh-regulators";
> +
> +               vdd-l1-l2-supply = <&vreg_s4g_1p25>;
> +               vdd-l3-l4-supply = <&vreg_bob2>;
> +               vdd-l5-supply = <&vreg_s6g_1p86>;
> +               vdd-l6-supply = <&vreg_s6g_1p86>;
> +               vdd-l7-supply = <&vreg_bob1>;
> +
> +               qcom,pmic-id = "m";
> +
> +               vreg_l1m_1p056: ldo1 {
> +                       regulator-name = "vreg_l1m_1p056";
> +                       regulator-min-microvolt = <1056000>;
> +                       regulator-max-microvolt = <1056000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2m_1p056: ldo2 {
> +                       regulator-name = "vreg_l2m_1p056";
> +                       regulator-min-microvolt = <1056000>;
> +                       regulator-max-microvolt = <1056000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3m_2p8: ldo3 {
> +                       regulator-name = "vreg_l3m_2p8";
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <2800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l4m_2p8: ldo4 {
> +                       regulator-name = "vreg_l4m_2p8";
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <2800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l5m_1p8: ldo5 {
> +                       regulator-name = "vreg_l5m_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l6m_1p8: ldo6 {
> +                       regulator-name = "vreg_l6m_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l7m_2p9: ldo7 {
> +                       regulator-name = "vreg_l7m_2p9";
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <2904000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-7 {
> +               compatible = "qcom,pm8010-rpmh-regulators";
> +
> +               vdd-l1-l2-supply = <&vreg_s4g_1p25>;
> +               vdd-l3-l4-supply = <&vreg_bob2>;
> +               vdd-l5-supply = <&vreg_s6g_1p86>;
> +               vdd-l6-supply = <&vreg_bob1>;
> +               vdd-l7-supply = <&vreg_bob1>;
> +
> +               qcom,pmic-id = "n";
> +
> +               vreg_l1n_1p1: ldo1 {
> +                       regulator-name = "vreg_l1n_1p1";
> +                       regulator-min-microvolt = <1104000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2n_1p1: ldo2 {
> +                       regulator-name = "vreg_l2n_1p1";
> +                       regulator-min-microvolt = <1104000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +                                                  RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3n_2p8: ldo3 {
> +                       regulator-name = "vreg_l3n_2p8";
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <3000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l4n_2p8: ldo4 {
> +                       regulator-name = "vreg_l4n_2p8";
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l5n_1p8: ldo5 {
> +                       regulator-name = "vreg_l5n_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l6n_3p3: ldo6 {
> +                       regulator-name = "vreg_l6n_3p3";
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <3304000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l7n_2p96: ldo7 {
> +                       regulator-name = "vreg_l7n_2p96";
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <2960000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +};
> +
> +&i2c_master_hub_0 {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       clock-frequency = <400000>;
> +       status = "okay";
> +
> +       lt9611_codec: hdmi-bridge@2b {
> +               compatible = "lontium,lt9611uxc";
> +               reg = <0x2b>;
> +
> +               interrupts-extended = <&tlmm 8 IRQ_TYPE_EDGE_FALLING>;
> +
> +               reset-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
> +
> +               vdd-supply = <&lt9611_1v2>;
> +               vcc-supply = <&lt9611_3v3>;
> +
> +               pinctrl-0 = <&lt9611_irq_pin>, <&lt9611_rst_pin>;
> +               pinctrl-names = "default";
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +
> +                               lt9611_a: endpoint {
> +                                       remote-endpoint = <&mdss_dsi0_out>;
> +                               };
> +                       };
> +
> +                       port@2 {
> +                               reg = <2>;
> +
> +                               lt9611_out: endpoint {
> +                                       remote-endpoint = <&hdmi_connector_out>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c_hub_2 {
> +       status = "okay";
> +
> +       typec-mux@42 {
> +               compatible = "fcs,fsa4480";
> +               reg = <0x42>;
> +
> +               vcc-supply = <&vreg_bob1>;
> +
> +               mode-switch;
> +               orientation-switch;
> +
> +               port {
> +                       fsa4480_sbu_mux: endpoint {
> +                               remote-endpoint = <&pmic_glink_sbu>;
> +                       };
> +               };
> +       };
> +};

i2c_master_hub
i2c0
i2c_hub_2

The order doesn't seem to be correct.

> +
> +&ipa {
> +       qcom,gsi-loader = "self";
> +       memory-region = <&ipa_fw_mem>;
> +       firmware-name = "qcom/sm8550/ipa_fws.mbn";
> +       status = "okay";
> +};
> +
> +&gpu {
> +       status = "okay";
> +
> +       zap-shader {
> +               firmware-name = "qcom/sm8550/a740_zap.mbn";
> +       };
> +};

This comes before i2c

> +
> +&lpass_tlmm {
> +       spkr_1_sd_n_active: spkr-1-sd-n-active-state {
> +               pins = "gpio17";
> +               function = "gpio";
> +               drive-strength = <16>;
> +               bias-disable;
> +               output-low;
> +       };
> +
> +       spkr_2_sd_n_active: spkr-2-sd-n-active-state {
> +               pins = "gpio18";
> +               function = "gpio";
> +               drive-strength = <16>;
> +               bias-disable;
> +               output-low;
> +       };
> +};
> +
> +&mdss {
> +       status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +       vdda-supply = <&vreg_l3e_1p2>;
> +       status = "okay";
> +};
> +
> +&mdss_dsi0_out {
> +       remote-endpoint = <&lt9611_a>;
> +       data-lanes = <0 1 2 3>;
> +};
> +
> +&mdss_dsi0_phy {
> +       vdds-supply = <&vreg_l1e_0p88>;
> +       status = "okay";
> +};
> +
> +&mdss_dp0 {
> +       status = "okay";
> +};
> +
> +&mdss_dp0_out {
> +       remote-endpoint = <&usb_dp_qmpphy_dp_in>;
> +       data-lanes = <0 1>;
> +};
> +
> +&pcie0 {
> +       wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +       perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +
> +       pinctrl-0 = <&pcie0_default_state>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
> +&pcie0_phy {
> +       vdda-phy-supply = <&vreg_l1e_0p88>;
> +       vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +       status = "okay";
> +};
> +
> +&pcie1 {
> +       wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> +       perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +
> +       pinctrl-0 = <&pcie1_default_state>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
> +&pcie1_phy {
> +       vdda-phy-supply = <&vreg_l3c_0p9>;
> +       vdda-pll-supply = <&vreg_l3e_1p2>;
> +       vdda-qref-supply = <&vreg_l1e_0p88>;
> +
> +       status = "okay";
> +};
> +
> +&pm8550_gpios {
> +       sdc2_card_det_n: sdc2-card-det-state {
> +               pins = "gpio12";
> +               function = "normal";
> +               input-enable;
> +               output-disable;
> +               bias-pull-up;
> +               power-source = <1>; /* 1.8 V */
> +       };
> +
> +       volume_up_n: volume-up-n-state {
> +               pins = "gpio6";
> +               function = "normal";
> +               power-source = <1>;
> +               bias-pull-up;
> +               input-enable;
> +       };
> +};
> +
> +/* The RGB signals are routed to 3 separate LEDs on the HDK8550 */
> +&pm8550_pwm {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       status = "okay";
> +
> +       led@1 {
> +               reg = <1>;
> +               function = LED_FUNCTION_STATUS;
> +               color = <LED_COLOR_ID_RED>;
> +               default-state = "off";
> +       };
> +
> +       led@2 {
> +               reg = <2>;
> +               function = LED_FUNCTION_STATUS;
> +               color = <LED_COLOR_ID_GREEN>;
> +               default-state = "off";
> +       };
> +
> +       led@3 {
> +               reg = <3>;
> +               function = LED_FUNCTION_STATUS;
> +               color = <LED_COLOR_ID_BLUE>;
> +               default-state = "off";
> +       };
> +};
> +
> +&pm8550b_eusb2_repeater {
> +       vdd18-supply = <&vreg_l15b_1p8>;
> +       vdd3-supply = <&vreg_l5b_3p1>;
> +};
> +
> +&pon_pwrkey {
> +       status = "okay";
> +};
> +
> +&pon_resin {
> +       linux,code = <KEY_VOLUMEDOWN>;
> +
> +       status = "okay";
> +};
> +
> +&pcie_1_phy_aux_clk {
> +       clock-frequency = <1000>;
> +};

Next to other PCIe nodes?

> +
> +&qupv3_id_0 {
> +       status = "okay";
> +};
> +
> +&qupv3_id_1 {
> +       status = "okay";
> +};

BTW, don't we need to enable gpi_dma nodes for qup / i2c to work?

> +
> +&remoteproc_adsp {
> +       firmware-name = "qcom/sm8550/adsp.mbn",
> +                       "qcom/sm8550/adsp_dtb.mbn";
> +       status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +       firmware-name = "qcom/sm8550/cdsp.mbn",
> +                       "qcom/sm8550/cdsp_dtb.mbn";
> +       status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +       firmware-name = "qcom/sm8550/modem.mbn",
> +                       "qcom/sm8550/modem_dtb.mbn";
> +       status = "okay";
> +};
> +
> +&sdhc_2 {
> +       cd-gpios = <&pm8550_gpios 12 GPIO_ACTIVE_HIGH>;
> +
> +       pinctrl-0 = <&sdc2_default>, <&sdc2_card_det_n>;
> +       pinctrl-1 = <&sdc2_sleep>, <&sdc2_card_det_n>;
> +       pinctrl-names = "default", "sleep";
> +
> +       vmmc-supply = <&vreg_l9b_2p9>;
> +       vqmmc-supply = <&vreg_l8b_1p8>;
> +
> +       bus-width = <4>;
> +       no-sdio;
> +       no-mmc;
> +
> +       status = "okay";
> +};
> +
> +&sleep_clk {
> +       clock-frequency = <32000>;
> +};
> +
> +&swr0 {
> +       status = "okay";
> +
> +       /* WSA8845, Speaker North */
> +       north_spkr: speaker@0,0 {
> +               compatible = "sdw20217020400";
> +               reg = <0 0>;
> +
> +               pinctrl-0 = <&spkr_1_sd_n_active>;
> +               pinctrl-names = "default";
> +
> +               powerdown-gpios = <&lpass_tlmm 17 GPIO_ACTIVE_LOW>;
> +
> +               vdd-1p8-supply = <&vreg_l15b_1p8>;
> +               vdd-io-supply = <&vreg_l15b_1p8>;
> +
> +               #sound-dai-cells = <0>;
> +               sound-name-prefix = "SpkrLeft";
> +       };
> +
> +       /* WSA8845, Speaker South */
> +       south_spkr: speaker@0,1 {
> +               compatible = "sdw20217020400";
> +               reg = <0 1>;
> +
> +               pinctrl-0 = <&spkr_2_sd_n_active>;
> +               pinctrl-names = "default";
> +
> +               powerdown-gpios = <&lpass_tlmm 18 GPIO_ACTIVE_LOW>;
> +
> +               vdd-1p8-supply = <&vreg_l15b_1p8>;
> +               vdd-io-supply = <&vreg_l15b_1p8>;
> +
> +               #sound-dai-cells = <0>;
> +               sound-name-prefix = "SpkrRight";
> +       };
> +};
> +
> +&swr1 {
> +       status = "okay";
> +
> +       /* WCD9385 RX */
> +       wcd_rx: codec@0,4 {
> +               compatible = "sdw20217010d00";
> +               reg = <0 4>;
> +
> +               qcom,rx-port-mapping = <1 2 3 4 5>;
> +       };
> +};
> +
> +&swr2 {
> +       status = "okay";
> +
> +       /* WCD9385 TX */
> +       wcd_tx: codec@0,3 {
> +               compatible = "sdw20217010d00";
> +               reg = <0 3>;
> +
> +               qcom,tx-port-mapping = <1 1 2 3>;
> +       };
> +};
> +
> +&tlmm {
> +       /* Reserved I/Os for NFC */
> +       gpio-reserved-ranges = <32 8>;
> +
> +       bt_default: bt-default-state {
> +               bt-en-pins {
> +                       pins = "gpio81";
> +                       function = "gpio";
> +                       drive-strength = <16>;
> +                       bias-disable;
> +               };
> +
> +               sw-ctrl-pins {
> +                       pins = "gpio82";
> +                       function = "gpio";
> +                       bias-pull-down;
> +               };
> +       };
> +
> +       lt9611_irq_pin: lt9611-irq-state {
> +               pins = "gpio8";
> +               function = "gpio";
> +               bias-disable;
> +       };
> +
> +       lt9611_rst_pin: lt9611-rst-state {
> +               pins = "gpio7";
> +               function = "gpio";
> +               output-high;
> +       };
> +
> +       wcd_default: wcd-reset-n-active-state {
> +               pins = "gpio108";
> +               function = "gpio";
> +               drive-strength = <16>;
> +               bias-disable;
> +               output-low;
> +       };
> +};
> +
> +&uart7 {
> +       status = "okay";
> +};
> +
> +&uart14 {
> +       status = "okay";
> +
> +       bluetooth {
> +               compatible = "qcom,wcn7850-bt";
> +
> +               vddio-supply = <&vreg_l15b_1p8>;
> +               vddaon-supply = <&vreg_s4e_0p95>;
> +               vdddig-supply = <&vreg_s4e_0p95>;
> +               vddrfa0p8-supply = <&vreg_s4e_0p95>;
> +               vddrfa1p2-supply = <&vreg_s4g_1p25>;
> +               vddrfa1p9-supply = <&vreg_s6g_1p86>;
> +
> +               max-speed = <3200000>;
> +
> +               enable-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> +               swctrl-gpios = <&tlmm 82 GPIO_ACTIVE_HIGH>;
> +
> +               pinctrl-0 = <&bt_default>;
> +               pinctrl-names = "default";
> +       };
> +};
> +
> +&ufs_mem_hc {
> +       reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +
> +       vcc-supply = <&vreg_l17b_2p5>;
> +       vcc-max-microamp = <1300000>;
> +       vccq-supply = <&vreg_l1g_1p2>;
> +       vccq-max-microamp = <1200000>;
> +       vdd-hba-supply = <&vreg_l3g_1p2>;
> +
> +       status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +       vdda-phy-supply = <&vreg_l1d_0p88>;
> +       vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +       status = "okay";
> +};
> +
> +&usb_1 {
> +       status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +       dr_mode = "otg";

otg is a default

> +       usb-role-switch;
> +};
> +
> +&usb_1_dwc3_hs {
> +       remote-endpoint = <&pmic_glink_hs_in>;
> +};
> +
> +&usb_1_dwc3_ss {
> +       remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
> +};
> +
> +&usb_1_hsphy {
> +       vdd-supply = <&vreg_l1e_0p88>;
> +       vdda12-supply = <&vreg_l3e_1p2>;
> +
> +       phys = <&pm8550b_eusb2_repeater>;
> +
> +       status = "okay";
> +};
> +
> +&usb_dp_qmpphy {
> +       vdda-phy-supply = <&vreg_l3e_1p2>;
> +       vdda-pll-supply = <&vreg_l3f_0p88>;
> +
> +       orientation-switch;

Shouldn't this property be moved to the base dtsi?

> +
> +       status = "okay";
> +};
> +
> +&usb_dp_qmpphy_dp_in {
> +       remote-endpoint = <&mdss_dp0_out>;
> +};
> +
> +&usb_dp_qmpphy_out {
> +       remote-endpoint = <&pmic_glink_ss_in>;
> +};
> +
> +&usb_dp_qmpphy_usb_ss_in {
> +       remote-endpoint = <&usb_1_dwc3_ss>;
> +};
> +
> +&xo_board {
> +       clock-frequency = <76800000>;
> +};
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

