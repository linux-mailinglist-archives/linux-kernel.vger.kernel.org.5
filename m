Return-Path: <linux-kernel+bounces-147132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60538A6FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F58D1F22236
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76134131186;
	Tue, 16 Apr 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="no3BpmVc"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2043.outbound.protection.outlook.com [40.107.15.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88421CFBC;
	Tue, 16 Apr 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281793; cv=fail; b=dp6iaYL4v7gySTQB1ed/Jj2PErZ5XQ0eQX6mt6Ibs6p+rJLwMe1oYDLwSuNNwVNGT75Y/eHd2eDPHS1jRUhsroX239g66SHgPzplu/XcRFheSxJichL9RXYuAReuwh9H3qU7QLkpJ3xWMzTDC5bbQ7qQJtyDhPosB3qPw+ogI9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281793; c=relaxed/simple;
	bh=BjwfwTDNrDjl9D/7tX7nJd/QFc2pjbNb4geX9bnBLBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ErrTK9sdqXlUeyYPG3GNs11iM0Lhw+dcZMe6ASOlpFZZLQ9SRjvHNv9A3l9GIQ2F3UIDlnYdFJ4DNYvN7Kt8kE5iupuF3Wkhi3b8mREYHgfDNQK0883NIqGo3WmCyOI2uAOXfJsZQpB66FjXOgOB5Jd55ZUra0yPWDufY1ctPBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=no3BpmVc; arc=fail smtp.client-ip=40.107.15.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuaKM6zPPMH3V/JSr9SVjs7WCwoH0Qw8/SoUpcDwogR7oJpPiLGGL79vZEOHuyjqoGE9YOtYNhiixE6c5APUp1itTbhDNNfE2TtcW1QGUWyeHkffnJlVFD3R8qLH1wHBkB5ObgSgLlireoJJuw4YKg3jacK0Cv3DSHa27ZZsxJ8oby/GA+FFHX26tFgMkEyq7nDnehmyuyt6H1aKkL0VnvIO092tZUKk6JcE7ITgCGX7peha/FYapimyXXUpzfZFFWv7OdiQDL+6owxI9kY2o4+n5NVIfufERro8B0RLeqRPwMZfnnj82lV8hBvauPlBW8IMV9TgnC/eeUMXPJm6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6S75QYqxjvNbSvVNAHNmmNef8rusuK9Y2YQJXAzrxc=;
 b=Ny1mUoOOfuGB305DmzIcx0e7ZuYY89HeCpmqxx5rkCcZUf8ua9M3Z3Dg6C1Gmox7sUqqUjdH92gxnLxgU7vhRshKSsbNGwFarbTdFvw64zQrdVdEQv0YBJ7iClgJPaOjS4eFhggjLCnbrHHiSOy71oSI4u2jnCpfFrvjN6JyYlPjIxpdeLXx6VNInJ6CosevuOGYlKIzujafLkMQafbQ6nmd+j4wSE2F9/ZukV3xljOZjdMpNwSKFJxkKnoVruH2cmBKXtzaS4B1W1c6JN7gf54jQUt/dIe3lFHLCIZTbIZ18qfUJlj0H+DLX8reEfIiDbARvgcfHQMQNSllLJQflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6S75QYqxjvNbSvVNAHNmmNef8rusuK9Y2YQJXAzrxc=;
 b=no3BpmVc7L9hER1SMcIIRrKCn/zgdp5dxAi5VcEDJTuaQO5PGNVRjZx6Bj95vuqV7hc59ld11a7fI/4SNAUCGd6S7vLIQkchH5dHUsuCgrWDfb/PT1D1t8px/n8nzhUlRLqYIrZYze7IccNTBcZOxSiyKmihe67zioAMAOGKba0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9549.eurprd04.prod.outlook.com (2603:10a6:20b:4f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:36:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:36:29 +0000
Date: Tue, 16 Apr 2024 11:36:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 01/11] arm64: dts: imx93: add dma support for lpi2c[1..8]
Message-ID: <Zh6a9E+MSiv8HuP7@lizhi-Precision-Tower-5810>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
 <20240416-imx93-dts-4-13-v1-1-da8ac02e8413@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-imx93-dts-4-13-v1-1-da8ac02e8413@nxp.com>
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: c83abeb0-23b8-4611-fb2c-08dc5e2afbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T3lwJl8NwTxvv9y74jEp74XLxOg+I1ICzRYQiZgGrbpMHzdDHV+fxJ+CrHpuPRCA7BsYClWmodgji4Mxehi4aKaEFqYR6udL0xDByS/qOtmXqs5U0PrOBXYcSpV4mDQQCajo2AZA1eEUs/L6FKv5mV6AF4/7guKH3kkPle9dZ7v3hQTmd+ArPOAQn614SY73HqDt1EOyX29QbePBc+eJdcqayjeWROZRu1ymJQke8TtqD7hqAw/yr2mQZs0bAIIW/Wfpul3cj6s4DA8dL9M3q5Rk0SO9ABRPEsetqUzapbI50DbKoDWa42GlzONKlYFOEgm5t5V432WndVPmIId1s1nkWtficoboh8ElfnbMGaVf5n4qB0wSg72CfAJDHWaJ5nQM2Q5hC6NKPJhIjVJqy7vHgXmPdUPDYud52jMFdvZdo/lXy903FVyaMil8zPwnLzZ9gYg5cHWcCDIRY+pXyU0pFqBInkTFxGV2dAOcidPtJZchpqJfWz1JToLUbHfqa7FlKVZQxyiBoYEtTd4gPHiKkJHL5Zs1T2miU1cjEBEN5uCmQEnqeWVhwyd7EtOrEckoAvxvkqc0/BCfKdAcyd1Irq3fYHkMU59nFqXdDjnScBWMBfSYD5zm5jntfH7jNRf++iD9YKcLnlmzIDSJpyoliTDc/IdJvh9LJRPkEAGjrgdatS+7u0mez62BGlkAsxB3I0etAAbXQjnLI9TQLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gej7AJh8INbmf+WBKajCq26qY7k6I2MoqBZaf3q616FOucNNn6vlhzAlFVIL?=
 =?us-ascii?Q?y+bfCFbR1lBP8tCxoYoH5ypJdVsvD2a7WSnD6varkhVaTXSTe3Y11ZSELkn8?=
 =?us-ascii?Q?qGRDd+PqzG8iVl4+AErZ4m+tGOx5PbREL8UM78eLxgPPbkZvYrahjf+gpMWi?=
 =?us-ascii?Q?rxpBDhWFY87iHuoO/3hk6P1zOcgP6DVkPQUka5K+tPFTocS5yIlr+u1ndb/p?=
 =?us-ascii?Q?zbshzQ9f6b3CXr+861jmf9SDkrn+/uxkmbwfg2hdH8Mtz3pYBTu0XW5Yi6Vq?=
 =?us-ascii?Q?ljPcyMjpbAGqjRX+JZ8Tp7AWmjDNstwHTL2ETmJQ6uYiBzePKovg1cBdmwR8?=
 =?us-ascii?Q?1Vb89FrA2TA2qn2NNXQM5UgBdFDoCINDmji3EdZ7nmj+eg/YfdIFOMH0UbF3?=
 =?us-ascii?Q?7rnwAPQZucNQ1GBlqOr9yMeL2wgSPot6tvrcVOzJHCNA21z43grzWZLzsybn?=
 =?us-ascii?Q?IHHkDMls+OxMqUJq5mrjejhFZj0uTc5Ld0vFFDX2xNyYrV7t1dzJf7btS2kQ?=
 =?us-ascii?Q?gd8zTTO0TGeVv2WOmYH0bjO2xjH2V8W5xaBBfSrawUpPESduDJVgtf1q7bNj?=
 =?us-ascii?Q?j8dOs3RjHybA8MY3f+TztWlsKa88ef0MT4a0k281r73xj+Yij14I8OAriQFQ?=
 =?us-ascii?Q?y68AA44EQVEKF+DnKYNKk5HNmAJiHnpgJO2/MetZvLzaX/xQD5dq5sbgjrbb?=
 =?us-ascii?Q?sgK4Zbj637IxD+8AT3VL9PgOyrxRgltyPgpiLMvrnu6l3cuUmuXMnIY0RciM?=
 =?us-ascii?Q?jcDiB0OxNpvO+kEwBXC0O7PaCQPLEhzkobP1EGchwDKcVzQuFdOzucMpoLsa?=
 =?us-ascii?Q?v/gEzW0CJmGB4vJZYY4ZI1hFlwwBAMT11u0eWTLgT4xGQS1C364i2wqdlnJA?=
 =?us-ascii?Q?lYRhaPcsaRbEILl3xiUEALkuavjeXbYVEoUeI1UZZ8hGVmYHWSTlrwf2HmFa?=
 =?us-ascii?Q?4i7WiqO1v/D0Y2h4B13MD7TazB13GMZUd9M3QNrE8pu42gF6RJic9zIy028A?=
 =?us-ascii?Q?0watMFi5NUISoqRjL/2XfC9O+OAnX0JmpMSgrWMV+CmBETCflkLyrIHwZDB/?=
 =?us-ascii?Q?SlC1hTFBGINi49TovMleSBRBIALEaivtEHEBG2B97I7+KJ+1aIC8EVytrKjm?=
 =?us-ascii?Q?a1uo/Ac5uJ98z7MXcRQ9bhw5hLm0hCPToqSt/x+z81zeCAU0QSG0L85Prfon?=
 =?us-ascii?Q?JOzvD6sstKoXdbquhWhMmyxxZ+E2Xe2XbXCvwbwr9PBSWCchcm9+3sRyK1b1?=
 =?us-ascii?Q?cblRVcwKXqLG0kCgQTVV6m1HMWfLGaM1DG5R4fDkaWOSGFF35H/gLGqk5PeE?=
 =?us-ascii?Q?TfkkstAN+S558w88JWkSXLxLuVVCKkDzEGbfzj7HQBEQHaJlnovrbmH0Djy5?=
 =?us-ascii?Q?9y85FNMpu+3g6aRJ5wyzWdvSTfK/KhCwegFltc8TaiG8aWS6S/Zag5MWYskB?=
 =?us-ascii?Q?gYtnrTCVzPikbIjaf47q/tonSsWnz+krBFUneY0v++kCtJc7k//e7eaQX84l?=
 =?us-ascii?Q?3vJ9VjqV4TOsRSRfq6gTTW214/Ymv6iV51Bv5/0WH0ZuxbgLawGyvmuDdrDc?=
 =?us-ascii?Q?UB5szzwZ17DsSkZbmYjS32uWWP38WsmMzd8wM8Ti?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83abeb0-23b8-4611-fb2c-08dc5e2afbfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:36:29.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jL0C+v0q74kmRDRCEcQQl66EOfAuf/TBk4MQJQYFeX0+/B4wbH2s2mMBXhXH9uS/8iRJNKqOqDPstG0Nz3G96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9549

On Tue, Apr 16, 2024 at 11:26:37PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add dma support for lpi2c[1..8].
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index b8ef9b938856..5c08e8787989 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi

#include <dt-bindings/dma/fsl-edma.h>

> @@ -316,6 +316,8 @@ lpi2c1: i2c@44340000 {
>  				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
>  					 <&clk IMX93_CLK_BUS_AON>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma1 7 0 0>, <&edma1 8 0 1>;

1: should be FSL_EDMA_RX

Frank

> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -328,6 +330,8 @@ lpi2c2: i2c@44350000 {
>  				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
>  					 <&clk IMX93_CLK_BUS_AON>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma1 9 0 0>, <&edma1 10 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -692,6 +696,8 @@ lpi2c3: i2c@42530000 {
>  				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 8 0 0>, <&edma2 9 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -704,6 +710,8 @@ lpi2c4: i2c@42540000 {
>  				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 10 0 0>, <&edma2 11 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -881,6 +889,8 @@ lpi2c5: i2c@426b0000 {
>  				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 71 0 0>, <&edma2 72 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -893,6 +903,8 @@ lpi2c6: i2c@426c0000 {
>  				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 73 0 0>, <&edma2 74 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -905,6 +917,8 @@ lpi2c7: i2c@426d0000 {
>  				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 75 0 0>, <&edma2 76 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -917,6 +931,8 @@ lpi2c8: i2c@426e0000 {
>  				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 77 0 0>, <&edma2 78 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> 
> -- 
> 2.37.1
> 

