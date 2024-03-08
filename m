Return-Path: <linux-kernel+bounces-97539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA3A876BA8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DE8282482
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4308E5C90A;
	Fri,  8 Mar 2024 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aP/Jm8fS"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005062D058;
	Fri,  8 Mar 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929287; cv=fail; b=tzl6ZdKpoXCoUAC66KYB06JotvugYk6XbC+oUtq++IXhajXRFQhWfgUEhO947dO2nbG76eQq9eP3C6UavFZMcdLReqvt3wXtaJM8oMhrPfUOt2UVR+wT73kmjgbH+BolepXAN0D3E0EiKycj0DL2eyJp8XZUAEJOgFSTfKHdyNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929287; c=relaxed/simple;
	bh=ps3p92/XGFIt0ivsq/Ll9FqdDb7OADSPNQ0NRkKPnAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QKFhQvHJOW5OHGEwoOMICXPtER6P+dI/0HvqjSqOlI+QXACvy1IibuElGKJGCV0sygIrkZP+w44saBZ7iFXwmwBkO513jquIY31uQj+ggWr6TFLbA1CNvjnz6wTQsKhnBehRQ8G1NphRgb350GbJX8rfaV15en+QYq2M0CqACsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aP/Jm8fS; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt5Cnmi6Pd995twYszOug8SFIA8MJzVQq9nJZcKIdh1z4l+iRtWMZilpjiTl1DrmpzOgn6M0meQOacF8XWL6cIx95PwweVvYtKC1L2JNl+uFzQxFTx3mYuNiCfrjUwUuD/PpSIZ5GWRgIT/4RjoVegriGmOYuIRVV8SNHCcpqf1P+FqLj/xHmy77WgGw9Xzn6LC8cUU9CbWiU6EL/rzqA0XrSkwhr5DTbLOZEBERzC6OQYpJYaadFfOTQSjA2cdnLRw7dCz8Uw7XI7KU+uUuQ1wDbqZZa5YEY4sHlmc1mnGU+5/X5e7Jlw5XfO/FS5/2SmWeVhhSKval3BGKK1LD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWWjqf5zZvvN8MLv7kcXC0byURflyONFlAe7rTDjsMw=;
 b=oSudTe5+fGTwN5uHewxsbpUY3DiwfjUR5eg6Yc088hXorteGqBp81cLyTBdWaffGYhQ3ZpeaGdoQFRugCW2vAfmA1YzJb6RUpk3YdG+9/D9sf1MTUeLMFfP3cedJhuYWe2im3/iDONW78jsUusk6t3R1ZP77zDHxrKS9Ty6Wm+zFz1bIb3rwpaqSXw5gObPgMWZvhjZQD8zHWXk01wHfVVqL6z9IqpXzj421/S4S0T9NBW/jtqWkKvTk5KHMke43Msvjb8mJcdodPOf2sK8rGtD3TJaXmIbvdpAdl09t6d5PSBKwPw1DNTh6OPA+2H7bUOujOHHVSo5xj/UjWUx5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWWjqf5zZvvN8MLv7kcXC0byURflyONFlAe7rTDjsMw=;
 b=aP/Jm8fSLGwNIhVUs8iV78sAVP09wQ/K02mg+oHuFbCmkNGRn4AnUeK8qe806476w7cAHkcrF8TKs1lrrHMD/RUxVDcL+HDEwXZkcugqntY01hSLrkxyzKc9oApQoK1HjFNV7nZvVOxx+5wuydBWZjfQwedvvXaIPurskRPtG2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Fri, 8 Mar
 2024 20:21:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 20:21:22 +0000
Date: Fri, 8 Mar 2024 15:21:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <ZetzOu+SqmLQfsOs@lizhi-Precision-Tower-5810>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
 <20240308-asrc_8qxp-v6-3-e08f6d030e09@nxp.com>
 <20240308-croon-goofball-797d091e981a@spud>
 <ZethoKhsUZ08HHL0@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZethoKhsUZ08HHL0@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b441cc-7d64-4f41-b27a-08dc3fad526b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jhZxcZpwwly2FuhCmXUzp3lxk/n9IPxn9lxoMy/EFXuZbj0oiLBfx351/FuKkENq/v1vorH00xrpXv+GEQLPZHltwuQqEwICKJp6MY4pFD6Bl+2w5ao/6JNVYPLB3m5lsYyuQOGg/IFcDrrfl1BEse9F0oCxF5aMm+Il7m38gzUOvEE1Ua1+MfCFrfDIR/Ysp7WKqmLKjlYBIiLABPRHjb8uuNDMwwZ6S5FSxWPuxnnnUGM4NYlGAwXBROvM6g8t2ei1Y0cFCiEcy9RGWTYICBmzgShv4Q/cEF6ITSQyOELjHlHPQ0gGAX0U4qtZQqoPKAcswkVaVBe7fEcDmQKIDMySM4z5fyS/h36saMxBdSU2JJTmJhXGl6A8Tp2gkCeqy6DukbVayCHX8PmOQhnMYwrvKjkHJhg1/Ai9U0VhglTVZoI/+ETC5I+9yr9AWRxJxT7av8ItMsOCTCU6au3t/s4+RsOoEi9cnSPotN75iFQvAsERZcqBT4Hzro2gR2yER8XlRh9NaLL6+c2Olcp8EsN2Cd9mswT27kQKOaARtE90gli/nNFaphr3yCfIk2Ll2VAPhVKPJhwhtctk7ZqAKccqf7BVRIWunHpo/A0rjYgXZXm5gr32BUs48pQzG+FRVb8RJd/sRQbFjH/wInA1YPEr/j1gNaLBq1HV6Dc3Vu8iArdVQaUhDjRJAr+Z0o4D3a/eRms9bXe9NiVFKiISlNIim3QOKyiJiwkBSeH+/fI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w+ZLZTRAS3w3EQDXFqLOZRnXKnnYD9ZEIsFMewulLbUGu9rfbjvFmpcHjrTM?=
 =?us-ascii?Q?HoE9Js5RHCXOnvDE/Knd7Z4ZAPToE9zwAe9z4ZrZ2GkBM+Ah6n0NBFYni+ud?=
 =?us-ascii?Q?3kKdhuhUmIm2DjYrJ7Loa93Gf9rD1znQBwVeOJCjUlwusMr69VRl2WFDxP8P?=
 =?us-ascii?Q?NxhibpJlyccduqNOrMPPGUQAVe+Htd63vfKpnVypoLCkaoEPmcdAqtUcvrsl?=
 =?us-ascii?Q?zt3tCzDOYj5/UOEHyQcIZgZiGE1udjBYDpV4Bv1oFrFvvThqMmQepCYMsqpE?=
 =?us-ascii?Q?m2lsTCa3/gR4G/QCjsVQbAWyZXAee9kjHL2QuEvmhj21qEmXRrsG60mrIvVp?=
 =?us-ascii?Q?eWARLN3i62/dxwO2LTvO9EKkChH2PeT8/v9pWX4BUluKBl5ybG00efL3HUaI?=
 =?us-ascii?Q?8j05c+eVWk9YTd813rJlT7EXrHlBBtB+x59yFVVPbLV/IlP16UcH/iJHbv4S?=
 =?us-ascii?Q?Nc8/pPzevvJ/AVLGkVH1JHWv97L07SNEboOzCWGrHAEF9PDSK34xbYZlEaCy?=
 =?us-ascii?Q?3dgbGSujPWtBz2Yh5UEA2fJ/9zhbrrxEor25pxCiicfPeGzrWk9OMuFFpAZq?=
 =?us-ascii?Q?BxN6QH9BLexKGkaFoDNmgOrzSOH1VkEkYgn2W02UxVarktaa5YNjcTSEFY97?=
 =?us-ascii?Q?jo6WXP9NqlaMJ8Za1aMRhuWogZ6Kly9MTpmLlf3gyVXGtfr6o6tW8hSOHw73?=
 =?us-ascii?Q?q8TP2ZdCK5lub1oLX9aB8tUEeT4JcUIEcZb0ZRfH+jooCQhvHDVW86i74spe?=
 =?us-ascii?Q?yxQOZriQakND09tTkCtiHGWywcFcpdbXlLHx0fND7F2DY+vLp+ysjjuhoqHI?=
 =?us-ascii?Q?qHzTsLPlJ60uAQIlfvvETgs2ikkXtuswUD3qQYM3ZC8iIynaNA2RFr4Zs/+F?=
 =?us-ascii?Q?pqvb3iA3hnbHJEB6/vVtMd29fwwwN32jO8U/zNyIMjKBGjQk3ogHzcZn6Zon?=
 =?us-ascii?Q?vVkgmSPX8ecG5Rcd132GnkZbfvFQFSfjTSHwym8u4tBboaBiTzW2OGQecM1x?=
 =?us-ascii?Q?KYeC3uPnlkGmP0DYe06LzICkFR4VSwDsmdHFHqZcSojwiO1YGnFRmKIMAvUF?=
 =?us-ascii?Q?dkQPfkVpxuo/7fUeoKXQ5GCr37V8d9fgxnOYhLPOZNQq/c3E+Jbe89l1Gyj6?=
 =?us-ascii?Q?AjRrxQyLKUNFe9G9ONNpJysbBXD5kGgsFnSama1sp21oJfsADwMMqFcSKyQw?=
 =?us-ascii?Q?MOcQHBqPrxLxMs3R/5W5Dmb9ZXo45IVPYnnb+RGzli+2ZCezzysykfyNTZ8A?=
 =?us-ascii?Q?5wqRA+EBrtU/Izo8hIPLBBX6SdWRoVLh93+Fa8jTzeVFoWSjebYmIlLHeGt9?=
 =?us-ascii?Q?/FKo5pYdlVt/uO5I5Ky1WihjXbmEe79dr5crG5qMydsu1fIENMwrqzesk70Q?=
 =?us-ascii?Q?kFbSlQriau2OgogIHRJsc/d1FWC6cIqf6LfkyROB6wwFnM0VxaFpJjMDxmeg?=
 =?us-ascii?Q?AyyZQsaQeG5olDjAbHwONQWbiAoBJqIzC718w8NBMuvJFoeTZ7TXOAIkSp1Z?=
 =?us-ascii?Q?wodSjFmJwEJm81rBFY5tKvs+1uRQWDE6cVNaUPz6J8L+jOxOHSswxYiKjnJU?=
 =?us-ascii?Q?7aY53QFLJMXlifwtJaz7dbW+f0yVMbapZimrylvg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b441cc-7d64-4f41-b27a-08dc3fad526b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 20:21:22.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkO6RGAvQI4EH32yguKDOc9gBCorcr1H9AW+wsllccRK03KDvGDbRPSwLrrlodv41IdwMKe70s56xt0k4vpgoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807

On Fri, Mar 08, 2024 at 02:06:08PM -0500, Frank Li wrote:
> On Fri, Mar 08, 2024 at 04:58:16PM +0000, Conor Dooley wrote:
> > On Fri, Mar 08, 2024 at 10:30:52AM -0500, Frank Li wrote:
> > > Some sai only connect one direction dma (rx/tx) in SOC. For example:
> > > imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> > > for dma-names.
> > > 
> > > Remove description under dmas because no user use index to get dma channel.
> > > All user use 'dma-names' to get correct dma channel. dma-names already in
> > > 'required' list.
> > > 
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > Please drop my ack from this, this isn't the patch I acked originally
> > and we were having a conversation as recently as yesterday on v4 about
> > this patch because Rob didn't like this approach. His suggestion is
> > better than the one I gave on v4 that you have used here.

I paste your comments here

"What I suggested is different, it is more permissive than what you have
or what Rob suggested. Your original one allows
"rx", "tx" OR "rx" OR "tx"
Rob's allows the same but with a nicer syntax. What that stm binding I
mentioned allows is
"rx", "tx" OR "tx", "rx" OR "rx" OR "tx"
"

Actually:

"rx", "tx" OR "tx", "rx" OR "rx" OR "tx" is exactly what we want.

"rx", "tx" OR "rx" OR "tx" is only feasible, but not perfect. Why need
limited "rx" and "tx" order? It just bring us some noise and no actual
value to do that.

Frank


> 
> Why do you think Rob don't like this approach? He just said this is 3rd
> method. And it is simple enough and match all restriction.
> 
> Frank Li
> 
> > 
> > Please give it a few days between resubmissions, and do not send new
> > versions of a series every day. It is very confusing to have different
> > conversions on three versions of this patch in my inbox all at the same
> > time.
> 
> Okay, I think it is just simple fix and almost everything already close to
> settle down.
> 
> Frank
> 
> > 
> > Thanks,
> > Conor.
> > 
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > index 2456d958adeef..93e7737a49a7b 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > @@ -81,15 +81,13 @@ properties:
> > >  
> > >    dmas:
> > >      minItems: 1
> > > -    items:
> > > -      - description: DMA controller phandle and request line for RX
> > > -      - description: DMA controller phandle and request line for TX
> > > +    maxItems: 2
> > >  
> > >    dma-names:
> > >      minItems: 1
> > > +    maxItems: 2
> > >      items:
> > > -      - const: rx
> > > -      - const: tx
> > > +      enum: [ rx, tx ]
> > >  
> > >    interrupts:
> > >      items:
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
> 

