Return-Path: <linux-kernel+bounces-109713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7872881CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A21C20BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A24D9F4;
	Thu, 21 Mar 2024 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ynCQXy92"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5556450;
	Thu, 21 Mar 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711004526; cv=none; b=BiEVJVxNjcGtm7WdJT+HKzl2h3whZpz2zo64wdzepjqmzcKh88MamEoi2W+Q14X4QQ1w4ZRIaX2CuxNUJA9W2+/lg6i99u5p7LnyMOUHL8wx2YgNdNX3BpohBpDdGz7qRiAw2oYfrKJ2XQIT6hX1KwJDJ7UcR8TWo4dQIBf7TGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711004526; c=relaxed/simple;
	bh=SwY21QFiwGpD1kcAiZUZyOjCoiCibVmG8EdjAluDzsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MRhbdMEIrp7vYCZXFSJtY2rQqv1v0Jwwpcw81v0dfei5czuG0N4TqYQOs2SFyb7X2ws5mCg7ptS1t7GHJNEJ4NXs5Bci81IAxc/UH0XGkajWT8H2KOQfXCS9gY/MxVDv5PKy9QoEGVtTLQw8Ts/8vOl7BIYt4DD6qT2RtIlJQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ynCQXy92; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42L71i5j014711;
	Thu, 21 Mar 2024 02:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711004504;
	bh=DJP47pseD2ZY7NaP7759rSonBuFE54K/AWpHpbwV2W8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ynCQXy92jpkozeHVfpylGUaOryqC5wpun1PGjj78Nwq45Xs+k+6557eX5mXIk2v2Y
	 FE4kkQCieLeMddWZM903qMSfVP3AXoM2q24eWz8CAgq34XBjHJvZn9cuNSjI3CZS5D
	 8Vt3q84dN6xT5sAi0Crz1+RR3zZumL/qOhDOL4w0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42L71ik3011527
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Mar 2024 02:01:44 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Mar 2024 02:01:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Mar 2024 02:01:44 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42L71dYr072133;
	Thu, 21 Mar 2024 02:01:40 -0500
Message-ID: <b2cc9610-1bc8-4ad8-bf0c-f7343ae0de75@ti.com>
Date: Thu, 21 Mar 2024 12:31:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] arm64: dts: ti: k3-j784s4: Add alias to MCU CPSW2G
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>
References: <20240131101441.1362409-1-c-vankar@ti.com>
 <20240131101441.1362409-3-c-vankar@ti.com>
 <469a7f15-0539-48e9-993c-5b9c638917e0@ti.com>
 <0512d57f-af22-4bd8-8266-33d943d7eb4a@ti.com>
 <c4b91154-7a8b-4642-a642-6ae93b448115@ti.com>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <c4b91154-7a8b-4642-a642-6ae93b448115@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 19/03/24 21:05, Andrew Davis wrote:
> On 3/11/24 5:44 AM, Chintan Vankar wrote:
>>
>>
>> On 31/01/24 21:06, Andrew Davis wrote:
>>> On 1/31/24 4:14 AM, Chintan Vankar wrote:
>>>> Add alias for the MCU CPSW2G port to enable Linux to fetch MAC Address
>>>> for the port directly from U-Boot.
>>>
>>> Could you explain *how* this alias allows Linux to fetch a MAC
>>> address from U-Boot? Sounds like we are doing something hacky here..
>>>
>> Using "probe_daughtercards()" function U-Boot parses MAC addresses from
>> EEPROM, then it internally calls "eth_env_set_enetaddr_by_index()"
>> function which stores these MAC addresses into environment variables
>> ethaddr, eth1addr, eth2addr and so on based on number of ports.
>>
>> U-Boot loads DTB during boot process, and it calls
>> "fdt_fixup_ethernet()" function, which uses environment variables to
>> update MAC addresses of ethernet ports as specified in the aliases
>> section.
>>
> 
> So maybe a better question would by why does it need to use aliases
> for this?
> 

Since "probe_daughtercards()" in U-Boot is implemented in a way that
it gets the MAC addresses fromm EEPROM and "fdt_fixup_ethernet()"
function configures MAC addresses for the ethernet ports as specified
in aliases section.

>>> Why can't Linux fetch the MAC from efuses the same way U-Boot does,
>>
>> Linux can fetch the MAC address from efuses if "ti,syscon-efuse"
>> property is enabled.
>>
> 
> Then let's do it this way always.
> 
Yes, Linux reads MAC addresses from efuse this way only, but the
functionality of Linux getting the MAC addresses from EEPROM is
not implemented.

>>> what happens if I don't use U-Boot to boot?
>>
>> If you don't use U-Boot to boot then the equivalent of
>> "probe_daughtercards()" has to be implemented which is currently
>> missing.
>>
> 
> Or we just let Linux fetch it instead of implementing that function
> in all the possible bootloaders. This would also remove a DTB fixup.
> Those fixups should be avoided if at all possible.
> 

Yes, we can let Linux fetch MAC addresses, but right now the Ethernet
driver in Linux can only fetch MAC addresses from "EFUSE" and not from
"EEPROM", and since the functionality to fetch MAC addresses from
"EEPROM" is implemented in U-Boot we are utilizing it.

> Andrew
> 
>>>
>>> Andrew
>>>
>>>> ---
>>>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts 
>>>> b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>>> index f34b92acc56d..b74f7d3025de 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>>> @@ -27,6 +27,7 @@ aliases {
>>>>           mmc1 = &main_sdhci1;
>>>>           i2c0 = &wkup_i2c0;
>>>>           i2c3 = &main_i2c0;
>>>> +        ethernet0 = &mcu_cpsw_port1;
>>>>       };
>>>>       memory@80000000 {

