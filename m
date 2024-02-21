Return-Path: <linux-kernel+bounces-75142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911D85E3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF6F1F253FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FAC8120C;
	Wed, 21 Feb 2024 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cuVz+nsr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCE82D7B;
	Wed, 21 Feb 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534406; cv=none; b=PH9RmglEpdbGV2Q+DHotdLhscjtJ5PFL9hxukADrNL7Rrq+gXB8IsCpQS6dC/7ORUsdL5rymV+fSCJhOK07DDigq/a4yUwyPdc8H0avsVVxrBye8dKOiPbvvibMJj6p2K6IHpb+DiaqDGtnFSDWpJt/ylvsnx3Imvo9K4Iv8BWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534406; c=relaxed/simple;
	bh=TTQ1doLzdpWsvm11itbyYFS24byaEDHmKqetfhZEnrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W+twxQzTQQOInXz/g8fwTVu8wbW4VTHtThEodpGx5BZPel9HsSinnuAK0mNj3iWglnSxaQfEh0Y75laJBBfX76ncOeIYnGL1a6/todrTUiA0LAuQZmsL40lAQZgHUvDscThtHk1wWHm0i9equx3FSiUWb8l3ZpV1Blb0nz+R4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cuVz+nsr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41LGrF5c111758;
	Wed, 21 Feb 2024 10:53:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708534395;
	bh=N52cOwBX2hZh18Hr3wGyow7igCwW2LIHlxO5yXnuMQY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cuVz+nsrDulnWjzObnBSTJUUH4YrZajGs/l+5hXj2D6MBrKhoO5Op/u5rTf0prhk3
	 KCfksj76ku9WZu1s+tZPmEqsUD66F7wJLTQArxt9Wn9FVZaDhjFkRt5fYBaJ/mAvP7
	 BJcWK1xr3dMPOBHuYKd39DwXOLsi1nqGnE/09hO4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41LGrFwd051916
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Feb 2024 10:53:15 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Feb 2024 10:53:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Feb 2024 10:53:15 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41LGrEm6040094;
	Wed, 21 Feb 2024 10:53:14 -0600
Message-ID: <415ee6d4-fe26-4582-80f3-9b503d308fdf@ti.com>
Date: Wed, 21 Feb 2024 10:53:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-evm-pcie0-ep: Extend overlay for
 PCIE1 in EP Mode
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240220105006.1056824-1-s-vadapalli@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240220105006.1056824-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/20/24 4:50 AM, Siddharth Vadapalli wrote:
> Update the existing overlay which configures PCIE0 instance of PCIe on
> J721E-EVM in Endpoint mode of operation, in order to configure PCIE1
> instance of PCIe as well in Endpoint mode of operation. Hence, change the
> name of the overlay to reflect its updated functionality.
> 

What if I only want PCIe0 to be in EP mode? Why not make a separate
DTBO for PCIe1, that way I can have one in EP and the other in RC,
and mix and match as needed.

Andrew

> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20240220.
> 
> Regards,
> Siddharth.
> 
>   arch/arm64/boot/dts/ti/Makefile               |  8 ++---
>   ....dtso => k3-j721e-evm-pcie0-pcie1-ep.dtso} | 30 +++++++++++++++++--
>   2 files changed, 32 insertions(+), 6 deletions(-)
>   rename arch/arm64/boot/dts/ti/{k3-j721e-evm-pcie0-ep.dtso => k3-j721e-evm-pcie0-pcie1-ep.dtso} (60%)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index d601c52ab181..c7c9508e3980 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -75,7 +75,7 @@ k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb k3-j721e-evm-quad-port-eth-e
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
> -dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-pcie1-ep.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk-csi2-dual-imx219.dtbo
>   
> @@ -126,8 +126,8 @@ k3-am68-sk-base-board-csi2-dual-imx219-dtbs := k3-am68-sk-base-board.dtb \
>   	k3-j721e-sk-csi2-dual-imx219.dtbo
>   k3-am69-sk-csi2-dual-imx219-dtbs := k3-am69-sk.dtb \
>   	k3-j721e-sk-csi2-dual-imx219.dtbo
> -k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
> -	k3-j721e-evm-pcie0-ep.dtbo
> +k3-j721e-evm-pcie0-pcie1-ep-dtbs := k3-j721e-common-proc-board.dtb \
> +	k3-j721e-evm-pcie0-pcie1-ep.dtbo
>   k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
>   	k3-j721e-sk-csi2-dual-imx219.dtbo
>   k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
> @@ -147,7 +147,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>   	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
>   	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
>   	k3-am69-sk-csi2-dual-imx219-dtbs \
> -	k3-j721e-evm-pcie0-ep.dtb \
> +	k3-j721e-evm-pcie0-pcie1-ep.dtb \
>   	k3-j721e-sk-csi2-dual-imx219-dtbs \
>   	k3-j721s2-evm-pcie1-ep.dtb
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-pcie1-ep.dtso
> similarity index 60%
> rename from arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
> rename to arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-pcie1-ep.dtso
> index 4062709d6579..5eaf304e3102 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-pcie1-ep.dtso
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /**
> - * DT Overlay for enabling PCIE0 instance in Endpoint Configuration with the
> - * J7 common processor board.
> + * DT Overlay for enabling PCIE0 and PCIE1 instances in Endpoint Configuration
> + * with the J7 common processor board.
>    *
>    * J7 Common Processor Board Product Link: https://www.ti.com/tool/J721EXCPXEVM
>    *
> @@ -24,6 +24,10 @@ &pcie0_rc {
>   	status = "disabled";
>   };
>   
> +&pcie1_rc {
> +	status = "disabled";
> +};
> +
>   &cbass_main {
>   	#address-cells = <2>;
>   	#size-cells = <2>;
> @@ -50,4 +54,26 @@ pcie0_ep: pcie-ep@2900000 {
>   		phys = <&serdes0_pcie_link>;
>   		phy-names = "pcie-phy";
>   	};
> +
> +	pcie1_ep: pcie-ep@2910000 {
> +		compatible = "ti,j721e-pcie-ep";
> +		reg = <0x00 0x02910000 0x00 0x1000>,
> +		      <0x00 0x02917000 0x00 0x400>,
> +		      <0x00 0x0d800000 0x00 0x00800000>,
> +		      <0x00 0x18000000 0x00 0x08000000>;
> +		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
> +		interrupt-names = "link_state";
> +		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
> +		max-link-speed = <3>;
> +		num-lanes = <2>;
> +		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 240 1>;
> +		clock-names = "fck";
> +		max-functions = /bits/ 8 <6>;
> +		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
> +		dma-coherent;
> +		phys = <&serdes1_pcie_link>;
> +		phy-names = "pcie-phy";
> +	};
>   };

