Return-Path: <linux-kernel+bounces-98713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69F877E53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55BF280E59
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261038FA5;
	Mon, 11 Mar 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hyt+S1xV"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF638DD2;
	Mon, 11 Mar 2024 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153910; cv=none; b=erS+JJsjgKvMV6IKBzwqFPLxF4WxIfDy67ft1cEJ14ugThNotzrEgmzv8H/ppoQkUKKwl6lLuTEziZVkF1yszsnEZwhEETEHO6Re0O4PSY6n82aw0Drio2zZjTsG6JAgAPCZhAwvvXulQcnb9cqCVpdTKsXb10L/JOL57ZUGWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153910; c=relaxed/simple;
	bh=+sxHONNnx1hFuxK0YIAbVsDwlEeH+igDtPPWM75FSv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BFPUNGZmw6t0ICYdgYH/9TqOjoDrZAmY4uqeNSA20oOfndeBzIMlHuK1Rg5KPZUN2590axFouflHR12AX5NS6+HnFOliCQPOJt2ZKuVMUtCVcxWP7rGmwSUDr6st/JEcxGVYJrN3IdXpzG1uSbsAM2Hd8TQDP2A84ulWYr6G2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hyt+S1xV; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42BAiruH107557;
	Mon, 11 Mar 2024 05:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710153893;
	bh=brk8hEUtZhRYQimGd+K1WoJ4/pWrBZiyIAP9nhQEREs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hyt+S1xVq5Aa03sAcOxLAYUTmzaRTG91NigalPACIk2CoYlzcA3vdQNQtQgbS9Jfx
	 73lEWYCDa/Y0xGf7by0MS0M2mW6ZkVY7rXCLUO5vT+68zy9X1lNpyIyGBBQWSLuchf
	 7K8GFf9kG6LK4f9D6TlDMN3rrOXURGXSNUAl5MAI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42BAirPa113120
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Mar 2024 05:44:53 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Mar 2024 05:44:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Mar 2024 05:44:52 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42BAikUT105135;
	Mon, 11 Mar 2024 05:44:47 -0500
Message-ID: <0512d57f-af22-4bd8-8266-33d943d7eb4a@ti.com>
Date: Mon, 11 Mar 2024 16:14:46 +0530
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
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <469a7f15-0539-48e9-993c-5b9c638917e0@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 31/01/24 21:06, Andrew Davis wrote:
> On 1/31/24 4:14 AM, Chintan Vankar wrote:
>> Add alias for the MCU CPSW2G port to enable Linux to fetch MAC Address
>> for the port directly from U-Boot.
> 
> Could you explain *how* this alias allows Linux to fetch a MAC
> address from U-Boot? Sounds like we are doing something hacky here..
> 
Using "probe_daughtercards()" function U-Boot parses MAC addresses from
EEPROM, then it internally calls "eth_env_set_enetaddr_by_index()"
function which stores these MAC addresses into environment variables
ethaddr, eth1addr, eth2addr and so on based on number of ports.

U-Boot loads DTB during boot process, and it calls
"fdt_fixup_ethernet()" function, which uses environment variables to
update MAC addresses of ethernet ports as specified in the aliases
section.

> Why can't Linux fetch the MAC from efuses the same way U-Boot does,

Linux can fetch the MAC address from efuses if "ti,syscon-efuse"
property is enabled.

> what happens if I don't use U-Boot to boot?

If you don't use U-Boot to boot then the equivalent of
"probe_daughtercards()" has to be implemented which is currently
missing.

> 
> Andrew
> 
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts 
>> b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> index f34b92acc56d..b74f7d3025de 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> @@ -27,6 +27,7 @@ aliases {
>>           mmc1 = &main_sdhci1;
>>           i2c0 = &wkup_i2c0;
>>           i2c3 = &main_i2c0;
>> +        ethernet0 = &mcu_cpsw_port1;
>>       };
>>       memory@80000000 {

