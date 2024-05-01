Return-Path: <linux-kernel+bounces-165269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE218B8A49
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEB0B21CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6BF5337D;
	Wed,  1 May 2024 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="avzeKvSq"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C922313;
	Wed,  1 May 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567726; cv=fail; b=NSxc9AswQVno6u/cMnlmH1pS3AJPftiRNfpBdwGGXu1MKpDIHFxS6O0ztytxNE3HVgLc64uq2z/M1jP8mDfjjKz7f3P0AwFKfQWt3fw8X4kaFSeApSBvCXZhc7KCvX6cUSAol7F3iJOZhhoNlNx/YnSKd5pqeWDmbUo52/gUVH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567726; c=relaxed/simple;
	bh=5oFMJzgmGVyaM4GqlYVEDeihtJKIKmnMO+5W0gXfuq0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FiHQe5Cop/XDx5O7igQn4NYjiAc72VyiDTSwX1IXLhYu0IyP8AyuD9icFxub85/XggFxa6mURif+Yd7GFFy8xgTozcAmsAL1mBARe0HSu0DSYMFj8lMgEEHXzpBwEI8jPGdNTDckLXoTDjH7RcDT/1tdVyx2NARqsUrMhU4GeX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=avzeKvSq; arc=fail smtp.client-ip=40.107.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtGqZBS8teDf5x3JRMuyIEblZMUrEOuJmfQMDOrmWCiaMEHwmJx6SDzE2IkbdtpsRjRgUFyGUJ7obl+6lA2ByW6eOwSugT1uD7AzbTBm71claRG/5uPeq5i0/buTwnKGN0mb+ZXRGEAjM5nvYZGGAjMQSX0ecSWZRav6AvayK0rLYQUWTTHuJCdvK74YQmwVjk4TqH9iP2XNFWPW8qa7w/9MqNU2OS4FHif8XqPz8FGfIGD8wZDsir9X/x1DPQLJGKNr2YdCQghJHqAeVXdWrY3NP1Rqj5I5vajmm9QhOS+L/WMCNnjoleW+bUTUSjp4d8DeSkP8piDmFJ8XH7bOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqwszMK70eQVJEA6pKKjpRuI8VkEgByRm8NicNvuM8U=;
 b=jIF5zYFLfv4k+Ai4BLO+LbHzQhW6gxxMjwhEvjGyAgvljoPw0bzqFq/iiADMHLK4jsJXB8R4uxO8wkPQQnRgAywEDB65StlIBxnXJiaYZ864r28x5VGKD2VOJ4qzksNNGwcRXSS9gr+xbJLJqdSYcbRKmcpdBiDfwo6PXkGvd9jxMkuCD0Hlx8ig9ItEq2ExLbbVqIVWM0ULlWlqQRRSLvfix8dEyUtiaV8HcUHMFFa/yrTCBccbNYXllTqT24TURzkbXh18YCUQXbNkKy9m4JSg2WsVf+pFp/VvUoIoOgba/W8v3faUwG/qapcZNS1VQIoMe9pS1An8x4XWKVYPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqwszMK70eQVJEA6pKKjpRuI8VkEgByRm8NicNvuM8U=;
 b=avzeKvSq4PewiI3jQVyUnNS8LbfkC+8WIhgG86jlQtI2C/xzP1qJwY8L2eqsK9cpfGKPicUA9/z0h6CY2VjQBPf10WP2AOYPRK855LWPn1ckp+OETvELl7E7KSKM0eGTCleUahuTQnaYodX6rkPbMm6ET+i9ZnqvwhihZFQdF3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 12:48:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:48:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:55:59 +0800
Subject: [PATCH 01/21] pinctrl: ti: iodelay: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-1-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=2618;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pkkGggwje14Z0jtlI2/3mY9oSznaGYtjsjUTP2Epebs=;
 b=8nSRZH4j9ElQUUnrxRoZB0IvYaXm+wYHSYfUTORvK0TtdfiFHDiT/ysKV1+rzrNSC18t/cZBF
 RPqvUMxjmGSC+wCW1TMY2LOwrVvVWQ57ebWbTQL39dBLQuE2mlMTYN7
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: e10ed49f-d70e-4910-e729-08dc69dd05b4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFpuclE4UXJsNCs5T3JPV3VkU3VPa1dhMFF3SXhtbjhmVm5XV3NuczVwSlQz?=
 =?utf-8?B?NWpJbEphZnBxL3g3T3FrcTlXakhzK01hZFM5TzV4WjY1OUJvVldvUEZtZ2VT?=
 =?utf-8?B?VnBxRnRwSG12ZHNkOURXQ2UwYld5YXNUWHRPMitLRHh4eVJUYlpKcW1KcnhM?=
 =?utf-8?B?SHA0RENWTjR4NHhwQ1dyQStpRmNIUUZEZkVOYVdzQUdQYWdZT0lBOS9FU1pM?=
 =?utf-8?B?UkFGeHIrdWVEMmIxa1VQVzBRRzlpclRGbFl0VnQ0cHN2YXUrSUJCWStUVnln?=
 =?utf-8?B?dERyR3Z0TFY1NVNuNHdyYU1hdmNwRHRxMTFTZUtDT0lnRWc5Y2k5MkNueENm?=
 =?utf-8?B?Rmw0YXdub0tJU2R5dlRxY0xsU3diZ1FuSWJMaTU2cmQ2cElpV09IYW1zU1Yx?=
 =?utf-8?B?a2pzK2VCaDRmR0R4UWs5M0pTUlFBRmVXTW0xSjJYRjZ1L0dwOXNhNUxTSVdR?=
 =?utf-8?B?ZjVmbkFVd1BBSE5OOWVjM2hSQUxTd3VoS1NLeEZmWXkrb3VLbGx1VGgrZ01Q?=
 =?utf-8?B?NGR0bi9kd2VudmJ2QkFoa0s3V3loajZySHNobHY1RWNrRlZOVHR5Um9zT0NH?=
 =?utf-8?B?TG9uMlVYRkpMK3cxeGlWaVdpYklmMEdKVFY0WDZBMFN2Tm5vZDJUc3NWZ1Vm?=
 =?utf-8?B?UmhNYWhORDFsdzBGR2NUU01pS05yUUswUXpmTjh3VmpMK1pkZ1JQQUY1aWZs?=
 =?utf-8?B?VDFuODFoemJBZzM3czZrb3c4eTRZUUJSSVBzNG5XSHVBeFVvZUxOVGlqZ0F0?=
 =?utf-8?B?U2tVMnBjMk5ML3d4Tit2QUdoeXR3ZDRpbkJONk85ZGErUENQRmMvZDBvbW11?=
 =?utf-8?B?dkJjVG9PeXpYWDBDMk1sM3E1N1pjVHQzd1E1YnhWRkUzeDVyWHNLL1NWZ3RX?=
 =?utf-8?B?TjVtTUNjenlIdzc2b094cWlHZGFyVFZ5V1BodUhveUh5ZWlUV05DK3lYOEhC?=
 =?utf-8?B?VmlmK2xOaFk3UmVtUXEvR3Y5eXRlZFJFN0lOMmZWNktxL1VPWFRYa08vamNZ?=
 =?utf-8?B?OHRPOUY5NHdVTXlHNEpBVHp3WmllaEs3b3FHNEg1RERINEdFc0VENjl4VW91?=
 =?utf-8?B?TDJFM2tHeEl2eVByeC9PYWNJYWpzWGlVOERxdTl2Q09oejEvQTFLRVNIYUZZ?=
 =?utf-8?B?WlRwRTZjUnB3cHpucWFQckZxRTh1ek42RXJVcUNtbk8za3hkbXBobEFIaEVh?=
 =?utf-8?B?SVNzazE1MkU4YXVucEk0dzdtSm0yalFCN0RXL1V5aHdWMXdQZlNjM1dzOHRO?=
 =?utf-8?B?SVY5VXE0b011TTBoejZUSU9ldUl4V2NWdGU1RWhMTW1YL0RYNVlJZHM0T0VE?=
 =?utf-8?B?eU5yeFhzcmJieU5iS2lYeUxZcFR4RVliaTdETG9jbzB4YmNqMjR0SVE3Smcy?=
 =?utf-8?B?MnV0VHRiV3BsKzdleGRtOFBsVkNkbGd5UFZiWjVCZGRWdVU0LzYxa3ZaQ3Nk?=
 =?utf-8?B?WFFSd29MWFVsTm4wZWlxeFE0NVJxU25zZW8zOGV0V3hkWHJRTlkyY0h2Umdt?=
 =?utf-8?B?aDQxeUNVbVduNGtWU1ZyeWRoV1hBVjZ0b2NnejlpcnlML05SemVDVElCS1J5?=
 =?utf-8?B?Y2NQaWRobWFpbGZKYWVzaXZUMHAyQ2FMa1JUR3dmc25CMGNHYWpuY2owZjVJ?=
 =?utf-8?B?MDdneC9ST0o0cUV6YmZwVTBYMHgrVkp6UnNXeE5xK0wyWFZzRTZ0bWt6ZGpm?=
 =?utf-8?B?NVFEazNkZThlSjN0aS9lelpibVluamQ4YnFxQjh5TGxWWUtKdE1TTlZCZU9m?=
 =?utf-8?B?RTVOTVNzVUY5bUlYQjROa3d1TE1FeDE0S2N3c050Q1F2V1VVWDIzSkt4bkxo?=
 =?utf-8?Q?O+5P0s4wq9qrrLyEw2U8Jxxhqd7UykdzmOJGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGdBMzNjMGtYMklvSlpEYUxMREVrVlVWRCtrSEtaN1FCRGtEdEpmYUlhSngy?=
 =?utf-8?B?UDJYeTNpRCtzUXZSMjFpL3BhVWh3Zm9raW1GMlJLWEhWWVY3Q3czc1hPejNM?=
 =?utf-8?B?aGE4VHlvVnFldkNEVFRRN1F4c3RKV3NyZHdLL1ZxMTVPbkYxVXNKenVEZVBy?=
 =?utf-8?B?WElSUitxVGN4VktYYVdBSEtNRHVYUGp5RTRtbWw4eHFJWlp4SGxiRitzbmlQ?=
 =?utf-8?B?SDVZamd0eTc2dHhxanF3SzlmMllzN2QwWjQ1M3FIZlMyYzdRZDRWNHRKOTJV?=
 =?utf-8?B?SWFnSWVjM1BnelgyQVRSQ1p2aVpTVmhTQlE3WmVSOWRKSFY4cGlwUzhLTEdi?=
 =?utf-8?B?U1RkcXplOTVyMVJ6TldObThoWFlLMmhueFd3dXdBQldvNnFVWEY0K2RiUGNJ?=
 =?utf-8?B?UHRyQXhhRlNKZWl4RE05U0VORHpJYXJMOGFZZGRDOWFkNURKNVZuaXJ5Q2ww?=
 =?utf-8?B?c1llSGVDYlRwc2ozNjJ5SmU1NllwM1l6OUg2SUgrUlA2ZWlMZDV6YlRvODE5?=
 =?utf-8?B?cG1oRG1XZHowZXdPVEppK254QjRxa3d3NnNhVk83aEVpeUw4UjZ2V2F0TUl6?=
 =?utf-8?B?aGhlWk9neTVIYitsNU1nSXdLUFlsTFF4Mi9wN3gwRlFuQStFWGVxVEdUQmU0?=
 =?utf-8?B?bm0xemgvY3ZZaFBIMVI1d3BZMnpmek5nU1ZJMDFjYWxjMXNrOWRCUkwrUTJ0?=
 =?utf-8?B?TFJnRnZWV2RRL3I0NnlJd0c2eVpyS09MUG9tOWl0bkMvb1NFSStOSXhIcFhy?=
 =?utf-8?B?VENVaHFlQThUNm9sK0VVVDEvbHpoSGs3Y0t6RjRXRGNDOG9SbXVycnhabVVE?=
 =?utf-8?B?cDMyc3VvMjFhaFBudlcvM0gxeW9qbHVGVTNNWmZvQUF4ZWtDSUFuQ1l2d3Q4?=
 =?utf-8?B?akhycVFaMzRiWVNaYWRZRUc0NVBiQ1cvVU00cDdSL1BHak5GVnBndUhRZjAx?=
 =?utf-8?B?MmZkRDJQSksvMk5jOGoyOHVIcUlxVCtWNDI0NzliRHk1Vnl3NjBuMk5haVNZ?=
 =?utf-8?B?VFQ4Q0dhdDlkNEhVMzNUVTlkQ0J2SUJvR1cvcEdXcEtBQy9FWUsrWFE0MVQr?=
 =?utf-8?B?UXFzS0RvK0k3c0xpVVNvemlXNGtpY3VoWDcxV0g1b2RKcSsraUNnZ2VrOUZ4?=
 =?utf-8?B?SlJEQjlocGcvNUJoYTU3NGNHN1ZQang3Rk9reVp2dHlSOTltVkRkZWg3N3I2?=
 =?utf-8?B?bklHQ0JURFFJeUwyUmNlejYrVldpTSt3NS9COGR0RTlmaCtQd1hReGdIOGlw?=
 =?utf-8?B?ZFFsRUNWdndsZ0RwMEZwcjNyb3RzWUFMM0RqWFh2cGRxSXdDZWhjOENYQzls?=
 =?utf-8?B?Y0xBdFRDTjdmdFFJWFdhTXVnQ2NseXNxUm5COVlYL0FJKzVLNUNiLzNPTXFy?=
 =?utf-8?B?VFhWV3NrTVZRb04ydWQzZTNQa0FkeXlWZ3l3N0xleUJ0REpQQSswb2crN2JI?=
 =?utf-8?B?ZWJRbmJleEVSQStjUWl4WlpwaGh4Nm9lS1VFMFp5cFRaWDlhR3MwZDFXQk52?=
 =?utf-8?B?L3V6a0FWOFRHc0FSRDhPdTIvSGtBeW94RE1HZS9taVBabkN5cnFPTFIvaENz?=
 =?utf-8?B?SDNUbUVXWXYwdmh2Q2JRZ2dUR2V2eGM1WHZHNE9mSjRVQkVZc0tsVVdHQlVj?=
 =?utf-8?B?c2RpV2NoRnZEelh5SlVlRmdWZnY1RmRBeU5Hcy9KMjJCeHJwQWw2elJkZDlu?=
 =?utf-8?B?STV6eU5xcEN1Mnl6QmNyeVJ4V0tpazFKbDhkK2F2SFArYkRHZ2xPRjJYK2gy?=
 =?utf-8?B?UFZsUmhNeDJOcTdTc1V2b1dtZTFndDJoRU9jdk81a3VmdlhUeGQ3K1g5TW5G?=
 =?utf-8?B?WDIrRTdsNmNUQU9UOXNnTUk3TDVTTEtDc3c3d3JjWGFjeWlqQXlsUzhrNEEv?=
 =?utf-8?B?V3ZGSG1HT25PRUw5RStzNy9rSk5ON2VCMEZKSlZtb2F3VmQ1bTFxczVYWnNW?=
 =?utf-8?B?aFRjUDllSmVQbjd1U2p4S0VoUXdCbkVveDR6Ykg0bEtYU01zUlVHc1RGVUor?=
 =?utf-8?B?N1M2bUs2U1hCekJPQ0ZpQVZhbGx2cjQrWks4QTZLL0RyejdjYXMzS3NrZW9L?=
 =?utf-8?B?UStmdFFCOERTVEZ6bFZOWGEzQlJERDdYbzdESWxTSFVuMFA5SmZVYkl5QU9C?=
 =?utf-8?Q?dT+WLBIANIHa6Wnmm4bUb6exE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10ed49f-d70e-4910-e729-08dc69dd05b4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:48:38.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwPttC3uQZkaHlw2TbVQNdOen4gRwAJVis6AnSuWi9l3s9tg3ZEut0bJPfwIMBQ0BaFcpI3O3vG3HMTcJVR7yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c | 37 +++++++++++++--------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index 040f2c46a868..1032bc9c36aa 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -822,53 +822,48 @@ MODULE_DEVICE_TABLE(of, ti_iodelay_of_match);
 static int ti_iodelay_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = of_node_get(dev->of_node);
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
 	struct resource *res;
 	struct ti_iodelay_device *iod;
-	int ret = 0;
+	int ret;
 
 	if (!np) {
-		ret = -EINVAL;
 		dev_err(dev, "No OF node\n");
-		goto exit_out;
+		return -EINVAL;
 	}
 
 	iod = devm_kzalloc(dev, sizeof(*iod), GFP_KERNEL);
-	if (!iod) {
-		ret = -ENOMEM;
-		goto exit_out;
-	}
+	if (!iod)
+		return -ENOMEM;
+
 	iod->dev = dev;
 	iod->reg_data = device_get_match_data(dev);
 	if (!iod->reg_data) {
-		ret = -EINVAL;
 		dev_err(dev, "No DATA match\n");
-		goto exit_out;
+		return -EINVAL;
 	}
 
 	/* So far We can assume there is only 1 bank of registers */
 	iod->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(iod->reg_base)) {
-		ret = PTR_ERR(iod->reg_base);
-		goto exit_out;
-	}
+	if (IS_ERR(iod->reg_base))
+		return PTR_ERR(iod->reg_base);
+
 	iod->phys_base = res->start;
 
 	iod->regmap = devm_regmap_init_mmio(dev, iod->reg_base,
 					    iod->reg_data->regmap_config);
 	if (IS_ERR(iod->regmap)) {
 		dev_err(dev, "Regmap MMIO init failed.\n");
-		ret = PTR_ERR(iod->regmap);
-		goto exit_out;
+		return PTR_ERR(iod->regmap);
 	}
 
 	ret = ti_iodelay_pinconf_init_dev(iod);
 	if (ret)
-		goto exit_out;
+		return ret;
 
 	ret = ti_iodelay_alloc_pins(dev, iod, res->start);
 	if (ret)
-		goto exit_out;
+		return ret;
 
 	iod->desc.pctlops = &ti_iodelay_pinctrl_ops;
 	/* no pinmux ops - we are pinconf */
@@ -879,16 +874,12 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 	ret = pinctrl_register_and_init(&iod->desc, dev, iod, &iod->pctl);
 	if (ret) {
 		dev_err(dev, "Failed to register pinctrl\n");
-		goto exit_out;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, iod);
 
 	return pinctrl_enable(iod->pctl);
-
-exit_out:
-	of_node_put(np);
-	return ret;
 }
 
 /**

-- 
2.37.1


