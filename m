Return-Path: <linux-kernel+bounces-107725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B3E8800CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CF01C220BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE7657D1;
	Tue, 19 Mar 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J4rmAa7A"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7808657B2;
	Tue, 19 Mar 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862548; cv=none; b=NvKmjJqvq/Q2KVG4BsKDKa+TUdC0hWnh+PuEo601D4yxc1g4Adf35i0nvCzihkS99shSf/VcbFaql5NhE42eXBXoVpfw9LOKbKT6izoF/nqxJ5h4UJrkQpXVYBqLw5g20fNc0IY8EgOQymzkNvuc3BYJEqw2NDLNjyxnEarOU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862548; c=relaxed/simple;
	bh=SFrg3KnosD/s710HAc8TZGNzFniC0MYmcCJHt/08xk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UJqS3DRnOOtMEzjswnxGPwcFhKhliqYMyTcGWG7xZHPdVPBGN7N8FNmfIXmWPIl7m0yxF0K0ncISh5co/kPZ9De+vzuCFmHoSDnWtp7FAvfjAMmId+vzYfmRtQOwBbgvbiVE1lbX1pUJxJneGxK82O2ir/j1TpLC5FTyDz1/WGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J4rmAa7A; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42JFZWQU065704;
	Tue, 19 Mar 2024 10:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710862532;
	bh=NBh+KBMmJomx56l27BvwXfnPT0Dnycn+6Y0IHyJ/T3w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=J4rmAa7AzDCllrxhw08+rGDAZblpacRmxPyyPjQlsJhw7ZT5eDkULcU9tS8ciB3lt
	 azRt/ny4lr70lnifn+9/HzKyzBjIpmyYeqOXQUqzVz8VeFxao6/hP6lQkakoOmO89h
	 bPBaThHFgp7zi4UtSbT7z1gBypwKRRLGZxMMF6zg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42JFZWQD128808
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 10:35:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 10:35:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 10:35:31 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42JFZVnG055645;
	Tue, 19 Mar 2024 10:35:31 -0500
Message-ID: <c4b91154-7a8b-4642-a642-6ae93b448115@ti.com>
Date: Tue, 19 Mar 2024 10:35:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] arm64: dts: ti: k3-j784s4: Add alias to MCU CPSW2G
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Peter Rosin <peda@axentia.se>,
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
From: Andrew Davis <afd@ti.com>
In-Reply-To: <0512d57f-af22-4bd8-8266-33d943d7eb4a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/11/24 5:44 AM, Chintan Vankar wrote:
> 
> 
> On 31/01/24 21:06, Andrew Davis wrote:
>> On 1/31/24 4:14 AM, Chintan Vankar wrote:
>>> Add alias for the MCU CPSW2G port to enable Linux to fetch MAC Address
>>> for the port directly from U-Boot.
>>
>> Could you explain *how* this alias allows Linux to fetch a MAC
>> address from U-Boot? Sounds like we are doing something hacky here..
>>
> Using "probe_daughtercards()" function U-Boot parses MAC addresses from
> EEPROM, then it internally calls "eth_env_set_enetaddr_by_index()"
> function which stores these MAC addresses into environment variables
> ethaddr, eth1addr, eth2addr and so on based on number of ports.
> 
> U-Boot loads DTB during boot process, and it calls
> "fdt_fixup_ethernet()" function, which uses environment variables to
> update MAC addresses of ethernet ports as specified in the aliases
> section.
> 

So maybe a better question would by why does it need to use aliases
for this?

>> Why can't Linux fetch the MAC from efuses the same way U-Boot does,
> 
> Linux can fetch the MAC address from efuses if "ti,syscon-efuse"
> property is enabled.
> 

Then let's do it this way always.

>> what happens if I don't use U-Boot to boot?
> 
> If you don't use U-Boot to boot then the equivalent of
> "probe_daughtercards()" has to be implemented which is currently
> missing.
> 

Or we just let Linux fetch it instead of implementing that function
in all the possible bootloaders. This would also remove a DTB fixup.
Those fixups should be avoided if at all possible.

Andrew

>>
>> Andrew
>>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> index f34b92acc56d..b74f7d3025de 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> @@ -27,6 +27,7 @@ aliases {
>>>           mmc1 = &main_sdhci1;
>>>           i2c0 = &wkup_i2c0;
>>>           i2c3 = &main_i2c0;
>>> +        ethernet0 = &mcu_cpsw_port1;
>>>       };
>>>       memory@80000000 {

