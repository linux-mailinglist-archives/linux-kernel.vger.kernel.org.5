Return-Path: <linux-kernel+bounces-151582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9F48AB0B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAEB0B229D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3F12DDB0;
	Fri, 19 Apr 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yo4zFN0Y"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268F85938;
	Fri, 19 Apr 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536813; cv=fail; b=NueDZs8kwQYvguWliwyonU6UuuAZAnOKHzRoDG1YYja76okPO8jAFGJ3sJWdWrnDe/T1pJ5BTNbhGvS60d0+SzcQ6cm0nV0Cy99vpI2qZPf3aoR+MRqg6nFmH6RgTLch59kEPj5V5hGmp5ERUUlAEwtnTO2M5yS9Vt35FJyMQeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536813; c=relaxed/simple;
	bh=6oDQ6Nx9LRj6mAKFqpnjxV7+xbgXxsf6R0o0oscZj60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nI3/D7zFEXZ7M/2eEck6G2A7I3XlbjQG+6jZaOvBbYfroBJZoxBckQvyet8Koe3pgAzGIJJAjotau1r4N2NjJmDvUl2IniM9UC8h0AP/C6xt7kOxOILsAX4Ly/SHuF8X8bUQvc9/1JML6EoQ1qZpTL680GtDph9OtX8SOrq4Q+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yo4zFN0Y; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHlQR1kGu7YACoNt8jUsGJ2raMkrJmlPgatxfMNybI0oNNQtPVMrSMXCsjZpKC+OisIom1TrPKMkx2y/H6i9W+CIBcQ4Y6T/GPVEOtmxgSjGRSUonDS5FBLtOlTalrkeldF8ry/lH6MJF1mPJJk8FeAuYAmTAuW2FVAvVNyYo9skpCDO2YPyhlqmQW8z4Q5/vooVPonLqsI+nEndsjmzDADos2cpF1q5vXknD/a9anII+x01sjKEjaIz83m3400rs/fhNRgUfs2hnmnkGAtCRjHuwCdneaHadjIbti6BhiVxp/KyYxNo3Q87ebcm0ZQXjvxU+vXxqVmspaBEAf1f0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ/4wfdbYYM4ednDDE6Iz2+y/105h8Fnhqq9tvG42gs=;
 b=emG57oDziOrOgwhwrSuhc8oTOAyWX+6pGnMULedGl+SAwH00WIZf2AnzFRLP7k6lO5IYCrw9BV7Jfq4bel6+0h5hloLFh0uZ5P5DuHesfr/n/OcfjmfypoRpTdqMMOUm0Afn009mmzAYqqiqo3sxKfbY3ITVTvtvAmEc1py97898xbu5ywpffdDVSBC/+Hs52b6CdE/RlDGOYfk5bO5fdFI4Ym0pZVgzrKpPmGBAoOtslLr2aOdnAg/pNvYNQ3+n/AasXQshMOi+XVI5TZOSBqEQbuUVmkzlN5rpStMSDHDq4+XXJEaF3c0cZ+V7mMy8jwMMtcKYc9KvHg8zurGaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ/4wfdbYYM4ednDDE6Iz2+y/105h8Fnhqq9tvG42gs=;
 b=Yo4zFN0YUFctYt7k7xCmhRFb+dizDhJYi3v0FIuFtOrT3GBl3u3t38dOw276au437uZI1cIIDMvUIvs7ZHYNRnOn9W7FiHdPBDtcoKOAmfYSHFD84FLTu6VyrTJWoFd5l8RDdfARjVEIRz8H6vu3Kk1F1qjuJMdgz2SqAcDnGTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8611.eurprd04.prod.outlook.com (2603:10a6:20b:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:26:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 14:26:48 +0000
Date: Fri, 19 Apr 2024 10:26:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 01/12] arm64: dts: imx93: use FSL_EDMA_RX for rx
 channel
Message-ID: <ZiJ/Ho/tjjoAehoa@lizhi-Precision-Tower-5810>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
 <20240419-imx93-dts-4-13-v2-1-9076e1d7d399@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-imx93-dts-4-13-v2-1-9076e1d7d399@nxp.com>
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 568bbbe5-1c97-4211-19db-08dc607cbf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V2R9Ca7snLu3+eS6dvngaj0LD+OPqo17MDtKBDxTihB368eCnyd4Pjlnbmqf?=
 =?us-ascii?Q?+570Cp3f4RVKVHrCBRPHHbKBJUhfTbrwJ0ggKnbWFKiM9zJSFmg9B1fJoDWL?=
 =?us-ascii?Q?eFsj/pBapHdq/TjseZsmcNRwme0JOA9l698eE7Q/ovPGL/Tj3kPocyRMsURK?=
 =?us-ascii?Q?wxr1VmS9DFB/nRJtYYu0uOWqQko8wP9Y9WXqNXTrJYSiIihtswie6YVCM51n?=
 =?us-ascii?Q?jvva8RSubnlYJNIvsvOglEx6CBhFRdPJOKb69kFvZU94ZS4HaUb31y0BviPe?=
 =?us-ascii?Q?LkS28auMMLjMLTiYE+0mJO7gtxBuQ3gUcLZrvfMUV7gPFhVYRIWAiU2AECvP?=
 =?us-ascii?Q?7EPon81/iV/FQ1mYHSyaCUoK17E44N3RXpydg5ejD2ogF7i7z0NyJlmVEL5b?=
 =?us-ascii?Q?cwEw+qG1R+8wcFQVNMsgr1gD+QIJLJtCrlPtikiH3xuPOoMp6JJ/1omgbaon?=
 =?us-ascii?Q?UFsxOiQhAjUrI+F/4WjWwDoyEQZHam5TfIoFWORG+Ddsbh5ghJmkdF5JRQlB?=
 =?us-ascii?Q?zGPWMxzo6Ol8AIeqg6cLrCnRGF7V3HVeCIR+4Fh3tiCT6QlSJZTUVzmHXAcz?=
 =?us-ascii?Q?vtNirOGQ1yaDbi2SQKuIT/FFqHRtXzDGLMeB7eqh+KRGrimlZg2/Yzu7UjyC?=
 =?us-ascii?Q?27oDXUygFZhgqg8YKhlCIN7CK+5N482FzzNv93DBdpriY0zIxTlZ+q5GfTan?=
 =?us-ascii?Q?JCax9Nq0TPCmLRVUc2oG4zCSpji0kRD4ye0PoODxmkGPDlr06hh3MnStuouo?=
 =?us-ascii?Q?7paddWoVX3DWOZAZNbRXF+V0Ya1axJTm/LKZbhLgUDH7gw5lSQwmIv0hBIoe?=
 =?us-ascii?Q?eket69dVFkVPpRcoHG/KtpYq+nWJFfeGIUUVvCwYgCta8C91xBwHSjVzSAIL?=
 =?us-ascii?Q?vbRX67/F9g/zbsojl72/Xdr5RyNutwkmHDI4X2RwFgasFGe8/D3wgfQxTnRs?=
 =?us-ascii?Q?hx3UhAJ9PvFbvLotkgkZKMjt+ZvcmEt4fbQVpGcCH/DfoSeQIsLe+F2za8Ra?=
 =?us-ascii?Q?53lcmLxDUwpXBRUtZtuQAMzg5Acw+WJ+URZx3qGll9ilC9QxfyHSD9H/sSOJ?=
 =?us-ascii?Q?aSUX+xfzyRiW2CNQOaZCR6ya/CbNYuOvLK0JrhQc3wVvaroSUTaDbqnfS1r9?=
 =?us-ascii?Q?6A2DeZtwG4iO7MwdjPkLXzJDaVKWy9eSHR4/MNZi5ajERUBy+FcuZaYc50hJ?=
 =?us-ascii?Q?WuVMipwNo6BgabkB+hVVAropzxgAbIHpe5trNLDl9sKG+6tIV4ponUtgShGY?=
 =?us-ascii?Q?jNhfHOXVEHWN746a5RLfxD42ntAaUy885rtAGf5C4cTBJN64aSh4S6xyCQUi?=
 =?us-ascii?Q?rh9MDUxsgdJto9CoiVgbKv/h5FPlFT3EePykrsqKzSw1ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QRaVMnzAbdDIDXsWd3meRqClIz5xIrwPSfKkXwygiu5G75Zhx9i1OaenZkas?=
 =?us-ascii?Q?uREu5J6l9NtuuC0pVVlcWUm2HcTlfdZQay7p9OrbHbQ4b6+O4PoN9Ke6JwjZ?=
 =?us-ascii?Q?kSXO1DAQVYi/ZK76rVSYgC+1P6dwlXhQOefp39WgoVzeqNIbqH0Zez/KoLiG?=
 =?us-ascii?Q?KU9mNVwt+zCa85omPIEuKdzMlI3J7Nl5UDy8dGNAFA3pTGaxaGaJT5JGc+LP?=
 =?us-ascii?Q?weLverzaG/z1up+ecBPpf8TPrbtJz8v5g0zKAIjH/OCL5eVoptLTMbJVjCXU?=
 =?us-ascii?Q?rvv9HgVoy8KyMuPDlBlqzlMg3DNAA531YPDLcVuc+RoyRl13ryVGksaiT7jR?=
 =?us-ascii?Q?bCUMnSczkbPpDddWBMxJXUhPrz0FBC4kkBy9fF0AGW+AOStjxAZzny/F73uu?=
 =?us-ascii?Q?e5+WQfvtWKl1jr0Y92pol+3di/Jg/HFtrkCMaeGUwLzXfE72X4EoEFECgfnW?=
 =?us-ascii?Q?yKgARURVI9mv+glxBQ2MbIlveYNpFsBwKEKs+etDyrObqppECqX9FuY0k449?=
 =?us-ascii?Q?PYqa8vISolfRF0Ibcf8jhflDbZp+5HvMGC71q0p7ElkvHWB6oiVRF4La0lLy?=
 =?us-ascii?Q?PC83jbilhMxlqngfEinfZNhECSbQJUhdu1ewlHG21ZDk8+e3SWKGpLM0ix5j?=
 =?us-ascii?Q?LYvQfv4+1n9iiEGt3ZQd/rVzD0s8PKrbgf63k70pvaH57vON6Bis3rZC0OW2?=
 =?us-ascii?Q?a+OiOodAcq/1qmy7mCjpQetvVs5bmY2tlu/me4XFfelPeSRvnokmGPl2UqDu?=
 =?us-ascii?Q?aDEg9FzIi/zjrnRtN1y2BUwPOdRdm0cfmKIj6Az4KRawaMPVkNtuBC/HlECM?=
 =?us-ascii?Q?DPN8oft7mzFI7BoC7dkiHWqYKLFARQcMfwMHKFoEqqNp19gYnCal9yjAQRx7?=
 =?us-ascii?Q?/iH+3j5aOl9nsVtEGe+AphNzzwZesyvL9ZOy8cUwYFQoQhxJjI8mnZbL2mV3?=
 =?us-ascii?Q?UMdZxawpQWSyvBDWUuidTDAERaJ1npxZY01u1A+7cULEJ0uy7zsqtYijcPyw?=
 =?us-ascii?Q?z87Xhwi+Sw0/gEQD16oIrkHkRPLf+0u2+5+W77k4CzXKeQSYtIiCeqfqLPBa?=
 =?us-ascii?Q?F6ezhY2O+vq3Tt4KaG2GaETfeABxKPGq+dRSbruWK2FTJ95UcVszjTBpqtTE?=
 =?us-ascii?Q?oCjwzzNujufVHohyxVXYeciWlLRzU/D5M8x+TkC+fwdZ5PCt+HI3RvJ136rk?=
 =?us-ascii?Q?0eL5XKpTPtb+s4EKONIfyTc5jXKc8B4WDdtUX7QSdaYV6lHp9CgRlmp28BhC?=
 =?us-ascii?Q?L029zGRH7c68OH0tGppFV2s3wCkkLgq0wMtNWFUMFPHPkT3Ozk29SgHUg1rU?=
 =?us-ascii?Q?+hiUdPfspdRMDHMuT0P+QPhGBrqNcO4RH3KVs97R8s0SFJ8kTX5pGnxzpXJ0?=
 =?us-ascii?Q?sySFNZY3qjn6mvJ+mcvgbtgUa9NflixsW2XiMt0VteuANWJO3pM69QA1hW+f?=
 =?us-ascii?Q?hWy1XNWZZa7lDvND6+RZdhSCjsibnrkoH7DljU071OVzJb7Qpn76a8YrNFKH?=
 =?us-ascii?Q?FVvSALoNuDEJyiOF2oviJL/0Gwvzn/dDn4tEpZM35XUHBGG4fb+hcjLIMliF?=
 =?us-ascii?Q?AIk/s1ZgQdmk56CevDk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568bbbe5-1c97-4211-19db-08dc607cbf67
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:26:48.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUtBqPalDAyZOKlWKQDBM7o4QOlJOI5ynCOq6nRfpzGPrSW/Jk0FkQXCGs57+HztMp3DsYLtb9PvHzCUSh4+Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8611

On Fri, Apr 19, 2024 at 11:36:56AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use FSL_EDMA_RX for dma rx channel bitmask, which is intuitive.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index b8ef9b938856..42bbe491a29b 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/clock/imx93-clock.h>
> +#include <dt-bindings/dma/fsl-edma.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -361,7 +362,7 @@ lpuart1: serial@44380000 {
>  				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
>  				clock-names = "ipg";
> -				dmas = <&edma1 17 0 1>, <&edma1 16 0 0>;
> +				dmas = <&edma1 17 0 FSL_EDMA_RX>, <&edma1 16 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -372,7 +373,7 @@ lpuart2: serial@44390000 {
>  				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
>  				clock-names = "ipg";
> -				dmas = <&edma1 19 0 1>, <&edma1 18 0 0>;
> +				dmas = <&edma1 19 0 FSL_EDMA_RX>, <&edma1 18 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -400,7 +401,7 @@ sai1: sai@443b0000 {
>  					 <&clk IMX93_CLK_SAI1_GATE>, <&clk IMX93_CLK_DUMMY>,
>  					 <&clk IMX93_CLK_DUMMY>;
>  				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> -				dmas = <&edma1 22 0 1>, <&edma1 21 0 0>;
> +				dmas = <&edma1 22 0 FSL_EDMA_RX>, <&edma1 21 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -737,7 +738,7 @@ lpuart3: serial@42570000 {
>  				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 18 0 1>, <&edma2 17 0 0>;
> +				dmas = <&edma2 18 0 FSL_EDMA_RX>, <&edma2 17 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -748,7 +749,7 @@ lpuart4: serial@42580000 {
>  				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 20 0 1>, <&edma2 19 0 0>;
> +				dmas = <&edma2 20 0 FSL_EDMA_RX>, <&edma2 19 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -759,7 +760,7 @@ lpuart5: serial@42590000 {
>  				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 22 0 1>, <&edma2 21 0 0>;
> +				dmas = <&edma2 22 0 FSL_EDMA_RX>, <&edma2 21 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -770,7 +771,7 @@ lpuart6: serial@425a0000 {
>  				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 24 0 1>, <&edma2 23 0 0>;
> +				dmas = <&edma2 24 0 FSL_EDMA_RX>, <&edma2 23 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -813,7 +814,7 @@ sai2: sai@42650000 {
>  					 <&clk IMX93_CLK_SAI2_GATE>, <&clk IMX93_CLK_DUMMY>,
>  					 <&clk IMX93_CLK_DUMMY>;
>  				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> -				dmas = <&edma2 59 0 1>, <&edma2 58 0 0>;
> +				dmas = <&edma2 59 0 FSL_EDMA_RX>, <&edma2 58 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -826,7 +827,7 @@ sai3: sai@42660000 {
>  					 <&clk IMX93_CLK_SAI3_GATE>, <&clk IMX93_CLK_DUMMY>,
>  					 <&clk IMX93_CLK_DUMMY>;
>  				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> -				dmas = <&edma2 61 0 1>, <&edma2 60 0 0>;
> +				dmas = <&edma2 61 0 FSL_EDMA_RX>, <&edma2 60 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -845,7 +846,7 @@ xcvr: xcvr@42680000 {
>  					 <&clk IMX93_CLK_DUMMY>,
>  					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
>  				clock-names = "ipg", "phy", "spba", "pll_ipg";
> -				dmas = <&edma2 65 0 1>, <&edma2 66 0 0>;
> +				dmas = <&edma2 65 0 FSL_EDMA_RX>, <&edma2 66 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -856,7 +857,7 @@ lpuart7: serial@42690000 {
>  				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 88 0 1>, <&edma2 87 0 0>;
> +				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -867,7 +868,7 @@ lpuart8: serial@426a0000 {
>  				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 90 0 1>, <&edma2 89 0 0>;
> +				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> 
> -- 
> 2.37.1
> 

