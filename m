Return-Path: <linux-kernel+bounces-48804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276898461C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71AF1F22A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8C18563A;
	Thu,  1 Feb 2024 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ilFj2PNV"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510808527E;
	Thu,  1 Feb 2024 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818159; cv=none; b=VQDIo4JjE9wMHuT6jnM3orpPI5GlDJjlnqS2N8R4hYtz16D1z7y06g0DYLyuzbtY8OB1MzIrsT3c5a/G6hM/XFKrUIIi6ZPxz0OwVmaFi/RiJ6Db5NgLANVZL13Bmy0AvaNaExbQ4ainbDXkAQN+gNU0PP8u2tLRo7QVd2uCqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818159; c=relaxed/simple;
	bh=EW6zO50jNE8LEi7zqDDeFfEa1UehgXfcEViL8fAmN/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qiuj5G8Odi6XmIEkGWDByse5n3dkEQZKSG1ihgyKHCcg4ou9wZEEm7gaU2hMPGmXc/FkJdv1ooSNOrSqaqFmOb2hnOvfzPwCcBOQaKPxndV0LDudMzZJyf5C9a/jz/rx199etiA4Sf0xkJTQ+/UCECzMybgxFLT5fWvoHk16f04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ilFj2PNV; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411K8ti0025389;
	Thu, 1 Feb 2024 14:08:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706818135;
	bh=vq6l9bOA+9EPk9QsUKSbSwGB/jfjZrse3PWQvl2f88s=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=ilFj2PNViSj3oGI7aFHI9l5HhTT8dv99TtnXaHP4OczwHHfgcQMrBgAPuOlwAeAka
	 MBnpNgENPS+T3+Vms4Axp7YFP29OnsplmaAmNztNlVrDbDrG8iSkgme0km6uhJA8js
	 koMcXWeCZ9zzlJd3NoAHUhp3F3VRgSUyii+33oAQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411K8tdI128262
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 14:08:55 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 14:08:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 14:08:54 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411K8rgh092262;
	Thu, 1 Feb 2024 14:08:53 -0600
Message-ID: <799640ba-3b7f-474b-8d70-64ed013e0755@ti.com>
Date: Thu, 1 Feb 2024 14:08:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] arm64: dts: ti: k3-j784s4: Add Wave5 Video
 Encoder/Decoder Node
Content-Language: en-US
To: "Brnich, Brandon" <b-brnich@ti.com>, "Menon, Nishanth" <nm@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Etheridge, Darren" <detheridge@ti.com>
References: <20240131212625.1862775-1-b-brnich@ti.com>
 <20240131212625.1862775-2-b-brnich@ti.com>
 <a5f0059d-b80f-44e6-8c1e-793054586e0a@ti.com>
 <a168bbdc2efd4cb1a71c6c6421dbd7ce@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <a168bbdc2efd4cb1a71c6c6421dbd7ce@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/1/24 1:13 PM, Brnich, Brandon wrote:
> Hi Andrew,
> 
>> -----Original Message-----
>> From: Davis, Andrew <afd@ti.com>
>> Sent: Thursday, February 1, 2024 12:35 PM
>> To: Brnich, Brandon <b-brnich@ti.com>; Menon, Nishanth <nm@ti.com>;
>> Raghavendra, Vignesh <vigneshr@ti.com>; Tero Kristo <kristo@kernel.org>;
>> Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
>> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
>> <will@kernel.org>; Bjorn Andersson <quic_bjorande@quicinc.com>; Geert
>> Uytterhoeven <geert+renesas@glider.be>; Arnd Bergmann
>> <arnd@arndb.de>; Konrad Dybcio <konrad.dybcio@linaro.org>; Neil
>> Armstrong <neil.armstrong@linaro.org>; Nícolas F . R . A . Prado
>> <nfraprado@collabora.com>; Marek Szyprowski
>> <m.szyprowski@samsung.com>; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Etheridge, Darren
>> <detheridge@ti.com>
>> Subject: Re: [PATCH v3 1/6] arm64: dts: ti: k3-j784s4: Add Wave5 Video
>> Encoder/Decoder Node
>>
>> On 1/31/24 3:26 PM, Brandon Brnich wrote:
>>> This patch adds support for the Wave521cl on the J784S4-evm.
>>>
>>> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   |  8 ++++++++
>>>    arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 20 ++++++++++++++++++++
>>>    arch/arm64/boot/dts/ti/k3-j784s4.dtsi      |  2 ++
>>>    3 files changed, 30 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> index f34b92acc56d..7d37c11b4df4 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> @@ -784,6 +784,14 @@ &main_gpio0 {
>>>    	status = "okay";
>>>    };
>>>
>>> +&vpu0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&vpu1 {
>>> +	status = "okay";
>>> +};
>>> +
>>>    &mcu_cpsw {
>>>    	status = "okay";
>>>    	pinctrl-names = "default";
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>> index f2b720ed1e4f..8b2623ac8160 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>> @@ -662,6 +662,26 @@ main_i2c6: i2c@2060000 {
>>>    		status = "disabled";
>>>    	};
>>>
>>> +	vpu0: video-codec@4210000 {
>>> +		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
>>> +		reg = <0x00 0x4210000 0x00 0x10000>;
>>> +		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
>>> +		clocks = <&k3_clks 241 2>;
>>> +		clock-names = "vcodec";
>>> +		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
>>> +		status = "disabled";
>>
>> Why are these default disabled? I don't see anything missing that would
>> need to be added at the board level. You disable them just to re-enable them
>> in the next patch. Leave these default enabled.
> 
> I thought that disabled by default was the standard for node in dtsi files, where
> they get specifically enabled in the particular dts file for the SoC.
> 

Only disabled if there is missing information needed for the node to function
that can only be added at the board level, e.g. pinmux usually.

> In V4 I will remove the disabled by default. Should this apply to all platforms in
> the series?

Yes

Andrew

>   
>>> +	};
>>> +
>>> +	vpu1: video-codec@4220000 {
>>> +		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
>>> +		reg = <0x00 0x4220000 0x00 0x10000>;
>>> +		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
>>> +		clocks = <&k3_clks 242 2>;
>>> +		clock-names = "vcodec";
>>> +		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
>>> +		status = "disabled";
>>> +	};
>>> +
>>>    	main_sdhci0: mmc@4f80000 {
>>>    		compatible = "ti,j721e-sdhci-8bit";
>>>    		reg = <0x00 0x04f80000 0x00 0x1000>, diff --git
>>> a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
>>> index 4398c3a463e1..93bb0cba1b48 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
>>> @@ -247,6 +247,8 @@ cbass_main: bus@100000 {
>>>    			 <0x00 0x30000000 0x00 0x30000000 0x00
>> 0x0c400000>, /* MAIN NAVSS */
>>>    			 <0x41 0x00000000 0x41 0x00000000 0x01
>> 0x00000000>, /* PCIe1 DAT1 */
>>>    			 <0x4e 0x20000000 0x4e 0x20000000 0x00
>> 0x00080000>, /* GPU */
>>> +			 <0x00 0x04210000 0x00 0x04210000 0x00
>> 0x00010000>, /* VPU0 */
>>> +			 <0x00 0x04220000 0x00 0x04220000 0x00
>> 0x00010000>, /* VPU1 */
>>
>> Add these in sorted by memory address order.
> 
> Will do in V4 as well.
> 
>>
>> Andrew
>>
>>>
>>>    			 /* MCUSS_WKUP Range */
>>>    			 <0x00 0x28380000 0x00 0x28380000 0x00
>> 0x03880000>,
> 
> Brandon

