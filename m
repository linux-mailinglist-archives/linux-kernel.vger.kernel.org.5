Return-Path: <linux-kernel+bounces-165286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B4B8B8AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5E71C21F74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E45B12D20E;
	Wed,  1 May 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XcMBz3RD"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D88248B;
	Wed,  1 May 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567966; cv=fail; b=K9/9wTbCXn3Sj25pnxFbznZfG9C/XfxUWXA26lulzPmj2bq9udy1Q6FThfEZtZTa3N1Bpbiq4Q3zZXl7vyuLsvDRqv2lyutyfwW1vOacS/Sgyg7hHZ9sxMlkULcgA8MiH9gatXNWnoetgzN+7CbhYWXOvab5oqwF21K/BcPUEp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567966; c=relaxed/simple;
	bh=UYDu+QLrZ0SSLpWHuRHRNNZ73xp3uVF3FfCqwL6cAd4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Tey3zYjcp4nn8Cct7wn2VpET8PHyQHmNBCRwc1nxmGFCph1kBa+TY0sDW0fOAbnhxsZmIS0HULmzz2hZYhW5r0u58e3ibVs6eRahkhx996a6LjI3otzbvHDlSj4EOXP+yH2upDgYM0ZvNri9dsM0HBgO5V9ieVrqC86fHqyF3ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XcMBz3RD; arc=fail smtp.client-ip=40.107.13.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XifoDNFy+OIEK+L1N3yuEmV5XxdlcDY7VEDXhd6JFqp0mpxPhZgUdo/lpIIzxLUjnMymIYzrtiDr2hLLA3rzjrgq/8GkOsbEDmKLr78QTf0iKZ52N056amWTpcs+ZAs3YVgaLlq7ieIN5D3wZZlNqMp5V/GzUFJ6gs3uvQX8G/AD7+y2JQuYYGXTXWKPsn52JcUIaZIF+MqOJzB6jriDDfq+G7OIVLt9ibhonhCJYDKu4sQ+aIIpiHC0XcZUW5FE/PyRGH8+4f9lLMxavBuIGzfOS+Pm9QdcJaQltYRlmozL/D7bbK0GCqME9v9sOysSlKmpVcL9DrApXCKUPtaxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh46VIFFtnR87VP8CR7uMzRt81dfHvC2gK19Gu2CtGM=;
 b=Z7XszxlL7Cd4EqBxsGRR3c7nh17exvXRKG5Xc86hzFyVwP/5aay1BDHBK+DdQXPmsrW4gmO2TBJg673S5e7cuyfZO0fcJAQhywHN8IEZbSyCCh3xqa2naV2TdgAgk9TrwG/r1J70m2/09XssXrwm119ZbG1BB0GseRt0G2yeqgnwpl44wgS5IuThMt37c7yJ21ayN9dIzcsVo3pKrgQUbEiuNAi5OfHSYL8gG2QNtmaZ9Mqn5a/ksZRu4kxiGCb+vZIdyDSnJdAblYBSaJQpQ+L1QHCOfz63pEvcSpuQXv2h66J3umxzYO2fI3JoTnPJ2uW8pVYIULuMsaipnQpyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh46VIFFtnR87VP8CR7uMzRt81dfHvC2gK19Gu2CtGM=;
 b=XcMBz3RD6J+BpOdQUcC+tI+ZS4U4ar6yAE7Ic9ceBZh00UY3Vze+v4QW0K0dkPqridb/N+uAh7bKF8b5WPN0leb/tl3uFohVjl6otL1ESHh0Fp4zJjevHJIRkCmhaGh94Z9Ay99uQcPquTMQ3AYo8wKrs8bs1ljsDXEQ7TopfBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:52:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:52:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:14 +0800
Subject: [PATCH 16/21] pinctrl: nomadik: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-16-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=1905;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=x+RKtlqeCysZbUAk0csydxI+b9I02cK4F7LOISGb+DM=;
 b=Y3+vk3f43AcNvROw3kkX4CgId2lnsZyoUr4FCfrXbQW+2RkiW/K4kuVSb4mcgJzb01ENb6OLL
 Tw+jfm6cSIaCjvByic6cwwOvm+A9nbuy+hC5xdMXE2JwFxQPNCx6NMJ
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
X-MS-Office365-Filtering-Correlation-Id: 338cf59a-6dc3-466b-c9f9-08dc69dd9634
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2JzaGhTOFBpTmpnUGg0SVhMdFZ4R2JQK21ac1VNakZScnlrbXVEVVVBTVVQ?=
 =?utf-8?B?cXp6b3pLMURNWFMvTU5GYnp3VFJUaiswMnc4S1pjZE1xVzFiWlJjOFJNSmlZ?=
 =?utf-8?B?eUptTzUzV1FTc0hBK1ByUG9zSzY2b3BpZnlGS2NNMVBwWWw3NWlwM2JFYUx3?=
 =?utf-8?B?dEFacFFuSUhxZjJnT01vUysxQ3c4ZEMyZHRpOEk4alA1WWtLam9Bdy9nUzM2?=
 =?utf-8?B?VnQxalZ6VE1jOVc1QXdsRjY3Zk1qV1dCSHN3UjZJWnpwd3pZUHVnZHNyWVNu?=
 =?utf-8?B?NXVxNmhNVVptK05kcFJ6cHRrQnNXbXdYTmZVOXNwekdwaUY2elo0YWVCYWlJ?=
 =?utf-8?B?VWxza1JGOUVucjlVamNwSFVGR1B4L01YMnVzLzEwQ2UySTZERVhLR0Nybzg5?=
 =?utf-8?B?ZmRDdkIvZjZGaU9OLzJzcU1VUTZaQnZDZnlCN0RWeHFHd0x6R1BGalBxcHRw?=
 =?utf-8?B?R3kzVVhFajlZc2g5NGxvd1hEOWtyZ3RmZEM4M21xeCtJeVUzaUh3dFRVd2dw?=
 =?utf-8?B?c0hlTGF0aEFId3NGcTAraGc4a3NjOEFmNVNUZ1BWQ2IyeE1BeEk4Q2dSbmRu?=
 =?utf-8?B?MXdJUFlhZW1MZ3llMVpWRW9yMzJjNGoxbUxZYlA1Z2Vpc2RJQjh4QlYwZVB0?=
 =?utf-8?B?bVJoQU5mcWN0NUtVbVB0dm5aWEFFd2xwSmpzWXFob0h2TnBGZkRDUEtmQTV4?=
 =?utf-8?B?djlSUUxSb0xvS0JZRjd6ZGNvSCtuRXdKOFlvK0NaV1FLb0N3T3FjOG40M2cz?=
 =?utf-8?B?REpsUE82cXR3eDJvazRJQ2tVZmNYOWpkRGtWMlVNbWZoS21aMVJWdWxvTVo5?=
 =?utf-8?B?SHhOWG51YjRyWUZxZ1UySWRsR2dPL3ZsVDMybFBNeUR3SzlLcXJNWFFOUlVR?=
 =?utf-8?B?S2NUdDIrVDBaU2VkVTFrSXpqNmNGVE5FcWtyMGVBN0FlQjBpckZPV3BuenpV?=
 =?utf-8?B?YnBacnV1aGdTZHpRY0ZvSTVhWW5aaWJaZHJIV0t4OGtWK1d3RWxxMVE2TDNB?=
 =?utf-8?B?L1RyRlNWTXROb0Q5bVloV0ZlZ1Y3SThTUDhabHhPTFYrOWEzQlZ3TitGV1Ax?=
 =?utf-8?B?MUY1WGRVNVJ0VkJhM1hMcG5DZzI3MXR5WUhjUVRvRVRNNHQwY3VSaSszRlBo?=
 =?utf-8?B?TjlKU09Ua0hEZkt0Z1FiYk0rOXNUSkw0Z1NyNFUrVHlJMkd2eGpybjRaTTc1?=
 =?utf-8?B?b3l4U0d6ZHA1STd5dzdxdCtndVVsV0NlSzMzemJwWkxhT3huVHRaNmFRT2dt?=
 =?utf-8?B?OTNkQ2c0NzRjTytHd3NSOUN1OHlLUUNWMkFLZm82R0pKeVcrS1RKSTh3VzUy?=
 =?utf-8?B?Y25QN0N1SFhBNExBYVljTWw5YlA2dkJTWERBZVEvRUdlQUZ4dktOenBPK0NJ?=
 =?utf-8?B?bkwwcE5mZDdTRUc5bmhDanJOWjZ6cCtVUXVsYmM2TTdENWpyM3dJaXo2Qkp5?=
 =?utf-8?B?N05jWXVzN3N6SnhETzNSRzJvS2tsUVhTbXlmRHI4RVpaaURNSW1RVHZFa05C?=
 =?utf-8?B?QzJGeStnd3U0dWUwSGJFT21nMjRGaXhUMmdHc3RIVHIyQlUyTk9Ha2V1QUNF?=
 =?utf-8?B?RUV3b0ZsQlNsYmJkUjk4bGhDR0NTZm5Vdkd0NnVjVDdiTm1ZQnQvVm52MGtB?=
 =?utf-8?B?ektreUo0ZzVFMHZLZ0VtR25MK0xCcDcxVzNLeHRHMjJFYTZuMmp3eUJpWm5q?=
 =?utf-8?B?VW9MMFlVQmcwK1BzcWhwSFZFV05pU0QyRFZVeXphN3hRK0krNVQzU1VBVERR?=
 =?utf-8?B?QkhxSDl1ODZEeGMwaVlJbTVWdlQ5RThlUC9JMHRlNWFNankrUUx3bFdLWDBG?=
 =?utf-8?Q?sqVNhK4g4Qmg697Pv+tixmnDym/hgDpaOxjnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sml3Zk1oUFB0RVdybURSaDVBRjh5ZHJ0UTRHaGh2YUE5YWt3T2FpNGtIcnFo?=
 =?utf-8?B?bGVtZTRHTUszRGQzRng2NHErS0pXRjBCRHBpTVZVUGhXbGhIQTBEWVRFcFJR?=
 =?utf-8?B?QzlyeFA3TlNpRVM3akRSenMvTU9CYjhmSmxMVXlJU1pjNE0wWlEzYU15Q0J1?=
 =?utf-8?B?ZktzRmM3MzhzOFNsdVlHNGNxMUNScTFQNFFUOStLa3dlaldvdjRXL0ZVQ1dK?=
 =?utf-8?B?dVJ5MW1BMXVwdys1REhVb3NYendHYktrMDA1cU9VaVBpTU9ZUjVyM1BzRXd0?=
 =?utf-8?B?LzY0MitiZTlDTm9LbFcrSU0vc25hVythczFaVVRCK21xb29mUE85WU5zSTJm?=
 =?utf-8?B?eHhCYVhieHhSSHdkWjNUWlhtd1JNWGcydnlSRnpGM21KemdOeGVSQlhKK3JS?=
 =?utf-8?B?YnBZaERHRFdGQ0dXTEFLNVpjQ1pDK0NrTEEwb3RJOXp1MkFrM0tIczZTSTFT?=
 =?utf-8?B?bGkzb2RValg3NGZISkRGZ091NjVtQzF5Vng1Vm5ZSzNDQnBJbXdJUlFsaXpF?=
 =?utf-8?B?M3NlSVBoTzdiYndzTFRxT0s3QmNCVG9zWjdjWTV5WXpxaVhFVVd6eHk0Rnlr?=
 =?utf-8?B?eldHem5xSDhJT2t3VXBESDF0YzJTQWVZdHBTRFJtd3Z4T3FFWTZoc1hnU1JT?=
 =?utf-8?B?ZGpkMndXQW1tSHdzZGI4eVpjRk5wMTBIdVV0cDFPcGcyZ3hNdUZYanNBT0ll?=
 =?utf-8?B?cWJaNkpVRngzeTEyblQ3cS9zcldUZHNPSGx3N0RWL0pVb01WQWtzYm53cm1m?=
 =?utf-8?B?NzNLRHUvMk52UmtodmgyZUd2WnNBeGVDTXZxSDZqZDBZOUtjYjArdTZ3MDJ2?=
 =?utf-8?B?T1JQTGtveGxUclAyWTFlSWtmcUJIeHlaUGpqNFlwU1hqamFBQStGclk5aDNo?=
 =?utf-8?B?Q21kOHhGWDYxTnFhVUtPelVKVUFJRTB1U2FFc004MUIxSm1KSVZndTBVU2tN?=
 =?utf-8?B?UTRSVnpMMHZaOHFJSlNyYk9ydURxb2N4dWNGZnlEZEJKeDVJUmQxUHl3WWhH?=
 =?utf-8?B?NkQvTXdMS05zSUhXanlkdmh6SE5xeHlaSHh0YnN1RldjSUM0aEJ1UU90Z2NP?=
 =?utf-8?B?SXI5dXJPcHpGTVV1d3o4Z0w2NU11aXNnTWZTSCtmVmcycnd0YXg0b2RQQUF3?=
 =?utf-8?B?QmNZdFplUDNLNjNMeG9QSlJZdnFLQllFVUhOMDJWUnNLVnpxUEU3SG41alRj?=
 =?utf-8?B?YUtFVCtlRjVHbWJCSnJPUEhZRDF2VTRiSEUwSDdrWTNXVkxIdGYzNEpSTmNp?=
 =?utf-8?B?a28wazJyT2tXM1BrVERDK3dZeWx6aDFEeXI4L0xLS3NlcnZoc053NEQxdzZM?=
 =?utf-8?B?ZDhMV2NlR2JGeWdmQzE3clMxYTJOTlBGakFNS1VlUlB0Q1Q1eDdlbXlRbTF1?=
 =?utf-8?B?OGdqd3FaWWVxNkNtV0FCY2VNVjFoWjIzQStFZEY1TGpBOEF3M1orZW5jUUs5?=
 =?utf-8?B?ZTFtRS9uV1pxWWErcG5uZ1YxU2RkUDlOZTl4NDRSMGJadTRXMU83dGg5dnM2?=
 =?utf-8?B?b2xoc24yRUhINUF1a3hZakdhblF2cVd6UEJZcGlmQTUvVG9vZ2JwTkprS3R4?=
 =?utf-8?B?S0Jtd0VSRXVkeTlVSHBUc2RpR0VxTDBUbHArVUhoVDIwOTVlM0dVMmVEVGRK?=
 =?utf-8?B?aW42MzJBTnJGVlJ0MVNwMjF4ODNCdlVRWTI3TWNHZUtROXRjc2N2VDR6eXN3?=
 =?utf-8?B?eVNvczRzQUUxNUpHRnpja0RCelBVSmlIZEovTW1jZlNVSmR6OUlqTTZielpn?=
 =?utf-8?B?bkpyWTdpVzJBSmUrS1VVakxCL0pUSWxkNjBybUJoTHRpNGp4a05aaXdOUWJr?=
 =?utf-8?B?dHJVUWdHa2tpZlBDbGE3WlBVc2IzRzhPOEpzZTR0UXBFb2l6VXlZdHU4N293?=
 =?utf-8?B?VTBPL3M1c3dxZlllYmdVVVAwVzhPUmJCb05wS1V6QnJWOGFwK09XOVpJbFR1?=
 =?utf-8?B?WUJHbHB0NUVEem5McStNa2l0enB1aE0ra2RrYjIzZ0lTdE8wZW5jK2JwVzZ0?=
 =?utf-8?B?cExpQnhqZ3FjQTZQQU9KM0Yvbm9vVE95ZHM2L1Rmb0hpdElRVVIza1dUdHJv?=
 =?utf-8?B?VnFHYTBFZk9yNWptMEtqUHpvWFROTzdDOEwwbGVwR1FlcUtYQUxvQU1pVDdq?=
 =?utf-8?Q?r4jXzoX4poFhYTorRV6AI0+rv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338cf59a-6dc3-466b-c9f9-08dc69dd9634
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:52:40.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BwTvFoAifewf9K//sLx0gnboIdTV1IhnrFyKGTjhX+6geimmswC0t0O4NdJwAILhii90JVZlNfmHkLVmbObVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c  | 4 +---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index 80e3ac333136..47f62c89955a 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -811,19 +811,17 @@ static int abx500_dt_node_to_map(struct pinctrl_dev *pctldev,
 				 struct pinctrl_map **map, unsigned *num_maps)
 {
 	unsigned reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	reserved_maps = 0;
 	*map = NULL;
 	*num_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = abx500_dt_subnode_to_map(pctldev, np, map,
 				&reserved_maps, num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index cb0f0d5a5e45..fa78d5ecc685 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -804,19 +804,17 @@ static int nmk_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				      unsigned int *num_maps)
 {
 	unsigned int reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	reserved_maps = 0;
 	*map = NULL;
 	*num_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = nmk_pinctrl_dt_subnode_to_map(pctldev, np, map,
 						    &reserved_maps, num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}

-- 
2.37.1


