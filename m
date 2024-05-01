Return-Path: <linux-kernel+bounces-165270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D38B8A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0621F23832
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58AF85923;
	Wed,  1 May 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="St/H2kBG"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3244F20C;
	Wed,  1 May 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567739; cv=fail; b=hg9ee2wCoD4BGlRpsBAZtUYX8CYSn09Rih8TtrPjwdTIuDr4JGKDwZwNbOW7mhtnrosJuxm7rnnt98fhcOrggKbqlkSDPKcU5vhM9QTOvsHErKOzRe26BQZ0KD5qGPDHAl8YeXQeQ6t3VSz4O1Eu1PUtgx4DDJ2hKdwR9m7NrK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567739; c=relaxed/simple;
	bh=qaA7+plvN9vJMJd6NUO018HXhCtt4dwNBhkaQZOSdns=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Q5YstgwkhnI+4VD7G/o25d18nIgL9Xu9slabM4pMQzlb2NXjSG5ljuit60Z+UmXcb1jlyC+JSZZiFUUAC5rpaPD6kscFzxT1GJfuY+31ZErEwoPuL/RCFkB5arqpUzTfR2I4IGQ6ZVEsNwPxi7xFgxCRG4siwRPimlGI1PeLjsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=St/H2kBG; arc=fail smtp.client-ip=40.107.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtUM1Zx26FAYDaCIfLxu7fGXSfjyfDqQKjq00DL9+51H8D0XXZHA3IPYETXlSw66QVS0BoVG1oHXsBHdbt/XhMAIypbf/frw4PpOFejJa/Vd16yjg89Ol20W4V1IE4kNtKmDZR/cIMSqPpqmM36JeV0/6mZwR1Dw5kupM9MuSny11X0/+/gossdQveqI3lo8Wjhe89ZlUV/GZtuw6A44tUSqu//fqXcvdX1fs2k1XCZ4yQ46b18dScuPfczImTaRTCLWNqcyM5w3EcShgyT0I5Nr8oTp8jP/12aUFgh/SkqEQtZAzL5NQ58IuQmQbif1WGBTjvnTAN6azSY5evLZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdVrOSBRAxxFKx+tFjA4FVBPMccJECy0Uh+F82a+UOw=;
 b=O8iZYvIqc2v0bQ1IuXZD62LHarNTgg+Nw1FuIHAOmNvpcnArOCcdoqkKU1JWpr+5XOJETBRgCaVmn/CsLUxlPVM1/qdlHn76Oml0eIpA4y2BhVITYsYSCjYZ2sqI6ro5wrMoF+PrI9a/DAJwOBv55JOkBIj1lKDJrNfHaoN9ZtAB4S/rn55C56lkocHnMYmLdoI5wCr+KmTES1rPTs0Us0bgucFF8JezsMawHk1dz01RpZ2aRmLfD1Kn8sag5UPVFo5ulVB6MEQuwBGxO83x/u7Rr8oANJDgyZhuG/It0aMNhSGAivHRygkA09Bo9MYR2tVIlymjxykcGDSMoRFdQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdVrOSBRAxxFKx+tFjA4FVBPMccJECy0Uh+F82a+UOw=;
 b=St/H2kBGw1IKsi/DaryohVBFsNhSXuGD2J28Nt3bd+SJvh7Ydcyh7dpn4JL2Jbi0VwIgmfoA3mdBdiOhoV9zNowsOOq92DLi53vC7Sd1bGVnf3iXUlrvb4W5x0BhUKy2Xs1pZE+zUZJDqzIJtxqFi7MHWgKoRrHMX8WoRzerpyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 12:48:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:48:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:00 +0800
Subject: [PATCH 02/21] pinctrl: tegra: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-2-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=2500;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=HWFw/UIgLMd6Ej1stcfUoXIfV6KFRULjDzCXoqwdlCc=;
 b=C5u5mDNdj00sFDZuSa9UWjL1tsHbOZz4YakGZqcS0xoSlLSwLVG2R5/NNhIluvh+BjLh8Vf7s
 CYFLuu1OxMhDtwRO+rjL+B7PKrWEibGnZZ1fjjdhVzBQmcHrpNNLoVw
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
X-MS-Office365-Filtering-Correlation-Id: cb754a66-66c0-4c35-06b2-08dc69dd0f54
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STVPWXpXTnlCVEdMaFEwcUkxMnE4K0FzQ3hkaWdZL0tMeHh1S2hRMnl1WmFn?=
 =?utf-8?B?MjVHWHcwWFNPeUFtRnY5U1VyY2R6MnM0R2VaMEZSWEQwbXdibXNXUjlMSWl0?=
 =?utf-8?B?MmtjZGFwbHBkT0RISGc0aXlvTXFQNkU0QlJhTUk0Z2RzRVJRdDhaRHZYRGEx?=
 =?utf-8?B?NFp0bE9icWh4dnV3YnhYMktWOHNIOElqRDNIcVd2Z0ZVUDRpanM5cWpyZHIz?=
 =?utf-8?B?WERqa2c2dCszcE5aV254eDl0U2xKMmhWSlEwUFVYVFFOaWc1NSt3eDhZak9y?=
 =?utf-8?B?djNzaWNrMGhEa3dUeXVidFp5ditiY3VOTTdEQ0hUWmdlTi9uMzY0MTZxZFJa?=
 =?utf-8?B?dTd6ek9rZFFqT2p5ek1tTkVtWk9OS3V4ZmlrRXFtWlh6b1RHNmRsdGVEeHZE?=
 =?utf-8?B?YXpPY3VBcWpIeG1FQTBIRHJRS3Q4NHhaYXYvQmFCUURCVFIrQzZwZE94aXFs?=
 =?utf-8?B?WXh6VjU4Vk1EbGk5RUFIQjR3V2ZoS2FJSXdEeDBXZWwxL2tHYzVaVUY0b3pX?=
 =?utf-8?B?TWttNG9PYVR3QkpRZUNwSzZsYjFrWWdHWnJZajFDaFpldzNwcXB0Ry9kSXo4?=
 =?utf-8?B?dVFJTmVPSjN2VEpnbWRSM0dKMlppaHFCTUMweFl1WXdqWXJKK0hJMUREK1A3?=
 =?utf-8?B?ZzlUVjN2QWpwbS8yUFRQRHRKN1E1KzkyNTd2c3BJdVZRMURicy9qaEVVbWRW?=
 =?utf-8?B?U0JkOGxmZW02UjVFb1pDaFJnWDdEV21MZXZNdHhCRTM1bHJNdS90bE1WOXRF?=
 =?utf-8?B?bnlnRnZCQUFvMzNmaUhvU3NCRzBIZ2pxdHRrUVlJcU9IVEx3NS9WYVJMMkZC?=
 =?utf-8?B?RTNTaFJKVUhOZ0RCT2VHamd1S3ZHbDVrMHhpdzYvZ1NrbTJ2eUdjUFJGTWF0?=
 =?utf-8?B?S2NnZEl0d3l2Tk1vMitkV0FlYWl4aGxsY3d4ZEUzc1RqdDRUam43d1NpclY5?=
 =?utf-8?B?Ti9pcnhPbUVUcFRUbkkvMTN0bzVIUi9IQU1WdmlZWkhCMTJmdWZhTUlNcUtk?=
 =?utf-8?B?YncrK3ROZlNNa3laa2tXOWd5WUg0MHlVRDRVZ2dQZnhOZVlFUjlzY0tQWTcv?=
 =?utf-8?B?bFNPTENPR0JXZ0FPd2dkQmpTakpxQmZod1h3VmtLMmFJMEgwZEhka2tYNWtj?=
 =?utf-8?B?VjFCQjdhUzNNcE1ISzJnTkI2S0d1VFFiVHJpUDlVT3dXK0psRXFlVVZ6ZXpE?=
 =?utf-8?B?WDVBZ1V4Ni9aMFN2LzlabW1vZjIwL1A4TEZnUFpDQWI0T2tFU2wvOVpWUmRu?=
 =?utf-8?B?NmRaRzdZOCtSTkIzalNmRVdYN05jNFh1aVVoVU4vZnR4cjJ2eTJHR0xSN05G?=
 =?utf-8?B?cVBLZXllSmdnc1pUS2wwY2hyTXpXYjZiNVpJd0tXYmZhRHVQdVd0NTE1TkxT?=
 =?utf-8?B?NHlDbjRtenA0MWU5eG5XellkVEdzY0VaV3VtN1prTzQ3WUl2b2tOamREV2pS?=
 =?utf-8?B?VGZ1YlIwS0hCNEVpTTdFOSt1Q0ZjZFhabDI3clViTW5LOVV6d09hRy9FOGZR?=
 =?utf-8?B?ZW1Kc1VCeFpCaHdQN2JVdFlWNUh0ZGxENXFsVmlWMWtQMktCbnlyRWNBeHBN?=
 =?utf-8?B?MCtHNUhIV1NIMmdpMHRkNmhPZGdXRU13LzVKODd2VVBwbjhrUjFqaFNDNVli?=
 =?utf-8?B?SUhkYWJvZENXZDFCcDNVUXFIaTM4RWJxZEVNRFUrOGhFTFhvbmlVVXpxVW5r?=
 =?utf-8?B?TFVHU2FMTWtreW9XK2tId0NRZ0FtR0MvaE5IcjF5VHJTN0RSdXJ2TkxxajVZ?=
 =?utf-8?B?OFBqTTZCczRBUXZVUVE5NlZaUkJEWUNzQ0pReGtTcUxBaWVlM1pMZ1VSOHpK?=
 =?utf-8?Q?NBHyk/BdX144Jr7lIO319PH2tblDoxpvagH34=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG5VTTNkRTRsaTRYbWFoYlJjVVR4RHgxYlJEV2VQMzMwYVk2cU1ZQm9IZENu?=
 =?utf-8?B?aEdTaC9qcnJOczhqb2F6NC9nenY2SjliRGpwSEVweTZOZTJGYXVYM0xZK2pL?=
 =?utf-8?B?S1p4NGgrOG5pRjNiTE82cjdCSkhWNE9aWEt4TWVqR0xnbEhkb21jMHUzQ0g3?=
 =?utf-8?B?TnVhcEFnQ1Q4ZGZZd0VYSTJkUHdneXBHS0tLNzA4bWxaeERVczEzV05pdFlI?=
 =?utf-8?B?VllFUXBxU1I5cDQxRS9PQy9Hemc5QW1wWU93b1drL1JHWmpLRC9OQ3VlUzdx?=
 =?utf-8?B?UmJCWUdsUk5LM3ZvMDNxeHZiNThnaHQySlY5MTZFbGVmUUhtOEJkck1jSktM?=
 =?utf-8?B?MTFTMkROTmw5MFpnVWI0V29IN28yUnNRZzh4Mm1NRlp6ZnpSdlJRQndNTzhq?=
 =?utf-8?B?eTBsSnFxYUg4S3BWSFZnT1VscURCZ3Q3MDdjNGRYVU9rWnBoRzZZV2VqTXJL?=
 =?utf-8?B?ZGYxSG9HSUd0R3ZIVUZLc0xFYkxMOGw0ZjcrS0lJMjJzbXJMRGdpZzcramM0?=
 =?utf-8?B?L203SHJ6T3FIZ1U3N09jWGk0cVgxSzVTajhic1UyVzdVQWE4Z0RJZlZreFRr?=
 =?utf-8?B?cUtEODhsN3k1c0RNSkdTcEFzanFhUFZ4R0pQZ1hzRElEeXFPUXIrN0Q5M3Vs?=
 =?utf-8?B?QVJibGpUTTNNT21COWtEVmV3aXdZS2NUUFNnLytoM0VVeEdFMjlQT256YXhi?=
 =?utf-8?B?d1hkalJuVlo1dmoycmZacUpFM05icktxUkVkOXlPYTdjcFB2U2IxNDFRaHRB?=
 =?utf-8?B?cHdyMjlBaXcvYmxPaUVMSTk4bCtlZUZQUGlmN3V6dWNpY1BRRDhUd0toOGZ1?=
 =?utf-8?B?dVh6dURtenVYY21ycUJXQkpwQlBnMDJiVno2M3A2NDNUeDU3SkxwcDVDdE03?=
 =?utf-8?B?ZzdsSGRMdkJGU01VMFRKV1FQWFdGbHUwOHBBSzFsOWJNNCtUeG9CZnJtZGRU?=
 =?utf-8?B?cnlMT0FYY3kxc3lMZURydEdLQ3ZtakpXbnFuVCswaUhpQ0hFV0Z5eDZrQTQz?=
 =?utf-8?B?N285Ky9USXpscE9mcS9wMzFtbjh1MHdZcXFHZWJQMWRsclJjUTFrWWo1azJT?=
 =?utf-8?B?QkcxMHFVM2VVMDNsb0xWTkliNUNiTEcwMXFXYzNoeHZFL2lGWWJyMC85RFdT?=
 =?utf-8?B?cGVCSk9qdHdMbkk3bHdKZmFqRFovQURLVlhEREZ2RUF6UnRwOHErUkFtWGt4?=
 =?utf-8?B?WmhYcFFCN0NOWWc2WjJDNUxnK0g5R3VMd3h3VHEvYUZobCtDZm1TM0hzdDJB?=
 =?utf-8?B?OFgrcHRSd1lvc3hWQ1pHSndjRnJTSW5udHBYTHF5bTV1MmluK1NVOXoyZmxM?=
 =?utf-8?B?cFBBMThMcFJtQTRiUVdXYXlHd2VtQS9vR1FPU1Z5MC9JM0ZrRTBRV05TNkFT?=
 =?utf-8?B?MHpsT0l1N2ZENGZIQ2JFZ0JpTVA3OUo5WEp3QUF3MXo0YzNHTVdIbmNMNCta?=
 =?utf-8?B?M05kVTlYR0FGdWdPZ1l2ekpkV2YzZWxxOENMZzZMQlhTT1RjWENtdDlHQzJD?=
 =?utf-8?B?UFE3OGRkcmI4Ujc1ZzNhUmhhNWgzZDVLSS9ka2dKeW1BQUhsTXFqN0l3WkZX?=
 =?utf-8?B?YmtobEZTSTJYVFRmajhTUCs5bUlkWWxXVlZXUElZWjllYk5mYTZ0N2RudVps?=
 =?utf-8?B?RUNSaXB6MVg1VGQ3QTVmK1lLc2ZCaVlFbU1yaXZ2NWZGNEJ2QUE5eFJWb2pX?=
 =?utf-8?B?N1ZpMFRyMm5NZ1N1QTJtVzJhY1B6SWtHMk13UGxqUHo4N1BBTlVFTm9IOEds?=
 =?utf-8?B?bWZoZlNRQTlNeFgxV05mOUJ4V0JnTjAyekFSQjQ1T2t2NnJDZVhVaDFRMTE4?=
 =?utf-8?B?c3lJeWorYkxwcXlXd0dsQ2VKZ0hWQlo0YnpyMVpMRUx0TFgwa3RBM0xNN2RB?=
 =?utf-8?B?bW1paU5USVFGSWpiWXZZTDFNTStEMUpMbk9zRWt0SXdOOXZjZHNiNTZlYmZV?=
 =?utf-8?B?RW82NEFscWQrc0RZbElRTmRCUGVtaU1ocFVIank5aEk2ZTExOFlNa1g5bGg5?=
 =?utf-8?B?NER6Si9EY0Fod215WUd0K1FJbHl3RHNDdUxYalZBdHhWUjRQMkJabFZKTlIz?=
 =?utf-8?B?RS9lOGtUeWlMQWk5ZWJucTZ1R254SWtoYmE5Ri96ckFvUWFIaWZSTWZFa0Ra?=
 =?utf-8?Q?VjjTG4PhdTvwTPBK9XJROdLxE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb754a66-66c0-4c35-06b2-08dc69dd0f54
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:48:54.6730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FT/DQq33uv22k5h2D/q7d0r+R/Pqjofvm3IEi18jKGnU56jr/GVnE2Loef6PhAtU5CmwT2c9e2bct2uKi9tMmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c |  7 ++-----
 drivers/pinctrl/tegra/pinctrl-tegra.c      | 10 +++-------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index 96ef57a7d385..49c5edeba87f 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -238,20 +238,17 @@ static int tegra_xusb_padctl_dt_node_to_map(struct pinctrl_dev *pinctrl,
 {
 	struct tegra_xusb_padctl *padctl = pinctrl_dev_get_drvdata(pinctrl);
 	unsigned int reserved_maps = 0;
-	struct device_node *np;
 	int err;
 
 	*num_maps = 0;
 	*maps = NULL;
 
-	for_each_child_of_node(parent, np) {
+	for_each_child_of_node_scoped(parent, np) {
 		err = tegra_xusb_padctl_parse_subnode(padctl, np, maps,
 						      &reserved_maps,
 						      num_maps);
-		if (err < 0) {
-			of_node_put(np);
+		if (err < 0)
 			return err;
-		}
 	}
 
 	return 0;
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index ccfa3870a67d..69088609a0c8 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -188,20 +188,18 @@ static int tegra_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 					unsigned *num_maps)
 {
 	unsigned reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	reserved_maps = 0;
 	*map = NULL;
 	*num_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = tegra_pinctrl_dt_subnode_to_map(pctldev, np, map,
 						      &reserved_maps, num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map,
 				*num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}
@@ -759,17 +757,15 @@ DEFINE_NOIRQ_DEV_PM_OPS(tegra_pinctrl_pm, tegra_pinctrl_suspend, tegra_pinctrl_r
 
 static bool tegra_pinctrl_gpio_node_has_range(struct tegra_pmx *pmx)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, pmx->soc->gpio_compatible);
 	bool has_prop = false;
 
-	np = of_find_compatible_node(NULL, NULL, pmx->soc->gpio_compatible);
 	if (!np)
 		return has_prop;
 
 	has_prop = of_find_property(np, "gpio-ranges", NULL);
 
-	of_node_put(np);
-
 	return has_prop;
 }
 

-- 
2.37.1


