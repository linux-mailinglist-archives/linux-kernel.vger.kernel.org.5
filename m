Return-Path: <linux-kernel+bounces-43359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1134841296
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52393285E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88176F080;
	Mon, 29 Jan 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GwRicA4v"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DFB46A0;
	Mon, 29 Jan 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553516; cv=none; b=JqdUGbdygU+eQZ8lzvVmfklSWdB/xO5Et4YFcIPBBXuvEJYQHjfsgpKxibdGrfTwkAP7AQFp6tG5J0fj3gUKkp3ib2kIYPsN3qQbWtlWT8+7q+NXWPrMURBi0KktUuNy04OyPK9S+ZfLrZaJ/ojcVSsTQWd9cLVDSe1FB22Sinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553516; c=relaxed/simple;
	bh=Wgb6AHbASHAIbUYNKyispgBiH/PHmLv6+sY9S/alqBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RIrNlbsrlxLQOGlly4BLGJRaiakUrKo/w5QPaL+EeQA52OSKLWbgrayE8kYTG15WCZf5uqhRMloWHYvA7/qHzNdGtsjLZCi68FIHWcdlsYzKgtl7eokpPq/ReFuHeVSuP1cth/bUVuOEH53YfL2AARpX4DiLCuh9Aa3euLMkuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GwRicA4v; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TIcLcw040405;
	Mon, 29 Jan 2024 12:38:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706553501;
	bh=s/J2LZYspsxQ9oo7bDTDwuZFAw/7FHF06DORePa2lCw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GwRicA4vEh0sDI6mL8bRoYHrqdV+N3kNx6auz3L9T82U7YSuD84bv/qDNrvnDx33C
	 mBDFjkV9vZYqbnp5iXGeKRWzlnZZg43q5mtoyFh48leLg8iQ3dsnUs8NRmHE5+FqMt
	 29R6GLBPwoYg7xsuFlleDH+5ZIMobRJiuX6cOXwU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TIcLnX009828
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 12:38:21 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 12:38:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 12:38:20 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TIcJf9084941;
	Mon, 29 Jan 2024 12:38:20 -0600
Message-ID: <3dcd38ef-c78d-4a28-b756-6be84ce7f252@ti.com>
Date: Mon, 29 Jan 2024 12:38:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] arm64: dts: ti: k3-am69-sk: Add overlay for IMX219
Content-Language: en-US
To: Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>, <j-luthra@ti.com>
References: <20240129132742.1189783-1-vaishnav.a@ti.com>
 <20240129132742.1189783-10-vaishnav.a@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240129132742.1189783-10-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/29/24 7:27 AM, Vaishnav Achath wrote:
> RPi v2 Camera (IMX219) is an 8MP camera that can be used with SK-AM69
> through the 22-pin CSI-RX connector.
> 
> Same overlay can be used across AM68 SK, TDA4VM SK boards that have a
> 15/22-pin FFC connector. Also enable build testing and symbols for
> all the three platforms.
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |   6 +
>   .../boot/dts/ti/k3-am69-sk-csi2-imx219.dtso   | 124 ++++++++++++++++++
>   2 files changed, 130 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 52c1dc910308..9fc8d68f7d26 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -80,6 +80,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
>   
>   # Boards with J784s4 SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am69-sk-csi2-imx219.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>   
>   # Build time test only, enabled by CONFIG_OF_ALL_DTBS
> @@ -105,6 +106,8 @@ k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
>   	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>   k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
>   	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
> +k3-am69-sk-csi2-imx219-dtbs := k3-am69-sk.dtb \
> +	k3-am69-sk-csi2-imx219.dtbo

You need to also add this "k3-am69-sk-csi2-imx219.dtb" to the list:

dtb- +=

below for it to actually get build tested.

>   k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
>   	k3-j721e-evm-pcie0-ep.dtbo
>   k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
> @@ -130,5 +133,8 @@ DTC_FLAGS_k3-am62-lp-sk += -@
>   DTC_FLAGS_k3-am62a7-sk += -@
>   DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
> +DTC_FLAGS_k3-am68-sk-base-board += -@
> +DTC_FLAGS_k3-am69-sk += -@
>   DTC_FLAGS_k3-j721e-common-proc-board += -@
>   DTC_FLAGS_k3-j721s2-common-proc-board += -@
> +DTC_FLAGS_k3-j721e-sk += -@
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
> new file mode 100644
> index 000000000000..4cd1d8d5004a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * DT Overlay for RPi Camera V2.1 (Sony IMX219) interfaced with CSI2 on AM68-SK board.
> + * https://datasheets.raspberrypi.org/camera/camera-v2-schematic.pdf
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	clk_imx219_fixed: imx219-xclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +	};
> +};
> +
> +&csi_mux {
> +	idle-state = <1>;
> +};
> +
> +/* CAM0 I2C */
> +&cam0_i2c {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	imx219_0: imx219_0@10 {
> +		compatible = "sony,imx219";
> +		reg = <0x10>;
> +
> +		clocks = <&clk_imx219_fixed>;
> +		clock-names = "xclk";
> +
> +		port {
> +			csi2_cam0: endpoint {
> +				remote-endpoint = <&csi2rx0_in_sensor>;
> +				link-frequencies = /bits/ 64 <456000000>;
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +/* CAM1 I2C */
> +&cam1_i2c {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	imx219_1: imx219_1@10 {
> +		compatible = "sony,imx219";
> +		reg = <0x10>;
> +
> +		clocks = <&clk_imx219_fixed>;
> +		clock-names = "xclk";
> +
> +		port {
> +			csi2_cam1: endpoint {
> +				remote-endpoint = <&csi2rx1_in_sensor>;
> +				link-frequencies = /bits/ 64 <456000000>;
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +
> +&cdns_csi2rx0 {
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		csi0_port0: port@0 {
> +			reg = <0>;
> +			status = "okay";
> +
> +			csi2rx0_in_sensor: endpoint {
> +				remote-endpoint = <&csi2_cam0>;
> +				bus-type = <4>; /* CSI2 DPHY. */
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&dphy0 {
> +	status = "okay";
> +};
> +
> +&ti_csi2rx0 {
> +	status = "okay";
> +};
> +
> +&cdns_csi2rx1 {
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		csi1_port0: port@0 {
> +			reg = <0>;
> +			status = "okay";
> +
> +			csi2rx1_in_sensor: endpoint {
> +				remote-endpoint = <&csi2_cam1>;
> +				bus-type = <4>; /* CSI2 DPHY. */
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&dphy1 {
> +	status = "okay";
> +};
> +
> +&ti_csi2rx1 {
> +	status = "okay";
> +};
> \ No newline at end of file

checkpatch..

Andrew

