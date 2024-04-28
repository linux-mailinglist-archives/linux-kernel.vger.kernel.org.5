Return-Path: <linux-kernel+bounces-161258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8118B49B0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B9728211E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3149479;
	Sun, 28 Apr 2024 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dA+/y5Bq"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318A748E;
	Sun, 28 Apr 2024 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714280419; cv=fail; b=W1Xj6UKNr2girrnovBYhI79cZkOtfL/tgtUaRbqpWo9sQD2H8/RU27YHeBP/6mzSPoMNDPMiiInNtU6D0OsmqzftpS1DEi0sq+OjSl3XHTlLud+mk+hJNCHUzJgRUnvachNDlJpRk7X69wUe5TmRj7pP/Kw3SbYZnmiUa4Ywa7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714280419; c=relaxed/simple;
	bh=3z+YHXe0W+SVUNhp2rXsnP4H3nC6DsL1oFahCu0qbug=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ILhJ5LSvd5xEWUA3dRsgtBf12BqTe3PzRr1iRBpaAQCDf/+AwnmWBHFsNn3vXBf8cBhcATVWCaGfNkfFPFiOaTsgGYDeKLqvGFa0y6971ECa7AFyxuLd8FYlRcU5DtGlCB2MF+fBo1D1DSMz9G0IcCwVAEPpfNfu0sxwKgSINF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dA+/y5Bq; arc=fail smtp.client-ip=40.107.13.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USsIbsikW77tA7JU3hD9lwFRLzckmLRlp0TSp87w8UYDYCp2K2Y4/+knqDFnYv8vi3g4KJWXaZ6oY9zJtGXB7lwSFNFhzPF80DbmlgIayLpv+Yr9VlguzvwgedgQxSITz2giYodUGwnKIIJSqnz2gU2nN4RiGQ/OdYwyj/TgU7JWFzizaOn6c2nubWPesb9tebpemHCcuT+gOq9LoUCVuIH0SdWVy26h5scQ17dG7XDytuPuSfys7SX9Ci3RSGB2NmeJf2AG3GPaeStybqOrQmhC7bu+bLUKIrujHweDLLgogjwt+QVcYJV9p8imvqscGdMCj8DD32aPEfrQ2Xt1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/Qo80YZbnDFk34LGa+x0G33rd6iHwJ4pxOLzRc55B0=;
 b=KnbWOAnbn2+kWcZ8kkPkz1SK4Olk4zzLW00SyYwKMF1ufIXk52Ye7fWEF27vAPh11RjUosrbboIzAlvC7cGX9DORWP3jzLM2ddDQYuCQ+svQWOQ6WR07dua5Nt099f5+IUEUAH7Pjg5x258XTUmXT7BE0dhaItqM7ioWTwgmrd/N4ZNnq2U4U+QN7fcG4SsfiGbBafbdUxEcbIjwq/syrC5z2erhqwkKWooC53MzHSHaHI0lIfCAZa5N54yAIsv4AVmL92Q+cJlKbPUcyiLwVYQQw3znEu66a27R6p1BV11/BCQUBfOj/Z3qVKAbsavd2dq9um4S4BQmnq+wx0c5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/Qo80YZbnDFk34LGa+x0G33rd6iHwJ4pxOLzRc55B0=;
 b=dA+/y5Bq6t/FuSjIolR4O0S5NDb3NuGGkVewM8aDsho4N5GhjcsREJzOLZVQoTHILiB0/AYjMPuFWDvbV4QiEhXe/gfhMEh5R3MhSG5G1rf0fEb2D7V/fgq4NNpIXlcRwBrePG8C5SqrdQtUSN3zniQdTCsmlwXfJvUskdwUnkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 05:00:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 05:00:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 28 Apr 2024 13:07:49 +0800
Subject: [PATCH v3 3/6] pinctrl: core: guard with __PINCTRL_CORE_H
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-pinctrl-scmi-oem-v3-v3-3-eda341eb47ed@nxp.com>
References: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
In-Reply-To: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714280885; l=819;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=39XOS9fDX1rjRHnqlzeUS1tTehfkUhSevikasyRfs0Y=;
 b=o8HdhUtwoiecxQ1mJR7FP+HASA5ckINjVEjU+abwKeTv12frBFqEiTW4EN+HJKgVF/xKU8/Pd
 3yImr2riPCMD+v++fx1bEkb6RPwX+WhQzM5YgXJsAQI1kSQgm9SAU5r
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb3a55f-6ea2-4b47-10ba-08dc67401734
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG9sVHlBazRhUlFyUStiZkNaMFJyZ0ZkM0R6VCsycWh6elhUVSs2a1hIMHRY?=
 =?utf-8?B?QW1UQTdidlVaenZxR21vdWh2VUVxaWlHNXdlVVNWNk44bTFoUmUwaVBySnE1?=
 =?utf-8?B?UVVwK3dNVWI3TkYxYm5aUDRFamRxSjZ2TUNMTUdiNlRtN1RYbVNmb3JIc0Jt?=
 =?utf-8?B?cHdJNE9HaHRycTVmS2lHeUhBKzAxb09VNWJKS2JHcXdOVVdYek80Z05iK3F1?=
 =?utf-8?B?MzJPd0VMRmV1OXcwR1ZSMHExMDlPNE5GVDVMWXEvM0UrU1QxTDZoNld5TlRa?=
 =?utf-8?B?ZWtnaGJqTGhXOEpuVjc1dkxWbFhEMHN3VWYrY2xKQWRJdHVtVktPeEF3ZWZW?=
 =?utf-8?B?VGNlcXU2cXhWVFBIdkpoSDZxUG4zVW1qUnNsbjV4M3MrZHNvcTJjZ3d2OHF5?=
 =?utf-8?B?cGVERGYzK1R5VGVHdUdEaEx1RWs3cy9kaHczKzdaZjg5R1dETjE0SE54dGNZ?=
 =?utf-8?B?ZnFHNDlPeWNRL3VGMVR2UllCbzkvQVU3UlJvczgxR2s2TVZEeWhpczRvQTRj?=
 =?utf-8?B?NHpwNDlkcVdpOUFIN1Q0K2pwYkUzc0xJOGlENEpsd2trUnlwaUp2c2p1eHdo?=
 =?utf-8?B?WGpFY2hQMHpZNTF2RU1GaXcvNlo2b0ZKc3Z3dC90R1lIeGFxSCtxVXlMNzFa?=
 =?utf-8?B?dnFVTm8xbDJLNjNHUG9ORlNCYUpScnd0YlQzbmY5SnYzcDVYS1VSUUNjSTNH?=
 =?utf-8?B?UDZ0WjlQcXZHQ2RpVUd6TGh6N3JXaUh0eFVldWRpcWhjU3oxRVNuT250NVJR?=
 =?utf-8?B?R0FGWUxZQzdTOVFlcDN6azB4UWNhUFRDZXMxWUVYSHh4RUV4U3M1YUtyYXRQ?=
 =?utf-8?B?azRTUHJSNXFaTmdWOHNiUGZSMExxdUdpRGNWUVNXVzR2MGE2OUgzTkZqYWZs?=
 =?utf-8?B?NzVaSUhURkJjVVhzdEErNzVacTRQQWordmNrWFpTWEpzTWRPRElmMzhrdlRC?=
 =?utf-8?B?VVVjTDBlb3VOQitxbXBNUExqMzBRUmVkc2VNQjhhdVk5Yi9hR1NIMXRuRWlR?=
 =?utf-8?B?MWJxdklNZnltYWU1SlQ0VnN4dDE5NEJtVlc1WXM4Y29mYmdnTFBrTU0reTcv?=
 =?utf-8?B?VGxzcmJZUUJoVTFEbmpSTHZHSzBHUlhBaVlXVjRDbmtNdlBhcUduOHNjSVcy?=
 =?utf-8?B?NjgyNzNIdUdJS3doN29iOElUYXlzeWRNamtvMzVjSEhvYkVhaERGRUh1bkxz?=
 =?utf-8?B?SndyU2dBUTNDV1RWbmhGRHh3bGNCVEM4dG5ON0VLZVBmdCt3SnRzTTFOSDFC?=
 =?utf-8?B?ZEV4SnNKZFI4eUt4RGNSci9YdllZZ051dzM5c3pjdHlwbXozNldlSVMzSmlS?=
 =?utf-8?B?YkVEWWZQeTFFOTAvYnZia1A2aEF2UytMOFdoYi8raW0yN0hmRkVWVU9ML0hI?=
 =?utf-8?B?QVFJSzh4WWUyaWQxQzk5bE5TdEI1V2txclhkK3ppL0NUQ2lMS255emVsZ2RJ?=
 =?utf-8?B?TjBIQnZlb09LT0h2b3MxUkdhWk9YUUZkNGwwM3FXaFFVV015MytPZk9TNlYr?=
 =?utf-8?B?SFBRcUxuazBJQ2RXNE1kekFOVnV5UWJYcWtTTjNUQVVnVkhKdDZhV2hyVGNt?=
 =?utf-8?B?aE5xNllVVHc5bE9GeTVSNG5MeTJQcmhyWUhpQkZ0YmFnN2xRUk93aUFuQUUx?=
 =?utf-8?B?QXdHTzVJVXlnQU05MjBrYTNIVFFvcHM0UDVFZjlaMW9qUFEwQ05rVnFDeFVM?=
 =?utf-8?B?aThqNEZ3eEdsRjZzMG5GSGRxRW9YdDJqTEE4Ly9jc2ZBOVNZa25yS1FPc1BI?=
 =?utf-8?B?ZURTTkl1SGxlQ2wxSkRhQmZtYlBla2FXemR6b0RjK0N1OEl0Q3JXaU01WDdr?=
 =?utf-8?Q?mKCMtijIAWu2mKfkNzSSjph/qcF4aENmigdHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3Nodk1IbHl4aEhGOWNneE9ZZ0tVRDRJRnZWMnRYV3NsaHhLbFVPN1NCc0d2?=
 =?utf-8?B?YS9TakQvZHYvUnZuampXZ2NjcXFmUFRvVE0ySVVmNXI1WVZtS1FnUFVPcm5Y?=
 =?utf-8?B?YXF6ejF3UzRxaWZwb3NUN1R2emszZDNxQnhIdzdZdUpVNzAyY09yOVdBVVVh?=
 =?utf-8?B?T1V0bFZkT0Q4Umg3b1FIYkQ5d0RCUFJyZy96YkxwOTZ5ZmxodmZkaG9xRDd4?=
 =?utf-8?B?bVpKNUp2Q2Z2YkxsZVBGWjgxemRCalNERHY3QUVQb1A3bHdtWVdwK2JvSnRl?=
 =?utf-8?B?MmVOZ21ZUitPa0piT204d0sxMk5teDF4YU1pcGRwVE1hZHRMUTBCTFVWZE1u?=
 =?utf-8?B?NnlmNGt0MXNjZnNzQjRjYWJLcGl0dm1xeUJXS1d5NEt1V3c5VExkSEVpUWxW?=
 =?utf-8?B?NXVYUy93T0xwaENpbjYvYTU5VS95TnQ0eFFGOVI0U2NETUdaY2JXdzg0SlBv?=
 =?utf-8?B?TWlQaXcrY2NSNTlFbU1tcnkzZFowVHdCVzZQQzlQY1pKWDJhSjhKTk93azhK?=
 =?utf-8?B?SDhiUkpZdTJFM1h6K1Q2VC9GNzM1V1MvejZFcUZCWndmVmVFUWhLaVdTcGxJ?=
 =?utf-8?B?T1lJVDZ5SGtGN1FuWHBNbkhjTk1wM1NEUFBDby9JTTBnQ1g1RmM4djVrSlA0?=
 =?utf-8?B?cGNuTEFxdnlXVjRKRFVEKzV4eUJEcExEN2o5MjJZQlZIZ1lrbHZGRm9ZcGZO?=
 =?utf-8?B?bHNTT2pjejhndHlwZEFWNzdzR1EvSVUwWU9oRHVUeGluVGFQUE9EeDlqSHdT?=
 =?utf-8?B?Q2JYc1ZmZGdZaDBPRjFWdW5RK1g0Qy9HSktyMmkwaHNVQXA2bzFJMG56c0Fh?=
 =?utf-8?B?aGc0QTlKcjFkdmMwS3NnMTMzQVdBVm5yL0plSzZIbG5DZ3BVdWJPMDQ2Qzl1?=
 =?utf-8?B?ZTlCMzhzUnZTZkYwUmkvZC9LSklpbTJ5K3RIbG1KL0JqL1RTRDRGN2VTemhh?=
 =?utf-8?B?bEJKZUVLOGp5QzFrNXJiWmdGbk1PSVJkZzNneC9McnRkV1luZ2J0akI2dTFa?=
 =?utf-8?B?QTYwRUs0R1lxMllxcFNnREN0YnZuVkJTN0RjemltNmpXdm12aUhyMkJFbEoz?=
 =?utf-8?B?RldwdFdpamprS1VldjZBdUxQc2l5U2NDR0RuVVRrS00vUWJMODhaZEtaSFZP?=
 =?utf-8?B?a0V1Y3hrSUo4ZXVMT25LNmxOenlxRDdQc1NFTjlxVFhMZTNtL1kvWmNEWnho?=
 =?utf-8?B?NlZQYWxENmJYa08xSDhwbkJaQlBDUUFST0pGcnk0K1M4N3B5T3JLTWRWTjZP?=
 =?utf-8?B?Z1F6bDR0NHhRVyswMnR0QTJVZk9HNWpleXFEU1FCdW1DQldwb3BMbUR1TkY4?=
 =?utf-8?B?QVpTeExiZUhrUXJoZTZTZUVrTlNWT21uNUZHcnhhMVg4akpYWDBiZGpvUWti?=
 =?utf-8?B?S29NdWZwc3owdW5nbTVaSGUreXVSN1dqYUpzK0Y4bnUwNFg1aGhjYW9iTlJt?=
 =?utf-8?B?cjlFTkdDTGRZcThWTVQ3OE9yWTlCNSt1bHJuTUxZVHh5VWloajNZemZPU2VO?=
 =?utf-8?B?bWJDSjJyVnZtN0pBM0Ezc3J5T2hRWVp0UG0xRnlHdVh5cUJUdzd3T24xYkxD?=
 =?utf-8?B?SDNxV09rUjQvcHFGQUhuaEtacHUveW1BeGtiOGVlVCtFdUoyblBhZ3F2a2tI?=
 =?utf-8?B?R3YxSHowZHMwTjk1V0JKNzlpazZMN1pRaWcwTG5vbjFTUnVXMVhGV2ptZmk4?=
 =?utf-8?B?aldKU2tyb3lkT2N5TUIzaGdFeC9LMzlzajMzODY1YjZuS1U2MW1zOVIzRGNo?=
 =?utf-8?B?d3N1WVdRYXRIVTV5VUhSWGRtZGN4VnRpSWQ2RTkwaWdVZlVxblZ3UFkzdEJR?=
 =?utf-8?B?dHFLMEdnZ2lvRE1xc0FHTWliWWNQbmg0TFdXeDNHRzZMK0NwcVdZZ3NxdElO?=
 =?utf-8?B?eHpRWFMremxtRTJwdm1kcjNsVW9maDhBQ1JSWmp6MlFSU2E5dTBkVCtsS2R4?=
 =?utf-8?B?MWtqUnk4Z0V5U254UUIzSVowSlpraWFMSFd3d2xEK3ZxNGFISjQzd3BQNG5l?=
 =?utf-8?B?NEhmTTVWYVp0aHVybm9RSlBCc1ZUQUQ5QWtPS0NOSDNpb2Q5R09DYmFnL0Ir?=
 =?utf-8?B?YWo2UFd2TU9YUnhucnprOFE5djVyWG1UTHNSdkdFL2lqUC9LVUlkZFdIZnV4?=
 =?utf-8?Q?pZ82KE68Mztw6N0pmGUvdlLLM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb3a55f-6ea2-4b47-10ba-08dc67401734
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 05:00:14.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+4u5ebU0sv1ozLVRVKdYOxajhib6flFIa6z/6fQC2r9xTJTPJYz8vW8T+LwpGTA1DOk8y3UNWUM/9lRIwB4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

From: Peng Fan <peng.fan@nxp.com>

Guard the file with __PINCTRL_CORE_H to avoid build failure in case
core.h is included multiple times.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/core.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 837fd5bd903d..1da7b0d329bc 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -8,6 +8,9 @@
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
 
+#ifndef __PINCTRL_CORE_H
+#define __PINCTRL_CORE_H
+
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -262,3 +265,4 @@ extern struct list_head pinctrl_maps;
 		for (unsigned int __i = 0;						\
 		     __i < _maps_node_->num_maps && (_map_ = &_maps_node_->maps[__i]);	\
 		     __i++)
+#endif

-- 
2.37.1


