Return-Path: <linux-kernel+bounces-70744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2A859BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99855282710
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36309200A8;
	Mon, 19 Feb 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tj+LMdnD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9433C0;
	Mon, 19 Feb 2024 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322149; cv=none; b=RY9aPhLagsw2Nf/GXOHFH1nKhpogEi1FifpjtWTSJS19XxnntQuLLmL1RIBvS6pXR32s/KY+d7DA8U4RSNw7mQ28JBlKZKM0DHjOSxHDuO6nVbjrlZBxHtjrvx89ADeBGaGymgo2FdGjlIiw57eky63NNULhsz0W2PU6C5AxmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322149; c=relaxed/simple;
	bh=kqS+eZftSx4sIClKNOVzzYPgpZBOuze/EHjy6Xbuk/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YbKv4Ddh+XnYVVP8tBGEzEvcEWSZt5Y+90AoBGPPUzXJd8f90HEEP5f2CRGXep4bE9VSQ95EHHtt/WpnlLQoyirXm4FVQ08mCRoWUOaGmFnhgWLgU5nFP95OQFCJGIpsj8DrR/iL3kwJBaoZdJXa3oE2O03tW3pkSH1PHaAbc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Tj+LMdnD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41J5tWsW012920;
	Sun, 18 Feb 2024 23:55:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708322132;
	bh=JLu3cR3Rq0C0/l0UjUXLHLU/TL0qcZO1fpe3DiWw7Ro=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Tj+LMdnDlfiG4Z0KQ4IdWsDw4JGtxWRegUrysk6kXSR4ly0SKqk0xcpo68JS0DpN4
	 ShWS6sewKWBsq6mPjW0xttRgkfFanJKs+OS2URfYz+b2HDN6N5Kfo21WsV4imh2JnH
	 yeKYCVvCnKufI6YAO6ufaN2n79ZSUGubKTwXEuYg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41J5tWHM009778
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 18 Feb 2024 23:55:32 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 18
 Feb 2024 23:55:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 18 Feb 2024 23:55:32 -0600
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41J5tRZE123575;
	Sun, 18 Feb 2024 23:55:28 -0600
Message-ID: <0ca01a1b-8956-40dd-8286-77276e021633@ti.com>
Date: Mon, 19 Feb 2024 11:25:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support
To: Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>
References: <20240216135533.904130-1-vaishnav.a@ti.com>
 <20240216135533.904130-3-vaishnav.a@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240216135533.904130-3-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vaishnav

On 2/16/2024 7:25 PM, Vaishnav Achath wrote:
> J722S EVM has S28HS512T 64 MiB Octal SPI NOR flash connected
> to the OSPI interface, add support for the flash and describe
> the partition information as per bootloader.
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 79 +++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index 9e12a6e9111f..b1c6499c0c9d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -169,6 +169,23 @@ J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
>   		>;
>   	};
>   
> +	ospi0_pins_default: ospi0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0000, PIN_OUTPUT, 0) /* (P23) OSPI0_CLK */
> +			J722S_IOPAD(0x002c, PIN_OUTPUT, 0) /* (M25) OSPI0_CSn0 */
> +			J722S_IOPAD(0x000c, PIN_INPUT, 0) /* (L25) OSPI0_D0 */
> +			J722S_IOPAD(0x0010, PIN_INPUT, 0) /* (N24) OSPI0_D1 */
> +			J722S_IOPAD(0x0014, PIN_INPUT, 0) /* (N25) OSPI0_D2 */
> +			J722S_IOPAD(0x0018, PIN_INPUT, 0) /* (M24) OSPI0_D3 */
> +			J722S_IOPAD(0x001c, PIN_INPUT, 0) /* (N21) OSPI0_D4 */
> +			J722S_IOPAD(0x0020, PIN_INPUT, 0) /* (N22) OSPI0_D5 */
> +			J722S_IOPAD(0x0024, PIN_INPUT, 0) /* (P21) OSPI0_D6 */
> +			J722S_IOPAD(0x0028, PIN_INPUT, 0) /* (N20) OSPI0_D7 */
> +			J722S_IOPAD(0x0008, PIN_INPUT, 0) /* (P22) OSPI0_DQS */


Could you check, Pin name in comments

For example, Schematic says L22 is for OSPI0_DQS , but comments says P22

However offsets are good .

> +		>;
> +		bootph-all;
> +	};
> +
>   	rgmii1_pins_default: rgmii1-default-pins {
>   		pinctrl-single,pins = <
>   			J722S_IOPAD(0x014c, PIN_INPUT, 0) /* (AC25) RGMII1_RD0 */
> @@ -290,6 +307,68 @@ exp1: gpio@23 {
>   	};
>   };
>   
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ospi0_pins_default>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +		spi-max-frequency = <25000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <4>;
> +		bootph-all;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "ospi.tiboot3";
> +				reg = <0x00 0x80000>;
> +			};


I suggest to keep 1MB to accommodate future size increase

> +
> +			partition@80000 {
> +				label = "ospi.tispl";
> +				reg = <0x80000 0x200000>;
> +			};
> +
> +			partition@280000 {
> +				label = "ospi.u-boot";
> +				reg = <0x280000 0x400000>;
> +			};
> +
> +			partition@680000 {
> +				label = "ospi.env";
> +				reg = <0x680000 0x40000>;
> +			};
> +
> +			partition@6c0000 {
> +				label = "ospi.env.backup";
> +				reg = <0x6c0000 0x40000>;
> +			};
> +
> +			partition@800000 {
> +				label = "ospi.rootfs";
> +				reg = <0x800000 0x37c0000>;
> +			};
> +
> +			partition@3fc0000 {
> +				label = "ospi.phypattern";
> +				reg = <0x3fc0000 0x40000>;
> +			};
> +		};
> +	};
> +
> +};
> +
>   &sdhci1 {
>   	/* SD/MMC */
>   	vmmc-supply = <&vdd_mmc1>;

