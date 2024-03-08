Return-Path: <linux-kernel+bounces-96634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A048875F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B97282661
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A57B50A9D;
	Fri,  8 Mar 2024 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zGqzObWI"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A550A6B;
	Fri,  8 Mar 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885468; cv=none; b=FC9aMQbk6IIqubd0Ipc/1+Ys9psbiwik9apQLhKysa+QjUEOU0EjbYBvRogKCCtzBgmE7d8XfjhIyPEbR5BXXLxjG+fH8Bzt7VYNFaQ8iEey7SEAlym5RzGNx+hi/ixbv03zm/akP05LH4RXHz8I5nrrRXcBq7iMgDphh4x01Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885468; c=relaxed/simple;
	bh=azvXjbqOy9RcR5PVyxuvJYdzxJhKP1d/eIAG7xygbtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dyitRCESPNOxnETHIs6EKg72uJIzMVAQD5pnov+BJ8PU9JjQwIm7bhq+PNCdxt5JnwB2IoTS0x7TN00ZQSS3RrtrDa9iU2JOpq4YuAbDuLNKMif087FKxbtmTo/vKN7P3JCv5tnuX4DJEVozupUj+NQ2HsrVSl41KPSvr/0Y+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zGqzObWI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4288Asj7060202;
	Fri, 8 Mar 2024 02:10:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709885454;
	bh=G2l3/k6t8Rzejj2TsUUYEtxEjPBCHJVZwIzgx1QUZLA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=zGqzObWIHxcYJ8qFN0lBD2Gbe3MoAwnvrJmELKN7G1x1ACiYAkvRmyqh1qQ9n8GKl
	 8QskXp/LVdYyp7eDaag8EFfabhLE6HK0warxfYEQSbfCaUOgolNIci+96Gx7Mpts/a
	 1mwzP9mY+xx9YBTX4LJmdhOAn5NgHpRiwsM0CSBg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4288As1i011124
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Mar 2024 02:10:54 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Mar 2024 02:10:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Mar 2024 02:10:54 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4288AoZV066587;
	Fri, 8 Mar 2024 02:10:51 -0600
Message-ID: <e7320b4c-d6c3-4164-a39b-d77c9ebcc7b7@ti.com>
Date: Fri, 8 Mar 2024 13:40:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: ti: k3-am68-sk-som: Add support for OSPI
 flash
To: Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinthu Raja <sinthu.raja@ti.com>
References: <20240226095231.35684-1-sinthu.raja@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240226095231.35684-1-sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Sinthu,

On 2/26/2024 3:22 PM, Sinthu Raja wrote:
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
> Changes in V3:
> Address review comments:
>     a. Fix the make dtbs_check error related to ospi pinctrl
>     b. Increase the partition 0 size to 1MB and update the following
> partitions start address accordingly.
>
> V2: https://lore.kernel.org/linux-arm-kernel/20240219075932.6458-1-sinthu.raja@ti.com/
>
>   arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 78 ++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> index 0f4a5da0ebc4..d3e869c250a2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> @@ -130,6 +130,24 @@ rtos_ipc_memory_region: ipc-memories@a8000000 {
>   	};
>   };
>   
> +&wkup_pmx0 {
> +	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins {
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


I see there is one pin SOC_MCU_OSPI0_INT# connected over F17 GPIO.

Please suggest, if this is being used ?

> +		>;
> +	};
> +};
> +
>   &wkup_pmx2 {
>   	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
>   		pinctrl-single,pins = <
> @@ -152,6 +170,66 @@ eeprom@51 {
>   	};
>   };
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
> +				reg = <0x0 0x100000>;
> +			};
> +
> +			partition@100000 {
> +				label = "ospi.tispl";
> +				reg = <0x100000 0x200000>;
> +			};
> +
> +			partition@300000 {
> +				label = "ospi.u-boot";
> +				reg = <0x300000 0x400000>;
> +			};
> +
> +			partition@700000 {
> +				label = "ospi.env";
> +				reg = <0x700000 0x40000>;
> +			};
> +
> +			partition@740000 {
> +				label = "ospi.env.backup";
> +				reg = <0x740000 0x40000>;
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
>   &mailbox0_cluster0 {
>   	status = "okay";
>   	interrupts = <436>;

