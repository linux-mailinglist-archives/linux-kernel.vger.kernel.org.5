Return-Path: <linux-kernel+bounces-165282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96A8B8A94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975F6286C60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5211DFF0;
	Wed,  1 May 2024 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MdQSrfNQ"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38588627A;
	Wed,  1 May 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567917; cv=fail; b=Jqixu+weRrWhcJkMI9XUCUcCN2ivZsl0H6+sorFNKu017XzebCxoC4p3X0RPM2xDzR7IUA3L431d+BI1FkyXoEyXDUwrudtr4mOO3Vr0nwyJKVghE/D/6FEtr9BlhrKLud2gcR0a8/3vpa4YRYRUsuV0ayKprBuadrNlW4NwECw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567917; c=relaxed/simple;
	bh=E6ik9M6/qhOWxdXMSi5wfgwa6MozB3Zte/4KB5unPbM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gSN+PmW6aBIAQdLNdsODjLA8MfCHZ8IPGMqOsPB/LOInznJ6F7LblkZbI3vFMr94EeOAZ+tnKpxSlcMc/U8bMNLZP/d/6ShhH2cu9Cpb3guLR8VX+TWszmjtRKmtcA9lubPhDG7fPnwPp/l94CEzYhqF0svYqkIe4d2iA8Soxps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MdQSrfNQ; arc=fail smtp.client-ip=40.107.13.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw5DDCtv7NZU3tK78HqPTOg3osCjCcgpGtQyoc5BjkZuBtztM1Vpw/WJu5QEDY4OXrEcsf/m3quDk9+9KtpW0iR+klqQB+7vHUVX4Ih5tbS4gRBARYFjEbFqr3c+5aA2x2Vz1V5alZcatqFLjaD7K6B6H06z0MfkKLaK3XPlDElMxkQmGDNiidtqkbuLOipr0ImlsdnEjPg4qYkqoCk1TPTqdkig7Vdh2f2sd1rg9U0f4Q2J9A0Fct8BqGaoMhF1rqFq6q+g6DD3zFStJM6nPylspzMgANwgU6iAP7hKlS6tOkp9MxsZChlcEA/O5T01+PjGpfZ1y7mQY7QsAmwh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKzscdFMbKHIkbo5TBU/zyPoN0zmGs6d6fVNhcTfxjo=;
 b=Lfgfo1eRxEbatyER+bmKgMu/dCsVHLw8K6gcs7ETBz471Kr51+W50R6pohvyBMwy0bKFG6g9Q+5/gFhpdoXoF/9nu+Q0Ta4JRA4Lss/kzqW2e8TXreaLEnIWduS+wAhcWl3U4133R9EaCVHLVmek0hbNphYvbyEvZ6aSJiTI6L9RWZoJKm+RnDVqjtmJ4kUVFFGsr+5NalFTfLs5JeFhz5yQkWxWatc6sHtYzpbaDQfYP5hs/F4dqNuqKofaZMXbhll8rJ4bvHMegPBHn7lgKKn2FHJfXya7xfoaW7yPDT6V5EvIgIEwAMnuFAmU+119+879wg67xXVEC/MNhSGtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKzscdFMbKHIkbo5TBU/zyPoN0zmGs6d6fVNhcTfxjo=;
 b=MdQSrfNQLjF5mR8tb1GBjL2yNGByTmi3tyWpA1AZM+gT978FSATk9tOjVPM4dFIVVff/z+XBLuf3GC55RgiPSApG/kLqbTj6iKeaf1N92FLF+iU6AJm4CeG1JR+dzJ+VlmWZ3zSIY7jdGM+o5zt3kkDomYegwJizAyqqhdf4Xy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:51:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:51:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:11 +0800
Subject: [PATCH 13/21] pinctrl: equilibrium: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-13-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=3196;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=HA5FdeU3k8hXGIzvGdYVmDetKxvVIH+CQmWTQZMAMaY=;
 b=lfIj3/spF8jGcz47ZvLuHp/k/UAG8bMzvdE82ONJ/bR1g1sJUKqcbZhnpbj2LhbltExEhtYGn
 fwAWX4c8JfCCz2+JBRdYekK/IHu0QInM17+/HxBCQRu/jEpaYiPq74r
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
X-MS-Office365-Filtering-Correlation-Id: 92041057-bc4b-46e9-af55-08dc69dd7975
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmdpU0FheVdkQlhWU2sxNEhEL2tDN3pSaS9hRkZ1ZktuSE5PMzVLMml0dWt3?=
 =?utf-8?B?bzJ1Qk5MWWx5clk2MlFUOVp2ZnRYS2dXSk93YWtHN3RPL0tQS3dsOFhtWTlv?=
 =?utf-8?B?QWVpNXhRdnJCRFBZajBiWFRWdEdweEtZU1hHVlIxVDZHWmZlUldzTWJNQ1Qw?=
 =?utf-8?B?eFBrTHZGR3ZpYzNKaVU2Q2l4ZFdrN1BrbGlWMlVEcUpxM20wTGQxSHBZNVZC?=
 =?utf-8?B?ZVFBZTBTanMwYVVPZE5NcmFheXhTT3RET1NzSGlYOHZUK0xXOWVLUjlCSk15?=
 =?utf-8?B?T2lIZjhFSjFTaUp2Q3JBZ1kwMkRaMFJxbUlqK0MwOFl4eW5KYXg2ZlpmVjMy?=
 =?utf-8?B?MDIxcGRVMHYxY0JpY3FYeHlDWTZjaTRUWktod1dUMHpKbGJuTUthQ2wzdDZB?=
 =?utf-8?B?WEoxcmlEVlhPSlVYV284UyttUmdMWFBEVGlaaTZFZE1DUytkUjVHNEJoQUdx?=
 =?utf-8?B?MS9NRGJ6aWhmWmNEOWVZQVZVdGV5UEFucHNWVEFHSDRvWEZmSm50dHlDUWt6?=
 =?utf-8?B?UlR5Q1pqeFRzK1BkUHlFaUNhUnJ2Nk5Yd0NpZitjM1lMcjVIM0VjUGc3SUh4?=
 =?utf-8?B?aUhFd05qWXBqMjJVcFNSL1hyUHdmQkZnU09ac1hIMkxkRjhNSE5tT1ZMWkt2?=
 =?utf-8?B?T0JncDA5Mkp4L1RUZEQrWXhiMHRkdHUvTjJYRHhVdnAzSHpVVklOK3YyOEtY?=
 =?utf-8?B?eCtlT1FTZHhvTzFMRmlCNDEvYnFwREVFYW9QeEM2UmlDQmlQS2xBQy9ZNXJ5?=
 =?utf-8?B?dXgwdmFpQjBBN0REbnNEUDVlTWdISlErV1gvWE9PRmlmZ3pWM3JzUGdobnNJ?=
 =?utf-8?B?a0g0SEhSdUZRZVVVbm9CSm41U1Z2b0JyRlI0Vm1qWndhSUJJMzNTQ1Zab3gw?=
 =?utf-8?B?b0pVVUhmWW5iNzdGMWlsU2xWNkQ3OXBmMytjVUtxQ3d3VGl3WWVtU1VTSHlz?=
 =?utf-8?B?MkVRUlc3ZzVrSVVyN2xDOUhhMGtFbFZ4Wm5qTTQyQTJqR0V0VmpIYUNxY2o4?=
 =?utf-8?B?VFF6aDVCeWhKMWcrQS9sUjJiVjBQZk1MNGhBOXBVLzI5UGhvdERXZjdadTMw?=
 =?utf-8?B?ZDM1NGlrVVhLS0JTeFkvOW9Ub0VoTVhVMWJHdEk3UUdrY0ZmVUtKR3dmdCtE?=
 =?utf-8?B?NkpvV2QrcGpHOEp2Wkc4amVHUUVzZmhxTWZuNzRiRW9pMHFzelVSdzlJQWs4?=
 =?utf-8?B?WXRmQTkvWjROaXNOY2hnMXhmMzlPdWk0LzBIdTdpSHNIUDZnY0RhMHFKV2Vn?=
 =?utf-8?B?eHp1RVl2YVAwVnBpZ1JFVE4wSktMcW56VkluamlEbnloU3Y1NWx6YUNsSTBs?=
 =?utf-8?B?MjNJcE9JM1pNQXVISlBOeUpsTkZkTkpoL2ptS1NkaWZFaWovMjJCaDhzYWRo?=
 =?utf-8?B?bDRQcjBoeVYyTWg0N2d0anpZc3dLcmxURVlGNkx3TGIrenNUYlQvVGxCN2lQ?=
 =?utf-8?B?VXJFdm9sQXBhMEF1K0RvUDl6VjBYSXF1cGFjUUlkd2MrU0xDMTNKNEs1RXgz?=
 =?utf-8?B?cEtKWi9tbld1N2d5TVJ2NkVTajhGZXZ5ZjRxSnFtazNaNGlQbFh1YS8zbzVI?=
 =?utf-8?B?SGlsdzYzWllGUVlNckFwdTBDek5yQVl2WlRZQXMraldqeUQrRklxUHJjREho?=
 =?utf-8?B?d1dZR3ZMelZqZFg5S1FCTDc4WjNZMHRZVkh0c1FWK3dEVUp3dUV0ZC9iNUlp?=
 =?utf-8?B?Ym1QKzMvRlVVU1hrQVhPVXBDL201SFhjbzk2OVd3ZjZyREdMTXNyS21LaGhB?=
 =?utf-8?B?QkNxYU8vYXc1b1FUdGNIeW1GNDBaZGlnYmk3V29rbjVkSDVDNjVJeFdXVGJ1?=
 =?utf-8?Q?ur0KIdS1YpaiotKmkXpNEwAmsJAaFEBaBf2jA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEdjbEpJUG5IQVNQdTk4a1JHbnkvZ1k0c3JpWkFNRG9yWjRjcDk0elN3MnJ0?=
 =?utf-8?B?Mkl3cEpLakpvN3FWdmZYNmNCdE4zd3F0Wm9xdkVXVjRMRDVqbFBaUHpnVVJu?=
 =?utf-8?B?MmI3Q3o3QStlWmxRcEd5OXRXWGlwRHZZVXVLRUNTL1BneThMbDQ2YXc0aXBi?=
 =?utf-8?B?MDhkZDBubm1ISDludHU4eTh3RkVIYWNINnNGbjF1eVNKRkhiajAwdWZSNCtY?=
 =?utf-8?B?TXIzU016NUErYldOaVRlaGt3WnlvVFZMbE9kbVBQeGs0aXY4eVMzYlVnamZF?=
 =?utf-8?B?eWZvdTMrUFlSZCtkbDBqc1h3cGYvWEMrV2Z1TVo2VHJWSm5MSTdwUGw1YU5r?=
 =?utf-8?B?YVlRNW0yM0YrNDdSL21oRjdZTTB6S0NZTlVqTDhjLzM0M1crL3NoY3BmQnJF?=
 =?utf-8?B?V0ViN2Q4ZEk2TGF3blpXWi9vT240Mmp0ekcrSXZhc0RUbnZSL2RyTTFmSjE1?=
 =?utf-8?B?ZVZQb2tJRElPRDZGREVoMklSTDVrSjcyTXRQSEJPU1RKekNoTmJEdExnemoz?=
 =?utf-8?B?OExURUVXOFB3aG1FWFRxSmQ4YjlxWDlETjE2T1U1b3FYSmJvbmpxTTNreGdo?=
 =?utf-8?B?ZzRzUjRaWkZYNDMxd2ZKdG9PSGdUMXRQTGZlcTQwR1IrZDc3KzhOOEoxcGh6?=
 =?utf-8?B?Z29PTW4zU0Q2ZHlDdGo0WUc4UXBJNWJWdW10NVhQK29ET3EySWVjZUd2KzAr?=
 =?utf-8?B?S29tbER6U01GUHZkSDRoZ2tWSWo3YjZCOVpnK2o0VzQrY05icEhCY05qbmdh?=
 =?utf-8?B?RkFWakY3Ylc2L1l3Zk0vWFI5dThBNGZ2amdWVk9ZcUlqV040blZvOE9MUVlP?=
 =?utf-8?B?RHlFK2N3eGlNQjVYSHhIYUZwSUh3bmJzcGFzaHlLYzJ2QmoyRWhTZkQ2aU1v?=
 =?utf-8?B?dTg4eFZQcEdVRC9uMU5SNDhqbGlNeXJVbnI2UUIrdG9UVEpFeEFLUEVNT0ta?=
 =?utf-8?B?QVoxTHlZbVM2eHYrMnI3NmcxWWNvUFNFMTRENlpUdlBsai94eWNzazR0bDll?=
 =?utf-8?B?djZjanU1U2JVVzlnd3lTVWVnTm5VMmh3OW9XY2M3OUMrWkNYR0FmTDVvT3dx?=
 =?utf-8?B?S21VeEN2WFFxR0EyblZST0NKc3FsdjdYSjYzMlpDQ1RUL2k2UmVqS1JEeXNC?=
 =?utf-8?B?cGZJSjdmc3U3OXRtSWNBSEZ6L2pSYUpmbWUrQnNLbXliM3Jja0YvTmZRbDNU?=
 =?utf-8?B?L1R5ZWlHN21TOWxDaTBrejFvSzQ3K0FTMGtaa281REJSbHJReGtGQnhvb1A2?=
 =?utf-8?B?S3p4OVhKQ2dhdHRTSi81cVFpMlhPaThibVhXekhMb2VPa0IrdkdPSytOdGp0?=
 =?utf-8?B?ZytZWXJ3cXA1bVNaVkR1Tk9GKytTS2VGb0c5MlVZMnJsdWhwSUlPaGNIYVMy?=
 =?utf-8?B?MEtEUXozK2pXMHVsTUZpemRlb05ZNGxDRmcwNUVWYUQzSmVJbTh2RHdvUnZI?=
 =?utf-8?B?dW5KRXFZVlNNcXBwejUwZmg1MXNNUmg2dzRHM3FrSjVLcnFwWk5IV1ZtREVp?=
 =?utf-8?B?RjZwcnNhYkwrTzk5dG1NQUJPb2FWZ3dKWW44NUh5WXFNNmM2WWg1djRTSlIv?=
 =?utf-8?B?Ty9BNGNRTkdEMkFMMFZ0VituajVERDFGaTFad09VT2FnZ3hkVDl5QTZON1Fm?=
 =?utf-8?B?a09nZXFjNDVQNHN3ZldsWTg2amFlckI2UzZmaHJGbmhxUXlxNEpsTlRDWStp?=
 =?utf-8?B?d044cVlnb3JhREhBYVMyY3RhdkpjRHIyNHJoTXJsVHMzOGN2MUFpOU1QdnZs?=
 =?utf-8?B?NEx2NkZ1RFFSa2JyU0hpWDJKSHFIZUp2K2R1VHpGQXJJcm0zMVZyT3lxRjhl?=
 =?utf-8?B?azBhdUVLbnlIQmRRUHdyTCtNNS9YNk1pTFVMMGZSMEJCS0hyNHMyYzFmekxl?=
 =?utf-8?B?REhxa0hXK3E2K1lNdDF6N29PbmRiNUlRNVY2WFAwck5Sb2tVRVk0clhzK1p1?=
 =?utf-8?B?bXpQZFAyWWxzdnA5UjNkRDNXTnZja1dOSEdsZ1Nkd2pXSHRNY04rZURhUU5W?=
 =?utf-8?B?eTZMbW5uc3JFNHFmTFRPNUYyMlZBKzhpMkIvS0RxL1dUcGszSWNzTjFzZmJO?=
 =?utf-8?B?aUc1Umg2Q2t3NTRWUXpXcHhjdTN1d1FyRzIrd3o4NVVaUXU0elA0dS9xVk5O?=
 =?utf-8?Q?VMxQ2D+aDaIiGIva+Q3BV5per?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92041057-bc4b-46e9-af55-08dc69dd7975
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:51:52.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+rfEts3EMc81tIw3DREulmqQte0GY3zYwWn916xq0atBwEVif9bJ2z+UIQZvnefYMON9VG8LKaqgf6P9Ep3yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-equilibrium.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index 6e1be38865c3..e727257bb697 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -588,14 +588,13 @@ static int funcs_utils(struct device *dev, struct eqbr_pmx_func *funcs,
 		       unsigned int *nr_funcs, funcs_util_ops op)
 {
 	struct device_node *node = dev->of_node;
-	struct device_node *np;
 	struct property *prop;
 	const char *fn_name;
 	unsigned int fid;
 	int i, j;
 
 	i = 0;
-	for_each_child_of_node(node, np) {
+	for_each_child_of_node_scoped(node, np) {
 		prop = of_find_property(np, "groups", NULL);
 		if (!prop)
 			continue;
@@ -633,7 +632,6 @@ static int funcs_utils(struct device *dev, struct eqbr_pmx_func *funcs,
 			break;
 
 		default:
-			of_node_put(np);
 			return -EINVAL;
 		}
 		i++;
@@ -706,11 +704,10 @@ static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
 	struct device_node *node = dev->of_node;
 	unsigned int *pins, *pinmux, pin_id, pinmux_id;
 	struct pingroup group, *grp = &group;
-	struct device_node *np;
 	struct property *prop;
 	int j, err;
 
-	for_each_child_of_node(node, np) {
+	for_each_child_of_node_scoped(node, np) {
 		prop = of_find_property(np, "groups", NULL);
 		if (!prop)
 			continue;
@@ -718,42 +715,35 @@ static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
 		err = of_property_count_u32_elems(np, "pins");
 		if (err < 0) {
 			dev_err(dev, "No pins in the group: %s\n", prop->name);
-			of_node_put(np);
 			return err;
 		}
 		grp->npins = err;
 		grp->name = prop->value;
 		pins = devm_kcalloc(dev, grp->npins, sizeof(*pins), GFP_KERNEL);
-		if (!pins) {
-			of_node_put(np);
+		if (!pins)
 			return -ENOMEM;
-		}
+
 		grp->pins = pins;
 
 		pinmux = devm_kcalloc(dev, grp->npins, sizeof(*pinmux), GFP_KERNEL);
-		if (!pinmux) {
-			of_node_put(np);
+		if (!pinmux)
 			return -ENOMEM;
-		}
 
 		for (j = 0; j < grp->npins; j++) {
 			if (of_property_read_u32_index(np, "pins", j, &pin_id)) {
 				dev_err(dev, "Group %s: Read intel pins id failed\n",
 					grp->name);
-				of_node_put(np);
 				return -EINVAL;
 			}
 			if (pin_id >= drvdata->pctl_desc.npins) {
 				dev_err(dev, "Group %s: Invalid pin ID, idx: %d, pin %u\n",
 					grp->name, j, pin_id);
-				of_node_put(np);
 				return -EINVAL;
 			}
 			pins[j] = pin_id;
 			if (of_property_read_u32_index(np, "pinmux", j, &pinmux_id)) {
 				dev_err(dev, "Group %s: Read intel pinmux id failed\n",
 					grp->name);
-				of_node_put(np);
 				return -EINVAL;
 			}
 			pinmux[j] = pinmux_id;
@@ -764,7 +754,6 @@ static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
 						pinmux);
 		if (err < 0) {
 			dev_err(dev, "Failed to register group %s\n", grp->name);
-			of_node_put(np);
 			return err;
 		}
 		memset(&group, 0, sizeof(group));

-- 
2.37.1


