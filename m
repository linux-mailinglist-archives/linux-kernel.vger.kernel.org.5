Return-Path: <linux-kernel+bounces-61188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1709850E99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62A41C213A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA027883A;
	Mon, 12 Feb 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TsR7nBuk"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321C321D;
	Mon, 12 Feb 2024 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725234; cv=none; b=Pzc5euJroMaSRb/emeAYmSBrnqHYACbN05ga72oNukxWk84os7ge6rdvyxC4+SdElMAf0zJEQLtpnLATCbF6yh9x9irEbcKJi76v5hWh3mt+/EZ/n2yNwf/TXRCTvwhsEuwMw35unZMgCBMl7FY6eytzAmobGk/mxqvdYu3RtPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725234; c=relaxed/simple;
	bh=/NObT2BJIRRk804yYtLjSJP7XuBFv1Z6SfpCILaMLCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lDSn9Qfxz/TUbFKWqyWiWXjVqsx8m/AnElYo30ayD611zIR47yMleQ8i5zQDjcgqq6W6WomwJcINu4sc1FEDh0HytY5Miymer/QPALAF+bfUYs+PXVA/vvqyFYnWSzM0WeZJYYmxUSPo3u3bFsUn0Sw+8l1/NGOfHHm/bmUnuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TsR7nBuk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41C86xDK060972;
	Mon, 12 Feb 2024 02:06:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707725219;
	bh=LJcHlbKaaeOSneIcBbGao3hkbua7EzT+M3NQRcb+ECI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TsR7nBukuq6qd5GXTJPbS5M89uxd8CYUSwToNoMqQBNQYJwEVgm/DhsyW77IgQhdq
	 khzcaGbQ4dxALyaHFHEq35TtSxwcfEu6oevai0Ps0U6kurOsJVGUzzSvVEoyYN2Zzu
	 4oMlu6goBVHy6lWUIn682T7mlPg03AdPQ++tiHV4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41C86xTU039332
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 02:06:59 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 02:06:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 02:06:59 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41C86suZ031111;
	Mon, 12 Feb 2024 02:06:55 -0600
Message-ID: <1a29102b-b3b6-4aee-96b2-5169fefeecb3@ti.com>
Date: Mon, 12 Feb 2024 13:36:53 +0530
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
To: Roger Quadros <rogerq@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
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
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <33e62844-a148-4374-aba8-481dc7799e15@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger,

On 02/02/24 5:56 pm, Roger Quadros wrote:
> 
> 
> On 22/01/2024 13:30, MD Danish Anwar wrote:
>> The am642-evm doesn't allow to enable 2 x CPSW3g ports and 2 x ICSSG1 ports
>> all together, so base k3-am642-evm.dts enables by default 2 x CPSW3g ports
>> and 1 x ICSSG1 ports, but it also possible to support 1 x CPSW3g ports and
>> 2 x ICSSG1 ports configuration.
> 
> "it is also possible"
> 
> OK so there can only be 3 ethernet ports on this board. There is no "ethernet3" alias.
> 
>>
>> This patch adds overlay to support 1 x CPSW3g ports and 2 x ICSSG1 ports
>> configuration:
>> - Add label name 'mdio_mux_1' for 'mdio-mux-1' node so that the node
>>   'mdio-mux-1' can be disabled in the overlay using the label name.
>> - disable 2nd CPSW3g port
>> - update CPSW3g pinmuxes to not use RGMII2
>> - disable mdio-mux-1 and define mdio-mux-2 to route ICSSG1 MDIO to the
>>   shared DP83869 PHY
>> - add and enable ICSSG1 RGMII2 pinmuxes
>> - enable ICSSG1 MII1 port
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/Makefile               |  5 ++
>>  .../dts/ti/k3-am642-evm-icssg1-dualemac.dtso  | 75 +++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  2 +-
>>  3 files changed, 81 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 52c1dc910308..320b2fae5730 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>>  dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
>> +dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
>>  
>>  # Boards with AM65x SoC
>>  k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
>> @@ -105,6 +106,8 @@ k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
>>  	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>>  k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
>>  	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
>> +k3-am642-evm-icssg1-dualemac-dtbs := \
>> +	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
>>  k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
>>  	k3-j721e-evm-pcie0-ep.dtbo
>>  k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
>> @@ -120,6 +123,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>>  	k3-am62a7-sk-csi2-ov5640.dtb \
>>  	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
>>  	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
>> +	k3-am642-evm-icssg1-dualemac.dtb \
>>  	k3-j721e-evm-pcie0-ep.dtb \
>>  	k3-j721s2-evm-pcie1-ep.dtb
>>  
>> @@ -129,6 +133,7 @@ DTC_FLAGS_k3-am625-sk += -@
>>  DTC_FLAGS_k3-am62-lp-sk += -@
>>  DTC_FLAGS_k3-am62a7-sk += -@
>>  DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
>> +DTC_FLAGS_k3-am642-evm += -@
>>  DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>>  DTC_FLAGS_k3-j721e-common-proc-board += -@
>>  DTC_FLAGS_k3-j721s2-common-proc-board += -@
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso
>> new file mode 100644
>> index 000000000000..b2b1a6252e73
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Don't you need to use updated licensing header like in the series [1]
> 
> [1] https://lore.kernel.org/all/20240110140903.4090946-1-nm@ti.com/
> 
>> +/**
>> + * DT overlay for enabling 2nd ICSSG1 port on AM642 EVM
>> + *
>> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "k3-pinctrl.h"
>> +
>> +&{/} {
> 
> You need to fixup alias for ethernet1 to icssg1_emac1?
> 
>> +	mdio-mux-2 {
> 
> this should be mdio-mux@0 ?
> 
>> +		compatible = "mdio-mux-multiplexer";
>> +		mux-controls = <&mdio_mux>;
>> +		mdio-parent-bus = <&icssg1_mdio>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		mdio@0 {
>> +			reg = <0x0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			icssg1_phy2: ethernet-phy@3 {
>> +				reg = <3>;
>> +				tx-internal-delay-ps = <250>;
>> +				rx-internal-delay-ps = <2000>;
>> +			};
>> +		};
>> +	};
>> +};
>> +

<snip>

>> +};
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> index c08b0223be52..6ae43c12419f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> @@ -200,7 +200,7 @@ mdio_mux: mux-controller {
>>  		mux-gpios = <&exp1 12 GPIO_ACTIVE_HIGH>;
>>  	};
>>  
>> -	mdio-mux-1 {
>> +	mdio_mux_1: mdio-mux-1 {
> 
> mdio_mux_1: mdio-mux@1
> 

Changing this from mdio-mux-1 to mdio-mux@1 is giving me erorr in DTBS_CHECK

/home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
/: mdio-mux@1: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

The documentation of mdio-mux-multiplexer [1] also has example section
with node name as -1 instead of @1. I don't think node should be renamed
to mdio-mux@1.

I hadn't done DTBS_CHECK earlier have already made this change in v4
[2]. I will revert back this change and keep the nodes as mdio-mux-1 and
mdio-mux-2 in v5. Let me know if it's OK with you.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/net/mdio-mux-multiplexer.yaml#n34
[2] https://lore.kernel.org/all/20240205090546.4000446-4-danishanwar@ti.com/

>>  		compatible = "mdio-mux-multiplexer";
>>  		mux-controls = <&mdio_mux>;
>>  		mdio-parent-bus = <&cpsw3g_mdio>;
> 

-- 
Thanks and Regards,
Danish

