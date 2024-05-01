Return-Path: <linux-kernel+bounces-165284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7438B8A9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75998286CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F4412D201;
	Wed,  1 May 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZKYeqlWL"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DE85C66;
	Wed,  1 May 2024 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567935; cv=fail; b=rOO7RM5OkcC3HmD4LUbD1PeGnhFFmX5gCMFkIE7EahJ/j9lrkUnRaf3pdADxBH+iYdrW6f+RpJGK1DVCsVhYoyHQEocVvMBeMvZUelNApz41YMZeDfWQ6zEp5qFTg1396ANM9/thTsOgq8IEPkaj1//D32fix6zrjaiD948HZas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567935; c=relaxed/simple;
	bh=X8fef6zB8RQgo+UuJGH28YE8D4qstSLlPE2UStayCOU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Vt3qaXjzoox9fugqyypYLxfVaVsI3D81Zd5TJzbRg9CRsISRJOAe20Sx2gAGbzBCKq+kK8G4xOwDolWJAdlyVwX5cBP28JZffdnGTo11hI/i7mXiiE2UJ4r4+YaPFfcn1ffMicQZZpEcNmaHXzJ2DC+GOE9n6PAH+Xym/RpCoIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZKYeqlWL; arc=fail smtp.client-ip=40.107.13.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHKYXhSHTJ9CRRmSXyMxJ8eBbJfoWIPRlZumxz4YH5QTfT5dI7D+Y8O4KDmaMZ9NgmuKvxB5wLooMj3JBPKgQSSJO5D+/Po7N/0IyFud4OQrNb4X15VWEiVo2CL8Hl5Kv5/ijJMOLUS8LclOOO/MSqNjBAW5taaChz+1Wau2zk48XrOB0taMC3wyqkMwf/X0LZq/7X4sJT5yN8QTw11DHvqw7+t/ZEqKk6LLwnx7mu8MfWBahI+VcTPDPwVoKUAbYyh8COb4EFodLjTUIsQbt7w9sqL162/i8pkwae5+FwHlr64t2M9OVqw0sInjz54Z20FwEGEuBwHCiJ6bTuDIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwSQeOuBtaXKgwm8vbTLzd1pc6GMs3D2WpIMolNx338=;
 b=bTqFgfRXnYWK3gHt2R66SDy2R7ajOl+qz5hjlLUFEb+3gmyv1ZPuEa0VasK/8MDIkU9fgO47zEfYMovP9ocoOJYf7Ms+Guz51h5mIJoP+WZlGmRKqi9SDm/799icLa1ujVDDam09soHWOVXaG7eIzeA5o33Qd04C2KY5e0dBIJW8Li2FSyhUehy+QZV6BR0CHpdypBARFczkmfdXUagwgbcNwjXjJvZPbtSf4FsLgvtrYbfKg4P+yELmVg3LgIcryCpTfGP0r7nR/UlMDEO/wR/4z1qThrSp165PGlr7JYR4B7CiD8ZI71U+gTR3PdeuCpqaa0IkkFCMpj+BkSsIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwSQeOuBtaXKgwm8vbTLzd1pc6GMs3D2WpIMolNx338=;
 b=ZKYeqlWLS/AdM5XC6NCh8Rp/qCNsPRMQn0dI5CNK7D90agHFXJpnKWO3O4ZsihfG/hms4q248fRvH1ghI2cuuI46OykyXNokFJ1cpiXAQ1iJVBM/qY+5QJAKOHNBmCIiGTuDlDl92XraNhHzQ36uvQTDQz/hQ4zsN5Roz7kvz0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:52:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:52:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:12 +0800
Subject: [PATCH 14/21] pinctrl: at91: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-14-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=3508;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=DsW52PKsk9s0VQOO79Vygj7HmsG35ZlCr2kUzApk7jg=;
 b=1cdQjjCVZD4XTvl7jD/+3a4DFvCSK+DbvouTIkodDirgS/P5DNB2U/LQnNk0QE9haDZudVF3v
 E+GOjqUPfNdAbyJ5f1Dr9PQyXKF6GnAn1dpDh7P5hmY2qLKYBSab073
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
X-MS-Office365-Filtering-Correlation-Id: c1a8b2ff-c9b0-4825-dbda-08dc69dd8302
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LytVbVNYUWtkQ3ZBSDd4YXpCK1hLVkhvWTFMcDhDZTh1dmk0U1IrelJFZnNQ?=
 =?utf-8?B?Zm04ckZ3SVo4eFJPTlFhVUxzSjcvZy9NbHVBb3dSZGxNTlVzM0RlazRHWnB0?=
 =?utf-8?B?czVxNkd5TEFlWHBYY3BJUldVYlJqVjhCUUovZmpRclorbFFFcWpMUEgxSEVa?=
 =?utf-8?B?WXhIVnkrZjEwWFVXRldzaDlVSkpmZDI5RktHUXRPUEN4ZHlyTWwyd2hCTDFP?=
 =?utf-8?B?eHk1NnNCNmgwZm9TMHRkdjljeVBUV0JLd01Ncysxdi9ZMHNtSlY1bmhjUFk3?=
 =?utf-8?B?dy9CN2NjTXdNVEdZa3VZNDBjaXBnRmx3TVo5U1RCMnQ3dVRVL1JabG82VzZt?=
 =?utf-8?B?UWt1ckpVNnYvVzlFT0VZejVBWHlYWXgwL2VMTVZoVGZ2YkVraFRPK0htN0Er?=
 =?utf-8?B?ViswblcvekVwNDFkY0FONmxCRmJqOFIyZXJvcTNaWlBIcFc3Vjc5QStHeUc1?=
 =?utf-8?B?WERzd3pNa2I0Z2MxQW8yMHEvRElyY1ZiT0JEWi9VL0tNbGJXbHVOZWVCTndY?=
 =?utf-8?B?WHVOWHNUQ01EV3o2TnJEYk5kVEpKUzV1OUY3UFJ2SlFxVkFNTHk5ejdvMnV6?=
 =?utf-8?B?RHp3SlFJWjNwRVFmZGxUN1hDSzA5WC84Y3NTZWQySkpIc0d1L1cvMEIrRzZa?=
 =?utf-8?B?MmJnb0ZuOWZnNVdUZjhRZFdqMlBiN0lBaVJvbmQ3WkFvWGNFMkZieDZEUlpT?=
 =?utf-8?B?enJoUGRwRTV6aHNNY1c5RUloeU5IZVF6NE5QUnJ1OFJyV2hjOFB0ZUdiaFMw?=
 =?utf-8?B?YWJvMGwydXU0VFpGd21SeTQ3RmFJRVh2WUlBOTJhcUE2MXg0L1RWNW1XNjFy?=
 =?utf-8?B?TU1ENWJqM0RlR0xIaEFGczlVeGlIdWNWczZKb3pRTVVaMjFxK242SzhiamNO?=
 =?utf-8?B?ZjRoYzRuc3JSMDArZy9xTFIvSzZnSWtycEVJVnlyT1E0bnlPZ1diTzB5cjZM?=
 =?utf-8?B?WHFScVdOeXZUaGdIbkV2RGlHQW1PT3NDM29VeUtRSDFodE9hM3pYRWRtNFpE?=
 =?utf-8?B?OE0yanJnaUhDcGZ4emdFUS9kbVc2R29vcWs0SjloWjNhazc1SUJaMlF4RkFU?=
 =?utf-8?B?dmJMWUk0SDBnNDN5QVplVDVwczdpd0ZSOENlVmlxYk1semJpNzh2dGdCdVNk?=
 =?utf-8?B?S1lKcEtCaE1MS0dmTlR4VStEVy9VQUg4WlVRSDNrYlo3QWtjRVpyMVhadmxx?=
 =?utf-8?B?Tm9ZSW96SkRIQ0ExUWd5M0NFMXRrVUVqVVJBM2pycnVOcXo3ZEdEcXk3WmJL?=
 =?utf-8?B?MFlXRTEwbk1IUjZIdFFPV1AwWnlreVFkVUJTeU1EWGpqRnJLbHpVbVBDYUFj?=
 =?utf-8?B?cXRGUDhucjAxUzYwaDhlNkF2T1dWT1d0bE4waC90b05ray9HNnU0dlNrNGh4?=
 =?utf-8?B?QjhwdVE1M0NqZ2svbkVqSkIrb0lEK2x6aFJ0UnVZWGtIUTE3T3k2WlRYeXdv?=
 =?utf-8?B?MGY1WXh4SDhCTkU2cDgrMDNtQWJJVmZ1dDdyQy83SW5YbnloeVR5OEE1SHd3?=
 =?utf-8?B?OVpEU05iVWF1STM1TW15VTFYNDNZUmxjVDlMNzNRaFpVai9jY1Y2Z2dBMzJ3?=
 =?utf-8?B?bGljVjJzZ2RNbmUyTXBvSkQwaFg1OEJjY3g0QTVSZnRhZVBVYnZnN0JUMDJq?=
 =?utf-8?B?MGxNbU9Kemg5cFhYUm1wVlV1R3dWa0dqTFBKWVlDdFk5dGp2S2JiQ054OHl6?=
 =?utf-8?B?Vlg1MVdqRmp2TndoeFg0N1JrNlhMVUtaVXNTVjBrSEFQZ1VRNGx0ZHRzanNm?=
 =?utf-8?B?cVNCeFZIcXhHMjJEeE9xT3Q5WWlXZG1HclFiTk9HKzQvY1g0eFR4bVZOZk4w?=
 =?utf-8?Q?2ezMs+Llox3dCSwh+MBDAdFOrHToZopR2izXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UC9vM3NDTFFVMVNqeUNmT0FKM0p0ZlhuT1ZBM3NhR002ZERCc3liOS9EV3ll?=
 =?utf-8?B?UXJ4SlJhQUV1bVVOSGR4enJvdUVuRDEyUVBHUVQ2ZVdrZ0FXMTR3UDhwaUdj?=
 =?utf-8?B?aGxwV0FnLy9zcTljRUwvZnJ5allQaEVGR0NRZDJubXJGd1NYTTAzUzlNYTNU?=
 =?utf-8?B?U0ZnVjFFaTU2Nkt2ZkFnM3Y5dE9vVEoweWNjYnhNV0FZbnR0R3B1bS9wR0FR?=
 =?utf-8?B?eFdQUXJtbEJWdmZpaDQzclprVWdnOHU0N3JnekNzc0NZdUM2RXVaOEhqdmVo?=
 =?utf-8?B?TlFiakszSmRXcFZWZDh3KzlFUFNhaGJZbEZZdE9SbVdYUDlDVTBLdzQvTmtn?=
 =?utf-8?B?akJ1dzNjUENZZnB5RmVkaWtzLzVpbHNZd2VnOEFSZ25yU09HVkVhMThQMUZp?=
 =?utf-8?B?UGcyS1hIVGh2VFN3aXNTaS9hTFJOSlU3SGkxTEdjWTBDVU1yRzlXaHJYemlE?=
 =?utf-8?B?cUhxMTIvcG5qV0VFRUhHUXlpMHl2T1RidjMxMnE5NTRZRTJ4RlRFLzVuL0ZT?=
 =?utf-8?B?ZE1xb09mOUY0RnlpOWVlUzc1d3AxK3pGT2NuWXZGQkIzbU9iN2tHWDNYdEp2?=
 =?utf-8?B?dWtFSEpkZ1hpdmIvY0MrVllzRnh6emtUMmx3SnM0djVrQlE3OVNmeHQybURj?=
 =?utf-8?B?S1FKeEpVdDNwMlJaNVFJbnZZMjJQQzBJKy8zU3BMcFhNSVFWdTlnMzZkRHB5?=
 =?utf-8?B?RmFxWGt3NllYd2JNVFIreXV3ZkhBdU90Nld0SHJkeStqOFhIUW9ZdVNaeVNH?=
 =?utf-8?B?SFRHZWUvdmo4cEMwOWE0bGRwUFFDVjE5NW1HRjVUWWxhTnFrbDJTamMvRDBK?=
 =?utf-8?B?TFdGRjY0MmhTSmJPZUN4SS81Mms0MC9JN09POVdLV3VtbEpMUHVKVG9wL3dt?=
 =?utf-8?B?Zm5rYUtpTC9kYjhrM1llS2pDdHNlNHlEWkJMS1lGUEtwWG9JbmhZWWFWOGFz?=
 =?utf-8?B?SzBvTEYvVy9MK2JoYS8veTZROFl6NFpvUC8wV1N6S2lHWEp6OE9ncDBsUndO?=
 =?utf-8?B?WmxpVWphWHNvN3RTWHVIdDRsVmRxSStRTU9YTTBkZk8zY0dlTGtYR0FsYjRn?=
 =?utf-8?B?RGZ4Y25SdzBtcHN5d2VpS29NYmVvZnRxMnhvVEloQXJFeUk5cHVLRmpyVlUv?=
 =?utf-8?B?UHY1MFNQSzdrc29hb3liYVRsWmkwdXAyenoxbDJvNWFtWGh3Nlc0QUhqS3VY?=
 =?utf-8?B?L25jTks2SHBPNm54akRkelpLbElMYndvdEtsSXZHWWMyWEFULzRuSjBtWlVl?=
 =?utf-8?B?SThFVkpzKzJTaU5QTlZncmU5UXUxRjF6TWFxTTE1bUM0am43Mit4a21UYjRp?=
 =?utf-8?B?WWxtVXpKMGhoczRsSDNiWFZxYnkweTlrYzZBaHRUSGdwOGlva3lLNGkzejBK?=
 =?utf-8?B?akx3S3FPZ09iYnc0aXVjWXdEcnBKYXJVYmFqWXBJUllXaFBJVXlMYnNCYVIx?=
 =?utf-8?B?aVpUWmJnTnBGTldBVjhRYit6WFMzWXk4V3ArZTM4dThRUHhqRE9HQnhDOUo1?=
 =?utf-8?B?QWJjNFpncVpOUG84bXpvd0l5RVl2QjRqYU1ITlVXYU95U1ArRERjMENKVDNW?=
 =?utf-8?B?R0E5UGpsMmlBOFBFRDRPYTUxU3pDakF6ZVZOZUs2UDdSVXpXTEFTeTRORVAr?=
 =?utf-8?B?ZHRRWkNEVERpVlpDZ25sODhBVXNkdkwwOXlqRWJIdUJkK3plNmFvd1dFanE5?=
 =?utf-8?B?YnE3NUpWMlpPeGhHd3VFNjdoQWg2Mnd1VVpTdkpYSndNL1VTWGZCWnN1V0lY?=
 =?utf-8?B?UDJ3dTVXZEpVK3BpMURqd1JrUW1YVlNSWHZHSms2Z3g3akJlU3lqK0p2Z05h?=
 =?utf-8?B?QWtoRWlzOGlsQmtYeWg1amhPN3c0c3FmaG5sRDhmay9UNmIrNVBFWDBqeVZR?=
 =?utf-8?B?dS9ySGdBakljMXlUb1hSdUVsaTZ1QmZjMW9lLzNiV0xRZHgreVpqTjUyemhn?=
 =?utf-8?B?UUprYzdwbkNHRktpenVoRW9OOTE1MFl0UENrU1grRmFDdTVKY0xTLzYrWHY5?=
 =?utf-8?B?SlJnaDJZaUJOWkZwQjFERnZyM0lKanFnWlRWZnl4ZlVKejVxRE9kbHlVZnVw?=
 =?utf-8?B?RVkvTmFndUt4UEZlNythaFpEazI0LzIvSExCNHh0NC82OWhUNzB5WEhxYkx0?=
 =?utf-8?Q?GlzowYzrVBdjGCrMv5L8Bk4BM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a8b2ff-c9b0-4825-dbda-08dc69dd8302
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:52:08.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p1DJvd9ZG11gV5c3BC+frDLn4qMRBqxL0203eoK/HfYhX4xeIDB+3pmdc02l9InHrExMp4T1fUbWYaVNVbo6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c |  7 ++-----
 drivers/pinctrl/pinctrl-at91.c      | 17 +++++------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index a27c01fcbb47..8b01d312305a 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -632,7 +632,6 @@ static int atmel_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				     struct pinctrl_map **map,
 				     unsigned int *num_maps)
 {
-	struct device_node *np;
 	unsigned int reserved_maps;
 	int ret;
 
@@ -648,13 +647,11 @@ static int atmel_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	ret = atmel_pctl_dt_subnode_to_map(pctldev, np_config, map,
 					   &reserved_maps, num_maps);
 	if (ret) {
-		for_each_child_of_node(np_config, np) {
+		for_each_child_of_node_scoped(np_config, np) {
 			ret = atmel_pctl_dt_subnode_to_map(pctldev, np, map,
 						    &reserved_maps, num_maps);
-			if (ret < 0) {
-				of_node_put(np);
+			if (ret < 0)
 				break;
-			}
 		}
 	}
 
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 5aa9d5c533c6..cc32db0797e6 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -292,7 +292,7 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
 	struct at91_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	const struct at91_pin_group *grp;
 	struct pinctrl_map *new_map;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	int map_num = 1;
 	int i;
 
@@ -325,7 +325,6 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
 	new_map[0].data.mux.function = parent->name;
 	new_map[0].data.mux.group = np->name;
-	of_node_put(parent);
 
 	/* create config map */
 	new_map++;
@@ -1244,7 +1243,6 @@ static int at91_pinctrl_parse_groups(struct device_node *np,
 static int at91_pinctrl_parse_functions(struct device_node *np,
 					struct at91_pinctrl *info, u32 index)
 {
-	struct device_node *child;
 	struct at91_pmx_func *func;
 	struct at91_pin_group *grp;
 	int ret;
@@ -1267,14 +1265,12 @@ static int at91_pinctrl_parse_functions(struct device_node *np,
 	if (!func->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = at91_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -1296,7 +1292,6 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 	int i, j, ngpio_chips_enabled = 0;
 	uint32_t *tmp;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 
 	if (!np)
 		return -ENODEV;
@@ -1349,14 +1344,12 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 
 	i = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_device_is_compatible(child, gpio_compat))
 			continue;
 		ret = at91_pinctrl_parse_functions(child, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return dev_err_probe(dev, ret, "failed to parse function\n");
-		}
 	}
 
 	return 0;

-- 
2.37.1


