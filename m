Return-Path: <linux-kernel+bounces-62550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EBF8522AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863E11C228BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429850254;
	Mon, 12 Feb 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t/2mUQ7v"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309A50251;
	Mon, 12 Feb 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781144; cv=none; b=JlhORQva7Dc2Pov7wpMJbvtWccVjD4e60K8vSt+EIhxCERD6yn4rKKku1UoMc8T2cLdv9q+aTOrxVzYn6vfWStDn/EV3EYZz/1ZMHNC538srlnsGaPwIvstfD6qAg/srZvhnZAFWbfajZEfcy5aOWKOyzTL4+KaYzJeBW7rn7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781144; c=relaxed/simple;
	bh=Z8oypL0/I5zgoi94ren6g6IFnyKXf9SiRaVde9Wd9DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sbBw3ZLTEvE+pstfzbYyqwi7uuw/sLzeNlC0EHyQ7nmvqoM54PkFIIEQm8UvRx9Q3vpzzB1F5G9avzTLobcZ95wpcNL+JL4LDcOQayuj99UYpMIZZZ1a9sG2nIPzGcZdY9rmniHDRL03bf17H95n8NS5NgumFxdiTaTiofQ2K8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t/2mUQ7v; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CNctL4125497;
	Mon, 12 Feb 2024 17:38:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707781135;
	bh=iTFElGTHMEr/JK0EWjRnNYP2a/92ZvSdFx07frdsnqg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=t/2mUQ7vNwcOFUEM9xjwN7d5akTUNOXdr8hnQ5ta4YsU2RvczrrSMxO2kOFVWMUVd
	 zkScWSlCLXCUCcERzaFcDgpy4mCMmjMFm4BUBkPdjJIgqjuiFIycv2MguFb6HyQjYw
	 yPjKBRdktAj9DwgCZnWrAwTu3oKAoX1r4JJwSkuM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CNctnP116534
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 17:38:55 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 17:38:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 17:38:55 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CNcsGr049509;
	Mon, 12 Feb 2024 17:38:54 -0600
Message-ID: <c94b7399-31c0-4e7d-a616-8f29c86a27ba@ti.com>
Date: Mon, 12 Feb 2024 17:38:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/13] arm64: dts: ti: k3-am62p: Add missing
 properties for MMC
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
 <20240131003714.2779593-12-jm@ti.com>
 <0c44863b-7a3e-48bc-bdc8-1069df6d79bd@kernel.org>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <0c44863b-7a3e-48bc-bdc8-1069df6d79bd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger,

On 2/2/24 3:50 AM, Roger Quadros wrote:
> 
> 
> On 31/01/2024 02:37, Judith Mendez wrote:
>> Add missing properties to enable HS200 timing for MMC0 and
>> SDR104 timing for MMC1 according to the datasheet [0] for
>> AM62p device, refer to Table 7-79 for MMC0 and Table 7-97
>> for MMC1/MMC2.
>>
>> [0] https://www.ti.com/lit/ds/symlink/am625.pdf
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 44 +++++++++++++++++++++--
>>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts   |  6 ++--
>>   2 files changed, 45 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> index 4c51bae06b57..f743700dd5bd 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> @@ -534,7 +534,21 @@ sdhci0: mmc@fa10000 {
>>   		clock-names = "clk_ahb", "clk_xin";
>>   		assigned-clocks = <&k3_clks 57 2>;
>>   		assigned-clock-parents = <&k3_clks 57 4>;
>> -		ti,otap-del-sel-legacy = <0x0>;
>> +		bus-width = <8>;
>> +		mmc-ddr-1_8v;
>> +		mmc-hs200-1_8v;
>> +		mmc-hs400-1_8v;
>> +		ti,clkbuf-sel = <0x7>;
>> +		ti,strobe-sel = <0x77>;
>> +		ti,trm-icp = <0x8>;
>> +		ti,otap-del-sel-legacy = <0x1>;
>> +		ti,otap-del-sel-mmc-hs = <0x1>;
>> +		ti,otap-del-sel-ddr52 = <0x6>;
>> +		ti,otap-del-sel-hs200 = <0x8>;
>> +		ti,otap-del-sel-hs400 = <0x5>;
>> +		ti,itap-del-sel-legacy = <0x10>;
>> +		ti,itap-del-sel-mmc-hs = <0xa>;
>> +		ti,itap-del-sel-ddr52 = <0x3>;
>>   		status = "disabled";
>>   	};
>>   
>> @@ -545,7 +559,19 @@ sdhci1: mmc@fa00000 {
>>   		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>>   		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>>   		clock-names = "clk_ahb", "clk_xin";
>> -		ti,otap-del-sel-legacy = <0x8>;
>> +		bus-width = <4>;
>> +		ti,clkbuf-sel = <0x7>;
>> +		ti,otap-del-sel-legacy = <0x0>;
>> +		ti,otap-del-sel-sd-hs = <0x0>;
>> +		ti,otap-del-sel-sdr12 = <0xf>;
>> +		ti,otap-del-sel-sdr25 = <0xf>;
>> +		ti,otap-del-sel-sdr50 = <0xc>;
>> +		ti,otap-del-sel-ddr50 = <0x9>;
>> +		ti,otap-del-sel-sdr104 = <0x6>;
>> +		ti,itap-del-sel-legacy = <0x0>;
>> +		ti,itap-del-sel-sd-hs = <0x0>;
>> +		ti,itap-del-sel-sdr12 = <0x0>;
>> +		ti,itap-del-sel-sdr25 = <0x0>;
>>   		status = "disabled";
>>   	};
>>   
>> @@ -556,7 +582,19 @@ sdhci2: mmc@fa20000 {
>>   		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
>>   		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
>>   		clock-names = "clk_ahb", "clk_xin";
>> -		ti,otap-del-sel-legacy = <0x8>;
>> +		bus-width = <4>;
>> +		ti,clkbuf-sel = <0x7>;
>> +		ti,otap-del-sel-legacy = <0x0>;
>> +		ti,otap-del-sel-sd-hs = <0x0>;
>> +		ti,otap-del-sel-sdr12 = <0xf>;
>> +		ti,otap-del-sel-sdr25 = <0xf>;
>> +		ti,otap-del-sel-sdr50 = <0xc>;
>> +		ti,otap-del-sel-ddr50 = <0x9>;
>> +		ti,otap-del-sel-sdr104 = <0x6>;
>> +		ti,itap-del-sel-legacy = <0x0>;
>> +		ti,itap-del-sel-sd-hs = <0x0>;
>> +		ti,itap-del-sel-sdr12 = <0x0>;
>> +		ti,itap-del-sel-sdr25 = <0x0>;
>>   		status = "disabled";
>>   	};
>>   
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> index 1773c05f752c..10156a04a92c 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> @@ -410,13 +410,17 @@ &main_i2c2 {
>>   };
>>   
>>   &sdhci0 {
>> +	/* eMMC */
>> +	bootph-all;
>>   	status = "okay";
>> +	non-removable;
>>   	ti,driver-strength-ohm = <50>;
>>   	disable-wp;
>>   };
>>   
>>   &sdhci1 {
>>   	/* SD/MMC */
>> +	bootph-all;
>>   	status = "okay";
>>   	vmmc-supply = <&vdd_mmc1>;
>>   	vqmmc-supply = <&vddshv_sdio>;
>> @@ -424,8 +428,6 @@ &sdhci1 {
>>   	pinctrl-0 = <&main_mmc1_pins_default>;
>>   	ti,driver-strength-ohm = <50>;
>>   	disable-wp;
>> -	no-1-8-v;
> 
> Why was 'no-1-8-v' removed?

To enable HS400 timing, the no-1-8-v property should
be removed. I add this comment in patch description for
v1.

Thanks for reviewing!

~ Judith

> 
>> -	bootph-all;
>>   };
>>   
>>   &cpsw3g {
> 


