Return-Path: <linux-kernel+bounces-28584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B4830052
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83691C2242D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978CBC121;
	Wed, 17 Jan 2024 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="aNlV/R4E"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272BEBE65
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705474828; cv=none; b=EwrM6uu/dyQYosZqNYJUHa2rp7SWONJGDIKtdRZLMrnSPdZPXT5/ENGGtCpdJvCchqjLbGCE72XcGPBB7RrwoOFa+hyGRmtKyBUMDiYGpUoDwykzA0CUJASR9zQ0MiY4/ntVA2PVNMn+nUJ0aHgCDy0/7YHt4Q6ZBLD7AQGVfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705474828; c=relaxed/simple;
	bh=nSK+sieiq3qlk5c5O8Fpw7o5HheSCCiiovPA69sWmVU=;
	h=DKIM-Signature:X-AuditID:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:CC:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-Brightmail-Tracker; b=iKCyHypDB+p4Zf0n4vjert/f65thaPK+Xwvcwx8VbbhKRwPCCLzfiMLvlCddB+bD1/6Z2NZ8iD3sQwEMlqZnCNICeRqrhfeb+OJ5gRnWVymvFfGPAemfkLA1EWn8oBBPPy0EJFjOb5Uff5YFV6fe7n5dbTcAIJ3KZipkzADCPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=aNlV/R4E; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705474822; x=1708066822;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nSK+sieiq3qlk5c5O8Fpw7o5HheSCCiiovPA69sWmVU=;
	b=aNlV/R4E30WTyffGRYGVWSTIvLu+9JMl2THX+JqencAl35QuiM6054WOGb0w73cc
	L/v6Pv3KCl7f69byef1XTm+UYPTBncU77HLT5DYFkH+ujfD9z/hW+mha8ZtNSQcz
	8qKSovyxJPqvkv/vNx8RAFtRThWrh143eJvFOoUQKXA=;
X-AuditID: ac14000a-fbefe7000000290d-f7-65a77b065fe4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7C.6E.10509.60B77A56; Wed, 17 Jan 2024 08:00:22 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jan
 2024 08:00:17 +0100
Message-ID: <979d5a5e-f940-4a0f-a211-694292f15f24@phytec.de>
Date: Wed, 17 Jan 2024 08:00:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: imx93-phycore-segin: Add Phytec i.MX93
 Segin
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Li
 Yang <leoyang.li@nxp.com>, Stefan Wahren <wahrenst@gmx.net>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Christoph Stoidner
	<c.stoidner@phytec.de>, <upstream@lists.phytec.de>
References: <20240116113939.17339-1-othacehe@gnu.org>
 <20240116113939.17339-3-othacehe@gnu.org>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240116113939.17339-3-othacehe@gnu.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWyRpKBR5etenmqwbz/nBZr9p5jsph/5Byr
	xcOr/harpu5kseh78ZDZ4lDzASaLTY+vsVp0/VrJbHF51xw2i/N3tzBbtO49wm7xd/smFosX
	W8Qtut+pWxw/0cnswO+xc9Zddo/Fm/azebRNM/PYtKqTzePOtT1sHpuX1Hv0d7ewemx8t4PJ
	o/+vgcfnTXIBXFFcNimpOZllqUX6dglcGWvXLGAvuKZXcfjdHqYGxia1LkZODgkBE4nO7tmM
	XYxcHEICi5kkdj5exwzh3GWUWPryJFMXIwcHr4CNRPP8YpAGFgFVid5Pv9lAbF4BQYmTM5+w
	gNiiAvIS92/NYAexhQWCJf5u6AezmQXEJW49mc8EMlNEYCOzxNFd+9hAHGaBzYwSj87PBpsk
	JJAosf3xTbBJbALqEnc2fGMFsTkFzCSunHnJCjHJQmLxm4NQU+Ultr+dwwzRKy/x4tJyFoh3
	5CWmnXvNDGGHSmz9sp1pAqPwLCTHzkJy1CwkY2chGbuAkWUVo1BuZnJ2alFmtl5BRmVJarJe
	SuomRlDkijBw7WDsm+NxiJGJg/EQowQHs5IIr7/BslQh3pTEyqrUovz4otKc1OJDjNIcLEri
	vKs7glOFBNITS1KzU1MLUotgskwcnFINjEsOtkzKT7qTVFJ9SvOZl5XPA1kD458vHum2RHLy
	978Omb/tua16jZy2hkIx6/xc6RmLhY/ccrqtxanUv2mj7t/yWC5HsWNJPUu3uiUt3bmNo/Pz
	pM1RjJen28yfJb+4+NHclAMLozJ2vbDk366w2/PjxoB3xj8/5rlecX7+5rfh2p+XQ5Qajymx
	FGckGmoxFxUnAgClv5ywygIAAA==

Hi,

would be nice if you could include the author to CC.

CC'ing Christoph.

Regards,
Wadim

Am 16.01.24 um 12:39 schrieb Mathieu Othacehe:
> Add DTSI for Phytec i.MX93 System on Module and DTS for Phytec
> i.MX93 on Segin evaluation board.
>
> This version comes with:
>   - 1GB LPDDR4 RAM
>   - external SD
>   - debug UART
>   - 1x 100Mbit Ethernet
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   arch/arm64/boot/dts/freescale/Makefile        |  1 +
>   .../dts/freescale/imx93-phycore-segin.dts     | 93 +++++++++++++++++++
>   .../boot/dts/freescale/imx93-phycore-som.dtsi | 51 ++++++++++
>   3 files changed, 145 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
>   create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 2e027675d7bb..6cb6d9f8783e 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -203,6 +203,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx93-phycore-segin.dtb
>   
>   imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>   imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
> new file mode 100644
> index 000000000000..2277d97fc3c4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + */
> +/dts-v1/;
> +
> +#include "imx93-phycore-som.dtsi"
> +
> +/{
> +	model = "PHYTEC phyBOARD-Segin-i.MX93";
> +	compatible = "phytec,imx93-phycore-segin",
> +		     "phytec,imx93-phycore-som", "fsl,imx93";
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +/* Console */
> +&lpuart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +/* SD-Card */
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +	no-sdio;
> +	no-mmc;
> +};
> +
> +/* Watchdog */
> +&wdog3 {
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
> +			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_RESET_B__GPIO3_IO07		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00			0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK			0x178e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x139e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> new file mode 100644
> index 000000000000..7a9ff998a342
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + */
> +/dts-v1/;
> +
> +#include "imx93.dtsi"
> +
> +/{
> +	model = "PHYTEC phyCORE-i.MX93";
> +	compatible = "phytec,imx93-phycore-som", "fsl,imx93";
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +	};
> +};
> +
> +/* eMMC */
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1>;
> +	pinctrl-2 = <&pinctrl_usdhc1>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
> +		>;
> +	};
> +
> +};

