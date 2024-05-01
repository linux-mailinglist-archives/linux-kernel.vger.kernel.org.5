Return-Path: <linux-kernel+bounces-165281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336CC8B8A8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569951C2259A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2512A15B;
	Wed,  1 May 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J0l5AzVh"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71343128375;
	Wed,  1 May 2024 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567901; cv=fail; b=YINtHBGsBZM0HRGzj1IrXJtqWp00k0XbRklmpr7FRA3rjYmLwW/igU39bTC/6WQo38m0yXf0NajKyxW03y8pS3X3PwVy/mVVFt1Mva+ACbniXI/o6tpmeYgqDMt6w/6QBhThel/CgwD9M7cphEvGlo1UVgIrK9U3HC2v9Bxti9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567901; c=relaxed/simple;
	bh=FyFseGQJmsq1rScaeKVJgP424XsxB+ntR+56HIl8ufU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OB4bNexzD/yjl192WtdBd7eIGtUqoZshCNSy9gF8NJh7UT5x95vTYGfXsli467Q5pJl5EQDLdFr25t1HJKb3x9w5Eqd1lRiUsgd2Wl9Y2xzoOb6h5Q8hz0sUl3wJlFncBl9dPPPGliZgkO0PhREk7R1iC4B0MInO8G9eKiOiUUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J0l5AzVh; arc=fail smtp.client-ip=40.107.8.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs/uFvgGf7J0mxLLz5tqMXVQpRAbjNRnrtuTQbZ6xFVpU64vWpZmo9HpwTXQCzYWa/HJKKrOe/eZ2LXvaD7BQpwtS35p6j+C3nHQPmpFkavYuPe49nGT/vYZ2PxuzKckhkgcKJnRALoAjs14PBQRXfw+wpWZz1F4HOV4K08oUgwQ/nQccuyhLsOj6sfUNh6EVzaI1MDoF1P6KFSUv/bRlm4BDMunzwy6a4Pql8aH6MubiYkRDyqTECMdJioasGac5S7OO1nGI8smTtubeZWu4hx2Zxo2YASvo6F6WclWhhg3cwrCbVzrRoQGVW9wE67+o8LcZUIVErxfehoC9pUrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPCG6xZzK0LC/23B+oYJdueIO/buCemfRXEoPX5rvQQ=;
 b=WSKsscBH/bb9MG7MVyy1EWwJadP4dUF9oRYqYVXqP1NvUQsivx7VTQum9bh5dZ1NPmqaQG5/UfgSqVfRvrJueC8jNckZedJ1B+rZQpUffq1JZhB1WUBok9v8viacjarKybJZiRKExS+Yzt/Vp32cvtPmypPWQLhA5JZxl8GalrEcvOe5hGtHiBMHhKTSVdtEYl+kRVC2e6NYt+lwMHyL/rxSA4PqvweVB6KjTvSpA84uaJJ5P1qPQ2bWuGG5fN23/NzqDDeEnIqz9D15lbHAzBkPSlQt8kduLqW6gOjdKeXK/y3LXF++LsxW8385Xamq3bygfFL8grCzsdU1a1yDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPCG6xZzK0LC/23B+oYJdueIO/buCemfRXEoPX5rvQQ=;
 b=J0l5AzVhTQLI1cvCJWqrnkayUw54jIhbmT/JLizp4vhOXVmPOPL2GaBkwanqaOQ4Tt6Tsd1mFCnsi7lXcugBlt5Nz7/1ZDX/ubywgnJK+CL5/gUTdJYp8HKgg2ITuUUTWXWHuSDdhClCPMs4JiahxWDFOva3o+Asr5VsZyprN7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:51:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:51:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:10 +0800
Subject: [PATCH 12/21] pinctrl: k210: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-12-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=1076;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=58KovdEVBZIsn2lfhZ/T0dqiN9oElq31ckJF6Ac0RQ8=;
 b=c3FRzwq+30RvCffuhcmIdUhGjJH58EpOfxv532cKlTQz1SNPixnIM2vMx7FK/oFWna1WvxNc8
 KHSDWPwcDuiBDzI/9ofA9cO0ZgozcaCukmcjlONWBqylIbTo8zfaTkV
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
X-MS-Office365-Filtering-Correlation-Id: d5210ffb-76d0-40b7-74e1-08dc69dd6fa8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmw2RFBBU0g5U2ZicSs5N0l1K2xMKzR4dURwSmErMUZvT25KemgzU2tpdUox?=
 =?utf-8?B?M0NLd2xXazN3MEszLytaRmg3by9QT2ZBdzdPT2xXL3hLQ3MySUNEdzRTVHd5?=
 =?utf-8?B?SzVkN3o3QzJRdzhTNU1zQUE2MTNzRThPeG9BajljaFRrMEcxZW92U2ZMR2c3?=
 =?utf-8?B?QjJhSE5BS3NVVHJkTHhFMExaamVJNHZXN3ZGUTdqSTdkeDBvdUQrbVRaWjJZ?=
 =?utf-8?B?YUp3aU5vTUd5VkpEWi9vdmI3VXBzN0x1NjdBNjNMaVZPSHNQTWc1dzJVVnpF?=
 =?utf-8?B?K1VUSmpRczFod3ZoeXZjTUdQTjhZbDhkR3lNd2J3QkMrYWU0T082Nkc0UWNm?=
 =?utf-8?B?MWQ3b2NuejNsc2hrZHJaUWExOVMwdC94Zlg4K3BnVXJUelZ6OXFRTXpaSEEr?=
 =?utf-8?B?c1dvUVRWeVBYeWJwSElQSGtuWUJEaTRlcGd1QjljMVg5U3RDalpObUErd2Ja?=
 =?utf-8?B?OFJCYk9XZEViNG53Q3VtNzZka29QNlVVYUtHYVV2UWt4TVJGSUdVcXViNU5U?=
 =?utf-8?B?TDFudVVoZGtIbm8rQjFYYjk1d3FYcUdTcTNaMjhPdm0rL0hRQ3ZLRTFna0NV?=
 =?utf-8?B?c0FOV3EzV211ZmxKSm16TTFTaFdSMEFvMWRhdlB3aTdzTFJCUTBaTGRyUVBJ?=
 =?utf-8?B?YzVPYkt6cmNYSHRCd21DVURLQkhtMHF3QjlqQmkxZnI2OXRUSzBqaG80NEho?=
 =?utf-8?B?c1dOdGJMdkFtaGIzSEpYZ0xrblUrS2sxaHBkUU5yQzZXWXQwVG13VWQrQVE4?=
 =?utf-8?B?Y0dDOHhSV3doTUJqTXdQSGVUSFFDdWgxVE9TN29XMGRxSEN5SDZpamduS0ps?=
 =?utf-8?B?OWxrZnZHdGlqeGFhMEpBaTFxenlEMG9MckJmc2l5aVl6eGxhaUtyZ0tNTWxs?=
 =?utf-8?B?SDNaZ0pCMU52dmtwdXRsYnpnZ3NxckJaa3J3MjBBSnNjb29TY3lvQk5XVmNZ?=
 =?utf-8?B?T1ZUZEoyNlVSNnVqUk40cnQvL1o1enFLRG5nMVI5QTZmOHhpN2E1bHlqOFhL?=
 =?utf-8?B?Qm45WkhNMjJxWjVaci9TOUhCdi9RZUpYS0dJSjFRRy8wM3NrMUhtdXZXM2t3?=
 =?utf-8?B?V3k0Mm9WdmVNZGxwRDlmbzBrN1orZjRjaGREU2l6VVNGTEZXWTBzZWxDQU80?=
 =?utf-8?B?QUcvcXljUTRWejdiRGJpNUpmVzZPZk96ZnNySEhxQlZxWk5KSk1tdnA0SXZL?=
 =?utf-8?B?Qy9YSmQyUUw5QWRnNlZ2c1FPWUQ2bmRhTjhSbit1QVdrU3FrZ0NZN1NSekVN?=
 =?utf-8?B?d2xtd0dtUGlLUGhDNDA1OHFuYmNiZTVtZ2FoRU9OWFV0ZVE4ZysyWG03ZHcr?=
 =?utf-8?B?a2M0eWlEZkRyOFM1WFV6STA1TUNzb1kyemxWRWhIWWJmZVZIWDVudUpMdnA0?=
 =?utf-8?B?MzVha05QTnpnWEcvRGNZM3h1L25mMnZmYVdyems2Mko2ZmNWbDdEYmtkcHZZ?=
 =?utf-8?B?THFUdTZJQUp1b2U0TS84bTYyeTk3am5GV0p4Z1ZTaGo5anRuR05ORy9wZERn?=
 =?utf-8?B?ZXQ1TUlnVWowaUw4RjBRUEhBU0NvWXZ0TG1vWGtZNG5yZXhtelNZejM0VmdD?=
 =?utf-8?B?NHVxUWN3WmxCMTFwYXJJOHIzZ3RVVzByMTNMMlo2aHQ1VUE5OU9tS0tvMWVv?=
 =?utf-8?B?Nis3WC92Z3QvcGllNTYzY1gxKzJlQ1ZmNklkL0NpQjNsRHB6bHkzdmJlckNB?=
 =?utf-8?B?T2NDK0c1Mjk2N0tSMXA5M0dqbTBTSXpWTDErQ1FiR1JSbldzOEtWK2VOdXYx?=
 =?utf-8?B?QmNZamF6eFJjK1Y2NWQxZVZTSUFhb2IzOXl3S3A2cTYwQ0psQXd0R0hmMGFM?=
 =?utf-8?Q?UAGIaD+KESmNUJPrYiZNFLjcUgInFZS7LcCt4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1ZNMWJBRk9rbVFWMGtyN0xRWEpUWlo3VzhUY2d1VVR0Um9Cd3FaQzFZa3NP?=
 =?utf-8?B?K2ZYK1dXSG95cWFmamEvZTZEZFBrMHJZbVk4ME80ZmVNWTV0cFRJT0tYaXFy?=
 =?utf-8?B?QmVYUkhRR2RlbHgydDJrTHAxa01DMEZuWjRzS1hiZVd6b2FjNTA4UWkwZWhU?=
 =?utf-8?B?Q3hLUThhUWMwOEhHcnYvZDBNeFVuSzRKQWdsWWNxQTV5ZXkyL3JLUTVDWkF2?=
 =?utf-8?B?Z1g1ZzhhY0xFVDUzNG4vNllpS1hVL3N3ZGRlZHFmQUdBbEZDU1FrWFh1RUtN?=
 =?utf-8?B?dEo2RDUwK2ZOS05mU2VjclE0Wmxyc1E0VDJGbk1rNytvSmdOUzRESUdWS0tl?=
 =?utf-8?B?SDdCcm9OL29lUmFRVjVQZFJJQUhhQThCSHQ0Y0lhZmpxVi9MM29KNTR6Y0Fr?=
 =?utf-8?B?RCtadnBETXZJYTdHZVVUellGRXdTK2IvbWxQV1BJK016V0UvVGkyNUpNaDI4?=
 =?utf-8?B?bEoxbWRxMkQ5bTQ2WW9pUFNKRWlhdDZ5TlRNSHBCdlFiMENiWENORW96emEv?=
 =?utf-8?B?T1krcHhKd0ZMMFVTOXdXZEpqSG5yZnVCY0QrY3BRcVVUTEZBU1BXTEVDTjEw?=
 =?utf-8?B?TzVLQU5xcisvcnIvU3AvMXBJT0lxaE40blFUWFhVQTRDcW1SVnNtMG1BRUxz?=
 =?utf-8?B?MlJCTk5GS3BqYWFqanozVUJmeHo4eXQzRmhYaUd0WFJ1WUowcnp2Mm96Q3N3?=
 =?utf-8?B?d3h3VTN2UkhpcHFpeGtXQmlpZW5WelphQmV0cmxLeVI3ck9oNXlOYVpjbFdB?=
 =?utf-8?B?TXB4RjNIZ00yK0g3cDhHc3RCaXFCUUpMcHNCL00zNGo4V0M2NUNGQUlncmpB?=
 =?utf-8?B?aFRiTnJYckZhaVo0OWJrb3pTM1F4eEg0Ny9ZY3lmUnJzQjBxNU1HeUZHWjV4?=
 =?utf-8?B?bmZtVytyeTI1YkpjaE96MGxYMFdEQlVNbElONFFadFk4V0U3b1ZzL2lGWG9Q?=
 =?utf-8?B?UTJPcDFQd1ExclZtSVBVVUxiZEs2cytxZGdxanZRZS9ueHpobGNsek1QTUpw?=
 =?utf-8?B?dHNmN2pSVVRmOXc0N3l2ZzEzSzd1T3pBRWdxNEI4NEF5TE5YcEJ1SXNhZXJW?=
 =?utf-8?B?cU4yM3ZRQ0Y1ZDdoRENRVUh5RFJ6aEh0R0dtR2ViSFV4VnN6b2RabDF1RUk3?=
 =?utf-8?B?UWJpSWhSM25rdXFqZ0x1SlhHazRBWjJCcXYxZU81TUV5RUxlRmo3MVhQalB1?=
 =?utf-8?B?MDBHRE4yTU5hdUNDc0l2ZENZZG51ZUpocEV6cERBWjl4dWZVRXh4TDhWQzRq?=
 =?utf-8?B?SFBKRXQvWENYajIrS29paU8xa1BveFNFTzV4WkN1VXNqRWQ1N3pyYTR6c3Bi?=
 =?utf-8?B?WXZpOUhhaUtpTHV5R1dxamtRS2RScDJHdmcrQjIxUDFRNVFycmJ5elVjTzVr?=
 =?utf-8?B?TXppUm93R2F6cXN6VDBTa3NPaC9FRFVueG5reHR2TldIb2dJbHVyZFhldjha?=
 =?utf-8?B?dEQ1cnJtUDBZNXUvMjF1T2grbG5ySzVwOVkwc1lTVkdPdXRyUTFsUWZacHlK?=
 =?utf-8?B?SHJoeEJscUN6dWxwaFN2TjJqZzBZVURnUE4ySnRkU3RhZUhtRGVjYlpGc0Zn?=
 =?utf-8?B?QXJpSGpYa3Fkc0lvZjBaZHJHSWF4bytVcXVHdlhQdzJGbGMyeXZMcWNuTjF5?=
 =?utf-8?B?QnpROWI3RXBGVDAzRzlQcVI5bldXalBZSU1wWlkvVWI2TVFLeUNrRW1lKzl0?=
 =?utf-8?B?ZnNabk1zVTR3bzNCemIrUlB4S20rOGFVQ0h4NXVaY09EdmJDdjBkUGF2RWJ5?=
 =?utf-8?B?VkFpamZRRy9GSDd5Rml4bXpvMzJOc0dSTGJET3NpVFZ2RHNYMlUrRmNNRDFO?=
 =?utf-8?B?cTlwVlc3WWwzWlBSUlBpTmNIZG16T3pMalVyTVN5ZncyMmVnTENJUDBvZGZm?=
 =?utf-8?B?aUMrbVRQS3IyVERaZkRpWWlLbVlENHEyVFEwamk1WC91VWZFUjZBZHVlOUt6?=
 =?utf-8?B?UHNxQ1U1K1owTGZ5NUhnRnhCSEkwVklJQVRoZ1RhbFdTYlN0U0Nna1UvaTdY?=
 =?utf-8?B?MnJ6S3FtUk11WExFNUMxMisydzhVbjZLOFdBTHB6a1NUdEg0L29lb2UxWlZE?=
 =?utf-8?B?TE95OERsY0pMOGhXNWZ5SWg3TS9OVkNNekFPN05BTnRrRGF3dFFzNk1tckRC?=
 =?utf-8?Q?tV8apihdZdr3p/8dXq1YpFEw/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5210ffb-76d0-40b7-74e1-08dc69dd6fa8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:51:36.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eq+udYVAMS1P7iBaC80ablFAPMktGWwiy9wgk9o7vE0CghgI0jjxJABORL/I2/8dOizP02pL50uDDaV5/5qH4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-k210.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
index b6d1ed9ec9a3..2753e14c3e38 100644
--- a/drivers/pinctrl/pinctrl-k210.c
+++ b/drivers/pinctrl/pinctrl-k210.c
@@ -849,7 +849,6 @@ static int k210_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				       unsigned int *num_maps)
 {
 	unsigned int reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	reserved_maps = 0;
@@ -861,13 +860,11 @@ static int k210_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0)
 		goto err;
 
-	for_each_available_child_of_node(np_config, np) {
+	for_each_available_child_of_node_scoped(np_config, np) {
 		ret = k210_pinctrl_dt_subnode_to_map(pctldev, np, map,
 						     &reserved_maps, num_maps);
-		if (ret < 0) {
-			of_node_put(np);
+		if (ret < 0)
 			goto err;
-		}
 	}
 	return 0;
 

-- 
2.37.1


