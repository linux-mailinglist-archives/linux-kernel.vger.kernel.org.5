Return-Path: <linux-kernel+bounces-147144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C38A7013
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7775C1F22201
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DF131720;
	Tue, 16 Apr 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDjXGues"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47569130AC3;
	Tue, 16 Apr 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282316; cv=fail; b=vFPQG6GEWuBqTKsxIwj9n5fwPu5jLM+0a2Rn4ksjFlhnndzsvEQut4Sft9QK+UxnfIbWff1ENB+EeuwKNUpzGbzIXsW49k+3NrWTQn4Yg6FEv3OHniEkSCaGSRwm9l25Ob0OgfLNM0GDrWFsXKykhiWTULOkwlzv6dQVoMBTA9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282316; c=relaxed/simple;
	bh=R5OEHTXQXX4d+SvYO/3a3+Ppt8wY/O3VPU7QP5Ow74w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=giM6JSKMdtHLmFo7fARckcaLRdWUvSOKIiPYg0nbnhPcn2f9JWGOMo6NdudNUMD0mUkQBMD0xbPMHrEbmno7wltqvEHgfIARHuV4lKKqi5abSfLYgcadh7fuFUSNEDjdiyxROLKMXV5C676s1XN9hwJ9H47GAP+HsDwUES8o/ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WDjXGues; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuXmeWkN1XKK3CSlnOIbNZiKw+5PuPzB89MtBAU1ERHfK1TN+3recZllk26Z2fvCbyN4hBfgOFqTvcnkVObl/1F0JhlQAF4rqaQi1ORq05hUw6y64Z/bjOPgZICwRauvTyjj21b9D5E/Dchb24cjLJg0f1DHW4w/XT5uhrIeIrupAJs1e291o9tcdVzq4d0/whyXf01WuxmEv3WAhOmodv2tMsoB6XZ8ZxWEbG5t4VM3lyAk/UmboMpDoHacuOKu+P1ZRtFaP12qL2UOoONkJPBG0AcS6RIsc3MTYhPgw+qjNWcOEgbDFxxeywrFNQMqaF3jkOCTbOCXxDkgRYNc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/55rCU6eDp0mdrTuojSXATBmsXHSiCfJIG4rpWVEX4c=;
 b=eYPBgFpvrYTSRmYFMPuIkRJzu4CO4m6KPI9HAMJepQi4GnNaGzCBJQfQwRLZnm3w2XZ9q41xwIcf10zqiYYXgvyAHB2R8xPl6hNHWG/2KiIWBZG2RrA99PVkIQvGutd8h1bQhVCChBA1Z3BjQVSfj4PodHTojSzT6TGoJeDcjraZrRwUlTztycNg2BlxGBXBKkmkksmhwv3EldHya5SL1ulilzqEgv2pPRDvKp2MeXWIgNlTk+9ltPmOwrSVZ4Uj7WvQ2O3dnpiMu/U0PYPRF1Np4RXbuI45aGeZAfmTSIV+DbZHyLaoocqwx2312DbNIWXibwzVzBIWQN1Yng5chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/55rCU6eDp0mdrTuojSXATBmsXHSiCfJIG4rpWVEX4c=;
 b=WDjXGues8IbV6hVe3H8WKUvdyWoXgNCVA1ALFUn+czpHcbiCbRONQYjRAtu8nr9pOerdwEZFjaK6g9HoMlzKMfbma8DK96P4JSLd/1emmbJyf+3CzIDeOzoLQm4YUPJ3X9heU2DD9YjKO6tWPYOcBU3yhuAW6cMupYdm278bYxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:45:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:45:11 +0000
Date: Tue, 16 Apr 2024 11:45:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 06/11] arm64: dts: imx93-11x11-evk: update resource table
 address
Message-ID: <Zh6c/gfdlNTIa0pj@lizhi-Precision-Tower-5810>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
 <20240416-imx93-dts-4-13-v1-6-da8ac02e8413@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-imx93-dts-4-13-v1-6-da8ac02e8413@nxp.com>
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea6031b-b711-422e-c368-08dc5e2c3322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	foPungl603qBT915KoCs7P62Qu6YDHIXzojLfuuRFz4tCt+XHug3w81ixoWjl98UmhNp9uF8wGsSbcV+8ryJ841X4TldtZVfDe/lXGH5Pfb5dsCLewHxpHcj2NNE9V/oGxh65uSaHaAngPazHgRP6IHLdHiYx2Vtbi2IsLkFGwT5BEetjbOdgT7Y6kCmOicg+l8PpWPXaF6qRMgtl1fORDm+H4w5LB2nX08/nLQAwZK1ZXKxooNinDkyjdFEiXAJtkAm3QVWb98wwEkx/8q/LZSC//nyLcUEBdTGoePkqXN0lYZajYy5GlubRTnBkt+RmsDSB5/7KJAJJRhUTbFwmNqI6RbssaGjqIUWeYgOWQqR258gcNAkbXBlO6u2w4rl63TrMRFMCADiCjd3QOjgf5iFztQHA+cFXiHRQDeVFnIdQ8WYIRqw5Y7vL4MoCAqOlTE0Z8jlIks/EF1FkrALXf2C1TsE5HZThhtMM6saKL7iTGIPajFbRZV8tEi9zO7OytTduESudCfsJmyvg7bvAXov6EyRZdlNVQ8ZkUfTizkXxGvQAQZ86aLh8QRQR6hY95KI2lPtHj/Y8gLxjro//aiscn4jyqm29a0UYPTR6Jw7rvh+W7ERrTDDwumOz9rpBoxjDdS8DaUwUprtt7TmZ7KAH2Qnuk/T8oSaZspBQU0T4m3ZeEqDbFkfBgpkj4O4fMFYQzopxEEqjXy8TMqgppJ3f0k9xCTdpt3BWpsXbew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ROUOi9qYY2ngod1UPF7/AwD558Tq9aG7VKoSWgFq80g21WLqmsrMHZwgUxph?=
 =?us-ascii?Q?sZrA4ccT95BnX9LmpCD4YUHzwTFI+jCYZjtxsy5qQ14wS8riW3sjUAYAULse?=
 =?us-ascii?Q?YBIK7JKGISK/6i1Ck/llftWnhHKBsHBZrgt0FDLqOc/6XVblMOUrSpic2vfr?=
 =?us-ascii?Q?jUsFOCcjeMAgXF2KXNPqt+hkyc9W0mhGNIDNpbv/8gmkCgkieslRYZdsjA5j?=
 =?us-ascii?Q?FsSRqWkS+inXIly7i64guPTWRiGgN334Hh0BX65x4ZWDfKAA/z233IVnXiwp?=
 =?us-ascii?Q?pMBULfTfFTrkYFWdHPtPg5zPYzG5eR3vs7Vj4LTfmCVXSmkSO3Af6UNPpgFL?=
 =?us-ascii?Q?ScvnSnDltke7iTa3EGyRuNizK6sfYh2ePDSkqf591YWu91JebBAhWhoCpOkc?=
 =?us-ascii?Q?LBmT942vAZQpquWmkTO0JlH6sRaXlVjt4l0GYdlFscSqCeeS9PVuIPXz7c9g?=
 =?us-ascii?Q?un7azN+mUXiIvBesRaAtDgIG9sygvWDqCFTO/rmHkoYiLlecz71zgGlaWbPO?=
 =?us-ascii?Q?cPQk67EZlSzvNTj/kc2wjd54xThXW/7xKco07ZDKlvwIs2iHGCzsUBjEGYxD?=
 =?us-ascii?Q?uNF1d01ooNpaTsericNelUf4j6+CVetLSAsk2070fdUZW2GT60secniGuLD0?=
 =?us-ascii?Q?UdKg85N5fPSBbnjLue4/3TOI5G4phaUVpQYFLlWFqOcfXhxvdRzKQoW9ZUUC?=
 =?us-ascii?Q?gGQK7gbZ1eIP91VdKWYQmpzjEm1u15jA/g5COsr5LIT32w6pCwxSWuWrsqLu?=
 =?us-ascii?Q?y5SEsE2ZCZtnx9RTmIQrjfBTs501UG3kkKIoKR4WNueq/A8NRUhRCT2swMx+?=
 =?us-ascii?Q?1SIM6ofAFeWAqNTP0L4ZOC5p1mSnJA/VnYo/qZOdcry7Sgz1MJX4BDeRCuNG?=
 =?us-ascii?Q?WFOGed+sJC8wfaphGzLpLTwbLuc+m7eWWUVYQ0pgW9d5BnjlIirdIPQ/JCfk?=
 =?us-ascii?Q?xuzX4ypJlj8mYhibPdj10ux6sRxPCvADKZxn5UVIP6S504549z+q+bOuvQY4?=
 =?us-ascii?Q?cQbU3sOGd9XrdvaCGikv7uFApntvbzqDisBHJJdWyilpEO1yRuDKzto0u2Vb?=
 =?us-ascii?Q?iXKSIS6VpUdIHbLBL8+GP0KKuSbqT+0W1Oupf5sBsGSXMy3VIFz0amhjAe3z?=
 =?us-ascii?Q?rd3voulr3YHS0Kd2VHO/bASoHSYhO9BKh5Dir7RugfkSjYR5pxJcAoOnnwJB?=
 =?us-ascii?Q?DHDAfK++PAhJYHxHri46OxljdTCnuxjarYLIGnLGmapqYR18b9yJw1/gZrLy?=
 =?us-ascii?Q?ammSIGB33FtQokgn6QalzkN/cT9zD0VGaKFNSLthseOLMzBuzdH05b7epgq+?=
 =?us-ascii?Q?PJfXWENNwcUa5fEQ5IbGrBs61Q3eWVX7YFpeW4cvliwisIG21OMD0/Hd3qZf?=
 =?us-ascii?Q?v24ez62v0+BTRWD7/Hvp/k0T1Gd3o3NTi7wlCUetgUclcswoG10Wxc7/LqEV?=
 =?us-ascii?Q?pV6m44khd+uSd9/DnVteqedjSTXL/GQGAgjI0IJpI+iL9uPr8tLax6Z2n5aG?=
 =?us-ascii?Q?Ezodt0NMUyVduS8qbuwALjPurp1OxT/SF8BIJ5Psqs/tgi0IrmGw7UkU/Mdc?=
 =?us-ascii?Q?BE22jmD497pLeaKMfF9EdfB2Bq8gA1ixgq5/JZUi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea6031b-b711-422e-c368-08dc5e2c3322
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:45:11.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WS6Ohwtex7XbA0BYjPZGXieSE7oHsxw+X3toa2+lhwzlw6iXdX3HQjxC6MEO3SvJCd0Z7j3FgO4jKhaAeRgtqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438

On Tue, Apr 16, 2024 at 11:26:42PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Because i.MX93 A1 ROM used the last 4KB TCM area, update the resource
> table to avoid conflict. Also correct vdev1vring node name to align with

Is it little better

Update the resource table to avoid conflict because iMX93 ROM use last 4KB
TCM aream.

where you correct vdev1vring node name?

> reg.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

It is bug fix, please add fixes tag.

Frank

> ---
>  arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 07e85a30a25f..b7b52576586f 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -38,7 +38,7 @@ vdev0vring1: vdev0vring1@a4008000 {
>  			no-map;
>  		};
>  
> -		vdev1vring0: vdev1vring0@a4000000 {
> +		vdev1vring0: vdev1vring0@a4010000 {
>  			reg = <0 0xa4010000 0 0x8000>;
>  			no-map;
>  		};
> @@ -48,8 +48,8 @@ vdev1vring1: vdev1vring1@a4018000 {
>  			no-map;
>  		};
>  
> -		rsc_table: rsc-table@2021f000 {
> -			reg = <0 0x2021f000 0 0x1000>;
> +		rsc_table: rsc-table@2021e000 {
> +			reg = <0 0x2021e000 0 0x1000>;
>  			no-map;
>  		};
>  
> 
> -- 
> 2.37.1
> 

