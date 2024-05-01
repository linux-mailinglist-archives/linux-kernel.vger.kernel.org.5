Return-Path: <linux-kernel+bounces-165272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 668DA8B8A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7697EB21E48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437F88565D;
	Wed,  1 May 2024 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Kqlxeuda"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1701EA84;
	Wed,  1 May 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567772; cv=fail; b=QvwOACNGsLbHZRgyWdzQXGvyYd+oh2MyE8NKD2uKH+E2U8UEkqrWgQrIh0n6noi2DlazwMj6hc3EQaIGRPR007Pxk+MjpKEhF/kKaIWvzp0b5wc9FwzKxevrVvPaSI8Nj7rlFLr0HlVdC8xn2oUi43K05ylXe1j6yzgVReKdnZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567772; c=relaxed/simple;
	bh=T8RPCLVB0venRQNxNQUNK7eXrSySPXtqqefcl0oLISg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cqcDtdl/WeL4vN1FuUg4ZzJsYDzg/GMYjLZRJEGy7B99VpL3UjHROLLvEuvw7mzZXEDYhFFgcDaC6HeSHmnATVYCwszNrfbfYzJV4P9P2wxIJgSYZWj1cq0jya2ihmy4T2lmtbXWGDVoCa6PmGE9J0goOvBJcsAGoZ93XFmpdmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Kqlxeuda; arc=fail smtp.client-ip=40.107.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd2pkTEpxdjR4zHMJabEAK8ziMtPIJdXtnU2NZKH+0KI12XRklQK+DhQtJrRal59uhMEX9bifoohmvgy5x2EEFMBDYLWc0hreM2/HuKM6hipY4VHs1E5IuP69ZmbdMBk79aTnk43OT4jIiE8RnvutU6tvF8E7xIgMIFu3ISbNh3d2BLLA4gcmr4vSHF9NMRwF+ZP7Pi5hQU1iInfiojmpfDvkRnk8OglpS1yTeP6md24K9RxJ5U8S/Ljzs4qfLmDLU6qXyv+NyB3VmsJclpp+B5DFx4ngrVqzzvLvcsxlnfWODpBLAdlqTHHHUhLf02Y8ZevKWc9/xOmTOHFnk6zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgaCub/AVvrWstgRn7NDSa3uLOl1yukaIFVzxzPeW7I=;
 b=EhjlbkSwIpK9p5mi+T8IG4fJMmy3vM2r3qtAH+zO2GV6i1EIR0hj6DvE75r8/pNWdBh8M2gBbUvgvYvRxHqQFwETfJFXyr8NstOe3KlDaIwXGu7BQkNLDITjPC6PqUqqlIEhti7JjZLntybbY+B/96ft3UN3DhmT89ZbintLaW52oZuSNsmWfcOIwwIIL1vby/qgsy2AfbWbiEW1HCac3xC8BMKYhRFoNCqZn5E4ubYaJ0R8B0cFwqshVjIEXN2s4zLpOTI2X7rat+QyxUxL5s3o7fW/XS7Sa/6Q3zVjBeDIQ0pMir+I2ACkYrpmKHI1Gx7IYNX8RXkWZq0XezQ9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgaCub/AVvrWstgRn7NDSa3uLOl1yukaIFVzxzPeW7I=;
 b=KqlxeudasMTvhe+KYjUqTRiD3zhIewnGUP/1/6FPzIUOiA7oIwOjMAYneE8FW/eXrC47IYOR5Id2saq1vXi4EVllT7bKTH9SciPp/WSRBpQEhmxx98G8kKyQ8xHo6utAnI+1zI/YiPCeNB4NpGnYXJgg1/3kf6F9AqjO0XWHZAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 12:49:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:49:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:02 +0800
Subject: [PATCH 04/21] pinctrl: stm32: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-4-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=1839;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=3dCftRoTOrOimvH/zZhm1znYYmC195eNUPhLJhk2Pd4=;
 b=fEVszNhFmB0ozWSgviQak9c62GVC/GEZgZAP4r8VCKSloHSeg9ffm1vWAQQ+bwWtefd5irQb/
 3aoJSkKQVp/AVh9+Sc4htbGVlXth84TcdldSRvPA3MnRCqG5c4wNNYL
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
X-MS-Office365-Filtering-Correlation-Id: c222aae5-b13c-4c9e-3bfc-08dc69dd22b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEVWanQ2OExpeWw0TVFIcFphc0UzV0h3aUxCUHo5ZEM2S3ZkRUdhOXhUQk0y?=
 =?utf-8?B?Y0N2bEdsNXlydlZrUmRyM2FiamJPVUN2YnpUVWw5VS8zR2NRamg5Q1lmVmg2?=
 =?utf-8?B?dytOWUFmd29jRyttemVJMzFPNDExVVFwcmxUUHJySHN4RFNGV0VxN0s0eG8x?=
 =?utf-8?B?Tm1xVCt6VlNmQUtESnhBeGRvbkNCcnBkNVBQeE1Qc0t6R0JOK1BxTzJFZndz?=
 =?utf-8?B?QUs0RlNLTVZZZkdIeGVjWHNtK1kxN3pFN0FiTmVtVzkzcUpqNGVTbGF1SVp0?=
 =?utf-8?B?MVIvTU4rN0ttQXo0Ty85N0h3T0EwOXJuaVFBaGFzZ1YzeWxhckdZaWp0TSsr?=
 =?utf-8?B?akhzQTZ0dlBiWnN0WlBzVm9IQnEyVkxQTEhFNW10UmZxcjdZWWtSV2VGLzZw?=
 =?utf-8?B?bFNHSWRUT083V3N1V2FXVXlydWpRU29Eazg5MWs2VTdFSXRoQVlSamxmdXQ1?=
 =?utf-8?B?Z0wvcHhpTzJ1K0o5enp6dC8wcWxGKytEN3hwb3JKYmFXblZIMXBTYjVwZnZG?=
 =?utf-8?B?L2RlZENtOFUyMXRBcjNhQjgrS0hwb0hWdkEwOG9xL3JIc0dUbjhQZUFzQUo4?=
 =?utf-8?B?VHdBMmp3Q3RkekVLd0V0bnYrNGNBTEhScXBwdUxJblFHeDRvTGRCUjliV2lX?=
 =?utf-8?B?QmhENlp1UjVaKzREVmdXTnNUUUowdkxnd2tYRkNDbXlQd05GYzU1WkQ3eEli?=
 =?utf-8?B?RnNqVXJUUDZJeWExbllldmh6MStNRW1wL1B0WEw3cU9EdGV3Z2VFTllWZUtp?=
 =?utf-8?B?WXRzSDI3dmlLdmtiT1pyeDVOaUx0RTJETUVFZlNlYUMraWt5TmRCWmtmemNI?=
 =?utf-8?B?K24zczNITEVPZG45TVA1Z2JIMXhYelRnaVpmbDlhOVRZVjBGL2RrczI2aXVX?=
 =?utf-8?B?bkphK3UzeU5ob1VuSkI2dm56RGQ0Q3I2LzlQd255VUFlazg4WmR1N2Q3dUtk?=
 =?utf-8?B?Rktic0s3WS9wZjcwUDVIdFlTUnRJR0pnYm0rU0p5WDUxbHNBZVk4b1IyL21X?=
 =?utf-8?B?MXZwMVRHRWI1b0w5dWN2OVlwZzlKdGJiZGVoK3JEYjZkdHZyc20rTWpzbnJZ?=
 =?utf-8?B?WE5KZGpLbEdid2Z2MUVLVGZhM2FrZ0ljTnUwTjNDYjRVS2tPQ2ZIczhZM2h1?=
 =?utf-8?B?dWpqZ05kNEkxYTdOMUFCL1o2a2xGbUppSHlFZ1dDSzhvTm5zZElSWHJGck1C?=
 =?utf-8?B?UHR2a00vWGZ0d1hwZldsTStMOWR3RjZ3QkFENEkxd1I2TTRQUXhhWXVDSVBH?=
 =?utf-8?B?ejAvWkJGWW5MbmxGckhkUnM4K1g2Q3ZIdGlZbXZaZDNLVy9ERzlFUVd3ckp6?=
 =?utf-8?B?MEhOdlh0cVdYZnRvcU5vYklINGZGNHJvUmZkVkF5RzZIazRTRzV6TW51NU0v?=
 =?utf-8?B?UXJVb2xpNElJaVNBRHZ6VElrczJIQVFNeWNmYXRiZExhajVFUDZnSWc1MUtw?=
 =?utf-8?B?YXU4VmQ5UnMyQVh4U0lWREZKRnFQS3kxZmNEdGRCTXpoTW1kYm1mM2FjaEpj?=
 =?utf-8?B?NS95MmhVdFBpcFl0TG90SW5LMlpZN3BwS3pRSHVqRVB2SlZibnRBR1dweG0x?=
 =?utf-8?B?SUltTDRzYTljR05jVFB0dFdTYVV6eU05VjN4c1Q5N3pYaDkrdVc5eUUwRHBz?=
 =?utf-8?B?NDkxVlE1TkpzU3ViUjJmZTloU1pkczg0YzV0akdrUGptYmhFWVF6U1hoci8x?=
 =?utf-8?B?UHA5ME5mSVhOcktPK01VQ2VpL005Sm9xSXNKMlh3L2k4ZnpsODJ3cWd6REpF?=
 =?utf-8?B?TERvTXl5b2FXM3B0NEVUWG9vZEpwbU10bE4wUnM4ZjNpUzNWbG9DZDNWdmhB?=
 =?utf-8?Q?ySOIaCBmcJo2Qfwuys0yy1oKe9MuEFAOI8snE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmFBKzhJVlVFUW1kdkNQVHlGS0Q5cG9saHp4NmFsN1JOMnlmLzdXaU9kR3Bv?=
 =?utf-8?B?RUlpUkdhazlDUHFJcmZqMER0UWJpWGJpSEdyZ1hDaEJ6YTlsRjN0YzQxSXNI?=
 =?utf-8?B?b3NpbzR1b3k1aW5BQkFqNE4wRjNnZmJTUnowWFI0K2ovODRodTZTcXQ3WFpX?=
 =?utf-8?B?eHpHRG03UEhSSjVzUnFsTnRWNTZnNlNRL2h5Qmw2OU81ZFh2ei9ORVRBcTBw?=
 =?utf-8?B?RmI4Njcyd1JqMW5vQ3RWNVQ2cUY2THhlZDRTWGYyY1R6all4OCtDV201R3k5?=
 =?utf-8?B?REoyZHhlV2VOaHRxNHZpL3JuVkExbGhIWEo1RHhqRkgzamE0ZndUUlVwbEFn?=
 =?utf-8?B?WGxHYkpKaWpiZTg1YWtId1NoRlNQOXNpNElNblkrUDk1Z1ZEL0hCWUVBRTJR?=
 =?utf-8?B?bDBuVDJ4WTI5bkNNME5IU2RXYW8wV2FrcHhyczM4SERtRm1kRWVKVHFNazl5?=
 =?utf-8?B?WUl0UTE3SlphZHVxZlNEamtPYS9TWm5DYk8xTzdvTUdiekxuOWhjMk1UK1Rx?=
 =?utf-8?B?eVV6NC9ldGxGQUc4cmFtT3BqUWNxODBoaDV5NjM2emlDS0d4VzkxeDVnNWZX?=
 =?utf-8?B?RFZpWjdoMUhvbVBFTFRadE9xQXI1a3h5dHZTbHRVb1VoTGNBS1VsNUxJZlpK?=
 =?utf-8?B?TkNDVTBXSHFtRTRQUlJ2alpjNnJqNzZnZWI2c0NBSTdoU2ovWk1sQzJENkpz?=
 =?utf-8?B?UldkUk80UE5aOGVkc01XYy9PTEpoeS9SRlc3TTdpd2VTak5UTFZFWjBhZytB?=
 =?utf-8?B?bFBlNmF4ejhqa29DUHJseWh0bXZhWGVQZHZTMHZRMTh0SHdadmlPVHczbWZx?=
 =?utf-8?B?Y3FFSnkzd2VoZXlkemlJQUNIR0J5aTgrOGsrUWZQNnYzV1VyTmpIK1RZQVBj?=
 =?utf-8?B?dkYzc2NFejR2Nk1BYVFGNDdyVUJzVVJlZkEyVE5HZW5lM3dNNkJ3ZlpSUStt?=
 =?utf-8?B?ZElLT2RrbmlOMkJnYU9rMDVwUUlUQytBclJmdHl2SGVJK3haTlFmaWJJb09i?=
 =?utf-8?B?YlVocVI2ZjBJaEhtNEVMQnM2NUEzdXYxNFAxNG9kWityR3h3d1NDMUp2VDBL?=
 =?utf-8?B?YVhQL3p4ekRoQ2V3WitYcEV3K3E1L3VLVncycDkxZXZLZzR4bjk2bGJQS0du?=
 =?utf-8?B?YktQeWdNcXpISnNOTXllWmMrSVREUzdwNUJHaklTaUdOak1xaHNDSk9XeGJ1?=
 =?utf-8?B?QklyRDBtU3ZITk55UTh0b1J4T0E4SmdPczcwVWlKTnpKT2J0azQrZEpTak9l?=
 =?utf-8?B?dHFRY25nTm83SVRTcThmZTBqWERZSyt0VzhPdkNNd05oMkFiVXlWb0M2TFlO?=
 =?utf-8?B?eGwxdHp2dkN1K1pRWmFmeDN3VVlEZDBPZ3VvdU8rc2E1aU5aKzdmb29DUDk5?=
 =?utf-8?B?WE5wb1MraG5YY3M3dUVWRXVwUXVMck1wYkc4dFlQaGNjeWhDc3E1YVluZ2pT?=
 =?utf-8?B?QmRCaEdtODNmZGlVaHBHT2dyQTJ3UjFCNHlUaEgyVVBWaEIrZ05aS25lZ3p1?=
 =?utf-8?B?VS84UWs3UlVjck12OExJRDJuUUx2MjRwd1AyNlg3Ni9SUitFemFCNjVuRUZ5?=
 =?utf-8?B?Y0g1SkJPUmVmZFRqUG54T1pMejJMYW5zQ3kwWVltNzg5T0QzMVhuSXlnOHdY?=
 =?utf-8?B?M1R2L0F2NnRXL09pNy9kOWFBdFNlTGF2NzdicjEwNE5GZXQ5bVozdUswbmhD?=
 =?utf-8?B?ZDk4NityWSsyVmVQVCs0QlNUdzI3NU16cmg3RkVxeC9jNFkvYlVjZjhtMWxG?=
 =?utf-8?B?WkNxQUp1dnJybE1xWG8yV2JUbDNIV0JXVEZvZmdPaEtiek5WeHRXeVAyK05F?=
 =?utf-8?B?ZmNja3V6TGN2OG1Od3NZYU9ZbkJWYU56bmZpUTFmYmJmcXVnVHZVQXdWQXpU?=
 =?utf-8?B?VGp5d29xbU8xMUZ1ZW1QQkxTTW4vRnV0OFlSKzNkVWhoL1hYYUx0cVRvSWgv?=
 =?utf-8?B?SGJaNlgzWDNYV1NMbVBieFg5T2ttWGxRaTIwQWZvQXFDSEtuU1JjZmZCbTk4?=
 =?utf-8?B?Ry9Tb2xDMnA4bzdQdzBVQVJVbFZOZXlxb21aN3YrOXhvK1lWdjB2Y2ZWNTBO?=
 =?utf-8?B?NHIwM0hWbi8zZk1JRHJjR3pIQjNMdjVtcEVBWE5HdWJUblFJWG53QnRoYnFV?=
 =?utf-8?Q?nNSW26EE2r3dBOQn0swugUaaQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c222aae5-b13c-4c9e-3bfc-08dc69dd22b9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:49:27.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYhhvpfni11AYjiQmPbJI7VN9cJiU/58D8H2Bm9JL6Fv8mo+F82kEz2zeToWO4luMT6owRB/C7fRHw0IinuiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 978ccdbaf3d3..ca163a91e724 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -670,7 +670,6 @@ static int stm32_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				 struct device_node *np_config,
 				 struct pinctrl_map **map, unsigned *num_maps)
 {
-	struct device_node *np;
 	unsigned reserved_maps;
 	int ret;
 
@@ -678,12 +677,11 @@ static int stm32_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	reserved_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = stm32_pctrl_dt_subnode_to_map(pctldev, np, map,
 				&reserved_maps, num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}
@@ -1401,7 +1399,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 static struct irq_domain *stm32_pctrl_get_irq_domain(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	struct irq_domain *domain;
 
 	if (!of_property_present(np, "interrupt-parent"))
@@ -1412,7 +1410,6 @@ static struct irq_domain *stm32_pctrl_get_irq_domain(struct platform_device *pde
 		return ERR_PTR(-ENXIO);
 
 	domain = irq_find_host(parent);
-	of_node_put(parent);
 	if (!domain)
 		/* domain not registered yet */
 		return ERR_PTR(-EPROBE_DEFER);

-- 
2.37.1


