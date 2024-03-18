Return-Path: <linux-kernel+bounces-106522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9887EFD1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E07284675
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB49126297;
	Mon, 18 Mar 2024 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rBZCR0VH"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC501E89C;
	Mon, 18 Mar 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786936; cv=fail; b=UuuKx6l15+JrbZOlG6q7dBIe/CfPk2sBlrA6WkHQf1UomegERdtlU+Hx6ZxmVJ8AXgUNoSyaDjwVSRlqNTReFXPh8StIIwcJwzsYnwICungsqnxI7gSfuaReqQmClNMZJeDuOrN0H0GXvcN7Mcf4cLnCm7xlIEf2TTg1UzGWHmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786936; c=relaxed/simple;
	bh=RftI9wBshZyfaS+S8xw4e8Pq8EYvZqi0qiGD0U7EmF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fz1O8eT9g+ApH7yqDua4GeYNWcDPs4Io+AmKCz38WVvshf5bXMeeRAVZCuluEr7Qwdh8Vh7g93GkXlKTa3mohcO0Q3Qc1qwNyzhJSeRALXjs0OCDyA0ZT8ccq9AytMGaL+xXZX79ZyCDuHpoNRzurJPXUDHsOfdMT1cPXAhLcgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rBZCR0VH; arc=fail smtp.client-ip=40.107.7.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kviIcmb4JV//DM7L+dmpPgOtJzH/DccjjJlehIu/hFiAA865IawWPGKEvEO+YToetXzSxB5O+V77AKG8R3b+0QUUIVf62CVV/BSdroVHC0Q6JV8qUY0Nl+8lAfA751wyHUDFZVOhi8JUadR26tqHJk2LXAVj6mIBk9euXgM3GwiaxUcmXYLG6f5j0rkWIia1SUhak1UQ9ekT7rPMPyK/LJTXsnA5fwAIlyTBG0jh6K2Ku/q5j/zGQsz382ZsFnt+fdvd4o9dQBrn0UaabMM3FSwCuDswanrpb++QqDcl9jZgA1ZOCzP72oGMZxXs2GKgrsxT2xOqxGW+UnJneyDZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lWXSTwhJ5x2xbXycnKDyz0lnMnJ2cOTiXh1/WEUMhg=;
 b=fJG0gwGPDJlZwy9X7YyHnSWFxb/qr5KjSgayMR6UtU+iabKhMZaqMRsLcTtDAiuhymaLXPr3JYetXHaxwP6rI/yazOZtwlNqKzscm3gUMxef9oB/+9T8I7coQD5yAAJ5UUeMlIVaw3gnZART7CpqZ+MAFQ/X9XEtwagSWdnpLAJRlPvL3ocQfAxvOIvYTuxsULcsR7PIOn65sJwOvILCeIISjLozHA1dKCjgkmHM3sDSXVhzAeVLuCvt9JQRUWEn7DgaE00xMoM0QHvqJ77Jy2cy0NURoo6HdoZ2d9+rnWPXDWif8S7cgLwBhxGNeJbReQeS8G+313imixEaTfanAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lWXSTwhJ5x2xbXycnKDyz0lnMnJ2cOTiXh1/WEUMhg=;
 b=rBZCR0VHZnlVaqeZMvmALtSZih+Tps4CPgcBr5vL2tGXjQo1J/Qlq/FIVwwCOF1Nulao4JGDh/3yxX+yYdfsYm5SoBMHok/vimDpiup6eVJf2svimEeRjvRXhrInMVt3xby+PKnkvrwgvKypCDHf4WdOLE+mZpefcTw/22RREE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 18:35:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 18:35:31 +0000
Date: Mon, 18 Mar 2024 14:35:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: ping.bai@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v5 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Message-ID: <ZfiJX0NZG5N587Ai@lizhi-Precision-Tower-5810>
References: <20240318095633.4079027-1-joy.zou@nxp.com>
 <20240318095633.4079027-4-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318095633.4079027-4-joy.zou@nxp.com>
X-ClientProxiedBy: BY5PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::40) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bca2c12-f078-4f40-74f7-08dc477a3090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6dS2s7W/KviQClX7CjCkr3qxj8uWBgx1uFIq0vHcSZWo3qoTZmHhqFxRftO8Uh3ZepgtnBCCiXHb43M9o/czmtcDiBerEtvUMmZyWKm6vlsO3yzguJwjv4Y7i4yOYwmmrwss3sFCtF59uSIE1htEG0sE/ZHAR5ATg1xAgDzRvSxOuJrRiXBEA4E62F6afIieP+OxBWrPYiMEH+yuLLYgi6vURkjCMUdFNIgOgW+wqBr3s4il3yHWnBwx3gHd8ePnyHHv+7rU1eqkPdENWbgFuQYhIScINXKX4s/sGPCZITTC3yFsI75ZrXO8DoqX+Y16vHsR3pXUfprx6FulRMNG4GE31nYPYRiU6kZbznDhsriVRRCLgJYRoXFxJmt0v24+JVugG9JcFHeludsmiz1yp07bb4qIE1Me6lU1o4TNS4DGV0n0wMP6aBU7jbPXmjh3vyTDv6wG3uWnC0YcU2NgkoGRZzYZctZebVn6FFLT49SB3V8nPoQWEuwQXeT7WVRjYIGTrgresJWLet/AlMYhfZ+spQnD/UwokXULic/sYXxdBYzHvnvEqgh+SN1sll3pDffh7j15mt7F9jHloyDG3KHgMfOf9lfgKADyKh3ZabpAO+WVFyULFubgDef5Pk0QZIM42g9yElLyAY2gAomnnmosa2chF3ntgndaUDxn1zxU3tkoWWHM0KSaAog64icSnfzHelRu/4Qcb5ETzIvPww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mk41X1bSCqyRUyXDF0E2HXuwGy8ZdIZm6B81vR1/5JZ2FYPmy/b0CfHkVDFS?=
 =?us-ascii?Q?GGGXqFJ/IgiZ4w5q4BEIxY6Dk2gNRsFY7lM6MC+0lhx/uDw7guVumSC+lEGd?=
 =?us-ascii?Q?wqbbRR01GIiIsJ0zfHXFptuaL9G8aiwu75iCjsq2EZ0ybQP8KvN57P0mwh7z?=
 =?us-ascii?Q?z/RnBS9dMAHQkzVhHgAEzHS41anNvmrctc2jUU8rokN70HpgjwyC+huOHg5u?=
 =?us-ascii?Q?U5AXGg/XI9s8Ybq7dZbQjmoIUAi/cDRNJwaonsw584vmXIBdKwzEImC7JxzJ?=
 =?us-ascii?Q?MnX1ky1YNcELtSgXFaoe70WtG4PDsFL5hMkKsJPmdEtDnkgoz612sJJWVOrB?=
 =?us-ascii?Q?oVthapJ9HtEcdRD15V5qq1lj6sBv4mVw3ugf/fbPJNvcZ9N2QMOvV0WB/F5K?=
 =?us-ascii?Q?fZKTzlCaFEyAHHdRcgv/dqyETcSCF0ObIxzmWX2To3f8NMusOwfwwwDH89BE?=
 =?us-ascii?Q?k+neolhIJyR3nr4amTbeyQ7sQQVALBLbE4wwuMGThURzmNa1ok1gEVRRAoE/?=
 =?us-ascii?Q?FXIpUTzxKt40F7iNuviA9X4nS4llak9W0OH8DOT9vEKo7vsA3Hvsyt9YVCKf?=
 =?us-ascii?Q?FSPJl8oAGUXs4pXd/65iJFF+G8W0mw4mrWfqpW3VjJf1gNsr2brf+Qay0xQS?=
 =?us-ascii?Q?xVFhkgVZnDqpscwx+BA3VKY9b6yypMaXkQK9KS2CLFfVp5j5VsWmwP9NjIDr?=
 =?us-ascii?Q?+F6UHFBnDMN2Scl9Q/ZXmLhPEOrhXAPB0T8GCja04ZkjpQHGv6EQY4e/T9I9?=
 =?us-ascii?Q?uCJX2T3U8oGDzeo8P51RUU+kb3/+bvaRnCSopPsfNvB3j+/PlqYQIHK/yNYr?=
 =?us-ascii?Q?RCklPKqnlG4GhaXGvDRCvMLtF6bi2eTZ4GCKLRnDmkmVBzJQyxOW7ZttOIJS?=
 =?us-ascii?Q?ogin29+dqC7PTvVlonIABC4jkfmhBRGMlympL8gw31CWVnx+GJAPrrNtJvr3?=
 =?us-ascii?Q?8fcqHVcgOls5BvuFNx9qURwx0prqfcB9z4SWH63BB0MEnzUid7v7wN5EfWpw?=
 =?us-ascii?Q?lFOL+kVMqVMPLJ2S1FQMoDOuzxnIkXNBVsKuwhVOJtU93mgnhAOGk9R8NVIU?=
 =?us-ascii?Q?RaYzJXRYTXOPMG22XWI8NGBA2af3w08Q7DG3omvZxLV1qRExotdGKL43ql1U?=
 =?us-ascii?Q?l/kdsqPb2BO9sF/cEosLc4OBVTeEo6ZXolaSGqtiPGGTO88xymUrCo3Kv7oZ?=
 =?us-ascii?Q?Ufdfa4qpFcWO9LV8pRXTBX5JI46qm7Fa6p9TFPFbnZcAZWwU81xpqZdi+aye?=
 =?us-ascii?Q?cUQpthk75afIqe04LoJBvM3ZHSy18akZ6VGO/FdxBXMg93hBPDpaFHzdkhZ9?=
 =?us-ascii?Q?zvSxt3v/YrOQ4SRx5WAChRzdSPda8VPrR3m9lYESOYDkH4jvoEpRz3zB2ssJ?=
 =?us-ascii?Q?nUISeBTajOOn4aAgrHydKQS6YCwPTxFFs42ja2dbONDGBMmPdbHl/yovZ0Nn?=
 =?us-ascii?Q?q2sgy25cx0CBvCxL9QahCBsyoHrJKnwic8Irz5e164OuklMnjRNssZGHd/lz?=
 =?us-ascii?Q?IzNUkc0c5NILYmsn0vnYSnsnKFSsFoccDjKWXi0+tJLB0nHlfreQ+RW2NkfO?=
 =?us-ascii?Q?J8BrWz0ftbn2GCVO3SWIs/uIRg8DpEoysM93AQFi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bca2c12-f078-4f40-74f7-08dc477a3090
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 18:35:31.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oENnaTzr5U9oiBl0PRO32N1YibHMZn3c1qXAeKfO1uvmZ1WNmwc+mACoA4UHe9KR+2JOMgBkCyx+BULgxrXeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

On Mon, Mar 18, 2024 at 05:56:33PM +0800, Joy Zou wrote:
> Support pca9451a on imx93-11x11-evk.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes in v5:
> 1.adjust gpio@22 to the front of pmic@25.
> 
> Changes in v4:
> 1. modify the comment for uSDHC but not i2c.
> 
> Changes in v3:
> 1. modify the voltages constraints according to the imx93 datasheet.
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 9921ea13ab48..478a134d4416 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -183,6 +183,104 @@ &wdog3 {
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
> +};
> +
>  &iomuxc {
>  	pinctrl_eqos: eqosgrp {
>  		fsl,pins = <
> @@ -238,6 +336,19 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
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

