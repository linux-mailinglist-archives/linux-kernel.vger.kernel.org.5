Return-Path: <linux-kernel+bounces-97508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06459876B31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2299D1F20CD4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2905A7AF;
	Fri,  8 Mar 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HLDfPsLc"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D0856473;
	Fri,  8 Mar 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925993; cv=fail; b=WXdpKDxbAQdRMRNrtD19HhCqlL06F6DmmGURFOHdhwOk1yLO6s54G7QXraaTcXPg3l364b6+TMt1SLDBdNcWpaAGkslt0Pc3lF9ITjvsdNJ2LiwDh8/lZQaS/o7vWPxJok5XNxN3Y347XxPmifen+wZSUSlNuhsaWPNLkyMl8OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925993; c=relaxed/simple;
	bh=7IAFTJkFjcYvMAXMo9SXxvmnbiihygdC+gqK92xFBW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qu1IsrgaQ3EK/ha3YFoLpUPiYRbtMNt6HqnjAOzXApCNZMA7OeIzswm+vtjJc/wIl0Fwr6X/rT3AYXBp9bzlKvyfcEmRT+AQ3CHMJ8qXRRHzZTDgdJ3KihIVvq9QkA3+BNvTUn7UyRvDTmggmOUCV3RlG502uXedpdc3xqQ4ccs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HLDfPsLc; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru3UUUGCmJIfxUpnzLCGchm7b/K4elzwSH/fXP+rsF5Atm/dWcIWpJOmkBoDFXTJkSXhjjiQk5CX7LCdLALkRqWm+dYVSA8PKA5Qcs87jeVXr4oU6tnlFYcYAA1URJoCr/PacusEbEs0ZfP6zKtBdv7BBuenPlk8uxbC8m0hLXsiZ4JVNzQCTaQIuEHUSA4O4BNYbDEDJKBlBtlHlJmJpUzBz4LUURkDStyKRIbqxMpRk6uA83IBXZDFd7AK6ja9AZOOjIrJ9/du2TUadTHFjkL7Vlmxmu+yWKQGFqJS8XXkNgYf9z0XRAqh/OCH68Cm+16iun6yNxEmi9mgEBYW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3SQm+oio7QZ/H8IsFVXqh1PxaZ9rUG4cNrYAOw9C1I=;
 b=OG55QVcjc+VGLXAuzEkI+gt2Nc4eKhNKyg12Od5QwrFFrO4J7dcjgoPpCi0WUeJ4FW01vp+W4VHOtz0Ay9cD+atcUeYAomu3LBEoyrULHBz4x+bfIDQYTWd7v/Jxv/8cnlFuDzZcjSKc0TF9Js3SEmy8I95zgkYUUW/3vUL4jiolRJvnCsC9gFZ/P7I9ZNsB2g8GCiUZl9AR7iECJ52WQMer6I6WEmZvjkdoCUUESKRT1qKq34y9/fCb6a4igZTXJdV56BGEnjkF10eHG+7BanivrihPi4Kc2C8u7KbmbCJS/c9P0pk+M9KV55RalN2ZOw7/Nv/wFxzo2kY4kyf6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3SQm+oio7QZ/H8IsFVXqh1PxaZ9rUG4cNrYAOw9C1I=;
 b=HLDfPsLcB7XRM+AU1La35GQbUwtGe9yoRTNHLpVVbwhBCFy7ucEvvbVXNLP+ZGMzNZu5tdb1PWBOTa8DLP3f1V16xPcs3ug5Gmgi8q4u6JDYvxvM59+ugBPUvDRMuw03pPbWEWpnKHg3jbikvqjcID9xxX8kLn55XXDxoDngxAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 19:26:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:26:29 +0000
Date: Fri, 8 Mar 2024 14:26:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <ZetmXE4YooDYJgSM@lizhi-Precision-Tower-5810>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
 <20240308-asrc_8qxp-v6-2-e08f6d030e09@nxp.com>
 <20240308181103.GA855753-robh@kernel.org>
 <ZetgiaZ1+wt5lCkB@lizhi-Precision-Tower-5810>
 <Zeti5mFUUh9UedAx@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zeti5mFUUh9UedAx@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: c099190a-456e-4825-e927-08dc3fa5a74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8TCwR4ysC58xB9EPGRZ2oIIYVGlSS+FkIjrhOu36Hb5qBLGaObPSzKGK8TFwM3DOB87zlvZ2mljkPcuCHrcWvpf2VLsuR8UOIv9Lwq68crcwoE4og5t/IB5Vwys+4jd0ZojLa2IJirRuqVQ0paQzzZQpIm+O2orFEsVxhZnYmU+y6DSsVcK90QsjGibeVxVRtx6KfvGenPk3XytamWsdulxYNW04Mmqe5fZTPacKtRze5QZEU8GW4jxs9nRH0XRSXv7zaaOqo0cSqH3GJe0ZszxjHKaEfQvr9YEzg8puryX6PIXpGjWQZRI/v9p1jWo/xfz+BWpx0H1FPaD10/PaG5EykPGIhdmHwpAiHhENMdbwvvXDXYrzIraDDN4m+0Zx1fVanM7bJIXgtVWDzrLeD+6xfOaNpZbn4THkUl8h/e0TuVbpJJaOLMlosdPTe0vW0iYDu+CYU4mwyZNH8ohIToMPCRgzyCVWraWjOhmAXFj3to1hXXGe7OssE9NHnmhkbu0F4ulZ557a3ZPy/wYtykn4jQGm6mn+9AnQa/CJNkaSbCtDzkaTuA4T8lPbNjqCU00nCXlvj/E0HZsxgI2bMTXPMno2gwQS5I0l6jc8YNlKqWhNnWHBtkTe3p+v+uywCF+DVv9M2nRyDpgYD1ixHpKznVXfGH4sjCI8LdYjPfY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/oO7P4oOvNo5jqWDzSp14zBAqvs8tTHK5yhSH3fZSI++AADjkwNxC4hERDd8?=
 =?us-ascii?Q?LdunAXnq1Y7O8DlZN0wFkGsnXl42s1a9W/dODMzkn6tMKkbRAINHL4m0b3GD?=
 =?us-ascii?Q?h7fImrH/I453rtE3r9vzMSHzeGNzUltXC+d02ml+O8NcEltysQl+hKsZf/qY?=
 =?us-ascii?Q?CKG+A/7Fc2bINvh1PeCajUfxbBp62tHfdJ/7luVEPfU8Xf52rioLqr46bllA?=
 =?us-ascii?Q?Al0OV9Is+rfxZkFCN5Y3ecmxl41ulzVfXs9ASz0Oi9bkn8+IBzSN9TCgTcDB?=
 =?us-ascii?Q?wDdp/odepj80tgKOWAshT0ZwQMbS8Wj930gdwO5NiBMueVGuS3z6G04lXGDD?=
 =?us-ascii?Q?sTt8Rs9CSrC7xEWp0afkH0roeyDwcBLbP4MO5zENnbp05B09fmes8MMqBgcJ?=
 =?us-ascii?Q?H7E0uDX6S9+J5GWHTX6lNcdcYwF1K0zMGVo/nMhqMSZtP6hzSVmddDlAT6/K?=
 =?us-ascii?Q?JUfBdoL1E0ZpeGEkE9atCdFeLChNzicDKpsoH/6W8f1k30WeKvYwV2VvkdaI?=
 =?us-ascii?Q?zmyKY68nnhFwT2latqYAIRjyN8criKU9u+jR7mopzp87lp4/Q+nXRp7g1i3j?=
 =?us-ascii?Q?Rc781gQ8VUlqyGs1WQH+mAG18m1F4LFJ2SQlYxFyO22cwVGl50dE3S+yHF3X?=
 =?us-ascii?Q?pmwBXRPJHdJ2agsEKjvL+5lNJ/4/FSFsp784aEnRrzCtHWIpG8wLHTcXto03?=
 =?us-ascii?Q?fA0Mbn5WIf2hLx4PCjf8bs3/QXlieEHUtoeHfMhhwyBc5lUm2tds/7wozz2D?=
 =?us-ascii?Q?jpaG9bPDh50dNCZuxNX00Q1uzmZf/SmNvW7Tdq/ATlfgugpTCPXlBS0wAgNW?=
 =?us-ascii?Q?Gn9BhDilBzVb66YIWgqQLEjQstxk3GhnJ/ifdS9v7+zlq6RKqoBM4hX4Midd?=
 =?us-ascii?Q?PlU//8R5XWjfNIM4OZ1wAxx9QRF65oxeqaUZIggwwBIQjexZ3wENUh2Gqrmx?=
 =?us-ascii?Q?xD5TNpfSC/6II026CEshqI2nUXMo6jg41LJNbw8phcr2QhyLkKx1KsPZKek3?=
 =?us-ascii?Q?yUbx/W1sSSFGhsLxZFDWz124XPovNBvrxkL9AhAnaVnm4OHj9GTx5fE5Z8iE?=
 =?us-ascii?Q?gjhtEcLn/CYI83SpojROlVKjfkVA3pVwEsWPmdnfWeGhgk4fnTAu80SIx9XO?=
 =?us-ascii?Q?BExOpx0+QufOmpvs+QXET2hMspEonEIIT3F9D7mworgW8xxs9hfuyuzObWD+?=
 =?us-ascii?Q?Bioa5o1PTqeisn7hbQpFHshbOVid1FPtFvLjPdUICheaz27jG+EFILX9lcYC?=
 =?us-ascii?Q?IpRROScs3H9kn4CSx4e9AUxTJUQ4qTkEh3xjcY/sbyG6bNsUyXif8mV0upvU?=
 =?us-ascii?Q?8Vw9BJ4sGGJ2lQAJzfJhyBwgN+JN6axR6pVUDuv6jpLR2FQeCyPFHrnyjNHr?=
 =?us-ascii?Q?K338sdoQhq+cF1XBWf1dwOoZIQYK0M/zlx/7dy9NBc1p3u7dvKhGTH62to9z?=
 =?us-ascii?Q?UV/ljzchcI02TBKKA0wUts2U+QeUi4WcKk5+hv9XJRlxAalp4BCleAxKw0XL?=
 =?us-ascii?Q?5SNxPq5N88aWLuyE3E/qINoxJMlY6ePDj4dJisOPfBS99BQL1MNea5gepVxb?=
 =?us-ascii?Q?rkVQZtuRKh3d/3QcWJOr55LhR5pFxbzYri3tdQbk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c099190a-456e-4825-e927-08dc3fa5a74b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 19:26:28.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2oI9LNHmVrEco4r/vASVO30uQM61hZTPWVMwoiZ0WLJSJW3gYUi//vqu9d7gyoS33MTdgeuXg4/+iFsjgIAmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762

On Fri, Mar 08, 2024 at 02:11:34PM -0500, Frank Li wrote:
> On Fri, Mar 08, 2024 at 02:01:29PM -0500, Frank Li wrote:
> > On Fri, Mar 08, 2024 at 12:11:03PM -0600, Rob Herring wrote:
> > > On Fri, Mar 08, 2024 at 10:30:51AM -0500, Frank Li wrote:
> > > > fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> > > > have 1 interrupt.
> > > > 
> > > > Increase max interrupt number to 2 and add restriction for platforms except
> > > > i.MX8QXP and i.MX8QM.
> > > > 
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/sound/fsl,spdif.yaml        | 21 ++++++++++++++++++++-
> > > >  1 file changed, 20 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > > > index 56f8c0c8afdea..a242f68f99f18 100644
> > > > --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > > > +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > > > @@ -31,7 +31,11 @@ properties:
> > > >      maxItems: 1
> > > >  
> > > >    interrupts:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > > +    items:
> > > > +      - description: Combined or receive interrupt
> > > > +      - description: Transmit interrupt
> > > 
> > > Test your patches please because this will have warnings. Or, you can 
> > > put in *exactly* what I provided because this is not it.
> > > 
> > > If you continue to just toss crap at us at the rate you are, the DT 
> > > maintainers will either just start ignoring your patches or require some 
> > > trusted review by another NXP colleague first (offhand, not sure who 
> > > that would be which is part of the problem).
> > 
> > Sorry, I run wrong command to check another dtb file. So have not catch
> > this problem.
> 
> Strange when I run second time, spdif warning disappeared.
> 
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8dxl-evk.dtb
>   DTC_CHK arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: /: fixedregulator@101: 'anyOf' conditional failed, one must be fixed:
> 	'reg' is a required property
> 	'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/root-node.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: bus@34000000: clock-cm40-ipg: {'compatible': ['fixed-clock'], '#clock-cells': [[0]], 'clock-frequency': [[132000000]], 'clock-output-names': ['cm40_ipg_clk'], 'phandle': [[15]]} should not be valid under {'type': 'object'}
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: intmux@37400000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,intmux.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@591f0000: 'clocks' is a required property
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@591f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@599f0000: 'clocks' is a required property
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: serial@5a070000: Unevaluated properties are not allowed ('resets' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/serial/fsl-lpuart.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@5a1f0000: 'clocks' is a required property
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@5a1f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@5a9f0000: 'clocks' is a required property
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@5a9f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: bus@5b000000: clock-conn-bch: {'compatible': ['fixed-clock'], '#clock-cells': [[0]], 'clock-frequency': [[400000000]], 'clock-output-names': ['conn_bch_clk']} should not be valid under {'type': 'object'}
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-apbh@5b810000: $nodename:0: 'dma-apbh@5b810000' does not match '^dma-controller(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,mxs-dma.yaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-apbh@5b810000: 'clock-names', 'interrupt-names', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/dma/fsl,mxs-dma.yaml#
> 

I figured out what's happen. CHECK_DTB will check binding doc except
example part. So I skip run dt_binding_check when I have not touch example
part in dt-binding doc.

The problem is
step 1. run make CHECK_DTB=y freescale/imx8ulp-evk.dtb
        Then I get some sai error, I found use wrong 8ulp-evk.dtb

step 2. run make CHECK_DTBS=y freescale/imx8dxl-evk.dtb
        Then tools not check dt_binding file again even there are warning.

Do you have option let CHECK_DTBS to force check binding doc every time.

Frank

> 
> 
> > 
> > Frank
> > 
> > > 
> > > Rob

