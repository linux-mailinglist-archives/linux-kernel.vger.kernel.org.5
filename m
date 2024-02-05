Return-Path: <linux-kernel+bounces-52842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA75F849D57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F65285FD5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543D02C1B6;
	Mon,  5 Feb 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sgd3G2f1"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A452C19D;
	Mon,  5 Feb 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144420; cv=none; b=Z9tlT0CtuZoy/zvBzbQuqFqbcYL9M0eB/T/FTGcKe8/iXbTMHUeTKPdl70Um/QW7Iau2dXdGzE7mjDAtmMDCYnGUYWOtxS+q5uBgDXcX66rmu/2X0sEtslJM2fh8T3enEeTzMq/pYbNMdH3BD4S/cUydXm1wWDvay73YVAesjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144420; c=relaxed/simple;
	bh=RuhvQqkz4t4ZdWp0fNV6yhtTJAtgHuV8Q5cF4yHcQ/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TKzTiiDx280m1ASlDsxKX2H0124CCvZrIYTJrP7fxNMLWDz05QBEcAQalviwBRRO9eATCG+5dIgC9mFxpHcEejE/OcHxfk7sfvfUMyNExfJ1XtGGHBdw/468cKBpBw5nmwYNVnnNuHp9IXgJa9Vg9GZtLxFMky84RNIQyqR1ZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sgd3G2f1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415EkoNM008786;
	Mon, 5 Feb 2024 08:46:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707144410;
	bh=iF284FyUeVxadvjVZisJfXOxrSnv87VNkZrtaEyD0CY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Sgd3G2f1IWr3lYh5AInvtLgIzEQVkKtxn6NltcK00j1g8POZNvfLnXoiQSRb6UQj2
	 uUHXZUkQ0dxhjAa1KvYz0jyolQP4gisIVl6S0GxC06AGmMELKG8CB3sP/+mXjNL4df
	 oe+Km5gnk9yMEaIBPq+4WcRcTGqojmt3EpdtOkYE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415Ekoh4019648
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 08:46:50 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 08:46:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 08:46:50 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415EkkLc111910;
	Mon, 5 Feb 2024 08:46:47 -0600
Message-ID: <547d7069-3457-4ee3-ad1c-fedc9db5da62@ti.com>
Date: Mon, 5 Feb 2024 20:16:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: Add DT overlay for PCIe + USB3.0
 SERDES personality card
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>
CC: <afd@ti.com>, <a-bhatia1@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@ti.com>
References: <20240126114530.40913-1-rogerq@kernel.org>
 <20240126114530.40913-4-rogerq@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240126114530.40913-4-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 26/01/24 17:15, Roger Quadros wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 

[...]

>  # Boards with J7200 SoC
>  k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
> new file mode 100644
> index 000000000000..c63b7241c005
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/**
> + * DT overlay for SERDES personality card: 1lane PCIe + USB3.0 DRD on AM654 EVM
> + *
> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-am654-serdes.h>
> +
> +#include "k3-pinctrl.h"
> +
> +&serdes1 {
> +	status = "okay";
> +};
> +
> +&pcie1_rc {
> +	num-lanes = <1>;
> +	phys = <&serdes1 PHY_TYPE_PCIE 0>;
> +	phy-names = "pcie-phy0";
> +	reset-gpios = <&pca9555 5 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&pcie1_ep {
> +	num-lanes = <1>;
> +	phys = <&serdes1 PHY_TYPE_PCIE 0>;
> +	phy-names = "pcie-phy0";
> +};
> +
> +&main_pmx0 {
> +	usb0_pins_default: usb0_pins_default {

No underscores in node-name and also should end with -pins

> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
> +		>;
> +	};
> +};
> +
> +&serdes0 {
> +	status = "okay";
> +	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
> +	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
> +	assigned-clock-parents = <&k3_clks 151 4>,      /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
> +	<&k3_clks 151 8>;      /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
> +	phys = <&serdes0 PHY_TYPE_USB3 0>;
> +	phy-names = "usb3-phy";
> +};
> +
> +&usb0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_pins_default>;
> +	dr_mode = "host";
> +	maximum-speed = "super-speed";
> +	snps,dis-u1-entry-quirk;
> +	snps,dis-u2-entry-quirk;
> +};
> +
> +&usb0_phy {
> +	status = "okay";
> +};


BTW, this breaks build on 6.8-rc1


  DTOVL   arch/arm64/boot/dts/ti/k3-am654-gp-evm.dtb

Failed to apply 'arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtbo': FDT_ERR_NOTFOUND


-- 
Regards
Vignesh

