Return-Path: <linux-kernel+bounces-97495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C01876B09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8696DB218CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8A59171;
	Fri,  8 Mar 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SyAUd7GS"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9B56473;
	Fri,  8 Mar 2024 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924782; cv=fail; b=h76OGMqsTmgegRxs6ybxRRT+yizo/LzwCpXtScA+FUxwGqOLNCO5nJV32VQBSjpynADPNpOUoh9IgZHXvMJU3U5sJ24z37Fzp2sm46GuPqVips4kjVZJf2DeUnuNQGvP2WEvyY9vV7fj2aUy9IyBj+ZP31iRHt3V812n34ytUxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924782; c=relaxed/simple;
	bh=iNPT0dIAxucaMHT/tqGMqHLejhCOpNA7YSpH6G+i5/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQjZ3ysHiUn36c5tV7SnP0MsvbAlp+SM9Ov88woXrLop2TR/ij4dO12+RGi3gcDXmZd7ZUlOewx0B3Wb0/xPD4feZL6rNhgKUjPXjcj2J39/Ar2r6XfzLhWgCLzKBWYAx4l5U5O7X2evwOutG5Lt9Nlk54rJz/eCXbHQMWUCDQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SyAUd7GS; arc=fail smtp.client-ip=40.107.13.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDzgwGRSLlgKursziPnQ5CCEnicIvOTIheUskAwWIwSI501jHA8V2OA0AXPzMr1IHKrwKFWoWjQQv7pnbqO71yZnb/wvJkzHEqYC/KEKXVTVVmkHBqFYzHFQqq7ftB2538A4RiK+KI7VVqYYJ91UQj26ygofJrjdhcBwYBbSa6WFRXb1miRhVj1B2Z3RaY6oH2VHVlQncpa6ToQQx0SLfGZuDJZ8mqAJkulFr5yqqlhxSz/W3KYnKjBIjifQx3X6gZVLtitS1sxZXNrVxepYOp5T2VH4EXngxVJxZxRLi82ug2FQYX2xKOU1qMIU0YBeR16owkR5l76Wx8vvnDAz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ2JuimjhDWtLpWqIZUi1mBn36cUBrg/OUvsNtfl0+M=;
 b=aeUmp4nLU4jXLAH7H9lGIek6zcA8zBJqc/kQX1Uk9aYd1R97FxI0Rgw3Y20TP245qhuoEdZ9CXGTCh+JmqDJrhYzKDoc9nOew3CH3nwxNbl3zwHiIOGJr/tcPbVE/utTGiMazFBHNefzDka2P0BfEnr/aRmxMrw5ggYrxhZdRwf+D31Iy0KUkEynkJ2Rkrr8ufAmagUIHMAUzW03+Cu2avrLeprzjg3eV+wDfaoFl0qxwiu6k2mHlUhhXFXJg6ZjYub3sOIFGxyIXPwPE2BtHA9ODfw6dlxuDBmQEC5kNBNuWxOYFuXJEDUfAG0r2upODUCADEym25h40Fxv0uluIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ2JuimjhDWtLpWqIZUi1mBn36cUBrg/OUvsNtfl0+M=;
 b=SyAUd7GSMSLPrtNJuKwNTj5xzbMpCLGGtkxJDJRNxUpFUHBpZjsU06rvJPq8RZ+PL5RVotLNOMniv403Ts7hicPtn6rG9ZseHgL/nLqdW789VdhY5ZhtHimgwxCjfQcYyfRXawef6goJt5s3xcH9snPfn/0olQYN9xC6r78BXCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9742.eurprd04.prod.outlook.com (2603:10a6:102:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 19:06:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:06:16 +0000
Date: Fri, 8 Mar 2024 14:06:08 -0500
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
Message-ID: <ZethoKhsUZ08HHL0@lizhi-Precision-Tower-5810>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
 <20240308-asrc_8qxp-v6-3-e08f6d030e09@nxp.com>
 <20240308-croon-goofball-797d091e981a@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308-croon-goofball-797d091e981a@spud>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bba068c-314e-48ce-9712-08dc3fa2d48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vSfuTM/CYxf8vY4QoIC4KZMcuj6n3YQ/7Rj+9xJ6X8Hdc81uAXDMcvH6iWksEnusl8JPlSI6oxH1Vlz2PyO0e7LhBMOYdcLgb3SkHOoJF883beYE7JUpJ7i6vCjEgeIpyArCk9MwtXJZJ413NxQ2w4P4AxvIGd50uvPQlEwh/GU3WC2nyW3XHe1jh3HRkYjS//xpCZpUpgjWNBIpyyyHeUYHo2mthvFBWyyKopvTYkJE75OqzVaQ35h1LCpQGi6nbRVSRHEtMcoouSP3w9ijUnFfqxUuGZF/5bndXBjuYI61NiLxPXw+p+o8ncMjskRry5oKZ25DkgDTeUfqkgQh6kOyWbpuBZWT0hp+yfITpMZMN6FUooABI8HU/8PuTH60Sv03s2knfV5jliTUjaEL8NI4xX3z7I0oAf0mw2RYMXA8YqWjo4deK2ln47gqb5mx+XNzeI6w6snc4bZ4M0bhIf2MIqMRGat/EYYmfMPFQrSpih4x0VbHtTI3A6XtUL/mz5pw1p2o3pDqdPMuzc/SWartTB46/8NsE09YxBkzDCD9Mw2iUjdPEgoi2skB/7an4lK9aqCPBUO4J+K0BPREUkS1TqXOOndqoyfsb2JhVQy2X5pWpUAIY2MfogjPTPBXZF/GX9zLi7IaEnYoMGSQ7/TVj08zBYcRWaoWvzDROBODo9PGXEx312zaKuNvRqyieodoNSwOjq2Fhklzx+waV6k2cjAoI8KBO5hsi3BoQRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?71uXvJDfNhtqeCvjLSZel90Hpi5SEOtIVFl21/EvtHjamN7Zb/i4vucfrVvM?=
 =?us-ascii?Q?cLB5qzJGjtscmzbw1L4xPPRMHIIEqZc+I8b9vS63YQMCuGgzG3b076Xg8Yhq?=
 =?us-ascii?Q?IzoNCjg3kB+W+zbDcAyjOL6czMiNvqy0QlISfp2c5Cwa1UapvuAYncjNQsnU?=
 =?us-ascii?Q?Tys8s+iwQA3XiXuNu6rWIOwMn3NLNWI0x5JmPxjWOm0oMHYg3PIj1kC6L18U?=
 =?us-ascii?Q?G9U9EzIULUuBIjXmeHVhDSsDLHKdaQvefu7XsGaAS7VuS0fywwgFvlyW0Kj5?=
 =?us-ascii?Q?x6j5LSoJ0Qk6l6qd02cvV8Lk/uyeRvKYSuZrG8/3bsUYi0jP5D4w7t/+KYrG?=
 =?us-ascii?Q?Q6WQW8+Slt8TFssYuvfN9e5pOEEix1b1TNC/w28sFc5cBNY/PmCFFlb099G+?=
 =?us-ascii?Q?r5Tm7hZL87BIWpnw4IlTPB9fXj0TrchzSJjLWpequJC10RnHsZhFR7B2NWvU?=
 =?us-ascii?Q?uJ2I1m/maeREqj6sLj0QXqp5Pkk/RufnS/3rFl/9XweABwjN1PG0q8WSeqxL?=
 =?us-ascii?Q?ogfyM043UyYMslPS/2digt3TTfxsNLW9mkkziL5a7VIxJupg2shcKQPhvU+C?=
 =?us-ascii?Q?yZzK1BDS+2YulFaiSJf0WPzu6JktZY7ibvo35PGedRTcGAazCRy5sCTxJQuC?=
 =?us-ascii?Q?Erpdu8tpFrbi+chKbYrJOIcCIp8geKvg7eU85vi58UQ97ongNQMRSMEUQKNC?=
 =?us-ascii?Q?OqHPfmwSIOH0sbk3yUxK0e79/3u6KK+XbqP1e5OF5fPaJVDghGxyEDmH/a22?=
 =?us-ascii?Q?Fy9t2FRSYWQ7eWwmK/srzPN5QSdrF6nRUK4iXyasHvCWTD5DnRbjvZy6FKi7?=
 =?us-ascii?Q?RhQjT+2oyTBgNaCVvNe3lRH4+EcGw/x8oK3SwnapiEkW8d8uhBxARZV4zKyB?=
 =?us-ascii?Q?IPCmoGiE/wlebdt6wgBtqc4VFAhvp2/NyLHcW019e6ugcCvszssQaLp5eN4z?=
 =?us-ascii?Q?9QrVNQlQzDdRywF5YJySMhpG2ztMNpo9GwV66t+pAmQu3eyDihenwKHuq2t/?=
 =?us-ascii?Q?zGDniqTzHJVhkQnW3mABGOvLCLpTrUCGGBC65xo3F3XKAbiksW8nZ3bTDl5k?=
 =?us-ascii?Q?JukkSI/htRYu0pTYzYGvSOAe475wHz4Ui+6OK+HMGx7o8YfPSF7Ka3cPWsLU?=
 =?us-ascii?Q?5voYr+3ZyoAO31glsNTATHdV8LZjGlBZuYwCTDyB9MK67G8pnH3OzKFnL46G?=
 =?us-ascii?Q?fmMd2YBAZLxit8lhqFhR/p4o+C0gMbReANslx+UMW2cihGXrUKaTkwwyePFT?=
 =?us-ascii?Q?9kvsDV8/VosVl3KrF4s1bdS1rLXXSpZ4FeKTj/XcA4oc+n8LcRQQWukvlSyt?=
 =?us-ascii?Q?A8g2WA0kciisJ/FmFDB21qVyOqQBHaCi9CVr+d6kFDNMf7fT1VFu3gOmVsAb?=
 =?us-ascii?Q?WotJgZpWuS7jTzXscw1/vmVLXW2VVdSppO5xCli6nkqc+dsE7DiPqGdSgv/U?=
 =?us-ascii?Q?1YDkpJqDhKD/flIxbVyV6DPi5aClVOPEclToM+HhKUJ4CHzIbscFTbKnK1Jn?=
 =?us-ascii?Q?RB5u35LXzZGWKjwov52yTC7J5RGiGLW781qPzEHF8eFqqOT70D8o8dWTkGEt?=
 =?us-ascii?Q?Gv08kQEGCVqKtTT7QWyWC3ZQ/C2BsEmotMSpRMiC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bba068c-314e-48ce-9712-08dc3fa2d48d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 19:06:16.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jTUhd05jsWcDcFFO2v8ZkPMR3Y2O1s+tdD+QK6UaY4eaecUynxQ7O4qwN4/FfMPkMUZjq2/c/M3mW/xzNn+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9742

On Fri, Mar 08, 2024 at 04:58:16PM +0000, Conor Dooley wrote:
> On Fri, Mar 08, 2024 at 10:30:52AM -0500, Frank Li wrote:
> > Some sai only connect one direction dma (rx/tx) in SOC. For example:
> > imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> > for dma-names.
> > 
> > Remove description under dmas because no user use index to get dma channel.
> > All user use 'dma-names' to get correct dma channel. dma-names already in
> > 'required' list.
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Please drop my ack from this, this isn't the patch I acked originally
> and we were having a conversation as recently as yesterday on v4 about
> this patch because Rob didn't like this approach. His suggestion is
> better than the one I gave on v4 that you have used here.

Why do you think Rob don't like this approach? He just said this is 3rd
method. And it is simple enough and match all restriction.

Frank Li

> 
> Please give it a few days between resubmissions, and do not send new
> versions of a series every day. It is very confusing to have different
> conversions on three versions of this patch in my inbox all at the same
> time.

Okay, I think it is just simple fix and almost everything already close to
settle down.

Frank

> 
> Thanks,
> Conor.
> 
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > index 2456d958adeef..93e7737a49a7b 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > @@ -81,15 +81,13 @@ properties:
> >  
> >    dmas:
> >      minItems: 1
> > -    items:
> > -      - description: DMA controller phandle and request line for RX
> > -      - description: DMA controller phandle and request line for TX
> > +    maxItems: 2
> >  
> >    dma-names:
> >      minItems: 1
> > +    maxItems: 2
> >      items:
> > -      - const: rx
> > -      - const: tx
> > +      enum: [ rx, tx ]
> >  
> >    interrupts:
> >      items:
> > 
> > -- 
> > 2.34.1
> > 



