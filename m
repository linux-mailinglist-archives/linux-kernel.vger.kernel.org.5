Return-Path: <linux-kernel+bounces-101497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAB487A7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC721C22EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8AF1F958;
	Wed, 13 Mar 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhOWS/5D"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8D40BE1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334523; cv=none; b=QKMb3L4RMrV3FY04mryrWBq6gezkVsD8GYCIsAA9lpf7lsISqohYOWIJpFiUJO0+6hUmmz4ENPraToE4/liXdZOOaspKBLy2uUIaJED6z1MhpPLxXHHleN1ZuoHp2DsnfE4b7D8BVXpw7p1hkzwi1KqqneVtfQYNTSg1eAzMyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334523; c=relaxed/simple;
	bh=D4mS9TN5zAt9PduRmBJHsD8zFdc+S+TnC8IcjVKeU1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgGfAibdbnRfBJm+NQN8bQ3x/kI4PZQ7oGBzB0DyMxcioU3Q2fLbt5OG2SpyEeqIpTov5TDUIEq1FWU1TsyL+dMojp1PKfYNivGkOC4t2J6xtmzcidGKVcn3sJQxkyK3JUJ9IeU7WQ7WNWnRVbaP99cmARSMGmtoWoLZ965e2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rhOWS/5D; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e9def4a6dso2318067f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710334520; x=1710939320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+J/zpBZ8gEqT6dCwGHbOxDJCcGLZPuDRO+od6X+T6jU=;
        b=rhOWS/5DdaG0bsFqPjywsBU79lGYdgUtJ5FDsCQkT6XrfFFu079eFpuY5/PUJXgDKm
         exmkwGRiJO4GtEiYzhxfkRgZz1wQfIqz5+BPHfKXvBtswEa3ZHnYPc/zKh1v7J0dTS40
         SAD0xxpZtc1xcJTovL4lWo6kVfW8L1hoYSw5sIhCoN3sST+sC3ORkuwzgrsg/9a58VEe
         ag41ah+dQ7Beo6grOCEzwm8EKb6ffKgfjITHrh8kZeCx9dtAMOe5h7KzcFyMCWmOgpM9
         2jPEjDgo+lpns7QY2TjT8oY13H07FvRGTjRCzQR1R9TbUPe9qmCbAiNafJXXEnVhxfbU
         10aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710334520; x=1710939320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J/zpBZ8gEqT6dCwGHbOxDJCcGLZPuDRO+od6X+T6jU=;
        b=az3R5tLfKTYiDqOh/80NfhXQtVlcfjqBiu18sn/Bw1saaibrLRglexuPgy5kU/bRp6
         vOUupOONC/DqCSpXp657QHqojIWQMhFAxZrVJ7CdWT7wdaBz14AO6APKyXFiwb5JYnJ8
         Cp/OUijpn/eU+Mmyk/NbPO230jcWVhEf5jwKYTKAUKJ6sIpSOuRk9ekGi8JN/eWvIKI0
         ETc+tLECsEI8fGTQtYcFzHeSIvZY00Y9aItEWrybHhgrdDUw763Qo0V7vmefe/EbmNhH
         U1rMS4qlJq0h5AHev+R1T7UCq1chZqAKRsMbWSWc385fw5a//9JJ1doAE3j+7GBJGfFS
         nc/w==
X-Forwarded-Encrypted: i=1; AJvYcCVsASjfr/pCOUpmg2CFtu3GvlkFNW+jo9E/bfGpQteIuS4Z4uhi4GeY/YQlkGUShJElpVxH587PWVchbgFMx+iyDg+bnO+QpJJcdWTv
X-Gm-Message-State: AOJu0YwZCq0uJd/tnp8dmgO/Go6fhIVbaGY6I7QW727dpw6xwEeckwTl
	OOXiLLQTT40FNp0conbcw7a19INg+8yMEy1+jrehOxM+lQOrLDAJhh5Tyndmuv0=
X-Google-Smtp-Source: AGHT+IGJpufB+mAmtIm77WSxh0vHLrc2cwkNDwrb5NHAgIDazKK6MvSzqifcQKnXMOLUAWu0MH/EeQ==
X-Received: by 2002:a5d:4248:0:b0:33d:1145:8787 with SMTP id s8-20020a5d4248000000b0033d11458787mr1422731wrr.25.1710334519696;
        Wed, 13 Mar 2024 05:55:19 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d59c9000000b0033e22a7b3f8sm11602785wry.75.2024.03.13.05.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 05:55:19 -0700 (PDT)
Message-ID: <80ad9093-c9cf-4b5a-94d0-78e966168ca7@linaro.org>
Date: Wed, 13 Mar 2024 12:55:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, stephan@gerhold.net,
 neil.armstrong@linaro.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240313123017.362570-4-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sumit,

On 13/03/2024 12:30, Sumit Garg wrote:
> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> Box Core board based on the Qualcomm APQ8016E SoC.
> 
> Support for Schneider Electric HMIBSC. Features:
> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> - 1GiB RAM
> - 8GiB eMMC, SD slot
> - WiFi and Bluetooth
> - 2x Host, 1x Device USB port
> - HDMI
> - Discrete TPM2 chip over SPI
> - USB ethernet adaptors (soldered)
> 
> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 519 ++++++++++++++++++
>  2 files changed, 520 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 39889d5f8e12..ad55e52e950b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -5,6 +5,7 @@ apq8016-sbc-usb-host-dtbs	:= apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
>  
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-usb-host.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-schneider-hmibsc.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> new file mode 100644
> index 000000000000..2f6d394feb87
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> @@ -0,0 +1,519 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Linaro Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8916-pm8916.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
> +#include <dt-bindings/sound/apq8016-lpass.h>
> +
> +/ {
> +	model = "Schneider Electric HMIBSC Board";
> +	compatible = "schneider,apq8016-hmibsc", "qcom,apq8016";
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* eMMC */
> +		mmc1 = &sdhc_2; /* SD card */
> +		serial0 = &blsp_uart1;
> +		serial1 = &blsp_uart2;
> +		usid0 = &pm8916_0;
> +		i2c1 = &blsp_i2c6;
> +		i2c3 = &blsp_i2c4;
> +		i2c4 = &blsp_i2c3;
> +		spi0 = &blsp_spi5;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	memory@80000000 {
> +		reg = <0 0x80000000 0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		ramoops@bff00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xbff00000 0x0 0x100000>;
> +
> +			record-size = <0x20000>;
> +			console-size = <0x20000>;
> +			ftrace-size = <0x20000>;
> +		};
> +	};
> +
> +	usb2513 {
> +		compatible = "smsc,usb3503";
> +		reset-gpios = <&pm8916_gpios 1 GPIO_ACTIVE_LOW>;
> +		initial-mode = <1>;
> +	};
> +
> +	usb_id: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_id_default>;
> +	};
> +
> +	hdmi-out {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con: endpoint {
> +				remote-endpoint = <&adv7533_out>;
> +			};
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&msm_key_volp_n_default>;
> +
> +		button {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pm8916_mpps_leds>;
> +
> +		compatible = "gpio-leds";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@5 {
> +			reg = <5>;
> +			label = "apq8016-hmibsc:green:wlan";
> +			function = LED_FUNCTION_WLAN;
> +			color = <LED_COLOR_ID_YELLOW>;
> +			gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +
> +		led@6 {
> +			reg = <6>;
> +			label = "apq8016-hmibsc:yellow:bt";
> +			function = LED_FUNCTION_BLUETOOTH;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "bluetooth-power";
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&blsp_i2c3 {
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&blsp_i2c4 {
> +	status = "okay";
> +
> +	adv_bridge: bridge@39 {
> +		status = "okay";
> +
> +		compatible = "adi,adv7533";
> +		reg = <0x39>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> +
> +		adi,dsi-lanes = <4>;
> +		clocks = <&rpmcc RPM_SMD_BB_CLK2>;
> +		clock-names = "cec";
> +
> +		pd-gpios = <&tlmm 32 GPIO_ACTIVE_HIGH>;
> +
> +		avdd-supply = <&pm8916_l6>;
> +		a2vdd-supply = <&pm8916_l6>;
> +		dvdd-supply = <&pm8916_l6>;
> +		pvdd-supply = <&pm8916_l6>;
> +		v1p2-supply = <&pm8916_l6>;
> +		v3p3-supply = <&pm8916_l17>;
> +
> +		pinctrl-names = "default","sleep";
> +		pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
> +		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
> +		#sound-dai-cells = <1>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7533_in: endpoint {
> +					remote-endpoint = <&mdss_dsi0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				adv7533_out: endpoint {
> +					remote-endpoint = <&hdmi_con>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&blsp_i2c6 {
> +	status = "okay";
> +
> +	rtc@30 {
> +		compatible = "sii,s35390a";
> +		reg = <0x30>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&blsp_spi5 {
> +	status = "okay";
> +	cs-gpios = <&tlmm 18 GPIO_ACTIVE_LOW>;
> +
> +	tpm@0 {
> +		compatible = "tcg,tpm_tis-spi";
> +		reg = <0>;
> +		spi-max-frequency = <500000>;
> +	};
> +};
> +
> +&blsp_uart1 {
> +	status = "okay";
> +	label = "UART0";
> +};
> +
> +&blsp_uart2 {
> +	status = "okay";
> +	label = "UART1";
> +};
> +
> +&lpass {
> +	status = "okay";
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0_out {
> +	data-lanes = <0 1 2 3>;
> +	remote-endpoint = <&adv7533_in>;
> +};
> +
> +&pm8916_codec {
> +	status = "okay";
> +	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
> +	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
> +};
> +
> +&pm8916_resin {
> +	status = "okay";
> +	linux,code = <KEY_POWER>;
> +};
> +
> +&pm8916_rpm_regulators {
> +	pm8916_l17: l17 {
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
> +	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
> +
> +	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
> +};
> +
> +&sound {
> +	status = "okay";
> +
> +	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
> +	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	model = "DB410c";
> +	audio-routing =
> +		"AMIC2", "MIC BIAS Internal2",
> +		"AMIC3", "MIC BIAS External1";
> +
> +	quaternary-dai-link {
> +		link-name = "ADV7533";
> +		cpu {
> +			sound-dai = <&lpass MI2S_QUATERNARY>;
> +		};
> +		codec {
> +			sound-dai = <&adv_bridge 0>;
> +		};
> +	};
> +
> +	primary-dai-link {
> +		link-name = "WCD";
> +		cpu {
> +			sound-dai = <&lpass MI2S_PRIMARY>;
> +		};
> +		codec {
> +			sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
> +		};
> +	};
> +
> +	tertiary-dai-link {
> +		link-name = "WCD-Capture";
> +		cpu {
> +			sound-dai = <&lpass MI2S_TERTIARY>;
> +		};
> +		codec {
> +			sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
> +		};
> +	};
> +};
> +
> +&usb {
> +	status = "okay";
> +	extcon = <&usb_id>, <&usb_id>;
> +
> +	pinctrl-names = "default", "device";
> +	pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
> +	pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
> +};
> +
> +&usb_hs_phy {
> +	extcon = <&usb_id>;
> +};
> +
> +&wcnss {
> +	status = "okay";
> +	firmware-name = "qcom/apq8016/wcnss.mbn";
> +};
> +
> +&wcnss_ctrl {
> +	firmware-name = "qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin";
> +};
> +
> +&wcnss_iris {
> +	compatible = "qcom,wcn3620";
> +};
> +
> +&wcnss_mem {
> +	status = "okay";
> +};
> +
> +/* Enable CoreSight */
> +&cti0 { status = "okay"; };
> +&cti1 { status = "okay"; };
> +&cti12 { status = "okay"; };
> +&cti13 { status = "okay"; };
> +&cti14 { status = "okay"; };
> +&cti15 { status = "okay"; };
> +&debug0 { status = "okay"; };
> +&debug1 { status = "okay"; };
> +&debug2 { status = "okay"; };
> +&debug3 { status = "okay"; };
> +&etf { status = "okay"; };
> +&etm0 { status = "okay"; };
> +&etm1 { status = "okay"; };
> +&etm2 { status = "okay"; };
> +&etm3 { status = "okay"; };
> +&etr { status = "okay"; };
> +&funnel0 { status = "okay"; };
> +&funnel1 { status = "okay"; };
> +&replicator { status = "okay"; };
> +&stm { status = "okay"; };
> +&tpiu { status = "okay"; };
> +
> +/*
> + * 2mA drive strength is not enough when connecting multiple
> + * I2C devices with different pull up resistors.
> + */
> +
> +&blsp_i2c4_default {
> +	drive-strength = <16>;
> +};
> +
> +&blsp_i2c6_default {
> +	drive-strength = <16>;
> +};
> +
> +&tlmm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_mux0_rs232_high &uart1_mux1_rs232_low>;
> +
> +	sdc2_cd_default: sdc2-cd-default-state {
> +		pins = "gpio38";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb_id_default: usb-id-default-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	adv7533_int_active: adv533-int-active-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	adv7533_int_suspend: adv7533-int-suspend-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	adv7533_switch_active: adv7533-switch-active-state {
> +		pins = "gpio32";
> +		function = "gpio";
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	adv7533_switch_suspend: adv7533-switch-suspend-state {
> +		pins = "gpio32";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	msm_key_volp_n_default: msm-key-volp-n-default-state {
> +		pins = "gpio107";
> +		function = "gpio";
> +
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	/*
> +	 * UART1 being the debug console supports various modes of
> +	 * operation (RS-232/485/422) controlled via GPIOs configured
> +	 * mux as follows:
> +	 *
> +	 *   gpio100    gpio99    UART mode
> +	 *   0          0         loopback
> +	 *   0          1         RS-232
> +	 *   1          0         RS-485
> +	 *   1          1         RS-422
> +	 *
> +	 * The default mode configured here is RS-232 mode.
> +	 */
> +	uart1_mux0_rs232_high: uart1-mux0-rs232-state {
> +		bootph-all;
> +		pins = "gpio99";
> +		function = "gpio";
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +		output-high;
> +	};
> +
> +	uart1_mux1_rs232_low: uart1-mux1-rs232-state {
> +		bootph-all;
> +		pins = "gpio100";
> +		function = "gpio";
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +		output-low;
> +	};
> +};
> +
> +&pm8916_gpios {
> +	gpio-line-names =
> +		"USB_HUB_RESET_N_PM",
> +		"USB_SW_SEL_PM",
> +		"NC",
> +		"NC";
> +
> +	usb_hub_reset_pm: usb-hub-reset-pm-state {
> +		pins = "gpio1";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +
> +		input-disable;
> +		output-high;
> +	};
> +
> +	usb_hub_reset_pm_device: usb-hub-reset-pm-device-state {
> +		pins = "gpio1";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +
> +		output-low;
> +	};
> +
> +	usb_sw_sel_pm: usb-sw-sel-pm-state {
> +		pins = "gpio2";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +
> +		power-source = <PM8916_GPIO_VPH>;
> +		input-disable;
> +		output-high;
> +	};
> +
> +	usb_sw_sel_pm_device: usb-sw-sel-pm-device-state {
> +		pins = "gpio2";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +
> +		power-source = <PM8916_GPIO_VPH>;
> +		input-disable;
> +		output-low;
> +	};
> +};
> +
> +&pm8916_mpps {
> +	gpio-line-names =
> +		"NC",
> +		"WLAN_LED_CTRL",
> +		"BT_LED_CTRL",
> +		"NC";
> +
> +	pm8916_mpps_leds: pm8916-mpps-state {
> +		pins = "mpp2", "mpp3";
> +		function = "digital";
> +
> +		output-low;
> +	};
> +};
> +
> +&blsp_uart1_default {
> +	bootph-all;
> +};

-- 
// Caleb (they/them)

