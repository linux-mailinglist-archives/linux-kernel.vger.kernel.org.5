Return-Path: <linux-kernel+bounces-57462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42284D95D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0ABFB20CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F05E2D796;
	Thu,  8 Feb 2024 04:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dy+kFaow"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447E2E3E8;
	Thu,  8 Feb 2024 04:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707366266; cv=none; b=ce6HoUyo61YD4dtyQjeanfuIcnBfjX1zjgLcoX7B+IyeBuzetZmyEbZmcE+e3rJ8Hk5b1JJ5ohO0VIV7VRyl6oVdwuMO9KGOObjy9dZLyVH7X9DVV+elRaNBPYQPaVR2anfkTeaEHHxBX1nODqOgiwGtNQu870aXo4Yx7/kmp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707366266; c=relaxed/simple;
	bh=WAxk1XQiVBGvTR21h1heyPZJjcckDl5qJsnv/OakAyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OW5nkSGKcvOPZvLGMW3ureUWIIkig3ACmsYbNN7ZwrdG+szUYtPeALEnd/xnqvFJRX5gkYUykzo51iGitMs0tz2dhQtWJlzYitEpk0Upu+sDXuajbZflYdCrueh0fJ/CO4+aM9GndgpeBwC/1axLJ4LjHrAIjLt45Ol8Xcv2AdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dy+kFaow; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4184OBVk089075;
	Wed, 7 Feb 2024 22:24:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707366251;
	bh=/EVdo4CqWkF7c65rcSRkeEKdEZKGAh1PbQMZsDt4Id0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dy+kFaow1WZg1RAy8qxygzEP56KCRLHq9ODZkEAzRVijJzG8oEWqryPClONr5PFAz
	 E0Cmhorp/rE33WnRtC9Hmes+xk2vfBH5P+6kPSNITq8nDVroxeohdsRulBumb1iyav
	 AXtdIUqbsCo3Nt/T6cihDq3PlgPL+1dHuHcE8PyA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4184OBib024617
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 22:24:11 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 22:24:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 22:24:10 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4184O6N9060106;
	Wed, 7 Feb 2024 22:24:07 -0600
Message-ID: <f0a05e0f-a40b-425d-883f-f3222f323dcd@ti.com>
Date: Thu, 8 Feb 2024 09:54:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: Add DT overlay for PCIe + USB3.0
 SERDES personality card
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>
CC: <afd@ti.com>, <a-bhatia1@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@ti.com>
References: <20240126114530.40913-1-rogerq@kernel.org>
 <20240126114530.40913-4-rogerq@kernel.org>
 <547d7069-3457-4ee3-ad1c-fedc9db5da62@ti.com>
 <a576961e-b737-49a8-80a5-65c87fff845d@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <a576961e-b737-49a8-80a5-65c87fff845d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 06/02/24 19:06, Roger Quadros wrote:
> 
> 
> On 05/02/2024 16:46, Vignesh Raghavendra wrote:
>>
>>
>> On 26/01/24 17:15, Roger Quadros wrote:
>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>>
>>
>> [...]
>>
>>>  # Boards with J7200 SoC
>>>  k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
>>> new file mode 100644
>>> index 000000000000..c63b7241c005
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
>>> @@ -0,0 +1,67 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>>> +/**
>>> + * DT overlay for SERDES personality card: 1lane PCIe + USB3.0 DRD on AM654 EVM
>>> + *
>>> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - http://www.ti.com/
>>> + */
>>> +
>>> +/dts-v1/;
>>> +/plugin/;
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/phy/phy.h>
>>> +#include <dt-bindings/phy/phy-am654-serdes.h>
>>> +
>>> +#include "k3-pinctrl.h"
>>> +
>>> +&serdes1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pcie1_rc {
>>> +	num-lanes = <1>;
>>> +	phys = <&serdes1 PHY_TYPE_PCIE 0>;
>>> +	phy-names = "pcie-phy0";
>>> +	reset-gpios = <&pca9555 5 GPIO_ACTIVE_HIGH>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pcie1_ep {
>>> +	num-lanes = <1>;
>>> +	phys = <&serdes1 PHY_TYPE_PCIE 0>;
>>> +	phy-names = "pcie-phy0";
>>> +};
>>> +
>>> +&main_pmx0 {
>>> +	usb0_pins_default: usb0_pins_default {
>>
>> No underscores in node-name and also should end with -pins
>>
>>> +		pinctrl-single,pins = <
>>> +			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
>>> +		>;
>>> +	};
>>> +};
>>> +
>>> +&serdes0 {
>>> +	status = "okay";
>>> +	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
>>> +	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
>>> +};
>>> +
>>> +&dwc3_0 {
>>> +	status = "okay";
>>> +	assigned-clock-parents = <&k3_clks 151 4>,      /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
>>> +	<&k3_clks 151 8>;      /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
>>> +	phys = <&serdes0 PHY_TYPE_USB3 0>;
>>> +	phy-names = "usb3-phy";
>>> +};
>>> +
>>> +&usb0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&usb0_pins_default>;
>>> +	dr_mode = "host";
>>> +	maximum-speed = "super-speed";
>>> +	snps,dis-u1-entry-quirk;
>>> +	snps,dis-u2-entry-quirk;
>>> +};
>>> +
>>> +&usb0_phy {
>>> +	status = "okay";
>>> +};
>>
>>
>> BTW, this breaks build on 6.8-rc1
>>
>>
>>   DTOVL   arch/arm64/boot/dts/ti/k3-am654-gp-evm.dtb
>>
>> Failed to apply 'arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtbo': FDT_ERR_NOTFOUND
>>
>>
> 
> It builds fine for me. Did the 3rd patch apply cleanly for you?
> 


Yes, build failure is due to the fact that I picked up Andrew's patch to
remove pcie_ep node. Could you please respin this on top of ti-next /
linux-next?

--
Regards
Vignesh

