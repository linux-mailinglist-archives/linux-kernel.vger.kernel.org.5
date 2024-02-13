Return-Path: <linux-kernel+bounces-63836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43073853540
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED98283699
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C65F551;
	Tue, 13 Feb 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="koe3/Qg6"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF65EE86;
	Tue, 13 Feb 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839582; cv=none; b=G9u3Myb7FE2Os18yFWcan0mEfZqXR0Lo4xHdHy/Y4IZOUEgQrcGFCmtnxymyw8+tsrk39iNWQpZSK9bk5yQT2czcGplZ7283G2P4NJmVbZ1jawN/zfVvFH3YKuRLZlVnL7m82v3UBE85qD3ek3tvBt8S6GGr5VzCtEFACFgRURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839582; c=relaxed/simple;
	bh=JOElLBZRLNXkgO+ogIXtBjUlGRxT4DytUTJ0a4Pm/gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IkB1EEiWX8mlYmmm9rfYLVSQG48/BnAMPgrKIioJoKq0iq0d1+m6vgvKuHwyBr5N9rbKeffJzhoxgMDWd/4VLU5T+RY7Xjwaj2zKWDl/R7CfuUCUfENXHFYxCRQf98HSQRl55kWjXSRpYn3vBx567ATOPeGlbIncbNvvJOwI9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=koe3/Qg6; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41DFqYqi022638;
	Tue, 13 Feb 2024 09:52:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707839554;
	bh=z00QlEOHtNWhJ8YhrANRAr/ZBFrK+uBZEFZ7BAZUXFU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=koe3/Qg6ngX6wLCQgQXoxuKxtV58ZdLlJUD4ZJ+9VXzky4WSwU9PLIAFXgZtuT/0G
	 9V9hFHPEhs6evQ/u1QB96WjkLUFtcvRpj6kHDwBxVcBGQHGT47UzIuGhCHnVPgl4X+
	 q4ilnZhCSTmYSkhLC8vaUawjBWg/VdYmIoNAXIJ8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41DFqY6K002313
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 09:52:34 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 09:52:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 09:52:33 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41DFqXS0057794;
	Tue, 13 Feb 2024 09:52:33 -0600
Message-ID: <e805b72a-17a2-4a54-bb90-dab44a551711@ti.com>
Date: Tue, 13 Feb 2024 09:52:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] arm64: dts: ti: k3-am6*: Remove DLL properties for
 soft PHYs
Content-Language: en-US
To: Wadim Egorov <w.egorov@phytec.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Francesco
 Dolcini <francesco.dolcini@toradex.com>
References: <20240213002416.1560357-1-jm@ti.com>
 <20240213002416.1560357-7-jm@ti.com>
 <5f9fd69e-d3f6-4293-8746-06173f24e521@phytec.de>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <5f9fd69e-d3f6-4293-8746-06173f24e521@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Wadim,

On 2/12/24 11:26 PM, Wadim Egorov wrote:
> Hi Judith,
> 
> Am 13.02.24 um 01:24 schrieb Judith Mendez:
>> Remove DLL properties which are not applicable for soft PHYs
>> since these PHYs do not have a DLL to enable.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi              | 3 ---
>>   arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi       | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi     | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi        | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi       | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi            | 2 --
>>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts        | 3 ---
>>   arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi             | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts               | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts               | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi        | 2 --
>>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi              | 1 -
>>   arch/arm64/boot/dts/ti/k3-am642-evm.dts               | 1 -
>>   arch/arm64/boot/dts/ti/k3-am642-sk.dts                | 1 -
> 
> what about sdhci1 node updates on
>    - k3-am642-phyboard-electra-rdk.dts
>    - k3-am642-tqma64xxl-mbax4xxl.dts
> 

The same patch applies for this boards.

> Also does this apply only for am64 and sdhci1 (and not sdhci0)?
> In your v1 you are describing that only AM64x and AM62p devices have a 
> DLL to update the drive strength.
> Trying to understand why only one of the interfaces gets updated.

This patch only applies for AM64x sdhci1 node, since sdhci1
is a soft PHY and does not have a DLL.

~ Judith

> 
> Regards,
> Wadim
> 
>>   15 files changed, 21 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> index fe0cc4a9a501..79ed5cbbbda1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -561,7 +561,6 @@ sdhci0: mmc@fa10000 {
>>           assigned-clock-parents = <&k3_clks 57 8>;
>>           mmc-ddr-1_8v;
>>           mmc-hs200-1_8v;
>> -        ti,trm-icp = <0x2>;
>>           bus-width = <8>;
>>           ti,clkbuf-sel = <0x7>;
>>           ti,otap-del-sel-legacy = <0x0>;
>> @@ -580,7 +579,6 @@ sdhci1: mmc@fa00000 {
>>           power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>>           clock-names = "clk_ahb", "clk_xin";
>> -        ti,trm-icp = <0x2>;
>>           ti,otap-del-sel-legacy = <0x8>;
>>           ti,otap-del-sel-sd-hs = <0x0>;
>>           ti,otap-del-sel-sdr12 = <0x0>;
>> @@ -604,7 +602,6 @@ sdhci2: mmc@fa20000 {
>>           power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
>>           clock-names = "clk_ahb", "clk_xin";
>> -        ti,trm-icp = <0x2>;
>>           ti,otap-del-sel-legacy = <0x8>;
>>           ti,otap-del-sel-sd-hs = <0x0>;
>>           ti,otap-del-sel-sdr12 = <0x0>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
>> index 3372a256c90f..43488cc8bcb1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
>> @@ -317,7 +317,6 @@ serial_flash: flash@0 {
>>   &sdhci0 {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&main_mmc0_pins_default>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>       non-removable;
>>       status = "okay";
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
>> index bf6d27e70bc4..6c4cec8728e4 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
>> @@ -185,7 +185,6 @@ &ospi0 {
>>   /* Verdin SD_1 */
>>   &sdhci1 {
>> -    ti,driver-strength-ohm = <33>;
>>       status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
>> index 680071688dcb..be62648e7818 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
>> @@ -206,7 +206,6 @@ &ospi0 {
>>   /* Verdin SD_1 */
>>   &sdhci1 {
>> -    ti,driver-strength-ohm = <33>;
>>       status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
>> index a6808b10c7b2..4768ef42c4fc 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
>> @@ -26,7 +26,6 @@ &sdhci2 {
>>       mmc-pwrseq = <&wifi_pwrseq>;
>>       non-removable;
>>       ti,fails-without-test-cd;
>> -    ti,driver-strength-ohm = <50>;
>>       vmmc-supply = <&reg_3v3>;
>>       status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>> index 6a06724b6d16..d68310444bcb 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>> @@ -1407,7 +1407,6 @@ &sdhci0 {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&pinctrl_sdhci0>;
>>       non-removable;
>> -    ti,driver-strength-ohm = <50>;
>>       status = "okay";
>>   };
>> @@ -1416,7 +1415,6 @@ &sdhci1 {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&pinctrl_sdhci1>;
>>       disable-wp;
>> -    ti,driver-strength-ohm = <50>;
>>       vmmc-supply = <&reg_sdhc1_vmmc>;
>>       vqmmc-supply = <&reg_sdhc1_vqmmc>;
>>       status = "disabled";
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts 
>> b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> index 3b4246ce49de..bb6a5837bcb3 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> @@ -819,7 +819,6 @@ &sdhci0 {
>>       bootph-all;
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&emmc_pins_default>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>       status = "okay";
>>   };
>> @@ -832,7 +831,6 @@ &sdhci1 {
>>       vmmc-supply = <&vdd_3v3_sd>;
>>       vqmmc-supply = <&vdd_sd_dv>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>       cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
>>       cd-debounce-delay-ms = <100>;
>> @@ -849,7 +847,6 @@ &sdhci2 {
>>       ti,fails-without-test-cd;
>>       cap-power-off-card;
>>       keep-power-in-suspend;
>> -    ti,driver-strength-ohm = <50>;
>>       assigned-clocks = <&k3_clks 157 158>;
>>       assigned-clock-parents = <&k3_clks 157 160>;
>>       #address-cells = <1>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts 
>> b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
>> index 5c31f0453def..a83a90497857 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
>> @@ -334,7 +334,6 @@ &sdhci1 {
>>       vqmmc-supply = <&vddshv5_sdio>;
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&main_mmc1_pins_default>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>       no-1-8-v;
>>       status = "okay";
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> index 6806288ec227..f283777d54b4 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> @@ -561,7 +561,6 @@ sdhci1: mmc@fa00000 {
>>           power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>>           clock-names = "clk_ahb", "clk_xin";
>> -        ti,trm-icp = <0x2>;
>>           ti,otap-del-sel-legacy = <0x0>;
>>           ti,otap-del-sel-sd-hs = <0x0>;
>>           ti,otap-del-sel-sdr12 = <0xf>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts 
>> b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> index c99b2e90f76d..f241637a5642 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> @@ -582,7 +582,6 @@ &sdhci1 {
>>       vmmc-supply = <&vdd_mmc1>;
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&main_mmc1_pins_default>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts 
>> b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> index 8c73587b0b62..5c9b73726ebd 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> @@ -422,7 +422,6 @@ &sdhci1 {
>>       vqmmc-supply = <&vddshv_sdio>;
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&main_mmc1_pins_default>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>       bootph-all;
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> index 6dd496cd459a..3c45782ab2b7 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> @@ -411,7 +411,6 @@ &sdhci0 {
>>       status = "okay";
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&main_mmc0_pins_default>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>   };
>> @@ -421,7 +420,6 @@ &sdhci1 {
>>       status = "okay";
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&main_mmc1_pins_default>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index 9bfa0a969bfc..a29847735c6e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -646,7 +646,6 @@ sdhci1: mmc@fa00000 {
>>           power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 58 3>, <&k3_clks 58 4>;
>>           clock-names = "clk_ahb", "clk_xin";
>> -        ti,trm-icp = <0x2>;
>>           ti,otap-del-sel-legacy = <0x0>;
>>           ti,otap-del-sel-sd-hs = <0x0>;
>>           ti,otap-del-sel-sdr12 = <0xf>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts 
>> b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> index 5c546ae76d3e..f308076d608a 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> @@ -508,7 +508,6 @@ &sdhci1 {
>>       pinctrl-names = "default";
>>       bus-width = <4>;
>>       pinctrl-0 = <&main_mmc1_pins_default>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts 
>> b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> index cce04e188ff6..b286eaa02ada 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> @@ -471,7 +471,6 @@ &sdhci1 {
>>       pinctrl-names = "default";
>>       bus-width = <4>;
>>       pinctrl-0 = <&main_mmc1_pins_default>;
>> -    ti,driver-strength-ohm = <50>;
>>       disable-wp;
>>   };


