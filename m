Return-Path: <linux-kernel+bounces-62552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA4B8522AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9117E1C23103
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FEF50254;
	Mon, 12 Feb 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hU9emQIA"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4894F894;
	Mon, 12 Feb 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781282; cv=none; b=iTj8Mwm319rE7rncgDD/dH2gHY0+j2NRx/X/p3X4kcB26fM6nn5w2NLCgYu3WVwtqEm1tcW9Ih9QdoxP8ERY5yHNAoQ23834MSmayjF9l/xB8QzY8qjsUL83C9jutHdBc6J6ivCXNJ3H/3SMzQ4NsnNbcAmLZnCMKoPMWwvRgCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781282; c=relaxed/simple;
	bh=TOZZnCAYznNd7BZZIZ55mkTRNE5HYi3nbgVAE/3iI3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uwFp3yRxgZdKM+T/THgyHXf2UppanHoox1lJzuq3uh9m9XyP+BC1fCPP/oJvmakyv1Ws704GrzVuVGi8yIs1fTVV5V3zj7aZIz6Q+lxglxzNLh0SpGkeBOJSqM8E+7+aeOda7nWbKFhp3VFJ/uZcB1HpqK9IrUfPcWd70+NG0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hU9emQIA; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CNfEPL077852;
	Mon, 12 Feb 2024 17:41:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707781274;
	bh=AwKyGyYmPF+OgcL3x0VofbAOM9qHnHKY0dtoXt4SX7w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hU9emQIA+03UwLbENvF6o4AWJrOOngR+EJ2NUajTOqKyoaujd9QTU+p+PHG68TbnG
	 a2/vkiaymGaXtex3Qt2HHa3A5pHCT+7CIshJwF4kCyHsdYfnfI7BALCrREvyuwaf0P
	 UQ1/HaUrAOIokmAqLVjg/23skL0Q7Rdpggz04bBM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CNfEfr101861
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 17:41:14 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 17:41:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 17:41:14 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CNfD4S052827;
	Mon, 12 Feb 2024 17:41:13 -0600
Message-ID: <da370943-475d-4696-a2be-631346b2254b@ti.com>
Date: Mon, 12 Feb 2024 17:41:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/13] arm64: dts: ti: k3-am6*: Reorganize MMC
 properties
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, <devicetree@vger.kernel.org>,
        Randolph Sapp <rs@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
 <20240131003714.2779593-14-jm@ti.com>
 <9c78f4b5-8580-4679-ae65-60878221e00b@kernel.org>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <9c78f4b5-8580-4679-ae65-60878221e00b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger,

On 2/2/24 3:54 AM, Roger Quadros wrote:
> 
> 
> On 31/01/2024 02:37, Judith Mendez wrote:
>> Reorganize various MMC properties for MMC nodes to be
>> more uniform across devices.
>>
>> Add ti,clkbuf-sel to MMC nodes that are missing this property.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 5 +++--
>>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 2 --
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 4 ++--
>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 ++
>>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 7 +++++--
>>   arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 3 +--
>>   arch/arm64/boot/dts/ti/k3-am642-sk.dts         | 1 -
>>   7 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> index ca825088970f..32a8a68f1311 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -559,9 +559,9 @@ sdhci0: mmc@fa10000 {
>>   		clock-names = "clk_ahb", "clk_xin";
>>   		assigned-clocks = <&k3_clks 57 6>;
>>   		assigned-clock-parents = <&k3_clks 57 8>;
>> +		bus-width = <8>;
> 
> Is bus-width fix for this instance? If not then we don't really know here what
> bus-width is used by the board implementation. And it should come in the
> board DTS file.

I move bus-width changes to a different patch in v1. Why should it come
in the board DTS file?

> 
>>   		mmc-ddr-1_8v;
>>   		mmc-hs200-1_8v;
>> -		bus-width = <8>;
>>   		ti,clkbuf-sel = <0x7>;
>>   		ti,otap-del-sel-legacy = <0x0>;
>>   		ti,otap-del-sel-mmc-hs = <0x0>;
>> @@ -576,8 +576,8 @@ sdhci1: mmc@fa00000 {
>>   		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>>   		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>>   		clock-names = "clk_ahb", "clk_xin";
>> -		ti,clkbuf-sel = <0x7>;
>>   		bus-width = <4>;
>> +		ti,clkbuf-sel = <0x7>;
>>   		ti,otap-del-sel-legacy = <0x0>;
>>   		ti,otap-del-sel-sd-hs = <0x0>;
>>   		ti,otap-del-sel-sdr12 = <0xf>;
>> @@ -599,6 +599,7 @@ sdhci2: mmc@fa20000 {
>>   		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
>>   		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
>>   		clock-names = "clk_ahb", "clk_xin";
>> +		bus-width = <4>;
>>   		ti,clkbuf-sel = <0x7>;
>>   		ti,otap-del-sel-legacy = <0x0>;
>>   		ti,otap-del-sel-sd-hs = <0x0>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> index f69dbf9b8406..0422615e4d98 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> @@ -836,7 +836,6 @@ &sdhci1 {
>>   	bootph-all;
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&sd_pins_default>;
>> -
>>   	vmmc-supply = <&vdd_3v3_sd>;
>>   	vqmmc-supply = <&vdd_sd_dv>;
>>   	disable-wp;
>> @@ -850,7 +849,6 @@ &sdhci2 {
>>   	vmmc-supply = <&wlan_en>;
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&wifi_pins_default>, <&wifi_32k_clk>;
>> -	bus-width = <4>;
> 
> I wouldn't remove this from here if bus-width is variable for this
> instance of MMC controller.

It is moved to the .dtsi file. Sorry for the confusion.

> 
>>   	non-removable;
>>   	ti,fails-without-test-cd;
>>   	cap-power-off-card;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> index db5a7746c82e..88b112e657c8 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> @@ -561,6 +561,8 @@ sdhci1: mmc@fa00000 {
>>   		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>>   		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>>   		clock-names = "clk_ahb", "clk_xin";
>> +		bus-width = <4>;
>> +		ti,clkbuf-sel = <0x7>;
>>   		ti,otap-del-sel-legacy = <0x0>;
>>   		ti,otap-del-sel-sd-hs = <0x0>;
>>   		ti,otap-del-sel-sdr12 = <0xf>;
>> @@ -572,8 +574,6 @@ sdhci1: mmc@fa00000 {
>>   		ti,itap-del-sel-sd-hs = <0x0>;
>>   		ti,itap-del-sel-sdr12 = <0x0>;
>>   		ti,itap-del-sel-sdr25 = <0x0>;
>> -		ti,clkbuf-sel = <0x7>;
>> -		bus-width = <4>;
>>   		no-1-8-v;
>>   		status = "disabled";
>>   	};
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> index 6dd48c826f74..2b4c10b35db1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> @@ -407,10 +407,12 @@ &main_i2c2 {
>>   };
>>   
>>   &sdhci0 {
>> +	/* eMMC */
>>   	bootph-all;
>>   	status = "okay";
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&main_mmc0_pins_default>;
>> +	non-removable;
>>   	disable-wp;
>>   };
>>   
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index 1842f05ac351..34706ab9f5fb 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -626,9 +626,11 @@ sdhci0: mmc@fa10000 {
>>   		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>>   		clocks = <&k3_clks 57 0>, <&k3_clks 57 1>;
>>   		clock-names = "clk_ahb", "clk_xin";
>> +		bus-width = <8>;
>>   		mmc-ddr-1_8v;
>>   		mmc-hs200-1_8v;
>> -		ti,trm-icp = <0x2>;
>> +		ti,clkbuf-sel = <0x7>;
>> +		ti,trm-icp = <0x8>;
>>   		ti,otap-del-sel-legacy = <0x0>;
>>   		ti,otap-del-sel-mmc-hs = <0x0>;
>>   		ti,otap-del-sel-ddr52 = <0x6>;
>> @@ -646,6 +648,8 @@ sdhci1: mmc@fa00000 {
>>   		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>>   		clocks = <&k3_clks 58 3>, <&k3_clks 58 4>;
>>   		clock-names = "clk_ahb", "clk_xin";
>> +		bus-width = <4>;
>> +		ti,clkbuf-sel = <0x7>;
>>   		ti,otap-del-sel-legacy = <0x0>;
>>   		ti,otap-del-sel-sd-hs = <0x0>;
>>   		ti,otap-del-sel-sdr12 = <0xf>;
>> @@ -653,7 +657,6 @@ sdhci1: mmc@fa00000 {
>>   		ti,otap-del-sel-sdr50 = <0xc>;
>>   		ti,otap-del-sel-sdr104 = <0x6>;
>>   		ti,otap-del-sel-ddr50 = <0x9>;
>> -		ti,clkbuf-sel = <0x7>;
>>   		ti,itap-del-sel-legacy = <0x0>;
>>   		ti,itap-del-sel-sd-hs = <0x0>;
>>   		ti,itap-del-sel-sdr12 = <0x0>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> index 0583ec3a9b52..572b98a217a6 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> @@ -493,8 +493,8 @@ eeprom@0 {
>>   
>>   /* eMMC */
>>   &sdhci0 {
>> +	bootph-all;
>>   	status = "okay";
>> -	bus-width = <8>;
>>   	non-removable;
>>   	ti,driver-strength-ohm = <50>;
>>   	disable-wp;
>> @@ -506,7 +506,6 @@ &sdhci1 {
>>   	status = "okay";
>>   	vmmc-supply = <&vdd_mmc1>;
>>   	pinctrl-names = "default";
>> -	bus-width = <4>;
>>   	pinctrl-0 = <&main_mmc1_pins_default>;
>>   	disable-wp;
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> index c3a77f6282cb..600056105874 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> @@ -469,7 +469,6 @@ &sdhci1 {
>>   	status = "okay";
>>   	vmmc-supply = <&vdd_mmc1>;
>>   	pinctrl-names = "default";
>> -	bus-width = <4>;
>>   	pinctrl-0 = <&main_mmc1_pins_default>;
>>   	disable-wp;
>>   };
> 

~ Judith


