Return-Path: <linux-kernel+bounces-144753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03278A4A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2701C22104
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3503715E;
	Mon, 15 Apr 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Swyd+kDN"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CA2D022;
	Mon, 15 Apr 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169356; cv=none; b=k19aPdpXbODS3qKJkVVwTE7hThDOVauaIZfgVv3gIbm2nBuaMVXMVbyHk9v3H5atTgu47CDYkdpoGlbVtgcEY7NRTsxeRvXNgF9tcZzoVfTgyiknPPIC/YG1F3IOSyP70g3LQBPUt9s4k7fEIdCDCQ6DNb0d7C/mncfvEN4trXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169356; c=relaxed/simple;
	bh=CVVzJFmo/hpBAPqJ6Dtj39yB/aP96Oyqa8EyRW9Q12Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i0ID+73L+SMaU+VJwKflbvS05l9Q9+XdGUE3fWCtMB56HBzHeKwfLRQ2nmwXv9Ktb8zhPxzm7bBtGzwEStKAs7WNVOOL9CJ7p2+fNZ/WLWhcWFBcX/YOSJt1O3qzpwOtWW3g2DvRunXwlcaxuvK9ypaYBoCgmH9kHixXBqWGA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Swyd+kDN; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F8MI0f061748;
	Mon, 15 Apr 2024 03:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713169338;
	bh=O39uRrglIXQjZzfqaVv4IwN4oOZmutfKiQZLaXMiV/U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Swyd+kDNjIdJ0C6/67bfzMC3QfTfhatwwtgE6mjyOwTnPmpgLFQ+AjAFmHlrloTDG
	 6m286gQalbIQMaIC3DUg40DIrDuusG4eiveVlTir++DE5m69mnVpsA9HJ+L2X57tKy
	 PqYgOWiNfYxXFvPGh+5+grgdVGmgO28PKhrposu0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F8MH8W113406
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 03:22:17 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 03:22:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 03:22:17 -0500
Received: from [10.249.132.73] ([10.249.132.73])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F8MDZj099513;
	Mon, 15 Apr 2024 03:22:14 -0500
Message-ID: <bbc276d6-709b-41f0-9987-63750d78deaa@ti.com>
Date: Mon, 15 Apr 2024 13:52:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721e-sk: Add support for multiple
 CAN instances
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240412112025.201639-1-b-padhi@ti.com>
Content-Language: en-US
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240412112025.201639-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 12/04/24 16:50, Beleswar Padhi wrote:
> CAN instance 0 in the mcu domain is brought on the J721E-SK board
> through header J1. Thus, add its respective transceiver 1 dt node to add
> support for this CAN instance.
>
> CAN instances 0, 5 and 9 in the main domain are brought on the J721E-SK
> board through headers J5, J6 and J2 respectively. Thus, add their
> respective transceivers 2, 3 and 4 dt nodes to add support for these CAN
> instances.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> Test logs: https://gist.github.com/3V3RYONE/2144fa883bf3a390981d25572971fcf3
>
> v3: Changelog:
> 1) Updated board name in capital letters in commit message description
> 2) Updated test logs to include communication between all applicable CAN
> instances
>
> Link to v2:
> https://lore.kernel.org/linux-arm-kernel/20240325103405.182692-1-b-padhi@ti.com/
>
> v2: Changelog:
> 1) Re-ordered status = "okay" property to the end of all applicable dt
> nodes following kernel documentation
>
> Link to v1:
> https://lore.kernel.org/linux-arm-kernel/20240315124728.490331-1-b-padhi@ti.com/
>
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 116 +++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 0c4575ad8d7c..7170f0220afd 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -210,6 +210,42 @@ vdd_sd_dv_alt: gpio-regulator-tps659411 {
>  			 <3300000 0x1>;
>  	};
>  
> +	transceiver1: can-phy0 {

Hi Beleswar, all looks good to me just one little suggestion to keep

transceiver and can-phy number as same for better understanding

and to avoid some bit of confusion later.

Eg.) transceiver<x>: can-phy<x>

> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
> +		standby-gpios = <&wkup_gpio0 3 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver2: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&main_mcan0_gpio_pins_default>;
> +		standby-gpios = <&main_gpio0 65 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver3: can-phy2 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&main_mcan5_gpio_pins_default>;
> +		standby-gpios = <&main_gpio0 66 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver4: can-phy3 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&main_mcan9_gpio_pins_default>;
> +		standby-gpios = <&main_gpio0 67 GPIO_ACTIVE_HIGH>;
> +	};
> +
>  	dp_pwr_3v3: fixedregulator-dp-prw {
>  		compatible = "regulator-fixed";
>  		regulator-name = "dp-pwr";
> @@ -367,6 +403,45 @@ J721E_IOPAD(0x164, PIN_OUTPUT, 7) /* (V29) RGMII5_TD2 */
>  		>;
>  	};
>  
> +	main_mcan0_pins_default: main-mcan0-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x208, PIN_INPUT, 0) /* (W5) MCAN0_RX */
> +			J721E_IOPAD(0x20c, PIN_OUTPUT, 0) /* (W6) MCAN0_TX */
> +		>;
> +	};
> +
> +	main_mcan0_gpio_pins_default: main-mcan0-gpio-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x108, PIN_INPUT, 7) /* (AD27) PRG0_PRU1_GPO2.GPIO0_65 */
> +		>;
> +	};
> +
> +	main_mcan5_pins_default: main-mcan5-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x050, PIN_INPUT, 6) /* (AE21) PRG1_PRU0_GPO18.MCAN5_RX */
> +			J721E_IOPAD(0x04c, PIN_OUTPUT, 6) /* (AJ21) PRG1_PRU0_GPO17.MCAN5_TX */
> +		>;
> +	};
> +
> +	main_mcan5_gpio_pins_default: main-mcan5-gpio-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x10c, PIN_INPUT, 7) /* (AC25) PRG0_PRU1_GPO3.GPIO0_66 */
> +		>;
> +	};
> +
> +	main_mcan9_pins_default: main-mcan9-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x0d0, PIN_INPUT, 6) /* (AC27) PRG0_PRU0_GPO8.MCAN9_RX */
> +			J721E_IOPAD(0x0cc, PIN_OUTPUT, 6) /* (AC28) PRG0_PRU0_GPO7.MCAN9_TX */
> +		>;
> +	};
> +
> +	main_mcan9_gpio_pins_default: main-mcan9-gpio-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x110, PIN_INPUT, 7) /* (AD29) PRG0_PRU1_GPO4.GPIO0_67 */
> +		>;
> +	};
> +
>  	dp0_pins_default: dp0-default-pins {
>  		pinctrl-single,pins = <
>  			J721E_IOPAD(0x1c4, PIN_INPUT, 5) /* SPI0_CS1.DP0_HPD */
> @@ -555,6 +630,19 @@ J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
>  		>;
>  	};
>  
> +	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0x0ac, PIN_INPUT, 0) /* (C29) MCU_MCAN0_RX */
> +			J721E_WKUP_IOPAD(0x0a8, PIN_OUTPUT, 0) /* (D29) MCU_MCAN0_TX */
> +		>;
> +	};
> +
> +	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0x0bc, PIN_INPUT, 7) /* (F27) WKUP_GPIO0_3 */
> +		>;
> +	};
> +
>  	/* Reset for M.2 M Key slot on PCIe1  */
>  	mkey_reset_pins_default: mkey-reset-pns-default-pins {
>  		pinctrl-single,pins = <
> @@ -1108,6 +1196,34 @@ &pcie1_rc {
>  	num-lanes = <2>;
>  };
>  
> +&mcu_mcan0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan0_pins_default>;
> +	phys = <&transceiver1>;
> +	status = "okay";
> +};
> +
> +&main_mcan0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	phys = <&transceiver2>;
> +	status = "okay";
> +};
> +
> +&main_mcan5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan5_pins_default>;
> +	phys = <&transceiver3>;
> +	status = "okay";
> +};
> +
> +&main_mcan9 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan9_pins_default>;
> +	phys = <&transceiver4>;
> +	status = "okay";
> +};
> +
>  &ufs_wrapper {
>  	status = "disabled";
>  };

