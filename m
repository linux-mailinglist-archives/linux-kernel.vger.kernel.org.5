Return-Path: <linux-kernel+bounces-87362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAA86D352
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47401F2358E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E6134434;
	Thu, 29 Feb 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jy5RLyC5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7981E499;
	Thu, 29 Feb 2024 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235517; cv=fail; b=nzWdVSUgxdYEbOuyFGnoqYQ2g0Bs4emJfdKjLMEHl5ZExqCW/RZ84xKa4Nz4CFb7JcR1YUppnZbNNsncMK8s5QBQAbRW5gFoY+qJRn8CSpfM+aWwofWaJhbl1POArtKXxzcblZvrzMmjdhx3HB16AQBNnrYE9+BIQSPsqlmmJ6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235517; c=relaxed/simple;
	bh=hp0UREfEE0ub0Q9PPldhDrKWRf3pLsV7OHdKy/wtjWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CzMUjAtPbo1rUAkQ2mB22ByvvvALmTVybi9BGC7q80v4Jb2CfSm6lxh8TYukLOQubKl1jDcPTucm1k4tk3wJDAkwKfgYo/JFdlnNN7gM3SKRCUwO6AOSC3INyfFRBKgkFhSgz0PkAvC1V2jp8qus2zjwZwZADD870PnAhtvRMxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jy5RLyC5; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F46F/AKjOUWLbI2Ouj5y0Sx51yVhPAOxACavaHWUHBXykU8oYw7Ru9DzETRjc5pCTd/HAbTVgx4mv67I0QZl6mfCOEEsVDzzwSWOzdhTPdNEaNHr59O+PZoDejQRYIV09uFuE2ZXseWIIL99WPuizHwXdeuqKjzhdKSgFF45vCczN5zOI1VFD/RHmOZKEqgBw+eb/WjiUJGpeZ13/bbeX9ZdbfSOzGUA12FZRM4m8rU0BRvFu9kOa/u9EKZDK6qGXkTfEfh8jLFEXMF5Olqa1ahOOUG4VRFSN1z5jUqF5OPDS2SdMe2JwWQ0XsD+2204sqAPll96PWK7LwQXxRDi5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1zzcsM6AvXKzL0HgaJA2/glcEsgDI3zBlXwhA1hcQc=;
 b=HDZBeTjRtPof1yZKxENkQEJ0Ci4D6gVqWFj+/P0iFbnuvbsOJv6YG5Zvg/kKNjxtiNpDCdYXgWqGVyiw/Nh8VilO11kkHZjFyt7ZScKMZ9QNnOQ74TIbXTT32hwYv6rqeSWwLybllIhaXkAxsAotLx/1maYHBENJpfBKs2VIIXp1paKWe0FdQa+jO7fqdXKzmVDJH2n7mYeAXJPum9O4Yf2ubHgLsw3TwxONj2Qeofw74qippoN908YldseLiNCZoEgVvYNFubAF4QxRsZoofjQrubchZWfbkweX81VpO9n1T+E+E92jDFncy0/dr2GEJO1Y6d5JRm3pvOt3uLbAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1zzcsM6AvXKzL0HgaJA2/glcEsgDI3zBlXwhA1hcQc=;
 b=jy5RLyC5D0QDxCH99swShNzakCG0MVqo7EF2aSq88qEyyGcQ2sDRBqk3ZuFT9oMyefuYVxmznL6jphOyzNCxF4OISSdooV48y+eRxSYV1pfDq8qM2TqWqHtY9laFcmo/gj/r67Uood5WxKXk9yTY6k/ppX8+gHE9kpuOv3maQ8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6833.eurprd04.prod.outlook.com (2603:10a6:208:17d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 19:38:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 19:38:33 +0000
Date: Thu, 29 Feb 2024 14:38:24 -0500
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
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <ZeDdMJlxBL4SGkws@lizhi-Precision-Tower-5810>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
 <20240229-rundown-isotope-954ba9ea4c57@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-rundown-isotope-954ba9ea4c57@spud>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 943608f0-8070-4032-2a0d-08dc395e03b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sfKb/5efQQ3F0Po8EhIhMjakH1Fe5WjUHEDTbPrk0wPMYtg/O8gwpQwd820s71dFOoGPvjqHncV5BZM5txvYkqfQFQdEAfPLkTcj5WKMZjpvABhUSOd5OTTyn9iGwA2fasgFvHX1jdCRQQoAQx22llTQHzNgcwg9wx0M3Pc76wb5QUwKfsOBz+g07PrhZOtXTYtB4T47ute+2bBHiIAZ00n1WHWjyR4f65rGqhTgLMsVyYTMyTBB0ze0SvE3G2XJTUZIVelZ0mDaWABaXDAGO0JfIlYWdDCEetG7URvfpA1XGxmIZGJpFl576GKOa10mrfvx8qnAIWZRoEgYVHNRxOZ3g+lPukFKQrdJ/UTVrZvXFOTtivn0XusnNcdUy8qkmtC2sXzZjx9v4Mm+7hFj68FnAIh0/CRyOUKfid+FG188Z5qXhA0Vbz3UdOOLmKriRBy59+Bd+VRH8upzgJZW7zwDPtUqfm4G3ibrBU336DDvwCHtr6krIKWxZc2J5atUB2au/3pdKoyIfc2lwi6bOvn2WA1mFJCuso8AcLGbZkQFnIBs1g2UeASlrKDl6HES2Q/EYiMVwgYmIuoOd4fFlB2oqPfge1i2dYJlPy86JB9WtuAcWFVmq9haZDXa5mQpB2+Py7Y0kvl6r81BlUJQsY1OLOBFYPme2FFnHXmV2v1spfrfwFWrmdapIoSgi/X5EQ5qPFq8xZWDZvBhvQShjXxCIH+jD+t2Kz6kq3ei4ns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqDVGuMyPb5Nmus7BNsbyfNYy1yaMxRGna1NovDdCjgucheZQ5gaIL+1sebK?=
 =?us-ascii?Q?9mrvC4bNMzbDdLSJ+MxMQWm4gYs/VK2tqrXwPYuUZuBUQDe58eSrWxwkHmfT?=
 =?us-ascii?Q?kv63m+8MM0hRtBsOXCrCpT4haXXKz/mWZRsEJ8bwZNUHyqXfR4zqMDp/bl6A?=
 =?us-ascii?Q?3kc23eQW5a12pyxyIKHp+q3OTN2wwi6KJUweslil2IZBNVYY+qQu7oQx4PNc?=
 =?us-ascii?Q?CYicN4+l+ud5NUGtM+4ltdslqZotzGWOVYxAmeASLWRwP6yDlE3VI3wDaY6u?=
 =?us-ascii?Q?Y0ZCWwc4GBpiu8CfGhfp4/33yX4gL8JSyVxfz/GXzgefGiQOkWtxPM932PO9?=
 =?us-ascii?Q?q0ANSmgDm4elPcNJ0dJen27k15Xkx6LbgILf3PbTCLQa0SkERdcrldai9qni?=
 =?us-ascii?Q?/MRyU6IW0ywE1lXZAuxg2jyA2+m7JlAw2126S3VsEMJLV9xrm2nlQGizXw2j?=
 =?us-ascii?Q?i/GPEYep4ryWOgRHC6HtRRI9OmEo0OHiNoo4uWOEAc3IF7m+KOKAOLCLvP8I?=
 =?us-ascii?Q?K2ZZd+Tih7jVDqAVCWYIxrR9VrQpwhRciTcZvudfw2nSjTsbiOb3TRGBc7or?=
 =?us-ascii?Q?Q08jL0h4EVB1gNVPyDZFBcxNMkMo0570CJwmeac5g+WYEzuhG0nYq1OJMhdm?=
 =?us-ascii?Q?/vMMdTTSCEYbzMvy6N/Ri2PSl6ulPwy4xyYaTf1COndwTd/e6Uw21gbUUtbE?=
 =?us-ascii?Q?YvV/Ohq7XjY1Z/xyMFbKYJvrzplfbs8MViy33OdZ9W+D+AnWsEa6KiU5Opfd?=
 =?us-ascii?Q?qwKX08AMZUWZCe/NZGAigEmFuSoZiOtByPwO3Abp2LAuuWGHAL6ITr+H2wpF?=
 =?us-ascii?Q?b4485+mFaExc9iQWUG+uf3BqhHRAPVUjc8JI0Gin1x0bXnqYnyaYxgCfnoL7?=
 =?us-ascii?Q?w5FWJWHHseCsxM2Dg9w9sFOJWjg4aTZWTnqymwt/QgPSeHHKPykGFpTbhCSO?=
 =?us-ascii?Q?2jrC7/uKFtJRm+Ww5omHZBnYGNu5OTCpujfcZu8UoHm4BymBD8yPVpXUAVoW?=
 =?us-ascii?Q?VTL5uwcq0SU3VI1EL2JUqAy7jOvdPm6Xm+EZ7A8i/yzJaFNYUG0mK1jHDoqj?=
 =?us-ascii?Q?CViGGDgN8badj4ZPx/Ck97MEnv4pbXhTJOSQx5vz0vrNtRAzkddFJr3oKZnb?=
 =?us-ascii?Q?SiiCDRHUDKuBIRtIp/BfSTClKbhpVHxGYHVO665Bl0fTQDkeu/jGtytvPSS0?=
 =?us-ascii?Q?P3B/O4ZRTVQWNbSj7o7tEljcLaQR17iV5nvcStUNNRbbayad6O813olnIGC/?=
 =?us-ascii?Q?4bNTIqOecFGNTRovWZoHb0tUUHsBC6IjuB++ZMssplvIXjYcIy/Mc0W05zen?=
 =?us-ascii?Q?00n/L2zsK92ISRaCppOlMD1Ml7VOWejOHGWsykZv5Dr7aiVIewoN1Z6qYJbf?=
 =?us-ascii?Q?WBL7zj7CCu3INbziITJeRqm7Xc7HPGNsVe1zHP7vkSafiQEPb6Ho4F0I0tML?=
 =?us-ascii?Q?cVqQwYsn2WVjAPmfG+m17fdEY2G9iZ19OB/r1uF+mXRl6elbcRRfnzi9pxH+?=
 =?us-ascii?Q?6YzZzxmk0z11NC4mFEZnTYDi8TOjkhYIKd0CpIUM23yC7MXl0IkX/dGjIYse?=
 =?us-ascii?Q?9R2SNtQB1X5dQTOT4KFrJbpH4aPDILqmeZCVBW3u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943608f0-8070-4032-2a0d-08dc395e03b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:38:33.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTORuBSiU+4kJ8YmQVj97sHE/y24kCNLy38nmMzQtJx8qhejtEwybJBhHVPKKwmJVzWewQ6g2bal7CM7Mm27FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6833

On Thu, Feb 29, 2024 at 06:57:29PM +0000, Conor Dooley wrote:
> On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> > On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > > Some sai only connect one direction. So allow only "rx" or "tx" for
> > > dma-names.
> > 
> > Which sai? Can you restrict this per compatible please, so that someone
> > cannot add 2 dmas for ones where only the tx is supported.
> > 
> > |  dmas:
> > |    minItems: 1
> > |    items:
> > |      - description: DMA controller phandle and request line for RX
> > |      - description: DMA controller phandle and request line for TX
> > 
> > The binding already allows only one, but it documents that the first dma
> > is always the RX dma, and that doesn't change with this patch..
> 
> I said "doesn't change" - but I don't think you can change this
> trivially, as something could rely on the first dma being the rx one.
> You'd have to check that there is nothing using these using indices
> rather than names before making any changes here.

Linux driver and dts with tx only work well. Only issue is dtb_check will
report error. I want to eliminate these DTB_CHECK warning.

And it also reasonable, only rx or tx for a special SAI.

Can we remove 'description'? dmas should already descripted at common place
and 'RX' and 'TX' are listed at 'dma-names'

Frank

> 
> > 
> > Cheers,
> > Conor.
> > 
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > index 2456d958adeef..0302752d58a2b 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > @@ -86,10 +86,14 @@ properties:
> > >        - description: DMA controller phandle and request line for TX
> > >  
> > >    dma-names:
> > > -    minItems: 1
> > > -    items:
> > > -      - const: rx
> > > -      - const: tx
> > > +    oneOf:
> > > +      - items:
> > > +          - const: rx
> > > +          - const: tx
> > > +      - items:
> > > +          - enum:
> > > +              - rx
> > > +              - tx
> > >  
> > >    interrupts:
> > >      items:
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
> 



