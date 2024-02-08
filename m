Return-Path: <linux-kernel+bounces-57679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4CC84DC1E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF08B271A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1E6F06C;
	Thu,  8 Feb 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dubXpNfH"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA86F06D;
	Thu,  8 Feb 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382448; cv=none; b=nQm5mWjAavoo8x597VFLdvMmV5O5RmETHYLIMhxdWRQPUvznKijdeUOcYkBQ9LwOjeI6FD3+BK/L4X4S5HuRTq3bSSdqZbNKadqbF/AqEMYN+v+B/GfOFg2WA/y4wayHMpcI8o8Y7C/51E6982j3pd+a4shxZoH8Vc7e42mJrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382448; c=relaxed/simple;
	bh=7G8PrCuNUA1B+YkOmPS+aNNojjW+btEBYEeHLsFY1c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DiZcZHfrv11F+919YvJKL9SDO8GJdhHVDJvmVpGNuN7/d9/7IaT+jtgmw+IJewnCFTx6UQg2EKWwVac9QykztGr9UAZy2h5ExlvqE48+CclWeOrDwUR81nJdt29aWtiEQQmq6gKajfpERqxKSDtnWf6ySJ45l8bjoiOp7jOr6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dubXpNfH; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4188rr1p018846;
	Thu, 8 Feb 2024 02:53:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707382433;
	bh=Oif//rHpkKIV/WLTcyh9G24tT84LisWf+JlZwELiNII=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dubXpNfHvA9bwumgqKhh2AfL3KDXi8lyqeIM2ida4uiby6ohSV8OPtMmwtvotrBfh
	 aamG/+N0CmM0g929x6ZcPYG8PAhIQHc6qnFIWFvjKYPCcOVZ2DzJpgZT1a9Oz3HU/C
	 fGvkI2539mdcAceVoBVXoqjpmAQ4EoOTOeDWCArk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4188rrHW042427
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 02:53:53 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 02:53:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 02:53:53 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4188rn5i113201;
	Thu, 8 Feb 2024 02:53:50 -0600
Message-ID: <0a52b6eb-1fc5-4fd6-9016-72e1cb97fcc4@ti.com>
Date: Thu, 8 Feb 2024 14:23:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] arm64: dts: ti: k3-am69-sk: Add overlay for IMX219
Content-Language: en-US
To: Jai Luthra <j-luthra@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>
References: <20240129132742.1189783-1-vaishnav.a@ti.com>
 <20240129132742.1189783-10-vaishnav.a@ti.com>
 <jzzoifrpcchpvvyy3k5xkcxveuopqdpkakv2ppv35wowvkc3uf@zlfel5wytyji>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <jzzoifrpcchpvvyy3k5xkcxveuopqdpkakv2ppv35wowvkc3uf@zlfel5wytyji>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jai, Andrew,

On 31/01/24 13:45, Jai Luthra wrote:
> Hi Vaishnav,
> 
> Thanks for the patch.
> 
> On Jan 29, 2024 at 18:57:42 +0530, Vaishnav Achath wrote:
>> RPi v2 Camera (IMX219) is an 8MP camera that can be used with SK-AM69
>> through the 22-pin CSI-RX connector.
>>
>> Same overlay can be used across AM68 SK, TDA4VM SK boards that have a
>> 15/22-pin FFC connector. Also enable build testing and symbols for
>> all the three platforms.
> 
> In that case, the overlay should be named something generic following
> how it is done for SK-AM62* family of boards.
> 
> IMO, it would also make more sense to have separate overlays for CSI0
> and CSI1 ports, unless there are no usecases to plug-in different
> sensors on the board.
> 
> Even if that is done later, at least this overlay should be named in a
> way to make it clear it enables 2x IMX219 on both CSI-RX ports, to avoid
> confusion.
> 
> So, something like k3-<jacinto?>-sk-csi2-dual-imx219.dtso
> 
> This will leave room for a CSI1 only overlay to be called
> k3-<>-sk-csi2-1-<sensor>.dtso
> 


Thank you for the review, for now I have renamed the overlay to the 
first supported platform(j721e-sk), like AM62X family it is difficult
to pick a common name for these platforms (TDA4VM SK, AM68 SK, AM69 SK),
also jacinto-*.dtso gives the wrong impression that these might work 
with the EVMs, so for now I have picked the name to follow the first 
supported platfor j721e-sk and clarified in comments and commit message 
that this can be reused with other platforms.

>>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/Makefile               |   6 +
>>   .../boot/dts/ti/k3-am69-sk-csi2-imx219.dtso   | 124 ++++++++++++++++++
>>   2 files changed, 130 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 52c1dc910308..9fc8d68f7d26 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -80,6 +80,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
>>   
>>   # Boards with J784s4 SoC
>>   dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-am69-sk-csi2-imx219.dtbo
>>   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>>   
>>   # Build time test only, enabled by CONFIG_OF_ALL_DTBS
>> @@ -105,6 +106,8 @@ k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
>>   	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>>   k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
>>   	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
>> +k3-am69-sk-csi2-imx219-dtbs := k3-am69-sk.dtb \
>> +	k3-am69-sk-csi2-imx219.dtbo
> 
> Andrew already pointed out that the base dtb should be added in the dtb-
> += entry at the end of this section.
> 
> Along with that, I think the overlay should be build-tested for each
> base DTB (AM68, TDA4VM) it is applicable on. Same is already done for
> the shared IMX219/OV5640 overlays between SK-AM62 and SK-AM62A.
> 

Fixed in V2: 
https://lore.kernel.org/all/20240208084254.295289-1-vaishnav.a@ti.com/

Thanks and Regards,
Vaishnav

>>   k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
>>   	k3-j721e-evm-pcie0-ep.dtbo
>>   k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
>> @@ -130,5 +133,8 @@ DTC_FLAGS_k3-am62-lp-sk += -@
>>   DTC_FLAGS_k3-am62a7-sk += -@
>>   DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
>>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>> +DTC_FLAGS_k3-am68-sk-base-board += -@
>> +DTC_FLAGS_k3-am69-sk += -@
>>   DTC_FLAGS_k3-j721e-common-proc-board += -@
>>   DTC_FLAGS_k3-j721s2-common-proc-board += -@
>> +DTC_FLAGS_k3-j721e-sk += -@
>> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
>> new file mode 100644
>> index 000000000000..4cd1d8d5004a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * DT Overlay for RPi Camera V2.1 (Sony IMX219) interfaced with CSI2 on AM68-SK board.
> 
> Overlay name says AM69 but comment says AM68 here.
> 
>> + * https://datasheets.raspberrypi.org/camera/camera-v2-schematic.pdf
>> + *
>> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> 
> s/2023/2024
> 
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "k3-pinctrl.h"
>> +
>> +&{/} {
>> +	clk_imx219_fixed: imx219-xclk {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <24000000>;
>> +	};
>> +};
>> +
>> +&csi_mux {
>> +	idle-state = <1>;
>> +};
>> +
>> +/* CAM0 I2C */
>> +&cam0_i2c {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	imx219_0: imx219_0@10 {
>> +		compatible = "sony,imx219";
>> +		reg = <0x10>;
>> +
>> +		clocks = <&clk_imx219_fixed>;
>> +		clock-names = "xclk";
>> +
>> +		port {
>> +			csi2_cam0: endpoint {
>> +				remote-endpoint = <&csi2rx0_in_sensor>;
>> +				link-frequencies = /bits/ 64 <456000000>;
>> +				clock-lanes = <0>;
>> +				data-lanes = <1 2>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +/* CAM1 I2C */
>> +&cam1_i2c {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	imx219_1: imx219_1@10 {
>> +		compatible = "sony,imx219";
>> +		reg = <0x10>;
>> +
>> +		clocks = <&clk_imx219_fixed>;
>> +		clock-names = "xclk";
>> +
>> +		port {
>> +			csi2_cam1: endpoint {
>> +				remote-endpoint = <&csi2rx1_in_sensor>;
>> +				link-frequencies = /bits/ 64 <456000000>;
>> +				clock-lanes = <0>;
>> +				data-lanes = <1 2>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +
>> +&cdns_csi2rx0 {
>> +	ports {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		csi0_port0: port@0 {
>> +			reg = <0>;
>> +			status = "okay";
>> +
>> +			csi2rx0_in_sensor: endpoint {
>> +				remote-endpoint = <&csi2_cam0>;
>> +				bus-type = <4>; /* CSI2 DPHY. */
>> +				clock-lanes = <0>;
>> +				data-lanes = <1 2>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&dphy0 {
>> +	status = "okay";
>> +};
>> +
>> +&ti_csi2rx0 {
>> +	status = "okay";
>> +};
>> +
>> +&cdns_csi2rx1 {
>> +	ports {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		csi1_port0: port@0 {
>> +			reg = <0>;
>> +			status = "okay";
>> +
>> +			csi2rx1_in_sensor: endpoint {
>> +				remote-endpoint = <&csi2_cam1>;
>> +				bus-type = <4>; /* CSI2 DPHY. */
>> +				clock-lanes = <0>;
>> +				data-lanes = <1 2>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&dphy1 {
>> +	status = "okay";
>> +};
>> +
>> +&ti_csi2rx1 {
>> +	status = "okay";
>> +};
>> \ No newline at end of file
>> -- 
>> 2.34.1
>>
> 

