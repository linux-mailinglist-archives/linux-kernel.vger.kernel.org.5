Return-Path: <linux-kernel+bounces-40238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3028483DCFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C411F24F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987341CAA1;
	Fri, 26 Jan 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OsPyVERI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ADB1CD1B;
	Fri, 26 Jan 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281271; cv=none; b=AAeglmJOFvjx6FQWQ0MWUQKwN7P4yH91Yh1MlEyAsn42DpsZeC33is4z645D0x+JARj1VVfATHtz/Be0wgRK+WuWfcbqgy6r2VSc3enwn0udZGctda/PRRuOVbGMSOsDofcc9RQz/lyhric+4j8purdASwI1syv0zQW7qcxvQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281271; c=relaxed/simple;
	bh=ogH/WxYNzbxPJyMWY22zLDSZVE6tO2CwW3DYcs0iSi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LQW+P1/dMFh9QJwO5y0gDTdoWdkESHW1SAFLkqPQKKWRvpfNzZQqhCktUbPP7PlhGsURCBpCpyel/GhEBvKx0w/ZUiJzrUfibfmnIWf3OSMzB5QXOo0P5aFgyjSKsyJVOBuQeDzY69V56MfKU9gQ9+U3MQ15pFwSAE0gJA0yYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OsPyVERI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40QF0wKq085493;
	Fri, 26 Jan 2024 09:00:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706281258;
	bh=c771FDHfVeJbjIOLYa+Ep4vTxtf3uSuzaoVrdsfKZ6U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OsPyVERIck5lszwtfBEiqG1MbXfFj/2fkfU6V6HLKAwgd5a2yKWRbrDg9EA5HzJ9d
	 i8W+2LnXtHpC5knhxEUvtX9P+4FhtO9aynmbK4mXEOs7/tNN3uzbCZSMuG4mW+E7wv
	 FtLVvhlpfKmNVrxEzBPVgUXdDmxc7cQVGM2Kmt2E=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40QF0wUA021144
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jan 2024 09:00:58 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jan 2024 09:00:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jan 2024 09:00:57 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40QF0vjJ004728;
	Fri, 26 Jan 2024 09:00:57 -0600
Message-ID: <16473ecf-c837-4424-a279-e5d921c2a588@ti.com>
Date: Fri, 26 Jan 2024 09:00:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62/a/p: use sub-node for
 USB_PHY_CTRL registers
To: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240126125951.18585-1-rogerq@kernel.org>
 <20240126125951.18585-2-rogerq@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240126125951.18585-2-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/26/24 6:59 AM, Roger Quadros wrote:
> Exposing the entire CTRL_MMR space to syscon is not a good idea.
> Add sub-nodes for USB0_PHY_CTRL and USB1_PHY_CTRL and use them
> in the USB0/USB1 nodes.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi    |  4 ++--
>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  | 10 ++++++++++
>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   |  4 ++--
>   arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 10 ++++++++++
>   arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 10 ++++++++++
>   5 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 464b7565d085..9432ed344d52 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -625,7 +625,7 @@ usbss0: dwc3-usb@f900000 {
>   		reg = <0x00 0x0f900000 0x00 0x800>;
>   		clocks = <&k3_clks 161 3>;
>   		clock-names = "ref";
> -		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
> +		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
> @@ -648,7 +648,7 @@ usbss1: dwc3-usb@f910000 {
>   		reg = <0x00 0x0f910000 0x00 0x800>;
>   		clocks = <&k3_clks 162 3>;
>   		clock-names = "ref";
> -		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
> +		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index fef76f52a52e..bd09662a3c29 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -19,6 +19,16 @@ chipid: chipid@14 {
>   			compatible = "ti,am654-chipid";
>   			reg = <0x14 0x4>;
>   		};
> +
> +		usb0_phy_ctrl: syscon@4008 {
> +			compatible = "syscon";

You'll want to add a binding for this to the simple syscon list.
See this patch for an example[0]. Otherwise this gives a DT check
warning.

Also, adding the new nodes for AM62p should be moved to the
next patch in this series. Fixing AM62 and AM62a should be
a standalone patch.

Andrew

[0] commit cb523495ee2a ("dt-bindings: mfd: syscon: Add ti,am654-dss-oldi-io-ctrl compatible")

> +			reg = <0x4008 0x4>;
> +		};
> +
> +		usb1_phy_ctrl: syscon@4018 {
> +			compatible = "syscon";
> +			reg = <0x4018 0x4>;
> +		};
>   	};
>   
>   	wkup_uart0: serial@2b300000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index f0b8c9ab1459..8311c7c44cd3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -566,7 +566,7 @@ usbss0: dwc3-usb@f900000 {
>   		reg = <0x00 0x0f900000 0x00 0x800>;
>   		clocks = <&k3_clks 161 3>;
>   		clock-names = "ref";
> -		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
> +		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
> @@ -589,7 +589,7 @@ usbss1: dwc3-usb@f910000 {
>   		reg = <0x00 0x0f910000 0x00 0x800>;
>   		clocks = <&k3_clks 162 3>;
>   		clock-names = "ref";
> -		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
> +		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> index 4e8279fa01e1..26e9fd9da78f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> @@ -17,6 +17,16 @@ chipid: chipid@14 {
>   			compatible = "ti,am654-chipid";
>   			reg = <0x14 0x4>;
>   		};
> +
> +		usb0_phy_ctrl: syscon@4008 {
> +			compatible = "syscon";
> +			reg = <0x4008 0x4>;
> +		};
> +
> +		usb1_phy_ctrl: syscon@4018 {
> +			compatible = "syscon";
> +			reg = <0x4018 0x4>;
> +		};
>   	};
>   
>   	wkup_uart0: serial@2b300000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> index 19f42b39394e..0893e63c399a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> @@ -18,6 +18,16 @@ chipid: chipid@14 {
>   			reg = <0x14 0x4>;
>   			bootph-all;
>   		};
> +
> +		usb0_phy_ctrl: syscon@4008 {
> +			compatible = "syscon";
> +			reg = <0x4008 0x4>;
> +		};
> +
> +		usb1_phy_ctrl: syscon@4018 {
> +			compatible = "syscon";
> +			reg = <0x4018 0x4>;
> +		};
>   	};
>   
>   	wkup_uart0: serial@2b300000 {

