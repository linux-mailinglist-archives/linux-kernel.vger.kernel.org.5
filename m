Return-Path: <linux-kernel+bounces-94558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EF5874156
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3901C222EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50580142620;
	Wed,  6 Mar 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rJv1soac"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C0513F426;
	Wed,  6 Mar 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756716; cv=fail; b=pC9YkWIU1EikahcfO/C5jSBGnAWFGfXa3QQ1sGZ1BBe1pdrd70UAaIPsDLIGD7xcXlhVJoCIP/tC+6PnJdu8nGNhsum0lJ+keU23/J8cO0u4ToCTYYlE9TejEM3uJ+mlO8QJfhW5jD6Qnp2ugl1CB0BnmSRsGLgqQXiSV/KDss8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756716; c=relaxed/simple;
	bh=wMFEeAATRgV5LN07Uwmh4PxsWNM2sMBI2nwv5aJrN+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XE9YOKPMvk/d2jjRSskysUaUc4zzoCfKrTku0wac9QgeU+IwhiRVcfuQeLuUSD25vnzEay1LbEMZZ4N6r24geqC5aZm+2X7XIZLPYudLl66Ub8PMql9DW46vcXof9lHos45DVfXBudW4PzY42e94MVgh/GWSdja3FHYqyXedh3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rJv1soac; arc=fail smtp.client-ip=40.107.6.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqgFWaeo508q7OfFL+XZxoDTxUSDJCIdffB3cFkd5mKEYCN0p4Zyv9K5E0jIc29HrgzXkX8VhB1KW3r+R5SINhdWcM3l/OiNjIM5LIHGCSGkUspsK1BgsGBiEnNurCApAGS1uGO0bqFoX7QmqF4Digx7L++uc/pjK4koN9yyXVcq7THMC/f+0ZcOAxRXuiDVmJV630J4u7PWiAeB9d5grON8kaUROKU6sdbwxjavS9J7f0fKxFP0bLeTPEzzlKkeKU4lmMsmw413A+HHJD38PEc3NYKV8/V7VPfcP5BU81Mamhbql5MIRLpEYRzUJJnt5oia+YOsAPzwv/okt3gyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXeDnk5/SxMzz/6VirjrY7OTLuMUmd1LghYeWNq4U18=;
 b=U5mebWnESEXOUDkOAyygpbKvFGc73McRTFBaAbW6HBIzTpwndE+qEfH3iBbpvOZrsaKnt9KVzWlfjgYUQ3cfN9ICHy1MY6gCSeJGpxa7k/SzMOdybBFH4tCB/z2H4lfkvPNp7txpTxr2hF3oMNZO6d52q/Wk7b7mJ6wG7pTtJtOMMa+esugHWT8PCAQVS26y/UOYfbwcLOiUKWFYWHMMKTP1VEx4SkfSn3NFTehe91nf6Q4JXhVEAAwhXcoLfuPzWF9Ny6EGCq+2apjr24kuA+X0m9IRx1L5joteQL0a48DsPSCE3Nj5B0bTCNNIDq6z5SqqGMNf/hrs5meN5SCsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXeDnk5/SxMzz/6VirjrY7OTLuMUmd1LghYeWNq4U18=;
 b=rJv1soaclSxVlz2HYRBReDZ5d8W+vDa93le3bH4XNkP22ctJrcTQ+CsY33AIRUWTMrtSikDi9ivrWbAOEfuwF8iFOrX31qpUSUijr/IXGvCjTu2fVt99YMn6jUIl9IQSOXvojhfx9BfJmXzdI6GIGpNJAb9BIEFv26Il2M51Otc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7084.eurprd04.prod.outlook.com (2603:10a6:10:12e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 20:25:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 20:25:11 +0000
Date: Wed, 6 Mar 2024 15:25:02 -0500
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
Subject: Re: [PATCH v4 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <ZejRHkdBsfUAH0sQ@lizhi-Precision-Tower-5810>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>
 <20240306-pebble-grope-88fdaa95a87c@spud>
 <ZejDQddMp17RD6Yk@lizhi-Precision-Tower-5810>
 <20240306-petticoat-womb-a61cad7d788d@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-petticoat-womb-a61cad7d788d@spud>
X-ClientProxiedBy: SJ0PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:a03:338::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 2662dc43-9dc4-4540-2495-08dc3e1b8604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l4FxC7CgmXidDfheLnWGvTT7O35irYzilFRixRoeIN7nIPndd472AHw5hMa1Me2Asb/Ysz1RhX/pz9HmR6dZK5yjKqtzk7QhWnR1CMEklLKuknPvCCacyVEdulx8g/uEVMUnm0+gk1cwB41kAoAnBfOl+DSJ7IPJymySTsbum850wxpg14gYebDX45FGny9ed5azsf2Yeaa7GhJTkc2vEMPhu0zNLujCY4PLf4RhJqXysogEnNvP/eSp+TL4gjsLwzjP2gv7v7XWUs3m1njob/u2io3VPVTUAyN4OI1fGnsoCnisQjt2DXbBZPbK1W9YH1j2qkIx6ALT09ZUfDYb7dxmlqOM31bcTk5MGgZHFFt1l65dWHS3SzCEN07Lhu9CaIUxSmX5BZ+mFOiW0me0jX692CrHrCvFu8tTrge27qOK125FIRh+OA0wQxzvFNza1XNocLVetN+byd6BBnKXNt7YpyumYmzPo+zNOIsqlHoGVWXCHP3lO3T//qxvPTFIZfKTxss8HEQGCTCQ3dpP07Mu6/MfPgLfQ+1beufAOOaEAmVorI+i4rsp4JaH3+Mn4sboP5V6BCNsXWJDt0zGGZn9J3qkOxMGVV0Kj3P8UJetr9fHCNdMDGW5CMaj3SRt6SNF3titqpM9fu4vUgrtocRBOR48ARDO7CMUE+ZUCsw9Y01U+BgHw+/UvPYCQ/fFkwrllBJOWjL6hrzrRRhpfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TuwwfhfWUL427kSgFt8TB4lPIn25lwg7gPaqXcjPkdzJ7H6pBkipLIkMulZ4?=
 =?us-ascii?Q?v0XO2HFFupHUS/QIcx+ASEswf3AkUGNnhbjPx/R7ohjAU0ILnCKx84GrVjh4?=
 =?us-ascii?Q?/HgBiWaXdrlEKI16793pBwesEfU8q6hk8+VNn88z1s2jTBG6uTDwBs9R2xU/?=
 =?us-ascii?Q?DsQyl7o766HL/Kg1faBw5egqQhKh/5cRQ1ujpca854cV6kPY58I6caovog/g?=
 =?us-ascii?Q?cQjsV0QqmZEaJpcKx97yGuL+4H60gaSGhxxdwj76OSQzttKg/++aF+8mTgYe?=
 =?us-ascii?Q?mV4JG/QlLbv5cj6woD8BhgF7xruzcZRxyT+ugpsSkgw/V74Vi9gYLGyC5lmC?=
 =?us-ascii?Q?gWy06Ut067HWnX8V6bg5Hg3YRJ0KzQwV77eU+3MhBeiDjNvu91JqoLf/jPPE?=
 =?us-ascii?Q?7PVPF7DlY5nh+k6dWbwBKYa3aX/ISHg0zPKylaYsRxw3JJzkqQA+I9fBQmHS?=
 =?us-ascii?Q?DJcEqe4+6NrfQEcrlg3+xELj+2JdLBDbW7qOgxv4Qwb5okKhVOWGHTI2rnhL?=
 =?us-ascii?Q?MAtWG5Luw11CEm+mSnFIzI4vDjNtUG0/0MlS2wZ0dFGUXWbCk4BRODpbmpq8?=
 =?us-ascii?Q?7Y4nfWlbkirTaHCmH6wSvPaYsR/45JfIDGxnumV/6mkLHd62YFqloYn5Mgio?=
 =?us-ascii?Q?vquzrFDWH3RKS1vOv7NwtQHCkTJkrLqwUIlaDl7UH7iN2UNhCd81twdxDvnd?=
 =?us-ascii?Q?ksWc8D+L/gqR27qGkED+alHqSia58BmfEmUQ4LdfkuCV7tWlY+fvkyLUlFJV?=
 =?us-ascii?Q?q2Cvmfw0gd1fSYOfgdzWsZMW+gKbEIZ4Udcr9oJnha6Ss07pjUrShqlwG+oU?=
 =?us-ascii?Q?4tshrrrDaxYVsEBT9K/2ErTZU58cAK4oCBA1dSoP4rZSTvA79VZTwwskIJKe?=
 =?us-ascii?Q?v/lB9bIhJdmqVnWvHj463k+0kNunMxf0+P/+wHwBTXYzyigWSmXrP18sneX+?=
 =?us-ascii?Q?sMV9ptJJIAaqVTUT4wX79lVOK5sJBeDzAEhXqWHCHi0keI7Za+4lJUw52aYP?=
 =?us-ascii?Q?WYdrJVW29MbA4L0pqx4xcJaty3N4LY9HgAaB4YUhhplDkTO0tSWt/C1gkMu9?=
 =?us-ascii?Q?KJoQLTfsL5aMIA9RNU7Yx0gfSfjpI/T3PfC1drQk5oKCZg+KSzo6tcCTxt+O?=
 =?us-ascii?Q?kisEkr/VdDNkf0TZnTqBx66W3rDOznJaUTZQS8vkoLr+lSW0sfxZABYkwHfA?=
 =?us-ascii?Q?poHvAYBqhBGN7Gqyl77aoral4PCQTNSNo5Jpt1ftiypGxxpvDW+viS65I2gy?=
 =?us-ascii?Q?9ugmijj2vAnZOdL2oDMwLG7cupUk8oNVtSOIovqXgoG5hvsNrfbHaY/pd6Ey?=
 =?us-ascii?Q?imPqz1BrqPcvSCyYVy+nV1fNdvB3zIoNEUYm0Z144QphfoFrW/VnEmEWREtx?=
 =?us-ascii?Q?OIhO63Eu4tuA5fsF37y5Q50dAy44+VXTbhJiRHEovWtLbdM4lQPwcRgpNMgu?=
 =?us-ascii?Q?3O9xLcMeVSmow+fawPoZpEB5vviXc0zWcLN/LZHK3n9gu3sYeY3R4M2PXcm1?=
 =?us-ascii?Q?JBr5LJi/MNGGS1eOulf6qjSGKqBnLZUz4ZszWKVXqqfdByq7iNVQ+Y+5IhSW?=
 =?us-ascii?Q?z+atg57d9VOC/xSu60E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2662dc43-9dc4-4540-2495-08dc3e1b8604
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 20:25:11.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: foX/kCXdMrqlqm2VNfJ1dtiVv1OgN7TTMVIh1NIoplyzRpvDPrm0gh5kVq5T7qOUzr7c2S4uBLnIWnSZLUACkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084

On Wed, Mar 06, 2024 at 07:45:34PM +0000, Conor Dooley wrote:
> On Wed, Mar 06, 2024 at 02:25:53PM -0500, Frank Li wrote:
> > On Wed, Mar 06, 2024 at 06:45:13PM +0000, Conor Dooley wrote:
> > > On Tue, Mar 05, 2024 at 12:33:04PM -0500, Frank Li wrote:
> > > > Some sai only connect one direction dma (rx/tx) in SOC. For example:
> > > > imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> > > > for dma-names.
> > > > 
> > > > Remove description under dmas because no user use index to get dma channel.
> > > > All user use 'dma-names' to get correct dma channel. dma-names already in
> > > > 'required' list.
> > > 
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 13 ++++++-------
> > > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > > index 2456d958adeef..6f551c68d33db 100644
> > > > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > > @@ -81,15 +81,14 @@ properties:
> > > >  
> > > >    dmas:
> > > >      minItems: 1
> > > > -    items:
> > > > -      - description: DMA controller phandle and request line for RX
> > > > -      - description: DMA controller phandle and request line for TX
> > > > +    maxItems: 2
> > > >  
> > > >    dma-names:
> > > > -    minItems: 1
> > > > -    items:
> > > > -      - const: rx
> > > > -      - const: tx
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - const: rx
> > > > +          - const: tx
> > > > +      - enum: [ rx, tx ]
> > > 
> > > I'm not entirely sure if this was Rob's suggestion, I got the impression
> > > he was suggesting that in the two items case we'd not care about the
> > > order. But while I think this is different to that suggestion it's also
> > > not wrong.
> > 
> > I log this at cover-letter. b4 can't support write change log at every
> > patch yet. Rob's suggest was not work. dt-binding check complain too long
> > if there are two dma-names = "rx", "tx". 
> 
> Yeh, that is what happens if you just have
> dma-names:
>   enum: [ rx, tx ]
> since that only allows one entry. Take a look at st,stm32-uart.yaml
> instead, for example.

Yes, it works. Thank you very much. I will update it at next version.

Frank


