Return-Path: <linux-kernel+bounces-161811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5778B5187
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB681F212CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9333015E8C;
	Mon, 29 Apr 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kN39CYSd"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225F10A09;
	Mon, 29 Apr 2024 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372347; cv=none; b=jXVOqVDv4y3GV7jLWBsUanv9WjVt26WKZSIEBl6H87sjXnEhEtuq7+PBGRN/td+Mcn8vO01V/kJUXdyXIwT4t7yw4cj59vELtSpr8UJRzTWaWR54XY9dH9IDRRDwnNOO5QUMEIQk6O93OBkmD2RbIxysCC/jVU46+EhYYuyR3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372347; c=relaxed/simple;
	bh=rsdP7+GnFp608SE+MUS0izg/bsNJYO6P3t8sjUtAcGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j3wTMTKEudjEcF+4UTjuFbRbjG5+oh9TEI9dP6RO+eQwO/6OYSVk3atkObaH7ShtFopp08m7Fr6aNZZjDNwNjlJkjTmgXoDEsnwFrud+ZtwEl9V8SmcUZSnVhDa1NsOT/KoSlQqMoIM4SLA1c6hNu9KQHyCdVw4je7ZnA9Rcqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kN39CYSd; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T6WA7j122646;
	Mon, 29 Apr 2024 01:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714372330;
	bh=/K+/pvtse4reS5XZh9Kumi6ENBvKQAHTIa0kZu2ukqo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kN39CYSdKpPa9Z+mpYUy8nW0LVMKBaLe3yvIhP/M/M9He9slxoi9ynNidZQKKdo+s
	 E1iRmjopVuzuGdahQ4lzVEO0Yy8aEeUO+Ubh/1Fmu4Y1ALDuIk63nYt3pQO0NDLZi4
	 vViARi58UatCA1Pg3gNo4mWsAlIUz23J2WJNaTmA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T6WAN1017086
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 01:32:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 01:32:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 01:32:10 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T6W5BP097297;
	Mon, 29 Apr 2024 01:32:06 -0500
Message-ID: <468e0886-9b8f-40a7-a643-f20ca6e9b993@ti.com>
Date: Mon, 29 Apr 2024 12:02:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am62a7: Add overlay for second
 CPSW3G Port
Content-Language: en-US
To: Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240425102038.1995252-1-c-vankar@ti.com>
 <20240425102038.1995252-3-c-vankar@ti.com>
 <6a3ef0c1-d6b3-7161-1338-c7c0a9c41d18@ti.com>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <6a3ef0c1-d6b3-7161-1338-c7c0a9c41d18@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 29/04/24 10:54, Ravi Gunasekaran wrote:
> 
> 
> On 4/25/24 3:50 PM, Chintan Vankar wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> The SK-Ethernet-DC01 Add-On Ethernet Card for AM62A7-SK board supports
>> RGMII mode.
>>
>> Add overlay to enable the second CPSW3G port in RGMII-RXID mode with the
>> Add-On Ethernet Card.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v1:
>> https://lore.kernel.org/r/20230424111945.3865240-3-s-vadapalli@ti.com/
>>
>> Changes from v1 to v2:
>> - Since support for device tree overlays for am62a7-sk is already enabled
>>    by commit "635ed9715194", it is removed from this series.
>>
>>   arch/arm64/boot/dts/ti/Makefile               |  3 +
>>   .../dts/ti/k3-am62a7-sk-ethernet-dc01.dtso    | 61 +++++++++++++++++++
>>   2 files changed, 64 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index c76b41f86527..8c55e46d9f98 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>>   
>>   # Boards with AM62Ax SoC
>>   dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk-ethernet-dc01.dtbo
>>   
>>   # Boards with AM62Px SoC
>>   dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
>> @@ -123,6 +124,8 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
>>   	k3-am62x-sk-csi2-ov5640.dtbo
>>   k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
>>   	k3-am62x-sk-csi2-tevi-ov5640.dtbo
>> +k3-am62a7-sk-ethernet-dc01-dtbs := k3-am62a7-sk.dtb \
>> +	k3-am62a7-sk-ethernet-dc01.dtbo
>>   k3-am62a7-sk-hdmi-audio-dtbs := k3-am62a7-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
>>   k3-am62p5-sk-csi2-imx219-dtbs := k3-am62p5-sk.dtb \
>>   	k3-am62x-sk-csi2-imx219.dtbo
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso b/arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso
>> new file mode 100644
>> index 000000000000..f6d5a089a717
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Please update the license to "GPL-2.0-only OR MIT"
> 

I will update it in next version.

>> +/**
>> + * DT Overlay for second CPSW3G port in RGMII mode using SK-ETHERNET-DC01
>> + * Add-On Daughtercard with AM62A7-SK.
>> + *
>> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/net/ti-dp83867.h>
>> +#include "k3-pinctrl.h"
>> +
>> +&{/} {
>> +	aliases {
>> +		ethernet1 = "/bus@f0000/ethernet@8000000/ethernet-ports/port@2";
>> +	};
>> +};
>> +
>> +&cpsw3g {
>> +	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
> 
> 
> One entry per line like below
> 
> pinctrl-0 = <&main_rgmii1_pins_default>,
> 	    <&main_rgmii2_pins_default>;
> 

Thanks Ravi for pointing out this, I will update this in next
version.

>> +};
>> +
>> +&cpsw_port2 {
>> +	status = "okay";
>> +	phy-mode = "rgmii-rxid";
>> +	phy-handle = <&cpsw3g_phy1>;
>> +};
>> +
>> +&cpsw3g_mdio {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	cpsw3g_phy1: ethernet-phy@1 {
>> +		reg = <1>;
>> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>> +		ti,min-output-impedance;
>> +	};
>> +};
>> +
>> +&main_pmx0 {
>> +	main_rgmii2_pins_default: main-rgmii2-default-pins {
>> +		pinctrl-single,pins = <
>> +			AM62AX_IOPAD(0x0184, PIN_INPUT, 0) /* (AA21) RGMII2_RD0 */
>> +			AM62AX_IOPAD(0x0188, PIN_INPUT, 0) /* (Y20) RGMII2_RD1 */
>> +			AM62AX_IOPAD(0x018c, PIN_INPUT, 0) /* (AB21) RGMII2_RD2 */
>> +			AM62AX_IOPAD(0x0190, PIN_INPUT, 0) /* (AB20) RGMII2_RD3 */
>> +			AM62AX_IOPAD(0x0180, PIN_INPUT, 0) /* (AA20) RGMII2_RXC */
>> +			AM62AX_IOPAD(0x017c, PIN_INPUT, 0) /* (W18) RGMII2_RX_CTL */
>> +			AM62AX_IOPAD(0x016c, PIN_INPUT, 0) /* (AA19) RGMII2_TD0 */
>> +			AM62AX_IOPAD(0x0170, PIN_INPUT, 0) /* (Y18) RGMII2_TD1 */
>> +			AM62AX_IOPAD(0x0174, PIN_INPUT, 0) /* (AA18) RGMII2_TD2 */
>> +			AM62AX_IOPAD(0x0178, PIN_INPUT, 0) /* (W17) RGMII2_TD3 */
>> +			AM62AX_IOPAD(0x0168, PIN_INPUT, 0) /* (AB19) RGMII2_TXC */
>> +			AM62AX_IOPAD(0x0164, PIN_INPUT, 0) /* (Y19) RGMII2_TX_CTL */
>> +		>;
>> +	};
>> +};
> 

