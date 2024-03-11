Return-Path: <linux-kernel+bounces-98721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F9877E60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206EE1F2101D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBA37169;
	Mon, 11 Mar 2024 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JHFhCL4Y"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320B2C69A;
	Mon, 11 Mar 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154184; cv=none; b=J/y/paBQBPG4vcnLLGgl0HFlcFY+CyuPxYa5gite+iOeUIhVpnKLCY5RKNM3Ji1MrAz6U8UmbS3kAppYkzjQsQhu5YgURv34sSGyIgYZ4RXz8K31kg2SkSoyrsCx9mkvwDKU60uXxH8TKScoQ1YVdqHpt2RLFEm5xWll3V6Ud9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154184; c=relaxed/simple;
	bh=zdumg2HTNXjDkRGH9WQHi7LXj63DIJGejKy1zfiZJiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uEECx3zUj3ZXZ2BQcRT9hbU2/1Z16j18U0UwecMgoEwIXn9AUON3wpRcARmdUuDUFJKvJ5tiaaLiuDCKHRtwfbo8arZRdecopkdbfaWq2cHmmYZRbULTEjLgyW0FaM9iNTYIhc4GhTN4SbreLWdTOmTLkGYkd4WTCLpjoE0I/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JHFhCL4Y; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42BAn95H109286;
	Mon, 11 Mar 2024 05:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710154149;
	bh=GCbA1hnNHwTujCBaxSWTiyZacv4uOD7uipAFx1zBfFY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JHFhCL4YHUQc+/SPUXonmLe9ov71U5c6i8s4PvDJ8zDgF1mGpDRsQXX3SCmTStG7/
	 AH7FGQf/0/3/KF4Fh/pVf3aSdP3hCAIG5sQSdwr/YmPieKnjdAqIXjE/nTaqHR+AP4
	 rO3hCvh8IQWlpdDXOQEis7Je2wkj0bIcCu2vTgys=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42BAn9hJ116567
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Mar 2024 05:49:09 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Mar 2024 05:49:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Mar 2024 05:49:09 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42BAn3Dt109815;
	Mon, 11 Mar 2024 05:49:04 -0500
Message-ID: <86a067c4-3b28-448d-8c58-c7a9e80d697f@ti.com>
Date: Mon, 11 Mar 2024 16:19:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: ti: k3-j784s4: Add overlay to enable
 QSGMII mode with CPSW9G
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>
References: <20240131101441.1362409-1-c-vankar@ti.com>
 <20240131101441.1362409-6-c-vankar@ti.com>
 <7960af47-5d6a-4e54-9d58-a145311321f6@ti.com>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <7960af47-5d6a-4e54-9d58-a145311321f6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 31/01/24 21:20, Andrew Davis wrote:
> On 1/31/24 4:14 AM, Chintan Vankar wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> The J7 Quad Port Add-On Ethernet Card for J784S4 EVM supports
>> QSGMII mode. Use the overlay to configure CPSW9G ports in QSGMII
>> mode with the Add-On Ethernet Card connected to the ENET Expansion
>> 1 slot on the EVM.
>>
>> Add support to reset the PHY from kernel by using gpio-hog and
>> gpio-reset.
>>
>> Add aliases for CPSW9G ports to enable kernel to fetch MAC Addresses
>> directly from U-Boot.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/Makefile               |   7 +-
>>   .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 147 ++++++++++++++++++
>>   2 files changed, 153 insertions(+), 1 deletion(-)
>>   create mode 100644 
>> arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile 
>> b/arch/arm64/boot/dts/ti/Makefile
>> index 52c1dc910308..836bc197d932 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
>>   # Boards with J784s4 SoC
>>   dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
>>   # Build time test only, enabled by CONFIG_OF_ALL_DTBS
>>   k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
>> @@ -109,6 +110,8 @@ k3-j721e-evm-pcie0-ep-dtbs := 
>> k3-j721e-common-proc-board.dtb \
>>       k3-j721e-evm-pcie0-ep.dtbo
>>   k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
>>       k3-j721s2-evm-pcie1-ep.dtbo
>> +k3-j784s4-evm-quad-port-eth-exp1-dtbs := k3-j784s4-evm.dtb \
>> +    k3-j784s4-evm-quad-port-eth-exp1.dtbo
>>   dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>>       k3-am625-beagleplay-csi2-tevi-ov5640.dtb \
>>       k3-am625-sk-csi2-imx219.dtb \
>> @@ -121,7 +124,8 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>>       k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
>>       k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
>>       k3-j721e-evm-pcie0-ep.dtb \
>> -    k3-j721s2-evm-pcie1-ep.dtb
>> +    k3-j721s2-evm-pcie1-ep.dtb \
>> +    k3-j784s4-evm-quad-port-eth-exp1.dtb
>>   # Enable support for device-tree overlays
>>   DTC_FLAGS_k3-am625-beagleplay += -@
>> @@ -132,3 +136,4 @@ DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
>>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>>   DTC_FLAGS_k3-j721e-common-proc-board += -@
>>   DTC_FLAGS_k3-j721s2-common-proc-board += -@
>> +DTC_FLAGS_k3-j784s4-evm += -@
>> diff --git 
>> a/arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso 
>> b/arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
>> new file mode 100644
>> index 000000000000..0667389b07be
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
>> @@ -0,0 +1,147 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
>> +/**
>> + * DT Overlay for CPSW9G in QSGMII mode using J7 Quad Port ETH EXP 
>> Add-On Ethernet Card with
>> + * J784S4 EVM. The Add-On Ethernet Card has to be connected to ENET 
>> Expansion 1 slot on the
>> + * board.
>> + *
>> + * Product Datasheet: https://www.ti.com/lit/ug/spruj74/spruj74.pdf
>> + *
>> + * Link to QSGMII Daughtercard: 
>> https://www.ti.com/tool/J721EXENETXPANEVM
>> + *
>> + * Copyright (C) 2024 Texas Instruments Incorporated - 
>> https://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/phy/phy-cadence.h>
>> +#include <dt-bindings/phy/phy.h>
>> +
>> +#include "k3-pinctrl.h"
>> +#include "k3-serdes.h"
>> +
>> +&{/} {
>> +    aliases {
>> +        ethernet1 = 
>> "/bus@100000/ethernet@c000000/ethernet-ports/port@5";
> 
> Didn't you already set ethernet1 to be main_cpsw1_port1 in the base, 
> does this
> actually behave the way you want?

Yes. It behaves the way it is configured, explanation of how it
configures MAC addresses is explained at:
https://lore.kernel.org/all/0512d57f-af22-4bd8-8266-33d943d7eb4a@ti.com/

> 
> Otherwise looks okay,
> 
> Reviewed-by: Andrew Davis <afd@ti.com>
> 
>> +        ethernet2 = 
>> "/bus@100000/ethernet@c000000/ethernet-ports/port@6";
>> +        ethernet3 = 
>> "/bus@100000/ethernet@c000000/ethernet-ports/port@7";
>> +        ethernet4 = 
>> "/bus@100000/ethernet@c000000/ethernet-ports/port@8";
>> +        ethernet5 = 
>> "/bus@100000/ethernet@c200000/ethernet-ports/port@1";
>> +    };
>> +};
>> +
>> +&main_cpsw0 {
>> +    status = "okay";
>> +};
>> +
>> +&main_cpsw0_port5 {
>> +    status = "okay";
>> +    phy-handle = <&cpsw9g_phy1>;
>> +    phy-mode = "qsgmii";
>> +    mac-address = [00 00 00 00 00 00];
>> +    phys = <&cpsw0_phy_gmii_sel 5>, <&serdes2_qsgmii_link>;
>> +    phy-names = "mac", "serdes";
>> +};
>> +
>> +&main_cpsw0_port6 {
>> +    status = "okay";
>> +    phy-handle = <&cpsw9g_phy2>;
>> +    phy-mode = "qsgmii";
>> +    mac-address = [00 00 00 00 00 00];
>> +    phys = <&cpsw0_phy_gmii_sel 6>, <&serdes2_qsgmii_link>;
>> +    phy-names = "mac", "serdes";
>> +};
>> +
>> +&main_cpsw0_port7 {
>> +    status = "okay";
>> +    phy-handle = <&cpsw9g_phy0>;
>> +    phy-mode = "qsgmii";
>> +    mac-address = [00 00 00 00 00 00];
>> +    phys = <&cpsw0_phy_gmii_sel 7>, <&serdes2_qsgmii_link>;
>> +    phy-names = "mac", "serdes";
>> +};
>> +
>> +&main_cpsw0_port8 {
>> +    status = "okay";
>> +    phy-handle = <&cpsw9g_phy3>;
>> +    phy-mode = "qsgmii";
>> +    mac-address = [00 00 00 00 00 00];
>> +    phys = <&cpsw0_phy_gmii_sel 8>, <&serdes2_qsgmii_link>;
>> +    phy-names = "mac", "serdes";
>> +};
>> +
>> +&main_cpsw0_mdio {
>> +    status = "okay";
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&mdio0_default_pins>;
>> +    bus_freq = <1000000>;
>> +    reset-gpios = <&exp2 17 GPIO_ACTIVE_LOW>;
>> +    reset-post-delay-us = <120000>;
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    cpsw9g_phy0: ethernet-phy@16 {
>> +        reg = <16>;
>> +    };
>> +    cpsw9g_phy1: ethernet-phy@17 {
>> +        reg = <17>;
>> +    };
>> +    cpsw9g_phy2: ethernet-phy@18 {
>> +        reg = <18>;
>> +    };
>> +    cpsw9g_phy3: ethernet-phy@19 {
>> +        reg = <19>;
>> +    };
>> +};
>> +
>> +&exp2 {
>> +    /* Power-up ENET1 EXPANDER PHY. */
>> +    qsgmii-line-hog {
>> +        gpio-hog;
>> +        gpios = <16 GPIO_ACTIVE_HIGH>;
>> +        output-low;
>> +    };
>> +
>> +    /* Toggle MUX2 for MDIO lines */
>> +    mux-sel-hog {
>> +        gpio-hog;
>> +        gpios = <13 GPIO_ACTIVE_HIGH>, <14 GPIO_ACTIVE_HIGH>, <15 
>> GPIO_ACTIVE_HIGH>;
>> +        output-high;
>> +    };
>> +};
>> +
>> +&main_pmx0 {
>> +    mdio0_default_pins: mdio0-default-pins {
>> +        pinctrl-single,pins = <
>> +            J784S4_IOPAD(0x05c, PIN_INPUT, 4) /* (AC36) 
>> MCASP2_AXR0.MDIO1_MDIO */
>> +            J784S4_IOPAD(0x058, PIN_INPUT, 4) /* (AE37) 
>> MCASP2_AFSX.MDIO1_MDC */
>> +        >;
>> +    };
>> +};
>> +
>> +&serdes_ln_ctrl {
>> +    idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>, 
>> <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
>> +              <J784S4_SERDES0_LANE2_IP3_UNUSED>, 
>> <J784S4_SERDES0_LANE3_USB>,
>> +              <J784S4_SERDES1_LANE0_PCIE0_LANE0>, 
>> <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
>> +              <J784S4_SERDES1_LANE2_PCIE0_LANE2>, 
>> <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
>> +              <J784S4_SERDES2_LANE0_QSGMII_LANE5>, 
>> <J784S4_SERDES2_LANE1_QSGMII_LANE6>,
>> +              <J784S4_SERDES2_LANE2_QSGMII_LANE7>, 
>> <J784S4_SERDES2_LANE3_QSGMII_LANE8>;
>> +};
>> +
>> +&serdes_wiz2 {
>> +    status = "okay";
>> +};
>> +
>> +&serdes2 {
>> +    status = "okay";
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +    serdes2_qsgmii_link: phy@0 {
>> +        reg = <2>;
>> +        cdns,num-lanes = <1>;
>> +        #phy-cells = <0>;
>> +        cdns,phy-type = <PHY_TYPE_QSGMII>;
>> +        resets = <&serdes_wiz2 3>;
>> +    };
>> +};

