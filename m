Return-Path: <linux-kernel+bounces-94145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C10873A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9A81C20F1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACD91350CA;
	Wed,  6 Mar 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bbj+2eN2"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C5134743;
	Wed,  6 Mar 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738377; cv=fail; b=qobCWcKgnwuqBD2/h8FxJBhZHgSdCK5zKNQHzRUoHtEPwQhODV8Fye5LKRwVaBnzNuItqXKjb/ot/cssmC7fcDYYtV5X3XwEfTw0ogma54ptJBn+ODj9g1c7M6PBv5/AKHMShhferaFS0noVU3QOBM2/Pux1wQoN3COJ3RqpSXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738377; c=relaxed/simple;
	bh=BDh7cymQ80HV3BGLG7HjGzQj8q/uUUU4Mo7/mxXBl4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eAY0qk5RGBYqpex+a3dkhAkTvS9eKgRWi4NarSzFvxLqiIrWwu+fEGAuxUeIq+8elWudElImyJRNR8dpSp+dI18ZoNU0sAJigoXbrRHNos2UhjNSX8N4oxY8tJcMXAbhnk8h/OY6MZ9nXn1tdirwHkvrnQwfmji0S436lgJczQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bbj+2eN2 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.241.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUA5lRLaGR7ZkHGCLIGpfzJb93z9GzJpRkbuF//bu4Ib33+/p2vXpcgr+HM4znQ6me3y4F5ZWh76n/1MXpm5BTzN9/P2f2EjCt1ZBQZ7OJhPIaXpB5h6jOkMLysXghjy6icxWfL/9VQXulN/pl6oObOx4hT7l/QtX4CNsFvn0KsrP/KVMNHrq86v45QXCy2Ro+8SWMXaHk/Yi4LWg9ju44uKEsz0lhadqJt5SFt1mB7zvP4W5+HPZg7rbli3GYm23NuWPqX/eSoUhq+oLTrzrJ9xvWAVAGJCfbtpRqbVtoJwNRN80AeIqu65kCoTGoNbqNQ+2Dd81rS+VKotMfj0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16MaFxYz0wUjxg2o0FHO3pRXFEPtXTGXEZrc6xfRpKY=;
 b=jaBorgau3waaZ3B7He01JocOtgYX0m5lhVD1credI5pZDKdxnrOceUmbGFfWADwhct6oE0UOo7oVfcjjT5lOq1Bv49WXfexsMm9ej0b6zsXpVZtE0lYHAqGJQpQJoV1cL1ANTW8TAO0bHL+n8vzJbetJ9/rgIKvIMcZU+dbMufdXytmL5HWb8QHHnegcgIGpw3S78OLGd/DEajVtuuE1V6QdpJL75dU1yXcOpgW0oIUKc+vrb/mtTnK5kSFwv67dBizequVitELsSaOLZ8u2QQpQd0RJ5vTMbG2WcEq09JjJ2HnRxN59dE3DSGYpJY1N8FkgbL4LSY4BERu8eToOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16MaFxYz0wUjxg2o0FHO3pRXFEPtXTGXEZrc6xfRpKY=;
 b=bbj+2eN2sP36eP2TW2w+xb/QskF4+oF8Z47cnY8YTivPRzOWmpXnBDfyaZFJp4U1aXlstLu941rO1PEdXXQc786tqmbap/ugaWU+2+v8dBEKzj0FstBmpxvW2RatyoyH7uiDpoapErcHSB2jjq2tHUpHIXa0ZZlLZnGMl+mGAMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9836.eurprd04.prod.outlook.com (2603:10a6:800:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 15:19:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 15:19:29 +0000
Date: Wed, 6 Mar 2024 10:19:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: imx8qxp: add asrc[0, 1], esai0,
 spdif[0, 1] and sai[4, 5]
Message-ID: <ZeiJdoTqWd8h0Q5I@lizhi-Precision-Tower-5810>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-4-c61b98046591@nxp.com>
 <2177674.irdbgypaU6@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2177674.irdbgypaU6@steina-w>
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 13222624-1ccd-4136-2719-08dc3df0d106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B1Qa5fErxSX4Gi1ikWjzcyOZc0BmRmBvuSSpO7mCe9UTH9NhobRiwjdwKpF8k64/FWdfOtW4TVf4mYW1LMlKnQvn5WvDphiWTcofRu8uPneyMRHG8xt9aECrg7QPRimKzljafx31NV3jRRyo2G8iojoeUZESPoJe08fwgxsB0HD7X3sSTIiEbDXjXTshk6b1CZwM4mzJKHjvmNgC63Xi9we0imNyAzQwGjFhBUi1kp+Jivujs5ShEFSQ9KA9++wZJyNZs9BCBSM3hVj9Y4YXXW0S73htyJsQuT7QYt5Mxy2oOkC4TliFAAwdFOcycde+a7eame8tms1M+eHz/W9PAXESm9o3aiNJxamqTNFnkZqlQb/HXZ59expjthUQFZpyVSJPHEou0WeEkiD11qPL9rt9SQM8c3f0UQjdV69LX02vpK+Cggjml95o5lm97JLxwE7+kiF0abq4oTLBcSHMKWp41dszgtpKHfzWFXQrk0kEFBxWy6dQI1UAiPvKNDMlrLm5RGxqk06vv8tJzGnJn+QobwQNqjI5up9XzvlEppUKCkhKTPzugJ7TO3DxQEoeT+eVwefSMikCnmKFnVMhSJ+dtU8eBteLTj/3eGmcC9UHxPBqeQUQBomHICAXHPTbOQ4KDgNf6ZpX3xjSr9FFGoh5wOlrQu01NY4OHF+vAgE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?SUsXpVpIXCToiRooe0Pqt5of1O0fj55GwknxPvkjyhYArdC69beBcGlfL8?=
 =?iso-8859-1?Q?nw8SuxqOi+bj2pT1F4nyP7IzSy5w5hj3VwJ/XSG2mNFJAdvbTB4T/WupAf?=
 =?iso-8859-1?Q?YDcD2rpQlU+EfFKcXlzB5rBt5kIsuB5yKrZ5ECqkRxvclzStAJnLC+yAcM?=
 =?iso-8859-1?Q?CC5P2tWhLbA7nYV0i1N51bU2FYMNJQRLL7CFaQIWxsij6/G5DYf02hw+U9?=
 =?iso-8859-1?Q?+tazWO63pkM/xGt9iahc6lAInARJTV6KcYRp81/xxYHvw+eFKR4sITQyPG?=
 =?iso-8859-1?Q?8UrV1twXCFP2TWZcJ6hMaxaqRjrIa9wbvtONSyPAkIuaFa9fPRlm9lfd+3?=
 =?iso-8859-1?Q?tCykrekppJwvii2OxJbdMzS9EXSAEnaLufdX0SCRqYDTe4cEYP7qjPbZQz?=
 =?iso-8859-1?Q?EcJ3AXZwTJC2lSkZyBRlZ/hClZaDJ3nKWdWD/gfRH6mByaX8j/DJbdlR26?=
 =?iso-8859-1?Q?lTUOyBsf1XJHqj9970yxgB2r+qTrWbIZ1tsQllvMVT8wtGNyi5OHwSW8Bn?=
 =?iso-8859-1?Q?xmHwpu6NVpahWQYy0XLGWbKOQ1yo8j+A1uU/jCKsQrrPlADgwfx7tG9Vsq?=
 =?iso-8859-1?Q?wfvaE4/HovO87L5gmRDqlVWvWLcLOmGwoBWWG2nuxxMlVoyH7wkmQeAzX4?=
 =?iso-8859-1?Q?1WC2TRtvkw/+NkeG3SkA5IsHKCDfighmIHlhUGok8FGs6y4OmENCry/Jd4?=
 =?iso-8859-1?Q?vaFr2u1gW5xwxMm/vgUw5PTxCIIImn9z4WXEQWDMjKN32w9Kn9AgqUZ6Iu?=
 =?iso-8859-1?Q?K/N4GJqtYgrTbXcM6GOZPPNipAdjAlKZ5F1za9NDag0LSEQxKewCujHC2m?=
 =?iso-8859-1?Q?MRFbkA1X49jAq+XbxArQZb8maE4w+B6o9fQgfZZbc0FjiTEv3C2LFFy3gk?=
 =?iso-8859-1?Q?jRY942s5Lk+1mtqYnNygCtTNIQaKMrR3jyaepCkCpOP+OgFUdr+S7P8NR9?=
 =?iso-8859-1?Q?roIhnWP16M5eNjEQjgyUCJ4YLVUSkcqMvIwqPVJRNdnHotPFVCupLwN0uM?=
 =?iso-8859-1?Q?fec7GBKXD9hROQd8TNNypX8VBh8qKvLV9FBuKiE5ZAQgl/tfVvaIdOGqIq?=
 =?iso-8859-1?Q?NAKoGsSWYqB4MU30Cl7wwWoh8HhhoNhXso8TGoXvQLKv7Uilp+cgERsEfA?=
 =?iso-8859-1?Q?cbLf72pCTaCnmJomqcd6H60rcpYXjDAAYdH4EBGX6iSUiXWPp4SvgeHHvE?=
 =?iso-8859-1?Q?qV6fGDSveilDt07zyzavt+kosMotACsHwmutEM+051s7vSL/XIbd+g5eJ9?=
 =?iso-8859-1?Q?HkXdpsAOjf98BYxp0bWMUABLH90Y/FKMo8e+KVrt7CLTzfQ1DhOaWUnqcZ?=
 =?iso-8859-1?Q?tOFYasufixUicI7eWKERym9qlimOFffUpaBb3PTA0hJ1PSqWA9AqllHfvW?=
 =?iso-8859-1?Q?xYhxyLFNcDk18FXzBOVbSCMQ5W9Wjh9wRow4esFEbqaydHfpjJQjyhHx9e?=
 =?iso-8859-1?Q?bER91f4JnBLfCm9klV3sHZzjD9gln/d26mi9j/AXAhJV3z19iE0+6huAmu?=
 =?iso-8859-1?Q?q3IgcqCH8i4MfxkGBjvXiEnqvvL3J6LFcJSdviSopFmHax53b5Gcz6LpAM?=
 =?iso-8859-1?Q?M8UPeHy/on++m2pRaNGOPUXEfpY/TTifbS65SRtLqcnUk0eeNk7kyCKDmt?=
 =?iso-8859-1?Q?PnOPG7eYHnTqQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13222624-1ccd-4136-2719-08dc3df0d106
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 15:19:29.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGOnbIo8esU7v8X7NO89bTIjyhm/dyjjdRdxI3oqV6C3YLTVWJJh4jIpf0p3w3e4ey85EupjxKAdf1lDO8FFpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9836

On Wed, Mar 06, 2024 at 08:20:00AM +0100, Alexander Stein wrote:
> Hi Frank,
> 
> thanks for the patch.
> 
> Am Dienstag, 5. März 2024, 18:33:05 CET schrieb Frank Li:
> > Add asrc[0,1], esai0, spdif[0,1], sai[4,5] and related lpcg node for
> > imx8 audio subsystem.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 304 +++++++++++++++++++++++
> >  1 file changed, 304 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> > index 07afeb78ed564..78305559f15c9 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> > @@ -6,6 +6,7 @@
> >  
> >  #include <dt-bindings/clock/imx8-clock.h>
> >  #include <dt-bindings/clock/imx8-lpcg.h>
> > +#include <dt-bindings/dma/fsl-edma.h>
> >  #include <dt-bindings/firmware/imx/rsrc.h>
> >  
> >  audio_ipg_clk: clock-audio-ipg {
> > @@ -481,4 +482,307 @@ acm: acm@59e00000 {
> >  			      "sai3_rx_bclk",
> >  			      "sai4_rx_bclk";
> >  	};
> > +
> > +	asrc0: asrc@59000000 {
> 
> Please insert nodes sorted by address. ASRC0 is the very first node.
> 
> > +		compatible = "fsl,imx8qm-asrc";
> > +		reg = <0x59000000 0x10000>;
> > +		interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&asrc0_lpcg 0>,
> > +			 <&asrc0_lpcg 0>,
> > +			 <&aud_pll_div0_lpcg 0>,
> > +			 <&aud_pll_div1_lpcg 0>,
> > +			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
> > +			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>;
> > +		clock-names = "mem", "ipg",
> > +			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
> > +			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
> > +			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
> > +			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
> > +			      "spba";
> > +		dmas = <&edma0 0 0 0>,
> > +		       <&edma0 1 0 0>,
> > +		       <&edma0 2 0 0>,
> > +		       <&edma0 3 0 FSL_EDMA_RX>,
> > +		       <&edma0 4 0 FSL_EDMA_RX>,
> > +		       <&edma0 5 0 FSL_EDMA_RX>;
> > +		/* tx* is output channel of asrc, it is rx channel for eDMA */
> > +		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
> > +		fsl,asrc-rate  = <8000>;
> > +		fsl,asrc-width = <16>;
> > +		fsl,asrc-clk-map = <0>;
> > +		power-domains = <&pd IMX_SC_R_ASRC_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	esai0: esai@59010000 {
> > +		compatible = "fsl,imx8qm-esai", "fsl,imx6ull-esai";
> > +		reg = <0x59010000 0x10000>;
> > +		interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&esai0_lpcg 1>, <&esai0_lpcg 0>, <&esai0_lpcg 1>, <&clk_dummy>;
> > +		clock-names = "core", "extal", "fsys", "spba";
> > +		dmas = <&edma0 6 0 FSL_EDMA_RX>, <&edma0 7 0 0>;
> > +		dma-names = "rx", "tx";
> > +		power-domains = <&pd IMX_SC_R_ESAI_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	spdif0: spdif@59020000 {
> > +		compatible = "fsl,imx8qm-spdif";
> > +		reg = <0x59020000 0x10000>;
> > +		interrupts =  <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>, /* rx */
> > +			      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>; /* tx */
> > +		clocks = <&spdif0_lpcg 1>,	/* core */
> > +			 <&clk_dummy>,		/* rxtx0 */
> > +			 <&spdif0_lpcg 0>,	/* rxtx1 */
> > +			 <&clk_dummy>,		/* rxtx2 */
> > +			 <&clk_dummy>,		/* rxtx3 */
> > +			 <&clk_dummy>,		/* rxtx4 */
> > +			 <&audio_ipg_clk>,	/* rxtx5 */
> > +			 <&clk_dummy>,		/* rxtx6 */
> > +			 <&clk_dummy>,		/* rxtx7 */
> > +			 <&clk_dummy>;		/* spba */
> > +		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
> > +			      "rxtx5", "rxtx6", "rxtx7", "spba";
> > +		dmas = <&edma0 8 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
> > +		       <&edma0 9 0 FSL_EDMA_MULTI_FIFO>;
> > +		dma-names = "rx", "tx";
> > +		power-domains = <&pd IMX_SC_R_SPDIF_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	spdif1: spdif@59030000 {
> 
> That's imx8qm only, no?

I am not sure what means. why do you think it is imx8qm only? It is for
imx8qm, imx8qxp, imx8dxl.

Frank

> 
> > +		compatible = "fsl,imx8qm-spdif";
> > +		reg = <0x59030000 0x10000>;
> > +		interrupts =  <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>, /* rx */
> > +			      <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>; /* tx */
> > +		clocks = <&spdif1_lpcg 1>,	/* core */
> > +			 <&clk_dummy>,		/* rxtx0 */
> > +			 <&spdif1_lpcg 0>,	/* rxtx1 */
> > +			 <&clk_dummy>,		/* rxtx2 */
> > +			 <&clk_dummy>,		/* rxtx3 */
> > +			 <&clk_dummy>,		/* rxtx4 */
> > +			 <&audio_ipg_clk>,	/* rxtx5 */
> > +			 <&clk_dummy>,		/* rxtx6 */
> > +			 <&clk_dummy>,		/* rxtx7 */
> > +			 <&clk_dummy>;		/* spba */
> > +		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
> > +			      "rxtx5", "rxtx6", "rxtx7", "spba";
> > +		dmas = <&edma0 10 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
> > +		       <&edma0 11 0 FSL_EDMA_MULTI_FIFO>;
> > +		dma-names = "rx", "tx";
> > +		power-domains = <&pd IMX_SC_R_SPDIF_1>;
> > +		status = "disabled";
> > +	};
> > +
> > +	asrc1: asrc@59800000 {
> 
> Insert this between dsp and edma1, sorted by address.
> 
> > +		compatible = "fsl,imx8qm-asrc";
> > +		reg = <0x59800000 0x10000>;
> > +		interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&asrc1_lpcg 0>,
> > +			 <&asrc1_lpcg 0>,
> > +			 <&aud_pll_div0_lpcg 0>,
> > +			 <&aud_pll_div1_lpcg 0>,
> > +			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
> > +			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>;
> > +		clock-names = "mem", "ipg",
> > +			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
> > +			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
> > +			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
> > +			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
> > +			      "spba";
> > +		dmas = <&edma1 0 0 0>,
> > +		       <&edma1 1 0 0>,
> > +		       <&edma1 2 0 0>,
> > +		       <&edma1 3 0 FSL_EDMA_RX>,
> > +		       <&edma1 4 0 FSL_EDMA_RX>,
> > +		       <&edma1 5 0 FSL_EDMA_RX>;
> > +		/* tx* is output channel of asrc, it is rx channel for eDMA */
> > +		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
> > +		fsl,asrc-rate  = <8000>;
> > +		fsl,asrc-width = <16>;
> > +		fsl,asrc-clk-map = <1>;
> > +		power-domains = <&pd IMX_SC_R_ASRC_1>;
> > +		status = "disabled";
> > +	};
> > +
> > +	sai4: sai@59820000 {
> > +		compatible = "fsl,imx8qm-sai";
> > +		reg = <0x59820000 0x10000>;
> > +		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&sai4_lpcg 1>,
> > +			 <&clk_dummy>,
> > +			 <&sai4_lpcg 0>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>;
> > +		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> > +		dmas = <&edma1 8 0 FSL_EDMA_RX>, <&edma1 9 0 0>;
> > +		dma-names = "rx", "tx";
> > +		power-domains = <&pd IMX_SC_R_SAI_4>;
> > +		status = "disabled";
> > +	};
> > +
> > +	sai5: sai@59830000 {
> > +		compatible = "fsl,imx8qm-sai";
> > +		reg = <0x59830000 0x10000>;
> > +		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&sai5_lpcg 1>,
> > +			 <&clk_dummy>,
> > +			 <&sai5_lpcg 0>,
> > +			 <&clk_dummy>,
> > +			 <&clk_dummy>;
> > +		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> > +		dmas = <&edma1 10 0 0>;
> > +		dma-names = "tx";
> > +		power-domains = <&pd IMX_SC_R_SAI_5>;
> > +		status = "disabled";
> > +	};
> > +
> > +	amix: amix@59840000 {
> > +		compatible = "fsl,imx8qm-audmix";
> > +		reg = <0x59840000 0x10000>;
> > +		clocks = <&amix_lpcg 0>;
> > +		clock-names = "ipg";
> > +		power-domains = <&pd IMX_SC_R_AMIX>;
> > +		dais = <&sai4>, <&sai5>;
> > +		status = "disabled";
> > +	};
> > +
> > +	mqs: mqs@59850000 {
> > +		compatible = "fsl,imx8qm-mqs";
> > +		reg = <0x59850000 0x10000>;
> > +		clocks = <&mqs0_lpcg 0>,
> > +			<&mqs0_lpcg 1>;
> > +		clock-names = "mclk", "core";
> > +		power-domains = <&pd IMX_SC_R_MQS_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	asrc0_lpcg: clock-controller@59400000 {
> 
> Please insert he lpcg nodes according to their address.
> 
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x59400000 0x10000>;
> > +		#clock-cells = <1>;
> > +		clocks = <&audio_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "asrc0_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_ASRC_0>;
> > +	};
> > +
> > +	esai0_lpcg: clock-controller@59410000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x59410000 0x10000>;
> > +		#clock-cells = <1>;
> > +		clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
> > +			 <&audio_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "esai0_lpcg_extal_clk",
> > +				     "esai0_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_ESAI_0>;
> > +	};
> > +
> > +	spdif0_lpcg: clock-controller@59420000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x59420000 0x10000>;
> > +		#clock-cells = <1>;
> > +		clocks = <&acm IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL>,
> > +			 <&audio_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "spdif0_lpcg_tx_clk",
> > +				     "spdif0_lpcg_gclkw";
> > +		power-domains = <&pd IMX_SC_R_SPDIF_0>;
> > +	};
> > +
> > +	spdif1_lpcg: clock-controller@59430000 {
> 
> That's imx8qm only as well, no?
> 
> Thanks and best regards,
> Alexander
> 
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x59430000 0x10000>;
> > +		#clock-cells = <1>;
> > +		clocks = <&acm IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL>,
> > +			 <&audio_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "spdif1_lpcg_tx_clk",
> > +				     "spdif1_lpcg_gclkw";
> > +		power-domains = <&pd IMX_SC_R_SPDIF_1>;
> > +		status = "disabled";
> > +	};
> > +
> > +	asrc1_lpcg: clock-controller@59c00000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x59c00000 0x10000>;
> > +		#clock-cells = <1>;
> > +		clocks = <&audio_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "asrc1_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_ASRC_1>;
> > +	};
> > +
> > +	sai4_lpcg: clock-controller@59c20000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x59c20000 0x10000>;
> > +		#clock-cells = <1>;
> > +		clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
> > +			 <&audio_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "sai4_lpcg_mclk",
> > +				     "sai4_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_SAI_4>;
> > +	};
> > +
> > +	sai5_lpcg: clock-controller@59c30000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x59c30000 0x10000>;
> > +		#clock-cells = <1>;
> > +		clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > +			 <&audio_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "sai5_lpcg_mclk",
> > +				     "sai5_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_SAI_5>;
> > +	};
> > +
> > +	amix_lpcg: clock-controller@59c40000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x59c40000 0x10000>;
> > +		#clock-cells = <1>;
> > +		clocks = <&audio_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "amix_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_AMIX>;
> > +	};
> > +
> > +	mqs0_lpcg: clock-controller@59c50000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x59c50000 0x10000>;
> > +		#clock-cells = <1>;
> > +		clocks = <&acm IMX_ADMA_ACM_MQS_TX_CLK_SEL>,
> > +			 <&audio_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "mqs0_lpcg_mclk",
> > +				     "mqs0_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MQS_0>;
> > +	};
> >  };
> > 
> > 
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 

