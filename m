Return-Path: <linux-kernel+bounces-147153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC558A702B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A221F21E21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A749F131729;
	Tue, 16 Apr 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4lCMe0p"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3453E15;
	Tue, 16 Apr 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282612; cv=fail; b=btn5m4msQl2Vj+XMl15YlQVv0aQQd+Nrrl0+eSkfxiFbChMxoe+bSLXt/1QZUspAY9JOMQHWCNiGt4gPjdvXq6KDYWQpszMmUylsCrIDtgDGviwb7Den1oU4ByDmgCNj5whD65e832e7co7jx9ggdEZuV/uuHrzyD3E1CddsE/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282612; c=relaxed/simple;
	bh=eKZFTd+8fMvEdlMRFD0rqwsjVn/34eEqIggoy2DNLoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BE+7h/24RYW1b+KvF9n95iO/fuHhooPz4sv9c4idMXVBLB3QJL1glZ2LZQDV+N25Qc8v0nUFwxdTtKizWZHweHj5NH9nt2exC+5Uk/Rv8ikCmpS5pz2NjcGTrhU6sdeyh6Vr0z4aAsBAw4mi5OBSTISn7Lqom7l0Q/+OieIJj7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E4lCMe0p; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga+BzduafjsqYEqV703L9BJ8pZHcBXd2GCMmtsRuRWaeP/Zqo6c3fF5FqAUlrX3dF2zgf0sQgpWVVbvIlQW57nCgvcnMmhqkUzRxFDmpF8MoxCbMaHEk/ADcglT32BiJfj2U7CZEqb3qwBo/A8Q5keOOXFfQFbm7gxeO//oNgSRxUKMELFGZxc7L7fFGfmjgBfbH8entwYd2ET1doBLmD2RjXVYgxpBG4X4a42GarOTRb9IG3vJWGu4hDg/7vuiC329Nex7nj0jiS1gVEZF8cjtWjPVqQUQ2OIpWR9wb8i7aNI2knCFY5BzQ8gOwQzMhqkebA123lOqYcL2UCyRABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THO4VnMN0Nqy3jsDeDFa4Lk50VH/sAtOzPt7ypUqLqE=;
 b=KMbqtINj6/C+agHmv0viWXMpk47vXX69MGegxB9770HGLBD8ZBfcVPSjbLGPcK36mCS85JcKCSGQSUxJ5q638HJ1TEwnbJVzOe12XzpvN3B5xsh8ffxGSlRVZ+T8eH8vJaHdn5xtK+xdaS/bOFB2RM0G/MTyuLQemLbFZu04xYnH7SSDas/bVlHrypVpiubydAk1C+mLxZmUML1Lsc6tkUFnI+lezSoFiL5/+/gfxNtwgQ/m66SlLj/zOPrMe5M0bSJOtD/qvG7mN3IRW9GZPEk+Wuoc8jOAXCN7CpgEapE6HWjKhwqb9ISepMzguMnCj/7NiiCDhjxOL0uq/7RSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THO4VnMN0Nqy3jsDeDFa4Lk50VH/sAtOzPt7ypUqLqE=;
 b=E4lCMe0pKuSxLMFH7uwdxiCFJudpuNHwzudzm5fDUNtn+STam1UXYm69pvgpi2cj7qMNYKhNR1oBZsI5Y4/l+TgSlizOwGtUMgXeVWivWOzySsMzEJi8HZGiMqIVDKYx4YWMMncwuYFSO3g4Uoygt5pFu5cvc5J+KXyJRJDM99o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9058.eurprd04.prod.outlook.com (2603:10a6:102:231::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 15:50:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:50:07 +0000
Date: Tue, 16 Apr 2024 11:49:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 02/11] arm64: dts: imx93: add dma support for lpspi[1..8]
Message-ID: <Zh6eJ7njMmoKCu8Y@lizhi-Precision-Tower-5810>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
 <20240416-imx93-dts-4-13-v1-2-da8ac02e8413@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-imx93-dts-4-13-v1-2-da8ac02e8413@nxp.com>
X-ClientProxiedBy: BYAPR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:a03:54::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 765dd22a-7185-499d-65ce-08dc5e2ce3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DA1QTiulGZTZEIxUa0tWowpcJ4hwSgTFs6GHhPNkLluslzpQ3T9ZZU5APjX/nQ1nxyCpiDuBw4jkBSXa0AUoaRunzad94LJM4faeK//yVv9oI/1V2JeZz5m83PYmuYIVtsDD2LKaEwAHcfvB93UQkn8aDuTjAuzDZBDBTDX1hD5bMhkJ9CJS9Sf/khQrmpYS82uT/CpdO93roeQ47np6pMcjck6T69V9+CZeaW4nKiCX/nr0vQgvXVg0GCQ9pEmUckZVxhekb7U1fUk9Mv9fWNJkbUKeLBdCH64Ftt4wsxbHcBj9OFfN7z1/0bB1WjhtlWBN+hsnNZCW00oWAS7U+HFTeTbtpES42uoQ3ICSTLxKrUNVubZek0VmSrboR+wRurJK7hMm8vvCE2LiYAkC9JSH6ErMiz1d414FLbUpGewG0tm3YgMOstwf6HgX5eTwDf3zMhEClsUarJ1YX0GJY96VbEXaoJn8IaOqNNlS/B0f/S6UQa/CPzmyxBs++DPyriCD/xlbrwl0uGlTaxoztx9lrHCV4qp/km+gp3+B9R0Kxfo6dkpQr7qV9J/dOXjKmvmlpPHDJHGzhdf1GfFQZIJxGbW8yXBag56E1HUiIBxeGnahGsPpcB19Urza6wRNkbJvXOedO2sD4jqdv/3SWpG0d2qDCB/STZL7kKJ+jmz0cBP9e5uNIFeMAAq1y8fzGeStZCJwZ+jwDmvHH+1Bfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Ce7DXE6GIzlN7zBE7g75Zc1k89/6Fpp4UO4tNZlT9ophkoaFwb0/Ib5qv0K?=
 =?us-ascii?Q?Iell1E9hQC9NJtkvca1VH0653m1lVZrscwCwfc/uMJdjG3dN91i2flycrfcZ?=
 =?us-ascii?Q?6Mhjk34x9gvf78ScGZKEAwCSevasocVt6G1Pvgj4YKoCICgqUiIxEja9jL97?=
 =?us-ascii?Q?EXfmKgqZZawaWKZIra7yz9CUEjIOPz2IbNHykFOTKROmKHibZkBkSBybyoK3?=
 =?us-ascii?Q?KWeHzKnaqY9sIhW2wdlO8A0rGMCPeE6GfWCsBXpKEdg0hSfZa49gBWErt0ek?=
 =?us-ascii?Q?gbn+J9NBj4Sit1mddrz2Kazyl/7GmRTY5VxvhRkbn0VXRBTbeUP8RRSwT+xK?=
 =?us-ascii?Q?lJgZyt6BD5PJzUYeQukij8sR7XPn8/0tLybg3Rr3EXVVoGaT2t4mPf6o1hq0?=
 =?us-ascii?Q?0GAxlfk+bFTxlDmpQDpyXXVoa1H5+b5Vh7FaQkrsU6s1hILa0TA98NKWj9Uw?=
 =?us-ascii?Q?FB1fSJPrnTVjKsVXOEmXxsv5y4x8rzteO4oUOAKbCpykA81RTQjc/0o5WpcR?=
 =?us-ascii?Q?A5idLrvbfvKaqoBlVXh6HdK2wHm1zpGY6DZMm2AvBOzQhhjziVgJv2S/rNQV?=
 =?us-ascii?Q?wmBIbTE7OXFa8uTqfvv18Cpaf+l5AaEf5Jfa1WIEzW2BTHaXvxl8elUUobEk?=
 =?us-ascii?Q?yspnGkCA/vHMtjzjKRWe27JKGKwTq+nHKjVSCGh3JMizz+kdDUCJA+HQnpBx?=
 =?us-ascii?Q?U46l3IdrS+3v12/0J33dzB3p1bHsDH92hOsWWPb3HB782VgL9t2Z5Vs1U72D?=
 =?us-ascii?Q?/1LeT8ntcTTtEsajZ1LJFEsCKRbBR6yxPjFAaHQmJKxI0xbb+eDwwh30Keyw?=
 =?us-ascii?Q?XHwmdr4K4PF1Bjx5ZEEL7TC80QxLoXcPm0+anoayt5SBQ3zcfjtFKa4udMqa?=
 =?us-ascii?Q?pBAI6H3kS/EmbxB90TOrXNg3qixEr5dmuJ5MPvsvtnZV0UzZhdYmdVU8qlNM?=
 =?us-ascii?Q?kDvJzvEltuFbW3dx/Yt1eRhBWfkNrXllO+XgDr0A4kFJ/a3+P+AfHGVoueJL?=
 =?us-ascii?Q?y7FyxDklByx/1knoo22vFTlDIYRrc/UO7J/6hZ2jOg4bFJz6vmephbEedecm?=
 =?us-ascii?Q?BiENlSS8K6+aXUtkKmltjsIUJvyH89z50HzWgMB8FiYwTl2FfGu911+gSF57?=
 =?us-ascii?Q?XteiarZtBZM/ohYSPY53TNlRXQb1tLSSoe5EtvR7K2uEjSlKkXo5249ahWop?=
 =?us-ascii?Q?LVf6w9pJgY5ouGOqBL6z42FEDVR/F58SUWHlZio1wbgBhVlohfaUVCwu6qgO?=
 =?us-ascii?Q?i78HfLQs3c80Mx++JEzwbUCm9rQygNTV2jDKBaJa7NtD09MOEkoIgzdmOJxJ?=
 =?us-ascii?Q?clfeBMXIqZTd7OSSq3E3DlfEd00wrLabWD0pgOfU9xymV0TzSOTRHveyiW2Q?=
 =?us-ascii?Q?dsms+ELFFnfw+oa0f0+31vCrQkNSRLdAU9UbKoy1kkT+lHTeVR5sdf4WKizR?=
 =?us-ascii?Q?WGYM/0FWtwRY/4nQHXLKWlf02ZarNjF6GjBvTQsMiT+xpowMIbX91GWmhzR2?=
 =?us-ascii?Q?al0RHBEjbBprgNcSMvNCV7MrpbGZKxXRs9N7NxfOyYJ8vho4t2OvSnopEAGd?=
 =?us-ascii?Q?jlShkMq4wPOKuEX3+QgKmnuwsfQ1UPabruWXWaFf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765dd22a-7185-499d-65ce-08dc5e2ce3c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:50:07.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxOoED7TXZcTLfgbRnfpPQTni2RrqasH8G0sDXAQvVsfgMxj7/6UV2ydoaTx4U/wzQ35JBK8DJNGx38exbzTXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9058

On Tue, Apr 16, 2024 at 11:26:38PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add dma support for lpspi[1..8]
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 5c08e8787989..00f2526c4011 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi

#include <dt-bindings/dma/fsl-edma.h>

> @@ -344,6 +344,8 @@ lpspi1: spi@44360000 {
>  				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
>  					 <&clk IMX93_CLK_BUS_AON>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma1 11 0 0>, <&edma1 12 0 1>;
> +				dma-names = "tx", "rx";

1: should be FSL_EDMA_RX

>  				status = "disabled";
>  			};
>  
> @@ -356,6 +358,8 @@ lpspi2: spi@44370000 {
>  				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
>  					 <&clk IMX93_CLK_BUS_AON>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma1 13 0 0>, <&edma1 14 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -724,6 +728,8 @@ lpspi3: spi@42550000 {
>  				clocks = <&clk IMX93_CLK_LPSPI3_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 12 0 0>, <&edma2 13 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -736,6 +742,8 @@ lpspi4: spi@42560000 {
>  				clocks = <&clk IMX93_CLK_LPSPI4_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 14 0 0>, <&edma2 15 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -945,6 +953,8 @@ lpspi5: spi@426f0000 {
>  				clocks = <&clk IMX93_CLK_LPSPI5_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 79 0 0>, <&edma2 80 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -957,6 +967,8 @@ lpspi6: spi@42700000 {
>  				clocks = <&clk IMX93_CLK_LPSPI6_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 81 0 0>, <&edma2 82 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -969,6 +981,8 @@ lpspi7: spi@42710000 {
>  				clocks = <&clk IMX93_CLK_LPSPI7_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 83 0 0>, <&edma2 84 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -981,6 +995,8 @@ lpspi8: spi@42720000 {
>  				clocks = <&clk IMX93_CLK_LPSPI8_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 85 0 0>, <&edma2 86 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> 
> -- 
> 2.37.1
> 

