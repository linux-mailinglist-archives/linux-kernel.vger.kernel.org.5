Return-Path: <linux-kernel+bounces-70928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC8B859E21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991E4B223CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01E210E1;
	Mon, 19 Feb 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vr0PpZvg"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43418224DA;
	Mon, 19 Feb 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331017; cv=none; b=tkTPe9Tz5rSK4ui4mDL4vAeX3iSoeAgEoVd34ElGGtjO8+RW4UtmvOpmtHPG1/09p2ITj8i3Kh5JgFIUaC3noIopkdiTTsstdD9w6iWoVteJQkdiuPfWfykJbabx24FSJhrlfNgQcWm9Mr16xl/1R+uR6bx0UJ1dlFps/8csZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331017; c=relaxed/simple;
	bh=eeunWe+QwDUXJ10WQnrgAfOE+WiHYgfOkZ1VkXfpxeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tQIlZwqJSO9JHOJfuFoGStjY8JeRRMDbtwJFej9mPS0VUAQeWakNlDz2Fybry5B0C52O9KkoXGeNsTS+UPE72qhRd/aa9FQGJc3MZYa93ZCXw8gQHtguIKinh13IFSIvHUViOuhFZQRIkBzmf0/BsQdx5XzoJmNIxyFpT3K9a0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vr0PpZvg; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41J8NIxJ065333;
	Mon, 19 Feb 2024 02:23:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708330998;
	bh=V+ENyFUmivihIc+SIaiSUWNu9rTsX6msVY869Qv8Fzc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Vr0PpZvgIQTlVxPh9ruBP5lPjCISx6vyYn5EuxspzOZRdcABBaOCkzWuLQib1bg/U
	 Ut+N5II8IWP2I225iQFj2a065G3UeT54ZNtAOEjV4tRzNsG0vmob62sx4ZDA6S5aNh
	 j6B41rGKG+BceY2+BihC2SdYj8Oey7bIN3Zk626Y=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41J8NIE5073763
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 02:23:18 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 02:23:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 02:23:17 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41J8NEil099835;
	Mon, 19 Feb 2024 02:23:14 -0600
Message-ID: <09853939-e623-42f1-bf80-1938161d1136@ti.com>
Date: Mon, 19 Feb 2024 13:53:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support
Content-Language: en-US
To: "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>
References: <20240216135533.904130-1-vaishnav.a@ti.com>
 <20240216135533.904130-3-vaishnav.a@ti.com>
 <0ca01a1b-8956-40dd-8286-77276e021633@ti.com>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <0ca01a1b-8956-40dd-8286-77276e021633@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit,

On 19/02/24 11:25, Kumar, Udit wrote:
> Hi Vaishnav
> 
> On 2/16/2024 7:25 PM, Vaishnav Achath wrote:
>> J722S EVM has S28HS512T 64 MiB Octal SPI NOR flash connected
>> to the OSPI interface, add support for the flash and describe
>> the partition information as per bootloader.
>>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 79 +++++++++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts 
>> b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> index 9e12a6e9111f..b1c6499c0c9d 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> @@ -169,6 +169,23 @@ J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) 
>> MDIO0_MDIO */
>>           >;
>>       };
>> +    ospi0_pins_default: ospi0-default-pins {
>> +        pinctrl-single,pins = <
>> +            J722S_IOPAD(0x0000, PIN_OUTPUT, 0) /* (P23) OSPI0_CLK */
>> +            J722S_IOPAD(0x002c, PIN_OUTPUT, 0) /* (M25) OSPI0_CSn0 */
>> +            J722S_IOPAD(0x000c, PIN_INPUT, 0) /* (L25) OSPI0_D0 */
>> +            J722S_IOPAD(0x0010, PIN_INPUT, 0) /* (N24) OSPI0_D1 */
>> +            J722S_IOPAD(0x0014, PIN_INPUT, 0) /* (N25) OSPI0_D2 */
>> +            J722S_IOPAD(0x0018, PIN_INPUT, 0) /* (M24) OSPI0_D3 */
>> +            J722S_IOPAD(0x001c, PIN_INPUT, 0) /* (N21) OSPI0_D4 */
>> +            J722S_IOPAD(0x0020, PIN_INPUT, 0) /* (N22) OSPI0_D5 */
>> +            J722S_IOPAD(0x0024, PIN_INPUT, 0) /* (P21) OSPI0_D6 */
>> +            J722S_IOPAD(0x0028, PIN_INPUT, 0) /* (N20) OSPI0_D7 */
>> +            J722S_IOPAD(0x0008, PIN_INPUT, 0) /* (P22) OSPI0_DQS */
> 
> 
> Could you check, Pin name in comments
> 
> For example, Schematic says L22 is for OSPI0_DQS , but comments says P22
> 
> However offsets are good .

Thanks for the review, I will fix this in the next revision.

> 
>> +        >;
>> +        bootph-all;
>> +    };
>> +
>>       rgmii1_pins_default: rgmii1-default-pins {
>>           pinctrl-single,pins = <
>>               J722S_IOPAD(0x014c, PIN_INPUT, 0) /* (AC25) RGMII1_RD0 */
>> @@ -290,6 +307,68 @@ exp1: gpio@23 {
>>       };
>>   };
>> +&ospi0 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&ospi0_pins_default>;
>> +    status = "okay";
>> +
>> +    flash@0 {
>> +        compatible = "jedec,spi-nor";
>> +        reg = <0x0>;
>> +        spi-tx-bus-width = <8>;
>> +        spi-rx-bus-width = <8>;
>> +        spi-max-frequency = <25000000>;
>> +        cdns,tshsl-ns = <60>;
>> +        cdns,tsd2d-ns = <60>;
>> +        cdns,tchsh-ns = <60>;
>> +        cdns,tslch-ns = <60>;
>> +        cdns,read-delay = <4>;
>> +        bootph-all;
>> +
>> +        partitions {
>> +            compatible = "fixed-partitions";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +
>> +            partition@0 {
>> +                label = "ospi.tiboot3";
>> +                reg = <0x00 0x80000>;
>> +            };
> 
> 
> I suggest to keep 1MB to accommodate future size increase
> 

For J722S, the maximum loadable SPL size is 0x7e000, images larger than 
these cannot be loaded by ROM, increasing the size here will not give 
any benefit, planning to keep as-is if there are no objections.

Thanks and Regards,
Vaishnav

>> +
>> +            partition@80000 {
>> +                label = "ospi.tispl";
>> +                reg = <0x80000 0x200000>;
>> +            };
>> +
>> +            partition@280000 {
>> +                label = "ospi.u-boot";
>> +                reg = <0x280000 0x400000>;
>> +            };
>> +
>> +            partition@680000 {
>> +                label = "ospi.env";
>> +                reg = <0x680000 0x40000>;
>> +            };
>> +
>> +            partition@6c0000 {
>> +                label = "ospi.env.backup";
>> +                reg = <0x6c0000 0x40000>;
>> +            };
>> +
>> +            partition@800000 {
>> +                label = "ospi.rootfs";
>> +                reg = <0x800000 0x37c0000>;
>> +            };
>> +
>> +            partition@3fc0000 {
>> +                label = "ospi.phypattern";
>> +                reg = <0x3fc0000 0x40000>;
>> +            };
>> +        };
>> +    };
>> +
>> +};
>> +
>>   &sdhci1 {
>>       /* SD/MMC */
>>       vmmc-supply = <&vdd_mmc1>;

