Return-Path: <linux-kernel+bounces-119960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5CA88CF71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4631F3804D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482C12B143;
	Tue, 26 Mar 2024 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NqotJdVz"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D76EDF;
	Tue, 26 Mar 2024 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486561; cv=none; b=S9OmmNRPUjYH71OCBWRP71omx2gh8XrKL4iKWl4pZIUZfP8O38M7nk4wm4VHe64lqlj/ilPpJsg+ObwDCV0sPBo1KfzaS27dllFMWzhNm+vzy2eNcWPF8RExiUL3+DdmPt1QRFOC/ppnMNAjFIPKNDGTQ9gR+WkctS13fock4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486561; c=relaxed/simple;
	bh=w35Zj+d0IyalQMWGYTBSeTjFwYAewQtIyiV34Mz8T7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FbAn3N2YlQtuIHgq0bnY6idkfgW8baA74RXTz0x+elG0qUAktcyjJA+8vP0YfdmXRgHjT3s0v5BfuxHlph1APVjABG01flQUK0srByJrbxR0jP4QQbJRV7k41pqgVUUJxvR1/lVyD1FEKm8z/miZ5J7duxwX+eFntxQr9A2a5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NqotJdVz; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QKtmi5095003;
	Tue, 26 Mar 2024 15:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711486548;
	bh=Smy5k79vUe3OVEPHAMKYoMHVAX3ehZ3inkD06MeHs1A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NqotJdVzXO8kVtZYpNXo8LQ5S2mLSUdodqfgatERWVTgbXM4QtNTS14w85tV9iGii
	 E7CUYDnpHHPw9ssUNpZugnQ6Q//+0NIDwSk0gm3kG236MuwNSdMLs6r6kvU95k7UKW
	 WScI8+9pUtEs1Ny5G2COXPmLUEevF7cX7CdQRDa4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QKtmKK065361
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 15:55:48 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 15:55:48 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 15:55:47 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QKtlLY084896;
	Tue, 26 Mar 2024 15:55:47 -0500
Message-ID: <fe1feb62-767f-40d2-95f9-75594afccafb@ti.com>
Date: Tue, 26 Mar 2024 15:55:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: dts: ti: k3-am65: Remove UART baud rate
 selection
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240326185441.29656-1-afd@ti.com>
 <20240326202105.duim7cooxk4dwlz2@makeshift>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240326202105.duim7cooxk4dwlz2@makeshift>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/26/24 3:21 PM, Nishanth Menon wrote:
> On 13:54-20240326, Andrew Davis wrote:
>> As described in the binding document for the "current-speed" property:
>>
>> "This should only be present in case a driver has no chance to know the
>> baud rate of the slave device."
>>
>> This is not the case for the UART used in K3 devices, the current
>> baud-rate can be calculated from the registers. Having this property
> 
> I do not understand the explanation above -> how does one do this?
> If you are talking of the 8250 divider registers, someone has to program
> those - how do you compute the baud rate from registers that aren't
> programmed? Note: I am not commenting on the rationale of removing the
> property, just trying to understand the assertion above.
> 

This divider register, when "unprogrammed", has a default value. When one
wants to use a TTY/serial device they pick the baud-rate(stty, termios, etc.),
that then programs the register with the value they selected.

As stated below, this property does not program that register, it only
tells the driver what it should have already been set to. Some drivers
need this as they do not have a way to know what the divider is actually
set to.

Setting this in our case is wrong for two reasons:
1) Our driver can and does just check the divider itself.
2) We do not setup most of these UARTs before the kernel starts, so
    if our driver *did* care about this property it would not reflect
    the actual divider value (which is unprogrammed at this point).

Andrew

>> has the effect of actually skipping the baud-rate setup in some drivers
>> as it assumes it will already be set to this rate, which may not always
>> be the case.
>>
>> It seems this property's purpose was mistaken as selecting the desired
>> baud-rate, which it does not. It would have been wrong to select that
>> here anyway as DT is not the place for configuration, especially when
>> there are already more standard ways to set serial baud-rates.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 1 -
>>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi    | 1 -
>>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 1 -
>>   3 files changed, 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index ff857117d7193..670557c89f756 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -89,7 +89,6 @@ main_uart0: serial@2800000 {
>>   		reg = <0x00 0x02800000 0x00 0x100>;
>>   		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
>>   		clock-frequency = <48000000>;
>> -		current-speed = <115200>;
>>   		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
>>   		status = "disabled";
>>   	};
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>> index 6ff3ccc39fb44..4f808e5089755 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>> @@ -43,7 +43,6 @@ mcu_uart0: serial@40a00000 {
>>   		reg = <0x00 0x40a00000 0x00 0x100>;
>>   		interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
>>   		clock-frequency = <96000000>;
>> -		current-speed = <115200>;
>>   		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
>>   		status = "disabled";
>>   	};
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
>> index 37527890ddeaf..eee072e44a42f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
>> @@ -59,7 +59,6 @@ wkup_uart0: serial@42300000 {
>>   		reg = <0x42300000 0x100>;
>>   		interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
>>   		clock-frequency = <48000000>;
>> -		current-speed = <115200>;
>>   		power-domains = <&k3_pds 150 TI_SCI_PD_EXCLUSIVE>;
>>   		status = "disabled";
>>   	};
>> -- 
>> 2.39.2
>>
> 

