Return-Path: <linux-kernel+bounces-141919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E27F8A251C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D591F24711
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0C18B09;
	Fri, 12 Apr 2024 04:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J0/ShJo8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B918633;
	Fri, 12 Apr 2024 04:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895820; cv=none; b=T32kGkfkAUicaLacqsS3uqH1rFB6WRjvNwRqTJHYG8znQLzCLKWStSInLFzEMvbT4qGMQi1m8kP/5FV79op+DVsTmkAU/meHjEe/iUnV226KXEhXuuZcR6XJwuPJDMvEcids+h6GVmILB5+sGFpdk0C2sQji9gUKh7Jbnndbggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895820; c=relaxed/simple;
	bh=bJVzT5ULI2bDBG42gCgO20HDCUC7DDGEixtHO+5vKLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fJnuUd4I2NQ/vrNT8CK25TV0jaRY42Sgc9TVMKSfTEb1AHrVAT6w1rYJyYlOrbCeztJ/gw+pFl1QgAH0lmtd1p9U/G7CqxPFoGuHBC+xi8oaIwOVxW6/D5QPWxmEjDSzvF25gvmfpESdsbH9pNrbT+bm/+2znGq/ykTMZfWEtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J0/ShJo8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C4NVwG066663;
	Thu, 11 Apr 2024 23:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712895811;
	bh=DSqJzUAiVcFR8d5YWxtuzmqMNSMiQ3isYTqV2zQMXOU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=J0/ShJo8bOdD++3F6ak01h7eGus1Ge7iB+qrDzUSNTPrSxPIW2L+9E0phUBbpv+AT
	 ffYbRUAtoerlNDdTvQ6UbHGDzsj8JNXMrF1LuHD9AiAKXjpoyv0p3IaNQthxVsgMaA
	 j4Ujni5j1raxDvA+f23+zZNdOxcukdKxA/fBfIag=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C4NVE3120980
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:23:31 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 23:23:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 23:23:31 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C4NRAB073737;
	Thu, 11 Apr 2024 23:23:28 -0500
Message-ID: <400cc67d-1d86-4fd5-ba1a-ef6bb166d0a0@ti.com>
Date: Fri, 12 Apr 2024 09:53:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: ti: k3-j721e-mcu: Add the MCU domain
 watchdog instances
To: "Kumar, Udit" <u-kumar1@ti.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>
References: <20240326122723.2329402-1-n-francis@ti.com>
 <20240326122723.2329402-3-n-francis@ti.com>
 <2455386b-cf9c-4060-ba86-34ea80a5af6a@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <2455386b-cf9c-4060-ba86-34ea80a5af6a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit,

On 10/04/24 11:15, Kumar, Udit wrote:
> Hi Neha
> 
> On 3/26/2024 5:57 PM, Neha Malcom Francis wrote:
>> There are 2 watchdog instances in the MCU domain. These instances are
>> coupled with the MCU domain R55 instances. Reserve them as they are not
>> used by A72.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 26 +++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> index b0f41e9829cc..867f307909be 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> @@ -694,4 +694,30 @@ wkup_esm: esm@42080000 {
>>           compatible = "ti,j721e-esm";
>>           reg = <0x00 0x42080000 0x00 0x1000>;
>>       };
>> +
>> +    /*
>> +     * The 2 RTI instances are couple with MCU R5Fs so keeping them
>> +     * reserved as these will be used by their respective firmware
>> +     */
>> +    mcu_watchdog0: watchdog@40600000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x40600000 0x00 0x100>;
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
>> +        reg = <0x00 0x40610000 0x00 0x100>;
>> +        clocks = <&k3_clks 263 1>;
>> +        power-domains = <&k3_pds 263 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 263 1>;
>> +        assigned-clock-parents = <&k3_clks 263 5>;
>> +        /* reserved for MCU_R5F0_1 */
> 
> Table 12-22642. MCU_RTI Hardware Requests (In same TRM referred in 3/4 patch 
> review ),
> 
> says each WDT has destination of MCU0_R5_CORE0 and MCU0_R5_CORE1
> 
> Please suggest, if fw level this is decided to reserved like above ?
> 
> With that clarification, Please use
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> 
> 

At firmware level, the MCU R5 is in lockstep mode. The dual destination of the 
WDT interrupt makes sense then.

>> +        status = "reserved";
>> +    };
>>   };

-- 
Thanking You
Neha Malcom Francis

