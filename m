Return-Path: <linux-kernel+bounces-147107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1948A6F95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22B92822AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868C13173F;
	Tue, 16 Apr 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mVJ+I0Xl"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FA13119E;
	Tue, 16 Apr 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280739; cv=fail; b=Y+wcEBGXyTWq9YqK0ZVMISFiktqBpm1Nk/EJXPdve7tGmvLtp+UQMTDfy6OTisb90nVp23S0YsKzxZHGrq3XFI+gns8awo+3r7fiXHQeZvbGEXlNCoww3Memxv9Iz1h7ugvbHLlkAbwTtTRrSpNNE4m66YzsiMuhqovmMFdCFXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280739; c=relaxed/simple;
	bh=yzWfiTVSSjZ+6X/d+x+YEU0zvSv6e6sN+nLMDJ1GVys=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fXlN+8ztaJ97XdSrnxwbQh/O/n95kvW1YoIo5Aa7arCQQYiKVbyF+VovshTT/Fmg939r+36kkX8sFvyLKIXz5xccHHiAfO2X4zxEDAyj7zCZAag/O/9/XUjZW+Cv3UVFIiQeE16ysbakCsbfEpEzwof5iSU7CpFyKNp0nx8vc0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mVJ+I0Xl; arc=fail smtp.client-ip=40.107.249.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO8l7EVh2zdMqCfNE9rr19CkuWODpxuMwDGUsRQ9xYf1dyxpel5eB6o+KC3fRxOZUtVSWjOVPEwDkkImV2lVmU35kT1xzUum6Dlgd85QF5cJIEa013N3k+UjYPuzJC76sth6libC2ZDbxB/+lAtdb6xJsy7E6x8VpYWmyAq0Dg6lhMBEKQVGiksDqcXli2L/a+ZZGhmZi9fVG3t4B7d8xtR+JmqEhQjdNdtan97o38nNSDKz/ycyqCJgIpzVb9D72lk0YTQBqHl4/vC+INirw6LUXDSh7GkvFR1xp+/AitMcJwi7PDCPguXf+kNSsnyo+N3eC5DGLyYnRlltVckcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W7NKezwmELsSFrjWyw98/PaLrZg5hjO5gaIBymVc2w=;
 b=PcvT/iaE4vGT0uTbV6E/UIbdTah2/0lmvcE3SS6MvQBLiKdqNgCendTKUePnIGJ92tZ3pn2NbK7aLYw+/QKHq59lYUecvsW3NLb+Ywt6vZhsOD93BDi1aafLJ5WsqS9w0UCYs1YdBxmUqgiVipode89aLo0bAjAInOqxb9av6bVTcczoTlMCLIU715UJvtajiiTdU7SjtBzNo84HKmCZA0UW5/jrjyTw3mWNBQCxjUwAEoFzma23VPWHjGLqIPGHvz7cRSt7kLe03awwdR+y2W2T3UXmzQT6piso/zGlCF9hgTO+u9fK88f0a7uR+/REMHGhL3QbNIDbJBRnUjGKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W7NKezwmELsSFrjWyw98/PaLrZg5hjO5gaIBymVc2w=;
 b=mVJ+I0XlKYcLUB4d4StS6+lxkFrqptMkxrmZWVprGBIAq5losx1mx+y7IVjTqjPeaYremU7CIjFu8sPvT5Tp53v+/zZXm7F6g7UUvQqe7IwsdNh3HYF428KB+fl9nw2HpWIPL4PA867BxJQh9zU74CvgiGsQSwLO1t4JySndDmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7039.eurprd04.prod.outlook.com (2603:10a6:800:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:18:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:18:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:37 +0800
Subject: [PATCH 01/11] arm64: dts: imx93: add dma support for lpi2c[1..8]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-1-da8ac02e8413@nxp.com>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
In-Reply-To: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281223; l=2626;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=5oF/x8PxcPbwIEPx68AVDmK3DdSghfjUDifVdGG1b3M=;
 b=YIIGhFctfj2jzStz9MY2S+slgtBqrD2cO3DF8ZbppxW2fOrjBdfeaG0bIId4JKpUS/sSzgO2h
 D8dVwEdY9WWCZ7Q9+fENnYcMVovDhUvXcxR19LAbYNO0nUENz0tP5Gw
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: d213a94e-3c66-49f8-16d2-08dc5e28887a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bV00EfZv0E6NI8ig3tJ5RP6cra10WmX/08d3oXJO/zp3u4Uve6CzXKCAqYq1jUfeA5+6aQTMPXqXOIxQp2DZ0+7olCBxJBuQiKF+HP2EV4I3Xr6V3/Y4OPLmbCbiXo4+CMV0zx2/TmtrgBFyvWsv9LK0lxAsfAfdcZfWgU+H0SAYvQHR5JhejcdJyCEMzZonqe+B9RwvNfOuR5Mqstq9aJmRmJuDofqdumFyKa/Wg20ZX7FDj/yC9vdTf8WaWNwo/rSngLJO2oNexyUmmA7zlKppMb1U6TpO7kvUP/JAjNVuA6sl/913qEst6Ilom0tOxJvah2aTjDIYiI9wMEkvsv6pIqZLP7flHpqcrhaxXnQpsjpyndsqeHqF6b+DDMBneJLzGsjxhRDJuQGH235mJHwvfrs+HJ2I6j2IwKLVizrhjgV+Dq4GuJM+hGSqz1W3FN7t2EZ6hgK9juUgGGyXKmvRDAGp1cwUu/qLqwikw4n7HMzqz1V3nAABM1LQI0aW+KwStX47nwlwU9C+n9tXwLCiXYDGacIPsblHyVnA6tFBMDDRy7qqKmjKWcKlaeGGVgSHLSadduJiulMCGHB0KpPtjjZgMN6gfjIAdwSU2GeWoIMncwJxWHAnSxHgFHL3EwL8QGaJd7reeNkL0s1lm1wvFFlC9m9TIkMZrSXdxMsFeS8Rj1sXg0MWmxA5z8+CmH/ugiXFaffjoB/cKDA9zAxbc/t3J1oHGiskPgZm0A8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE1VOGE5M0JuYS8zYUcyWjM3L0FldFIvZkR6QU92TEtaUW1CQTRxZmJwWjI0?=
 =?utf-8?B?bk41VHJPRVovMFYvUmtJZkc4TWVaSTQ0UlhxZHY2dXB3MVNJT1lpdmNON0Yz?=
 =?utf-8?B?SHY5eE9VN1FkSWNoc0p6cWRWRm1kVGZsTW1Fd0N0VVJyQlVldlpNZmJ5ODYx?=
 =?utf-8?B?bXpEeHgzZ0JJNVV5UDR5UkhtZmh4azRleU45VEJ4cVlpem1SSGFpekp6aC9E?=
 =?utf-8?B?R0FpYWhWRlhydTZjU3U4L2hiV3dIUitWWElyTXNaVXAxZTBLOGk4NlhpUWtJ?=
 =?utf-8?B?emVHZ2FITXQrMFZWdnNob1REa2g2S3NiNnRMbnE3bTRGZDdBa0Q4dXFiMDMr?=
 =?utf-8?B?OGpUN2N2TENsZnF1QVRrYXdRT2gxbWozNC9HSFpWdTV4akhlTnRXSlhjQUNk?=
 =?utf-8?B?U3NvUG8yTU9jaFozdXA2VzBYZ293WDJTMHpoZDF2UVB4RUtxdVUzK2loTVJv?=
 =?utf-8?B?dGlwSDVRQ3JqNVBXWmJFYklSMThwcVE5dDhSeGhuNE0remYwK0xYc29kNTVr?=
 =?utf-8?B?RHJaOE4xaVgzUXBFRC9LWW9MT2FzNW9iNGJyNFpFaW42T0dTTGFpeDU5YXA2?=
 =?utf-8?B?cXl2U01PN2ljY3h2VGxHMGRUOVlDTTZWMEV5OEtHdExIUnlBM3M4dUN0dVVt?=
 =?utf-8?B?Z3JFSlNRM2NINEhzVndQMUc2NEhaMEl5WktQMnk3Tm1VMzFtbTZlVk53VWdh?=
 =?utf-8?B?MytiZmFONlBvSFp3VUxzN0ErQ1ZxOGU4SGVLOWVva3hjUDBQT3FITlYwSitV?=
 =?utf-8?B?cDl2THV0WkhQc2RSUUw4dTdxVDgrNjQ2dGFTNXE3R1VSamg1Um9KeGZLVDAz?=
 =?utf-8?B?N00ya1BYOUhnN0dXT0MyZnlpZktseWV5WWkvM1A0MnZhQVNuVFhUeDc0MTJG?=
 =?utf-8?B?NHNEOVhDMTlQdlhhQkYxcWxwc3MxUVZBdkhMMURkZGFQNUZNK0lFTE9pTFBM?=
 =?utf-8?B?ZVRyUWQ5V0pROXliaW5hNHhnd29VQ1lGYmVDcGJMMytwZ0dBZjhmVzFqbE1s?=
 =?utf-8?B?ZVRPY0pJRnZaa0ErQUxVQXkzaVkwQ0p0aVc1L0JQd3hDcXhMbGNzRXcyMDJD?=
 =?utf-8?B?Rk5kV3c0TnloUzBDWS9rQjkwNFR6eHoyWFE5ZjF3RlJXMlFpNHJIazIycDQ0?=
 =?utf-8?B?SnhLRE1IZnMxUUM4aFNFTWc2aWZwaEZFQWJtVHllZzhrU1R2WjVmenhYcThn?=
 =?utf-8?B?dVR5bnhRSHlja3N5U0hoR0ZhRUpaV2srY1RzMlZRczRiWmtWekxNaWNsbTlG?=
 =?utf-8?B?a0JPY1loMGpqUnBTcUl4YzRwcjN5c3JFalI2S0k4bG05NWZ6QklHSHF3bENr?=
 =?utf-8?B?ekRuMHExWHlZZk9KU2kxdEZmcFpXWkZ2M2Fsb2VPUm1rL3BpOWFLd2VEbkFk?=
 =?utf-8?B?RC9IY2gzdTNZdlovN3BEYnpGeFVoSitrbkxUeGhEcUloa3UwaUxEamFHZ0M0?=
 =?utf-8?B?YzJOL055NTdqMUN2VFF1clRMR1lnLzNYclN2dEhpbVlQNkkrUGZucUJoRFJQ?=
 =?utf-8?B?SDNnQUdtUVRrSlJHZkNpcmdFdGdPdUJjek0rbHlVU1kzbWtlOUR6dXNIMEFO?=
 =?utf-8?B?U2k0amtMVnpCUWRTaHorSmhuNlBRY0V5Yi9FOEpiVmhMOVZmYlp5VkNIOTU5?=
 =?utf-8?B?ZU55WWgxS3lHLysxMXdGQ0tRNGlzVkthVjNnZnJDZlBlS09wVUorRjJidUQz?=
 =?utf-8?B?QUJHQnpld09ua2pYYVU1WVl1RTErcmFCd1Y2VFZEbmI4aVBmeWZsNjQwN2x1?=
 =?utf-8?B?SG53enowWmJxTEFtOUtBNlkvS3FpU2pyVTg0ZW9MM3lIR2VTMkFTNFJzTWlx?=
 =?utf-8?B?akhpOFBLNzNZY1JkL0NzWTN3S3pBblZyZVBTK3g5NitwVnBYeTlQaW03cW5Q?=
 =?utf-8?B?ZE83NDcydUhVSjg1Uk9IRG15TGc0WnR1YVBZaG40OGhzaHRDSjlXcG05MjZY?=
 =?utf-8?B?cEVYajBJOG5PMGw4THltbHFMUGlCMTl5eDE3anFXb3Y2VkhiRUZqQnFkZFV3?=
 =?utf-8?B?N3lYZ2Fxd2s4RlorRXNhMkZuSHhZSUM2YWEwSm5CdVA5SWtnOXNLdE1BeGs3?=
 =?utf-8?B?SmJNL2xxUEhaSGVnK3lKL1dzUUZHMm9KUjdOM2p0NUZQMnhJZUxJVVlFR2NC?=
 =?utf-8?Q?KMPxYKJQKQ8xUZQJHHbY0l0J2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d213a94e-3c66-49f8-16d2-08dc5e28887a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:18:56.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZrRFq3UDlA1yrj0gszAepwV3zla5bhVCpOW7YQxbYRxGyZCgX/kB5HmdMkUi0QFiYNcAQeq6/5bEz0oyuCHHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7039

From: Peng Fan <peng.fan@nxp.com>

Add dma support for lpi2c[1..8].

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index b8ef9b938856..5c08e8787989 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -316,6 +316,8 @@ lpi2c1: i2c@44340000 {
 				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
 					 <&clk IMX93_CLK_BUS_AON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 7 0 0>, <&edma1 8 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -328,6 +330,8 @@ lpi2c2: i2c@44350000 {
 				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
 					 <&clk IMX93_CLK_BUS_AON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 9 0 0>, <&edma1 10 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -692,6 +696,8 @@ lpi2c3: i2c@42530000 {
 				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 8 0 0>, <&edma2 9 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -704,6 +710,8 @@ lpi2c4: i2c@42540000 {
 				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 10 0 0>, <&edma2 11 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -881,6 +889,8 @@ lpi2c5: i2c@426b0000 {
 				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 71 0 0>, <&edma2 72 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -893,6 +903,8 @@ lpi2c6: i2c@426c0000 {
 				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 73 0 0>, <&edma2 74 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -905,6 +917,8 @@ lpi2c7: i2c@426d0000 {
 				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 75 0 0>, <&edma2 76 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -917,6 +931,8 @@ lpi2c8: i2c@426e0000 {
 				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 77 0 0>, <&edma2 78 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 

-- 
2.37.1


