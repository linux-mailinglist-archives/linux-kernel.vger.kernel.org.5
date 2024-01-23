Return-Path: <linux-kernel+bounces-35979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39549839970
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4C6289FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08B823D4;
	Tue, 23 Jan 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sSHHFAQz"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984650A64;
	Tue, 23 Jan 2024 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037770; cv=fail; b=l8QGnW2bFNgWhbrge35kcExudZHm8M724eKg7ZggK0UN1OYc1ITKYy39nmHJe5oTi1VspfEA546IFyO/JfB7P4Fpf5nu0VmWeeyLbpEqhIOxtiquCYlToh0tQw0db0K458h8suZEM4pjabHefZPhnTBRyCBlPl5Q5dezqhNbfc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037770; c=relaxed/simple;
	bh=BMSlD+BF92+dQb30dZMDQ7qJkrZttSLppEnheIbh7WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JaJXmZXoG91j/iJmway3eMaFtckEZ1M8Zbkz60vwVu4yBWKueafJ+ZN6S5cHo+iLkCV0GoyvSXQNiSRy9JqM4bTsRk+y2D96tWwAQdHh8jFgUQM9tdiCl27kiewFxV9P9wl7eUSv197/QM9v2IzExOjxMjaoVKSq14azAPJ6BS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sSHHFAQz; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/QUp394nmJBGNdLomdFWbd/w60/0nk88wXTnxd3r/PhHc5aduOdptWPJ80/xHiu3svfjy0/rclzN1e05gBAr4owUlNk1DdOwghmvvMpds8941/J6OETbmIWyTaxx4OZkoayWhu5/yjcR92vYcTJNP4iSrmdLPhnK7kJ48eYsPack9dcXVa15tNDvFoAGAoebMy60TVnZLLo2z47XBF2A1HJpJLWq2CbDe7a8noteWdInxC07IgXM1SrQk5KN6+XYspURkSZKjA2mNlyJHuJVCLtVUOK1idULLGrI94bJp36ayw/7I0Alzh8NpfG1qOwooYmbfMyfkUiEMoa5as+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjp3OdRziRqu79muPL5tVoMc4uaI6Iiay4RRPl/OUlY=;
 b=SV86klCZQ+hCnhr/xE1ST4YSc+TvF7fwYBf3mmqBloquayywmrViastx7y0B36ITFf6HF7IAA4tYdpueQnwLvF62ACm0GOrtNI2qTTth5TRUffrZNmrorVrqETfKnR1e+yxDXDVKmFFtAMoCjTWxVJ9V57/yrVzxemMnNlnrsn7fcyIDoOBby6M/oreCrw5J1HE9KlmQQtoHqfvkbtEUCrmJMjWikmsJ9mAaqDkWv1mlmcpJmSB/CTyASsxkMGuxaOEOuEzprHlJac4BerWrOB6lPquVCckzAm94C1Hsauw2li5neFQDT3TkRqDgPJFcSe5VxEKwDIZikYx9w8dgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjp3OdRziRqu79muPL5tVoMc4uaI6Iiay4RRPl/OUlY=;
 b=sSHHFAQzF9bDbz8f3kQyvhAxD1FVbhXwQRnFCnt8ncVsd0Ee4UYNS24SrQ5PB93b8uGJuL9QKqpzyfVcq6r29TrLhaOyUJhoX48vdtuNU9v6CMoGuYbuRBTDvExqS+7NxQOXNf7dIrvXLWO1M9cShUgIUH1EYfX5d9Q/GHJRl1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8273.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 19:22:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 19:22:44 +0000
Date: Tue, 23 Jan 2024 14:22:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: thinh.nguyen@synopsys.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Message-ID: <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
 <20240123-poking-geography-33be2b5ae578@spud>
 <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
 <20240123-anew-lilly-0d645bdbfb30@spud>
 <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
 <20240123-nanometer-atlantic-6465b270043a@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-nanometer-atlantic-6465b270043a@spud>
X-ClientProxiedBy: BYAPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:a03:100::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: ee82efa0-f366-4e0a-1666-08dc1c48acfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eJjDk+FeaerWlDXSFRBeDeD+39fgk6k8oUHP864qbZZAUjnqomMq+LyYwbyLScEtsS+Z+MvIeNBgAvCaJY8FNptNWXmuvMVqrcDLuYUvwwsb2axl7HIsIvSCbYqyQ8QnvQY65QK14qlfmiRXGTh1D6hXVPjt+dygtwYBPqzROdUJTa+yTF3+aRExFSjyFXPdTlrIqhpYzro4pYlBD7gAaoa5PeTiAu8rlwpVwydrOqiif04uLK+BX+UdGbYTmIhSOQGapilFnKnughTJa+4nOgaY46SBsLIfAcviL91Sj2iq3LExcM1W9KJu5XppPqUO/gqBs9T1aVMQC1IYX/JmJvznNK/rcn0oHIHnd2+Xw9VAsLUUiTm5i4/71JECh3wTeyVyvUuJkk/dd45lqgMsJlSbGW3eyRPVRh3xqXt6OgsGRmziMa35HChqqxKaFVJOZPEdGZLoZGsYH9A/efwsO3zn5R3dusgE02tv8Trays74UmSpDTWXdnB6d5NBWZa3jSzYiuC2s1pbNvJpbTVE7PhaLXEwF8SXcZEKSpCD3PnsLBA0CRMGZh9ejKv08Hc7+g5pRt/Fl3BZxnJ+6X53zeEsrXHLD4AgNxVDdzphm3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38350700005)(6512007)(966005)(6486002)(83380400001)(8676002)(8936002)(5660300002)(6506007)(316002)(6916009)(9686003)(6666004)(66476007)(66556008)(26005)(478600001)(66946007)(52116002)(4326008)(41300700001)(7416002)(33716001)(86362001)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rx1VqdGYP5JpIs70jAkoPCSwuskrDyVG+y5dQEdMcOngscNqfXGBf39L2nqV?=
 =?us-ascii?Q?y5NnPEBaafIQMBHeIYhcLLGt2A1RNjnPOdjLxMWuwbrHLwtvEGoEKyrz2wJt?=
 =?us-ascii?Q?rQjs7Wtph7e40E7s9asjcF8feJiFqRsOUK2dKeuKCVewAfreLGxaYN9pYP8f?=
 =?us-ascii?Q?RHvqYiTnLr5oMdJ9QeWy6qyl9OAHPzfchsreS6cInF2LK45YzRG7r/99IhLI?=
 =?us-ascii?Q?+NCIaTb180ZeV3TfnQPBwCgKoIxZ9DsqmbKySn7gbt/TlXuBDddpuImYWCQF?=
 =?us-ascii?Q?ThPWudhnR3PkPAkazyEFPbJwVtax4W/j1N7GTZWBbraSumqHe888CqEkyxao?=
 =?us-ascii?Q?TE7aLTwn7fZbGKwPQX7DJSZDZoE74f5z2KhLzN6wGTl4YwtwmnJb9j5pZDRP?=
 =?us-ascii?Q?bh8GPaM1TwfR3/ZEtYmRZ4e2xXvtRlHf67Z1jFgg8aIbX87O2Oa1hqiwB68I?=
 =?us-ascii?Q?85Yj/ehOeyf6lf1XMZklDzaVjqOtdqDmnggnF7CDLuYcoC4hNCt8r8kLiDSx?=
 =?us-ascii?Q?cNASad9+azKyD5gIHe/Xx2CPRbXL4/mxJ+BBTey9sEUtL9L2L8S0Q7fJtNMw?=
 =?us-ascii?Q?s+QbP8PDIBNe54gsCxOpp7QRZyHvTOuDlevQnkiopQJoYwtBJLjSvmkSKjCu?=
 =?us-ascii?Q?KLpuXWuhPEkt1kDfVyYrO2Vk2V3kCcK3zlKfvEpPTsb6Z0rsL5V5LnEXRB3h?=
 =?us-ascii?Q?+lUW90uCxZl9mox21qnLQIclnD2+cTJ8vZQk1ge+MaB00Jj8hOWlidnikKyL?=
 =?us-ascii?Q?XMvXF17i9h9+qsN3vdCmuCe0la3crL6crUzAO/nDVJJsDIkX8W1dTT+KN7Md?=
 =?us-ascii?Q?D0y7XsSqf4yCXJJL7XxoI6sT6zs4kqUWCaMuqz2Lkt+Q7CsoCTb0899CA4gL?=
 =?us-ascii?Q?AfaIwY0ll/3CIw8kW3kTsEoyOxJNOG+pkO8LuGKjeV4qTTLsWrzvY8yZwzg4?=
 =?us-ascii?Q?NL4N17tS92Os1MtvQxnAgpsHfDFWb6Jp2iMSr8SpXsgnpPCmcdq7quXjMgHM?=
 =?us-ascii?Q?BzUYZ4rdktn3rjAVz0eUFJG0WQPB602Ld9FFU7j9KjGV8AayJ0Y5iQaZAVru?=
 =?us-ascii?Q?nd9mDjaqvZGBUGE60/IgfSXvX8rTApLQ55jCmPeMwVWUp5sFm9rQV1t+rj/i?=
 =?us-ascii?Q?yN2cNofuSLtUOMlDl9iVwJnDDMDWugd6vicJBx2L69VGFQE6G7OcnRHN8FHr?=
 =?us-ascii?Q?4bDnktTD7PaLmrmPj+5+t6rN//RFepZzqzbDaCzdhsz17Byzm2MTA3oU6+o4?=
 =?us-ascii?Q?G5Xf5RbrHX34aocSCoKPn/wLbuNCGbIgsACGXXy6uaTGqjySiId77BtcH5ZA?=
 =?us-ascii?Q?LmAtyMv77IhBg62zyzcvitM0v7hpNtexNNHGIZunBRnMBv5f3NDrld7uABvV?=
 =?us-ascii?Q?scjgKFVY2rpZvl4/29A05CmkGGRawCG74Bq7AY1OjezB51X6SXwFELu62KyF?=
 =?us-ascii?Q?1gfovHsiM8o2w9xHk1qG6H8bPaeg2JsHpOU2w+07UdQozo546ne1p3QPUUBg?=
 =?us-ascii?Q?bXK1bxgzRxDAf2np8DK4Renzx8YcdPKGuDmQV8QtBmcx7XMFUb+mM6sSqWVj?=
 =?us-ascii?Q?iQptVy97zak7/7GYP0z1j86RQhSiSs/YDUcBzf4C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee82efa0-f366-4e0a-1666-08dc1c48acfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 19:22:44.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvH3RGgikXSgTUp4pFfxCTN49wpkuaXVIu5Y/tC0JQR5UCVdfWawzxe1647xQulcPw7NJeX8BPSE5pVqqmiRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273

On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
> > On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
> > > On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> > > > On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> > > > > On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> > > > > > Add device tree binding allow platform overwrite default value of *REQIN in
> > > > > > GSBUSCFG0.
> > > > > 
> > > > > Why might a platform actually want to do this? Why does this need to be
> > > > > set at the board level and being aware of which SoC is in use is not
> > > > > sufficient for the driver to set the correct values?
> > > > 
> > > > In snps,dwc3.yaml, there are already similary proptery, such as
> > > > snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
> > > > driver keep consistent. And not all platform try enable hardware
> > > > dma_cohenrence. It is configable for difference platform.
> > > 
> > > When you say "platform", what do you mean? I understand that term to
> > > mean a combination of board, soc and firmware.
> > 
> > In my company's environment, "platform" is "board". I will use "board" in
> > future. Is it big difference here?
> 
> Nah, that's close enough that it makes no difference here.
> 
> I'd still like an explanation for why a platform would need to actually
> set these properties though, and why information about coherency cannot
> be determined from whether or not the boss the usb controller is on is
> communicated to be dma coherent via the existing devicetree properties
> for that purpose.

Actually, I am not very clear about reason. I guest maybe treat off power
consumption and performance.

What's your judgement about proptery, which should be in dts. Such as
reg, clk, reset, dma and irq, which is tighted with SOC. It is the fixed
value for every SOC. The board dts never change these.

But for this "snps,*-reqinfo", you don't like put into dts? 

There are similar case at 2019,
https://lore.kernel.org/linux-devicetree/CADRPPNRHOda+ZfB25CeqReXBb-MrB1oAeTHF-3muXVExn+G+Dg@mail.gmail.com/
look like, this thread prefer quirk proptery method.

Frank

> 
> Thanks,
> Conor.
> 
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/usb/snps,dwc3.yaml    | 36 +++++++++++++++++++
> > > > > >  1 file changed, 36 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > > index 8f5d250070c78..43e7fea3f6798 100644
> > > > > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > > @@ -439,6 +439,42 @@ properties:
> > > > > >      items:
> > > > > >        enum: [1, 4, 8, 16, 32, 64, 128, 256]
> > > > > >  
> > > > > > +  snps,des-wr-reqinfo:
> > > > > > +    description: Value for DESEWRREQIN of GSBUSCFG0 register.
> > > > > > +      ----------------------------------------------------------------
> > > > > > +       MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> > > > > > +      ----------------------------------------------------------------
> > > > > > +       AHB      |Cacheable     |Bufferable   |Privilegge |Data
> > > > > > +       AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> > > > > > +       AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> > > > > > +       AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> > > > > > +       Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> > > > > > +      ----------------------------------------------------------------
> > > > > > +      The AHB, AXI3, AXI4, and PCIe busses use different names for certain
> > > > > > +      signals, which have the same meaning:
> > > > > > +      Bufferable = Posted
> > > > > > +      Cacheable = Modifiable = Snoop (negation of No Snoop)
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > > > +    maxItem: 15
> > > > > > +
> > > > > > +  snps,des-rd-reqinfo:
> > > > > > +    description: Value for DESRDREQIN of GSBUSCFG0 register. ref
> > > > > > +      snps,des-wr-reqinfo
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > > > +    maxItem: 15
> > > > > > +
> > > > > > +  snps,dat-wr-reqinfo:
> > > > > > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > > > > > +      snps,des-wr-reqinfo
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > > > +    maxItem: 15
> > > > > > +
> > > > > > +  snps,des-wr-reqinfo:
> > > > > > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > > > > > +      snps,des-wr-reqinfo
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > > > +    maxItem: 15
> > > > > > +
> > > > > >    num-hc-interrupters:
> > > > > >      maximum: 8
> > > > > >      default: 1
> > > > > > -- 
> > > > > > 2.34.1
> > > > > > 
> > > > 
> > > > 
> > 
> > 



