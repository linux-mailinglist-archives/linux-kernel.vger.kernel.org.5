Return-Path: <linux-kernel+bounces-165290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA058B8AC2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235392860CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE8112DDA9;
	Wed,  1 May 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hYKP1dft"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8612A160;
	Wed,  1 May 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568015; cv=fail; b=l8ziBWSNnQIZFa4sZ+6E9G0zRUDbzy9f0vYGJliqz4rcHamswdw/FaxcRRqqdEJBGkwFLQX4Smg2RpAgdT+GB0DyBWu0VZaZMrU4v5thDMgmUMVw8mPwmXtTUKHQwiHim594Rtx+ByPVkdGbmUqWlysZ1/5IWKJIp0BwxwFTYxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568015; c=relaxed/simple;
	bh=o6F5l9CsoiURStmJJEE9Qa953QXfjAQBUVSJDbNbaG0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GpuDvVDHaangwPXzLWde32Orjwe8UmYcw9Lbz9i0IvfwfWpmW8jNNgjak8SxvfDp2nFHZFUDD/650zz3atD1yWxO0kMyft79J24n97CDo/4wTWdIJKEUoDMIJXg2qXPFXrwO7d+ObF5nNzZMMeYf5TQjPDgej+v07gw9urH9yj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hYKP1dft; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyMrQIQxgXLORY8LgQ5cGpC7twhaNxkvD3iy5PLxMztUxxou0azI1OJnKW1iyrzBNk/cLawtOpfT8lECCoL5upFGQ3HwnyavPOGLvLa0fprUdKd9TilG9ElcANWu19ggXOCIPre+Ad33wohA7iVw/cHvIQOXq8swKz/JenNflHcgZLscvXZVwQjp9+rFlNd6yJhemvK0GHryctLSKZsfwcUa86E3w0FRLyMb2uS2p1yTsxx1bYgVjYsu3PPeizj3eX/fbiYTsloA6rUN/LM39NFEF9tYocvTP09sicy5uwpWNttuF8IIqXM3Px7Wv6q9JZrrvgPAdi/IN0b4DitF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8YW68N9lyxeJ9/mVk16q9wzxsh3g7k9BYoR+TfhQy0=;
 b=VVGTDZyj1RnAl01LIEHARrjBeQCzbPXdSqcc+xAEJvih9ssxrCmMTAGzrvl5fSzFoeIXN7bqNMQRMDkxsaJW6yLLv48C6zdL7R3gHjqSK1xPGBGmYADBhs4/r47mwAnGOYTkizyKE2baPQNIfm3wGBOxda/w/t4H+3jxy8qLUHrm0unBWZKpfUGNe785lB7URe2BvDgV04Q1JT36dWv98bil2RiMYptLeGpXI239htCSfAd8JjHC0BUiHwcq00RtL1ABPBPqcwlBmCGFSYRql/KGBbLfRmHhDxvgn+55viKLPDZmq3WghXJdn9euYvr3ZK0WHhloGd1Uprkk42O6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8YW68N9lyxeJ9/mVk16q9wzxsh3g7k9BYoR+TfhQy0=;
 b=hYKP1dftAW2q5LqCOyS2XVjSGY/jHgc1uYQGjzMPqbIQvIKeUz+umDZ6TIdK30LOv92UH+K5CPMIij1gC1YSMZzZftVJfMwhzQhxAJ2Hv/4koEwPM4yWJ0fEfRlzYMWUYW5ANVHxX3Fpss5iUkQ7funftKAYLi4MN0da0FdGQOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 12:53:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:53:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:17 +0800
Subject: [PATCH 19/21] pinctrl: bcm: bcm63xx: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-19-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=1176;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ngb8bjYWoY2vP8GroJ6WPcYXu1rPDt13jwjXmDP0P84=;
 b=inAIaru0WMRLGzM3hLBhV+swvKEs0M2rx4eFAsHRDsmzb0LTjRVPF2wrCwtv0nZ378wxJlsEK
 ubzlBlL/0H8DPj4CCn28aHMnunMnRVB/96akcAo3TUmqc+aFkdavPMN
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
X-MS-Office365-Filtering-Correlation-Id: 28a73565-6187-4894-ea9d-08dc69ddb2ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|366007|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnAzR2ZwdE1LMndXZHAyQmFsUWpjVG5RVFNDK2hJeWtuYUZOcjFPQTNZSFlh?=
 =?utf-8?B?NFpRMDlCdC80WFo1TUUvOW0wSGJTMHZhWm1TUUtRWTQxUjV1bkp1bUJ4OWcy?=
 =?utf-8?B?dUV5R0tiVVhkNWJDZ2dyMXJBWmkzVjU1SGlzMWVkcGFLZkpOWE10QVZiY1Ju?=
 =?utf-8?B?dVJoaDBPNmdkdmhvMDEzMFV5c2tJeFRrSkdoNGdLN1I1bHlWeDR6ZUJ3Wm5o?=
 =?utf-8?B?cWswZjlsZE9rYVhmZTBRZ0dmTTRNa1BEQWJSQUhPSm12SnJEdGhod0QyVkJT?=
 =?utf-8?B?Z3JLc25MRXZJSG16VEtpb2NQTUNhRFBPbzlTanNabXhSWk5aaFFja2VzMTcw?=
 =?utf-8?B?aExqVHA2RkFiQ1FqaEhkZllyY21FbXB2OElHUTA4Q1lGc3B5R0RVSHEwNUpq?=
 =?utf-8?B?MlZRdHMvLzVBTFJLSTRPOUl0UWxmNG11M1MzeHRpQlR6ZmZRT2YyRGpsTkpq?=
 =?utf-8?B?WXE5b0FxcCtuUXdBVXlPVjZ0Y2V4ek5wZndMU053OTRqUldjMjh0cEljN3p6?=
 =?utf-8?B?Z2FlcngzeS9wNHFtVWE5bWFaek9lODdyZ0I2K0ZIUlRKOHF1MFFhOTNuZ3hz?=
 =?utf-8?B?MDFFd3VpTVQ5STc2T01PZnNabXA0Q1RQYmFQb05VOFI4blM0Kyt3cmlPZjA2?=
 =?utf-8?B?OE1Pc250TVhOZUx6OUs3TGRQcnFJblE5bEVuakgvOUg3V2JCWW9OZjN5YnB4?=
 =?utf-8?B?S1NJYzNyZnkwamsrS08xRnBabWxyaXRWNUk4b0NicDhDRUlNWWVvQlBuaW9W?=
 =?utf-8?B?eHh1NFU5Mk4vZWNyT004aDUrU0pVdmd6K010TGlabHlYMXlqSURXdVoyaDZX?=
 =?utf-8?B?aWp1ZmxyOUpkaEFGRXRidWkyTGVvOTR3R05jODExZkJZRHgvcnh5cTlCd2lr?=
 =?utf-8?B?aktWb0EzRUU2MGlyNmZwZWNEMEppZ3lDcGl5am5yaXJwODVWdno1YzQ0MG80?=
 =?utf-8?B?aktya0JLY1ZVVUVRZVhTdWNHYTNsL2xQZTVyYW5vZHhLRkg5bUd1YzhjdzVj?=
 =?utf-8?B?QTFIQWgzbmJzRGhGODh2dWRvNXlFejhEa0pyMjladjYydHpjVnpqNXRCRVgr?=
 =?utf-8?B?d0FQcTYwV2VsU05jWjRYSHlHMkFDazlSMFc0aTZrNzF4ZU1STVIvSU5kaDRx?=
 =?utf-8?B?TTMrR1hYNDNld3IvM3pncHBDelNZejBtL0Nac2VjNXAvYUZxMzZGYlZnMmtW?=
 =?utf-8?B?ZlM5Yi91VFJDMjlpYktweTg2UkJUTldTZFloc0NvZ2c1Q0hNdkNhNmFJWWdB?=
 =?utf-8?B?dkRFRURUMW56cTZqK01GY0Znbjg2S3VqaUR6NUlKZ3ZTbEwvTjY5cGd5c0dL?=
 =?utf-8?B?Q0s4NVlqRzRWcjlicDFYNHM2Vnl5c2RRSVIzWmxHWWxjeCs0UThvRWtXNU5N?=
 =?utf-8?B?cThleUxqUW5RVTNhWC9oZHdQMEZNZHBaUzRaV0NZTGJSOHNseU1QOUJXREtN?=
 =?utf-8?B?NG94YUpNVXNYVncrcC9OV1k4WURWMGdReDJ2dFVCK0RJRzkrNk55YUNrQnoy?=
 =?utf-8?B?ejlIanJlUVF0MWI0NGlGc3JMTFdtVzh3Q2FWWUZCd1pXZDUvVnJ4aTR1aVpY?=
 =?utf-8?B?L2pNSGk5aGs0cGJiNWFBTVBJaXcwc09oczFiV2MySCtRV0xEMUZXQWg5bUVZ?=
 =?utf-8?B?YXR4TE1wc0lHTnBpTWZKMlBUL3VCUU9MREJRSU5kb0llb1ZEM04xdVpqRDJz?=
 =?utf-8?B?Z3l0T1dCNXp5Wk5XL2psM1BVRW96dGJKQkJWcTVSMGFYU1ZhcUl3SnJ4OHVZ?=
 =?utf-8?B?dTVicW1JNmJxcEhuQWdtN2J0a01rd1RkdFJFcDlNQ09rS1VyV2dPNHhlM0tr?=
 =?utf-8?B?SWNRQ2V2cmdtbXk4Nnl5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(366007)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFI0aC9VYUIwek1tQzVMb1dkUG5PTDlhcWk1ZzBYaHA0dU9lbmRHMFBVNlc5?=
 =?utf-8?B?bEdXejRKVUF3RTI3NnlKS3RPL2p1Rm90clMydUs2dkhJV3JGZVFQZUcxWEJV?=
 =?utf-8?B?TWRxekxhOUsxdDNiRTBJQ2R4VFdzYWxENnUxeVQ5WUp1NTFGUlRBS1hUZnJQ?=
 =?utf-8?B?T0NZQXAyQStMNUhHYUZ2d1BkY0FZMDJxcDZ2T3M5ckdOOFpJaS9qcGJyM0xp?=
 =?utf-8?B?dUhqUUZuMVhpOWIxdUNHaDgvNjJJdi9pOGJrWmQvTVZPWlZLL05zNno1bWRs?=
 =?utf-8?B?OGlZenBLcjRqaFhkR3FhaFNZWkVNQmp2ME5qcndXRCtBdUY3eTYxeGZpMisw?=
 =?utf-8?B?VERudjRlY2pSQUp2QkF1UG1Cb1dxTjIwdjlkZmxjVW1Yc0p5Z095Tmp6a09X?=
 =?utf-8?B?L1ZjcCsycjZaVDZaS3QxMjBCOTc4b0swT3hXeEkrMWhHak1TY09NMlFNNWVQ?=
 =?utf-8?B?RTR2dUJ4UENQZjlGc2pKSE5RelBCR0hQTjdybjFEZlhWdjc3MDZMYzZsQTly?=
 =?utf-8?B?YjlDbUtDVmtVSlFEZVloSXM5QU1CakxSVGs4WGtjTDZ4Qm5vclFJNFQwb0dW?=
 =?utf-8?B?T3E4bE1xd0Q1UFBiaU9DUDh0ZjJ3endULzVNYjJlWmM1NUdMWGlYYlVLMkxw?=
 =?utf-8?B?dEdHbm85LzFicThScXZnUkNFRzVWZW1kWG9SMEZzTkJTK2RuZTc4eTFWVXZG?=
 =?utf-8?B?bkNiZVlPajRWRW9qUnQ5eGlzVGlpbEVvbUtLY1JxcEsvSVVaMWlub1JQZjNq?=
 =?utf-8?B?ZXNDTTJpcm1qQTlldXV6SVkrdFBrWTlQVUxxSGJyQllsL0NEeFpUOVdxbU5h?=
 =?utf-8?B?RGNwVlhYd3VCMUFsc3lxeHZabUFYSTA4b0J0WTAzaG5mWUlVMC9IYityYzBv?=
 =?utf-8?B?QXJ4amdrbGpzNkNVelhKeVV3N3FJL09RK0duVVMvMDN5WXNzQnU0a3VwTDF5?=
 =?utf-8?B?bThyUHhtZFlkVWN0TEZMN2N2bGNzekR5Ti9xL2t6dyszcGljemhybGV5S2RH?=
 =?utf-8?B?UVR6Y2lJaG9ISkRhM2ZYYnpqM1d3eWV6VndRaENyMWdmd3E5cWw1UitzRUI3?=
 =?utf-8?B?MzJ2VVJWbjUxRjlyVHBYUm16L00vR1VxYlNTbVFaaHR1YzJuTUFxbnhEbXd0?=
 =?utf-8?B?Ymw5bGR3bloyYzZIbGdRaHlNUzZKVVZGVlFwdkxQUnMvallocU9IZ2dtTDVZ?=
 =?utf-8?B?dlNLZ2d2OUs2cGFsMDN4ZjZOZHgwenB3MERQN1AvZVVPcmtGTWI5NmY3QVF6?=
 =?utf-8?B?aDZjam1jd2g4L21oV1lNZ09JMFZkaG9zd2hXYW5sZGQ1eHlwTkJuYkFNQkxr?=
 =?utf-8?B?U2ZWL3lVMXFSZDQzVWZjdzg0NEtNL0tYK2FiMkEwVGNlU3JlN0dhM3RScFlm?=
 =?utf-8?B?V3E2ZFp6N3BnYklwS0QxNm11TTRnN1RtQjEwMTR2YTN3ZlRxWko5Vys1a1Jo?=
 =?utf-8?B?UW9RRUFkc3JOcU1xandCUWU4aDAvSlZBU2s0bzAyVmxOdE5uSHg4L29zNmJi?=
 =?utf-8?B?VWRiMVlTQ2FyK21IMm81UUxaL0NkQ0VZUk55cG41OFNvS3kwVzJwOWhSWDFZ?=
 =?utf-8?B?RUJUYTRFYkhUbzNoL3daVDEzSExRcThuaXJibWg1MDR4U2hJY2xEQ0FaVnZN?=
 =?utf-8?B?RE9ERXNCTU01K0tMQnk2VjVrQmJ2RjZKV243dll3M2ZZNTU3bDRzU0tucG1K?=
 =?utf-8?B?RTNaVlF2alNMbUdXdEJIQS9HUlAweDBqYm5BOFFtZnJOZTB3WWtIM2tlSTlO?=
 =?utf-8?B?RS9MTlhwNG9kQ1VJYUxrMEZQcmpsZERwYUVveDdleDVqZ0xDSWRTUzJ4ZEpo?=
 =?utf-8?B?TjNXcEd4SldIZ1VUekx0QTZaemZCcVR1KzN4ZUpaeU05Skg1VUZOQ3Z1WGlH?=
 =?utf-8?B?R0VnN3VybW80c1pLOHVmZk1SQ3JCbWpla0Y1SGppem52TkZNMi9Eb3dCeU8w?=
 =?utf-8?B?WDJGbi96MGpBRE80YU45dkFjYmFwbG9tV1g3ZkdDWEJISGpFcG1CT0JKNGVZ?=
 =?utf-8?B?MzlYb1krN3FOY3dxMHp0cUZyazFsQWdoSWFYNXBvWmprT21GaHVZY3QvdStE?=
 =?utf-8?B?VExpYnpOQVVxUDIwWERqalhQQW1rUWZwZEdER1oycmYxSm4zbEVDSzhlM3Vk?=
 =?utf-8?Q?ktDahcjUvbrWLBFWTTYuTtzap?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a73565-6187-4894-ea9d-08dc69ddb2ef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:53:29.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtileGvMyRwe/6xhoIjtJrWVNFuE1tUQoTyK5MqWQGRWwp0HDMa5VgyQZnuVjiYwP9Invnaufxd7mBeXn4Gxqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c b/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
index e1285fe2fbc0..59d2ce8462d8 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
@@ -67,7 +67,6 @@ int bcm63xx_pinctrl_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct bcm63xx_pinctrl *pc;
-	struct device_node *node;
 	int err;
 
 	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
@@ -94,12 +93,11 @@ int bcm63xx_pinctrl_probe(struct platform_device *pdev,
 	if (IS_ERR(pc->pctl_dev))
 		return PTR_ERR(pc->pctl_dev);
 
-	for_each_child_of_node(dev->parent->of_node, node) {
+	for_each_child_of_node_scoped(dev->parent->of_node, node) {
 		if (of_match_node(bcm63xx_gpio_of_match, node)) {
 			err = bcm63xx_gpio_probe(dev, node, soc, pc);
 			if (err) {
 				dev_err(dev, "could not add GPIO chip\n");
-				of_node_put(node);
 				return err;
 			}
 		}

-- 
2.37.1


