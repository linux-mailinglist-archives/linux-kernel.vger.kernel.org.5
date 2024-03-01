Return-Path: <linux-kernel+bounces-88769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B686E651
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D66A1F28BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6C3D0A4;
	Fri,  1 Mar 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HGo6cSy+"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09471259B;
	Fri,  1 Mar 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311594; cv=fail; b=cSZ24qdFDQ8pOCVY6G8A0pBFwnS7h9GVgLkCCsoXDjixY7yOSSZYxxdwwFFxI29+trvVr5Ksdrsw8fey8HVinCCdCo2WOJZSYF068p6MGtNMTRCwMNrf/RF9nl8bMNhB0V9EgAMDg7T6swivfYdUW2NFFk12yNDMc5Gnw6UJKDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311594; c=relaxed/simple;
	bh=pFEYWfMnzFOGEazq5JiyDMlOBIdcmJ5bpbSXbvn5SUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hkbSR0WV2BYLAmClSmle5SCDCWPTjR9qSN90SExEU+ntPUAnF1WDzVBoZ0cN40e+bZBIsUhbKbdltoocadVjIipJJU7DsDlFvdQtwJPEU4vQIoh1P7IrMFOV+KBqQx4gIrLbn5X5O/63+iYAgnVQrwq9Z3c/E2Ey33RgWiTTQjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HGo6cSy+; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=impP9uFoZYs292IjtemLJ5I7gFe4AFwcB/1bv1PmNxa8JZHh1LUq1kFzuoeD4Z+c4gaGjJqzhbRoXgXN7DuSgdzrT0cfVAJAQ5JRbnH0f504JfVDTQ/MQUHSC5U+X/rUgAb9yOltWLfJVUF/x7/ZUjJ6zBq/Rt33LrDay0643PbgIzp3uWhp6jonsw5vQENrRJmyHnWezfEO52SQBR1HBErhdgQQ26n8uvP81bGnGy4vNgl4WFIUpERtcJr/fqB7Q6vFcz9h9m380J4BWGXB3531K8MuJydDPKMZfWL7i6O/8/yQl2EULWliUQ3zvVBHYrcY+o2Tj3UavVC3lxfScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p59ZosAPfj105wfCfILNHGzXauledxGexnkHmx+oEi0=;
 b=Myx0Y8Sy2urpA+ilZfewm8CFnGStnz7UhrI1lCyfLh/oJdZTkGfEGI3LJ9UYemQaiz8v1TO51IBJxKax+61uZ0/djlaR8Zm8dDkbFW3LRUYkiGhhPFvuNdosTpAm5vXh7TekTVYWJ6ijvPQINfVVnrIMpzZidIndNfREy33HmCC6YmbkOotWXnpHdGJg+HB/TJ5lgVHGSD6p1Piuhht0LXCpSMXp2qWjZlZd5gVy3CDGYApzbs29t/JPQbOwJGGO8VEsx6RhpW2113WxxQPJL+9jcLyJx56WmCbE7+MblOAClkVsJ8bskn88xVpLC1MKfFkBiK/dJY8Dj3OHKIK84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p59ZosAPfj105wfCfILNHGzXauledxGexnkHmx+oEi0=;
 b=HGo6cSy+d4G4L2Ip+KVclgqpDprh54dz+uC6+Tbkzm+HvBvHx7IpXpfXk7mPBVcfyKzpF/RpF+3c8GBT2RNimacGz/pIIBdYRAS6brDKiOhuGkJodbFjCnZVl3ju6i9wpNeAyoaQG89ceQQs74TJ7L4L5v/r9Cmmsh63Z9BJHkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:46:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 16:46:30 +0000
Date: Fri, 1 Mar 2024 11:46:20 -0500
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
Message-ID: <ZeIGXEJ3l4tgjmxT@lizhi-Precision-Tower-5810>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
 <20240229-rundown-isotope-954ba9ea4c57@spud>
 <ZeDdMJlxBL4SGkws@lizhi-Precision-Tower-5810>
 <20240301-crudeness-resale-3c0a1228850d@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-crudeness-resale-3c0a1228850d@spud>
X-ClientProxiedBy: BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: f202c273-289f-48c1-043e-08dc3a0f240a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NpnjbX5SWOmfEcJNgxiZDkUPG89KuUNztzyHhIyxIuXAGR4hgfhx1MwJ853erQkRfYYzae1pfifiVVW0DmfjN0Qudg6vgtA27T1CID0ARKi/FEa9DXGvugwZd2UnA0pKUguGSty2QFTs948HXkWLUeu97sfzKZLn8MJ6jc1Bwzsebalcb6yNnum86WBf86eQWnlD/X22BGv/ugoBeqCW0JIXtuhi/Qejs8YE69PsAOYajsrsf7ksr0Ja3vrH6sxj/j4lglrUEc62V6OqxMpRzzGjZ66qk7B/3jkfqIz1X5xo4fMb1DGlyGo1lgFwQy8LpRPZR2n/6VfCX4CvYBef//Sq+bycvJWNOwwK0Y4mV/Vqw5ZS5KYAoxGPnneYLfdCLpo6ZZeXkGSGybUgjAHs+FM9CwUeCA6aXtNaQ/J6V/ZWM/n1WF2OQf+WTM5KwJn1Ul2ntuw5/xtcpabjTc/qykMO1OpE3iX9CmNkngtyKDrTP3Q3xIpx8kaR2tsq/IgOXlW7BOnhvzigeI96EC4OrAFuKpTVcnf3n7q+WopaBU++LuLpECH6GloVKbVldoneU2ASz0ZP/0YQxJjN+/ddpZT7jynQ6Uyj/vOSqtdH9PfaN+PuYUARYX6CjDQrQ1jn+TKiHYXvkdl8WtJTwuzkQjMpW8MA9VyfRVV2cxLspm7h/G6Rxqce5QdGb+VsnfBo4mADxTKKZfmWHoCa7aQTM8XK9XXTyGASKbMMpbJJOR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ff+WVaS0KKl5rC6z0YFVDRXean3LnTKwzg5A9k1EHV9XBAqyT82aQNonzD5l?=
 =?us-ascii?Q?n5lWWSR0r6JQAlIFpls+WNFYfho6mhtlELEZy+GEEs6Pbqpw6BdfNKcPjQv4?=
 =?us-ascii?Q?Vz+GnEeQj5duVKoYrUn9L6cte9aWOf7OWwWK6iDu9ryA97CA0s/ZEUR+S1t0?=
 =?us-ascii?Q?+q1yzv2xUFMJBY1bt4TgqCwma8xVCt5AX0a4ubpZQyranfptIR5C9YSsUPx+?=
 =?us-ascii?Q?VzARKC6I67pkMK6zH8NOqrnmOX2XLBHr3+eXhZlgiWOCSrT29p9dIoMxPCoA?=
 =?us-ascii?Q?L/ZZmWAJ4kQ5UcSAJwBHY+qRtT5nNqZPRHv1OAnaRi8E8NYmBRghnLMDbAAj?=
 =?us-ascii?Q?pvlm7XzTfkeA70n5jm9cq/Tuz98gfRDV8ENfJLxWwaJvVEKADueTUB8WNHso?=
 =?us-ascii?Q?3WGnzIU/G7PWzur+dPh5fy55hqropwGJw+sIXhvo6YjGQYVUm174cfsylkd/?=
 =?us-ascii?Q?KxoTpUkgINvc/2LArci73juDdMA9acvmvD3N1naktqB6HVxIRgfQ48ppAybP?=
 =?us-ascii?Q?Mta7W1NEoXIBfjzF0ihnrtYxrKbg+2l/3PCeHqnV3p1kB9dmet0/ylw+D5wb?=
 =?us-ascii?Q?KXGhlNCfbsQwj9D1Ld3FhJZgmTBVHAZiRaTdyVMKrfAhk6aIScVW07LROvb9?=
 =?us-ascii?Q?SGDtcSF6g5kNZzLuPhJKBDgy+fT9ZTRnqmG/ejyJBBvKFqUcFbKAbf5b7lCO?=
 =?us-ascii?Q?gLNmmW/WL48a/4WtxzJQZiQBB1wJJXfczj5dpckowfMpAPoU6RxZov7jGEzF?=
 =?us-ascii?Q?etSBWlqByXsqoAk7qPnXFTtucV27OOdp5l3eeStaEyxEp0t4qzuU6WcnmdVo?=
 =?us-ascii?Q?ZsD5aaClZAb3zphAGkVnOS7UPrcHhi9C2lyxc7UrVB+/aBlNi+Ry3jSlZpE4?=
 =?us-ascii?Q?As4z7gBzq2wJdL9ihf5KUQT6rxsToPrtsSCQZs1yamx3WCywEbP6sI4cFGzD?=
 =?us-ascii?Q?jsB66CmM83HmTX+NZRHUj7Bwv8tMsnROSxDMCPQhBL0ePT34d7raPO2OeH5W?=
 =?us-ascii?Q?NwvdWzXWD7Dgv1wt2cRWE+ZHZoq1JneY6K2zMiB2LJ9pso+Ch642GjoLOQ7o?=
 =?us-ascii?Q?8xFryqsZ/RWyDZ2qGkR5WKGKwTWEQ76YXipuWi6g9JO5JXGVeG/9A7mB6YfQ?=
 =?us-ascii?Q?jSeFooAFb7u/egebv5phh4Ol6oVyX19A6cPbJFYUiLbVxy/X8RXVQ6/J9k7/?=
 =?us-ascii?Q?kAA6iUBGq58ayvqClWQrxCldTiYUlwSW5+duW8WcWoubXc69hMHayyPTkfvL?=
 =?us-ascii?Q?zQ90tcNURx4NUcRJ0j4h892knQp2sFDdexLkp5G0iWJMYbd2CjGR3EqF9BXB?=
 =?us-ascii?Q?SNWYPTyAqK9LVVvwGsZv2u1dtauy47ceolP1dZAspq7NuQt4W8CNAf/YNCcq?=
 =?us-ascii?Q?L6Uvt043u5V7Er3yMgOZPEXL5irmBKhaJN5E7Fy7pbRQYnQN5SNH//kfqO6h?=
 =?us-ascii?Q?+5X9vT43OwTSxd/s1hyDtbdvTOYTb/q51wqMzBqi/ymBx+ItH7n+7UAUK+FD?=
 =?us-ascii?Q?7jnHIH8KwuqTsABD2lQR9nmmIQHkN42Wgs03Pi4V+1Mfu3spIIrXgcRFmVlG?=
 =?us-ascii?Q?MGzirGpDhtJ4vu4QR1FJbjuErxyEaO8SMcs+392f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f202c273-289f-48c1-043e-08dc3a0f240a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:46:30.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jOfTZcZSTcgZwuIMP4qaCXPGbbAVPfEbffJCmpKdJIgEph47XcBS4seVYnyudon0pNaFf/a9O3xpJy/kmbM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839

On Fri, Mar 01, 2024 at 04:05:25PM +0000, Conor Dooley wrote:
> On Thu, Feb 29, 2024 at 02:38:24PM -0500, Frank Li wrote:
> > On Thu, Feb 29, 2024 at 06:57:29PM +0000, Conor Dooley wrote:
> > > On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> > > > On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > > > > Some sai only connect one direction. So allow only "rx" or "tx" for
> > > > > dma-names.
> > > > 
> > > > Which sai? Can you restrict this per compatible please, so that someone
> > > > cannot add 2 dmas for ones where only the tx is supported.
> > > > 
> > > > |  dmas:
> > > > |    minItems: 1
> > > > |    items:
> > > > |      - description: DMA controller phandle and request line for RX
> > > > |      - description: DMA controller phandle and request line for TX
> > > > 
> > > > The binding already allows only one, but it documents that the first dma
> > > > is always the RX dma, and that doesn't change with this patch..
> > > 
> > > I said "doesn't change" - but I don't think you can change this
> > > trivially, as something could rely on the first dma being the rx one.
> > > You'd have to check that there is nothing using these using indices
> > > rather than names before making any changes here.
> > 
> > Linux driver and dts with tx only work well. Only issue is dtb_check will
> > report error. I want to eliminate these DTB_CHECK warning.
> 
> Linux is not the only user of these bindings, citing linux as your
> evidence here is only sufficient if no other users exist. Do they?

But, 'dmas' should be common property for all these bindings? I don't think
they use 'descriptions:' property, which should guide dts writer to write
dts file. actually words 'DMA controller phandle and request line' just
nonsense words. let 'regs', it'd better descript at 'reg-names' instead
of 'regs' if reg-names exist. Only meansful words is "RX" and "TX", which
already show at "dma-names".

> 
> > And it also reasonable, only rx or tx for a special SAI.
> > 
> > Can we remove 'description'? dmas should already descripted at common place
> > and 'RX' and 'TX' are listed at 'dma-names'
> 
> Removing the description has the same problem. The existing binding has
> set a fixed order that you now want to make flexible.

Actually original set minItems: is 1, which means allow 1 channel. but
set items to force two channel. 

Does it work

oneOf:
  items: 
  	- description: TX
	- description: RX
  items:
	- description: TX
  items:
	- description: RX

> 
> Thanks,
> Conor.



