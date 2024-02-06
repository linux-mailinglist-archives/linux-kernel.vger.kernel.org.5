Return-Path: <linux-kernel+bounces-54339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFDF84ADDE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A547D2872B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF277A736;
	Tue,  6 Feb 2024 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sNTLGiwf"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945378B6B;
	Tue,  6 Feb 2024 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196579; cv=none; b=lQE1Tl1kvXdWK9Y+7fZAlY/5Vlbv52Mp1Z/oYpkRYZ93Yn+EH5s0+2VOPam7e8MnGymO2GkknzqfNxUZrr6oqoZ7n1tBc+eJkDlZFsm9byhzGFuLMDMMAXpv5vKkqiq2dUyhvq7EiHdzLafB+a2M+L0MsqkcRrKY9uUouVNFyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196579; c=relaxed/simple;
	bh=MR41QP/4EPa/N0JJYid3YbXrUwHg4lad8H730sDJQ7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ooQ19XhfGtqEuBKE7fsdFce50ZPqTlSk2CMz0u4v+vfnFzCIZWsqxbkoaoNfIxo7qhuKEH6XyqpmSQsRLphHueXt+WiOsXI2veKZj3Lr1M22qzexXkLRn5HMmuc8a8AnHBQ6sQhnhShVQ0XhiH9DK2O0OS1trQHUUchd7w9XYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sNTLGiwf; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4165G5OA012061;
	Mon, 5 Feb 2024 23:16:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707196565;
	bh=aLGkzC9wjwC+NnwhamYtqaOYE8QgwAi84hsw5Xy5m6w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sNTLGiwfmcg/eOnq9s46lAJPXo3PRjFbD8n5mn0KfnbV2X4++UruviC4ZCT4NTh9i
	 hXhkfgBwI6PqMX0s+B5MyAPg3cwF4DmBWrNMNgzk+6s+7GkTvL0hx1UDFEmlZN3bB5
	 mAmvWGR+4qeb9fjyUw+WZ5HlU+fI8k1fgNnY8mp8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4165G5hd016512
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 23:16:05 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 23:16:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 23:16:05 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4165G0mU029523;
	Mon, 5 Feb 2024 23:16:00 -0600
Message-ID: <704316db-cb3f-4069-bf34-8d470b0ab444@ti.com>
Date: Tue, 6 Feb 2024 10:45:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: ti: k3-am642-evm: add overlay for
 icssg1 2nd port
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, "Anwar, Md Danish" <a0501179@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240122113045.1711818-1-danishanwar@ti.com>
 <20240122113045.1711818-4-danishanwar@ti.com>
 <33e62844-a148-4374-aba8-481dc7799e15@kernel.org>
 <17d1cfd0-2962-4857-af1d-7f2126b37abf@ti.com>
 <6c5e2ca5-9b47-4a08-817c-e4bb1d10032f@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <6c5e2ca5-9b47-4a08-817c-e4bb1d10032f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 05/02/24 6:27 pm, Roger Quadros wrote:
> 
> 
> On 02/02/2024 18:50, Anwar, Md Danish wrote:
>> On 2/2/2024 5:56 PM, Roger Quadros wrote:
>>>
>>>
>>> On 22/01/2024 13:30, MD Danish Anwar wrote:
>>>> The am642-evm doesn't allow to enable 2 x CPSW3g ports and 2 x ICSSG1 ports
>>>> all together, so base k3-am642-evm.dts enables by default 2 x CPSW3g ports
>>>> and 1 x ICSSG1 ports, but it also possible to support 1 x CPSW3g ports and
>>>> 2 x ICSSG1 ports configuration.
>>>
>>> "it is also possible"
>>>
>>> OK so there can only be 3 ethernet ports on this board. There is no "ethernet3" alias.
>>>
>>
>> Yes maximum there can be 3 ports only. By default 2 are cpsw and 1 icssg
>> but this parch introduces overlay to change the muxed port into icssg.
>>
>> By default,
>> 	ethernet0 = &cpsw_port1;
>> 	ethernet1 = &cpsw_port2;
>> 	ethernet2 = &icssg1_emac0;
>>
>> When this overlay is applied, it should be something like this,
>> 	ethernet0 = &cpsw_port1;
>> 	ethernet1 = &icssg1_emac0;
>> 	ethernet2 = &icssg1_emac1;
>>
>> Let me know if this looks ok to you. I will modify the alias accordingly.
> 
> ethernet0 is ok
> 
> As per schematics: icssg1_emac0 is fixed to J21A port. so I'd call this ethernet1
> 
> J21B port can be switched between cpsw_port2 and icssg1_emac1. so I'd call this ethernet2
> 
> This way ethernet1 definition is fixed regardless and you are only switching ethernet2
> definition.
> 

So ethernet0 and ethernet1 will be fixed and only ethernet2 will change
from cpsw_port2 to icssg1_emac1 when this overlay is applied.

I have posted v4 [1] before your this reply. In v4 I have kept ethernet0
and ethernet2 fixed to cpsw_port1 and icssg1_emac0 respectively and only
ethernet1 changes from cpsw_port2 to icssg1_emac1 when this overlay is
applied. Overlay only changes ethernet1. I think this is also a valid
approach. eth0 will be fixed to cpsw and eth2 will be fixed to icssg.
eth1 will toggle between cpsw and icssg. You can have a look at v4.

Pls let me know if you are okay with this.

[1] https://lore.kernel.org/all/20240205090546.4000446-1-danishanwar@ti.com/

>>
>>>>
>>>> This patch adds overlay to support 1 x CPSW3g ports and 2 x ICSSG1 ports
>>>> configuration:
>>>> - Add label name 'mdio_mux_1' for 'mdio-mux-1' node so that the node
>>>>   'mdio-mux-1' can be disabled in the overlay using the label name.
>>>> - disable 2nd CPSW3g port
>>>> - update CPSW3g pinmuxes to not use RGMII2
>>>> - disable mdio-mux-1 and define mdio-mux-2 to route ICSSG1 MDIO to the
>>>>   shared DP83869 PHY
>>>> - add and enable ICSSG1 RGMII2 pinmuxes
>>>> - enable ICSSG1 MII1 port
>>>>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/Makefile               |  5 ++
>>>>  .../dts/ti/k3-am642-evm-icssg1-dualemac.dtso  | 75 +++++++++++++++++++
>>>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  2 +-
>>>>  3 files changed, 81 insertions(+), 1 deletion(-)
>>>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>>>> index 52c1dc910308..320b2fae5730 100644
>>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>>> @@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>>>>  dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
>>>>  dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>>>>  dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
>>>> +dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
>>>>  
>>>>  # Boards with AM65x SoC
>>>>  k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
>>>> @@ -105,6 +106,8 @@ k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
>>>>  	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>>>>  k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
>>>>  	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
>>>> +k3-am642-evm-icssg1-dualemac-dtbs := \
>>>> +	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
>>>>  k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
>>>>  	k3-j721e-evm-pcie0-ep.dtbo
>>>>  k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
>>>> @@ -120,6 +123,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>>>>  	k3-am62a7-sk-csi2-ov5640.dtb \
>>>>  	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
>>>>  	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
>>>> +	k3-am642-evm-icssg1-dualemac.dtb \
>>>>  	k3-j721e-evm-pcie0-ep.dtb \
>>>>  	k3-j721s2-evm-pcie1-ep.dtb
>>>>  
>>>> @@ -129,6 +133,7 @@ DTC_FLAGS_k3-am625-sk += -@
>>>>  DTC_FLAGS_k3-am62-lp-sk += -@
>>>>  DTC_FLAGS_k3-am62a7-sk += -@
>>>>  DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
>>>> +DTC_FLAGS_k3-am642-evm += -@
>>>>  DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>>>>  DTC_FLAGS_k3-j721e-common-proc-board += -@
>>>>  DTC_FLAGS_k3-j721s2-common-proc-board += -@
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso
>>>> new file mode 100644
>>>> index 000000000000..b2b1a6252e73
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso
>>>> @@ -0,0 +1,75 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>
>>> Don't you need to use updated licensing header like in the series [1]
>>>
>>> [1] https://lore.kernel.org/all/20240110140903.4090946-1-nm@ti.com/
>>>
>>
>> Sure. I will update the header.
>>
>>>> +/**
>>>> + * DT overlay for enabling 2nd ICSSG1 port on AM642 EVM
>>>> + *
>>>> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +/plugin/;
>>>> +
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include "k3-pinctrl.h"
>>>> +
>>>> +&{/} {
>>>
>>> You need to fixup alias for ethernet1 to icssg1_emac1?
>>>
>>
>> Yes I will update the aliases accordingly.
>>
>>>> +	mdio-mux-2 {
>>>
>>> this should be mdio-mux@0 ?
>>>
>>
>> The main mux in evm dts is defined as mdio-mux-1 so I was following the
>> same. I will change this to mdio-mux@0
>>
>>>> +		compatible = "mdio-mux-multiplexer";
>>>> +		mux-controls = <&mdio_mux>;
>>>> +		mdio-parent-bus = <&icssg1_mdio>;
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +
>>>> +		mdio@0 {
>>>> +			reg = <0x0>;
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <0>;
>>>> +
>>>> +			icssg1_phy2: ethernet-phy@3 {
>>>> +				reg = <3>;
>>>> +				tx-internal-delay-ps = <250>;
>>>> +				rx-internal-delay-ps = <2000>;
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +};
>>>> +
>>>> +&main_pmx0 {
>>>> +	icssg1_rgmii2_pins_default: icssg1-rgmii2-default-pins {
>>>> +		pinctrl-single,pins = <
>>>> +			AM64X_IOPAD(0x0108, PIN_INPUT, 2) /* (W11) PRG1_PRU1_GPO0.RGMII2_RD0 */
>>>> +			AM64X_IOPAD(0x010c, PIN_INPUT, 2) /* (V11) PRG1_PRU1_GPO1.RGMII2_RD1 */
>>>> +			AM64X_IOPAD(0x0110, PIN_INPUT, 2) /* (AA12) PRG1_PRU1_GPO2.RGMII2_RD2 */
>>>> +			AM64X_IOPAD(0x0114, PIN_INPUT, 2) /* (Y12) PRG1_PRU1_GPO3.RGMII2_RD3 */
>>>> +			AM64X_IOPAD(0x0120, PIN_INPUT, 2) /* (U11) PRG1_PRU1_GPO6.RGMII2_RXC */
>>>> +			AM64X_IOPAD(0x0118, PIN_INPUT, 2) /* (W12) PRG1_PRU1_GPO4.RGMII2_RX_CTL */
>>>> +			AM64X_IOPAD(0x0134, PIN_OUTPUT, 2) /* (AA10) PRG1_PRU1_GPO11.RGMII2_TD0 */
>>>> +			AM64X_IOPAD(0x0138, PIN_OUTPUT, 2) /* (V10) PRG1_PRU1_GPO12.RGMII2_TD1 */
>>>> +			AM64X_IOPAD(0x013c, PIN_OUTPUT, 2) /* (U10) PRG1_PRU1_GPO13.RGMII2_TD2 */
>>>> +			AM64X_IOPAD(0x0140, PIN_OUTPUT, 2) /* (AA11) PRG1_PRU1_GPO14.RGMII2_TD3 */
>>>> +			AM64X_IOPAD(0x0148, PIN_OUTPUT, 2) /* (Y10) PRG1_PRU1_GPO16.RGMII2_TXC */
>>>> +			AM64X_IOPAD(0x0144, PIN_OUTPUT, 2) /* (Y11) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
>>>> +		>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&cpsw3g {
>>>> +	pinctrl-0 = <&rgmii1_pins_default>;
>>>> +};
>>>> +
>>>> +&cpsw_port2 {
>>>> +	status = "disabled";
>>>> +};
>>>> +
>>>> +&mdio_mux_1 {
>>>> +	status = "disabled";
>>>> +};
>>>> +
>>>> +&icssg1_eth {
>>>> +	pinctrl-0 = <&icssg1_rgmii1_pins_default>, <&icssg1_rgmii2_pins_default>;
>>>> +};
>>>> +
>>>> +&icssg1_emac1 {
>>>> +	status = "okay";
>>>> +	phy-handle = <&icssg1_phy2>;
>>>> +	phy-mode = "rgmii-id";
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>>>> index c08b0223be52..6ae43c12419f 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>>>> @@ -200,7 +200,7 @@ mdio_mux: mux-controller {
>>>>  		mux-gpios = <&exp1 12 GPIO_ACTIVE_HIGH>;
>>>>  	};
>>>>  
>>>> -	mdio-mux-1 {
>>>> +	mdio_mux_1: mdio-mux-1 {
>>>
>>> mdio_mux_1: mdio-mux@1
>>>
>>
>> Sure. I will update this.
>>
>>>>  		compatible = "mdio-mux-multiplexer";
>>>>  		mux-controls = <&mdio_mux>;
>>>>  		mdio-parent-bus = <&cpsw3g_mdio>;
>>>
>>
> 

-- 
Thanks and Regards,
Danish

