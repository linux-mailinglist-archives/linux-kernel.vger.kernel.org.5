Return-Path: <linux-kernel+bounces-90036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D066A86F92F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DE41F214E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0B4613A;
	Mon,  4 Mar 2024 04:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gd96gwWk"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D3539E;
	Mon,  4 Mar 2024 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526287; cv=none; b=mK1oNTsevRZfSSv3CkvAmh5L1AzFIutDL5cU1tVsDL3ZxhY2e6+KLH9gpweR62oBdlqQL7fs0FdnTTSLlSjLk1mWoO0Ub8BpYFWqP0ardzOHnmD6LhvSMvbmyHYUpLRY3DCNWtrrNgq6zsLi7GFfEb6UXg0zTeZ93407+peJQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526287; c=relaxed/simple;
	bh=/UO1JchsRlaHph8IMHDSkaKMTLSRO+gYXsqGVjDeD5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iMyC1lVYWvQ9Rc2W8WTOiQz4WXcvapT288unDj5HyLeKUwEyI7YeNOeD1V73teShCR9oD7LL2H2RPgbSYLrX2/aA//PltH7vdwt2u9sLh30zke1P3logr2pRoV5Ujit8BqYllPYkoIV4rAOdfei5++NjbplZdQmVTQYqSgHO4ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gd96gwWk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4244OOc7068967;
	Sun, 3 Mar 2024 22:24:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709526264;
	bh=6xyNnzj+dboJSEAS1HgU2JHeEMGGFllhk6cp37pKr7w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gd96gwWkdfPTta0rogXvDAX8ygh0VKreIvt+8CiUeY9v2Ac61Fii5K0ky+9Ru4MKS
	 dhSnpSDbJwHaf9CKqohRQ8sKc4nzpk3OuQWNjcdm9lUf+imcsq8iKstY59r8VF0LCN
	 U/+sedfjJDLDOMVk4o36lcMeQUU9fQJApLNfg5uw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4244OOJH055999
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 3 Mar 2024 22:24:24 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Mar 2024 22:24:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Mar 2024 22:24:24 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4244OKxK077275;
	Sun, 3 Mar 2024 22:24:20 -0600
Message-ID: <392def9d-5e02-4ca6-8838-c4252ccd4c54@ti.com>
Date: Mon, 4 Mar 2024 09:54:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <srk@ti.com>, <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-v1-1-b3e4b33378bd@kernel.org>
 <bfd9b146-061b-4f82-a703-3bd32ffc09b7@kernel.org>
 <c75d35c1-13f8-4f79-bf96-9a73e88d1b19@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <c75d35c1-13f8-4f79-bf96-9a73e88d1b19@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger,

On 02/03/24 02:59, Roger Quadros wrote:
> 
> 
> On 01/03/2024 22:58, Roger Quadros wrote:
>>
>>
>> On 29/02/2024 18:25, Roger Quadros wrote:
>>> The RESET GPIO pinmux should be part of MDIO bus node
>>> so that they can be in the right state before the PHY
>>> can be probed via MDIO bus scan.
>>>
>>> Add GPIO reset for the Gigabit Ethernet PHY. As per
>>> RTL8211F datasheet, reset assert width is 10ms and
>>> PHY registers can be access accessed after 50ms of
>>> reset deassert.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>> index a34e0df2ab86..77240cf3ae4d 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>> @@ -292,6 +292,8 @@ mdio0_pins_default: mdio0-default-pins {
>>>  		pinctrl-single,pins = <
>>>  			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
>>>  			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
>>> +			AM62X_IOPAD(0x003c, PIN_INPUT, 7) /* (M25) GPMC0_AD0.GPIO0_15 */
>>
>> This should be PIN_OUTPUT.
>> Will fix in next spin.
> 
> Actually PIN_INPUT is correct else we won't be able to read the correct GPIO pin status
> on gpio read.
> I observe this issue on u-boot at least.
> 
>>
>>> +			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
> 
> This one needs to be fixed to PIN_INPUT.

While at it, please fix the $subject prefix:

arm64: dts: ti: beagleplay: ...

Do we need a Fixes: Tag too?

> 
>>>  		>;
>>>  	};
>>>  
>>> @@ -383,7 +385,6 @@ AM62X_IOPAD(0x017c, PIN_INPUT, 1) /* (AD22) RGMII2_RX_CTL.RMII2_RX_ER */
>>>  			AM62X_IOPAD(0x016c, PIN_INPUT, 1) /* (Y18) RGMII2_TD0.RMII2_TXD0 */
>>>  			AM62X_IOPAD(0x0170, PIN_INPUT, 1) /* (AA18) RGMII2_TD1.RMII2_TXD1 */
>>>  			AM62X_IOPAD(0x0164, PIN_INPUT, 1) /* (AA19) RGMII2_TX_CTL.RMII2_TX_EN */
>>> -			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
>>>  			AM62X_IOPAD(0x0190, PIN_INPUT, 7) /* (AE22) RGMII2_RD3.GPIO1_6 */
>>>  			AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
>>>  		>;
>>> @@ -597,6 +598,9 @@ &cpsw3g_mdio {
>>>  
>>>  	cpsw3g_phy0: ethernet-phy@0 {
>>>  		reg = <0>;
>>> +		reset-gpios = <&main_gpio0 15 GPIO_ACTIVE_LOW>;
>>> +		reset-assert-us = <10000>;
>>> +		reset-deassert-us = <50000>;
>>>  	};
>>>  
>>>  	cpsw3g_phy1: ethernet-phy@1 {
>>> @@ -615,7 +619,7 @@ &main_gpio0 {
>>>  		"USR0", "USR1", "USR2", "USR3", "", "", "USR4",	/* 3-9 */
>>>  		"EEPROM_WP",					/* 10 */
>>>  		"CSI2_CAMERA_GPIO1", "CSI2_CAMERA_GPIO2",	/* 11-12 */
>>> -		"CC1352P7_BOOT", "CC1352P7_RSTN", "", "", "",	/* 13-17 */
>>> +		"CC1352P7_BOOT", "CC1352P7_RSTN", "GBE_RSTN", "", "",	/* 13-17 */
>>>  		"USR_BUTTON", "", "", "", "", "", "", "", "",	/* 18-26 */
>>>  		"", "", "", "", "", "", "", "", "", "HDMI_INT",	/* 27-36 */
>>>  		"", "VDD_WLAN_EN", "", "", "WL_IRQ", "GBE_INTN",/* 37-42 */
>>>
>>> ---
>>> base-commit: bbef42084cc170cbfc035bf784f2ff055c939d7e
>>> change-id: 20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-098f274fbf15
>>>
>>> Best regards,
>>
> 

-- 
Regards
Vignesh

