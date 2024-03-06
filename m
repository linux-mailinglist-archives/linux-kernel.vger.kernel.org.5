Return-Path: <linux-kernel+bounces-94592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC118741D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3367F1F223E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29D1B275;
	Wed,  6 Mar 2024 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V3lv0eo9"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7418EB8;
	Wed,  6 Mar 2024 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759964; cv=fail; b=kAipt27ZGaFO6eY7tUMWPiJccUW8yHvdcTOYlBnd1BMQv5Ud4APRYLGKUJtV8/iVL9rg6IqHSzXGLW1sr0H2P5n2JfZJdMCLpf6Y4e7O4NiYCf/HKzkiw92anMmj7kh/ZpDAUIJQqo2Jwx5kyfHcUqkCKX48THmTCFREMJPSedw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759964; c=relaxed/simple;
	bh=CACSeuYacIg66GedaknJNyISIN1RqvdICudp4u+r5ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l7YLid1YhYO1M/NJC2s6mWjNqrVVc8o17pEfi2Oi64ab6qla5UMI+aJMlLJ746BY/iJI3tr73h4Hv0dHrtn/nCZU2fWWGo/UjwUrAV9aY4nZ8k1y3fy530rkGue5TQ7qXAPM+BQumWPczg9jkEqyWifNK/92q7T/7Lk72cMWiVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=V3lv0eo9; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/xClcBu2sOFmUqovp9lb5f+GYbnbKBmA1VE4/2b16AwX0ZjPvTSPuOIeiCdH+4J2ARGrtJ7X4Wk02i9IFBvirU21Io+eF20ITWP52rKsvcPx+cxJ4SRUpZdXTswrObd8cU5LVeDoep1BdQtuzmypkQK/USkm/9RTZMLm4O3Gz3GsoLu0Ca1rgmWe9Z1l/cUxvyGNbNb6XTU7TFsEkUlxg6twqSi5rRCGM4cU3LQo7phiW739cmiHxsmJyPqVlqCSecBXnVMibGDQgmHCx2TZJDSnHczNbxryQfLQ25ChKf81TW49JzckQhC84pU+J/V6f9QQpGbQZmAPukXW+yclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2h3J3wL87ALsq8w2HZ0qrtvVc8Tn9zv+G8YnWa9XV4=;
 b=IpxC7yEngOkiOkS/5aqOxgaEtXWOUq/oCeEeaHjykuffo7P/pn9cQqNzh//I9Xsn5l8KNPKvCy8aBuzTVqePOy/6Wm8Ljm8vClzDQX97r/9eRmi+a7yydxU/vY2yDPokBmcEUB6CSLTh/aewjZ6rb6+ey4TAqCWDiY+HkZ34jDpZbrgF4WAyDpdmlybWzstFNXfjl7gUyT5vgEjhU10ztbkO1qpb8mjx1/+sWEe/FdzsXIUYw2480rQPZbrVSU6bmGNnbfaN7xW4KfpfB/PPFnEdSY3Kj7wOwpNmpdOWsZ9Rduf1ERIBa0HeaGtvuJcSVbE7wBidJB2eMUbcbTQtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2h3J3wL87ALsq8w2HZ0qrtvVc8Tn9zv+G8YnWa9XV4=;
 b=V3lv0eo9sTyjQLb9Kt08yk+QHA9m4l7hJu290GiamvYCNLujU2IQUTEE4YC9FUW9A6a3opfuJaqGKYYWt/zWDcA/x571Fc/gaz6ZUmlu8uZ6REWDAoteyR0t/0afSxEDMfuYKIyHKfIGzK+0TbjUd1Loc+UmyktsHPvFC/+OZlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 21:19:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 21:19:19 +0000
Date: Wed, 6 Mar 2024 16:19:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
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
Message-ID: <Zejdz0BKwSlsio9S@lizhi-Precision-Tower-5810>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>
 <20240306-pebble-grope-88fdaa95a87c@spud>
 <ZejDQddMp17RD6Yk@lizhi-Precision-Tower-5810>
 <20240306205524.GB587561-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306205524.GB587561-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe46367-cedc-44a0-f028-08dc3e2315f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oiDYbt+fjLk5OlXNvKnU1QsAMdJxILCkKKhgDBPFz2yRWAOCtmNmfsH+N6m/7VE5Uf4Xw9nBZhnho/n0dERiJgJgsFkJIQRo/9VSOvR3RjYhCT6fP8DEUkEUk7GVPNWyt54UKinAqKcpZ4P9IGYHFcYTcHtId7ZC466LFw5vpUFJMW7ZIlv3fKS/qECyolvX2zT0R+A8vm5SUNJTK6s+QB9Idn/3jOXzog9iqoPCXmmhgjceClXoFNmyjCWYsl4smhDRoIZ63JvTJOynooLsXPPuNgl0mHcgcXz0ZAm5vZp13WZRcPmhDBQykZr/JXNL3Pk3d+SxGImMNreLXN98NW0zIYzAiidhT+bUirFlLkiYXe6Y51UhqCQdLjRQXCEm84O4b8vrbqcri9pvmZaceK/lueIUpJPH47ESuIseb63Ab/pLeKr7kDkxu0tcg331YfMH++GZ0AnHdjCi8aBYmIWzhxZutY2jrWEAcK6iNQFpk6LlNd9hy3ToTXPgpBt6Yg/mifvT3zLebhVlj9fU73Xlf44cdVOU1/Iy902LDX04g0HZNdDFIKsbdMK/ATxPb3zk2QF/LpoJDnEUtAKJZXJq/wi9IcxqHz0iBQZcP9dAlWy5Fh8KwuNbkbQ3lwdJ/1H6bS+XTEhySyIiWGuHkEOfcvPFXpO0yiaNOIUxSuFt+ahkCNUHmLJ/r72VHLrPJeKssj5etbfZNOgl8z1AQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zC+rAsZ9hrvEv9wLvb9SPvPNDQi3i//bjOf0nOeghCIa8QxHzY+vPiigIGy1?=
 =?us-ascii?Q?BJFMImyQrXntWHXfmrirL2YF3mVx5OLjuTbNCFEs/50lejT/yqn7gxHWEflQ?=
 =?us-ascii?Q?RyuY/dvk65BUgzr61IcHmU63DFzVWY2t3TawmWR0RUVDk6wV2nhf79C3tHXK?=
 =?us-ascii?Q?FP2EcSktjxh8o01WjFDl70lZs8mdVLrJQp498hfH387F+/0Q0de1s7F+K+FJ?=
 =?us-ascii?Q?kCAsjboKiUjew2Rbw6wjtzXB57ikFt58Wj+mq/HNmip2KtD5qAESDDf4MArU?=
 =?us-ascii?Q?b69S6HhzJcTHsyZ6TCbWCFSDDqRda1vpmxIIn1Qd8YLI4tVLC6N9x1ke46dm?=
 =?us-ascii?Q?M6a8qr95F9F0yfivezM5PqvyWQehfelKD3fJ4bkLJ2bElUsAlDj0IqpihJyg?=
 =?us-ascii?Q?LbZFK5wCWbUNwv0bWPHOIE1mpXiuSfFhYzhMR8xcVTV8j5ukbH01hJpc/As0?=
 =?us-ascii?Q?VRABtTxpiXm0NMP4D/mCTqERzHEXg3DcmKoknCLRTQwqveDmux838FWAHEPJ?=
 =?us-ascii?Q?wR4K14FozdZfVfWRDMiD5b0szvLetSvkh12Pbvfv4Iwxq2mI9cDOsytc7kjF?=
 =?us-ascii?Q?fRFRTKD/iuNGR4en3hHl0cYGE0/U9jT9g58Dcj5BEnXwIDIPr94m8KbDbg/l?=
 =?us-ascii?Q?75fQI7CXIXT5nC5bfRtdqaBBAUkScEun6QqWrt2ClzSENJpjJYUEx8DTWAlx?=
 =?us-ascii?Q?G7o+fBXjG/UO8ONzApFNIOXlGovYmY1/h9j0yje4+W6cY5kQjOiMuVbD6bmL?=
 =?us-ascii?Q?qzkVpJOfKhj7UyQ6MJpmDlS7n+sEYscsH17l2blWxA7iD64xPT12c+KQXM4z?=
 =?us-ascii?Q?qAfX1Deww5gN7Jq1ZkFrbMBAoQ5zy3BUmTBFWse1G5be59UhPA8J2ZXMSr/e?=
 =?us-ascii?Q?D6ogpPOt0fIrnTwVtKjxhy0UYalbIVQwge8X4IUa+ftihADzvhqz4acfMy9s?=
 =?us-ascii?Q?O6ePZbKLyTNEzbPJ7CB5VZuzbruGk1MBphaL0lQRA+Pehog6UlqXLVrAs0ll?=
 =?us-ascii?Q?BnzsDgdpco8YijJJOIDH2vm+z/nPiBVgWJIFe1ODPyC32J02QPngdWjlHete?=
 =?us-ascii?Q?SNwlY6sfsTvoEs+SiGx42tPZsDff66w6id495kdBHl1BWMlUDA8jN/knOtMN?=
 =?us-ascii?Q?9blFcctV02ckfLZcsULFS7ex+fiI3Lsy5SpCBkGypzC9Cs8X+cMX+COc5FAW?=
 =?us-ascii?Q?lLM0TC1qo+5NjOeVLXob2V8OGqhfXHBJEyGdq/jRgNChEMa1CRZT7CNB3FA3?=
 =?us-ascii?Q?lB4nuBgGUfpgzACHfl8zrm6z3Yq0quD9TF1jgw2eGYeOARwVc3Sz7KWLnwnU?=
 =?us-ascii?Q?jhxfFcUv+zehId6gx+RkIVMXTKeaUDATUHhBTATMj/MwCUYmquzpSjbqpssm?=
 =?us-ascii?Q?kp8ftlyA141+XDraXpogxtWoAePXp1yqr+qRTh5hFEROoNQU4uyGSIF4R78j?=
 =?us-ascii?Q?9ygIX75wn7SHH1NrNrp+Ll/jO5qn/OhW/rfCkwdJdv8gTapAE1L5WPvgsAkq?=
 =?us-ascii?Q?X228GPyyiPmYqymxUrW5GuZj1h3UH4HII1t6f+D9uZebM0hn1ChttrGRmNKl?=
 =?us-ascii?Q?ao4lR555bU6Df1kRQjbElBoo+2/M4uIycj+r/znw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe46367-cedc-44a0-f028-08dc3e2315f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 21:19:19.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeJjPHlanpqvjjiJAOfwFKr+qnn8YrI6ICIgSRXpLqju84ehW2A5eDs9bQs8fQFdFMzopIodlrsXmEWua6FeVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288

On Wed, Mar 06, 2024 at 02:55:24PM -0600, Rob Herring wrote:
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
> > patch yet.
> 
> It never will (probably). That's because it doesn't need to. You can 
> just do it with git. When you edit the commit message, then after the 
> tags, Add '---' and put whatever you want after. That works as long as 
> the commit is applied from a patch as 'git am' will drop it. 

The key problem is that I don't want to lost notes when respin patches. It
is easy to make mistake when I copy old serise change logs.

Previously I use git notes + git-rebase, it work fine. Notes can be kept
when I do rebase and git commit --amend. But one thing is not good. 
git send-email --to-cmd=./script/get_maintainer.sh *.patch. It can't
combine all patches's maitainer to a list. It looks like difference patch
will be difference --to list.

b4 can help some case. But can't keep git-notes information when rebase.
It should be git bugs or feature missed.

> 
> > Rob's suggest was not work. dt-binding check complain too long
> > if there are two dma-names = "rx", "tx". 
> 
> So I'm wrong or you didn't have it correct? No way to tell with your 
> explanation. Let me give you the exact schema:
> 
> dma-names:
>   minItems: 1
>   items:
>     - enum: [ rx, tx ]
>     - const: tx
> 
> This says we can have 1 or 2 entries. The first entry can be either rx 
> or tx. The 2nd entry must be tx. That's what you want. However, '"tx", 
> "tx"' is allowed with the above, but we enforce items to be unique 
> elsewhere. Or I thought we did, but we relaxed '.*-names$' at some 
> point. I'm going to fix that now.

Conor find out my problem. The below code works. I missed maxItems.

  dma-names:
     minItems: 1
     maxItems: 2
     items
       enum: [ rx, tx ]

Frank

> 
> Rob

