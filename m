Return-Path: <linux-kernel+bounces-129972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF648972B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9181F217DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B957875;
	Wed,  3 Apr 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dfJ2hSUi"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC879461;
	Wed,  3 Apr 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154860; cv=none; b=qgMHf9y+uKviV1DBqsvyMJk0mJCeEBOSRcJiE/66WHa+eO6IKrPpF9ZSQW0yAv731IKiMd0EUBlyMVZ6hvh+n7OGQhUQ1r9FxDI6XKS3SMKAtq1MMqKYqLM3VcEIllhnxX0v9ATIRP2R3kTzWGr/foiJfKPuK245il2qMuUY3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154860; c=relaxed/simple;
	bh=IAYJLk6DU8cPwm4Sq8ppOSGbg/MjkwMiUAFWzHaDr2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rk1imBJWsedYTX4qdQHNXRYUTtSgX1k8g3LZwU47aj6sZwGqbJLuoFdKkbJuiCDFFsKGBWPTgZzt+R1bi2310Z3PO5GT8tNdgrFjBFP/raHBO2wQCWXajnBdCc0Vo1v1SL+URW/Wb8y/Ii5cv5872LLZh2GxHmwn6nHDMkF++Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dfJ2hSUi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433EY47Y103082;
	Wed, 3 Apr 2024 09:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712154844;
	bh=9nvuNv2peLEBbIQzidVWKZxcdEr6uidwXCp/+6d7NzI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dfJ2hSUi8FPR1Lo44762Gc1y+RmW8gSWFEDWAvau7ccV6o9Pz4mfY2WdVD3auEH2x
	 P8JvxfQ7hXxXQl+aT8D4drzm8X6UNVbhxbXqUL/fxYuzn/rmkFQ7fM5pkUABrBMHE0
	 4Y6c7OtROgPQ5X2wulXHnMBRFXuzXGZtS6ShE0nY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433EY4GQ021774
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 09:34:04 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 09:34:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 09:34:03 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433EY3jB031913;
	Wed, 3 Apr 2024 09:34:03 -0500
Message-ID: <67c8028c-0d22-447a-8856-0c42d1cdeb64@ti.com>
Date: Wed, 3 Apr 2024 09:34:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-{am62p,j722s}: Disable ethernet by
 default
To: Michael Walle <mwalle@kernel.org>,
        Francesco Dolcini
	<francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240403101545.3932437-1-mwalle@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240403101545.3932437-1-mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/3/24 5:15 AM, Michael Walle wrote:
> Device tree best practice is to disable any external interface in the
> dtsi and just enable them if needed in the device tree. Thus, disable
> the ethernet switch and its ports by default and just enable the ones
> used by the EVMs in their device trees.
> 
> There is no functional change.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---

Acked-by: Andrew Davis <afd@ti.com>

> v2:
>   - move the status propert into k3-am62p5-main.dtsi, thus also update
>     the k3-am62p5-sk.dts
>   - put "status" last
> ---
>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 3 +++
>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts   | 3 +++
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 5 +----
>   3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 7337a9e13535..88bc64111234 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -673,6 +673,7 @@ cpsw3g: ethernet@8000000 {
>   		assigned-clock-parents = <&k3_clks 13 11>;
>   		clock-names = "fck";
>   		power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>   
>   		dmas = <&main_pktdma 0xc600 15>,
>   		       <&main_pktdma 0xc601 15>,
> @@ -696,6 +697,7 @@ cpsw_port1: port@1 {
>   				label = "port1";
>   				phys = <&phy_gmii_sel 1>;
>   				mac-address = [00 00 00 00 00 00];
> +				status = "disabled";
>   			};
>   
>   			cpsw_port2: port@2 {
> @@ -704,6 +706,7 @@ cpsw_port2: port@2 {
>   				label = "port2";
>   				phys = <&phy_gmii_sel 2>;
>   				mac-address = [00 00 00 00 00 00];
> +				status = "disabled";
>   			};
>   		};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> index 6694087b3665..6a9c99c5fb2a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -431,16 +431,19 @@ &cpsw3g {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_rgmii1_pins_default>,
>   		    <&main_rgmii2_pins_default>;
> +	status = "okay";
>   };
>   
>   &cpsw_port1 {
>   	phy-mode = "rgmii-rxid";
>   	phy-handle = <&cpsw3g_phy0>;
> +	status = "okay";
>   };
>   
>   &cpsw_port2 {
>   	phy-mode = "rgmii-rxid";
>   	phy-handle = <&cpsw3g_phy1>;
> +	status = "okay";
>   };
>   
>   &cpsw3g_mdio {
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index 6b148da2bcdc..8a38e5ae7d4f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -226,10 +226,7 @@ cpsw3g_phy0: ethernet-phy@0 {
>   &cpsw_port1 {
>   	phy-mode = "rgmii-rxid";
>   	phy-handle = <&cpsw3g_phy0>;
> -};
> -
> -&cpsw_port2 {
> -	status = "disabled";
> +	status = "okay";
>   };
>   
>   &main_gpio1 {

