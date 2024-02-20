Return-Path: <linux-kernel+bounces-73835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C80985CC38
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9D72828A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C17154C1A;
	Tue, 20 Feb 2024 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OHz+oem4"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32C153BEC;
	Tue, 20 Feb 2024 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472735; cv=fail; b=TF/jUFVE1bPp3y7lH+rEokL/izSGuIHdTmZOuknKtoWR2kz29yqbIqYAyABOlk6Cz0+eq/mKHCoeR2hY1QAXH0pS7FqBvNbvQwZOwOafev32b8b0OlK+9x3ABeQpZZ3G8q9OVWFNSSKeultkYOntMh+eKZpAJJqdVppp1qha8W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472735; c=relaxed/simple;
	bh=xhZxiN3Z4lnn7ZBmFgy5hu13RIYE+iOuQiJanxj5NOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pcpkuLVXrSK/VDGX2IddqHL/tF3/iyHVZ/OGaPo/ey3LsuXvGUKPU7Z2f0QLXEee3W/AzKgfM1bJDpw8W9xIcD9XYqz/OSpik00jWsn/FQxox6G8r7WW3wPT1MYi2XwYIaVvgMnqofwYwWpWuv7Fu70s5DvVkbqZ90/kqk7mfKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OHz+oem4; arc=fail smtp.client-ip=40.107.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI05KEz52njGD0z1H9WL9zvxUJe6ALuWtWInyTI0TnNlxd6lbYsuFGDXj1GxITVj8lqgbAtRXjuiFyX9Qsj8N1WwWUd3njDMGpNepJj9Qxv6uRIrtgD3kDqW4QzoC7pkwgKdnP/HmCPnJk/BUXr90gYFNhlsiUqXQTvEoXv6ipSOYSOZfpHL0Oz5PyUuuq6TMcq2W1PmcJ38RhZfoaphv+XNYAaJ+k8U/JFzGxUmrwx2stguqgEqUYyMGPu6J2VZxFWftJFbtCa61KaqkeCmSJTsGVCPuo85eYQI6T8bmzQjj4iJFs0+nnPlLlDGTMzOCjzPziYNXHRJoVEr8BuyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ivvNrQYYj2RWFZRfIDsh0kIzi0XJEjUy/HbGaHYgDY=;
 b=E5rPl4LMmvvr/sX4pwzcJKMGhPoyzJ7DoSiNtx/+eUU2iL5sKRQIi1twXFyCwX1plSlIta0sSCnr2g93J6h7Ek4gksYrnJiMOGNfPoVOiSXEH6ED3JQt7V8qGAVm5aOR2hVq7S6a4DbWvA1BItU8WPbpV8fyeej17Mb9M4D5zkHuvCUxnVgTluZRVH+pgs5Kizytvi39i9RbyMBSaCmj0OQFoXil8MuGio8WFk9m6XkpnwxVw8GeR3OyiNI/LbuknTIDi+TC9/kdwgdboBPKjpuap5cOJhrp6ncv+1LSJj9FZknrTsgPXNN/z6l2VGuil9JlKGhKSsOAmvr6P8LR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ivvNrQYYj2RWFZRfIDsh0kIzi0XJEjUy/HbGaHYgDY=;
 b=OHz+oem4okNEvr/jEH3yf7Oi+kTpZJFebq0dWJQgtibDb2tnXje0Rm/C9+fpvqqpv/90N32HdkAhMOErcaiYji85djAfIkGIjcjldPBKAqpfLn3xnVgvBeEhEWR1qjFv5A/5ItCW1RWzAZboHKp5fuLIwhKJoXslW3XTaUed3pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AM9PR04MB8210.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Tue, 20 Feb
 2024 23:45:30 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 23:45:30 +0000
Date: Wed, 21 Feb 2024 01:45:26 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: zachary.goldstein@concurrent-rt.com, Shawn Guo <shawnguo@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] arm64: ls1046ardb: Replace XGMII with 10GBASE-R phy mode
Message-ID: <20240220234526.fkifmrt63qjcpz7v@skbuf>
References: <20240220145037.kf3avnykjif24kkr@skbuf>
 <191b4477-7b4b-47eb-bb3e-0e4d08b3b32e@seco.com>
 <20240220223706.o7wc5r57omkmgtgh@skbuf>
 <e39c811e-ad9d-4e90-8710-629b822944e0@seco.com>
 <20240220230656.cefvrh6avji2elrd@skbuf>
 <bce5cff4-c1a5-4d71-b6cd-a89c55a628ba@seco.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce5cff4-c1a5-4d71-b6cd-a89c55a628ba@seco.com>
X-ClientProxiedBy: VI1P194CA0033.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::22) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AM9PR04MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f88549-1f0a-4439-c723-08dc326e05a3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 6ZCLAgUjXWKkVnzkt0iH6g5hJXTwFZ8zNBwsm0/OnveOmzIOKCazMpgevYwC3Zg1Fo+8LZZf25K37mk3MQ5N8N0CydLgKKSCTgka+80z48PF12R4+NRpDXwFKuACIcTXjK5PBO2YUDv+amayn+M7A61LDmNHPhHHID5X/ly8ukoJNJKnFCzXRmSo4PJAGBv7Q8+YRvjZe6rk8yC+zxXaCiyRN9iX43zecORbWOXCgx23BDwH07bvFithjT5rI8L/rO7PD0K4nPrt1cGPejFN+A98eS9wvsvDt+I1Lh++PSIAQruMlnl9JBZ+UbWX9UOMtfsNmAlZ7q9nLVopCpmIpllpOIYjObZqJ/tXUSBNyhqmqKRQF/tKz969cCd7kwHBCAdGkTcnqh/dYlJWRpHorE3TavflLWaolx8U2RQld5MPiZQv2TKltvVfLdCFAkZad95irIhJzO+XsnXLNHkjXaaQ9FE9BPM22woGSpbmgAXVwypxLLxQou14JygBxe88FIk8MDQGUklHtKpAbdUC2rcamkfIpiKcmP3Wgs7manc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?R2hrGzdJ1ORYw3CaZjnWkARKYCoMW/wHRl7xD09kkCtb82HxMOQ2xTE6YCNA?=
 =?us-ascii?Q?dV2kot1v4EzferT5CBbRU2apxhs+vEyUYITYwOtGvieXJWnHrnsK6VoX315i?=
 =?us-ascii?Q?4pYvGAV75Rs4Ix6J3FUCxGqpL2zhmlxmU/rnjvaL5MpTUUfmPhgnX+/CLznW?=
 =?us-ascii?Q?xiaJ71X1DbaHw2kaNKEZayDFPQk5DKh8PheploLE8IQb0/fP6ZyhPN8zU3vp?=
 =?us-ascii?Q?txfD0JoGm6FjEVgKGWWJ/nuPyoVqc2cBmxZgvml125ci9od7A8CrEFb1Pnjw?=
 =?us-ascii?Q?1KNh5vUEXHxgNGQG5AbaARIQkVmbFWekO1sl1zwjKnaFsh1m8EPoiC6xZpXs?=
 =?us-ascii?Q?r4fN7hcOlhLxz31J9qI8+H9o5NYMfmdOD2llSW+4S3Umi+UJAvW89XVO6GJX?=
 =?us-ascii?Q?1JikuAI0u6xSbVv8VWtEHQd62bnImetOREuauvSgFpiYHDLnie4IhGwAVhEE?=
 =?us-ascii?Q?CpZYhnwWr04TWnyvqSobzEJvlupabTno9cfeZphoGEWrvHIV3W37fum9pmlv?=
 =?us-ascii?Q?/m83orSCS6r93tYC0AAvfo14gPa5ihth27zjL4PfzxsEkje7WzmV8kdLETlk?=
 =?us-ascii?Q?bJNPgiisqXkfFR2XF9tmhjCzGVQ0KAVjAqQHxIjf+dVo6TVXdavpN8aiIS/o?=
 =?us-ascii?Q?nuRUptjC8KLfJ75RrjOLKXPRQUO+OLwRo8++C2WhDw775EI9+tXBXtuxYEMm?=
 =?us-ascii?Q?eg5Ly5RAM+ygTRE/ubWCoBW7yXdjmYbmNIlafvb4YELOVBLjziwON4iuHXVg?=
 =?us-ascii?Q?Zw5yNhTrF0QIB6nI+UX3hdMpX3yZRVII1uBJd/z0ysRrFqa/pNMxwdywIucu?=
 =?us-ascii?Q?Xz2UFgV16E6OWvzwlJ/8PNZ6UZ/qGtNvJqqx3HKhLibVmqb7wWbppIZHRg6v?=
 =?us-ascii?Q?xVLjswGZPg50m+8Tt2oFiRF5N9Okas/LgPzs802ngDRU2ThWWWb+kv3nxrOV?=
 =?us-ascii?Q?B87uSdF3loL2IiM1reOkjIZiz0d5uwwNjX6wwS3zASJGos9NhRd3w6BPC3yx?=
 =?us-ascii?Q?Zj6BsGqJcoieKtWfk9P2BKKDwcgy1WgDB+owD1XowPUq+UQQTFCmyPDpfqop?=
 =?us-ascii?Q?zMM+NpA56TN9HZffxX932oVPaMT9bRIS7lET4ekb7yBxDsy2LWaQQY2Sgifv?=
 =?us-ascii?Q?efZ+RjpbJ7+L3cBza6BGWyOUZdWG15vgumLn5INEi9wvKgXKRIwq+75AgP2v?=
 =?us-ascii?Q?t4xqoqkyXX1ZR1//NDLD65ObuhgWbeAF3XPuJb2n5DEKs3sSOrpQyrYagTjH?=
 =?us-ascii?Q?pTgU1Ws+NUB5+s5EweAYYoLTkiX2ohxt9xL8HsoHnPdqEsamo9BNr5ED95my?=
 =?us-ascii?Q?m/QuDcrmi6hfID0w3KznbQfDdUFmzQjIGgdbjfRxbRmFY3WktpKk/i96uChA?=
 =?us-ascii?Q?FvtefHl3keDgdQPaQ8m/kpaoxN+r5QizplhupkoHuMK19G/wCvE22bu4LPhO?=
 =?us-ascii?Q?8lg7ftr+vI+Ea46T/c35ehC63nmpjqswRrAot4hkylyeh4sAdBa2ZzheBhXZ?=
 =?us-ascii?Q?zKrfWJjX3y7oW49yS2qYqapd7eqRx0N7vjp1GwMKdSkkN9RIve8nn8Irg5RV?=
 =?us-ascii?Q?AW24fxf0wl6KV1AdcAhXv7QqD2eXJAmofCHOJ7mUZuZ4bnMp/DyQ1JjAPxRB?=
 =?us-ascii?Q?krVDwgYSu0N0IXC8g0VIbB4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f88549-1f0a-4439-c723-08dc326e05a3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 23:45:30.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJxC4Hew/+bygXM6mopoUCTkJOHamIDLKWY0irCnSAFFOnvYxMmIycw9ZvpE2w4q/SEaZ0S1br/d/iM1pxq3Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8210

On Tue, Feb 20, 2024 at 06:17:02PM -0500, Sean Anderson wrote:
> On 2/20/24 18:06, Vladimir Oltean wrote:
> > On Tue, Feb 20, 2024 at 05:52:36PM -0500, Sean Anderson wrote:
> >> With SGMII and XFI, the PCS sits on the MAC's MDIO bus. So for SGMII and
> >> XFI if we don't have any labels we can just assume the PCS handle is for
> >> the right PCS. But for QSGMII the PCSs sit on another MAC's MDIO bus. So
> >> we need to tell the MAC where to find the PCS. This means we need to
> >> supply multiple PCSs to the MAC
> >
> > So how did the other Layerscape devices with the same SerDes, PCS and
> > mEMAC manage to get by and support QSGMII without listing all possible
> > PCSes in pcs-handle-names? :-/ DPAA2 has the exact same situation with
> > the QSGMII PCS situated on the internal bus of another DPMAC.
> 
> I'm not familiar with them.

Take the LS1088A-RDB. It has 8 QSGMII ports (dpmac3-dpmac6 over one
lane, dpmac7-dpmac10 over another lane). In fsl-ls1088a-rdb.dts, there
are multiple references like this:

- dpmac3, dpmac4, dpmac5, dpmac6 all have references to a PCS situated
  on dpmac3's MDIO bus.
- dpmac7, dpmac8, dpmac9, dpmac10 all have references to a PCS situated
  on dpmac7's MDIO bus.

No limitation there that I know of. It's not as if the pcs-handle has to
be towards the internal MDIO bus of _that_ dpmac.

> With DPAA we used to just try to configure the QSGMII PCSs on every
> MAC's MDIO bus. This worked out since if you enabled all the MACs, the
> right one would eventually configure the PCSs. But it also meant you
> couldn't determine the link status (since you didn't know where your PCS
> was).

Yeah, the lack of link status reporting from the MAC's PCS is a true
design limitation with the old fman_memac approach. But it's not either-or.
It's not as if things can only be done like that or like you. See above.
Each MAC can talk, through a single pcs-handle, to just its PCS, on
whatever other bus it may be on. What is escaping me is the justification
for _multiple_ pcs-handles.

You accept that you need to have some components of the device tree
defined by the board (phy-mode/phy-connection-type), but based on some
philosophical notion, you maintain that all PCSes should be listed in
the device tree, even if one board could not possibly make use of them
all (and specifically not make use of those PCSes for which it cannot be
hidden from software that they are distinct, see below).

The argument doesn't make sense to me, sorry.

> > It is unnecessary and buggy complexity, and it will only have to become
> > worse when I add support for C73 backplane autoneg in lynx-pcs and the
> > fman_memac driver, because I will need yet another PCS handle, this time
> > not even one that represents a phy-mode in particular, but a PCS handle
> > for C73 (with C73, the autoneg process determines the dynamic phy-mode).
> 
> There are multiple physical PCSs there must also be multiple PCS
> devices. Otherwise your software and hardware will get out of sync.

"Must"? All the single-port-per-lane PCSes and all the multi-port-per-lane
PCSes can be made to appear to software at the same internal MDIO address.
So switching between the SGMII PCS and the 10GBASE-R PCS is never a problem,
even if you don't know they're distinct.

The only thing that's not possible with this simplification, and would
thus justify pcs-handle-names, is switching between a single-port-per-lane
PCS (like SGMII) and a multi-port-per-lane PCS (like QSGMII). But why
would you want that?

> If you don't want the complexity, then don't design hardware with multiple
> PCSs connected to the same MAC.

In case it wasn't clear, I was talking about unjustified software
complexity where there were existing models to follow at the time of
DPAA1's phylink conversion (i.e. DPAA2) which solved the same problems
in a much simpler way. If by making these choices, you've solved design
limitations that are unsolved with DPAA2, please let me know, I really
want to know.

