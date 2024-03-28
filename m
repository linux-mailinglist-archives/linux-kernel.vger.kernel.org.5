Return-Path: <linux-kernel+bounces-123121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254189026D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45259293F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC412E1D0;
	Thu, 28 Mar 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cp3aj2l3"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92624E1D1;
	Thu, 28 Mar 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637869; cv=fail; b=CC0a2joH0xAdOUDq/aIhLqDfI/54ouj0PaYgCVUbFs6KyDhW6930tb6tFzFRefwNduJ+X0+oZASug7l8+lbICmDAz3+cYi9QpMeo3GuYvNL6GBYw3gcCT1QP0QshPvA+boLTkHKzvI4Qan+Ss+wr2bXUHRQatz8HyCI8C3aoZB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637869; c=relaxed/simple;
	bh=9d33e/6K6Mbjr7mqgEo1Kor+bna1KUVLdJHO9BBAYEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PQS6HlwRzt5tYBUmyXZFjk82/KoaJZETwpDj3KKvApVOgLfUciwVLUn7xIPO1ZvN4qtzA7Nrmy2ePImby6qxLIBBZy6LAdU62z/KoolwsB+Eef8xodiNHFh08bu8cf4CFs8U5jAbAmRy5zcNNXmblSue2lTNzLaLRSda5ANOYeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cp3aj2l3; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWxECZGio8lXMOIdmMiPxDyOBUDmmJPm0RMHJcDEh+OrondtSoriE0YykBIBltl0tsN2ZIiC25DIhbzywyV8GUcZR6yddB0h3qL9AWGDug/XY9JOlE05ACsH9u+R8esj7LTk4/0hcqWXe6O5ha+vS7CNvqRK3R+Igc1gy0lyOG0Y2+N6jKeML77ThLS4Ep0DN82CtZ72pDuBWK9igf5Bx67dXMhaF9E2c/B/D+ZjhzoB03Tl9iXtQQNK17aMbgGBaOSxSeKdSO4I1I28V7AuQr3aV8a1rciQp1M29IOVN3qAILo0QX/YeyUw67Bh5m7OyUBhx9SNZFtDlVCl1j67Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSvmBxIjPfT6Lac0xlJdvmaJnNMOZtYa8B7ViXb+jvg=;
 b=GeGKw2lBLxVBzBXYTXgQNPf9fFH7mTpW07aPGpH2pMVc4r0u5zXxK/XxynAJ+3nL4Tj1/E+29QPSLkQwrfVhAN29afB8wcCHPMfDqhMgeQFVr/24x9+l6OZmfK7zOiJ59tcyTOw02x7aIYa4Ffo9jpdotF23fS99NbJnAKoDjz64CDmaV+4Wxxn3/Z3y5/yEp4T3y4hMaGGgYg5FMKuUjoCJ7Fm+GMvQiMaLTkITvc7mBZAWBBLlFWMyr3Ojx1tRqnTmYOahmDR2xxLYD3KOw3dTrrI8wsnSWD51sugofGWV1Hc4kQ0hG20RbzmpElKZcRBhFXF7UpeMoy2PoFJsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSvmBxIjPfT6Lac0xlJdvmaJnNMOZtYa8B7ViXb+jvg=;
 b=cp3aj2l3Jr15nFvkTJlGy4xqfji+iyYC3+ZGq3hYNdnjmoe928CkADqzpZrIDlJmV8IqFmODzuDpeAKAfOMHhgzWFUq+OFsZppJzZAApEbcm4HAai0oAP+GYLBfMfDlZrhQU7gsfmqfskH3J5CQDk1AO83J+oJOT2vDZzafm9aU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7916.eurprd04.prod.outlook.com (2603:10a6:10:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 14:57:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 14:57:43 +0000
Date: Thu, 28 Mar 2024 10:57:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8qxp: add asrc[0,1], esai0,
 spdif[0,1] and sai[4,5]
Message-ID: <ZgWFX70McJc5PoNg@lizhi-Precision-Tower-5810>
References: <20240226192130.259288-1-Frank.Li@nxp.com>
 <ZgV6a7ZMwM4aR7f+@dragon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgV6a7ZMwM4aR7f+@dragon>
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: fb717032-b944-4cbc-5987-08dc4f376c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bnmXTbHUkAO7Ug6WSjDghP8vfkuW7fMtncLhRJ5PiaDYBcPqvkb5ocwRXCj2rWEamwZZqWq+8oOg/nhEZ7zUXOXWwxHXcwwTTaBG7DqaiL0QJCYVvnvBeu/cqhYl9yEPGl2SkcEy34mPnezoHCzGOmHJQm+5IdnDOkSk7nDlZFDJIXKot4ysPYB8sDXyDp+RuAXk94LFiMh90PoFasqfBi4vii0DTSsuxb0GClspHK3mRVVL3YTChGDzJ2hEJBieILtrwD4UBo+W61DCFAbsIfB9cPoH1PUV6tp6GrwMguG9a4+UaCT8ty7anjiqnXw+QY/JlwVudmnatPRJeAs44/vk81GYNHrWagG8SUvmnxWyie6jgkgxO/YfPvIX/TWh5ppY/HEVfkLATCGooYlFhPkhFA/9Hq6ZVMVFd5fx/3ZGBHd0NpUzkyUC7MGwbXOzKTObU2aY+ERRlJjVYfW/7ij9xMmQRv3c+wwXEqk/loL0hcgz1UH9PyY5l4Q5lauVCkk0kFIp7c0n8BGOqjf0VLL8FN/jNn06heMYdS018OkrG4o0OiRVd4r5MsBmfY9+bjK38ssWN6EETHfFA0+PJXEQIebBPBfHo8EVStosCHrWsA/UkrIhARbqocodp4M/xYe1SSiUCdtw2pBut+GFy89Jo9+//GwsA4WtsFsss4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1XRmNBNU+vDia+SgCCqOF0XGhPsnMaUs8jGnq6AfP6SRHnoojxa/23Wn9ld?=
 =?us-ascii?Q?myucYUlhK8bH+qkf2uP3bSN0qBqK9Bs28yjmPtEBg8BFnzq2lW188tZNc39W?=
 =?us-ascii?Q?rt0E3dS+Jl6BWlpUGHxn627siWwPXR35ehsODSH3/jArjsGKf0uHq9MV+cqU?=
 =?us-ascii?Q?M2J8wY9v+pjAuR2LIAZvcBHbrWNic+mB61qEejZwcC2tYg6FJpG9PB2wa9+9?=
 =?us-ascii?Q?HOUolhtVkYGlfDNL4cuNKCgc+1UB2Te/aodeEetCLR1mM2kEH8EdLR78Kdm1?=
 =?us-ascii?Q?9qbEuuW1fik8PR0GEV+nCD/5p3B0+lRwcWx7LfABCqDAqWvxdKPStwIn2hl+?=
 =?us-ascii?Q?NGNsvWy2+ro3GyELnZ0/9oMltdGrlNXdo71AOF9UvWcHHrSdsKdaRwxSVJ7i?=
 =?us-ascii?Q?VntGLDvgeteI8B2x+dLkLPBde05KTQcWg1TFSVogtYxKPTW9eLsyVyhEpFCf?=
 =?us-ascii?Q?ziL0YUWasrKjNaaRF9vYq6qio0AijHWQsctmKMT+17m8U9usRc1ucAH+f8jC?=
 =?us-ascii?Q?c6LAbBtf48f4H8zcMjfRW3srEbYapZj5rKDPN5gK2jMgke/yPpH5VRJNMUTA?=
 =?us-ascii?Q?7cSqk32yJrZX19ABEqMhWzHFDg7LB5Kg7yf6JXxvONVsV0u7sXH11H1LaUS7?=
 =?us-ascii?Q?7BC/Z/CuWwzDZV/+gzfdPUOTpy1wp466fhE0jZrEEZFAtsk4tkVzPS//WG+A?=
 =?us-ascii?Q?ZUsmCFqOqEVfsI+DOxIP403BYvnzggDVJKpovsB9B9c7Jkr5OVnF12Aoo8Jf?=
 =?us-ascii?Q?w0NnWX88SGI1s1gkpOK+sJd+qItXolj0H0psawsRtheYZWHtAdaQLglHlQzS?=
 =?us-ascii?Q?zNETBpn9pCkSmq6/EmkvMwSac0v8tWp+72TFmS6OPq8RCUZcrvNhAqoTzBBE?=
 =?us-ascii?Q?vgaI3mPy3RFzFxgHglY4hCm1YoANi59FzUZWf4agy7ZkzF3NWtDzjKI8vnnn?=
 =?us-ascii?Q?JMiS/hKH4OMzrjJnUdo4aq2kHV33JHMJXJo99S3mFuy0EgYF+AIPnsNh6ba4?=
 =?us-ascii?Q?yfPWxYzWNdF4Pe+AkTATgj2KQsvYlezHBpZ+6LF7ZifU7wCvmgnB/pDCnv2X?=
 =?us-ascii?Q?/YHFPNRLrQdmfz+HYsB7P6JaCCl+KddPZsgTljyDxkXOaueLXL6maANsG5JC?=
 =?us-ascii?Q?rtP9ipb/1/vsrK4fxFWJI5DIgm4sJkszuK8iQ8gy83JU9AHirubuMTDb1/YZ?=
 =?us-ascii?Q?yxskZ8eNAhjiZ2An6nRT7OtRMjabcKr9h13VU3O+ME0zNNm+ege5gqM/w9w6?=
 =?us-ascii?Q?CiI6hTlUdZONqo+tGyFcjaGpBxiwNexzsNXqyrOWFw//HZBMQsMMwF5QzWtj?=
 =?us-ascii?Q?FnqYOEv7/ZLGp5B6rrKirxGpwPeu+OhFd1cKvv46GnloBGUflYwiHEKdne6e?=
 =?us-ascii?Q?RVbYsTuGnCfOiFv9LfH1q+SN+GD8/GbVsn2n4QXi9dofV9wHYbuw5VZTTBau?=
 =?us-ascii?Q?cP0UI4p9q85sFdkbTiWHMsQRN7flvCEeja1B9Hc7ES1wDtnXOewk+7KWSmZq?=
 =?us-ascii?Q?1rJitazF2c2GxSXxUVNQfHVAp6cg3ug/wpgYb5IbnRfWLHJnSs7O96OkjZdG?=
 =?us-ascii?Q?MqZ0tOyV4FBab3RUih7J8XCisXnNl5EkQCXBcpjL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb717032-b944-4cbc-5987-08dc4f376c13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:57:43.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sG7+/KpZhkkBRTbIw67hjiR43N/WHNcFRZ2JseQI/tt09Q4sDcZAsZg44KKRoGsk5HZmndfPVwekSv4b1RHUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7916

On Thu, Mar 28, 2024 at 10:10:51PM +0800, Shawn Guo wrote:
> On Mon, Feb 26, 2024 at 02:21:29PM -0500, Frank Li wrote:
> > Add asrc[0,1], esai0, spdif[0,1], sai[4,5] and related lpcg node for
> > imx8 audio subsystem.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../boot/dts/freescale/imx8-ss-audio.dtsi     | 306 ++++++++++++++++++
> >  1 file changed, 306 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> > index 07afeb78ed564..6d78d6c0d9002 100644
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
> > @@ -481,4 +482,309 @@ acm: acm@59e00000 {
> >  			      "sai3_rx_bclk",
> >  			      "sai4_rx_bclk";
> >  	};
> > +
> > +	asrc0: asrc@59000000 {
> 
> We want to sort nodes in unit-address, right?

Actually it is fixed at v2. I just send out v8, which include extra space
fix and wrong clock index fixes.

https://lore.kernel.org/imx/20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com/T/#t

Also need below patches to make board level audio work.
https://lore.kernel.org/imx/20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com/

Frank

> 
> > +		compatible = "fsl,imx8qm-asrc";
> > +		reg = <0x59000000 0x10000>;
> > +		interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
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
> > +		clock-names = "ipg", "mem",
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
> 
> One space around =
> 
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
> 
> Ditto
> 
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
> > +		compatible = "fsl,imx8qm-spdif";
> > +		reg = <0x59030000 0x10000>;
> > +		interrupts =  <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>, /* rx */
> 
> Ditto
> 
> Shawn
> 
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
> > +		compatible = "fsl,imx8qm-asrc";
> > +		reg = <0x59800000 0x10000>;
> > +		interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
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
> > +		clock-names = "ipg", "mem",
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
> > +		dma-names = "txa", "txb", "txc", "rxa", "rxb", "rxc";
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
> > +		clocks = <&mqs0_lpcg 1>,
> > +			<&mqs0_lpcg 0>;
> > +		clock-names = "core", "mclk";
> > +		power-domains = <&pd IMX_SC_R_MQS_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	asrc0_lpcg: clock-controller@59400000 {
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
> > -- 
> > 2.34.1
> > 
> 

