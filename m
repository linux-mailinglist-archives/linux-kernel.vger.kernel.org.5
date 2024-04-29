Return-Path: <linux-kernel+bounces-161763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7AA8B50E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CD01F22025
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64208EAFA;
	Mon, 29 Apr 2024 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DYF5Fa3p"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B2F4EE;
	Mon, 29 Apr 2024 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370331; cv=none; b=G/AGBMc0p1c1YR4zSy2hJcsdo8YC8XFyCEO/zOIqa78PpAiP0oZI94M7F0Rr9oUT0RI+eMukZsXYtsZwnVrouB18OoGKRaDwTDh1GGWMGrGNafuRH9rjKmxMg8h8I3UaFS6J+ZQhH1w/uAdYiCsvz5OqdZuPd400hrPmwd8X8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370331; c=relaxed/simple;
	bh=e1P8tGa6IFpA81KoEGzB1eIGcS4THl82BNUlm40/2GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iZkBsAzMcOOGO5gbmHCXo9GfE1Fh3D/UT8DiBAo6+5Kd6sa4fP/k1B1C1WpeJugs4TzMpYAWPvDnVM4ldGzVAoTcUnNvZBUehjoGv0Spxza/Uh3SH6qpjNGi/eRbUV2ytGiQd41ybKCMvKzmvbxqEL+PHBICgWDqzXTCNUL/III=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DYF5Fa3p; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T5wYF0072429;
	Mon, 29 Apr 2024 00:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714370314;
	bh=/S14Cs9r0Kc9xNHZTnf7vdOEmagLCFWKsUwxz+NjGuk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DYF5Fa3p/Hg8Lnow+Q2LYfNOOFuWsQfoCf9ZWSi8irqIn0MEok09bH0Kdjwn8xOBu
	 Mwd5k39MbF2oATfgBg9QEV70mIsfRwntE9Mo6osMKFihR2RZ8HcjmlLemun2WPmrFH
	 TfASB7Wovx4hpEdUo9OdNqIbGETO/hzWSoURc1U8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T5wYul114455
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 00:58:34 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 00:58:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 00:58:34 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T5wUp5036283;
	Mon, 29 Apr 2024 00:58:31 -0500
Message-ID: <c9a3cce8-c122-c9d2-37ae-1deb01acaec9@ti.com>
Date: Mon, 29 Apr 2024 11:28:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm-icssg1-dualemac: add overlay
 for mii mode
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Ravi Gunasekaran
	<r-gunasekaran@ti.com>
References: <20240423090028.1311635-1-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240423090028.1311635-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/23/24 2:30 PM, MD Danish Anwar wrote:
> Add device tree overlay to enable both ICSSG1 ports available on AM64x-EVM
> in MII mode.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> NOTE: This patch depends on [1]. Without [1] mii mode will not work for
> ICSSG. Patch [1] is currently posted to net subsystem.
> 
> This patch is based on next-20240423 linux-next tag.
> 
> [1] https://lore.kernel.org/all/20240423084828.1309294-1-danishanwar@ti.com/
> 
>  arch/arm64/boot/dts/ti/Makefile               |   4 +
>  .../ti/k3-am642-evm-icssg1-dualemac-mii.dtso  | 101 ++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso
> 

[...]

> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso
> new file mode 100644
> index 000000000000..3081b5c64886
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0

Please update the license to "GPL-2.0-only OR MIT"

> +/**
> + * DT overlay for enabling both ICSSG1 port on AM642 EVM in MII mode
> + *
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	aliases {
> +		ethernet1 = "/icssg1-eth/ethernet-ports/port@1";
> +	};
> +
> +	mdio-mux-2 {
> +		compatible = "mdio-mux-multiplexer";
> +		mux-controls = <&mdio_mux>;
> +		mdio-parent-bus = <&icssg1_mdio>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		mdio@0 {
> +			reg = <0x0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			icssg1_phy2: ethernet-phy@3 {
> +				reg = <3>;
> +			};
> +		};
> +	};
> +};
> +
> +&main_pmx0 {
> +	icssg1_mii1_pins_default: icssg1-mii1-default-pins {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x00f8, PIN_INPUT, 1) /* (V9) PRG1_PRU0_GPO16.PR1_MII_MT0_CLK */
> +			AM64X_IOPAD(0x00f4, PIN_OUTPUT, 0) /* (Y9) PRG1_PRU0_GPO15.PR1_MII0_TXEN */
> +			AM64X_IOPAD(0x00f0, PIN_OUTPUT, 0) /* (AA9) PRG1_PRU0_GPO14.PR1_MII0_TXD3 */
> +			AM64X_IOPAD(0x00ec, PIN_OUTPUT, 0) /* (W9) PRG1_PRU0_GPO13.PR1_MII0_TXD2 */
> +			AM64X_IOPAD(0x00e8, PIN_OUTPUT, 0) /* (U9) PRG1_PRU0_GPO12.PR1_MII0_TXD1 */
> +			AM64X_IOPAD(0x00e4, PIN_OUTPUT, 0) /* (AA8) PRG1_PRU0_GPO11.PR1_MII0_TXD0 */
> +			AM64X_IOPAD(0x00c8, PIN_INPUT, 1) /* (Y8) PRG1_PRU0_GPO4.PR1_MII0_RXDV */
> +			AM64X_IOPAD(0x00d0, PIN_INPUT, 1) /* (AA7) PRG1_PRU0_GPO6.PR1_MII_MR0_CLK */
> +			AM64X_IOPAD(0x00c4, PIN_INPUT, 1) /* (V8) PRG1_PRU0_GPO3.PR1_MII0_RXD3 */
> +			AM64X_IOPAD(0x00c0, PIN_INPUT, 1) /* (W8) PRG1_PRU0_GPO2.PR1_MII0_RXD2 */
> +			AM64X_IOPAD(0x00cc, PIN_INPUT, 1) /* (V13) PRG1_PRU0_GPO5.PR1_MII0_RXER */
> +			AM64X_IOPAD(0x00bc, PIN_INPUT, 1) /* (U8) PRG1_PRU0_GPO1.PR1_MII0_RXD1 */
> +			AM64X_IOPAD(0x00b8, PIN_INPUT, 1) /* (Y7) PRG1_PRU0_GPO0.PR1_MII0_RXD0 */
> +			AM64X_IOPAD(0x00d8, PIN_INPUT, 1) /* (W13) PRG1_PRU0_GPO8.PR1_MII0_RXLINK */
> +		>;
> +	};
> +
> +	icssg1_mii2_pins_default: icssg1-mii2-default-pins {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0148, PIN_INPUT, 1) /* (Y10) PRG1_PRU1_GPO16.PR1_MII_MT1_CLK */
> +			AM64X_IOPAD(0x0144, PIN_OUTPUT, 0) /* (Y11) PRG1_PRU1_GPO15.PR1_MII1_TXEN */
> +			AM64X_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AA11) PRG1_PRU1_GPO14.PR1_MII1_TXD3 */
> +			AM64X_IOPAD(0x013c, PIN_OUTPUT, 0) /* (U10) PRG1_PRU1_GPO13.PR1_MII1_TXD2 */
> +			AM64X_IOPAD(0x0138, PIN_OUTPUT, 0) /* (V10) PRG1_PRU1_GPO12.PR1_MII1_TXD1 */
> +			AM64X_IOPAD(0x0134, PIN_OUTPUT, 0) /* (AA10) PRG1_PRU1_GPO11.PR1_MII1_TXD0 */
> +			AM64X_IOPAD(0x0118, PIN_INPUT, 1) /* (W12) PRG1_PRU1_GPO4.PR1_MII1_RXDV */
> +			AM64X_IOPAD(0x0120, PIN_INPUT, 1) /* (U11) PRG1_PRU1_GPO6.PR1_MII_MR1_CLK */
> +			AM64X_IOPAD(0x0114, PIN_INPUT, 1) /* (Y12) PRG1_PRU1_GPO3.PR1_MII1_RXD3 */
> +			AM64X_IOPAD(0x0110, PIN_INPUT, 1) /* (AA12) PRG1_PRU1_GPO2.PR1_MII1_RXD2 */
> +			AM64X_IOPAD(0x011c, PIN_INPUT, 1) /* (AA13) PRG1_PRU1_GPO5.PR1_MII1_RXER */
> +			AM64X_IOPAD(0x010c, PIN_INPUT, 1) /* (V11) PRG1_PRU1_GPO1.PR1_MII1_RXD1 */
> +			AM64X_IOPAD(0x0108, PIN_INPUT, 1) /* (W11) PRG1_PRU1_GPO0.PR1_MII1_RXD0 */
> +			AM64X_IOPAD(0x0128, PIN_INPUT, 1) /* (U12) PRG1_PRU1_GPO8.PR1_MII1_RXLINK */
> +		>;
> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-0 = <&rgmii1_pins_default>;
> +};
> +
> +&cpsw_port2 {
> +	status = "disabled";
> +};
> +
> +&mdio_mux_1 {
> +	status = "disabled";
> +};
> +
> +&icssg1_eth {
> +	pinctrl-0 = <&icssg1_mii1_pins_default &icssg1_mii2_pins_default>;
> +};
> +
> +&icssg1_emac0 {
> +	phy-mode = "mii";
> +};
> +
> +&icssg1_emac1 {
> +	status = "okay";
> +	phy-handle = <&icssg1_phy2>;
> +	phy-mode = "mii";
> +};

-- 
Regards,
Ravi

