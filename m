Return-Path: <linux-kernel+bounces-71513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB76D85A674
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B05283774
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75EC37701;
	Mon, 19 Feb 2024 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ncLqtjTZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347E37141;
	Mon, 19 Feb 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354376; cv=none; b=EGUUrvi0YSIHVgDV7L1YPjmmlQf2+LKuzZNzc2TNoaw4qOUsXQ+jtH3OfPhXVjoEez90DlWNdsq82rdX6CSPF26vtvwyZzlDYkyO32QVDGzNuruyr2S9Lafkaus8Cdi/F3FxDj82l21kOMJGcIQCxeuJyG8jGM7SBhlTECyLJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354376; c=relaxed/simple;
	bh=ZlRNDV84m3/OQcjHrnNbDqMZPVxR9wQ6CGgRBMtzN2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ads5IH/bCAPKpFIbsKgl7ADGKcWoWY8Gy/5rYVHJyw1o2COIw3iLQ3/2Rhna0Bw1igLo9udVzCOW/DgWEK7rp0uRxlBj0XNpwg+CrQmQ8miYxmdcHL2ygUgFnJTUc/hNrBUG/CoiYwgcefEYfnjWXrHDq/26f0OJOWcBbXMGRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ncLqtjTZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41JEqioG059731;
	Mon, 19 Feb 2024 08:52:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708354365;
	bh=cTeNPPUiHyloiQJwO1KCVRZMjmcyOZitwPbdjibYJyI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ncLqtjTZsr+2+EH88zJHKjHOmnKRcbRnpFnKDOZSEHNaiT4dFq3xE+7wvTsJqvQB2
	 JRzJJdGLLbWRTF7xrdE5B+HtkYF75xPrScNE0OduX9I7zPemeWbxwRncP0FEW76wUb
	 VD5pMAUzUFUzZ2jaRBM7s7+x3JfF/s+MvhgC3mgY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41JEqiTI007663
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 08:52:44 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 08:52:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 08:52:44 -0600
Received: from [10.250.151.109] ([10.250.151.109])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41JEqdci106044;
	Mon, 19 Feb 2024 08:52:40 -0600
Message-ID: <f4bb70f1-be4b-46d4-8e47-bf1bbc1c3ae6@ti.com>
Date: Mon, 19 Feb 2024 20:22:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH V2 2/2] arm64: dts: ti: k3-am69-sk: Add support for
 OSPI flash
Content-Language: en-US
To: <sabiya.d@mistralsolutions.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya <sabiya.d@ti.com>
References: <20240219111422.171315-1-sabiya.d@ti.com>
 <20240219111422.171315-3-sabiya.d@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240219111422.171315-3-sabiya.d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/19/2024 4:44 PM, sabiya.d@mistralsolutions.com wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
>
> AM69 SK has S28HS512T OSPI flash connected to MCU OSPI0.
> Enable support for the same. Also describe the partition
> information according to the offsets in the bootloader.
>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 81 +++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index 0ff4d1623cf4..acda25a9e814 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -471,6 +471,25 @@ J784S4_IOPAD(0x09C, PIN_OUTPUT, 0) /* (AF35) MCAN7_TX */
>   	};
>   };
>   
> +&wkup_pmx0 {
> +	bootph-all;
> +	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
> +			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
> +			J784S4_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B33) MCU_OSPI0_D0 */
> +			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B32) MCU_OSPI0_D1 */
> +			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (C33) MCU_OSPI0_D2 */
> +			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (C35) MCU_OSPI0_D3 */
> +			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D33) MCU_OSPI0_D4 */
> +			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
> +			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
> +			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
> +			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
> +		>;
> +	};
> +};
> +
>   &wkup_pmx2 {
>   	bootph-all;
>   	pmic_irq_pins_default: pmic-irq-default-pins {
> @@ -1070,3 +1089,65 @@ &main_mcan7 {
>   	pinctrl-0 = <&main_mcan7_pins_default>;
>   	phys = <&transceiver4>;
>   };
> +
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
> +			bootph-all;
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "ospi.tiboot3";
> +				reg = <0x0 0x80000>;
> +			};


Recent update around u-boot shows, 512K is not sufficient for tiboot3.

Please consider to make it 1MB

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
> +				bootph-pre-ram;
> +				label = "ospi.phypattern";
> +				reg = <0x3fc0000 0x40000>;
> +			};
> +		};
> +	};
> +};

