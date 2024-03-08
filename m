Return-Path: <linux-kernel+bounces-97490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A95876AFF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2417C1C2160D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239AF58AAF;
	Fri,  8 Mar 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K101Ld0X"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D0225D4;
	Fri,  8 Mar 2024 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924503; cv=fail; b=SSrJhA1eTzpjt8tUfCQEXN0VO4iU/22ONw4h2Bvt6+nSehiOM4/NTRh2G73DZkBOUHszbbSTihR8ULAkE2ugZOqU/kNjSkwBpYdk9OAEzY5NeHeABdgB7li4DjUFGvZbKpl2l2D3Hsy1SREj/TCVWPoyv6+/0FKatERaNEafmK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924503; c=relaxed/simple;
	bh=gYy/qjjO1zQ+pWUO3NeN4LwP7K+tAh9GXgpc9WIxZnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dbQ/m3osxGBm7r0E05bJF9b/KbyLv4h7AWTLek1fpK0MTSoq7cLJzvpIN1yYfRop3hH0STFJuTOZM4wsN+mI5+cIyUfMSxAyJ44rgPOAskzxmN4q/mDEWuPbF5MHEf6P5tLPBw1Kj81bD9i5fTuHrOind84FiDZK8AOXVvqeh0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K101Ld0X; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc4ZAt2t+p17v42BGpMbTQ1u/oyaX3EfEhENPSdS1jH78PRBDipmYlYvrgXj+qyRN90xys7sQUemnNveM13xVcXtx7700GADu6Nl4ANforp94p3AXvaHEl8DdRBt2WdZQCRtetN/ZcaLVJthrCFp6R74f2eFGP9lZuvTY+ZpxmKTXJnWcgAZx96+gq6sblz19Df/NVA0TFiLwGFqyqzMFLTc56Z7yRqNnFcOu361FT0IjLbahss552q8nxElyuv9KFyAo6zQil0UoGUqH5SsfxGhxcWW6bIYzgjUmP8rpFZfaEVNumPrF9UrMRtwSNXiKWKgCr2u61+mX79XI8GQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+ntK8z2Wgpp5dGyGZxcQCFN9alXH1rCnQC79IK7CdQ=;
 b=S1vncN1ZjSe0dHa1mFsfY0QCrbNQjOJbd6UopxwuqZtvfsIYWURURUSy6A1BlOuksyQ0pGg+FpuHttzr0AHvEELMUgq5djXW9N9uuP5fJ7vAivSyh05F3WCe7DGhYzt4yPZrLrfeIGeZA7+0xL/AeeLQtgOjMou/6T8hsO6xzguKZMS4zlztEBbY3EbPGE0S9beuBiZTQq8IFHzpuV3pLuu7iFQaJTl18DAge/bat09YCYEbxPUdhK3MWLKo4r/nzu6DgmIkrjWHMEqsIzHAkFgPwAqs/F+slNGG44sqpxgIowB+G9r91ZqisnTXgxKgH046+0be41+z7Y0PsdJrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+ntK8z2Wgpp5dGyGZxcQCFN9alXH1rCnQC79IK7CdQ=;
 b=K101Ld0XVM4ycURSE8K3iqtrpnOlHBhISUiVmEftTSrcSkgtr477AZB9uQmrEoOFrl/PDaVabmm7sddNe02K5clNZrjbVqnmi6WulKUGSXVGs58/ilujO1prlSwyOO23Fipbr8P/gtZUM27r8z1Uz3nLTUie9x1IShFvHoOL/V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9869.eurprd04.prod.outlook.com (2603:10a6:10:4ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 19:01:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:01:37 +0000
Date: Fri, 8 Mar 2024 14:01:29 -0500
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
Message-ID: <ZetgiaZ1+wt5lCkB@lizhi-Precision-Tower-5810>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
 <20240308-asrc_8qxp-v6-2-e08f6d030e09@nxp.com>
 <20240308181103.GA855753-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308181103.GA855753-robh@kernel.org>
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9869:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b04cb3-6091-42ff-e80f-08dc3fa22e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NNB1I8fRMSDr4jytv6tu0AeyLc/xBscMnll+GaDHc63hVefq9k1azQ0ZFFLo6ELfK+9Fn99B1gCsPje20/xsl82srlwj1n593yIKve1CFNG7bhP3Iw7Y/dcRMBsM7AMbG1cIS53tTvnoxAn382t2rKeCGSPimh6fSmCx+ptxP+brUJzL0/ITqhfpmUNlQulNXbhmomoyR2isVllTULSBeTFDOmACC/CdDAj9GvrXit/+f0Z7P/+cMA1gjxLQk6WrRB3OtecWB6C5Vrm5WIC2BsjpC3tb7f+gO7HXzss9HwLzCZU4SyOjCui3mzr52K9qBZF3QQC7pH2NBwF6xwKrrg+SPBnmgJ67b5I3taO5kZuohnbt/WJfy5dg2nEFVUC3O+2xszQNeX15sNChHfALDVVDM+e3WVoHbyCuiGBgAq9ACMq8vXqiQ5e8tme6vEw0shyushCVJUFTfzv70Hrl1j8a33YU76qIPTUUFG41KbfEEtB1jjS2cwa7gcCrrsxUObbS4HIOeRzLNv57BavbOdyZO/HRyfQMbG1G4Nc5NQS5y7A2RkOQznTurdAlr3t3jsSCDvycUSuWE9SvBnT1m/MdmEHs5LtwQT7PSsTV/FkXN0LcgucQOpDNJFRQyzYGxS3QPhQjLquTa3b6NXSemfRhBEQFsHY4FLgjxdIbJKA/ayACrIFv5T7PaGk5D6kgvqzllY4FxC4ZozCZaUsc/q+7/f/z4QdYqta9/KcIx/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BTS2vBDq4dq1atuiMQLzAtyKzhD2qa5/B1txylMSidotnf8ckZQHPIq8xGrG?=
 =?us-ascii?Q?8X/hMfS+v2dhYfOHIgamdHWmhUl+sycl5Zpqr9xYU3Y/5yb+ypZBgXJRSuAs?=
 =?us-ascii?Q?2ZHuRLbm34c1APZ3JhKorny1bWy0HOrphimIAujlle9kJ0r1Z+SPs7SQFJkv?=
 =?us-ascii?Q?vcxxw/tpGHTPQv5bBI3QjISfxr7oVgv1hD4An8JFUdN1YrxFXnSRzm0+FOvq?=
 =?us-ascii?Q?CV+dYqpgkDmsgx7qfx6Owv9vf7mUsDzU7tBhlwlbRqA7GqAzgNJZexbqE+2q?=
 =?us-ascii?Q?WGH6+NFExeh1T+cCPzqjDrcjxOWbzTScKCgREYqAc8WAoFJCnvUVWt1saCUl?=
 =?us-ascii?Q?qyQUFM2cqqSub2zTPgnTPUZdcfDn/gltWYMUDIO8Bvy+IQRgwVFxO45TsJ73?=
 =?us-ascii?Q?gQmtvraK/xMDYVhiDjVL2wb5Vp1j7eWnDHZMqiQ/HOxJ8oe6ejHTP3Pye4ge?=
 =?us-ascii?Q?JYLKI99VY10cn39GqI34kcRoQe1FOb7Nydk9ihOyDfxL3eD2UTh8fp7UfHBI?=
 =?us-ascii?Q?VnXoMAtzCR1FxNJ2CcNVykimjLMXMOcwdqGnbyAkiNhRLcofXmCQo0iyimel?=
 =?us-ascii?Q?TwGwRGNucnphtfal23zPg8AvHpsHSIjknBTFJSjrAPLFW03cs9/6KncM9QDA?=
 =?us-ascii?Q?pZJqWcttabU1/GrPsWwHxnWfr+p4FkabsAaNNfusXy6LlZ0tc6PGxuhk2aAt?=
 =?us-ascii?Q?G2sAMDfa12/kNYZidRucuksDH6sRDD4OxLHeNjRdVQpUWPlVABLC8s4nEHW0?=
 =?us-ascii?Q?uAiHeo1GqAS3R5ssgZNwVB7Wn1y6XunTP8QEZjaaJWUlyXGSIAx5AgLTWzxx?=
 =?us-ascii?Q?j5IjZgz9QUKIfKK+TCp7l8UggjHpW7F3d5CCcZjf4NMVZXx9nVRV/fGN09Wk?=
 =?us-ascii?Q?0ISdBIvDzBEKoW/gx6mutI1LUKP4lkBn/ZFYO4KOE+3oWc9K0besEsN+M2Tb?=
 =?us-ascii?Q?7CorymQ9Se0SRmeZBXUHV7Sz7FG5rxU8WM0ttu/N+iCwcfqyTqOUR4olIcLX?=
 =?us-ascii?Q?iT+MKbIZbr7lYHH+/Db1iAJkrybkDNsxZ03+LXnJRGtloNj86BUADsxhUEVS?=
 =?us-ascii?Q?448gy/nK160cc0YFLRa3eiUYxNmEhCd6IjxhugV6V+gnzck6ctJRb4ObVCyx?=
 =?us-ascii?Q?scbbhmTnBsIWXSpOLMVOgNEMdfcnSnJ+i0BoP7NuHouaMoZvhRfFxhP+DshR?=
 =?us-ascii?Q?LhANXpF5I0EFbW8DD2OWlYJCHgSROHb1HQuN8CVR5eju4bgTpsaC8SPG0IQ1?=
 =?us-ascii?Q?l7C1OU4TEyp5m8RfEYsJy3cfW0s0oaskNlMz+MpCsZGhK5/e54RVqraYzyJm?=
 =?us-ascii?Q?lJp9/gVd48IRE4pb9XlIxYd48hER/WKLHakXLFGKGEmdSlpFwgVBpQMlHybG?=
 =?us-ascii?Q?k3H94J/I2T4Vq+YVpuU7OZH6kTrcbwbGGwBTlIgvhZq2b16UiPYXrAz+cfvl?=
 =?us-ascii?Q?NQGj3gwFdKLkEY7wryjsOVj946KmEd04ilJbsvvHOyuk7wc9R9ztY360fLMt?=
 =?us-ascii?Q?lR2BrRdp3FxRG+l132eifZAVISBlgrfw9S6hy2AnEagyS+uZEEo1Am9NvHDY?=
 =?us-ascii?Q?ouVIHNfiMPxdIdmzaKCVmCC2zT56+q7w1YiBVx1e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b04cb3-6091-42ff-e80f-08dc3fa22e17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 19:01:37.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwtejvAJ7ag/q+SBqu81h9sY1ZEM2CK9xj19T7SsAQYGOnQoPPpfUNKF2eIfzYkq3dObn5+6fWjkUIieLoT+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9869

On Fri, Mar 08, 2024 at 12:11:03PM -0600, Rob Herring wrote:
> On Fri, Mar 08, 2024 at 10:30:51AM -0500, Frank Li wrote:
> > fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> > have 1 interrupt.
> > 
> > Increase max interrupt number to 2 and add restriction for platforms except
> > i.MX8QXP and i.MX8QM.
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,spdif.yaml        | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > index 56f8c0c8afdea..a242f68f99f18 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > @@ -31,7 +31,11 @@ properties:
> >      maxItems: 1
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      - description: Combined or receive interrupt
> > +      - description: Transmit interrupt
> 
> Test your patches please because this will have warnings. Or, you can 
> put in *exactly* what I provided because this is not it.
> 
> If you continue to just toss crap at us at the rate you are, the DT 
> maintainers will either just start ignoring your patches or require some 
> trusted review by another NXP colleague first (offhand, not sure who 
> that would be which is part of the problem).

Sorry, I run wrong command to check another dtb file. So have not catch
this problem.

Frank

> 
> Rob

