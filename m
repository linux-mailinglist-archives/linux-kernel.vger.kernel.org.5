Return-Path: <linux-kernel+bounces-50166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4641584752E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2036293EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED61487CD;
	Fri,  2 Feb 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BUwyuQaB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EE146919;
	Fri,  2 Feb 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892264; cv=none; b=O9fr8KpBNRQmzNu5L82NjiaPn2Qb8jiaOlD0G9hzfg3LP9WjSc5ikT8EdLLzSA7lw7FUi3E4Mslz7tm/50BV1/+edJVwgbuFwByGybU9H3Wv9yNhVtynQxP2YZB8sWEBry1eFnsivrD7NK1HlqyUDUdXZtTLDXn4Dtc3Y/v8yZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892264; c=relaxed/simple;
	bh=7W2wfru9NH8Buvh0gA0uwlam6d6COq6W/BYDoJV4ZGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jp6tca8ysYFBMpSAuJixbIc8hcXNO2vZgl78rCdW2bxGRcesczyNRS6S1RyJ+TOYEdmZf1Xndl8IvxKWusDgZmSW1ABQYEZTQR6geUwP7gjVDpToKi0ugZmNK6JAygP5RyDvSeceRfpFdaHJh350pWisciKZpGinA10m1u25yKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BUwyuQaB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412Ghp6u014745;
	Fri, 2 Feb 2024 10:43:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706892231;
	bh=fLTPqaxy3LnDEc8krX57o5bs9pobCIHmrVXZ2wTqfY8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BUwyuQaBEXyFM67SNYiRBytgw6owsKl537I8hO8qUF9IMi7xKoBmN66SpWRQoQz+/
	 Z+tVwteDQbnXt2Po+5MGaaRB5lC5YMcheXZL2cInznIA3T81zqV/qZZgNS1yWwDkbJ
	 nUuaJBUIqnRrUxu/QIF1F5ofc4q8+REdca1kpDr8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412Ghp3D003880
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 10:43:51 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 10:43:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 10:43:50 -0600
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412GhkrW087447;
	Fri, 2 Feb 2024 10:43:46 -0600
Message-ID: <58e2d55a-51cd-44ba-80b6-a6eaaf3ac85d@ti.com>
Date: Fri, 2 Feb 2024 22:13:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet
 support
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240122113045.1711818-1-danishanwar@ti.com>
 <20240122113045.1711818-3-danishanwar@ti.com>
 <156ae282-3052-45bd-be71-8220d04e73d1@kernel.org>
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <156ae282-3052-45bd-be71-8220d04e73d1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/2/2024 5:17 PM, Roger Quadros wrote:
> 
> 
> On 22/01/2024 13:30, MD Danish Anwar wrote:
>> ICSSG1 provides dual Gigabit Ethernet support with proper FW loaded.
>>
>> The ICSSG1 MII0 (RGMII1) has DP83869 PHY attached to it. The ICSSG1 shares
>> MII1 (RGMII2) PHY DP83869 with CPSW3g and it's assigned by default to
>> CPSW3g. The MDIO access to MII1 (RGMII2) PHY DP83869 is controlled by MDIO
>> bus switch and also assigned to CPSW3g. Therefore the ICSSG1 MII1 (RGMII2)
>> port is kept disable and ICSSG1 is enabled in single MAC mode by
>> default.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 102 ++++++++++++++++++++++++
>>  1 file changed, 102 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> index 8c5651d2cf5d..c08b0223be52 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> @@ -32,6 +32,8 @@ aliases {
>>  		mmc1 = &sdhci1;
>>  		ethernet0 = &cpsw_port1;
>>  		ethernet1 = &cpsw_port2;
>> +		ethernet2 = &icssg1_emac0;
>> +		ethernet3 = &icssg1_emac1;
> 
> If icssg1_emac1 is disabled by default there is no ethernet3 right?
> 

Yes. By default there isn't ethernet 3. I'll drop this alias from this
patch.

>>  	};
>>  
>>  	memory@80000000 {
>> @@ -229,6 +231,70 @@ transceiver2: can-phy1 {
>>  		max-bitrate = <5000000>;
>>  		standby-gpios = <&exp1 9 GPIO_ACTIVE_HIGH>;
>>  	};
>> +
>> +	icssg1_eth: icssg1-eth {
>> +		compatible = "ti,am642-icssg-prueth";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&icssg1_rgmii1_pins_default>;
>> +
> please drop blank line.
> 
>> +		sram = <&oc_sram>;
>> +		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
>> +		firmware-name = "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
>> +
>> +		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
>> +				      <2>,
>> +				      <2>,
>> +				      <2>,	/* MII mode */
>> +				      <2>,
>> +				      <2>;
>> +
> 
> please drop blank line.
> 
>> +		ti,mii-g-rt = <&icssg1_mii_g_rt>;
>> +		ti,mii-rt = <&icssg1_mii_rt>;
>> +		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
>> +
> please drop blank line.
> 
>> +		interrupt-parent = <&icssg1_intc>;
>> +		interrupts = <24 0 2>, <25 1 3>;
>> +		interrupt-names = "tx_ts0", "tx_ts1";
>> +
> please drop blank line.
>

Will drop all the blank lines.


>> +		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
>> +		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
>> +		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
>> +		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
>> +		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
>> +		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
>> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
>> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>> +			    "rx0", "rx1";
>> +
>> +		ethernet-ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			icssg1_emac0: port@0 {
>> +				reg = <0>;
>> +				phy-handle = <&icssg1_phy1>;
>> +				phy-mode = "rgmii-id";
>> +				ti,syscon-rgmii-delay = <&main_conf 0x4110>;
>> +				/* Filled in by bootloader */
>> +				local-mac-address = [00 00 00 00 00 00];
>> +			};
>> +			icssg1_emac1: port@1 {
>> +				reg = <1>;
>> +				ti,syscon-rgmii-delay = <&main_conf 0x4114>;
>> +				/* Filled in by bootloader */
>> +				local-mac-address = [00 00 00 00 00 00];
>> +				status = "disabled";
>> +			};
>> +		};
>> +	};
>>  };
>>  
>>  &main_pmx0 {
>> @@ -383,6 +449,30 @@ ddr_vtt_pins_default: ddr-vtt-default-pins {
>>  			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
>>  		>;
>>  	};
>> +
>> +	icssg1_mdio1_pins_default: icssg1-mdio1-default-pins {
>> +		pinctrl-single,pins = <
>> +			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0) /* (Y6) PRG1_MDIO0_MDC */
>> +			AM64X_IOPAD(0x0158, PIN_INPUT, 0) /* (AA6) PRG1_MDIO0_MDIO */
>> +		>;
>> +	};
>> +
>> +	icssg1_rgmii1_pins_default: icssg1-rgmii1-default-pins{
>> +		pinctrl-single,pins = <
>> +			AM64X_IOPAD(0x00b8, PIN_INPUT, 2) /* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
>> +			AM64X_IOPAD(0x00bc, PIN_INPUT, 2) /* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
>> +			AM64X_IOPAD(0x00c0, PIN_INPUT, 2) /* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
>> +			AM64X_IOPAD(0x00c4, PIN_INPUT, 2) /* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
>> +			AM64X_IOPAD(0x00d0, PIN_INPUT, 2) /* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
>> +			AM64X_IOPAD(0x00c8, PIN_INPUT, 2) /* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
>> +			AM64X_IOPAD(0x00e4, PIN_INPUT, 2) /* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
>> +			AM64X_IOPAD(0x00e8, PIN_INPUT, 2) /* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
>> +			AM64X_IOPAD(0x00ec, PIN_INPUT, 2) /* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
>> +			AM64X_IOPAD(0x00f0, PIN_INPUT, 2) /* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
>> +			AM64X_IOPAD(0x00f8, PIN_INPUT, 2) /* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
>> +			AM64X_IOPAD(0x00f4, PIN_INPUT, 2) /* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
>> +		>;
>> +	};
>>  };
>>  
>>  &main_uart0 {
>> @@ -731,3 +821,15 @@ &main_mcan1 {
>>  	pinctrl-0 = <&main_mcan1_pins_default>;
>>  	phys = <&transceiver2>;
>>  };
>> +
>> +&icssg1_mdio {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&icssg1_mdio1_pins_default>;
>> +
>> +	icssg1_phy1: ethernet-phy@f {
>> +		reg = <0xf>;
>> +		tx-internal-delay-ps = <250>;
>> +		rx-internal-delay-ps = <2000>;
>> +	};
>> +};
> 

-- 
Thanks and Regards,
Md Danish Anwar

