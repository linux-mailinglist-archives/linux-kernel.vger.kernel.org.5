Return-Path: <linux-kernel+bounces-165289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2268B8ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038621F2284F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C6612A16D;
	Wed,  1 May 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kzyBjaKe"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692212DD9F;
	Wed,  1 May 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567998; cv=fail; b=s+fXQQVjjUJSKV0eGmW7W1R8BmHs5BLOEn79kvN6Jwvs/PzqBG/ZvarZy76T7McW+nx7SHL0KH5MYX5k7gpcKK1ShICcXDMeDzU2emyCfLVeLAWSxtx7AYylaJQr6gx/4hQ8MZepUIocuxS8MsEXU6UqEQSpa/N2B+Oo9+eHqsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567998; c=relaxed/simple;
	bh=KV+m8eucvOGFTI4e8uJbFa77qPbZ1dpmI0MWVBfNKrU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j7cZD5Ymia+U9w/zBzW+KDT4KCRkmwd/Vw75p2ES4qfJ5SFNBGpfp6Pa9VVG4QDpukzhXImkx3aQI3l/SzbwW0KzbDePXxP7V+copPlXHET+EpcbtbuVwBd3cvZqmgZO/YChvC37jLhXzUIbywWFe/mvnN8qhkLhyQSezUJEX3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kzyBjaKe; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljZ0boUiuNpueqEYS1sx+4W9Zsj+2UcSUMJsh4j3b2isKHr2zFReu/hFMMQ04XlujmzxtascpO/U7CSRuLvNzU9X0iM2D30Z2VC7drjMCO3HDBjmtA1XlwxmHTCfSmerCPUfDLe572/F1i/J/rcVs6YcwtyDveg8oAB6sGrDhzgdA2UOObQsT/oMe4K66fuFhSViHUttgrRG1wzt3n4Qt2/0Yn2Ob2kv4cM0fT1wPJ9XQdTQ2yBI40f2q6Lxo2h52GiMhMX3WxGNfMxmLinhVsxxVJ5IzpkJeyxy25cP23Iq5vcdZ9Pp3zrxy39I8uAw4A0MDDZLwJtsAGarpRtyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOUGS2GhtJtBkQQNXEIQ7AVz3ycnjlDuNKMdQb91LlY=;
 b=gLJxpZScs2tF7a2nByZLypSwz0GAItiP1G5oawi0WrggoRMRqkQocGwW5w7W/l8g0CFdHk9ghNmOzP4pdrt3tQJ60UUWqI4WU9+5nIh0Et4tVHwT/g5UGwpuMJgd8Dja9WV1VOMqmmqgtA2TXyILVSoUnHlGDHbuJ4qZSsd+vkU+oks5arx8Z4AZriPqzhHtfy44VTMjKQuaJyqQkjB3cgxtUjFdCfIhkYuvhghBw5KvztwRl3iXm1XLRHndyo2PkG9HBpOklU3x9PBWOzdxeOSQcqg2dIOYuKB74/P6pN7Q8T/hiXwg+dYkT2cgJSy1+IXZVzFCT57LBTOcWRDtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOUGS2GhtJtBkQQNXEIQ7AVz3ycnjlDuNKMdQb91LlY=;
 b=kzyBjaKeb+AUuC7Zjd64qxo43UGsk4EmPWahLi5mkfywRXN+mOo62iMeZxfFmnxn0uQJ5B/klABzN6+DNqxRx/Isq+Nk4R9xwGwU6oLUiNSdsUB7S/D7ziGL0pVHp+ZqBqCPHe8irEOBb/23VQSPHKi5yumhx09MPN70mkmaxyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 12:53:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:53:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:16 +0800
Subject: [PATCH 18/21] pinctrl: freescale: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-18-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=8521;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=irbmvdeFvCZAi6uMcwD/z6mbAQPBAAsA8D6exICZ4Cw=;
 b=s3Pfcg/yFofine3MrQ4SLUV5kyRaLbAVfgtd4OqT6ZRRIpRty68qr71SYvc+CtO+bxloRInCc
 NFCqy3dfezPDcwGGN6ZwYHEtnT2HOVOUi16fBq6/QSfsbgPTLk9vd26
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: a797f85f-da26-48ff-4da8-08dc69dda962
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|366007|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEhqU2xTTGZHcSsxMWtkYUhXbitRSGs0dy9oODlvSVdOZHI5TG5wbUdsQ3RX?=
 =?utf-8?B?WDY5ekp5bVVNcnB2dW5pbSt0aVl1eGRDbWQ3YVlNNzNVMlZWL0wyb3NPckts?=
 =?utf-8?B?WUtKNjVyWTFNZ2p3MXRkS2NNZDhWVFpLVlpLRlhSVmlZelhteUF2YXBZenNJ?=
 =?utf-8?B?Uyt5R2JENlNwR0I3TzlnQllyVThIeHpkSXhPd1FjN1RabkhDbTRvZCtyMFFv?=
 =?utf-8?B?Q2xDdGtRaW85TStiM0xJQW95M1h3b3grWlFWVjZkbDQ5aHZxZy9oSnpKVzJT?=
 =?utf-8?B?QWNrZGd2ZUdTV0xPTElTbWwvNzliY2ZYWXBDaXRTY0x2dWhTQVV4QjlmMzJ1?=
 =?utf-8?B?ekc5QVpEZ1g1NThSMVpZTkVXS0pQTHBZZC8rcGM1VGtjSUVyYnZWVlBBcHJx?=
 =?utf-8?B?bkpSa2QyK2MyQ0F4WUgrRWFNTzYzSTBmN0toUjgvYi92SzV6SlFZeTBmL0ZY?=
 =?utf-8?B?NGxVdDRGRU1GbmNGVExuazRMMjFScHRzOHZlRm1kY2VGUGlPek9QS0dXNnI2?=
 =?utf-8?B?ditiTzlVbUlPWnlyTEZkSjJJRjRiWUR1d0oxSTg2dkRKaFZ3RCtoR1N5dFNl?=
 =?utf-8?B?SmpuWWp0eDNVUGRPWXo4QXdHMERuejhFRWhEUnV3N3hFRk9TWnhmN2ZSeWM3?=
 =?utf-8?B?c2ZET29tTldjTFVJaHhtRFpwSklReHIxSnIwUDU2QmFlL1k2NTYvaVk4MUNm?=
 =?utf-8?B?aCs2RTBYTWQ1Y0JCbXRNQmtTSFFXMHdhYW50YjRseXM5c1JaNmcwTzRsWW5T?=
 =?utf-8?B?SU54Z1pZRWVPL2haaHNoTk9WZXluZTEyTVNBazlERzFvekhOSHhtODBIeVpz?=
 =?utf-8?B?UjNvdWRzdHdkMFprektmaTZ3STl1UHVoRHpZTTMyOUI4T05oSGhjeVF4c1pS?=
 =?utf-8?B?U1E4YmlzdWh5UG05NXVFdUdIZDFuUkp1U1FTL1doRGg2Y290ZFh4Z3Q5L0I1?=
 =?utf-8?B?VXlodFphY1B1MWM2a3VNMXFVODhKbEFkV1NWZDVBbTh5eXhFOHdmc292ZG5O?=
 =?utf-8?B?U1o1YVJacVJhclhjSkQwT3l0UDFKSlpNYk9BVDREZEltQUhYYmZiSTVKRElH?=
 =?utf-8?B?YjdxWEtWUWorNEcxLzZmMzFvTGgrbEV3UzZ1VTd3YmFBalVDQTBCd0xPZDNW?=
 =?utf-8?B?V0ZzUC9wR2thRXFEV3pDU3d4dTVDNlJOWVRBNGdnNzRncWQ5S2YwbkhsQjNL?=
 =?utf-8?B?RUxkVTFOenJrK2J4Tmk5KzczWDE5K2V4aStnbWxtVzFrZFlTTWhDOStZVTIv?=
 =?utf-8?B?ZGg1Wit4a2xiR25vQjVlajlxYzQwd3JmTFJIdjQ3bjZsU1BPRkJKK2tydFhQ?=
 =?utf-8?B?NjNxbTV5MitNaUFiUWFDVWhHQ0pLZklDV0UwSFF1cU9qUTJURE9UMTRoRDFJ?=
 =?utf-8?B?WXJDd0pvbDV4dFowL0ZFTG5mWUpiL21QdDBrVktuay9qN095S0UvQXpEdVlq?=
 =?utf-8?B?WlFqSmpBbWR5UHc3SXZ0KzRTUjMxT3c0VUlRZXI4S2pHNGdVVXNQUzRkZEpy?=
 =?utf-8?B?dmZZTGNCZ0E2K25ja2ZOa2xZWDZSdnEvWDVwSHNyUjd1UHRuMHFielptQkkw?=
 =?utf-8?B?cWJmbUNKSTllVVBkT3Y5WU5haVFSRFpyRXR6UG0zOTR4N2Y1MjBvWXJ0aFo2?=
 =?utf-8?B?QjJUQTVhQWN3RGdXWEdFWkU3VlUySGd2QWdYOUgwRE9WTVdkLzhwY1k4OW1y?=
 =?utf-8?B?STlWOWFEaXB4REdBZW1aSEFBdjJQdFJlUnNsbG5wR29QL3M4YmhEVXVsR2Uy?=
 =?utf-8?B?NTQzVjdmWjl2Zk0vZXFMMTR2K3JTRmhNRmRaMXI0QnJBajNCelpnWDI1SVlS?=
 =?utf-8?Q?3qMwRx78AfTGQq/DoSr0fSLHx05Q87IsZrGj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(366007)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzNEV3VEaUNsc2txd2VrMDFFQjVXYm4vQkNwY0YxeVRNU2hmQ2E2TzBuMVc1?=
 =?utf-8?B?eEx1aUFmRUVaRUVxM3U2SEpCcnUzZ3VHMy8vRDhoT3luSVZQZWlsVkRDbXFT?=
 =?utf-8?B?d0tYOHlDemNqR0RyNnR4dFl5UWdFQW0wcnM4VHNUN1hBbTRXWWlLSTFHcGll?=
 =?utf-8?B?cXdpYmx6R09sNGhnYzZBQVcwWm11SmlFdG5FTm55Q0FTSzVPMDBLN3ovTlcw?=
 =?utf-8?B?VzVuWGttdUcxS2x0T2FTZlZRc0dtWnF6K3FQVFA4WXYvdE1lL2lwSkJWSGIr?=
 =?utf-8?B?WjhTNWNZQ01xamwxMlBBL0wrczM1MnRJcHVERFE0SWV6Wm1EdUlScVhyb1Rq?=
 =?utf-8?B?UXlXMGo4VGFaYnlsaTVWMWM5TzNwdnNmT2xnS0M4T0tuNmwvUmYxdytaemJN?=
 =?utf-8?B?Z0RYTE5sRXVGN0xLdFBzOENaNFMrd2FjTmZEaFd3R0lNNFpJb3gvdFJMcFk5?=
 =?utf-8?B?SlpaN0thK2REcThKNVV0OXo0VFJYbllyNjVnQjM2SUJZVVA3Q0pXa1RvRFhK?=
 =?utf-8?B?ZmM4R1prTm9jYjFyVzNNcE5QKzF3UVQ3VGNmc0xBSUxmWHNidHd1VnZibGwx?=
 =?utf-8?B?RmdHVkZjdTVkYlQzdzJXZTU5dDlpMGU3Uk8rVnMrTnlBSGxad3dtRzFpZ0xE?=
 =?utf-8?B?ZTlqMmQ5anB4L2daOFp0cDhud2JoS0VZdGMyNnpJYlBlTzVqekVTZUJjTHVF?=
 =?utf-8?B?VDhlMi83UHV0OG1JVks5YTAvZlpsR2xBWURqNFhDRnhQdjV0STlpWnQ4UHJV?=
 =?utf-8?B?RnJVUVJaLzhMYnhvTlhNRW5ZRDNTaFg3T25VWFlFZTNhRldXVFRZZTVZV2t1?=
 =?utf-8?B?bWNJNGZWNlJPbmZOVnlxN2RneFVEc0JwamcycGd3c0FZbzVwOWhvaTN3ZlNY?=
 =?utf-8?B?V0NNZWlMcUhsN2JnYWJhNEMrR1ROaTViL2ZYdmJoWVV3b3ZYVWNPZ0dXU1VW?=
 =?utf-8?B?RVp2dzN5ekwwR3orMXB3NTk0NGpFaGlYcFRCdmo2THQ1SGRFQTVMS2pUTDV6?=
 =?utf-8?B?NzNWVjRuYXhxRnFVdG8xc0h4RHFKeG5HZjFic1RTK3lJSzZTUEJsRk1WUlFw?=
 =?utf-8?B?NGVOTFYvQ1hOdk1oOU1Eb3hudjR5QmN1emFhU1FQaEp4R3VNaVkzbnN3SWFT?=
 =?utf-8?B?K1ljTzM0T3AraThkOTY5WkhONnFFU09xeURWNGJ6Qk1WVTNYTDA2Y3c3T2J3?=
 =?utf-8?B?UkpXWkNYeURmSTZSUjFhQ3JVSzJwOVlidG8yUUJNVlE3ZU5ueEpNU1BkU3JU?=
 =?utf-8?B?K1NaR1paanRrWlhtQjkxRVFUcjk5TUJXVis4ck1QU1NBZklCRVFhYW9aaHVT?=
 =?utf-8?B?N0d2bkdLV01qVWpDU2U2cmxUSWhnVG5wYW9jLzBYSnZBWDFmU1AvaXFyVjl3?=
 =?utf-8?B?MzFsNlQyYnJUanFlVFdVQzhiYTBBQ3dmNGRyYWdaUXFaZm90MmNwbnkzSEVv?=
 =?utf-8?B?UXozMmYyc1hPRzZEbFhFTjVKaGdDekVCTjhiVXZUdE9PVjQ0OUFqSHFFblQ1?=
 =?utf-8?B?bGFxaFJOaHNFYW8wSkc1bm5HeDlIYWtnR0Y0LzB3L1ZveS9ZZnIwcWl5dTJh?=
 =?utf-8?B?ZDVsa1dzTGczc3pmMHM5ZWMwVEJ5RW5ZOUIzVjF0dllBeWFDcVJsWktrT1Vj?=
 =?utf-8?B?cEJoczFiY3RUYWdPYlhCMm9Gc3MxbVdKVDlTT2N5MVpxWTVKb3NFN29pTUJE?=
 =?utf-8?B?bVJLTmJnTFpTWFdnOVB0elRWSHBtYU9IeE1leWl1ekY1OGZWd1NiSDFsV3E5?=
 =?utf-8?B?OU56VFdNcmlsMXVvVXhRcnVoMnZGRUpLZkFkU2VVUjgzRWFySCsycFBqWHVF?=
 =?utf-8?B?cUZWS3NDRDFCYmtLNGw5ZFIrZzYxTnU2dmpuY1ZRMHY4NGJVa0VIeUVOejBU?=
 =?utf-8?B?WC9meDVRak1BVHhlYmtUTnNnS1dOS0JoRCtZMUdyNExzUHZFTzV5ZU1ZK05V?=
 =?utf-8?B?VWlFSVpPeUVMUE1TeUtwNTVzc04xMHBYTE9EaUh5Mi9lUE4xUE4rakVxemZP?=
 =?utf-8?B?SjhEOEIzQWgvVGxMSHJ2OVU2bHNzOEl1eWNxYTNCN2s3YnRDOGxtejFJbU9R?=
 =?utf-8?B?S2g3WFRpcmx0VkYyS0cvbEJBVlpZb1QxcEplbFJaRGhKdGNVRHBhZmI5cFhw?=
 =?utf-8?Q?yhI7PKgEqXZFySEVzVldn9Z4T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a797f85f-da26-48ff-4da8-08dc69dda962
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:53:13.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Epo3rPF9ea6ewaRMkGPpJm+PckatLqvHnIGPFP0/stFX3SZcV8pEmI6V6iT2qTsH2ITL/QfniVoTBL1izJRArA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c       | 31 ++++++++-------------------
 drivers/pinctrl/freescale/pinctrl-imx1-core.c | 19 ++++++----------
 drivers/pinctrl/freescale/pinctrl-mxs.c       | 24 ++++++++-------------
 3 files changed, 24 insertions(+), 50 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 2d3d80921c0d..cb129325bf24 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -63,7 +63,7 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct group_desc *grp;
 	struct pinctrl_map *new_map;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	struct imx_pin *pin;
 	int map_num = 1;
 	int i, j;
@@ -105,7 +105,6 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
 	new_map[0].data.mux.function = parent->name;
 	new_map[0].data.mux.group = np->name;
-	of_node_put(parent);
 
 	/* create config map */
 	new_map++;
@@ -580,7 +579,6 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 				       u32 index)
 {
 	struct pinctrl_dev *pctl = ipctl->pctl;
-	struct device_node *child;
 	struct function_desc *func;
 	struct group_desc *grp;
 	const char **group_names;
@@ -605,17 +603,15 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	if (!group_names)
 		return -ENOMEM;
 	i = 0;
-	for_each_child_of_node(np, child)
+	for_each_child_of_node_scoped(np, child)
 		group_names[i++] = child->name;
 	func->group_names = group_names;
 
 	i = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		grp = devm_kzalloc(ipctl->dev, sizeof(*grp), GFP_KERNEL);
-		if (!grp) {
-			of_node_put(child);
+		if (!grp)
 			return -ENOMEM;
-		}
 
 		mutex_lock(&ipctl->mutex);
 		radix_tree_insert(&pctl->pin_group_tree,
@@ -635,21 +631,13 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
  */
 static bool imx_pinctrl_dt_is_flat_functions(struct device_node *np)
 {
-	struct device_node *function_np;
-	struct device_node *pinctrl_np;
-
-	for_each_child_of_node(np, function_np) {
-		if (of_property_read_bool(function_np, "fsl,pins")) {
-			of_node_put(function_np);
+	for_each_child_of_node_scoped(np, function_np) {
+		if (of_property_read_bool(function_np, "fsl,pins"))
 			return true;
-		}
 
-		for_each_child_of_node(function_np, pinctrl_np) {
-			if (of_property_read_bool(pinctrl_np, "fsl,pins")) {
-				of_node_put(pinctrl_np);
-				of_node_put(function_np);
+		for_each_child_of_node_scoped(function_np, pinctrl_np) {
+			if (of_property_read_bool(pinctrl_np, "fsl,pins"))
 				return false;
-			}
 		}
 	}
 
@@ -720,7 +708,7 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 	struct regmap_config config = { .name = "gpr" };
 	struct device_node *dev_np = pdev->dev.of_node;
 	struct pinctrl_desc *imx_pinctrl_desc;
-	struct device_node *np;
+	struct device_node *np __free(device_node) = NULL;
 	struct imx_pinctrl *ipctl;
 	struct regmap *gpr;
 	int ret, i;
@@ -765,7 +753,6 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 			}
 
 			ipctl->input_sel_base = of_iomap(np, 0);
-			of_node_put(np);
 			if (!ipctl->input_sel_base) {
 				dev_err(&pdev->dev,
 					"iomuxc input select base address not found\n");
diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
index 90c696046b38..409efa1ce8f8 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -226,7 +226,7 @@ static int imx1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const struct imx1_pinctrl_soc_info *info = ipctl->info;
 	const struct imx1_pin_group *grp;
 	struct pinctrl_map *new_map;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	int map_num = 1;
 	int i, j;
 
@@ -261,7 +261,6 @@ static int imx1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
 	new_map[0].data.mux.function = parent->name;
 	new_map[0].data.mux.group = np->name;
-	of_node_put(parent);
 
 	/* create config map */
 	new_map++;
@@ -508,7 +507,6 @@ static int imx1_pinctrl_parse_functions(struct device_node *np,
 				       struct imx1_pinctrl_soc_info *info,
 				       u32 index)
 {
-	struct device_node *child;
 	struct imx1_pmx_func *func;
 	struct imx1_pin_group *grp;
 	int ret;
@@ -531,14 +529,12 @@ static int imx1_pinctrl_parse_functions(struct device_node *np,
 	if (!func->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = imx1_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret == -ENOMEM) {
-			of_node_put(child);
+		if (ret == -ENOMEM)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -548,7 +544,6 @@ static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
 		struct imx1_pinctrl *pctl, struct imx1_pinctrl_soc_info *info)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	int ret;
 	u32 nfuncs = 0;
 	u32 ngroups = 0;
@@ -557,7 +552,7 @@ static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		++nfuncs;
 		ngroups += of_get_child_count(child);
 	}
@@ -579,12 +574,10 @@ static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
 	if (!info->functions || !info->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = imx1_pinctrl_parse_functions(child, info, ifunc++);
-		if (ret == -ENOMEM) {
-			of_node_put(child);
+		if (ret == -ENOMEM)
 			return -ENOMEM;
-		}
 	}
 
 	return 0;
diff --git a/drivers/pinctrl/freescale/pinctrl-mxs.c b/drivers/pinctrl/freescale/pinctrl-mxs.c
index e77311f26262..baa1e806688d 100644
--- a/drivers/pinctrl/freescale/pinctrl-mxs.c
+++ b/drivers/pinctrl/freescale/pinctrl-mxs.c
@@ -406,22 +406,22 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 {
 	struct mxs_pinctrl_soc_data *soc = d->soc;
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
+	struct device_node *ch;
 	struct mxs_function *f;
 	const char *fn, *fnull = "";
 	int i = 0, idxf = 0, idxg = 0;
 	int ret;
 	u32 val;
 
-	child = of_get_next_child(np, NULL);
-	if (!child) {
+	ch = of_get_next_child(np, NULL);
+	if (!ch) {
 		dev_err(&pdev->dev, "no group is defined\n");
 		return -ENOENT;
 	}
 
 	/* Count total functions and groups */
 	fn = fnull;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (is_mxs_gpio(child))
 			continue;
 		soc->ngroups++;
@@ -450,7 +450,7 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	/* Count groups for each function */
 	fn = fnull;
 	f = &soc->functions[idxf];
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (is_mxs_gpio(child))
 			continue;
 		if (of_property_read_u32(child, "reg", &val))
@@ -490,16 +490,14 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	/* Get groups for each function */
 	idxf = 0;
 	fn = fnull;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (is_mxs_gpio(child))
 			continue;
 		if (of_property_read_u32(child, "reg", &val)) {
 			ret = mxs_pinctrl_parse_group(pdev, child,
 						      idxg++, NULL);
-			if (ret) {
-				of_node_put(child);
+			if (ret)
 				return ret;
-			}
 			continue;
 		}
 
@@ -509,19 +507,15 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 						 f->ngroups,
 						 sizeof(*f->groups),
 						 GFP_KERNEL);
-			if (!f->groups) {
-				of_node_put(child);
+			if (!f->groups)
 				return -ENOMEM;
-			}
 			fn = child->name;
 			i = 0;
 		}
 		ret = mxs_pinctrl_parse_group(pdev, child, idxg++,
 					      &f->groups[i++]);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;

-- 
2.37.1


