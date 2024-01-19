Return-Path: <linux-kernel+bounces-31187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3573832A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81351C2329F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320452F6E;
	Fri, 19 Jan 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NvuVbFJF"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B694524BB;
	Fri, 19 Jan 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670427; cv=none; b=RnZa5AXQBygkQUqmtRtSkue4NE9/soNGNB+13v6EMsHj6sdQXQLRvKpfbVWALjXjr/jp8DDPbuHmz0Yg14tmwoOrpaOck6FN1Czdr5T6eLfnuNNZwtDkMnJtj5BBISZ0wy0w1h0/HnYRsCn4SLETD7xVzVKTtZjY0PmjyJLXCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670427; c=relaxed/simple;
	bh=ElJ/OCsOrIp+TTmifUSJD0/f8uRrKubB7ZceV1y38rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uO7UHqvj77Q7xS3F+QSyiEPZr8fztNdKYa/C3h/K3eHkbRBU3roDHsQxigbejNBrm4T3/bwnerXb3Fe0sT+f4iCdD60I8NOZNCiHBueYyxdOsaKX9yJQpDCdsoKcIBEDbPg4nzuor6Q+aSKF1efMR6rJ1+KBt3VrSZGDudOBMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NvuVbFJF; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JDKEnr121209;
	Fri, 19 Jan 2024 07:20:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705670414;
	bh=/5N8KpYypf0t30Zg/oKI7dNIkXHHpGYh04I2FGal8YU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NvuVbFJFUEWKecl1ysFBIc0/9OwlGAaEUP4WMKQtZ4XcY5xTXonRIK0g8WpnDW7dP
	 xkgK3sn+H/U6dPbPYmaf+S85tEiV9YJi34QQZTZsRIsdOUB92NL3/B60BZLi6vaIPa
	 7RnvIc3dQADCW8QSOVpTZf6fTywqMrbWwMRpF6Lc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JDKEf0108410
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Jan 2024 07:20:14 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 07:20:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 07:20:14 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JDKAQf020766;
	Fri, 19 Jan 2024 07:20:10 -0600
Message-ID: <5605f593-8526-46b8-9a71-4cbbf013e96e@ti.com>
Date: Fri, 19 Jan 2024 18:50:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for
 AM69 SK board
To: <sabiya.d@mistralsolutions.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya <sabiya.d@ti.com>
References: <20240118153524.4135901-1-sabiya.d@ti.com>
 <20240118153524.4135901-2-sabiya.d@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240118153524.4135901-2-sabiya.d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 1/18/2024 9:05 PM, sabiya.d@mistralsolutions.com wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
>
> AM69 SK board has several CAN bus interfaces on both MCU and MAIN domains.
> This enables the CAN interfaces on MCU and MAIN domain.
>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 85 +++++++++++++++++++++++++++
>   1 file changed, 85 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index 370980eb59b0..feb571a5a0f5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -29,6 +29,10 @@ aliases {
>   		i2c0 = &wkup_i2c0;
>   		i2c3 = &main_i2c0;
>   		ethernet0 = &mcu_cpsw_port1;
> +		can0 = &mcu_mcan0;
> +		can1 = &mcu_mcan1;
> +		can2 = &main_mcan6;
> +		can3 = &main_mcan7;


AFAIK, can sub system does not support aliasing.

IMO, you can remove these.


>   	};
>   
>   	memory@80000000 {
> @@ -321,6 +325,31 @@ tfp410_out: endpoint {
>   			};
>   		};
>   	};
> +
> +	transceiver1: can-phy0 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +
> +	transceiver2: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +
> +	transceiver3: can-phy2 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +
> +	transceiver4: can-phy3 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +
>   };
>   
>   &main_pmx0 {
> @@ -429,6 +458,20 @@ hdmi_hpd_pins_default: hdmi-hpd-default-pins {
>   			J784S4_IOPAD(0x000, PIN_INPUT, 7) /* (AN35) EXTINTN.GPIO0_0 */
>   		>;
>   	};
> +
> +	main_mcan6_pins_default: main-mcan6-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x098, PIN_INPUT, 0) /* (AH36) MCAN6_RX */
> +			J784S4_IOPAD(0x094, PIN_OUTPUT, 0) /* (AG35) MCAN6_TX */
> +		>;
> +	};
> +
> +	main_mcan7_pins_default: main-mcan7-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x0A0, PIN_INPUT, 0) /* (AD34) MCAN7_RX */
> +			J784S4_IOPAD(0x09C, PIN_OUTPUT, 0) /* (AF35) MCAN7_TX */
> +		>;
> +	};
>   };
>   
>   &wkup_pmx2 {
> @@ -525,6 +568,20 @@ hdmi_pdn_pins_default: hdmi-pdn-default-pins {
>   			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 7) /* (H37) WKUP_GPIO0_14 */
>   		>;
>   	};
> +
> +	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (F38) MCU_MCAN0_RX */
> +			J784S4_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (K33) MCU_MCAN0_TX */
> +		>;
> +	};
> +
> +	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (K36) WKUP_GPIO0_5.MCU_MCAN1_RX */
> +			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0)/* (H35) WKUP_GPIO0_4.MCU_MCAN1_TX */
> +		>;
> +	};
>   };
>   
>   &wkup_pmx3 {
> @@ -988,3 +1045,31 @@ dp0_out: endpoint {
>   		};
>   	};
>   };
> +
> +&mcu_mcan0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan0_pins_default>;
> +	phys = <&transceiver1>;
> +};
> +
> +&mcu_mcan1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan1_pins_default>;
> +	phys = <&transceiver2>;
> +};
> +
> +&main_mcan6 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan6_pins_default>;
> +	phys = <&transceiver3>;
> +};
> +
> +&main_mcan7 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan7_pins_default>;
> +	phys = <&transceiver4>;
> +};

