Return-Path: <linux-kernel+bounces-141948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B2F8A256D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB211C21971
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2014C17BBF;
	Fri, 12 Apr 2024 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l2CRK+as"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6987D531;
	Fri, 12 Apr 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898372; cv=none; b=YXRj43KqSPFFgF5ATJSXrC+YO6/n2IDPpFLDGNly4BL4kxkFTQAO8lx6zi5RXuBBPRjrs7qlc8zUFHlpqcG0Dv18LZqJsWM6Mb6vyPXshGxIx+3o5hkZQaPsmVgj0xaDzXzwij3nHdCqzBxm7MMVi5dqDuOGo0Y42UIHMb/eBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898372; c=relaxed/simple;
	bh=jObT7VfLMIIqVsT1akCrKsockMOBLbdK6DS9sYuuHpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mwu56qv8+v183mNf+6bxIEd6VmuZxWeSlNAY+fHMbiX8SeKSFaHzesGNPFzPerlzlOLh0GGjwFWeZzPxG6mWI9XQRY6KR+64aQ6WuLhqmkw18kLp9KOdf7/z85fAOPhML/p6YxhkHW+sBfcywIDCcR4sMhQs8XPr5a7fURm8s+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l2CRK+as; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C563IF022068;
	Fri, 12 Apr 2024 00:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712898363;
	bh=Mg9xMhP3bnikgkGVUXDalcW4Jdwur4/SLsPYtHgg734=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=l2CRK+asRh4br2/v4yc6qtP5g1bisH7wdezvmXQ6x4+DmA5rGkVIs02wLh108oXsH
	 6Y1dZzXAKqNW/FkcIe0PoDEIJxL8gmKR0242eD8VDbX2IBXe7bPO5aezC9vYEzQTXH
	 tGX5wpC4vz+DaUoP2dsGHP1OWSaQVUAcjAYfVzYs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C5635j023718
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 00:06:03 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 00:06:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 00:06:02 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C55w2s028890;
	Fri, 12 Apr 2024 00:05:59 -0500
Message-ID: <cb3bb55c-b6ed-4e17-bafa-b83b19cdd5eb@ti.com>
Date: Fri, 12 Apr 2024 10:35:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: ti: k3-j7200-mcu: Add the MCU domain
 watchdog instances
To: "Kumar, Udit" <u-kumar1@ti.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>
References: <20240412042537.666137-1-n-francis@ti.com>
 <20240412042537.666137-6-n-francis@ti.com>
 <fd22f818-f123-482a-97ff-6f113bc08164@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <fd22f818-f123-482a-97ff-6f113bc08164@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit

On 12/04/24 10:33, Kumar, Udit wrote:
> Hi Neha
> 
> On 4/12/2024 9:55 AM, Neha Malcom Francis wrote:
>> There are 2 watchdog instances in the MCU domain. These instances are
>> coupled with the MCU domain R55 instances. Reserve them as they are not
>> used by A72.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Changes since v1:
>> - patch added
>>
>>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 26 +++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> index 7cf21c99956e..d1a42c3f30c0 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> @@ -686,4 +686,30 @@ mcu_mcan1: can@40568000 {
>>           bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>>           status = "disabled";
>>       };
>> +
>> +    /*
>> +     * The 2 RTI instances are couple with MCU R5Fs so keeping them
>> +     * reserved as these will be used by their respective firmware
>> +     */
>> +    mcu_watchdog0: watchdog@40600000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x40600000 0x00 0xbd>;
> 
> 
> please refer  Table 2-3. MCU Domain Memory Map of TRM.
> 
> Size of wdt is 0x100 , with this change in size from 0xbd to 0x100.
> 
> you can use
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>  for whole series

Thank you for catching that! Sending v3 soon!

> 
>> +        clocks = <&k3_clks 262 1>;
>> +        power-domains = <&k3_pds 262 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 262 1>;
>> +        assigned-clock-parents = <&k3_clks 262 5>;
>> +        /* reserved for MCU_R5F0_0 */
>> +        status = "reserved";
>> +    };
>> +
>> +    mcu_watchdog1: watchdog@40610000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x40610000 0x00 0xbd>;
>> +        clocks = <&k3_clks 263 1>;
>> +        power-domains = <&k3_pds 263 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 263 1>;
>> +        assigned-clock-parents = <&k3_clks 263 5>;
>> +        /* reserved for MCU_R5F0_1 */
>> +        status = "reserved";
>> +    };
>>   };

-- 
Thanking You
Neha Malcom Francis

