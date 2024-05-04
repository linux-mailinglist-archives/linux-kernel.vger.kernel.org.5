Return-Path: <linux-kernel+bounces-168476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0928BB8FB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFF21C22D00
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E7D2B9DE;
	Sat,  4 May 2024 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UHDFD4IY"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7BD2B9CE;
	Sat,  4 May 2024 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783360; cv=fail; b=j2BysM9HfSi9DDOj92qiGCQtYjyVtfUSXWmfkBR6XGxQ8SrRE3rHGwJaPQrUMg6s/GQFSn44FVF1l0VxgPPG6xmzFrysw+R1Ddy+CSl1lrTMkoy8G6e/zQHGiQtqnZO64kJM9sta9FbcWOUezkU5zB+apB7LGq2HNM9+Hz+ryb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783360; c=relaxed/simple;
	bh=zB0ZVdk0Qm7I8UWyqi5Qs3uBnGOodb2WAs9gToNGiDU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cgA8im1StO54gcQVdR8mt+OiIxKDQzUyF2biomqRXyxy433aY8tXVs5gPj57OQdvWqQMzsghYJPifkEmqHUc0bAF1iIRyVp4B/St7vIde6p+ISnbfcctkaF7TUvUzpM1exrHglBl3Xd//lSFQDVMxmELsGMQB/6a3LjSWeUA8ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UHDFD4IY; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSsE43sf3Ip9guXN/I1G55EQhEDluFM22uri3q4bY/6F3rDvPtvuZZoK/bROkbfaTbgvhMVWmaIFZZ1ttVcW1KaubrxMIKuZvu9F89mwuaIrrZQeZZovkTvp1rZZ66+i3/LflB5cHA6N7/Zi4qZWGa8gPbdLqtx5m2fOiGkCI+sab5RbdMsWubwbAVIKokm66rcGxx6OxT/05OOyAZklTkAtsN5jcdD4BtXd+ShIj77vIJWvM21NJbYLTdmisueAlDsxO791J1CigWVmJji6Sj0BEFq4owKkVBCMx2dISZ0AeKUCDFfR9QOYlDGoKT+tOluzmNM0uGceBGpTmpLLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=morjSPZoht/sZgZZlrJFTpm7VksD0m/Vy6jf//XeATM=;
 b=lVvooT4F0LoiW9cTIfYUSmp2EkoA3fGDLJxj2gJ/xTVlG7T44/+Ggwp27LvPkioVseoTTOqBa9B+ucgurjPJzhVO1j5BLqx9rH5nXcvGWQ2fYlO2mk+guM6ahOvGSJCj/FPR9EMnR5vASVePGrhRGUNWRw5UdaPFJJZOszL+epqxUIiiJOTeRddlRMBZAtI3uscGD5JCFyqg0DkaBWxV6GaXD5xeyhd3Gq7ifr3/Bucl2mHZl55AkPfRqgRwuQ91gCrF5kGqc4BGfvKK93Na+7JMoer/A2jkuotSm9cyEDD7DLAomgH5hHaUPiDQpygOeP253j2QH6SUOktjgbkVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=morjSPZoht/sZgZZlrJFTpm7VksD0m/Vy6jf//XeATM=;
 b=UHDFD4IYz31jMk1YtV1KaikCFXSpv8QtpjotNhe0a7OMRRSNMIma71W5l2yFWkKO0e/LKszRX/9LWxDODd3X0FawzdbpH1Tm6J936pL3kR8vJK8cBkjwjujsE74klPkaVoqTSnx2+M4wv+cruzon+kite5q6rasu9WK8T4WemFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:42:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:42:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:10 +0800
Subject: [PATCH 17/18] clk: imx: imx8qxp: Parent should be initialized
 earlier than the clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-17-f7915489d58d@nxp.com>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
In-Reply-To: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=2435;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=hrw2P3sZckBHVBC6N5CEm5mGrpqUDVpTtcM6jOZ4s+Q=;
 b=kMNh8mRqhB2ZDTaJfXa8sIEqusAxeIdV1ctqQPQJT619wLq1V1wOyRkq7JmU8v0JMclWoOtqu
 5CJIiqYI6P6DMjk1UvpSbkZbv433QFF+vi0FycR61sqi+S9C5XzB2F2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bece1c-ef20-4b36-406a-08dc6bd31782
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTd5bC8xRnVVWUd6YXFZZmV2bGV5ZmJZVGtlbFFCSGpNeW9kbEQ2ekc1Nzhi?=
 =?utf-8?B?a1ZVTnA4MnVwd2kvNzlaZWxZalQzODE4cHYyd0pDNERobHZnMTlMMGhMd2pa?=
 =?utf-8?B?OHlqSlFNckIrNFZGZU5HMnByOFpPL0MzZEJicXVBUjh2RVpHeFhKMEhCT1lX?=
 =?utf-8?B?OHZNQ01DZTJIbUFaenBhUUdRR0w5MUh3NGVQb3lMVEtjdm9yZDcrTnoxajNp?=
 =?utf-8?B?NnhNM2JPNzloejRwQXdxOXBzbVBqMktWR0pKQzBpZjVNNnV4TGhwOW1IOWVU?=
 =?utf-8?B?bHprNnIxRTFnRWh6RnZydDZ2Y2NMMXNiS1dMV3lENEdVMXlkRTFBcFdKSFhy?=
 =?utf-8?B?WmJmTTBFVnVjanBPLzV4U1Bza1lhOS83Ry9XclNOOXlDRXNZNEsybVZBRCtw?=
 =?utf-8?B?dU5WU0RLUmRLcG40YmRMRW5RVEFqbjlEM0tCVkNKNFJpblphempFSm9YT3M0?=
 =?utf-8?B?MnNRc0JHYzVjVmFkLy8zMjdnOHJQRHpqU1BUV3JJckdwakRqSHMySE55c0hk?=
 =?utf-8?B?UTJQQ0pKOTV1cW5xNVU0ZGFjaXdaYTc4OGZrY2FXY0szTEUvd05yQWtLYkFI?=
 =?utf-8?B?NTlWcDJIZElRd29JMEZrdkhZOFl6dTl4K0VZVDhUY2dzRzRiNGt5Q1gwejNI?=
 =?utf-8?B?dG1OUGpLNlJNN3R2dWh6SVVUOEdadlF1L01ITmRiNzB5MVNJa2QraFovSnI4?=
 =?utf-8?B?RjJjTmEyWXlvNlZFZlJBUzdIY0k0bDg4RDZScERhVi83MUs5WGxsazR1cTNR?=
 =?utf-8?B?cVc2MUE3MHBkamtRa2dqU3NjdkVCQkY4SUlWeEZXdUFMTlM3OGRLMjVhZzk2?=
 =?utf-8?B?cElKSFFXbW4wYURsNFVGbndLSlo1R1pkU01NZHczUERNT2xoUXpnY0pYSXZa?=
 =?utf-8?B?YjNycHJyUmF1TXpCM1ltQ1NRRnJXYjUvaFdnN25iTFFXWEN2K3NEdlgrS3Nt?=
 =?utf-8?B?VkRnSUJBTGNoYkJ2TGt0dGw4YVhkd1lmdnZWMXJ2eGhxTldpaEhpWW5HLzhh?=
 =?utf-8?B?ZWkvdzc0Q2kxYmc5U0VjMURsL3BmSkxFOVJxWHZZalAxcmlQNjBlWVZQSDBq?=
 =?utf-8?B?Rll6dEQrR3B5bnk4NUREZ2tYMi9rU2MyMjJZUlZCd2dwQWw4Nm1RVDd0QXZx?=
 =?utf-8?B?RnFFZ2h2UVRtWi94K1NNM3VtN3lhUC8vcmFTdFZXZ1p4dXpyTkhqbkJRS05s?=
 =?utf-8?B?dmFFdm1ESFAyazNvbGticTZ4THpZNFg1bEphOThISWhYWmxiWDRVbm9LSlFE?=
 =?utf-8?B?a01HRzMzQVgzWmRlcHhIck9qeFVGS2p1b0JTdGFHUUtsenE2TEpXeVFkbGVk?=
 =?utf-8?B?cEJqdDJRSldPdkxJcjF3T3lJdmVBMXFIQzlmbW9DSVZQSEVrZ3B0TmR1c3Rw?=
 =?utf-8?B?clI4R2RNS1YvdEVYOTRXTHNiMUd0TkNyVTA1ek1GamQxbGFaWXhmZmJ5WnBz?=
 =?utf-8?B?N2dENy93a3pHZ2RwSUpvcTVkR2hPZnM0d0tEb1VjZHY3TXBGcnB2QjdUSjV1?=
 =?utf-8?B?QlF2K2t3VldKYTU0VUxUS3Fxby9qejhuaXlBWUhmVW9lbUdYUnB4c2Z5bjVL?=
 =?utf-8?B?M0VDTTZqcDVObmplTHVFcENHcEpjS2RPOFh1aHZWVHZLQlE5cjFlR3k5eHhM?=
 =?utf-8?B?R2VERHhJRGdXdVlTYWxXb2RPejQzNExjTVJaMGEzbjVmODd6ZVVrdllVVTI0?=
 =?utf-8?B?UHVNNTRUMSthWTN1QW1mZ2ZHZktjOW9QZkN0MU40RXZoN0dTVThuelN1Qk1v?=
 =?utf-8?B?Mk1wYm1OdFc0dnAwUVpEKzNRcnlGbWk5L2JYck4zb25Ba3dIRDd1SnZBQUls?=
 =?utf-8?Q?IZ3fwldUih7p0X8tmJZaRGGhJfAkvlf7Ovpi4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU5pVmNqTXRZMTVORnlwNnl1NXpFM21tSnlHNVVQc0dxbHc5OG1HV0VoazhU?=
 =?utf-8?B?dHVoS0JQT3VVbEtmUmlqRDdBcU1EUEhoOUJ6WTVQZkJaNjc0ZjFMTWpYdjR3?=
 =?utf-8?B?NlRURmFSMnVTa3RBcS84Z01lMzJLc0xFZCthSWhudXh0WEtpYVBkTktYM3c3?=
 =?utf-8?B?S0ZiOVQ3RzBUcUpXV1JFazN3UWExbzE3dG5zZ2o0SzA5L3p0SjBrSlpKTVJU?=
 =?utf-8?B?QmVtYzBWTFpNeG0zQnhsbFFMaTRHdFB6ZUZUYWRWemVuS0hzWE9YV2JWQWdJ?=
 =?utf-8?B?TGZWa24rL2hlQ2c2V0hxMW0rOFI5V1BmYUNVREhmYVJSTHpiMmhXN0o0YUxB?=
 =?utf-8?B?S0g0dXorVE5lMFlwTlVlS1psRGR5U1EzbXhpWFFMdlJuWk1DYzArMmN4Z2cr?=
 =?utf-8?B?S0dwbzhOcWJPV0hUdkJMd3dtZzBDdElWNVM5S0tXdUI4b1I1b2R4aVZrWEFW?=
 =?utf-8?B?NzhpaXhjTnFjMm8wZGNNenRzZE82Ry93RUdwUU5QNFVvRkhjR2lFazFZdXBr?=
 =?utf-8?B?TkZ1TWRIRkIyVkdCM3RIVXRoYlFBY2NoN0VwVnVzLys3U21sRjFWNFQ1OUZB?=
 =?utf-8?B?VEozMzE4OGFGN0dFMjkvUzVmQlVkY1p1bDRpNnNxQURlbmFJeW1pb1hiWkJk?=
 =?utf-8?B?cVAzNFcwTmZBTFovYUNVU3NSU0Vzb0lkbk9wZ3pJbFZyS1lWNHh1ekN3R2h0?=
 =?utf-8?B?RG05QTMvZ3IzTHorTEVKVWpXZldTRkdlTkpWeElHcVVzemN3bVZ3TFAvL2ln?=
 =?utf-8?B?UFZ4ZG5WaGhrNXEyRG1Xdy81OGV3TCtnTzZwd0xJQy9RYWRkRWpPeTNkaHpz?=
 =?utf-8?B?Y3ltbWhkdGN0QTlVY0dXTDlId2lEL2VLZU1haU5rM1B3KzRSSS93RExKR0ts?=
 =?utf-8?B?aFJ3S0V4RDB3S3VTZVROclBWKzFkSy9RSlN4U0gxNlBvQUZLcG8rekdXek5Z?=
 =?utf-8?B?ZXdnMEJhYkxFZjh4WWcrbVNaRDM1bVhkVDNqekY4ZG1hbUN1VVcrV2tDVHdj?=
 =?utf-8?B?cVZLWWVsczJFTGVoeWlPalBhNzFOWUY4Q1ZOTHZBL1NENkdtL0t6dTlQdElo?=
 =?utf-8?B?WXJlT3BxRDV1KzhYOHN2SVRqdzN3Zi81TXpuRTM5Wk1jTjV0eU5ZRmhiMVpm?=
 =?utf-8?B?TVBpNlpDT0F0Wm4rNXpMVnVoS0hnMGRmYUE3TnpNcElDaUFKVEMrN01sNWtB?=
 =?utf-8?B?cEprTjVwSFhDZG9LK1NOS1hMYm5FTjZCRjUrU1NkOWJQUHY3UURTNFU4NmVH?=
 =?utf-8?B?T0hacFFvUmRveG8zdnNNd1B5cGxoc1ZiTWhTKzdFSTVLR2wxWDVvUmlMbTFZ?=
 =?utf-8?B?bUFxUFZTU25FcHdOcnBRR3Vvc0RCRkJUK1dGbTFQbFg1ajJpWjhDdC9LNHRu?=
 =?utf-8?B?MUVwS1ZMNGRjUTNISzJXUDhJNGNiaFlMN3ZBOXFrYTZ0aUgwU2R4WVBBU253?=
 =?utf-8?B?cmFOdHpZeXlxOTlBeVdSYUVpN1M2dXZ1ektmT0gycGdDdE5TM1FoeWJFTkVv?=
 =?utf-8?B?UEZScjJScVBJd0twenM5TDlJdG83NzJpZTdrWHBGenZKRS9YcitRYzZzQXds?=
 =?utf-8?B?QVV5TTJMQk9qY2syVXNZWW00V05vWTRhV05SZFpQMUZnQlhRd1IyQkFFcXZw?=
 =?utf-8?B?MWx6b0RWaWw2S2ZqWFZsRUJ2T3pEUFVFbGFvcEJFZk9DeWZWaDkvWDlVV0la?=
 =?utf-8?B?bDJxbkJsWHUyR3dPSGR0NlNVMEcwMk03R3VHV1Y5aXRjMDlZNjlIcTVLT2Zw?=
 =?utf-8?B?VVo3RzVmdVgyb0J4NjQ2WE80R240T3NQS1NzaGFteHYrZHJOLzluS1JSV0dD?=
 =?utf-8?B?MEVlVUdYK3lLblc0QlFqRFM5eUZBYi9TSTdKQTdFbFRoakdBV1BGcFlGQXRH?=
 =?utf-8?B?Sjh4OTdPRUNGUEh3eDRWVi9NYnkrUWUrenZpc1B0QnA4c2d3NmUwSmx3NWRC?=
 =?utf-8?B?ZCtFUzdWZEdqRC9PKzJRdHdBNGk0WlFibE8xWlkwdlhoM2pUOUJLRVpoLzhx?=
 =?utf-8?B?THBFNWpoK29sSnJ4MjdXM0Fid2YwNGhCSTZyanQrc0ovU1ZnU3JnVDR1dlJ3?=
 =?utf-8?B?bGRJaVpLTFlITGw0RDhMSVZLUnZHWE9sUUVMUGI5cEIvc25sTHExcXBZNFlR?=
 =?utf-8?Q?un4oVIoqp5fO6MRpJCx5Q6C2V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bece1c-ef20-4b36-406a-08dc6bd31782
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:42:35.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvDZXT+pEobDOUD8GHKuZhTP30Ad7uHwX17EWzs4ePJZMaLKn3kFHhaqSXMCA0203P1M8DQK/mbu9SBubRmSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Peng Fan <peng.fan@nxp.com>

The initialization order of SCU clocks affects the sequence of SCU clock
resume. If there are no other effects, the earlier the initialization,
the earlier the resume. During SCU clock resume, the clock rate is
restored. As SCFW guidelines, configure the parent clock rate before
configuring the child rate.

Fixes: babfaa9556d7 ("clk: imx: scu: add more scu clocks")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 47f4ceab1179..3ae162625bb1 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -186,8 +186,8 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu2("lcd_clk", lcd_sels, ARRAY_SIZE(lcd_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
-	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 	imx_clk_scu("lcd_pxl_bypass_div_clk", IMX_SC_R_LCD_0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 
 	/* Audio SS */
 	imx_clk_scu("audio_pll0_clk", IMX_SC_R_AUDIO_PLL_0, IMX_SC_PM_CLK_PLL);
@@ -229,11 +229,11 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_bypass1_clk", IMX_SC_R_DC_0_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
-	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);
-	imx_clk_scu2("dc1_disp1_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc1_pll0_clk", IMX_SC_R_DC_1_PLL_0, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc1_pll1_clk", IMX_SC_R_DC_1_PLL_1, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc1_bypass0_clk", IMX_SC_R_DC_1_VIDEO0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);
+	imx_clk_scu2("dc1_disp1_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc1_bypass1_clk", IMX_SC_R_DC_1_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
 	/* MIPI-LVDS SS */

-- 
2.37.1


