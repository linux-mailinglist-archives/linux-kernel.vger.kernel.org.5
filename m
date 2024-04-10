Return-Path: <linux-kernel+bounces-137961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C7089EA6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4222877BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663EF28399;
	Wed, 10 Apr 2024 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BazAjjRX"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B4200D9;
	Wed, 10 Apr 2024 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729396; cv=none; b=M45M5yh2oX1UwvBHGltJaH7a9PJRiEaplODNSkk6EXVmuHxIa34ZckBEwZn0S0GjbJRi05ut70G6E/oBpm2XAwPkIOZiWPaMyjc+NEebBbOlUO0HJCt0YeeY3N+m7VTI7VcnN+K2fqeF+IzmfMq9bOKfKdYRmF5ZtieWqpCS8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729396; c=relaxed/simple;
	bh=ZCJ50r0OiBeyLIMEGOMGcjQ5TDkinOK54KbSrDpBKsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cNIMEBGv5e2oMpcKuGW25Fz+DtZiGflx4W6Mb5TlnOHdCYpuhF9+ByBGy2puQKkTNbUoA6sXaWillTtJzDyVCvhrFUeNsSus6ZHDAMPeZn4EcQRXk44k/2pChoKgpHyM9tQ5qvjKJ0W4OU6XD3XEHSol0X9lLf70LgMKe3krdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BazAjjRX; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43A69lUs124928;
	Wed, 10 Apr 2024 01:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712729387;
	bh=zhhvFSFGE9yQ2nG9GWtGX3JJHeyVgAouwLT1MfGZelc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BazAjjRXKrkiuNknbNuWYK2wq4BgzwgByEUzEPSElT4Zw2T2TVwkMXnyjxaOwSUGx
	 7Tbai6jkzk+Q/+W0SFFE6ZnTD9OsrlW6YT0Kkl0/v0e84QepuL2iKcnfryfeBlGnO5
	 UjNcUv4AeZRUJ4bxGQL+EozhlmSF5pnKuvG+38LU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43A69lok009976
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 01:09:47 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 01:09:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 01:09:47 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43A69hqm069319;
	Wed, 10 Apr 2024 01:09:44 -0500
Message-ID: <bb464315-26ea-48d7-8407-df4b132fbcfa@ti.com>
Date: Wed, 10 Apr 2024 11:39:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: ti: k3-j7200-main: Add the MAIN domain
 watchdog instances
To: "Kumar, Udit" <u-kumar1@ti.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>
References: <20240326122723.2329402-1-n-francis@ti.com>
 <20240326122723.2329402-5-n-francis@ti.com>
 <f999020f-0f07-4eb3-bc59-f1a0f7237af7@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <f999020f-0f07-4eb3-bc59-f1a0f7237af7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit

On 10/04/24 11:35, Kumar, Udit wrote:
> Hi Neha
> 
> On 3/26/2024 5:57 PM, Neha Malcom Francis wrote:
>> There are 4 watchdog instances in the MAIN domain:
>>     * one each for the 2 A72 cores
>>     * one each for the 2 R5F cores
>>
>> Currently, the devicetree only describes watchdog instances for the A72
>> cores and enables them. Describe the remaining but reserve them as they
>> will be used by their respective firmware.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 27 +++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> index 657f9cc9f4ea..c448c2218e23 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> @@ -1254,6 +1254,33 @@ watchdog1: watchdog@2210000 {
>>           assigned-clock-parents = <&k3_clks 253 5>;
>>       };
>> +    /*
>> +     * The following RTI instances are coupled with MCU R5Fs so
>> +     * keeping them reserved as these will be used by their respective
>> +     * firmware
>> +     */
>> +    watchdog2: watchdog@23c0000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x23c0000 0x00 0x100>;
>> +        clocks = <&k3_clks 258 1>;
>> +        power-domains = <&k3_pds 258 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 258 1>;
>> +        assigned-clock-parents = <&k3_clks 258 5>;
>> +        /* reserved for MAIN_R5F0_0 */
>> +        status = "reserved";
>> +    };
>> +
>> +    watchdog3: watchdog@23d0000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x23d0000 0x00 0x100>;
>> +        clocks = <&k3_clks 259 1>;
>> +        power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 259 1>;
>> +        assigned-clock-parents = <&k3_clks 259 5>;
>> +        /* reserved for MAIN_R5F0_1 */
>> +        status = "reserved";
>> +    };
>> +
> 
> Please see, if this make more sense to have label as watchdog28 and watchdog29, 
> to align with TRM.

Yes I will change all the patches in the series to align with TRM numbering.

> 
> Also request to add mcu domain 2 watchdog as well.

Oh I had missed that out, will add it in v2.

> 
> 
>>       main_timer0: timer@2400000 {
>>           compatible = "ti,am654-timer";
>>           reg = <0x00 0x2400000 0x00 0x400>;

-- 
Thanking You
Neha Malcom Francis

