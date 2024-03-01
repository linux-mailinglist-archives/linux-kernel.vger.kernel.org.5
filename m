Return-Path: <linux-kernel+bounces-87886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A429886DA80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B59B22238
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E3481D5;
	Fri,  1 Mar 2024 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ld8I+1zq"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EAF3FE54;
	Fri,  1 Mar 2024 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709265845; cv=fail; b=mZzFUhiFufr3yTFek97m3j1iFz+jlypwhPFHiYV20t2q0HosaUfX4lA9QgIiEIuJu9l1L819G4a3YqRy9sy2hACy5jSDWUWyDsJk0tYN+ayJy6LgUQAAm9Qt9k+F3iC36i9mVWaRmoeT+X7DTsLHf0YQxGDDibdZ15rwmrCq1yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709265845; c=relaxed/simple;
	bh=GNBAdGFbZUno3Q4VMnewvsnau7J5jTSjYKBVqLEznZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TtwdggUH0qqd9z9Q8mOcnpIG9uxavbyPKcNO9gvXM+8DMjsG7aSIjDCsWgyUf4CDkeGYDnRgd71pGiFJGNhSJMJUujoNLrjlPgiFb7bOd0e6zp+q00jXv642QUvCuScfC0jRns4/Ya08OPdZdM6+uTChQsciWH4R2iXn1YjaivA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ld8I+1zq; arc=fail smtp.client-ip=40.107.8.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMLoY+riS/1YWq4wuRPaWJvmjziOUwHL+1Y4yKsm2fbK+4mnwhaxOjJoAg3WoHA/lQ9fEh1X/Ono/b3lLgr8gJZRHOEcZgoJUVF7MQY4IhLVTAow4fRZiZg5orF/JtZVzYSLWX9Zcaa7xhS5G7qqjbkVTXRAcY4oDIsAkNf0syi3pQn5+9LHg6uPHFW9/DbrWgb9DZT8d7KkuQljF24cfcvVx8XWbYFoNj9k1ng0Sr05GxQAc4cTT7YkdPr6moUofoFkxYhIPC0h0jeewmEdujhfIhDB4Q5j7B/DWZOmelAdY+oW7ZLVjihoUaUFUU6rHcB8ZMErpTzPdc+InQn3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRSU5ZtTMgDpJ5uZLebObUxdPVWRfIPol7BPdUUTZek=;
 b=Pg8blq6hvQcNmU9gIybw1v7vLqiV0/JpRO+S1bhCKYoKMZROEGuNdQ43us7UXKO52DRnBZHoQKW35ueu6mTzQ47SSnxxHmoa547kFLv+dUvaQ2+v7BQInr7jKC5is639TM8bbJfs7+ih7enTLzOvahyzOx7ZV93LF4VQQd09UR+QbnoCFHzuym7+SWnFR3IBA/1rNZ9YXLcoj2fjnkbuYoGwIDH7ZzaCPLsFVoOxzCnQIRhcpmY8Ev+6BRyWeTp1WWyZJLd6xy1v8pjCMuNphteUDJe9Nc3SRpBh8V6UoD1a8qmgtR/2vvfCNOZg9oFGGdd7TnUf3mdCNf2zzmX3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRSU5ZtTMgDpJ5uZLebObUxdPVWRfIPol7BPdUUTZek=;
 b=Ld8I+1zqNOMY+XJPAbxbWGx2Uw7D/rsrbSRZ0uMcnxsTEqevFycXHyXYQSWqNZmY9XczlYrRpX2jIYqlcTZ1uEXG5JEi3Efls/SpS1I5JBOx8bDfM4eHRn9AziYdug35y4KDhtYvIsKwSg6UL64C6+XkmZM6utRA1fioz28x7rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.37; Fri, 1 Mar
 2024 04:04:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 04:04:00 +0000
Date: Thu, 29 Feb 2024 23:03:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Subject: Re: [PATCH v3 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <ZeFTqM8o/eozl+MS@lizhi-Precision-Tower-5810>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-2-d4d5935fd3aa@nxp.com>
 <3460ecc8-d7d7-4d1c-ad0c-b32efc3b9049@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3460ecc8-d7d7-4d1c-ad0c-b32efc3b9049@linaro.org>
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 29160c66-f74a-441b-04b5-08dc39a4a017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zAuAV9Evdt22TIWmT/rBgncmeQwrKsYPpfZjGJbYz9l4o8cjN51pV2v4H4nHjjVxDt0RSnzMCSMifPJKuRoJdBz3wZoWtAe/bYQOXFmbGSG0PVSIUczV3/iQePEka1HTEK1kWbSSP9RjH8XI1A8uG484q5ytATKrE34CyDqw2avsQoV4Pu7F12H4XH/u00NZesH1Cfw6JL+Sv/j57zWf32GE4L1AomkRYemMJhTOv0e2iS8xPK6abEXUf/0J+52Vn3DYE6ofj9IGmAaFNL2FIHY9o8dwixmJ1G23TRPEl2kWrUtMn7UXxGRF6x1j8s+2gPK/tomARU6eTxIpRNER1ZceZk+pXOZ9ey7JxSm2DnWt8dOOyojD1RSu1X7j9Ke/HILmg8lI3W9hcrbuFrK+Qzx/VqbQjXFhrHlLf+zdUtj4nsTBPa1QCd01vhBM0SF33gf6gEatnvETzrabgfHTvZCHagJicq5HM+UEhjkWmnoOW6LCtg20RsPyPTr6sq6atJtWJtk/3OfQtptAmE7adfW2TdMIcL4Iqs3hrhPiQ71zNJ+/Oz7fNdHzxzEg1/wGQazdlasK7y1yrNUG8skMwiWcHgPmTLfpV+mtjCzQ9a9waMYFEIY6y28UZ5BH9YKSp19Uj8GAjDdPyjR8Y9lz9rlVPnPXOnolxvZzlwrhO/RboFHI6X3cwjRsXMMIPscw+meqwhQlM+Mu7lzU/P/xPRxTNO+ZKKG8JbE8BOCcVTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5uRsfKBSGpY+nz4eGWfP3cIEs7YrNDAk4k1p2KXlynYr5dzE15WBlNXfOfFF?=
 =?us-ascii?Q?oIaltRVWtvyEzwIy/+39THQKxXXHrBKxechu+Mcct4VQwq36i6o94F6uSoWg?=
 =?us-ascii?Q?KohtA3l11esxbkVVwgTnQ7JmjAkmURyvgoX8Yicc4oKVC6qqGy4R5oSKHKdo?=
 =?us-ascii?Q?JblxaznrYkIlcJj6edaQ20qgG06Av1/LnDUDIJOqbB4qReXgJMhiKCyyEPJf?=
 =?us-ascii?Q?FczhNUlaXIRnWiV3SsTYjM52iFsz+RYfiodn5Txw4qd05psGvx6Qm4FvstIZ?=
 =?us-ascii?Q?0bHAT+CDfo//zkHkdLygQFWGaw42ZitBUSSH74YBASbNYXWyhKNWfyeUEPR/?=
 =?us-ascii?Q?2AjJD1W+gRgU7WelwVKZ1VQGfpPWcu/67aQaUzwzaRv3m1DjIxyv6AsFIWZF?=
 =?us-ascii?Q?5z13qLGPk//8nlS1Le7fOuwo4zZmkhH3bUDaoMCCP5fCOXOniQa2P2cFBDco?=
 =?us-ascii?Q?YfPU1kmA0PGXQ0Z0P39/41HEseuOZW3oOr9sVq5XgSwUnFee2Qs8alG/MiEm?=
 =?us-ascii?Q?/VvoCzr0CuNTZIfJTAfDkvgHKkT6KihIpHcLrQT0KvtX+eibVwx9iyYPttmd?=
 =?us-ascii?Q?3dEx8BLWaSqMa2hz/dMrMm0mFwUhBUr1qXSdzHuenXg+8Y8yYnQNSTeZaZpH?=
 =?us-ascii?Q?Ib/159Lym9bHd3eUtCRrmxuXLYWWt1rtFe5NAKt19u/xDZqQihF4Wxfr7U0D?=
 =?us-ascii?Q?woW0xYbyPPsiCkt20NJhB6IP7V6mKgajX0a2Bso2cux5dS9wfKRL1ZNgo4rG?=
 =?us-ascii?Q?J3Ei4t42R0QK4/h9NZ0yeEGwyprCQF0no0XNZ00iBBAKzJHMtYf6f8f3nQIc?=
 =?us-ascii?Q?cncPo2kaisvdGwAA7iexr73w4q8wWlxWdGBvlMfbBhdClxqUmlkFEcYbuMgl?=
 =?us-ascii?Q?DUq4sdsnYja/pv0wxKZ+ufeAtxnVOsWTaha7hN5IKKY9Nch8e8kOxypGL8Us?=
 =?us-ascii?Q?ACbCnrAXC6xf1+CxbJBD4MuK/4TEfEWQwM3oxpy5Hxr3I5LGccjthe134m/2?=
 =?us-ascii?Q?OGO+KjGYlT3ATsZfwVox/hIJAHLCjOKLX8u64r/S4PKkNGTmVJ3atNAO74uO?=
 =?us-ascii?Q?Gk/80egkPDRbXeIhGT8DPHSsrUwmxQVF/jVeUkjV9M3N4lNOwbPO0mOQYzx2?=
 =?us-ascii?Q?E0KpR2Dgad7I5PiB6lkmuFhxyMEbUeUooHHIvWvnXzyCZxg7lnlqh9SFUe3a?=
 =?us-ascii?Q?yuMTI4eX3YSj3V09Gw4h+2hZt/FpyifIut//cIaK0Dmt5+jz6Qi8TrL9AYre?=
 =?us-ascii?Q?iUh/G49pMRrOBAMH20ka6/ybwkxTFmh8RRAtDIoPZNQRD+hOB0zOcARbuSZS?=
 =?us-ascii?Q?FLxiC5qm7IlFE8g0+YZ7xB8l2O+rUguAZjmXJfRlyLI4l/qXMUOETg1a4vd3?=
 =?us-ascii?Q?3I4cu17ljyQOR6k7wuu+ZdDg6F46CQqx3QrD52zVJ15c5Ua3MdgVqJSrhONA?=
 =?us-ascii?Q?W8htLgckURfO8MlKKgPhesAM+r7HnUFlfCP3wMsxeyoNcyZsJsgPr5OFYfoD?=
 =?us-ascii?Q?FmXd474EaLZGHfMUf+3avWXa54V/yu8x7HGXth0vaqsKODMC3W4p/HPtx0kk?=
 =?us-ascii?Q?UFfvV0GBgIb5LJU6oC+QTzo1BCX+5/Xr0MZ0OUZZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29160c66-f74a-441b-04b5-08dc39a4a017
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 04:04:00.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNN2O9jDCToAMRTtrx2r+j9j9F54oYP3V8Ck4p6rgvm/XNrHdIBWaNE01dhMrNcHgxoVeTRfp5jMbNOFHH37og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967

On Thu, Feb 29, 2024 at 10:44:42AM +0100, Krzysztof Kozlowski wrote:
> On 28/02/2024 20:14, Frank Li wrote:
> > fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> > have 1 interrupt.
> > 
> > Increase max interrupt number to 2 and add restriction for platforms except
> > i.MX8QXP and i.MX8QM.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,spdif.yaml         | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > index 82430f1d5e5a2..785f7997eea82 100644
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
> > @@ -100,6 +101,23 @@ required:
> >  
> >  additionalProperties: false
> >  
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,imx35-spdif
> > +            - fsl,vf610-spdif
> > +            - fsl,imx6sx-spdif
> > +            - fsl,imx8mq-spdif
> > +            - fsl,imx8mm-spdif
> > +            - fsl,imx8mn-spdif
> > +            - fsl,imx8ulp-spdif
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> 
> else:
> minItems: 2

I think needn't 'else' here. Top have set to maxItems is 2. 

Frank

> 
> 
> Best regards,
> Krzysztof
> 

