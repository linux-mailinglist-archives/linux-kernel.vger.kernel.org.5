Return-Path: <linux-kernel+bounces-48393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A49845B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CBB1F2BBE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36015DBAC;
	Thu,  1 Feb 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BjWT620y"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EE4D9F2;
	Thu,  1 Feb 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800993; cv=none; b=i5WFRdotAlUYhOfSLrAEkVNuuWyoVF/MeZIRluYBfzhP9Iektpot4vbDUDvpplP4kz2M8Hxw2sLDqUplGygdwCPhaLfHmXOZmHW1lgC+JMKb+hdvlPI3SP6IM4tXCa8YUaP99FH7FbJ/kq6diiG+Mr0GN4LI50w/Q44rljpmutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800993; c=relaxed/simple;
	bh=lrMpJHmL6dLiDJBX/uXUgDSz+S9xzB96Vgx8mAvb3EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gSLNf7+tQDZUmwMN3sJOHpExmx0BOx66h7GgD/gMMR66SquBph1n7r7B2uHnkj/wrHE/aSZd41kFe1Bz0grzj/fPJheZPdz6okh4HIShtigUUYB3aNAnN7sU2mglUkA37NfBy5Mpk/74iXA3rYTD4LUER7tLOEZ0SCV0R5ChvXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BjWT620y; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411FN5XV009343;
	Thu, 1 Feb 2024 09:23:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706800985;
	bh=4u0t1agjt5N36cmUVcWvY4Qs+OpjwDPsN+ZNOQ2Kc64=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BjWT620yy9hsUg3MDFUPOnsw5ie1SylpYdmiQv148s1Cq2yv0yf5SUSfrgzN8kERt
	 BpfiqQnhvNbrA33Ln5XU3OtB/t87+lbo5Le8Kf479w5HmTUScGhjL3rUrwoNYrlf/L
	 5Fxf1vaL2wgnh1BYcdRNJHZHZaDd49oTI5klntXs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411FN4CC012003
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 09:23:05 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 09:23:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 09:23:03 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411FN3YX087378;
	Thu, 1 Feb 2024 09:23:03 -0600
Message-ID: <c032c8c7-a4f3-4cd0-a96f-dd177ad84ba4@ti.com>
Date: Thu, 1 Feb 2024 09:23:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] arm64: dts: ti: k3-am62/a: use sub-node for
 USB_PHY_CTRL registers
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>, <b-liu@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-3-rogerq@kernel.org>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240201120332.4811-3-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/1/24 6:03 AM, Roger Quadros wrote:
> Exposing the entire CTRL_MMR space to syscon is not a good idea.
> Add sub-nodes for USB0_PHY_CTRL and USB1_PHY_CTRL and use them
> in the USB0/USB1 nodes.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> 

Reviewed-by: Andrew Davis <afd@ti.com>

> Notes:
>      Changelog:
>      
>      v3 - no change
>      
>      v2:
>      - moved am62p changes to next patch
>      - use new compatible for USB PHY CTRL node
> 
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi    |  4 ++--
>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  | 10 ++++++++++
>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   |  4 ++--
>   arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 10 ++++++++++
>   4 files changed, 24 insertions(+), 4 deletions(-)
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
> index fef76f52a52e..817700b2eacf 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -19,6 +19,16 @@ chipid: chipid@14 {
>   			compatible = "ti,am654-chipid";
>   			reg = <0x14 0x4>;
>   		};
> +
> +		usb0_phy_ctrl: syscon@4008 {
> +			compatible = "ti,am62-usb-phy-ctrl", "syscon";
> +			reg = <0x4008 0x4>;
> +		};
> +
> +		usb1_phy_ctrl: syscon@4018 {
> +			compatible = "ti,am62-usb-phy-ctrl", "syscon";
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
> index 4e8279fa01e1..4a375f5e0c19 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> @@ -17,6 +17,16 @@ chipid: chipid@14 {
>   			compatible = "ti,am654-chipid";
>   			reg = <0x14 0x4>;
>   		};
> +
> +		usb0_phy_ctrl: syscon@4008 {
> +			compatible = "ti,am62-usb-phy-ctrl", "syscon";
> +			reg = <0x4008 0x4>;
> +		};
> +
> +		usb1_phy_ctrl: syscon@4018 {
> +			compatible = "ti,am62-usb-phy-ctrl", "syscon";
> +			reg = <0x4018 0x4>;
> +		};
>   	};
>   
>   	wkup_uart0: serial@2b300000 {

