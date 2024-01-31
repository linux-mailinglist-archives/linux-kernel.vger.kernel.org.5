Return-Path: <linux-kernel+bounces-46729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2839844344
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCF7B280BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697DB12A169;
	Wed, 31 Jan 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sy6Ckxc3"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E735E1292F7;
	Wed, 31 Jan 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715716; cv=none; b=Q+1so5HNoreT+Z31DMb4U/2wzp6LBv6PJDdF8R0bbXpoKj5DdngdmP7Nr8TS6LDeMXMv6byqVAMusv3lQsg8zykCD23Ha6Melum7ZQS0lTLUSVlSfI+4L3YnZeZ4eJ1hG5HGV0eeHyw3RFPG8luG45s0Xr68gST61WI6iPUpVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715716; c=relaxed/simple;
	bh=OY3bW4RyJYoIakBZivR/Y+Ua+hVYu3TyxVNFADq89ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eSt7tTtUOHPfisA4cR2Psmx649msOdyNdA5dg5unMkC/G+2kbzEmWSCgL/rFpvAvXWHQWIJBA28xF48+VZEBzNkW3SVm6tjsXG5tjjmbrwAEAX2VAXZTRJgJjY/jQVtgmYTvSVZFVByTuhkQJy3oVTI1RovZSAvcfSVMDyFubaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sy6Ckxc3; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VFfcR2026580;
	Wed, 31 Jan 2024 09:41:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706715698;
	bh=YUPIxfbN7igG1w5ev0dRIuOh5fGnBd1xonZKD3T8aDs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Sy6Ckxc34RFdHK5+QpbrbJp5WWtZj17uqYsykjZxOu8XPlLyPCN/hRUn/d0Zb72tm
	 zW9mAsdAN6FT8H0/WRn1JEzLquvSbq37Qsf2f2hHFipbrVddOZ8jHF2nYOcpX2IrbT
	 gOH6s0eDjZeikBIIf5543Krx1U6pWitYNUyUF78s=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VFfcJA011814
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 09:41:38 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 09:41:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 09:41:38 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VFfbLF069991;
	Wed, 31 Jan 2024 09:41:37 -0600
Message-ID: <96e48198-6027-4f94-9a36-1c21560fdfc1@ti.com>
Date: Wed, 31 Jan 2024 09:41:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
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
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
        Jayesh Choudhary
	<j-choudhary@ti.com>
References: <20240131101441.1362409-1-c-vankar@ti.com>
 <20240131101441.1362409-5-c-vankar@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240131101441.1362409-5-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/31/24 4:14 AM, Chintan Vankar wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> Add the device-tree nodes for the Main CPSW2G instance and enable it.
> 
> Add alias for the Main CPSW2G port to enable Linux to fetch MAC Address
> for the port directly from U-Boot.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 49 ++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index b74f7d3025de..be028c246c67 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -28,6 +28,7 @@ aliases {
>   		i2c0 = &wkup_i2c0;
>   		i2c3 = &main_i2c0;
>   		ethernet0 = &mcu_cpsw_port1;
> +		ethernet1 = &main_cpsw1_port1;
>   	};
>   
>   	memory@80000000 {
> @@ -280,6 +281,30 @@ &wkup_gpio0 {
>   
>   &main_pmx0 {
>   	bootph-all;
> +	main_cpsw2g_default_pins: main-cpsw2g-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
> +			J784S4_IOPAD(0x0a0, PIN_INPUT, 6) /* (AD34) MCASP0_AXR12.RGMII1_RD1 */
> +			J784S4_IOPAD(0x0a4, PIN_INPUT, 6) /* (AJ36) MCASP0_AXR13.RGMII1_RD2 */
> +			J784S4_IOPAD(0x0a8, PIN_INPUT, 6) /* (AF34) MCASP0_AXR14.RGMII1_RD3 */
> +			J784S4_IOPAD(0x0b0, PIN_INPUT, 6) /* (AL33) MCASP1_AXR3.RGMII1_RXC */
> +			J784S4_IOPAD(0x0ac, PIN_INPUT, 6) /* (AE34) MCASP0_AXR15.RGMII1_RX_CTL */
> +			J784S4_IOPAD(0x08c, PIN_INPUT, 6) /* (AE35) MCASP0_AXR7.RGMII1_TD0 */
> +			J784S4_IOPAD(0x090, PIN_INPUT, 6) /* (AC35) MCASP0_AXR8.RGMII1_TD1 */
> +			J784S4_IOPAD(0x094, PIN_INPUT, 6) /* (AG35) MCASP0_AXR9.RGMII1_TD2 */
> +			J784S4_IOPAD(0x098, PIN_INPUT, 6) /* (AH36) MCASP0_AXR10.RGMII1_TD3 */
> +			J784S4_IOPAD(0x0b4, PIN_INPUT, 6) /* (AL34) MCASP1_AXR4.RGMII1_TXC */
> +			J784S4_IOPAD(0x09c, PIN_INPUT, 6) /* (AF35) MCASP0_AXR11.RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	main_cpsw2g_mdio_default_pins: main-cpsw2g-mdio-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x0c0, PIN_INPUT, 6) /* (AD38) MCASP1_AXR0.MDIO0_MDC */
> +			J784S4_IOPAD(0x0bc, PIN_INPUT, 6) /* (AD33) MCASP1_AFSX.MDIO0_MDIO */
> +		>;
> +	};
> +	
>   	main_uart8_pins_default: main-uart8-default-pins {
>   		bootph-all;
>   		pinctrl-single,pins = <
> @@ -809,6 +834,30 @@ &mcu_cpsw_port1 {
>   	phy-handle = <&mcu_phy0>;
>   };
>   
> +&main_cpsw1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_cpsw2g_default_pins>;
> +};
> +
> +&main_cpsw1_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_cpsw2g_mdio_default_pins>;

If we need this pinmux info, why wasn't this node disabled? You disabled
the main_cpsw0_mdio instance, but not this one. Disable this by default
in the patch before this, then status = "okay" it here.

Andrew

> +
> +	main_cpsw1_phy0: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,min-output-impedance;
> +	};
> +};
> +
> +&main_cpsw1_port1 {
> +	status = "okay";
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&main_cpsw1_phy0>;
> +};
> +
>   &mailbox0_cluster0 {
>   	status = "okay";
>   	interrupts = <436>;

