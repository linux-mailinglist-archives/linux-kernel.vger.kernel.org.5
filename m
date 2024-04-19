Return-Path: <linux-kernel+bounces-150956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31EA8AA725
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6ABD1C20F13
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F60DDD9;
	Fri, 19 Apr 2024 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WEPXEFD5"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80391DDD5;
	Fri, 19 Apr 2024 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497367; cv=fail; b=aKbbsWN3RnwZj02oNn91WYXCmA0EFEIBG7jELqS5CGLIqeZnrksd4PLa7D8G77btBZfoIlXYzjJEZ7MpVfPKXeBwxAkOhwAe6F2cu3S1oXOpOjKAJDjo3CavupX5p+m77ghFrnIEsB8brurKebX4quWWGa1+PmKQe94yRc9Rxe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497367; c=relaxed/simple;
	bh=GtBcY4T6guoUq2WGAT4PQ6BeFvICXknALT9xiNftSgY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uLCdiIhVBW8/ditNrwH8LkeirZstYHWXBkfQzbj001jAcBhN++wy7i8ul2iOXBAmjI+44M15xm6THpsMbD68gMkdtGsdAdhWlIdJEcGnyNxwK42vqUHkMdcnjCqqrVayF+jlPR0OkMZK2fpqE+G6D/take0u9YoN6iGplM7mWYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WEPXEFD5; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqBQZnL92TGA3hFJZYW184O/JI3GrTvNcBLCoT0VsHAEmc2XcfvC92p1xbJLpZ9fUP/EItAkPAmBT/F2zaA+TD+iA5PCEZao0tOQ9NmQREgmVNNsk84AwFBFR/PwxNQ8KydeqbaCM2FzjooKT8SO0NRoRrmBxCik8cWM4XAcwZcwfPJfSOIOCWqgjEVFMxhpDG+ZCu+D9z+eRSHrNOlHFGA2RBddCTHjDWGfRQypc3prdQ10DKkp5eeuBrV943aBE+dyYWcN/3+n1GWyMs/OscasFFutWnIj2Sm8Qlb3vHJXrUjVaR9tE0DDjfsmBqMDNCIuKIyAHo900p1ibR954A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E376hw7okZA3gyRt6FHqVVoTkDlyzFXW28a/g8TKz6g=;
 b=eYN+yPRoEEqE06Y8UVLRxQPlv7AYOuq18nazhjs94pQ4dDZKS6NSzeMQAPUmcNcTaCt5EJ0RyEj47WzG7K5C9TUYZd240Julxm2m4RUc04da8T6qwRk/ZB6zFZoC/jKgw9z+GL7l17DXCJ9OFBcLxG4fwmSMGQPadBkCGAv3v9IzhkXgNtPjmMPJFDBw4MdmnGwiyNXdzaL2eRbrZfS17ZqxSrYQaB8JT3lFos/6g58oHR6qFr4foyoe9NOKD/sca6yNo226xZO5MxZir7BQFyGhMPy0ml4DyNO5161cAYSL7Dft3nOYgFI3uqvH7iLzpz2r/4a7nAAt7XqnFpQvjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E376hw7okZA3gyRt6FHqVVoTkDlyzFXW28a/g8TKz6g=;
 b=WEPXEFD5H2l3NeFXf8470pESgfQRw2qorLLxz0bpXm0OZVu+ficTJfZKe7wycgrZVhGUZ7wHUCc8mAq1pIiAuVerJGJ7JI6P6/tfTqKADfdDVhYIn1J0itRh6Ojxd536JrAPrMWdiKXcgfvuJfwa1j3D4FyYU+vX3VfpoPTsEpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:36:58 +0800
Subject: [PATCH v2 03/12] arm64: dts: imx93: add dma support for
 lpspi[1..8]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-3-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=2710;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=JRiwvwf7zsQWFnwrGpbPk1gr8vwpQcTBOuKKxzQjCkU=;
 b=+F6Pl3ZCd52DVDR/2m7Wzx1Z9GhWZqrRbpwcFDIOtYHSu1NK1BBIcWODlWRPk9mLpJkGI6J0J
 eUls1SKHefTB8btvyiJ+cF/l4ARJDLSiGe/gtGEMyHIdHbU6N/oXbzz
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ade895-351e-4b41-9d52-08dc6020e77e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P2ztm4Wzq6LMVVUZ7wDOGrK9RxJomHKCrjFylpR+QR+eXYLduIS2hX9fqOwxvwlwMJd0ZCErLVHm9zcJj6rtB258g7bZ2FZaiG9bl6zboBHmiErdXKIgV9CFUbofg+JKxt+UPK7Sd2Ni3UOJPGaNozijvVqu6/J1r4BANfNd2adT+URZTC+7RQSr50ZwPVRotFMV/Vfm8ESAgcd7izwUK2eNxZos1nnXLie4/OcKqKtbzQ6olfDG1SlYp1xVS7egko4502Uif2SWrjBYz6r7PT04NuGmOiRtkMLI69Hvr1IlibAosujGCy0aJjDiw9/jFsvgX8Vwtn55H7TDaxP23OOPaEKwyC52vZvu3ANhKX2xl6KbfCEZjY1PiEcdfDACGMg/WgVAtpqtEPXsJtk1z+x0TacBiFX+cLdeoIuE9rLiUhQQd4dEnbG4pfc9Bk0sPn0dRezMV7ytA2yyo33I8gRsDlphErJ8qXu6WV1yjQkv61UXl52OwXazERj3xipVLmtMtTFZoQPLJ6fXyvYkMybGFslte/WNFQE1caZG14Qj75iP+A6H9QneoL14GYH+8tV5GV0X85FkrBcNNKNxxR9ckcpgfm08wywsAq1p3b6PVzukGsLO+RC7tQPOmo18xTqsiIcMBSk5nM5NKYxkMQW4hMQjnc1Rn4nbVk4zk4uXxmTLeAIgSkK1fsK4+WHsbJx4FH3LfELiYC4LX1fmRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE4rU0ZuNzVPVnRLek1PZzZibVg1eFFoSW1wV2lLNk5iOUhrK3VXUk1nK0My?=
 =?utf-8?B?SlQzSGJVL0VGZEJTVmdNM2pRQThIZnVVdGQ3b283YzlTZU0wS29BZ3ZTOVYz?=
 =?utf-8?B?dXpVdVFFZmtpNnYxbFQ2QlJIZGppUlRjVW5tOGxSRXdIT3cxaDJrTHp3eWtn?=
 =?utf-8?B?Y2txWmVuT05CYTRVWVl3bHZQWnNoNk8rWDBhNzdEU3p6QnhTaGx6djltaU5N?=
 =?utf-8?B?QlE5bWcrbUhJMXRuOENYNHZwN1JzUkJXWWxRRnNSWERPMEJHNEJqNm1jdHlX?=
 =?utf-8?B?YThLQTdkS0swVTNCMjgveVFwaHJ0OEt4UzIzM29NUVIzZU16aG9TV2JEbXlm?=
 =?utf-8?B?T0M5eTBkc0ZwelBGbUlrbk1kWDNyaVNVZTJRSHMxU2NqMnhTenRMOTY4MXVv?=
 =?utf-8?B?WjZ5OFJ5RTJBRUpDQzVkaFZQMmJwR0JoSXpjTis4aFBWakpvYlNjenVXS3ky?=
 =?utf-8?B?bVV2SVZwSk81a3k1ekxscHpiZkhmMmlPcll4NWJiakZJWkpwb3ZKdVVaRlpP?=
 =?utf-8?B?akY0ZFY1V2VrZXhQSnNSM2UvYnhOR1FXOTcrYXVxMDF2SGE1RUpVL1UzRCt1?=
 =?utf-8?B?bkpyVUowY2p4eGV6ZEsvdXpxczlYU1UvaFhuNUdUd1Z6SXBjUU5aRFhLRTNG?=
 =?utf-8?B?WENHUE9FOTNXazhtbE9ORjduS2tEUzNidXpXWHlIZkJpTGVNUTZoRXczL1ZP?=
 =?utf-8?B?SGhXTllQV2NOb0dZUVlyQmJrcUNNRFVsODBMZ2NJU2tiR2tXRHNqRTUwNzNV?=
 =?utf-8?B?QlFYV05VQ2tBWndETVAyKzBXSTJXT00rdnFkaFczdWpWU1NTaDR5VWhvM2xy?=
 =?utf-8?B?MDYyNjNOMzZKb1NoMktXSzlGb1Y5Z25YQmlyN1d1N01kVVl6NVpGeE5rZDNm?=
 =?utf-8?B?SjRvU290d0c3T1lYRGI4OW11L2pEUUEyczJ2V3E5RU9iWEgycUlacVkxTENh?=
 =?utf-8?B?VVBOeVZ5a0VmaUhUbEsrRDFodVN5Y0VHSkVHZWowSVRualZBVVhBdHpSaVRP?=
 =?utf-8?B?RlB4bWhxVVEvUDl3U0JoeWc5QTdFOC8zRksrVlkyaitKWHhqQ2xFRysrMVdr?=
 =?utf-8?B?d3FRSlZ4MldpOThRZFpVL0hVVU9IdE95bk1ZZm96cnIwMklRb0hta1hMQzFM?=
 =?utf-8?B?MXVUekVtWXljQUJ6S05mUjZlTkxTMjNNQmRoU3NSaFZKMmM5a1ZMS1BPVHVq?=
 =?utf-8?B?MWt6VDF6WEdrRjQyWkN4TEpFNU5aMmhWdWZOZk1Tb21JWXNQeTZFVHpNL1ZF?=
 =?utf-8?B?T1NyUnYvQjN3MUU2WEVqRjM1akM0ZFVyR0dzelFyVXBFNlVzOHJoQWM3bXU5?=
 =?utf-8?B?L0hBdVljT0hiekxYYlViNEZGVXlkWEZsbkNDY1FDV1krOHVhK0Q4bjI1T3Mw?=
 =?utf-8?B?Y2gwanVISmd5QytGQWNidmVaN0VkVGQyZXp6eVhQZ2pNRkFrNkNDS2Ewc0tL?=
 =?utf-8?B?cnZBcFdZWC9YazE3OUYvZGtKUE9lSm9pNWV1a0FHbkdwNGs3ZlZpdmdRdlNt?=
 =?utf-8?B?SUF0T2hncmRxN0xrQm9FMFFyZnVWd2JTRG5XdVQ5NFpZYmEyckh5eUZvMVBE?=
 =?utf-8?B?eTdOZ2JSMjBUM201L1BDbEhtRnFLdzBGTVRUZnhVVnhSMm00Tms5VlZFSkF1?=
 =?utf-8?B?anBIR2JxOEJBbkp6N09sTGRSTHptWVcwSGp5cXJPL1N1ZWFGMVdoRktTaWZD?=
 =?utf-8?B?QitxZ3lDNlRKcnpmNWJGZGZhTzhMSGttM0grNG0wQmZ2aEpVZklFV1cwZmlC?=
 =?utf-8?B?ZlFWWjFmZUI5ZHU0aTVzak1Pa0NKRGtlUExwc0F0alZ3bUZaeEFGTU8yT2o3?=
 =?utf-8?B?U0kzU3UvWmlOOFZrLzl2VkU4aWoxK2FOLzAzRHZxUGdlVHBZL3lSWU1sbEw3?=
 =?utf-8?B?bHV5VWpLWUI3WlZFOHgxYUc0ejNuYXJTMDY0NWJaRGM1TW5OQUdYbXNUT2xB?=
 =?utf-8?B?NzJ5KzA0RjU4U2NkaXV3WGJidVNYTnlKWVR2dzltdzljNjRueXNRNmM3RVJm?=
 =?utf-8?B?WGdPR3JrdURUQUZyMlFmc2s3K08xMTJrRWM2dUpLMHgweDQ2ZmF5RVZadzdh?=
 =?utf-8?B?Q0RzQmMxeXQ4OGhUVzlmUEF1bjQxQjArNGZhMGtuVk16OTA5QU50K1YwamNH?=
 =?utf-8?Q?rz1RlMIdnCrbgwuSeVKR10k11?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ade895-351e-4b41-9d52-08dc6020e77e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:21.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6QpIsm/0FnjuXxbluA+sO9bHL3UhN5KWlBkeQoLYOxUtEVSpXIVWve+YuRKfXwJbLN7w4XCaSdkZgO6TCtsZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Peng Fan <peng.fan@nxp.com>

Add dma support for lpspi[1..8]

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 93c1d0fae291..d762d96afcd5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -345,6 +345,8 @@ lpspi1: spi@44360000 {
 				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
 					 <&clk IMX93_CLK_BUS_AON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 11 0 0>, <&edma1 12 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -357,6 +359,8 @@ lpspi2: spi@44370000 {
 				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
 					 <&clk IMX93_CLK_BUS_AON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 13 0 0>, <&edma1 14 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -725,6 +729,8 @@ lpspi3: spi@42550000 {
 				clocks = <&clk IMX93_CLK_LPSPI3_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 12 0 0>, <&edma2 13 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -737,6 +743,8 @@ lpspi4: spi@42560000 {
 				clocks = <&clk IMX93_CLK_LPSPI4_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 14 0 0>, <&edma2 15 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -946,6 +954,8 @@ lpspi5: spi@426f0000 {
 				clocks = <&clk IMX93_CLK_LPSPI5_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 79 0 0>, <&edma2 80 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -958,6 +968,8 @@ lpspi6: spi@42700000 {
 				clocks = <&clk IMX93_CLK_LPSPI6_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 81 0 0>, <&edma2 82 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -970,6 +982,8 @@ lpspi7: spi@42710000 {
 				clocks = <&clk IMX93_CLK_LPSPI7_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 83 0 0>, <&edma2 84 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -982,6 +996,8 @@ lpspi8: spi@42720000 {
 				clocks = <&clk IMX93_CLK_LPSPI8_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 85 0 0>, <&edma2 86 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 

-- 
2.37.1


