Return-Path: <linux-kernel+bounces-102756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D27287B6EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1D01C20E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386F153BE;
	Thu, 14 Mar 2024 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qskep9QL"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C314C96;
	Thu, 14 Mar 2024 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710387830; cv=fail; b=KQz5kMNmPcJX6EOkyjThvrv2Zq5N0CHWmeHP6eK2VxWJiRDkdZ10OQNR6A19NNxzDyexePipvKzJbEoMBANqBKd5sA5mzNR2+wapGjGq1TFbdLj6Z0KlnR4T9EaO5EC0HYmiJsTFGO5FvLwH+JULH26QBBbEYz4ItacbvvHNdRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710387830; c=relaxed/simple;
	bh=/xCETYQ4JzCKnur52p/SJNiOdamFJhhiwf1pElt+mao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GnINA4M02wC1v88QrfhSaCW5SQ4qTyz9cMiyducMhaDk82iFwi4jEQ4I93KPqEus30kJbVek2E9TVVoe3na5THQiAZdoUV3SDu0NRI6Xwu0XDfa8QTyegKCKSN4uqxV7Pvi9XBeWW0DFEmiHQaIEhM9Zk1G7hR5LqhE67k94DRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qskep9QL; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVTyf6M0nS7SFPrF22u0wVIpBlk/uXOUYaoaDjn3Y+MKe/X/nk7/RzJlY0C/budpe+5EbaZFwFv3SWKZ3E0DCv1WNeDHsna6pWREnFWyV5ose03p/dvgqpj+mBqRDIkfFzCKhOZxl5dzf7ROWB7dc7eRHSdxlpF14DOZdQvcQEDVIl9iSHzr6dBEQopQnd92Xwc/9BUl2FIAEjfWJwCZEBiseKDFUsuFMzDV5XKhJ8fCx2tRpow1yGm3BJqkff2Ux/EPwjkMahM7lKDSGAcGpL9d87hw3MizPznidgRdn7+7KbMcc1+WblX+h2cscewJvzRpjYrDAo2oN3hxxhSoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRhTtl1kujxQ5cn0hIuPRoQlV8XvD0CUzsjDA/oNW3I=;
 b=jzHtzVjpyhL6a4NKw0ZkEtjBY/MBCbA62m+IwD5Qa/UD5SlOWrzm7lf4BXLR0+WX8gGRPUzi5NM0gxVd9XqC2NPt02oPRWZ0sMf2uAu2pI7oxUoWckGP2w3V+ROrnpv/ajKm61pXzEocYpD/raKkrosVpNiBbX2BCx38THqljEi3zwIJqptzUIBnF0JyQsFXQ0x/n0N8kN6HQ7w0IMqiGGICdDQh2ZoBrLzIKBcN2uhtTRw2Je3lqEBSu/2cmgXzWlBKYlB2kzTjUjfxvlqq/+973/RKtN2okWCwtaPh6Lla89Js4C6phVO3wOuaKU1Dml9sXKMXgu9tYo8XXJ6eJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRhTtl1kujxQ5cn0hIuPRoQlV8XvD0CUzsjDA/oNW3I=;
 b=qskep9QLnMNsbgERvvMLd73jVXJgv9RpeacMIuw2rR+z2Hmph+7mNz6nz1wfjLpqaWasAe4U8/6aelPS1GueHJGLm1wn/xuz7vB8vSfCZ5zNzj6yJTId5Xq5gug/fjLYi4yR3XyIZh7zltWLr46mP+IJjMbCrtEQNaBfHxykYfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8343.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 03:43:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 03:43:45 +0000
Date: Wed, 13 Mar 2024 23:43:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: ping.bai@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Message-ID: <ZfJyaFUxwMq20XMd@lizhi-Precision-Tower-5810>
References: <20240314032923.2360248-1-joy.zou@nxp.com>
 <20240314032923.2360248-4-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314032923.2360248-4-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6e2899-15a9-4bd8-7d17-08dc43d8f2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uaNCradKUnHVYJH4fzIvXE8ABRpGl+LMafzTjDJV7fbPf8Oipy/wvwKpCNWbm44SyUTDIKGLkWpfs93sd++pYdQ5ymrGb07CzAAYHLdHzLo9MndeJnmmAfB0PXyG+zYXm9RVFATKjRx7GdkwB8E7AWFLpGB0/0BIrHpSnIVV3v9EcYiRjAvsCN8JBeIdur2dDesQWH+sJxP69s5luyGtb95ovvuorbHrGIch4MKNjEjIbT/waRs8aI8cJ1XJ5C2fsLtmh6+ET9SiJxoJRExJdkZj1M3R0wcF8/2RuK+STwcZsveGTpCCLz9dmUdv7XsfBOo/RmjUrYuPwZA/UVTGXKCoZQi1CYbW73XiOpfwTo9jZAM4vnlZzECyxzl2N37neGruQlUYskLxWSo3MuWVxKPQRvSE74F3zRhNiGs8u6YSVkOgrEb6KHCBvO+eOj9QDVqA+z3pXBk5EiLnfrZDflFl0TGi+GQiv6eaN60cYz5xR94p9k2qsvncPyjHzrRSYKyVMl2q96sE9779GpXjyYPRNfGAMB9FDMjIZT5CfCEhOL7H9qd1blK6vbJPpQxoqZ2dPz4ObQYcgyG9ukGUtsEyv/u2iX3v0CChepFgkCAdJJ26Vy5cV3GC5c/8/2zqMsWwA0qes6sQTt0W0SBCKBq8vqsHLvPaP1bORIVDZ8rhuY3xRJH6nDJATJ1FwvNeMU42Nm23JdRbq+buoFcn6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SnPJFi+rmuFegNtxhKx6nmmeyRbqfnMC/bJZsItdsH3DSjt9OXLuKTWeIPoa?=
 =?us-ascii?Q?slLPXfiWI4PLaD3xNuq8wlNmtiPw8bhARPoPC7XE9kWOQN/foog7AWc+AaxE?=
 =?us-ascii?Q?7BPine+T0ISBvRMwhcFS0jrDQAbS413l5EjaVbbmCCQNA1T40wA9RJW4JnQQ?=
 =?us-ascii?Q?5jgLcrB2EKaU4HMd+uM1dDycrPUwv0wsj4z4B1xgDw8NU0ba7qxdwiM6K75U?=
 =?us-ascii?Q?ZpdYYyO0LtaRdaO+gh8KbEDu7MNYo8/gbZU9Cuu63cFMINCDWwaYajKtJSiA?=
 =?us-ascii?Q?9gMCoXVNWgqJviVLoGMb0TZLRZEkKiii4RyWP6CToInTNbpeQbuGrlLjvMBz?=
 =?us-ascii?Q?7k92VZbc9MvwL5+2yFnJfHStS1U31VKiyLNLPFOjudpkiBTcXAl914toiyqT?=
 =?us-ascii?Q?+bIgB1J6lKL6vWNF0W7kuDuOEpLJy6NjwcbLIVRZYgflBo48RY9SEZVckZxY?=
 =?us-ascii?Q?hpiKnBhDacdsvkq95LFlNVZfuMvcGjToepAId2KOxk6XAHQL1+S8x1mTXtUN?=
 =?us-ascii?Q?Q07f+RtlRMC7BjtGOUCoTijQUq9g4evhd6IYInyBUF0f0JZ3Bk1IxJB0lfvA?=
 =?us-ascii?Q?LUv5oyeMW3K/TK2y96R6/PXHMpvKXmVK4T7/rkRDHZpgnhoAZgRRWRn6oge9?=
 =?us-ascii?Q?E9uY4KIVv9WJlyBiY+tpqJw3opoRNO4LcWsGVRt4z8us9DwgBgeiARJEs+SC?=
 =?us-ascii?Q?6HIXG7UjNLU65BwksfH/rx53v6yBx2G0pZdkzScCONw6Q85lYQyqB7TdjD4U?=
 =?us-ascii?Q?KAf2yfs3Udo8uFtrLH/WuLx8Yosl3ai84pqWvZYIXCF+8MyP/NgCvyfc5c6I?=
 =?us-ascii?Q?pfkMmry4XK1o163xPRA60nj389qB7hbgl5zZFOYhdzdY/1+sUWawsioqIER1?=
 =?us-ascii?Q?fXEzxJYal9KYyblg9qt+KhGkRC3TKZcHeUHiKBk8R/tzHi845GtsBt6nTjVd?=
 =?us-ascii?Q?gnxMu1oGBXQgK6HtDxCJLbI3Cbr5BVMKsKWtURgpcGPlXA8h5ZeHLyTcSd01?=
 =?us-ascii?Q?bOlDi3NZUOPnJ/pdI2pI1TANJFpcoHJHfH0osXg9AWdTjCqoWQUAV3oEOoR5?=
 =?us-ascii?Q?n/vFZQiegmcY5hdp9Xm5Jxegf33/P64Lix5JkJE94TbAU4FFdSiiwkjN6Ojr?=
 =?us-ascii?Q?SpZ6YaXSoXawBSxfNHjr3rszxJDkjRsyAqeEc0i/nQGBU4aoG1AKhF5TuKYO?=
 =?us-ascii?Q?jkT+5tFKgvD3afu/UPsjDELS4KxfG5H5N6TeT4nzasouevcawNcvapGBoyVw?=
 =?us-ascii?Q?RT06cpIaknq6eqbqKLDHOtnmJJsnuKglPCTUfAecenr8cg9EqRV3MhEM2vFh?=
 =?us-ascii?Q?lY1B7iRwGGC+BqKV7hwRxROjU45EFBvUN1HEQioAzXawk3nLYyq1igpS5IIS?=
 =?us-ascii?Q?qi0CrZ4AsmQo9UmwjURXkjgJL3qMWyc/cq8vTWC4ZjDbebGzOkqdJZYAlKFx?=
 =?us-ascii?Q?fFS1I6BQt3uP9kqBlXJVsW4ipsh0HIPEznc51VMeOVn5F9Vezx8iadvuy5r/?=
 =?us-ascii?Q?q4r/B0KKhU08hQUXbvi4tgYkZoXCuwgUX4QHJaC+/YrJWMt9W+Xl5A8KLONq?=
 =?us-ascii?Q?QRbcb8Tf8vu8+1gWkx2st+C/bSJ7U7vlP26asw3v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6e2899-15a9-4bd8-7d17-08dc43d8f2fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 03:43:44.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkmpIqvXxB/djWZ0aqrV71oCCB+0qpF3A2pClDVZavKodw+TlQE9UQIjSTnWF19/dh7mh55iV8eKmWtoaxvRKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8343

On Thu, Mar 14, 2024 at 11:29:23AM +0800, Joy Zou wrote:
> Support pca9451a on imx93-11x11-evk.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes in v4:
> 1. modify the comment for uSDHC but not i2c.
> 
> Changes in v3:
> 1. modify the voltages constraints according to the imx93 datasheet.
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 9921ea13ab48..59740dfa054c 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -183,6 +183,105 @@ &wdog3 {
>  	status = "okay";
>  };
>  
> +&lpi2c2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-1 = <&pinctrl_lpi2c2>;
> +	status = "okay";
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <610000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <670000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4{
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5{
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1060000>;
> +				regulator-max-microvolt = <1140000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <1980000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <840000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	pcal6524: gpio@22 {
> +		compatible = "nxp,pcal6524";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6524>;
> +		reg = <0x22>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +	};

It'd better order by address. gpio@22 should before pmic@25

Frank

> +};
> +
>  &iomuxc {
>  	pinctrl_eqos: eqosgrp {
>  		fsl,pins = <
> @@ -238,6 +337,19 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
>  		>;
>  	};
>  
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
> +			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_pcal6524: pcal6524grp {
> +		fsl,pins = <
> +			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
> +		>;
> +	};
> +
>  	/* need to config the SION for data and cmd pad, refer to ERR052021 */
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
> -- 
> 2.37.1
> 

