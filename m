Return-Path: <linux-kernel+bounces-70908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73EE859DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34241C21F12
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822D92137F;
	Mon, 19 Feb 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fs7xbopf"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650D2135C;
	Mon, 19 Feb 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330228; cv=none; b=KVdIUiGFrR4tK22s2eDbLuI5VJyLltE0XWovecRJOoFy/MJ+TpnSBAp2vaYPI6c07X25YzV4VpFQfwlu3kR2B3PPep9vsYBsUAA91xmRDHDknSZqljOytQo6H+KJaX3CcrGOv0BpVQOmFHf6WA39C0WS0uoD/S3OFRO7SMym+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330228; c=relaxed/simple;
	bh=Wnz7IF+lBWMi5nmkstyYasqT63skyZVsy8kEwI7acJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lwsMCEePrJAHkMtW/tjn7jhYXWh1T2N++dtXTF1z8+dkGtljT/1YDbr5yyLzORDHqXSIx9c8hoLclOr+DEJ3OiKykV3HvUO1pumFbGqEi1MHZ3TABCKRzqScn6Ik5N/8F79wd5KqOS+5tAVmW/nhpSZMTCE6P/N2jiW2kDw/TRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fs7xbopf; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41J8A7KN049025;
	Mon, 19 Feb 2024 02:10:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708330207;
	bh=ecqgTj1/lMnJgqH/K/Gn3LYhWWugkOjDn1gyoX0RGuo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fs7xbopfBN1vYyhaEjoO8g7N4NHQoi0vL4+p2Z0fxqZUdaNM9z28PR1Tug1SLCTkd
	 x7tmcpFBejjBezxuSi/Yi13mx2+7fLt5aF5g4tw9RLu5rPGg7EVkhizTFBjyQJ3FBn
	 zQGP7yfftVdZMTbZ4QSHRVKlqKjs/paMwRUSDsCc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41J8A76i003479
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 02:10:07 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 02:10:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 02:10:07 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41J8A3MM066742;
	Mon, 19 Feb 2024 02:10:05 -0600
Message-ID: <623c9ed1-85f2-47a3-9ca2-8c7fa5b2251b@ti.com>
Date: Mon, 19 Feb 2024 13:40:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm64: dts: ti: k3-am68-sk-som: Add support for OSPI
 flash
Content-Language: en-US
To: Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinthu Raja <sinthu.raja@ti.com>
References: <20240219075932.6458-1-sinthu.raja@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240219075932.6458-1-sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 19/02/24 13:29, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> AM68 SK has an OSPI NOR flash on its SOM connected to OSPI0 instance.
> Enable support for the same. Also, describe the OSPI flash partition
> information through the device tree, according to the offsets in the
> bootloader.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> Changes in V2:
> =============
> 1. Address review comments
>    a. remove pin E20, which is not connected.
> 
> V1: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240206092334.30307-1-sinthu.raja@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> index 0f4a5da0ebc4..afaf702cfc9d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> @@ -130,6 +130,24 @@ rtos_ipc_memory_region: ipc-memories@a8000000 {
>  	};
>  };
>  
> +&wkup_pmx0 {
> +	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {

pinmux nodes should end with -pins                        ^^^^^^


Please run make dtbs_check and fix the issues pointed out

> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (D19) MCU_OSPI0_CLK */
> +			J721S2_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F15) MCU_OSPI0_CSn0 */
> +			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (C19) MCU_OSPI0_D0 */
> +			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F16) MCU_OSPI0_D1 */
> +			J721S2_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (G15) MCU_OSPI0_D2 */
> +			J721S2_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (F18) MCU_OSPI0_D3 */
> +			J721S2_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (E19) MCU_OSPI0_D4 */
> +			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (G19) MCU_OSPI0_D5 */
> +			J721S2_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (F19) MCU_OSPI0_D6 */
> +			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (F20) MCU_OSPI0_D7 */
> +			J721S2_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (E18) MCU_OSPI0_DQS */
> +		>;
> +	};
> +};
> +
>  &wkup_pmx2 {
>  	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
>  		pinctrl-single,pins = <
> @@ -152,6 +170,66 @@ eeprom@51 {
>  	};
>  };
>  
> +&ospi0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
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
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "ospi.tiboot3";
> +				reg = <0x0 0x80000>;

Should this be 1MB similar to comment at [0]

[0] lore.kernel.org/r/0ca01a1b-8956-40dd-8286-77276e021633@ti.com

> +			};
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
> +};
> +
>  &mailbox0_cluster0 {
>  	status = "okay";
>  	interrupts = <436>;

-- 
Regards
Vignesh

