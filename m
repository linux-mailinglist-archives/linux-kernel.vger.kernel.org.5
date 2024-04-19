Return-Path: <linux-kernel+bounces-150959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1BD8AA72B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654B51F217CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3A81802E;
	Fri, 19 Apr 2024 03:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DWy1OXQ5"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB210979;
	Fri, 19 Apr 2024 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497384; cv=fail; b=fPOpcPXvwmV4xggJWxvMRD1cXdkfuWFKJuvMpQEry0qt74wzVCmtkJurFIe3DnL48m66F/OEWrUk2BfzeSqc0erpR3Y+/HsLd94qSDLfiSDAOhW3Dw6Sa5ufFdpzFwL7VpCGvF3IgH7+S8HDdfz0UKmVH/s1ezYuoITt2sbUUoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497384; c=relaxed/simple;
	bh=GxCzQttCIqA6LM5I3YqUpjdK9i7lz3EmJ+FZh9alvws=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=judkFyZo8lLBa/oHtwmCwRNyijilk+KuRwFrVtRIi+rFh3WXAo3PR3v1627CM16cMXkSy5kkB+ZT/cAyDnSXvO/aTPyy12z6zGMY32g7TnqtgkFMlolIw2kteR/jFiPGK5AzqAqMMq2hOHK1KDS4GkjlnF/7LN3RH5fBI8tfhCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DWy1OXQ5; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R641RT3Au+EmRrYzdKRSxt8Cd+XVBIFFCpJiqQAVuH9KeTc40Q5EOwOQrpTPKUGITC/0YxKJxDozvyKXv2yXVWg09Y2i3YTw3acueGVo6LWwsC3fQXGt2soH+SWxTKDic10CGr63KOphIgiS/f6L057s3HtnYCN/SyMyzn0YwD6lW3J8BGt42nDRI9RagsshXSyDBuWtck8Eh7wu+GENPayRz1RVD0Z8Oqsm+QdOAPzUHyLOCTcJk6jrDSOyPtkPCQ1FPezcmonzmUcDd4EnVqzk9HDdthp2o1OHgcKTerU1ZXbmn1bA+1+rg0jvCAEdJGaKXMTC4hFWnK2GT+4JGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHq1roPSIB4Ja40tEC+Os+YKEXzefTn4rZfrgb1f9LU=;
 b=MKxPi+9rT+uJ9dmwkdls88DHvLqkei62HmBCF3EUoUwwMsTS2tr0kqgaOKbzSOh8GcJXXImryjSK6lpV+nUnLDROY1QNJM8sdOygbCkDzxvliOL3+a9cBiXdYKnsZpjNFusV39ouXIAX8FV765dtrJkQA+j/pKjV412SoVjQiFSYZU7Vwl3E7j9mkR4x2QukNhZmskQvp15tgx54uvmYbc8NGoYNBiBvBr9/a8crjYaHihW+6KOofANT8UqgDnKkFGdMSG/OAR9hy74C8vxR80MmVKIzBvHX6Cju1tmOLYs05HVF2r6XGXS9tVSNZAzXoGLFyhcpXzoj4180GxORyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHq1roPSIB4Ja40tEC+Os+YKEXzefTn4rZfrgb1f9LU=;
 b=DWy1OXQ5wrLAMQHiEmQHqDZUuPv7qAvMkp5Jr28u70xwH+0b4GvXDl6vNpRNFSJm6HLZg7SL7GOLh7eDpcTO6EXYC56J0PDMYF7+6zuCI65b6cx85uY9cGDnZXdCjj6a3qw4+IlPWwE7uBdqgq0vJ0yvnZXjRmPa9lwF174IPqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:37:01 +0800
Subject: [PATCH v2 06/12] arm64: dts: imx93: add nvmem property for eqos
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-6-9076e1d7d399@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=922;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=XpHH9fWzkgX0ChZpZFdzJg6cer3AB46CAW1MMWSbdms=;
 b=xvsVdSBp/++eAThM7EoPm6CuveJ5DhAlkB2/tG93FjCtNEp6pLwUEKQOKP2/l4hCFdUCIvKcw
 RynimuTju1zBd934V/owsoFBlmq988jdl4nSczSjzs99ZUBR9QrcP1H
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
X-MS-Office365-Filtering-Correlation-Id: a24f9f45-b436-4def-f527-08dc6020eebc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GuKWw8TI3Oztz2PVKcGnQUE9cl2YaQnK5npvgIBFovBknl8ks7uXIk82IdjXf1ljf69LhzFXUM4jTY5qShfRvuqMRcwaw7CoT3lRZy+jAwcGPe1o0DRGN1qsLZaMHj21ADywVgipu+un8IltKV9AitNTcTZMtSWk5x30rTKnJGdg6Dp+IEH6KwiVo3lBuH97M0W2KMtvknm0SWc9i2LQwmyzdvyhPymN7b/nIOLKlkh7F3R916ROti1seVZF2F5yHkRiRttVkMLZ4IsZAeDSysXbosJXV1/S/kg5ERQRL/z26T7YvPdWeSi3YY1+EXlO7p4ij9RDG5Qn6DZd9MGWZGBvup1lEUZkSA2SiElmo86J0z4+w2ratsorFA+rmJ86m4Hz/wDHfuLUalUxpA/Am+ZnVWwohj1qmgXMptc70c/yG9mnFq9Gwkiwe2eBEIKGSyxPyBRsZNQSvgDA/SjS0qMoPciBHlVoe4FEweoQI4vhvegsZAHSvxgQ12pXugTDR4Xj5rC/HnkdiXhEQLQopXw6ab+AOlGoQs+VLHPLdrKSX5IuyD0DRe/zxVvx4vG/RTTSbpQw5v460HXb5ykY1hk4B+DkEe17MU8QMycNjspx/rHvp85zSJPsKSdXCh0RuHHrpyrr3cOMgr/mlSvI3K3159jjvhIIYfiUC6LhZ1U2U6GIlJvt1KWMoI4CUwHm4ORsLsXwF4gOs/GhmTAgN9/ZgaZ5xWroiCzW+7+JEvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEVDdklneTJhY2lmZGx2VHNqakFXT1AycTYwM29vdFpEZUNaalNScFo4OU53?=
 =?utf-8?B?OTRIU1RTR3JsSm5Ubnk0c3kvZzlVcVVkT2dFNXFjM1ZTMXN2c2Z0VE04UHRv?=
 =?utf-8?B?MEZLVkZiSGQwU295bnRmQUpYRWtEQWY1RElvYngrMzM5MzBBTEhSTDh5Y1NB?=
 =?utf-8?B?by9WdjdkSVNnbGtQWDhiZXFHUTY4TE52Y01QUnJLNDlkZExkQjRoWFhsQVFl?=
 =?utf-8?B?V2FsOHI5L2dMVWpYRmZDTW9ZTVllcHlYbzZSQmZrU3BWQmE0VU55L2VGUEFJ?=
 =?utf-8?B?MVE1Y0tRWFB4YVNYemR0S2FCaWZZNjFiRUQzRm92MVBHUGJYbVMzL3h3NTNK?=
 =?utf-8?B?VDhoKzQxZ1grZXpFMTNUSVJ4NWpBTUUranhRUzFWdTBqZnBDUHM4YjNVWUJR?=
 =?utf-8?B?cG0yNVdtOG03blZxSHkreC9IYWo5T3JTdllyRTF0VkxMNkYzTU5LeHN1aUhR?=
 =?utf-8?B?RkQ3bnh2SEx6TU1aRlNiVmZQU1dWRFgyOEJUTmdCVForTk5leXhFVWlxUjNM?=
 =?utf-8?B?ZzZST0poN1ZmaWlSbzd6dFBUcW1Ca0hhMUJBdUE0akdjSjQ1c3hqbkRYdTFB?=
 =?utf-8?B?MDlRUEZxMGVMYXdjakxOaXVCLzVjcVNjMnVHMm5UQ3JhUXdQS3l0LzBrTWUr?=
 =?utf-8?B?b0VZU1FJZkJlNzlYaWtEdmdyZGY4d3ZrSlg0UFQ2R1haWGlFTExOcUxQdmxa?=
 =?utf-8?B?NHF2eFNwd3o4dTNBUnU2bFFoYXltTWIyOThYcnBDMHR3ZExlZ1hPSkd1K3Fi?=
 =?utf-8?B?SUtlVzI0WCtJbDJETTV6SSttRUhmeDZlb3Awc1NEZmtNaEN1d0s4eHZFbWVo?=
 =?utf-8?B?VUM0T2RYREczNUt2VkQ0b0VTZVhETUlLUm9kcjg3TFhyV0FKMm1RL0M4VHlR?=
 =?utf-8?B?blNMTzRObUlZYUxCbEV6V0lFOXQrQVVPRFdtUGxJWndUN3BhTHFSN3JSanJ0?=
 =?utf-8?B?aW1zQzVKM3AwTWxMSWQydWRldU9wcm5SSTQwUnNuZnNYQk5lWDlsQlNmRkdR?=
 =?utf-8?B?MjlvVFFwZDZLRi9Vd0h2NGNJaFBkb0ZsWUtGQjhGZFo3RDdGdTdEQVdyU1d2?=
 =?utf-8?B?RkRMLzJyM2doMC9BRXFuQkp3VmpEV1ArWnQ1di9lVEpoeEVxWjIvcXVxVlJ4?=
 =?utf-8?B?akFpaThvWnc4dHJVdWtLazUxVXJrK25FM0dHTGNRN0lyTUxrZndDcHFDbk44?=
 =?utf-8?B?bGhvaTZDRno2WjBBVWlyWThId28reVU0UVZTdEpteU1IcFpUa0ZNaTJKUE9O?=
 =?utf-8?B?WlRXOEc0cDJWOVJsZVJKUzZyU2RXYmx5bWpMNmlrR09SRWNZYVV1RlRuQVlT?=
 =?utf-8?B?S2piR0JIWUFYYnk0UmN6RmF5V0VJQ1Y1WGIvQU1ZbFVYYlFGMzNHMTJDOUJJ?=
 =?utf-8?B?VlNLOGR0dzNBTU02TXZzQjdhL3pPeDNjM05CaDZHb2FuOHd3SFB5cjVlSVVa?=
 =?utf-8?B?U3FZekJka2didFhLdXJGZGdjTlZRZWliWnNnM29NZzhQMFJ1UERwcnVxZHZ5?=
 =?utf-8?B?cnFpM1RvYlEyQS9WcStRV0cySGJkeExTVjBUYnRMbFZhVTFJQkxKTW9aZ2lX?=
 =?utf-8?B?MytSbXJodFB4bkYzNXB6S3VkUFZSRUEyS24rditTQ0drUjROVW4yUk5QZ1ZK?=
 =?utf-8?B?bVhrZXJXSkhpclBrYyt2TUdhcGJJN1dPRHI1U2plM0pLKzJFa3ZLd1ZZblhG?=
 =?utf-8?B?Vld3c28vU1lHUmUybWVFZVFWQVBVbHRhN1NmRFNMQ0x2cUtaSlVlTU8yVCtZ?=
 =?utf-8?B?UHp2UG9KK2RYOVR2ZFlJQnFqWUdlNXB5WURsMlp1c2NocFNId0hRWjZZNmlE?=
 =?utf-8?B?UFpoajB0dDZYajl2T0pJMGpUM0Myb0N0TkZwMkdJTzJMYU9iSS9VbkdFOEwv?=
 =?utf-8?B?N3k1aDlWQjEwVEpObzh2ZlJHMjZWR2dpMnEyNU1MKzZzbU04ZTRGWE5zNnQ2?=
 =?utf-8?B?bGJhYlNoblR1RFpESTVhYnNUeGNVSHI2WmlobEdnT0VublRMVXpSNnNWTFNU?=
 =?utf-8?B?SFFvUG5VUjdLd2FpMzhaK3MrYjkzS2ZwSHBLKzRaaTlCS293WGplZGFERVQy?=
 =?utf-8?B?N01YQU1PWk5Od1dzOVVsdkNIaUxHalJxeVVyWm5aaFZoYVl5Q2lXQjlub3Y4?=
 =?utf-8?Q?8vJj2Gm3hyeYfA6IuJqx1/BJA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24f9f45-b436-4def-f527-08dc6020eebc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:34.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCOlTF+/IJBsuy/BzNwVTeyos6n5xpu10G9ljIlxPUnwFhL9RdC7Ts5mBBwe5wZgONSMAGPt8rFCYzqxIJdMYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Peng Fan <peng.fan@nxp.com>

Add nvmem properties for eqos to get mac address.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 04d0b1c2ce02..7aee43a8ae71 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1092,6 +1092,8 @@ eqos: ethernet@428a0000 {
 				assigned-clock-rates = <100000000>, <250000000>;
 				intf_mode = <&wakeupmix_gpr 0x28>;
 				snps,clk-csr = <0>;
+				nvmem-cells = <&eth_mac2>;
+				nvmem-cell-names = "mac-address";
 				status = "disabled";
 			};
 
@@ -1184,6 +1186,10 @@ eth_mac1: mac-address@4ec {
 				reg = <0x4ec 0x6>;
 			};
 
+			eth_mac2: mac-address@4f2 {
+				reg = <0x4f2 0x6>;
+			};
+
 		};
 
 		s4muap: mailbox@47520000 {

-- 
2.37.1


