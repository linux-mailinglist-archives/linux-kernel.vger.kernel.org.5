Return-Path: <linux-kernel+bounces-87355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD4486D337
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B921528611F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A913C9F2;
	Thu, 29 Feb 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZKPfge5i"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF948627D;
	Thu, 29 Feb 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235094; cv=fail; b=hdPP2TD23GTbd4yDniajprAvIIfN7HfgrVLgzZo4GHEiP2YMjBjQsTx+aR6Klfy42bOVgSs7YoQMScL9/2rPLqW1bE7Q6C38IUP1LlXV842KLJMnlA317WQ14hTsBsx8wNgZOkJvqDoWdVO6qgr1UNuUN1UxKU/2qkiYQ5XI52o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235094; c=relaxed/simple;
	bh=unft92S/teXYeKyuPx/c1HZAg0Mo5Odg0twQGOVyqYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RVdEDm5+NlRBOMVrajxpNi8ZViwjl1tHK8WfNuXV+yHyp6Q4MyfHQANS7O716R0AOnMLepP1atMopQ2sXSZCJFzThBfgOP78R9RKdvPMeLybQZz54QedEm8RW0MHByD6UYgUkJj2/kSoWvcd39AQas7KB7AHUn9+Un2l6NWwwdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZKPfge5i; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYrRPZjPxPvOW/gd0GMJaKefaPS99vzd6y4xYBYYPUbhyupnvJiPi/xJQB4Khj/FoOSI0fhMJvQ33pixFHEinA3XP8nrG3Ob6hX2V/S6oob3sk0VU5YqSAg9IuKziq7pA8a6Q0WjyF9CFEwFUD3FbjVfzbkv0MupwfKI4kGFT1rsp/0YATBbpVkuvd2wX6F3rJikn2/mzDtu2fw94N11hEa6xP6sg52vv4/2oyOrLFXWtvwyMnTX3e2dw7wiArHEU3SVoBa9BzduzS2Wikg1UtcbZm4peCj/sCew0todOmYDvHL8KsfEkMvSuz4JAcFNgUDzpRV2X4P0IEiMoytm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gipB4G7Z7MYMfdMPjjMt6+uhV69KF+YVKh/jDMOrSg=;
 b=OUXUfbjxYvSriM3bcarla2BUgNE++rn7YwEI94QfvipeFDihq2GGDoHXmr1RlDWlncocnQct8UKpKIkg/SyRlh0tXW+APxv7UPO5N7NXj5ueZye5RatNlbUqeAHrueT3bmcjaLRrblLL9hPiGTALyoFGIDnCAPl7xo1prjndMYURrnJYulh/DZxbtt2Xmg6ePjAZvdDsTEqzL+f/MA38MGqHMDtMwqiUW5rb8CfQEd7Lyd8C14FIdjCzfoBHZAAcaR4Tacx32co7FA/B0MAC1r5gebB+x0uqM89iWjo7A002VlJo8DOWbLBWW57bJW7PjV0bnEiXxMvipp1c0KDKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gipB4G7Z7MYMfdMPjjMt6+uhV69KF+YVKh/jDMOrSg=;
 b=ZKPfge5iBuyu6P1UMhAe9I0kOE2Bb431CvC3mbQbEpf5NvN9Oh7p9nspoFGk4/dDsKmcyQk/DC/WvUssntWH0zpNVOTBlY/6ijVLoVKSpb0ls7EZzSJTEjRAB+WMJImsOQFhuf7/WnfPm4/QB7fT+LB+1y9MsUEpe5gpQXGTYvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10194.eurprd04.prod.outlook.com (2603:10a6:150:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 19:31:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 19:31:29 +0000
Date: Thu, 29 Feb 2024 14:31:20 -0500
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
Message-ID: <ZeDbiLR8vLtVfgGX@lizhi-Precision-Tower-5810>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-husband-penalty-8c1ab0f57f55@spud>
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10194:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c7c9c7-a044-49ec-67cc-08dc395d06de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iS3L7BDOzRKEtwXvHg2TzKWPV4vj13cW56+3YBUcbEJIEAYVRdqbWqTtMEUJsr0LozOEsimxVkzeSLelXRQxxThSYz6oMmlw7HcrPuIn5Z6h8GdCw3jh1m90bXon4k7EsxQXC5uOtMWilvu88mEFpbySOueXY3W2U0/wb78xSbAlbW8sgZzXYpe/PS00w7Jp70Qki69E7t1D/4gXVgD5jdvnV/m8GsYstDXcf+p5KU827Met+/80CUfkauJ3kCW56o1hnT9tQnIgDUFfK4qLjsr0t12ZfUY7Lb2geVa9zJcKZOb0ZlSLEBROc/Egro1uhtKn05pW+xPIBvCaNc+5QINHVFFgvVEzf0aWxTT72XM/CGrPC9o9FV56ix9CojVNVg6/eBFQo0OaojmRcwa1Zvh2ZoWu6t6eWxB9tlj7ngST9DeSTIC2ms11jR8I1UVm5AAmsxPHZYUkA8Ii5y1exPyOJrCCkSE5CIPcoQ2Bf4OhwZqpIN0ZAJIuBv16CWGJA3XfMqoYPaIFX41iSWHeU7aWLULSFUDhFK/XMl8n7+KEv040KzqbnjyX/+BgpTD3Xhz1LfjVL9RGjSPXLABtcSc1olWOdU/k9kUcyzAALbcpkNscEcMjTGhHGNGzdf1wL1h5RDvJauk3J2ROIC4KBhndupnRXvGC33CKei/xj0t+LtAwsY7EFVwiSJlAprEE5JW+GHKx+Td0caeZOZ0J1es/yRZZRQcfTlxiEq94BbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yO4X9BN4xtCWc/gngle1kskE5Wq0R7CfCmwpiAtm0emMeSCA1BB/eE7BLubl?=
 =?us-ascii?Q?XlcNDv7hWWb8nwVXTzs2GQ+Ll90pzQUnAusInWLdUaQuewmwaoBJkkgGa9dG?=
 =?us-ascii?Q?E9pbk1/sm6w5ZSEGkEUo0RukxpVR3OcFFQE/t8eM9cClBuZevxTqKB4IP10t?=
 =?us-ascii?Q?16mHHblMAqNYqz2UJYquFXc+DUKI0JBT3+XpcRt/XiDj88/TEopyhKrHtCx+?=
 =?us-ascii?Q?34ZF833oR2x3kDyuc6pOuWEblBPTuIojS1EREwGlKYrGZXlFby+vG/14xZYg?=
 =?us-ascii?Q?CYAGlri9iSbhViKNe0KB2rmB5CCTlncbJGCEMwjge77v1q159Ql+bQE3TScx?=
 =?us-ascii?Q?QPZWH8ymIv7o3GskUhVICNVrCrnioeDY3TzX5aCelIztmZ9O7NEdpofztL67?=
 =?us-ascii?Q?JzVcXB5/5IKgNykILu5HGDRpa8ABlD5Bx/URjZOP8BbaLYzAvhgBLECglD9Q?=
 =?us-ascii?Q?QGCQuYLY/uqi2Vdb3BKytFe9C7he56m/6XF9Hht5/u8ImdvfpxmSdc2K/Ja+?=
 =?us-ascii?Q?tiH8pVYBYOmJgpZGSfi469oVrUz9ODKYXL2CJ052KWDk3Lijd8uk1U2ts/+y?=
 =?us-ascii?Q?YkoaTDt4iCak0SY6InWMxdhjz1+0LuUw2uTGELri0rRiHrNgDnOjUH5n3bSB?=
 =?us-ascii?Q?SsW13JHvqvwNrMJC7Nm7TWbmXlcJrZ9q6EZZpDTthQcwpK1uvb+d7mzTKbmj?=
 =?us-ascii?Q?bG748EKFFWzq+gBaNIOyw2GtVxcUwMzx3yUABfL32A4bgOnxhw3Al2kBbewL?=
 =?us-ascii?Q?RjLS4VYumIUSE+cMI1KrgOdmVgPdyYTtD7SWL5jZ/sB8GemTSR19mHU84vjw?=
 =?us-ascii?Q?T8x6smJ9Zfwxs4RUQ1IdxJ+7rFRcXb7NwV6JSqcwMVGAeHGAzsu8eXGsOyd8?=
 =?us-ascii?Q?u/7WJbLBFEnSevnKVxp7Y/Moib8kG4aLvvEXsqN88mIVdpuJXPc7kobvGg/M?=
 =?us-ascii?Q?gjEREzZHvaOeu1IeBqQeCBtzZO8Npsq9xv4c3sEI6bl/XzeYcrGhI2jDeVMC?=
 =?us-ascii?Q?jTYo3rZHZyiYpBV5T35x3gNVgxO5JPlqW2qYXviwCfvHOXQp5iiDkOHVeUoj?=
 =?us-ascii?Q?+2MD5VnKn8VHQ0jyTSGohx0M8TgVCSnwOqqSCBIkfqm+/98qEytz9+o7gCOy?=
 =?us-ascii?Q?A09rWd+C1b9ISm+gbxmsYOyOT0lFbmanxlWQAiYkk1PdtUOTRvBk4lbqwC0Z?=
 =?us-ascii?Q?keNGkoIvBWJvyLGNuIDKyegHzkSTFSSsaOhnn6bKL0FdVlJDo1EI8ZSvOMDz?=
 =?us-ascii?Q?qz6lq6QbLQ8LfcfFcu0ceC+DqNt57i5SoSdHNAXX8bIXwPcfhw4/DXaGJa7i?=
 =?us-ascii?Q?HFfbommbQfZ292ggjxl82n/Ax9TMM/Nd/EinGrX9jrtBBlvH5N1bu2oN0qws?=
 =?us-ascii?Q?A0MwdsNqxPrI+XsvnGaUmXjrq2TdtRr8+TGHTbB1mYvN5ghpkIh6gDtckXBG?=
 =?us-ascii?Q?XZd+BqM29MuU+F95S8utey2GwzLoHLwFta1n6hbBMMRkbihk06NBXyS60+xh?=
 =?us-ascii?Q?JKNdrVP1Nh5rn1CHT+84XTSW5KogwYYqbQEWje9sfpZH6pfSxjT7Iq+03wKz?=
 =?us-ascii?Q?qLxSCJ5sqqkjKD7VKM6d6rrRUyIvZsICEgT394HD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c7c9c7-a044-49ec-67cc-08dc395d06de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:31:29.0641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /w43dZGDtjx3van6ys9xXqj4Tn7xdnVIzrQjfR1YYap7ZoZ7ZYMXX7dtlSPT7lwu8zByUwolhiX0zrfiPZyy4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10194

On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > Some sai only connect one direction. So allow only "rx" or "tx" for
> > dma-names.
> 
> Which sai? Can you restrict this per compatible please, so that someone
> cannot add 2 dmas for ones where only the tx is supported.

SAI is exact the same. Only external connect one dma channel.

> 
> |  dmas:
> |    minItems: 1
> |    items:
> |      - description: DMA controller phandle and request line for RX
> |      - description: DMA controller phandle and request line for TX
> 
> The binding already allows only one, but it documents that the first dma
> is always the RX dma, and that doesn't change with this patch..

Does below logic work? 

anyOf
  - enum
      - description: ---rx
      - description: ---tx

> 
> Cheers,
> Conor.
> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > index 2456d958adeef..0302752d58a2b 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > @@ -86,10 +86,14 @@ properties:
> >        - description: DMA controller phandle and request line for TX
> >  
> >    dma-names:
> > -    minItems: 1
> > -    items:
> > -      - const: rx
> > -      - const: tx
> > +    oneOf:
> > +      - items:
> > +          - const: rx
> > +          - const: tx
> > +      - items:
> > +          - enum:
> > +              - rx
> > +              - tx
> >  
> >    interrupts:
> >      items:
> > 
> > -- 
> > 2.34.1
> > 



