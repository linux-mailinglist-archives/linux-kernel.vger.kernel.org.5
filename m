Return-Path: <linux-kernel+bounces-47083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8328448EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA3EB284AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B245413BE85;
	Wed, 31 Jan 2024 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sNzJzDCu"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12512C530;
	Wed, 31 Jan 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732916; cv=none; b=tvsjJywWA3rl1G7xJDFd73x11yzKuz7dPRhOB2gszq1RxIlbq5HoOKlhfcM5x6//nUOsU1kkIMQvDHDrr5HkNtTro8Pg/E6lBj/76Yb/ZUswQ3Ra/kDS1c6Z/AdW+M3vzmileBDcQ7zxIoBUfzrlES9w4E6LGwy+cm8437jk6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732916; c=relaxed/simple;
	bh=AobQs8fGY6bAULna2NphD8OM/8oC3NaAwQ1AoRZBCJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V6EdQdTOcUBM+aDhu12vgwBB2wpZMSW+i/gjrmdIUe9pH6FEwdUeZSL4YPWHRtJEDlJ9KwG56+e6rpVYO3XUJcA7mq3vjASe0Ot12mOt+bVIgrGzyUBMgUObeYai65BsFAAtMOs0MA/WhvttSuz1P/nur6FdsOLaosKD1dXzmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sNzJzDCu; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VKSSUH036914;
	Wed, 31 Jan 2024 14:28:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706732908;
	bh=O4QKI7u5TiP72gjKRfe59KstoPVoUktboSkXvToUitc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sNzJzDCu71yLTLWbVZz4pix/MR90pfSHA8MfYjBSw3LWAJk6DYx0SzxFJ4zRrUl3a
	 A5MruFROlEETKmz+RsbD3LQPsPHKdfkLfBRpG7o7JaEPNeYCc/46Vsazk1GyUdDnXt
	 wOVYqAu53h8Oiy8UKfUp90tRsvpOycPdTsoc0euo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VKSSCl026864
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 14:28:28 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 14:28:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 14:28:27 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VKRSBG030672;
	Wed, 31 Jan 2024 14:28:27 -0600
Message-ID: <cbfcaceb-37bc-4333-9e90-31d2417ed5f5@ti.com>
Date: Wed, 31 Jan 2024 14:28:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/13] arm64: dts: ti: k3-am62a-main: Add sdhci0
 instance
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <devicetree@vger.kernel.org>,
        Randolph Sapp <rs@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
 <20240131003714.2779593-7-jm@ti.com>
 <20240131191717.igbfpfchen7gmpam@headstand>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240131191717.igbfpfchen7gmpam@headstand>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/31/24 1:17 PM, Nishanth Menon wrote:
> On 18:37-20240130, Judith Mendez wrote:
>> From: Nitin Yadav <n-yadav@ti.com>
>>
>> Add sdhci0 DT node in k3-am62a-main for eMMC support. Add otap/itap
>> values according to the datasheet[0], Refer to Table 7-79.
>>
>> [0] https://www.ti.com/lit/ds/symlink/am62a3.pdf
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>> ---
> 
> Side note: will appreciate if the dt patches come via the SoC dt tree
> for TI K3 and not via mmc tree.

Will use DO NOT MERGE for v1, thanks.

> 
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> index f0b8c9ab1459..523dee78123a 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> @@ -536,6 +536,24 @@ main_gpio1: gpio@601000 {
>>   		status = "disabled";
>>   	};
>>   
>> +	sdhci0: mmc@fa10000 {
>> +		compatible = "ti,am62-sdhci";
>> +		reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
>> +		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
>> +		clock-names = "clk_ahb", "clk_xin";
>> +		assigned-clocks = <&k3_clks 57 6>;
>> +		assigned-clock-parents = <&k3_clks 57 8>;
>> +		bus-width = <8>;
>> +		mmc-hs200-1_8v;
>> +		ti,clkbuf-sel = <0x7>;
>> +		ti,otap-del-sel-legacy = <0x0>;
>> +		ti,otap-del-sel-mmc-hs = <0x0>;
>> +		ti,otap-del-sel-hs200 = <0x6>;
>> +		status = "disabled";
>> +	};
>> +
>>   	sdhci1: mmc@fa00000 {
>>   		compatible = "ti,am62-sdhci";
>>   		reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
>> -- 
>> 2.34.1
>>
> 


