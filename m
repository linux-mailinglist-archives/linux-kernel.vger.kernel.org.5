Return-Path: <linux-kernel+bounces-94572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD219874191
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4073A1F228EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317AA1758D;
	Wed,  6 Mar 2024 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pcUrQkrz"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F014006;
	Wed,  6 Mar 2024 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709758433; cv=fail; b=aYiuUi+RIzrIAcC/9qvBvp8Xlkeo8IDTKt7b/ZUdbfNDPSEFI4E0JLwUpAA6qs+dTjYeLD8BFxh6vs6lXZ5LYX+XNlS9pR/iP89vXbvUBwzIBvCHV+u3dMzp+t2jYVULfnvRFIInK/V7dF53UqEV/FRRbBZo1ZU65DrT8t4nv24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709758433; c=relaxed/simple;
	bh=oawDAlumw+sGpF2KsZMo1T7z+uucC7P1wYj0MYh2Np0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mjcqovxOgFC3iZb35QAFHfbe0rXFfOL1XjDCHojSbh+5KEGwfGYZmQRt4SdOm8j2ebJlWJNUTBKmCU8BoUHP0gzYBNhIsLsY80b6vtBGtaqN3nYZpdUiN61gnONQfSYMt8XhmpKCYvcbatdO8XX0Zc8+DkSlV/uXtnOiylZHH14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pcUrQkrz; arc=fail smtp.client-ip=40.107.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOCproecGbxWmV5drrtjxSlFD9Fy69OJjgTWO/VX86XUUrDcp6YJ33l8PDRKgp155yrHdTXRSLuJ+Y1oRa4jR1lO98JxQF4ZPfxhSQMo82icv7nXwHbbpdPvDUiRQ3GWvMsIv4PhbcGt4+oOxnDZQht4hd0vS6VoJ6CbG+L+m60ADhP+M0CviX8dQ3mgIqOOPvnUP1ikkSn5aRdHPFJV+AMXsGsDrkFAUkcO6OlKkaHUEo94kINOKvnEz0iK6jMWEYKrdTHe4cdG5ZjNs+HNOhpm9ElL+o+Oh+RUHDQeXJYMllM0s9xO9aA0kqHUoMofFzROQhuJmftXIdruE49O5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/M1HV8HxMbuB3l/xeNGwJQ3jw82L6iqZC4TjICGCMdQ=;
 b=Hrxc4Phl14KA0VPTuI4rKsXiKByiO4lYCOTayaXhqtpRG62Lj3R/D31StOl/JVJviDqPmSdBpirukf1k0zRwPE4zvTzpiijDVyKGlqwn6s5WFis8MzbIuU8wWK4/SAHMx8QcKQWqFTo41ZCKV1TTVFvbR987A82Va5MugvjlHa66R3X0HXsW3jGBI3lpJrqUdX5hi/jqPt64crhfqcKrMSstb1ZyHrDz/uwdBu34ijheSmbyg7eb63kUKuC1t18Eo2ob8jLmlYHk8/CfgOW6M+1rrzjJRRCUDouPLw7Wi6P/uI8+UaG4HzCCJGfX6C2GAIbnDZ3d9ykoCDoKrxUH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/M1HV8HxMbuB3l/xeNGwJQ3jw82L6iqZC4TjICGCMdQ=;
 b=pcUrQkrzzC+6TiPtFaBda70r3YlxEuDLvIONmNilFd7FVEYwYRiSzBKK8kHR5BSWhUsNVH52HI9RsbtZu6csfhce3x3T1qd2IkBJOW9v9UDIoESs0kKyaFrYAJnGRaYamWKBRIYc204tGt4Qh8U3FJyEVYCdvSn0LPPv+46aFLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8484.eurprd04.prod.outlook.com (2603:10a6:20b:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 20:53:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 20:53:47 +0000
Date: Wed, 6 Mar 2024 15:53:39 -0500
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
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <ZejX0/FA/z4wa7cY@lizhi-Precision-Tower-5810>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-2-c61b98046591@nxp.com>
 <20240306202537.GA587561-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306202537.GA587561-robh@kernel.org>
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 125c0329-c2ba-4ff7-42e5-08dc3e1f84bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G4pC0h5G5Tyr6Hj42Ppkx7E2oe5iQtbaA7L99zhAlrruoyIOTj4b5j/6rFnn1SZO/7FZ8TVBE4UTHU4qV6rWeHRxhdfSpZrek+ymJRpo9PBHrfIAbZy/OAaYjfKWZm0KCNR8VVYA2ouKAtyAFJPVG852+O/8aMSjwP0xAedaK66+Rf1GNw6vp+v/7BBrU156T1rrBeojW0xNi3yju+r5CRkk6scYfcI4Eoneie2lU2itWo0ESZDaK+oLVMme6R8PGVbl0tVxM+5Q7iOnBY2o0anLVk2oqchuAi0pQ6ZeAlM7yfllYd1zTFqb+39fGdwFDE4yulR+NpF0vz2nM7VISY7feuwpj6N+6Y/MeDqY2TCoymQGelqlC1IIFqKHjrPAeSi9v7cZE1ynMBFABh4dXiXZ//TA2SwoF4Dt3sSuiJz+JS+gAfbjHqsft3i0zW39H9hiDfUhAMUYLS1TdopbtMoAOi6LD4vC4qqTCymS5nRPfOFhOwVYuoLsXRhg5XeOxRoEAnb5GWAs7zsTnZ/PuUk2HsvofX00lku7Kg9OmFUCoPA2jbWL1X2xoonBToaxvzJINJMDBVAXD8v1CPhfMQ6/5ahf3XeGTaYNkdKkDcLTe17E7O7fJDH4siPvu5UBu0siaFDsrHtlMoh3AhZs28I5EQ4poKWTXAio9Hs7PJJZHmfeuQrznSFa6/mPjyDHjT+dw765qSFRx+y1w/LF+YWrADdNFrQwv7rgUxS1GMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1kAk748voL9fyaGloPaP/ZYwrkAD6VXrhq89Mm1Z043Kpm4bJ6aSoanr/Zsw?=
 =?us-ascii?Q?xpF3WOivVp/8lSDZdB5cTcXJfPR3vit3aTJLdoCHs6CLjVjFJwYbwmZ8VV2g?=
 =?us-ascii?Q?vYO5s2OOdHaGn5CtSGDaUktll3WtjmH6rMtKhhfmUkpzcEpk4w6VOcNhkpKt?=
 =?us-ascii?Q?zd6sZ11gkVdYiNyYIt+7KkAn7MoZ4cfdp4xoJaBrmrCmgfsNgv7CvRlQiSPm?=
 =?us-ascii?Q?59cKFH6Fh6iEId2PVSSUpaKd9TyRlr1xGhH9eOdDczB0HxmUfA8Y9agYqzeW?=
 =?us-ascii?Q?Srvl7qIrD2o3IWUC7gDWfYQJ2fUisbwzT/OmON0rUlTil6mcpRuPvRGdV1vn?=
 =?us-ascii?Q?KQtyGAKvp5YhED010VHOd1EJ+pexADnePOi20qlceaoH4CKkFglYyNOLPlFr?=
 =?us-ascii?Q?dn4a0FwKu7DQq9w962CX0ls/1anKHfy4P4Fu+IQwXSxNirfeq2RwQWjaLUbV?=
 =?us-ascii?Q?HSBNEQbw3YrwGR3M+qFlIVI3TEscCbrEHv3y//PjKXlh6ITvWB9o5H0bpNcv?=
 =?us-ascii?Q?ZoTB5prlWbsQobN4qQAFHUnDB/SfBP6zlY833uAeiFi98SWhDz1Og+xc7VBR?=
 =?us-ascii?Q?p0BRH9cEE+I+McghIQL2QzswNVBHJL1BO7O5c2xEz+PXm9qt8SuF0enwrorU?=
 =?us-ascii?Q?UYtq9cQDhCnZ+7jBDALi03hPsOvswOmVHx1roR2eAQdjtZXunJZHepnaKETv?=
 =?us-ascii?Q?ncMwagVkA8TIqHQjcN83Y4QaitfHwaGmYmtg2I9YGhFgQYnYVuLYSHSxl78G?=
 =?us-ascii?Q?1lb9XoA1L6qiUwvy6qWSMZGfip1dax61y4SrVTdfc82Pifz/r5uk5oN4kT2s?=
 =?us-ascii?Q?DJgL1dx2Zu8PVRSXSyRymcKfHGScVJZuoRZQfWkKNjfM3C6qNCN8eiW4vNp6?=
 =?us-ascii?Q?uWSrFrU+GOFNhuvEnc83KvSLJJgo02aInTYqIQIRPfwM5ruTYRWs0I2ME6GX?=
 =?us-ascii?Q?47ldqTNtJu6uLq1RD5GK44nH0JGVaZQqVomq+dYc1zHECHpN6Pp5+Q35Ckje?=
 =?us-ascii?Q?H98Bm8VkroEU22fbhcJfHy0Y/Jejkdz+lY1mU3jbLWle5Ih4YMN23h/XACUL?=
 =?us-ascii?Q?PvEpxNzruxzNYPQ4O7akOwAYyGjppxsq3EpPnT1Vdml9I8sN6f2ttQY9Rybm?=
 =?us-ascii?Q?/+jLP9HEUZFGnofKQdcJnSH0juIfetirzm4nNDyjuME/xUfNb0s1UzbBcvJq?=
 =?us-ascii?Q?rrdOB7lYfOJ5pPkzZUQgZGiRjMYWdQjabthN1p3bgfBzSRQaf0bW8R/zqytN?=
 =?us-ascii?Q?1vRTfBOGh2VqaZ7QeEMOOGFsAQFJZOrew4nbQ8tF6E4X3dD4e0S+Dy1XJyTk?=
 =?us-ascii?Q?V0kltmfKnfVc5+VtOCXV5n92WWdvH1V+J9AB7K4yjROqO80zXiExX9WfRnCy?=
 =?us-ascii?Q?ILICtT5FjmqvA0944ftaxmRjih5yp5VHRrpAMi9N1OFrIKSYx+Iq3VlI6E2V?=
 =?us-ascii?Q?hGQj6gj+QB8EbX67E4efbhRY9B86Q6UVzpb8T+Ro4UVprejcypZ0Q9PTjQzF?=
 =?us-ascii?Q?ncRBqKc+ot+u5Lj/4npbxDfV5bbZXMlm1u42BFLZmBqqvN+/lGMiyxG8d3B2?=
 =?us-ascii?Q?WeLrLUSvcvX2uxkLmCg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125c0329-c2ba-4ff7-42e5-08dc3e1f84bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 20:53:47.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8pBEh8GD/mlwKN7bekTOmBVknR49vL8iJzYocZ5j0/19R2CTbMH6Ac1/zyp4KrbKXzDAzlTDJpgpiEswo811A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8484

On Wed, Mar 06, 2024 at 02:25:37PM -0600, Rob Herring wrote:
> On Tue, Mar 05, 2024 at 12:33:03PM -0500, Frank Li wrote:
> > fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> > have 1 interrupt.
> > 
> > Increase max interrupt number to 2 and add restriction for platforms except
> > i.MX8QXP and i.MX8QM.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > index 56f8c0c8afdea..7f6590708e1ec 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > @@ -31,7 +31,8 @@ properties:
> >      maxItems: 1
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> >  
> >    dmas:
> >      items:
> > @@ -101,6 +102,21 @@ required:
> >  additionalProperties: false
> >  
> >  allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,imx8qm-spdif
> > +            - fsl,imx8qxp-spdif
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          minItems: 2
> 
> Nowhere is it explained what the 2 interrupts are or what the order of 
> them is. Is the first interrupt the same as before, and there is a new 
> interrupt for something else? Or it's the same interrupts, but they've 
> just split up into 2?

It is same one and split to tx and rx. Order doesn't matter. They uses one
irq handle.

Frank

> 
> Rob

