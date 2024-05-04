Return-Path: <linux-kernel+bounces-168465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB2D8BB8E4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E5F1F21C38
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6F1400A;
	Sat,  4 May 2024 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Gn1H7oXu"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E017565;
	Sat,  4 May 2024 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783300; cv=fail; b=a3MPlI2csPjRpX1wIkhLTJvL0VK1nablO6JxkUYVzU3nLzMUDXXKfMrwTwhBOxw1MHRB+6Iob4KlBTKjboR8HQ1uSjq4ud3xfNXRzBmcmliJI8pR9GhOjWm5sq0MziW+QKHVBLvaJ5+ykIQQHwEDZKM7ctE6Mrnga38YY0bvDXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783300; c=relaxed/simple;
	bh=NAgjteHG4/XOhS80XUlWTWBcJsUzWYrufgmpN9Vk3nI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qOCLIHTiucQGuK1kmrTnNP0igp7N28DyGXm9W1Dqug49YW5m9xAA9VtMcEn5mWrEIAxbhB0cTQlle2ATV8DDNyknl9CnQidHEqn8fz2l2tVPEYTma9sTFRzL+fYImy8znDgfGGuE2knZUu36wq4SiJebZLdWvYBH2VElmK7nfd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Gn1H7oXu; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxHreot451wt8Bc/DlpfFE2jHhkt1mfxJ6WVnN1jMZh9ESGVYJ2W+Utm4amITNeX/WuLk6u+VnKIk1iQGl2OhbdXldvbOncMAPdVwPygLPhKoDJtC4R6wRpID1mSpHK09gE2tfDhkBc/eThAaYD6TigtmBJg6+TuNlTj1ENDgp95gsF2d/qx4cDz8wzM40teTVJcKg29jr1mQEuWMB5DjyDplLTvU8V/x3EXNJhYGlgHF3mZDbhzLsrC7BeXR48VpvY4nooiRpAxQgkWGLrVt12ycw5befKyewTvZMaDFjZzF38ifIQtm5vgw30qARkeRwAHOOvO2lb5Q28/q1ucMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3Dlal46WwJP6HqnyaAJPochMMZl48zjLeMC6YUUWjg=;
 b=jv/M9IHtx63qRd5A5darDsjGU4/ZM4MBkkldGF2Y9Aqh8bKGi0Jx4JRQE5ppkMDWHVh2G7Rch7B5OnHE9o6TOqaQ8M4t75rIbAx7Gdug7kpxre2PkIEN6FjxlKngABbLg6uSRXtHbhbVrYB85i9w3Q6VoSes90/qOD2SJ6PhQVGDgyP57ufwlbsU2AAQPMcO7SRZnSAPKx3cYldFnWI68tM1BQJPLBF+RNbctNaZFaMbh6yl1oPbwCX7g7NYmnfnBn26TjsuQJ0PtO0LILhdagszC9KIPF1YYC989UVuFKAFSKGVSSCuATjgSixIh+wpf5J84nt+Y9xcUIenmGiw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3Dlal46WwJP6HqnyaAJPochMMZl48zjLeMC6YUUWjg=;
 b=Gn1H7oXuIlhAhiPE++KDkjI2mK82hGHc+M3MrXaQr/r6EFOwZTuOlKS/8nuAGjr2nWPHgOQ3qMTeEuub6uxwnOpOxkp77ViQkgQYZdK1O2C7Fwmhi4ec9HqlywzpvI18ihaVrxHY+uafdo9eHc7QkPguL34Jdhs2UTOv1l7UMIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:48:59 +0800
Subject: [PATCH 06/18] clk: imx: pll14xx: use rate_table for audio plls
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-6-f7915489d58d@nxp.com>
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
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1433;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VsebgP4ftghgfa/u4sGy9l2KDwyNnhs9lAuDW9Fh9Wk=;
 b=aVp+giJUzQcsNSUMXsSbiu6QN5r6I5Tyl3LzMxLTo5ogOocVK3wKi2EwzwUdTzN8oHEvxE8Hr
 tBRp3mRIEXTDPedZFQusxGLbKCkxddHAvMkBFWUFL35ouDLt+0LUpgp
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
X-MS-Office365-Filtering-Correlation-Id: f5f4dc46-bafe-4e01-9ab7-08dc6bd2f395
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1ozWGw4aUVwd0g2RHJwMHFWSm5zRFRaNmZhSTRxczFSeHNmSHpmNTR1L2F4?=
 =?utf-8?B?Q2xMcjFkUk1haTgyZFlsK2M2RUJscHhXNm9lcGNlaXJZOXhZSlpYdjZtNFgw?=
 =?utf-8?B?N3ZCQXFha2pXM215RVBHVTIvUEhBakdIc2ZwZzkzV05UaUsxNSt5MVNRYUtr?=
 =?utf-8?B?YkJVZXk2MTA2ZGsyS21DaUtrbkkyWmEyWHl1Z1JjOUE0U2F1OW1UWWVhZUFt?=
 =?utf-8?B?bzNwYzBhcXFFT3lKVEhaOFN3SksydWFNeEZzcFBGdWpxNU5JbVJnU2FGLzV3?=
 =?utf-8?B?S3RRQ0VxT1N4a0JIWVEzT1dIWklSenhOL2plbjcxbW5LUmM3ME82aG4vbkhj?=
 =?utf-8?B?TDJ0bmhFYTRxRlI3MFFoYVdnUm1Yd0p6WnhlMTdZTkNaSm9XZERQV1BHeThH?=
 =?utf-8?B?WFNlVC9GeXE2SnV3QWh1ZlM0VTRDYTVqWFZGaU9pMDIwWUVPbFhlL2xibUN3?=
 =?utf-8?B?SlM2U2xzMGxpLzhIN1hCYjVQY1VRUjl1K2RSeGNSVUhIMFAvS0cybVcxY3NU?=
 =?utf-8?B?djVoRDk3RHZJUUlzSko5dWc0UDArRjdwRHlMeTJFc2FYWDJ6dmtwTnZtbmJK?=
 =?utf-8?B?QmlJSEp6NmZMQXIyQ0ZMSTNoR0R6WlZBYklsSnpiZnRMQjJpUmdLWVp1enNr?=
 =?utf-8?B?VmJ3VmtyMGNiZEhBV05xYXViTlpGUTJOcFFtcFUvNGVRVmxmT2pLbVBMOGJV?=
 =?utf-8?B?TGNURDdHcWVVKzlvZWpOVW1nYzBBcDlML2tqMmRaUTVuMXNUMXlQOW9OcjJq?=
 =?utf-8?B?S2I4U1B5NzhtcTVhTHE1MFJldGgzajh5ZGg0SHNPOWFZR29YRFZPdWhyZGJa?=
 =?utf-8?B?RDUwTUF1VVF5SlJTTDR2cnVic2UwWm1yOTUyUDJWNjZ3YTdaUXJKS25hT2tt?=
 =?utf-8?B?YUdvT2hvTGYxaTVScGt6emNwOG1ubzRaNXU1Zm9VOWlJWDMvZlgwVUxRNlNJ?=
 =?utf-8?B?dUp1OFA5WUFDOUxWcjV4djZockVZbk4rQkxzaitTdHBPcE5tL0oxMHpRQW82?=
 =?utf-8?B?aDlUNXJoRENXSVZOMFcyWENiVDNRMUk3QXgvNDBaMUNQbW9xU2xrMFJCSWhl?=
 =?utf-8?B?cUFWM2NVSHIycm9xN0V5aEZmU3ZRSlk3dWJhN21LcHNuNzVicExJeWwyUVVn?=
 =?utf-8?B?MmJhZUZWM1hmdHlveHM0ZHloR0k0cnZZbUx6VFFWS3ZNOWFCYXlyNWs1a28v?=
 =?utf-8?B?Tmk3N3UrRmhjOUM0dG9EOGZBbzBhb09XUVA2b0pDY3BCd1J6c3FVSG4zbW5a?=
 =?utf-8?B?S3YzWEpGVTM4NC9GYzJwUjUwMTNUa1VQampjK0hMV0xzY0h1N0JUZjU2SVpa?=
 =?utf-8?B?Y1U2aVNvSDljWkJYckhMVlFVSnlUL3BlcFVPeEhtNUIxeEZjai9RZy9lRTJ4?=
 =?utf-8?B?QjlNL1ZpbzduMWYxYmF5VW91amlwT0E1ZG5rOXpjU2dLZlN6NlJOWkRMaTcv?=
 =?utf-8?B?VkRGeFl4eXpaMmJuUitGRExhZ3NvVDJ6R2hEenRZMi9SK2RmOHJTVkNZeFl1?=
 =?utf-8?B?aHJ4dVhLYkJDMHlHV2FEUCtKYVZxeE1PL3hWakljeU9mTWJpN0x1M00wZDA3?=
 =?utf-8?B?MGw3bnNNa3l6ajVteXBPZGJlL3ZPUGorcUlVS0w3ZjJ5U3BRTWVWa0lQWUs1?=
 =?utf-8?B?RmwrcnJrTTdOTk55dTEzNkp3cHJtWGZVMmR4SWdJTmhESjFxTDJidGhrQXdF?=
 =?utf-8?B?eS9Uc2U4bnV3azdNbFVFcDQ4a29kaHZUTjc2QWRYQXQ5bFhpdCtMbGk1R2Vx?=
 =?utf-8?B?bG1DNkl6T1A2cWM4VWo3L2EvcmE1ZHYzNUhHemwrTldGdjkxMFBKZ2lTL1J0?=
 =?utf-8?Q?nRaHv8QHdc5hG58mpL2D9pY/lryrWZEKRvpis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2o1aWxRd2N5ZDJFZEtDNGxMV3BRMnFYRE0xNXpQb1dxY0taM3NRVzRLN2Rk?=
 =?utf-8?B?bHJQTjVzT2dXQXNER2pEY1FBdCtSb2swNFlESWVoTWlMa0RSQVVFeEM1Tkw4?=
 =?utf-8?B?VDlOYW1MQUowUkdTdWVGdVc1QlAzVENpVjZva3ZEd1RscTlwSWRaM0lBeDJC?=
 =?utf-8?B?clNYVktRaFV0U24wcFAwMlgxRmZGRzVmRm9jMlRHVXA1ZHhLZ2lkVXRmbVl2?=
 =?utf-8?B?YjNJQlJXL0syMWZzRWxiZEsrQUpPcHE4b0xGQ3RhQ1kwMXNITU0rdk9tbk92?=
 =?utf-8?B?K3BQSk9MeG0zR0tHMXRqSHB3YmkyVGhOQjBEcmh6a1ZMcGQvcnpMbzVGVUc2?=
 =?utf-8?B?QkI0VW1XSlVIcjdGRFlIQ0hiUEs0WENRQWgzUE1lZFJWZ0tCTHNQc3c4NkZs?=
 =?utf-8?B?NkhLMGVZT3RHS0pCQ0NadlpXN0RYbEJpZU9ZbFVMSFRZdHJ0YWxJZnlPS2N5?=
 =?utf-8?B?VS9RS0FnMU9WVXRzQzFCZUFaZWZsSDZCelBURERsTDR1K3A5blpkWDY2bzhM?=
 =?utf-8?B?Q01GR3pBblRKcU9SZzFJOWw2eWVCdmQ3TzFkYnROL2RxT0JxSVQ5aWllSUlN?=
 =?utf-8?B?ejdSZENNaHVjRGEra2FFUkNHdTRyeW1KcC8zQzluWEh1eDhYWHd1MmtBWDhr?=
 =?utf-8?B?aExTZXdSU293Nm9jRmJNVUlHVm0rQzdGTElzd01BZmV4Ui9WcFJ0Skp3dDBy?=
 =?utf-8?B?UWZQcXkxQ3ZwVk5RdTNSTGJuVlZhRndkQlNmTmZiK3pFUkZyTFBRakxLREVs?=
 =?utf-8?B?OHhjcTk1RjM5TExRVUJSSmxIOFc5czBiOFlSa2k1ZDZZMmpnN0RMeU5pSEps?=
 =?utf-8?B?OTFnOGpuZVNnL1U2M1I4ZnZLY0NDRlJqRWExUHh3Vmw5SDJvRlNocFdBOHNF?=
 =?utf-8?B?a3VNUmJiSHdYK1lmby93cDNsdXFJc1F4ME5xWWJLUnVyOTdEM0c5aGZwL1Vx?=
 =?utf-8?B?cng4eXhIZlEwWWVMaDk5MmZGRTFWUzlNRCtuZEhkSlBvbExiVUgvaWkrOTdM?=
 =?utf-8?B?azZPVnFjSjl6ZHczTC9aaWFYUC8wMjY3cW9HQmxJdi9pMDloREVIOFVVVy9p?=
 =?utf-8?B?N3VIWUo2Y0svR0pHckZoMWNEVW9pK0trVnpaOVNKTkhrVlRDWVhCcWRYdXQ3?=
 =?utf-8?B?bVBpeVUxamo1MjRPcjRabllLdmF0N2R1QjhBbmFvaVkxWW0weElwNWttSkxy?=
 =?utf-8?B?WXp2Q1dFblkzRG5SZEY3T0p5WC9VbUVQZWZYY2ljNURBbThxZDFIM0YrcTNh?=
 =?utf-8?B?YnZjKzQyWjVPUU5IYy9DdngvKzhCeVl2N013ODh6NlFtN01qM3ZpRzZJS3Ex?=
 =?utf-8?B?cWc1OGNxTWF6c1ZlMTI2bHBUang2SkRQLzErZ29EQ0pXMWRnblcvYnN5YW1S?=
 =?utf-8?B?K1hFWEd2UzZZclk0Q1FzNTJsZ0c5R2ZwYk9pZHpZdXNvKzZYTGk4anJNUnhP?=
 =?utf-8?B?RllqaUNQZm16QnIrcHVLYTNIT3BaZ21hMmNjZXQ4QmxCS091V1U2RG5XL09z?=
 =?utf-8?B?aFk0TENWSkwrWElQTUNpR0Zod2V6OUVWUGl6dkZUUDR0am9COFo3WUdhUDFz?=
 =?utf-8?B?MUF2MUZ3dUU0Mmh1dFI1dU44NlQ4cW9IeHAyNW91U0JmRmFFemlVNWRzWTdO?=
 =?utf-8?B?Y0FNeThGT2s3dW5qZjNIcFVDcGFVN2dITXA4WDRZWjVQb3pxU1JCS0NFekRx?=
 =?utf-8?B?bVVHaVIxbXBNK0UvUFAzTzdjUWZGMVhJc1BOSkxHV3pubnRCWTNiY3NCN2FU?=
 =?utf-8?B?d2hJOExtZStUV2g0cGJxelR4MU1ZSkNSZGcyalpaaC96d2dTYW1WelQ1SnBG?=
 =?utf-8?B?UVFNU0hWdmhtSzVneGV5ZXBDMERRNGNwWGcrdlphRE5NUlQ0MGt2MElaTmVq?=
 =?utf-8?B?cm9INS83anJXWG03UlRMbUlzV0FvR0xnWUk2WWNhNnd4eG1IUStGUjJDR3Az?=
 =?utf-8?B?YkZaZnNiMXRZUG9hYi9iRksvWmtCUzlQUk92MURHUG9uZjJzSDdEcldwQXRT?=
 =?utf-8?B?SHp0eTVQQnpVMTBiNmdVdkNQbDY4N2xPL25PWHF5czJPV0xOQk9KMjEvbm5U?=
 =?utf-8?B?dkZFekV5MDg2M0xsRGpmRWRVR3d2anF5QzJDWHEvbjgzWXltdHFuRmxFTHhF?=
 =?utf-8?Q?Obk5ePWLcPL65KajtcWIOSw+K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f4dc46-bafe-4e01-9ab7-08dc6bd2f395
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:35.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kgf2yexnRqZ2cEvJ8C6ALpyW3c1IJ8aFvNmUEMD6t4AbRfF4RePghnX4fjkGwsKCUteR1/f9c9u8AFFNU/2IuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The generated clock frequency may not accurate, for example
the expected rate is 361267200U, but result is 361267199U.
Add rate_table for audio clocks to avoid such issue.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 55812bfb9ec2..6b2c849f8b71 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -64,6 +64,17 @@ static const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] = {
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
 	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
 	PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
+	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
+	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
+	PLL_1443X_RATE(245760000U, 328, 4, 3, 0xae15),
+	PLL_1443X_RATE(225792000U, 226, 3, 3, 0xcac1),
+	PLL_1443X_RATE(122880000U, 328, 4, 4, 0xae15),
+	PLL_1443X_RATE(112896000U, 226, 3, 4, 0xcac1),
+	PLL_1443X_RATE(61440000U, 328, 4, 5, 0xae15),
+	PLL_1443X_RATE(56448000U, 226, 3, 5, 0xcac1),
+	PLL_1443X_RATE(49152000U, 393, 3, 6, 0x374c),
+	PLL_1443X_RATE(45158400U, 241, 2, 6, 0xd845),
+	PLL_1443X_RATE(40960000U, 109, 1, 6, 0x3a07),
 };
 
 struct imx_pll14xx_clk imx_1443x_pll = {

-- 
2.37.1


