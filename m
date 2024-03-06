Return-Path: <linux-kernel+bounces-94476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9664087405B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22944282735
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E20F13F45A;
	Wed,  6 Mar 2024 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ifd6HLm9"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2237692E6;
	Wed,  6 Mar 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753165; cv=fail; b=Yztm7bJo7IKKIan5kDvR9BGSpqbRxlsbYlzX5YGb3skfUxoRf67xxYemJ25FYsJvHKgT6/7Ky2wOdi+9oYGNkoNCAx3/mXrOYpdNM9NZfrFUZcRuEBSVCNJZutylh28rJxPTgzboiOi8wbl5zOSKXkyZe7Wtpylz7KhO5o3lQ0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753165; c=relaxed/simple;
	bh=3A4jTdHYdTCXYKvaVwJKbLuKfhxJT3wm1G9aNI0uaJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GjPF5L1sKfHsgR3UODuXmEZBh7DioqcwJ3597B0iZfpHWyL9aA+byFGIYGlNod/l3qy+oTgnpVcC089XjrOegyWuZrJcd7cHhvXN9rZFBY16VwK8FAobNFFIzT3g5m6jVPyuQ3J7DLjhb/lGhJUC2ZZZXz/HbuL7ptcJC/BG3K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ifd6HLm9; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoNGheSTazq+hrtVvuzqi0cOIOUwlk4EYnTfJjc5fl9syiM0lK3t5zB/qd3afcWPDf5Qwoh8WfAjXbN4UgNSEzgT8rQbqgm995kTjo8FRZdZ8B4FNrEUpGUtOo8DwbiOM2r1yncCGfF9Nhz6bsUrNCYlfgpmgakVXISOeQkxEFjU1mebtzgcJddvgHjnhSuV8+GkApxvHAJiu1KdYzoHz28ZYPktuZIJhcSzvNQ9pR9Ru3QPalgA1RHk1r9J5gYiwnCfy2+BG8E+2HRy9Sb1eKaAVsvTR2bhnwe3lUUJISFPckjQtIpLpInmM31DkeZ7XVaVO5isF3hipt8YQSoV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHNgAGco2M3qzJ0D9W8b7Xjzw3txKePlzD3e0kMuKrw=;
 b=jft2NcFDmoJgKKC6V1EM6K95x8aINfaGwi3OFuufZHoJONxHney0E3hlhW0r7J7qMBCYwBENICN7J+dEzdqhAQ0cBc5dVUrI5xwLU+xUtqJ5KdvBZKgIseu/SImewltlXljQVgk+joaw+R2nI2DbXvJeAXBqNpneIkm8b4fdSNNDXoUA8HuD/w8SW65AaULfLamaCJhvkeDveya8p5JtEg6IxlTBHwWRMxAnZb6iWyIJ6h1RhRQ5qm7+0fYdC5U71bs5c0lbEjlml3nIyFgDRpxrudCZLnO//RpCwrjT5C33pmJkZas5VyXOx75b/sRkzgp3n7RXedKkHIBguZxVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHNgAGco2M3qzJ0D9W8b7Xjzw3txKePlzD3e0kMuKrw=;
 b=Ifd6HLm9VoroxUAQIvy52xrMpVcpJ69O3vYrXnLpi7+lTiUu8zdHKH747ZZtwTOzBHXP8nfF2J+vPVFVoTUJUxcgMSn9hByTJunjLS5y0+1/0ZApMnWV8hRUBuTlMvZ+MQyeMa+ED4waNtRqDND1wJI0JbUFcXc/AG3wUxj+Yv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7951.eurprd04.prod.outlook.com (2603:10a6:102:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 19:26:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 19:26:01 +0000
Date: Wed, 6 Mar 2024 14:25:53 -0500
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
Message-ID: <ZejDQddMp17RD6Yk@lizhi-Precision-Tower-5810>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>
 <20240306-pebble-grope-88fdaa95a87c@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-pebble-grope-88fdaa95a87c@spud>
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 870aba6c-2cc7-464e-6258-08dc3e1341d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hswYL59acMhf6PRODZNnfXdZWVpWCgeU2O31n0LjWe2Lqr2IibSz9Drw/X6aCD3C7E0+jSprf4OOZLHZtY2kJ7jQLh80ryK5OyGEsdLJdqBGE9b82zRsrGc8C06crdlelxYjbaCMhvc4QHH/LyXGcLdurSXV20o36rNYzVvtqlpri9+dKZi1Moxc4Y/9WPY4FyXHDVQK9FwiRduFT9k4IE/osgrtN8Ae5+lhbsQa0uLt7P980oOekzjGLLRBpzDhiGD4Jf1YZHfVcIHKbMGdRZ7qseHv0pmjLcEn9+R0JAwXjSDti+gew0lwK5pdF3TR57Y15v1H59gdLXxwehP4PILPSyVhyIaAuurl+e8CI+wWvXa2r8Ozfz8OpreV45f+OSUGxdtfY3BfgpDOBXnUuX/F8h1okgTKFXIbPh8+mQAUM1524Ibl33o3QNUgVS8WEf3RKjh5E4bXzTJ3eYid/+OSSkd0zdmOYMVb0nZDSkQ97lqLD/l5TrUOfaRqSiWhqh+bZk9ZGy0j2nDJkge0FF9jC1X7ABtsuq2jpMQvExm29QdPAkfKHosyyJ46uPEP9gbM0GWIcU4iQ8Ry6y+JClrfCZpGlN9hz+ceWJg0c5UvtGLu+JqNuEO6eDrvsdRoxyn0BYXTAeSTKHM4or1s/po++RSwMkenFckBkJoDuqsGejLIytD0BDLr3Xln6jPCribJbguNZpHhkjeUwB20jg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgShbDSfLbH8nrAqS1IiDELfJDWpT5H3gCvH5kHrIFoowrePcsJ9Z0Hi3LFg?=
 =?us-ascii?Q?EqbmdyhiUCTdrSe7OEg+egM5K92nIina7jg10BN7GEsnMrqsXvJfw9Sl4sqT?=
 =?us-ascii?Q?I9wrG3O5PzNb5Kd/fXUrK9mEoDUrlGHkKYplEwucu7P7t4tfXbYVGASTLInL?=
 =?us-ascii?Q?hRVUSPN+cvRwskyPVNL+jQv7ZduW5e8Ef4udQZrAjMEVR91+JTKuG7cSlXhX?=
 =?us-ascii?Q?Py2hXlAEGQOGl2E2GTAoKmraeIp5kvwGnnC5fJSx2OK4WQyJRmSwk6MnrnAQ?=
 =?us-ascii?Q?/ECgJNMNQl52M8lST6Ic+LUeqjc5x5Y0Zqmo+BD1d7BmSIaJGkGgtq2k7l/n?=
 =?us-ascii?Q?dR8KmP5XvmmtoMK+fiMFYOo02208ghcH/1wpUdxC9M7M9SZo8oaqvCTSEmIE?=
 =?us-ascii?Q?K/cKysHZ0XY0dO6kfo9jWRkcPrKEPto1WrBHTuYi1wlnChc3MY2dYVlDhNto?=
 =?us-ascii?Q?T2nOdZ5uxRaFr6VLIkn7kz1JfIUt0ma1qUpsaVE0h7VUZp3AJaYSQCkO6bfS?=
 =?us-ascii?Q?MPVOMCrKnk0lpsqX4pmJvOQ++dCfVSc76VNC0VCKHkeG8zDCy73B+EO52yoC?=
 =?us-ascii?Q?uGfa6VJ9WUm9QME7Hj6rsN2FNA4W/RcnXKf+9dbczY67wSQSQQU4knlvHT8h?=
 =?us-ascii?Q?GgoiN9uc0gZzhx7vvSxIyHGIm19IcGWmCxs1ISaDKMTzL39cw6i7wYifSpSS?=
 =?us-ascii?Q?UJ1rrgC6rEq0l7SlHthe703dtFOcAwQMa0rDEDSbo/qbyQjba/tXspucY1y1?=
 =?us-ascii?Q?rWr5VlFnDWFC+KqVfCTluJFO0vt8PvQUwfdTTTjjF9b9JNbKwkHrt5oiy3Kf?=
 =?us-ascii?Q?InWRWMPjlJyYgTR/TIzmVvjVLMFLR34rLSzTOq7rpEpVDIbmF42S1+AVNb5R?=
 =?us-ascii?Q?C/i9YUgB+3Kb6mb4KDL0KOr4EesMnFxf+OCDGlk1P6U7xVU3CB5dN2r0cn1P?=
 =?us-ascii?Q?6ttO6VtmT2MKY6AqoopYJe6gp8fs9oP8lJ2NSrRgUIdkt9vzH88gf6ZVmHs5?=
 =?us-ascii?Q?Kg7beQaScSP7JLObKD/zxqJj6/S/NKxYJW08xZvn0r6dNo3Zc+7aSNSrnMEO?=
 =?us-ascii?Q?5iiqlRfl1khqwHpPgD4vLXDudRj+yLu/wQ6SdjQqLrEWSKTsKNauUBD1o2Zw?=
 =?us-ascii?Q?73BDBOFNDxv6KEWPL5ull/BBV6kQLxa7BlrJeaiiXhNeS3Hpy4kjhdvKUTMc?=
 =?us-ascii?Q?8ie0HHbPskMeOahhPAUGQcWImJj4XJuu5hgOqvhSJFmDzDtxsbF2tZeLecYR?=
 =?us-ascii?Q?w7d0n5qhdfxp+bEX/Nldd5wlVGARb0kjD+YAHJoVe5a/iYpsmNAUJmWK0QyV?=
 =?us-ascii?Q?ms8jlicumSgzPpTmzoBH+dNQXN6jb8+SXqfRdT30fK22E3FLy0J/8gSW1KWL?=
 =?us-ascii?Q?88V4mO/RWikTUbyg4UpWioOVKbdzKzMcdthiwGClAl8TisEmEDZCY5xz3dIs?=
 =?us-ascii?Q?btXbg0fEOg2aGG/NTRTldfnI13B06YMNFvJYyF8nJzvv9V86H0C/c4h53eN5?=
 =?us-ascii?Q?+4PJ8BileVLyynaBVVnO4IWJxNlZ4NqYg6g4v576Wm9M3UUhAAbAsUTIoZZY?=
 =?us-ascii?Q?58HWd/NTw0oVNdFHzZe53R1MWJ786yaCNTJ59i5K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870aba6c-2cc7-464e-6258-08dc3e1341d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 19:26:01.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tp/CnZAW+DSi7M7TMJYLgTqXECFDjPOD9PcdNkZFBFvF3T64pKF7PwfkDSkqWmkSDd+EbN4PCPOVKzVNdgMFSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7951

On Wed, Mar 06, 2024 at 06:45:13PM +0000, Conor Dooley wrote:
> On Tue, Mar 05, 2024 at 12:33:04PM -0500, Frank Li wrote:
> > Some sai only connect one direction dma (rx/tx) in SOC. For example:
> > imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> > for dma-names.
> > 
> > Remove description under dmas because no user use index to get dma channel.
> > All user use 'dma-names' to get correct dma channel. dma-names already in
> > 'required' list.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > index 2456d958adeef..6f551c68d33db 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > @@ -81,15 +81,14 @@ properties:
> >  
> >    dmas:
> >      minItems: 1
> > -    items:
> > -      - description: DMA controller phandle and request line for RX
> > -      - description: DMA controller phandle and request line for TX
> > +    maxItems: 2
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
> > +      - enum: [ rx, tx ]
> 
> I'm not entirely sure if this was Rob's suggestion, I got the impression
> he was suggesting that in the two items case we'd not care about the
> order. But while I think this is different to that suggestion it's also
> not wrong.

I log this at cover-letter. b4 can't support write change log at every
patch yet. Rob's suggest was not work. dt-binding check complain too long
if there are two dma-names = "rx", "tx". 

Frank

> 
> Thanks,
> Conor.



