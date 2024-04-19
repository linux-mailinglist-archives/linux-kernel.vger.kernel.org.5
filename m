Return-Path: <linux-kernel+bounces-151587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DCC8AB0C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49166B2379C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39112E1C4;
	Fri, 19 Apr 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CU9m6yRv"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526174F214;
	Fri, 19 Apr 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536905; cv=fail; b=n6QmItfn/eK+cL1t9C03H40WQi9nsZsixv4pTnyrqzGaPRlyseyQhuC4iskqdazupv8FINeGV2MXOn96hnTRwtBhsQNrHX5sKbnRFFQI01yi3M7u1eyukQAFy0pxEdSSV1kuN4bYUkObCvF8PTgrC9A4gGT/F+YqQZwzqiETq9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536905; c=relaxed/simple;
	bh=vwCtR84FLS6urpXFpKrpK9F6NEjcfaWVV7vn54ERmG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ASoQEIrZ7yzIrR7WehcMwJLQChwH9d+IBS3W3VgNvNRSYZsA5WiCjy5ot0X7NaEPtTwuqwX1ROMoRLcCGKIOuh64RrV4c2rPfgAwcI4dzas2L0mUEiJgzOzA3Mk2Npd0o/vh47hNCmCNUqEYRQJckDkvySP/0Q0bDi56JO/cSZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CU9m6yRv; arc=fail smtp.client-ip=40.107.6.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpiBITgGU4slfwIkr5GgGlpgE5hiVZzIBPhIhZbVbgSBVVhxP8KkQNdLjQh2W6ekSUUbbMX/F6K/rDRQSEUn7ziwPe16v1F2+vlum/QRqF1KgcS9r/9F54mXCAlAL+P856pnhK8PWqoYgByip/DHmn5gI/2G8cUxOrvZ8pNP3RfG37ZBVG6jpECMCHBK23/0GOUUzs/YZ/IhqzG0ph23tebq+A77zwwpy//tIaG16kZb0yVyUuSkEM0xoeFyjY8VKp1B0S++4envSo7Wyn/wGxHBXhNhyxLZlfRzNArcuZe1WpeloRWIR+LIEfkTJeDAHE90RwbH7CgirOnB+eqWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeGlyxA8JqHJ2zRj4kJtUvTDJn2Sfqjj2mv6fNlz1jY=;
 b=SdDWxibbgfIGB4uLyPNijKPTibuKUHF4qju6Td7YeO6tk9LJuNyxqRz0wxhdoyArWxd+BD85Kc6W6QrnRnnOkQLWs9kGtb6Eh5ZZ9Ud2dVbq6m+0lSqVxuMQi3Z9TpwE4JwxYFd9Pod0E+T+nVuQFbNE0pqrOiFpDZbeQ++7tHfbe1Md6CoD4YVIG0Fvhj5q4En5GJlSdwp7xm6TdvIwlLWGB9S2b2N4/e8rwZpB0rzwEdIaEpCsxvXjK+k9pk9po6+tifWOn/9rH1Q/c+alXBGhJmEpmIkP/QSVyuhFHttYNw91bt4T/ZQ8g55rwXUwHHegCK1JvEtKfubyJP1+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeGlyxA8JqHJ2zRj4kJtUvTDJn2Sfqjj2mv6fNlz1jY=;
 b=CU9m6yRv1+xSK0Z8uWkH96G/b6J12L4lAzq1HHcAbX5Z19iYrSERFbC1Fo8gfg9OfpnTBEeIqi+CFS4kyurJ0i3w5e4xTXQLCZD1gf6/SBYbeJkBM30EnXI5zn90C8EATNyhanAnsVktB1/4lqs/11tCY75U11YxThauFI+P+og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7123.eurprd04.prod.outlook.com (2603:10a6:208:197::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:28:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 14:28:19 +0000
Date: Fri, 19 Apr 2024 10:28:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 03/12] arm64: dts: imx93: add dma support for
 lpspi[1..8]
Message-ID: <ZiJ/e3GqaQynf9ih@lizhi-Precision-Tower-5810>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
 <20240419-imx93-dts-4-13-v2-3-9076e1d7d399@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-imx93-dts-4-13-v2-3-9076e1d7d399@nxp.com>
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b52337-e9ba-4573-9c30-08dc607cf5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UDhS/oKvPMlgMrE42dtI+K1MFSBlhvxo3jKrruWtpajfT7fjzkyu/kdS7+EB?=
 =?us-ascii?Q?HfGrCArBNnbPxYnuPyVxlj3GFaRVFfEXsecLvhleG7OA9c2MyhaQXJQiPsOq?=
 =?us-ascii?Q?I/FV7VC4dRF1FTOShb1fmkOr8KZ29NFGJRzSw2dA/LYAUsckY9pFYeY4DlW9?=
 =?us-ascii?Q?zbYVlTEeJFWlxT/4ZRwybHswxJCzVIGduvvh+IMDfWO05Okx/fDmPWNs5JE+?=
 =?us-ascii?Q?HI1JXyhBJNANYCNHmYJJIzTW7EN4UUcMzbLbtjCr1WcAXxEQ3w4TIlr4U/UL?=
 =?us-ascii?Q?gqATd1MygfAkPWBZy+gzqjs2YMMKv+aF5KdHK3GJvfsJKHN+7VrFS4vY/ba6?=
 =?us-ascii?Q?r1vChNDwTkqEg1swaxitpir+lWsqf7LjL4IxYB/uaQi+4/L9aQq24p9Wpnx5?=
 =?us-ascii?Q?aVACxcUrtENeXqwEQyAhbwb/bSDsURvCkf/H4lIkPgv12mK9o1bdzVP58juY?=
 =?us-ascii?Q?ZRaJs/clCxCNBpEbTeo6FBmnVVcOyVD++wGK3ll6bzMEqPTDqS47fTni7p8K?=
 =?us-ascii?Q?VI0mOaVZTmclzzyiKC09Tgp2azhIANDTPTtEoJFgvtf/MXx57A25+KHbbtSU?=
 =?us-ascii?Q?oCjq2l4YxNoJf/3C8GMo5HGVn8tyAT68lGh0DeOktdWEIxR8mrzvIeMckY9v?=
 =?us-ascii?Q?rgdjG176TkMK+4aIhANg8EtFc90d5MuouJiWk7AEMe27xX5/q9GNtdCBeSGM?=
 =?us-ascii?Q?q1AORW6022t51YGNfOQ7LOm9nqVDOi2EPLrKtdw33PIw2zAFvESVkq5gOuX7?=
 =?us-ascii?Q?jTceIVQvblLKBVymvWMvtEY+cSo2C4Vmzok/fCmlRlPwX7eLIKMkCU60ezn/?=
 =?us-ascii?Q?8ANtcNvLw7PVe1z+kwABK9JdzirfzQ3V8nOXLaxtEpmrzb9IpjpWmtvSN9pZ?=
 =?us-ascii?Q?VIgRh1KZ8qlyPSJ8CjPrTPQRTTox9+MLzYyn4F8V7cKJFrx4E2N0U+vczhIw?=
 =?us-ascii?Q?kUbJcvrLqBgg9ydnF+FLJmWxiPCfnc320vWcXOA6dNODv+FXIJ8kcLp9Qmyo?=
 =?us-ascii?Q?JHckY5pmsxLTIlYO3cFhaQVXu5/Q9AIMbWnMAym62IIySUdpaSOkCA3yncQv?=
 =?us-ascii?Q?4ZqilK1g5zhVg5PcRjemLoH6hifdBE60GXe6pgi3w+51RiKVbj+Pzj4AENwe?=
 =?us-ascii?Q?K+KIRzeyck3+PEigoZXPJUK7iE4M9Vlr7vK+sSwj/57rjNmAcKj6/HZBnM2S?=
 =?us-ascii?Q?IezpaSfUppg5yaCTVho4284vL1Lu3/uiYiczSDGfwm4wXr11UO82vO/FkSr/?=
 =?us-ascii?Q?SmdW6zQeNdNv7qDPnGt0R8qf8cqXI9qEhu/k7wZYOUc2gK+VGtzKL7ZCNsYj?=
 =?us-ascii?Q?PXUkrNhFKTLYuqJ/VxnJMHSmYWJ1nvdIhA0TaQ60fpYzFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k4pdDn0t8rrTjMkcW9W44g4wg0xzCgbqH0Y7liseVJUwSToqf8e5Z/zCmc9A?=
 =?us-ascii?Q?ujDT5npZkjgJ/QGB2jZSPm24G1kHctaSULXAXY5U5JIzdaGS5LF/eQBTOlzv?=
 =?us-ascii?Q?RhTDc0eDV1bWgVXe47m5m2faWCqfidZjrNOS7aOxspGqhyy1dFHb4VWTBu8/?=
 =?us-ascii?Q?h4fPD0DxcXp3nWa3R/tkM/UuevuW8MG5AyKmzxuHKTefmJkho12ls+V5ZsAC?=
 =?us-ascii?Q?88spqpJvB+UDWRYAsJ8Y9TGlkAT4ueoYfoRAlr6tlMyUkyCCfh1ZYXnoKmTh?=
 =?us-ascii?Q?jbzlI3YgV5VO5JyzGTJ7c2FBD73uPB0OPM4GhL+DDw/NJN1A8pQ3v0vKsPWr?=
 =?us-ascii?Q?oi8zT96tgcWgvyNPLQCrFRWIQLPft4OtNstTulo55v3KaI/LFILrWT/2yoCK?=
 =?us-ascii?Q?N1Jjkmbh2240czEK5cP3zPOz76MVZkthYue6gEiohiFdPIYCwLoWwkHu0KQr?=
 =?us-ascii?Q?Zey467rhdBDxt04xZKfureCASRUgQYxpxujruj99ONpGELULLMduAMWXEj06?=
 =?us-ascii?Q?zuKQQyhCiQnjLqPOrB5QpPJOw4rJPp1NpHuRTPZVujvfVjomcFPE4KObrDxw?=
 =?us-ascii?Q?zYSV4f4h0A+coCCueko/46pB9kcFA0vLb67abkJciahHs0NferjChdG+Tl5o?=
 =?us-ascii?Q?wYMOQZUEzLk9cb/m6Lj6T3svZiTgILxqOKLU61YaXbjKyUNYr2Y+iuoQviwz?=
 =?us-ascii?Q?2uf1xpgmikuto002ZJXvLijyDFdEKdWUYsNwwv6W2Z2AI8ZBr7r7BRP2HDSa?=
 =?us-ascii?Q?gVVuTf4dF9/aAaDTfpGNpGgbQbdyXe1v2XC9uPZMuAkCcfui1VtUthmHNRE4?=
 =?us-ascii?Q?K/fycDgk1AyRUlL2p+hAGKexlXFDa2LNMemQ8Ql2KxwfUVT4PmIpwTvmr7nJ?=
 =?us-ascii?Q?KZ7aM/tUNOdGppngjQx9NPX4tSHqaSPTUM2BEf2SQDWAl8+MyOzNjnYOSA+b?=
 =?us-ascii?Q?n8lo/WH3ftOiHcD8qRicoKLUbBzcC5pmjg1Ta+3DtP4UMdTi0DAlk+NlYA9b?=
 =?us-ascii?Q?NGhtpR63l+tzNK3eD3q6fk08u7Q/z00sLVgx9VWt/LAfDla19KZ8jqmTDYou?=
 =?us-ascii?Q?jXAK5D0zM0gq51VR6T4yZPi1gJw6p8boUZJDr2SwNIU1a31te8xk6lIBleSx?=
 =?us-ascii?Q?O2xSBf4Pt/yeQs1pOWqDtX23G+HeDbTCKWjI9DHCfvc9B5m+5Gt1Wgyz1Ycl?=
 =?us-ascii?Q?AY1ynIKtUerE2+LylCvR9skEOqHENqxt7QFCjUL+b9sgilOOdahc5X4fN8dy?=
 =?us-ascii?Q?URcD1vq1uVx+d0WO1KtWcLva/ixgkRJ3zTsLV45Vv4MewV74K0+uGiF69Eji?=
 =?us-ascii?Q?WrMw+nQJEK8ICSYhbw3hXjR4yM9eTkyvV7Xc9pH0o2v8xRLbd/W7BTqAoCVI?=
 =?us-ascii?Q?6dD2T4MRnbWPHI5+wQmf16t130NHc8xdWTV6U5yDD3EXHjAUx/xoDAZwty3D?=
 =?us-ascii?Q?9ouwTdZO2NcfxFryU3GSiEW4foC7ykPUd/tM4ahc/Va3Wpo0sCtu4xfM5XUx?=
 =?us-ascii?Q?1F/11orCXnctGrjdsOQ5ayJIY+PbQRxIo+QwOh/jMEgZ9AHqsCZn7FnzIwCq?=
 =?us-ascii?Q?Rg3tiZ4I2xJNG0pmg008UA9D1emPlol8r3/khuVB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b52337-e9ba-4573-9c30-08dc607cf5d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:28:19.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx95y3ou0AtxkS03ASJIUxitvnQaAz66uxtkV70PU5OufUnQ5QY+UTe3I+iOfSxnRvAMCyfKPjycV4usRwZCwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7123

On Fri, Apr 19, 2024 at 11:36:58AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add dma support for lpspi[1..8]
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 93c1d0fae291..d762d96afcd5 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -345,6 +345,8 @@ lpspi1: spi@44360000 {
>  				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
>  					 <&clk IMX93_CLK_BUS_AON>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma1 11 0 0>, <&edma1 12 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -357,6 +359,8 @@ lpspi2: spi@44370000 {
>  				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
>  					 <&clk IMX93_CLK_BUS_AON>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma1 13 0 0>, <&edma1 14 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -725,6 +729,8 @@ lpspi3: spi@42550000 {
>  				clocks = <&clk IMX93_CLK_LPSPI3_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 12 0 0>, <&edma2 13 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -737,6 +743,8 @@ lpspi4: spi@42560000 {
>  				clocks = <&clk IMX93_CLK_LPSPI4_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 14 0 0>, <&edma2 15 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -946,6 +954,8 @@ lpspi5: spi@426f0000 {
>  				clocks = <&clk IMX93_CLK_LPSPI5_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 79 0 0>, <&edma2 80 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -958,6 +968,8 @@ lpspi6: spi@42700000 {
>  				clocks = <&clk IMX93_CLK_LPSPI6_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 81 0 0>, <&edma2 82 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -970,6 +982,8 @@ lpspi7: spi@42710000 {
>  				clocks = <&clk IMX93_CLK_LPSPI7_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 83 0 0>, <&edma2 84 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -982,6 +996,8 @@ lpspi8: spi@42720000 {
>  				clocks = <&clk IMX93_CLK_LPSPI8_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 85 0 0>, <&edma2 86 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> 
> -- 
> 2.37.1
> 

