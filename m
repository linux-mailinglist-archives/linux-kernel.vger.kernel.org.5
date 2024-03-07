Return-Path: <linux-kernel+bounces-96320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84457875A2E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377FF282FAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F413EFEE;
	Thu,  7 Mar 2024 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WiNRNfI0"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CCF13A25F;
	Thu,  7 Mar 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850173; cv=fail; b=BzNem4CwDCdjs69yX44KdrQMTqm/LsyYBeluKbtEnU3VkvJuZEhDVkdVlhAI4rVVQ3rVvaR87njLE9a84lpyvC81pj4upQHOZhYQZhEeDE2wtov+yxeMR09gkbabQmEK7GuuGc8rl9SqdZAoQRATnhlzQMs1FuyP4XxnKtlvows=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850173; c=relaxed/simple;
	bh=hJyf6CKDcPrLnpEErnMjQ+o9XlTEqIom0QWqpP1J6kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OVo4PdXHYfwu9nO8vrasI6TinqlbOy4w/RHCVT95Acm6AJ0KsEjcgira/TNv1kLnFOPjpHoMVZAlkiVN13qiLDbClouALzS6qEb0ks6JormzRr6Pi/57cPOtfKLPQ5Nn81KtCuZgaFCGsfj+04HpAT4oF6uhNPpyYr0YZsv3uQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WiNRNfI0; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2xbZ8ug6aGnt+O+1rixikeLV13OjrDXcOVJYLOqIiwwFuVeVJLWZ3/XPmn65ifdsiMfPEHr5B2TV+JYXAju9DXXBExOxhIC4mbAT0T+AZ3T6XDweLPQ6eKBxoKFFhREi/6F/2msv5rEaD206gzXDOVFQvD3kUmbPSJcBm9eLKZ35Fo4hgPLg7xNH0DOfinWcZHvZvFnqsH0icS+1XpHMruAv55W5c5blOiiK3W6KudqAat+cTCD/nVMBMMTVzWU6AmlTNoyTVk0SyzDRSRPBNP99jBpKDqYERG9OJWj1eKHkHZzpRr+KG05AP3McSlFqpzL8pc3NTB4kux1Pay1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwRAUuYq+QhVm+/zXcihR0Tql+5HCzlnLai43Y/F420=;
 b=VQh9idkBVKHUdOW1pkdKa6xRU3TZy96sox11FROYAnNQMH2u2Zqaq/wZoPSSqQ9GRq6quxL/icG5+xW+SoDL6TkFgzxgVQy9ZGcesGdPLHLCGXC2wqOw/lZOxHRliPvY9bfQGQ9Py+73/vB4aCjmMtvSAEyuygVc8xWsYs2d1g+jaoP/l/N+UHhGaxAqBKn37UBOY20k8kw/TMywH9tZaAtjYNxcHj63zOe/zArnA3nfLP9tNwRCALGtibQ5vC62pGU3DKB8cobb4ogiGXq9hQrdXoY5rJq6OyReUki/g01HmHsHZhEfM+UlTfTwcVovs5KzXbwlCXbXWOIhXklFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwRAUuYq+QhVm+/zXcihR0Tql+5HCzlnLai43Y/F420=;
 b=WiNRNfI0ViC9AZvNnOKQ0pNcJ2T7040fADXmdzPDVx0PbmjxBe//XcQhNhaT8eTKlOkgoqsBF2p4RwkOv8jhQyJFiL67v9NY+gfH4bGPJBLQq6feCdlLWKx1abFEU5n4b91iVEnv6GhQx/An6UBA2JBtSG0w23bhY77sEhIM9Tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7596.eurprd04.prod.outlook.com (2603:10a6:10:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 22:22:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 22:22:47 +0000
Date: Thu, 7 Mar 2024 17:22:38 -0500
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
Subject: Re: [PATCH v5 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <Zeo+LoBkwN1E5GyQ@lizhi-Precision-Tower-5810>
References: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
 <20240307-asrc_8qxp-v5-2-db363740368d@nxp.com>
 <20240307220344.GA3133548-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307220344.GA3133548-robh@kernel.org>
X-ClientProxiedBy: BY5PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:a03:167::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f761f4-8e8c-47e9-acec-08dc3ef51dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8why5nK/Jzd4Vd3yvOJbTnWWeeBSTV1KKxoXXD7dAB0eNP2igr+ELpRfXkgaLEsdZPOMNQGazJ3vhzqMX4uKAbE2Wf2uxYHnZltx9/M/u2Cc9y1NVocQX3XiVeA54JkcriZ4LeqEpVvai2nuwcSBW40CbN6ojJjvOvYbYLCfl5N/Y/nuMv5/5Crpe9l7nyLJcDv+AohAU2k940ro0IZ96KpexivZay34hUTI49k4L3JLF6y0BAWjz3hVuQ6D4hpRXHUT9vFW6LYrebV1sWOhRCqIXrGvg/Yeyd3fUCyn1YWR8WOMK7tfYgQrhEK5jrrv6RkK3A+T0MR5ix5q9bzF0efgx9bWCNoU77H/059UUY6zuOJ9Myy3898tVpY26YjQBOWygKl4V8WgRg2kdvW+KKzuVJNVxinLFGkNaGBGiSU/zrjvHjee7HGkokRY2AHQiJ7jQ0Ib6B/4zZBdqwWlGBPzqpxI29QxWhTd3wNDyr0zQf7k0EWLPxl9Qu9p7Vy6QfAYYFz3NsXwraFLjWh8K9gG1j7CasbePYghsawy9X8SJCartGS58b0lrOmrIwbWJfmrrwLfniF2LhByKD25nA1PFB7pTkdg7F983OaKVUmoTDHxzeo18pl1srlE5AYI4Rqr+aHE3USujwCQjkpMWsGfn3DrKpAPGiZRgCdISfdPhUw0xsOAESz29AuMll5FP764rFuoGQBI8JiJ0S7gvvteYBfiBKJy8UT7t/rraaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bX4Fc7m4zJOMnvZPlxlHL+x3RQkG+pKfCAHtrMl3QnlSfltRxDOVnsK3/zs4?=
 =?us-ascii?Q?Hmry8WrfBNndkvCvVBea1ojiMYPXbrEkqiRSxSHlDI3n+4jD8j1gjAc6Ag4x?=
 =?us-ascii?Q?Eh0uhBl4oMoozAXB9Op9DK31ZjOKAJNzGWeQpAG6kX5JGb0LYQhZ+dtuILNX?=
 =?us-ascii?Q?cGhlFZOZaIrzs8NfVC8H7csEbDrNuZpRQcwfHj6+E+93mMg+b/J0p5cMX2cA?=
 =?us-ascii?Q?45r7e9bF5r68TbmwQqfiuywq8kt20YLfiu6telnALeLStGHNXmoaTQ4qT6EA?=
 =?us-ascii?Q?sSwtw8U5vNpmDfY5H5rIrbpUkA1753UNIjF/IHUg22tIWcRSX81ozSD9QApE?=
 =?us-ascii?Q?wM2Br3bRG1wo+5dAIzFUi8AHC/ZA+pj2VtCSz6PURRYZtXBvSCK0PYU4FExx?=
 =?us-ascii?Q?zt24rZjdYygJrHDuhjOxnauGwaR7erf1Cm95OJ5VqcJkmMrg94MZ+SGkstsI?=
 =?us-ascii?Q?kVpXP21xk4acdB3A2DTcKR5HPCBYlVs1LeYbONSDwSz+YOfaywEw4d7EvgNJ?=
 =?us-ascii?Q?/07kUN90qKvZCtXAViy65SxeocPQI5zOJEwCiUSl4P5txDtE91yvF7KG8MNs?=
 =?us-ascii?Q?MEZCASHOrN/wT9Qvra2VknB92vERqvT/uG1o+89y4+1iZpr8MG8lEUbLy8i/?=
 =?us-ascii?Q?JEbYgWngJkBSBq3Y/zRg3R3A1Sq6pLmwxt53gm7aWEHRkBM4YhrgkDgGhQ/e?=
 =?us-ascii?Q?vRzcSdxYGiM3jqQO2sMepwMDnyHMjMzcGUP3yilPwgSq9jl9fLrvtmBG0NfR?=
 =?us-ascii?Q?KUVpdTt9k+N0lfHO+oR1ueMIgLOmvvjE+R45pCJBNYJQEY64buEIWo9rkT57?=
 =?us-ascii?Q?dbBMbSN2P/+EnxWtNYqPX50kFZafexrporDaviyTwRp8IqRIqzy/VGdP0tw3?=
 =?us-ascii?Q?vR6rPIo6R4G4atCJAxwWK4B5KXODLwyInvU7ASWKEueswKURYjqDYKj2GDLy?=
 =?us-ascii?Q?hhofHqRDLC4x83J5IN+1Wg1jqZCKNPoRPV8GW3YHRs6cAXA82FuL9J4jvnuR?=
 =?us-ascii?Q?lHQJXxbHpnvAMfo5UtpcskE55rq8HtLLtfCbQLqfCBQLORcXZhoDlPLChKGA?=
 =?us-ascii?Q?yMoHgXDIdxsf2ntL3JkXbOvGJpW7K5NqTHzhaxli20v96AyEDz7aMN9f3OiP?=
 =?us-ascii?Q?/NxFCmjh1lhLzkxeFnog2GNp3RtbtAYvfqWkD5EmEhqFalaVcvRWBEmvUshw?=
 =?us-ascii?Q?Dy299FQ9KRomEplPc5PvO8itHV++W20M5zwNS3h7pIaSnIX5YDDec5h78JDm?=
 =?us-ascii?Q?ceYJWJujWpdsYeG29HLrAqpJmtG+piBNjkVYFAaKvQRiW1iWcFo/L/vIv7MZ?=
 =?us-ascii?Q?P4mX4v0BUY1dWv6X6W2zEqgYmxrxDglU1HBILGoqnu/rYDqivXmKig34F4bA?=
 =?us-ascii?Q?8wo2h+8V6ID4xcfF9rsSJnJTMyfTus4rhu7/oEX5PtJ9ai/KzfJ/aETxd+CR?=
 =?us-ascii?Q?Wlf1BF5cLAaptxSK8eaO1D8LKpB5b+Vcf38Mg8pOYgLuDf/5gyy5WQDG0FuQ?=
 =?us-ascii?Q?5mbymPoKQL0NM1evWAQ1WrWLPpM2fjsGUXAjWR2vaQD4Wa5jpTcks5KdYOUI?=
 =?us-ascii?Q?2jAZ4VxaJsGYg/o9AuCuJLArLJnq6Xwl3Ba+/pdD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f761f4-8e8c-47e9-acec-08dc3ef51dec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 22:22:47.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdKSEDyRbrphjHKtnP6RwWHhdCtpxFBYL/++pVb4WUl4A8slQN8vgKfa863ueQgO1S6HLv32Qdbb1462ThMhZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7596

On Thu, Mar 07, 2024 at 04:03:44PM -0600, Rob Herring wrote:
> On Thu, Mar 07, 2024 at 02:19:09PM -0500, Frank Li wrote:
> > fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> > have 1 interrupt.
> > 
> > Increase max interrupt number to 2 and add restriction for platforms except
> > i.MX8QXP and i.MX8QM.
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
> 
> I still don't know what the 2 interrupts are (reading this patch). You 
> need something like this:
> 
> interrupts:
>   minItems: 1
>   items:
>     - description: Combined or receive interrupt
>     - description: Transmit interrupt

Thanks, I remember I changed yesterday. Sorry missed it. Will update at
next version.

Frank

> 
> Correct whatever I got wrong in the descriptions...

