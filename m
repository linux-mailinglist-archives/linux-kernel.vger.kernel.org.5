Return-Path: <linux-kernel+bounces-165275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17DD8B8A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2FBB218DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04321272C6;
	Wed,  1 May 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cZipzCbo"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2080.outbound.protection.outlook.com [40.107.13.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DD1EA84;
	Wed,  1 May 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567820; cv=fail; b=YPnt39OX/YllkYXLqqgnY4OZRt/DjJzZIJIOpzelQI7fjz0aAfkRWoKu8bLqH/+F/ybUIeiU+spFRoVCyqAk+/+BVBmRSY3wdQzWYz5Fgy6DA6vZSIZ9xNTrwD2WHQDWJ9TbMgyvPh8/VIxEX7G3miNEBheGJKpLyk9ha92IVi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567820; c=relaxed/simple;
	bh=OInO6yAg14U2A4TIttQDy/mS0VvP7xhIZA0f8KUS5dk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=av7vuNgfoNBL2hnhXl9YGCnQJ30WMhaKyPcsftZHXEjWo6ozPGhWb8LcW7XwE+nkS9f0rfFfUXleuEIRMF9uAq7fpr26Lqb6+pC5wvIaGP+X/smQdqvDyoos5gnYxdBWwx9QWcf9V8rfusu5/GKb1sJo27b3yXLI98UZz66E2Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cZipzCbo; arc=fail smtp.client-ip=40.107.13.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlXs0UjSi1vMqrsif1HGZWkYFRbJp5ptGqN01C/w36+72HjBo1F4BRhOwNNTCqOqaLZOpSKXfbliA+qkvsAU5Cgf35G+RwaQjNZYQ1QrkHVD5j59qsfoD7gd7Mra2rwqldL0Vq9DL2BM2QvnmbFfstGBhIzoxbMTxhTnsByiuk1iRa7ECKmwRW0DqiDf51lr81trGRfAsmNs6E4nscBqNCXL6i5N6SG4zQFlillgcg6oK+GIeb3H0eU6mlI9NQWpK5s5KDkt68OtZu+VYcizlAm+w2MGm2L87+jGm7fLQvQTzvutC+qd/JTm9bD8aYX6kPykkTRrv6jAir4+re4jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eig9P6zNNvksUOs0mChTICwLK4o4MZg7g2lLrYGu3MU=;
 b=Wqps2H6ek/2E0xaTShqwFIZh5vfJN68YleAmPS73MD5W5SoVgwbAL4AsdVMD2Ydkp28DMxmuAyw5NMfP4rQSPjc2FGYnPpqH0300OrqSSOK8fpBYm09nBz0lHKj62F9ybqmYEhRx/7X0Hx5FM8I4lHVxeLYYfwXqVFoBOyc+QQOPdPjrELs1VlYD73iNLmfz1p9sdplARflJDGdreaDzKXj0/FBB5CaQWHdMw3B4raDm+5l1bu944XsKsoKkNti5vDonGJEcwcSr3LE6556bb6BoDbKrMe50aLUGzkBAL/OeyN/C2sfng1s7xJCIki8XRjPQp2lQvjWZOifuP06v0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eig9P6zNNvksUOs0mChTICwLK4o4MZg7g2lLrYGu3MU=;
 b=cZipzCbowOFGsvyjBkun+Dm2DvrXj2nY829GzsOFOCWmjkxfTSDguNJLA3v/mcRAtzS9zlyPndCuiBgZWr+/h4CxGKbc3c2mh8+jqpbYW0tGdG6Bjj6iD241ieLU7hjzwlI4otXahO180IDEK8Qkn3NZ3I1R90+PNLttkA6IdwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:50:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:50:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:05 +0800
Subject: [PATCH 07/21] pinctrl: spear: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-7-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dvorkin Dmitry <dvorkin@tibbo.com>, 
 Wells Lu <wellslutw@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, Damien Le Moal <dlemoal@kernel.org>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 imx@lists.linux.dev, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=1599;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gLxq6qceZG7Nsihhv4/AWrdppvVafau2eKIInT5INMM=;
 b=5hrt0gbxJJ7QqY7zWkD59XD6gGmBtnJ2Mk2mppbXKINjScokK/bEUlyDvxyY37V73GUwBmelp
 8QpZLElFZ8OB/OjNAS53Kw/ZvCNuX3C/romIDSd8neQC4zDRgxkW5fM
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e665480-5eb4-4375-39ec-08dc69dd3f8a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlNOQXFjcEQwMjFyVG00L1BHYUVhTWE3YnVvVlVoazYrc3crdjhDZFBicW5E?=
 =?utf-8?B?N3lxODRkNTU3S3dubk1YdXhpV0VvTkw2aHZFck9LWGUvc1ZrU3dJZCtxQ3Vx?=
 =?utf-8?B?N095V0YwYmxZTHh4L1gxYWNpWkpqWjlGTzh0bDlvRUM1QUlyY1Q2c2VheGhH?=
 =?utf-8?B?ZnBpRDd6TkJjS2xVY0tkN1pKWWhzWTIxVXBJY1BlK0psRGpUZ2l0OG1VV002?=
 =?utf-8?B?YzdNemRRcWJSc0gvZnVwWmhYLytwK3BIYm1uQUNZT2JUc1ZpbEZKRndRQ3A4?=
 =?utf-8?B?M2NMMTUxdUxEVm1MQ0R1M2lQaDNlYlUxK250aEtuRmJMSHZrS3c2RW1jVkor?=
 =?utf-8?B?YnFsTXMyeUZ6WFRwSnVBaEp4YVV2ZzJWNG5nK2JrNUhhakhXUHVCUEd5dU13?=
 =?utf-8?B?RUFBTVJtT29lclZPSHNoVS9BNG9raVZEcDYwR1dXM3lYUldwbUs1SUhoeGdQ?=
 =?utf-8?B?d254a2RSdm5ZeWZ5MERteHlJNHlLc1NRQjQ4OW12K282UzhTLzVaTHg2YXVa?=
 =?utf-8?B?clBwdGw0N3JtNVBuNHBYVitqQWN2UW9aS3k2Uy9TeE1wRmRoa1g4a0JJcTQ0?=
 =?utf-8?B?NHpYQWFTWkx6SnNrdkhLTjBCbjZlcFFuTko2Wk1MdDgrZ3h5NEZJelR6Uys2?=
 =?utf-8?B?Q2VuUkI1UjAvd1NCellrbm9xQmx5emxzZXR5UjdxQ3JtcTVhaUpvRmpsOUVt?=
 =?utf-8?B?YldiNFdMRVFkZkcwMDdYMXhWQm9HaXdlT3EzNGFaQVp0NDI2bmdQTko5OVRZ?=
 =?utf-8?B?THU3OG1MVVpWeWhETDFNYloxZTlxU2FLTlkvMm5YVGVlR0R6aXp5UW9qMDdI?=
 =?utf-8?B?M3pHb0ZkT0FrZmVHaGVQQVl4Q1U1dDdOTkhDb1BNek90M2lPRlM3WlpVR2Rk?=
 =?utf-8?B?WTBoeFJ0TWpVSXZ4U1RROTNzUTltc3pzZ2t5c21hcVg5ZENKSWtCVS9JOUJ0?=
 =?utf-8?B?QzF3WlUwSHdTTTVsZG9kNFFERDBKNVlkTGtuZkFoYis2UWk0RndybU5VTk1X?=
 =?utf-8?B?NWY2dzF4VmpQNGdIdEZOUGk3QnBzVlFQTno4QzhpKzFSSE15c21qdGhGTjNP?=
 =?utf-8?B?TU9tQm5ZOUU1RmduWEQ5OVA2MElUbHpEYVFCY25WcEtFUVhWQVZ6bGxzZkFv?=
 =?utf-8?B?eWoxWWxCVXBMaGUwOWJmZklVL2VvZTVnU0lPbmRiYW5BeXg3OXBldGNjYTRo?=
 =?utf-8?B?alkzRStyWTRZMHk1bkhxL2JiQ0xSUm1sbEF1SWVYNzFxc2k4ZVJCZzlwdmlD?=
 =?utf-8?B?cU5zdnU4cy9CdGdXWVROYXVGamV2UncvV3Rob1NBTzU2Y0hnU0M4aVZVSHd5?=
 =?utf-8?B?QVBPdmZ3SEpXNWZjdGJ0aXpNUjY4Tkppc2t1M2V5MTRQK1had2pBZkpjaTdl?=
 =?utf-8?B?WDZVVnc2biszZk5OaGpCMktvQXh4dDlqVzVJNFFYVUIxTmtVbFhuOVhacXZl?=
 =?utf-8?B?aEY3MmcvanJJRkdSSmJIb0hWRGQwdHRvYWNxRFpuK1dQcFZtZUd1ZzFFLy9p?=
 =?utf-8?B?eTBBVlQ2WEtBSkw5TWI2ZlZaN05WbkM2SXhocFl6ZjZYeHMyTiszTU1yenZJ?=
 =?utf-8?B?WHBQSnNnSGh2bmswaElKYVpJMnp5OUVUYUFMaVdQY3o1WTJ6RHI4UFFtVFdV?=
 =?utf-8?B?N294b1NDNkxsdk53cnpqUy84S3doMDNtWjBQQ1VKWWJKdGMrMitwWnNCbk1p?=
 =?utf-8?B?U29EaTBaclRrR3JBSk1hSDJvZDdCb1pCaHV3bEdzb1IxVjJSak93bEN1Yi8y?=
 =?utf-8?B?QWFvd3RDd2tmWHc0VVdoY2dMWnlKYmc0UUlScUxZRmdTa3I4V21ISStHZVR4?=
 =?utf-8?Q?wTWF9BAO6Po5NhzSvLXEmBrfBzrm9SfRpzSHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXBSczkvZ3BJM3NCaHhPTEhKZU42V0llempCdlZxTDJWcFIraERvV2p5bFVn?=
 =?utf-8?B?a1ZIMURDK0VoVDJ4b0IrWjgzS3I3L0tBUmtvQ2hCZnlHcVZ5SXVFaDFsazVt?=
 =?utf-8?B?ek9ZMGZzeC83dlRZUTJiV2ovWGV2Q1JQZVkxajlBby9RL3RaUUE2NjAwSGNN?=
 =?utf-8?B?Rndwd0VqZmkzenlwN3VzOXE5MWZJTjNHemVyUHFUeUZxMUsyWmNaRklzMm01?=
 =?utf-8?B?K3ZEaHdjR0VNYXdUTUcxR2dpUTFQb3U3OURHV1Y3QzAyYXQyYnovVy9iV2RN?=
 =?utf-8?B?NDZKSkxJVGtjN09QckgrblY2eFBHL0FpM3M2WWxaTjdOMHN2Y2F4ZWZnQWtK?=
 =?utf-8?B?dkVqV0E5NnRvSHNRR3J1eWJDWitscU85QVlFM0JhbUoxWHJBams1d2I4YXFy?=
 =?utf-8?B?TlhCeGRJYkFOV01IZzZXUUZJR2hCZmhSMXVzZ0pPcVZJVllPdFlKRUhiSEJQ?=
 =?utf-8?B?WmVQU1RUQk10Rms5blUvTzJmdnM4MkF6SEErajhkYWYvaVZyQU9qd3ZGbmtG?=
 =?utf-8?B?ZmdXYWxvd01lT00rdC85engxeE1hNnRrVlRXWHYyM0JQaHBOb2xvNXNSOFE2?=
 =?utf-8?B?dmVYaHJyOCtlT3ladmJxUmNFeTZRUkZWUHdqbk1KaTFaMlNLcXhKanowTkxC?=
 =?utf-8?B?WHhHUzdRQXp0OU5XUkFuZlhuMVdpbUJLdDZzYkJFdWk3QVpyQXVDRU5aVk0y?=
 =?utf-8?B?UVpnVUNDUHlmQlpvNzFRQy91YUhPWlhNQmRMRXZFL3lPLzlSVjNDUElsVVZW?=
 =?utf-8?B?U3h1UWpKNG1QV0p5UWFOcXF4SlpJYWNpTXVZTHB1YnU2VHlkTVhTcUtuTjBW?=
 =?utf-8?B?UFNLaU9FVTBKcVg4U3k3aHhEZEkxbll6M1NHcjJwWlArL2daK1oxNUNJS1Bv?=
 =?utf-8?B?MGFzOHlpSU53a0d5UHZZU0JuQ3hIc1d3Wk1FdEh2b0ZxZEtTbFc2clQ4YkZx?=
 =?utf-8?B?QjVFZDFiZmREL1VXalBnckJNdENDYmVwZS9ZQUNiUGxCQTJCQUJETTh0ZXJD?=
 =?utf-8?B?MVQxejBKOFFBRUlMWmw3WkV4RllCYWRLY0pyU2tBa1hvRGhBNjdXK2VuWnNs?=
 =?utf-8?B?WnRORXJoeVFlK0pJVC9aYmpvZENtd2Y5MThVWEc1R3JxbjIwcWJDSXN3NlN5?=
 =?utf-8?B?d0xTazZPUEo4b3poNGRYYmJaa2hqd1JvWXh1NmV1QkY0d3NMZVFjM2FsRGMy?=
 =?utf-8?B?WmZYeDM5czdBNFhSR2dGRTlHRnk2ZzB2THo4Qjk4TUpMUGlJM2h2amg1NlBk?=
 =?utf-8?B?SDRSL2F6WnJCSzJVa2dleWt6aXc4YWRCZzJRc051ZjRzdUxERTNYYldUSWFi?=
 =?utf-8?B?cXU1L1VwYzJ4a3pKcHRsMUttSUpwVlExVU9YQ2FnZlhaSVpZVlFYaHI1MXl4?=
 =?utf-8?B?bVJ6Z04wU0IwMUpzMDhtQkF6bjBDNG1yYUQ5eXliYXg3ZE54eGxUWWFtTFRS?=
 =?utf-8?B?U3FHT0dqb0tXdDJzU0svb3dTVmZXSE1ONjgzZDBUNDZPQThYcXQrL3hIbWlG?=
 =?utf-8?B?WnU2Nm04T0ZIREtBVnFDNUNMd2JEWWFxOGkyc21xZllBYW9QSmxHLy9IeFRl?=
 =?utf-8?B?WXQ1cE1IaHNKKzc5NFF4QTZTZkpNL3ovN0Z6NDIvMDdoc21GZndsVlpMRHJV?=
 =?utf-8?B?ZFJmZ2lXSmtINnpIOEtuNUFrSkpzR1ZKMFQ4emNSQmxVN1R5aHcvSnJHeHgz?=
 =?utf-8?B?WDdMT3F4YS9nSE9OeVZYZmJKTFpzcmVwMmZaN3F4dW5YUVI0MFRhZElHdVg3?=
 =?utf-8?B?c24yS3VaODRPOFEraUdWZGovRDlSbGF6MitVMnZMRzBuMHAyc3JLTWM3eDhD?=
 =?utf-8?B?UWk0T1llME1QeDVhRnB1VTNUYTJGdmhVWGRoNUp6d1hqOVNZazkyRmZHM0gw?=
 =?utf-8?B?bnhDRzZzcUVSOGpWTEFBWnlaZzUrU0lhT08vVmQyOE5TVGlZVVRxb2lQTHhk?=
 =?utf-8?B?R3dHQW9vSVh4NWx2Z3JTekFkTlBoayttQk0ya3J4OVlwQ0FMWHc4RW1QLzNy?=
 =?utf-8?B?QnhYU3lGY2g3cHd1eU1BRzA1VVBwVEx6M25kb2w3bDlIck1tMVoydnZScXZE?=
 =?utf-8?B?QnRoVGU1a2x0alNROVJvM2NYYkpoTnBqV1h1YXM1ZXVUblp4Z3FpVElwdzRW?=
 =?utf-8?Q?VWDDTs7drznjxRKvCb1Hj8ylC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e665480-5eb4-4375-39ec-08dc69dd3f8a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:50:15.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkHfKCLsyqDxegbPuqxBxgVbu73I8PVYwC7CDQNooBActqbhc11Njlm8wnVrI5roh5OyAWqtvP41o5HfZmQ6aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/spear/pinctrl-spear.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index b8caaa5a2d4e..a8c5fe973cd4 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -151,24 +151,19 @@ static int spear_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 					unsigned *num_maps)
 {
 	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
-	struct device_node *np;
 	struct property *prop;
 	const char *function, *group;
 	int ret, index = 0, count = 0;
 
 	/* calculate number of maps required */
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = of_property_read_string(np, "st,function", &function);
-		if (ret < 0) {
-			of_node_put(np);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = of_property_count_strings(np, "st,pins");
-		if (ret < 0) {
-			of_node_put(np);
+		if (ret < 0)
 			return ret;
-		}
 
 		count += ret;
 	}
@@ -182,7 +177,7 @@ static int spear_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	if (!*map)
 		return -ENOMEM;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		of_property_read_string(np, "st,function", &function);
 		of_property_for_each_string(np, "st,pins", prop, group) {
 			(*map)[index].type = PIN_MAP_TYPE_MUX_GROUP;

-- 
2.37.1


