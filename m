Return-Path: <linux-kernel+bounces-165271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3D8B8A55
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E251C21915
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2C8565B;
	Wed,  1 May 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EmmRaZXL"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685A5337D;
	Wed,  1 May 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567755; cv=fail; b=aClHK9hGL38xU84UPLBYsWxHM35KleI6cViWHHIoCxnj9YJpveAVjD0bxij+sSriymwXQnRO0uGzS+/dlHkwYMF+V2QMv7GN/A+rXwQNOde5h2tOqrcznQwJxOz889QWnPyCaF3wbxRWRp3/7bL03lK++f9NOsuE5sF4syvQZug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567755; c=relaxed/simple;
	bh=LSAn+p8fmAs99DQTsjCYGuuV7Smm9Rd2CDUVvdFN+HA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h+Io9IrlBiBgD0HCgxCayiE//sQADfNfteftHRIfq5crGQXVp2g3cTh2xpXicbURSA/U8DpHXqT5Y1jGxIsE1pU7HpYMX0uPRr97N6PfE8CGnwVgGn+hiOAc7fOup4rdCkvmg0uomM8T2Il172WipGq73HobUZMVk5DF9/jQFkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EmmRaZXL; arc=fail smtp.client-ip=40.107.6.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeu47Q+dPv1DPnRVGtc6IiNSPWuUWczHuMJIvx/20XaKHr4tGZ7eStixVLJKlt6k9gXBP+1/PR67tQAMiDlnrHAlpuNWxKdDAF6bDS1NzZ8GHl1UN6f5afpgN3LX7jWR7JOMnH90w8dA5VG5BzgZ7d9lSUkmbJ04GoIHryivbP1QDu3EGjRLivniGmriEkbOKZoWfCn3tAUjffx1OT3WstUpQs8VmUWCQSxdnmuFrLNmrmmrmXe6gsHNPwsG68kwa/8wPslY1o8lpxHDaO+gCofqCdwUNhwr1ov6l8sn1NHkf9pkclPfa2sPQ93DOCz8a9mhRyey486T8N+tbok7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWbaOnhitppwCU5btaK/2yH59NAaiI69tzBZ/+l5Sls=;
 b=GRlchT30TLUK57xGbReuKjfzmTSUr9s7OMLTNM7oX8VHditGMqb655tXxxqqGuLO5PZF+kd4uUDc7COHYN/Fk8oLFjkbpZiinCR/rOr2bv8lH6pty5oKDQuQ9v8pIvv5Cn4JBHrvi97mZAf/9d/3xSP7Ts+oJ+6xIuaDRxld72sDAHLRVtTauuMJtY/X57HpiDowhh2Y6D30He09nz2/ShwRJ9/KMhTPKnX1TOBeC03VrO9l/EtbFnb5P+wWOCLa2ClWGa3CcUKgsSnXuz41Cs9e0ERzmkq/AKfmRe/AsLaD65Js+0xvlgf/rzIyvWbx9a1mjSzZtKNg40Iu9vuyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWbaOnhitppwCU5btaK/2yH59NAaiI69tzBZ/+l5Sls=;
 b=EmmRaZXLTcmyZ8/Gzn7BfXWIGm50cFWw1ABS/y4xR5FZ0rFwDj5ScpJilmo29x49sCMfAzTWuXKku97P0fc2ra9ASs/2muNOJzKA7Fev155/6SxjfM8g9LIw9T/5jyiKaZSzT28wJ0+x/A2r7loWZu3KbtlansoFo3F/zca20J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 12:49:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:49:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:01 +0800
Subject: [PATCH 03/21] pinctrl: sunplus: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-3-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=1303;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+m9hOUks1zLp1UolZzmwZ7jTtIojf5UqsPjaqQIsEwQ=;
 b=IZjMe94P6fYw86SmgQeVTPliGzwM5/iZVmO4VECeHSp9Ch0ktEbWrPRvuWTFTkBwPt2Tg4ElP
 txogWLr0hpKCU4Qnc8bC8XisL27TbpzKeibh6Ju1lkhyT89QOJTe+0p
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
X-MS-Office365-Filtering-Correlation-Id: 065f0460-04e2-428c-56a7-08dc69dd1913
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWgxa29RSWQrb1I4M1FZKzIweXZqakNKUGNjc3ZMQlhzbEZEZU9TMi9WTmJy?=
 =?utf-8?B?TzZFdWRvV3hZMlFDTWZ4SjJQcHhrVVhnWHBEN010OXNzS2tacDc5SkhtaG1r?=
 =?utf-8?B?NXU2WjhGL1BscmdpUGUvZy9tRUNBV0VJU3FPczd0MW1QN2grZzU0TkwzYURo?=
 =?utf-8?B?Q1BUbXZwcmpXYmY1QnRWbm16dHBRcWJzMWpMb29BaGhBRXdzQmczemFsRnRQ?=
 =?utf-8?B?WkczaFNscGlXU2J6ckNBSU9lK1NJTEwxem5odUVHM3I1MWVKZldjVTdWUFRN?=
 =?utf-8?B?S2ZxaWY1b05rTHEzN2ViMmk0RGM4QUUzOURVancrb3JFcWo3RnVJUEVwc0Rm?=
 =?utf-8?B?ZUhHZlJSMXJ3cjlTbjZnTHZibzFoYWlkbDc5L0hjM2FDWTZxTnQrd05vR24v?=
 =?utf-8?B?S0pwWEhXS2Qrak5DTlZyaGpLcXpTMXdORW44eFpXMjFHQUtKNTJrWU9YVmR6?=
 =?utf-8?B?ZTNmbmo4TC84VUZrNkU0R2JhSmlHaVlMUC9JUjVrNTV5eldYeW9uZU8zc3pD?=
 =?utf-8?B?RFNZS3lsSHQxQndHcXNtTG85RVBUbzFEQ2t1ays0cHhLeE5IUGtqTHZYRnR3?=
 =?utf-8?B?ZVMxOHZjd0VxZGc2ZUJvdi9tc3owL29yOVhoN3czTUIwMk9FNnZ4M0RqbU5o?=
 =?utf-8?B?ZHBoejhiblhUV3JhcTRIdmZZYnozR2NBaTRHNmtQSm8yaHBrSXpVNGdWQVN4?=
 =?utf-8?B?Z2cvaVFoQmdvQndNNTJPR09GUXY0OEJwNjcwcmZXNUtWNW9DY0Y4dG0zcGVR?=
 =?utf-8?B?a0E0b0lUUG43dUtOc3kydnI5NVk1RStFcFpWUFpkeThaZGpXQ3VxanhaNmVL?=
 =?utf-8?B?QUoxWEthOWNLd0dkc2JHeWFRdEdncHp3ZHE0a1g3ZXdnNXFhOGJUY040V1BV?=
 =?utf-8?B?RFBXQStVTXQ0ay8rRXIyZmdxQVVtYURObUNVNncyT2Y1dWVYNzFVR21OUmhE?=
 =?utf-8?B?d1QyNThSMHFNSVNEbDNwUitIK2dia0VIVkR0YmFiWUJXODlyN3ZRMnREWWR3?=
 =?utf-8?B?ZjdDcDhzOXZtYlV5NndCT3BNSkQ2MURFN0d4aXVYK0JFSE1WSnBXU1ZNenhn?=
 =?utf-8?B?aFNiWk16aDE1cFEvL2RuUDQ2a0FsYkwxUHltSzB3NVFtWmZSRTArcDcxK21I?=
 =?utf-8?B?QUpUb2N2czdKaFNDVnFhV3BhZDhjdWdVbVlFNnA5OWRudXppK1NQa2dJZEk4?=
 =?utf-8?B?Q1lSRU1pV1JtTnpjNU93Y0lxZ25mdVlYQnhYc0Z4bXZDZU91UEMyYjRkbFE5?=
 =?utf-8?B?VFdJUk5tMVFiWCt6NHc2UmoyVmwyeW80bHc5SmNtT05TVzRMYTBNcnRUblk3?=
 =?utf-8?B?cHlwVExGUkxZL2dGR0MvbUpZdzg2VnFleExIN1VjNVltNkphM0JqdnVaYysy?=
 =?utf-8?B?ZXNabEwzZFJVdWRXdmw5RmhtWUNzSm9Gczl3aU5tcXFPbU5hdVh3ekJCVjRH?=
 =?utf-8?B?azNPbElOUEpYalBBSlVPenVQMTYvY1VhQ3Bsc1VoTlVCc2RETFc1SmtIdXkr?=
 =?utf-8?B?NVhsSDBGWWIyOS9LN1FaM0JpN2hxdWl2MWRYNWRWaElEaHprY1l0NzRZTksz?=
 =?utf-8?B?YzZXbTcxSDBFQjZGVnFQeTI2dGt1aWppK0RvU0pMTVp2ZUg1VVZldktzbTRk?=
 =?utf-8?B?K0ZQL2ZnRzFINTFTS1lnRU5jS2pmUEpiVFZHYmpmZHRiVzMzSEJaeXJCL0R1?=
 =?utf-8?B?NWRQamloQ2xKeC9zcXhScWQvNjFVamlXd294bDJGem50ZHRkMFlOWlM5cWtx?=
 =?utf-8?B?Mnc3OXY0OWU1aTB0MnpQM3lMUkRqb0hQc0xkM1dXME9PMkJJWkFoWlFHdnR2?=
 =?utf-8?Q?3UCC1vhaTalv4F3aFfhdRU5kwAIVYGktXVNPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RncyM2k1NklpYnNOWUdwTWtuVFN3ZFl3QUxRYmJqbTZDSGd6RzQ2dHBWU05C?=
 =?utf-8?B?MnNwcDAvZG9CNEZQd1pIbDFiWnJlUnAyYU1yaFdiYUVIMm1ISk5KUG0xb0Fp?=
 =?utf-8?B?S0ZYR2ltelpXVk5ibEhmNVo5OUd4aG9UMWJTUE13dHRJZVp3OGxSVEdLNGJJ?=
 =?utf-8?B?S3k2NjEwcHN4ZW5zN3NjVXhsU3NZNFpyaGNXTzZjUWFHbXZobEJ0QlNVblV1?=
 =?utf-8?B?SHJaTW5rM2ZHWjN4c3NpNjJJSlE1dWZuZU5PaVJoRjN5WG5BeEZuM0RXbC8r?=
 =?utf-8?B?c0JlUjd5OUZPTlBHcjRuRmNsZzcrYjBJbHZkaVJaWEl6S243N3FzMlQvajNl?=
 =?utf-8?B?dGxjUTRxb1RBN05MTnZrdjU0L1ZPMnhqMWphTGJ1SkRRdFRNZkZCYm5YeG4y?=
 =?utf-8?B?VUpEV0NsZjgyVXlpQVpLWVM5VWhsUStWN2tRRFBUSzZ4Yjc1Ui82clhnaWVZ?=
 =?utf-8?B?MmFLSFo3WHdCaTJBR0lZZ2VObXExT2NJQkJvRFo1M2N1UXJURTFZaVYrWkRz?=
 =?utf-8?B?TWpLeEpkVk5EbDcybHlHamtSR3k2dXRMSzJlSzkyZXhoamZnV3RNQ1VsVGhF?=
 =?utf-8?B?VWQ2bDFjTHpuTVk4OTRmSDM4VE9PWTVUQU42NzV3TllHaEpYaWRpSHdIY2Nr?=
 =?utf-8?B?L1RkTEMwMVovUEVWVTdWSGZvK0hudTJUdGtSTlBvR2luOTV5VVBVUTgwVE0z?=
 =?utf-8?B?OUJWTWM3THN5aWNKd3lRR1VnU0JOV1MxMUNwZHdQSVdkakYzUE1mdGw1YjJS?=
 =?utf-8?B?eVIxOXkraC81dktuZ01rK1BTQmM1WUpGUjRBLzNOMDhnc2FRU0ZFc2JrYnB0?=
 =?utf-8?B?S0ppNE5jRC9GNXRkbFZ0c0xZdW41UnFGNUd0a0JwV2ZEb2E4cm1mZ3QxVTlO?=
 =?utf-8?B?TWNDYWVrbXU0NCsxZTVzMkYrWFlCSVozZUEwcmZ0b2ZSb1ptWnJyNUh1Zmpl?=
 =?utf-8?B?Mk8wOU93alpKaDFIUmlNWXJwdTVvRmYvNko5bDNmb1B3TTZYd0xvN21ZY1Q0?=
 =?utf-8?B?ZUJXS3czOTIvRjBzODFESEhmdSs5MEc0QlJ2UnhWRkl1dE1TNnRSdFJrQnpj?=
 =?utf-8?B?NVFoMUxONEkyNHIwT1RZM3VWSnhnMlEzelh0eTFVc3pTTUx4MFMzb2JVYzhh?=
 =?utf-8?B?NWRaS2tCQ3NOSVlYbWI2R2xCMmR3QkpqNGxFUDJ3eEQ4UWg5ZnJubHlCb0tn?=
 =?utf-8?B?NjJHR21kQzVzRUhQbjF3ekhNVjRKaFJqdWhIYTIvM3hUVnFZLzdDRzY4V0xC?=
 =?utf-8?B?RzBIUzFJamlGSHpuLy9TdUdYRzY2MmlHQXFKa3BiUTMzVkh5djQ5ZUI5WGM4?=
 =?utf-8?B?bXBzT2pSNk0xcll5eVhnNXZBT09zZDg1VGg0SWd0cHc2MHJKa0o1NWg5SzNr?=
 =?utf-8?B?blV5UjNkK1ozdEtYZG5UTzB4Z0R1Q3B5VkNpMlRrUTk1NDZzNmNjaDhjRzIv?=
 =?utf-8?B?S2VKQy9sV0RUSUprYW1lZDl2TWxwbk56ZHc4c0VMNmVad2JsczdXMDZGWlZZ?=
 =?utf-8?B?bHRUTVlIeUlzVXBtZWF0Y3BVZ2lHWFJNV3ZTanZKeVdjUG5XWVlJYmJDbVJs?=
 =?utf-8?B?Q2NXZnpSVFZyZS9MeFY0MWxSdktaMStUSktpa2E5SDFzaXlJYU9UUENyNnNa?=
 =?utf-8?B?b3Rtei8ydFpyU0M1cndHMXVuNVQ2L0VBMkhVWm9qMElKWmRXQXRIRmRXZnVL?=
 =?utf-8?B?WlVmdXB4R2tnYWkrNWNkQVh1UkF4SGlYeU54MmdPa0VnMjF4dk1maXJ6Z0hr?=
 =?utf-8?B?VXZZUlpHZXREVDh0V0FiUW5SVnF6VFhZN0J3MVhYU1hYVGdGWHNoS1R6VjFm?=
 =?utf-8?B?OFluYUNzekRWNUJEMDI5RHN0WnBtSzA4MllKbnVLTEpNcytDSHdvU1diSHBW?=
 =?utf-8?B?eEM1TDZPSk91aE0yY0tSMHdTUlhITWZEOTliZ0dYNVBrOWdBU0VJdUJhK2E0?=
 =?utf-8?B?OXVLcFFiZVJCNFV2VzkwRVc5bTF4UCtwcWdxZERMTGxUakVPWVRMQVJFc3J0?=
 =?utf-8?B?SVZ2RUJYZmptNTBROW5ISTNCOXFlaENpWHpaVis5WHFENFlYVXBZTzk5aVE0?=
 =?utf-8?B?bHJyc0xyb0wycGFkbXVYNFN6NGhSLzdmT2x6RlpFa3MzUUZlbFFCL0tWNG85?=
 =?utf-8?Q?PpH8nE3WoGiTxUR1vvJ9wtWDC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065f0460-04e2-428c-56a7-08dc69dd1913
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:49:11.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvq5FEOPiyJ+1kQ64iVQwxsQD3eMnMe+tmTitUmgyqQLUOxYlxzgOM82g+xPwvaQXsBROZvmNsKkMC2YFHNfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/sunplus/sppctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index ae156f779a16..604256ec9079 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -823,7 +823,7 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 	int nmG = of_property_count_strings(np_config, "groups");
 	const struct sppctl_func *f = NULL;
 	u8 pin_num, pin_type, pin_func;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	unsigned long *configs;
 	struct property *prop;
 	const char *s_f, *s_g;
@@ -964,7 +964,6 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 		}
 	}
 
-	of_node_put(parent);
 	dev_dbg(pctldev->dev, "%d pins mapped\n", *num_maps);
 	return 0;
 
@@ -973,7 +972,6 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 		if ((*map)[i].type == PIN_MAP_TYPE_CONFIGS_PIN)
 			kfree((*map)[i].data.configs.configs);
 	kfree(*map);
-	of_node_put(parent);
 	return -ENOMEM;
 }
 

-- 
2.37.1


