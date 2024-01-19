Return-Path: <linux-kernel+bounces-31183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CAB832A34
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31901C233FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01145524D5;
	Fri, 19 Jan 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="st2ei165"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAE4C60F;
	Fri, 19 Jan 2024 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670309; cv=none; b=V4qFjIkr3CcjsalUSHeoPl62p+pvYNPdLEU6m4FK8xKGBCvrVlOUU3oBmAQkK2F053fKoxYG/egWWHGeunNAqHCDTILlLZxF+9ls4EBCKt04oaxzMSVrYimS3xrLLITlP37SVexOi254qrup9vAh5gXBrq8TMn4l5o4s9t4BsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670309; c=relaxed/simple;
	bh=scEyk5mG4MHVlb3TdIEDTYM5miHVqBSU5EH9WQtmfOY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg5PZWKPqf1RHVt+yrGpBA2IvmqNbrIZBGV2n/4045UrgQ7/MicTNOuApPK9Wae82CQaPLumVTqkQxc+4qFCMp/uQgnVLo8pWJVOW1cpdpd+rhMGoex+PqLGTtNnrBGAgzApOctOLeJ10zH8At7RfKLZ90SHg0yB9aLloeVthrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=st2ei165; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JDIAUG122374;
	Fri, 19 Jan 2024 07:18:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705670290;
	bh=DttDxxlhhho6Pk4MnWx7DeuLLf76H/bzgonU83D/WdA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=st2ei165MafZFKllTrLlp4zn9c4ipLAPehTwt9WlJaRvzHrdSXblGkkiB0CRSJ0Xm
	 MzfSI4/3UnzwVYbLMXs2x2qzjomMIhATl3fT44ar3psvu7OEylSl7F1etk2yvPGy9n
	 dA4RgE6SOJy0o/Uz4HsnKApihv3eTVcPnwyjjSWg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JDIAEj085256
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Jan 2024 07:18:10 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 07:18:10 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 07:18:10 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JDIAVn018277;
	Fri, 19 Jan 2024 07:18:10 -0600
Date: Fri, 19 Jan 2024 07:18:10 -0600
From: Nishanth Menon <nm@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>,
        <r-gunasekaran@ti.com>, <danishanwar@ti.com>, <tony@atomide.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
Message-ID: <20240119131810.2qg2zkb3xi4km74q@irritable>
References: <20240118094454.2656734-1-c-vankar@ti.com>
 <20240118094454.2656734-3-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240118094454.2656734-3-c-vankar@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:14-20240118, Chintan Vankar wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> J784S4 SoC has a Main CPSW2G instance of the CPSW Ethernet Switch.
> 
> Add the device-tree nodes for the Main CPSW2G instance and enable it.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 47 +++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 68 ++++++++++++++++++++++
>  2 files changed, 115 insertions(+)

Please do not mix the SoC and evm changes in the same patch.
Also, any benefits of giving the second instance an alias?

> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index f34b92acc56d..826367ffa3f2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -279,6 +279,29 @@ &wkup_gpio0 {
>  
>  &main_pmx0 {
>  	bootph-all;
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
>  	main_uart8_pins_default: main-uart8-default-pins {
>  		bootph-all;
>  		pinctrl-single,pins = <
> @@ -808,6 +831,30 @@ &mcu_cpsw_port1 {
>  	phy-handle = <&mcu_phy0>;
>  };
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
>  &mailbox0_cluster0 {
>  	status = "okay";
>  	interrupts = <436>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 56c8eaad6324..191fdbe02877 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -48,6 +48,12 @@ scm_conf: bus@100000 {
>  		#size-cells = <1>;
>  		ranges = <0x00 0x00 0x00100000 0x1c000>;
>  
> +		cpsw1_phy_gmii_sel: phy@4034 {
> +			compatible = "ti,am654-phy-gmii-sel";
> +			reg = <0x4034 0x4>;
> +			#phy-cells = <1>;
> +		};
> +
>  		serdes_ln_ctrl: mux-controller@4080 {
>  			compatible = "reg-mux";
>  			reg = <0x00004080 0x30>;
> @@ -1242,6 +1248,68 @@ cpts@310d0000 {
>  		};
>  	};
>  
> +	main_cpsw1: ethernet@c200000 {
> +		compatible = "ti,j721e-cpsw-nuss";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		reg = <0x00 0xc200000 0x00 0x200000>;
> +		reg-names = "cpsw_nuss";
> +		ranges = <0x00 0x00 0x00 0xc200000 0x00 0x200000>;
> +		dma-coherent;
> +		clocks = <&k3_clks 62 0>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
> +
> +		dmas = <&main_udmap 0xc640>,
> +		       <&main_udmap 0xc641>,
> +		       <&main_udmap 0xc642>,
> +		       <&main_udmap 0xc643>,
> +		       <&main_udmap 0xc644>,
> +		       <&main_udmap 0xc645>,
> +		       <&main_udmap 0xc646>,
> +		       <&main_udmap 0xc647>,
> +		       <&main_udmap 0x4640>;
> +		dma-names = "tx0", "tx1", "tx2", "tx3",
> +			    "tx4", "tx5", "tx6", "tx7",
> +			    "rx";
> +
> +		status = "disabled";
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			main_cpsw1_port1: port@1 {
> +				reg = <1>;
> +				label = "port1";
> +				phys = <&cpsw1_phy_gmii_sel 1>;
> +				ti,mac-only;
> +				status = "disabled";
> +			};
> +		};
> +
> +		main_cpsw1_mdio: mdio@f00 {
> +			compatible = "ti,cpsw-mdio", "ti,davinci_mdio";
> +			reg = <0x00 0xf00 0x00 0x100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&k3_clks 62 0>;
> +			clock-names = "fck";
> +			bus_freq = <1000000>;
> +		};
> +
> +		cpts@3d000 {
> +			compatible = "ti,am65-cpts";
> +			reg = <0x00 0x3d000 0x00 0x400>;
> +			clocks = <&k3_clks 62 3>;
> +			clock-names = "cpts";
> +			interrupts-extended = <&gic500 GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "cpts";
> +			ti,cpts-ext-ts-inputs = <4>;
> +			ti,cpts-periodic-outputs = <2>;
> +		};
> +	};
> +
>  	main_mcan0: can@2701000 {
>  		compatible = "bosch,m_can";
>  		reg = <0x00 0x02701000 0x00 0x200>,
> -- 
> 2.34.1

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

