Return-Path: <linux-kernel+bounces-147108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739138A6F97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AF11F21446
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257A131BB4;
	Tue, 16 Apr 2024 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l95fRwHj"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB369131BA1;
	Tue, 16 Apr 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280747; cv=fail; b=QQn5cb2YN6ryQcp+qI+6YyqoAZddxnzQZV9lJC8vAQj4rH+j6s796kQjlAD0tCaUr8EPKWNyRSe6Cn8Ib6cUO9JiENxDVZU07u0/CMHh7xtxUrY1TdD4t36ZVvFPVck7mVzLpTNUR6CQFztU5U1VhOw/CiSwMcA1qfezNxap01Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280747; c=relaxed/simple;
	bh=IXMf4KQMFhGV25dNj+i3nTWw4TBvIZXjY404c8XH5X8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q3POFNy4EgrIRIp9g6oNhsiONUZBTlh9mkehYLIkQJf5NVHcGca/3GDYV9DNFL3iR5wbnATuttv+8aUkGMTbRqtfZRJVxwMo2LKgy+BPStR0lp1SKwnFs/gDZW2RKQ6zLBw7FQPRu+XPPU4If691IWzfq4zDwjFGi/P4gS0fcb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=l95fRwHj; arc=fail smtp.client-ip=40.107.105.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnePe5MFbu/llRnwt1SiwLJwxtE0bAG9+bX5v2+07udq0O7Oi7XRvShFl+OQU0qfqEym/TrathgYUmPi/L9tEgBAhiMhflCRVGgnHxYiBm62LQ9PaWo9haGFzGrNzYjLyBZ8o2X0eKSVnHvuF9ldMQxl2EBIzhFMGnhEDLLsdhzqnLBLTH0KQ7qKp3mfjKPQviToGVxf9Q5bxSKg+pZcNjIkB48qXLR+PoDguj1H7iEl8WAtSlgBMWgm9uEtHQQc77Ul5VhRES7vB3ngdxYAsRwNZ/E8yvL3IdF2U9xQb41yJyMus2oYfZLkor3jKt22tE3DdRL6o1kHKHA7wZQxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBCyYSgZ3dbcOHRZmq5b9Yc6wf2ahyedhro1IQOgnvA=;
 b=CWWbECpB4NtLCSuUr/eY7EFX3eRjD6s04ZOYIO/+jB138IPk6edh9kf+i0ZcAUZv4imaPSWwChALoY40zcaE13xGdtxlOsVATtJJxba9uk0cCkbNJGF7xSiTMPcB7AB4jQHC2dboBMdSKkQwRhhxJpvLJoleS9FoT9UslmCry5GwPnLgM54XE8C0ZWkOo27pCK6/gFJtkskObqsPAU4rfxgDgQhVbOsXR16FesH9U4w0fIc78JMnygO+4T97lEGuoteQtXJFzkmCFKIwm9BXa+i52xbM0GWZuZagehiZI0UMSRGAxmK3Ss9HvWs1Y4r/qqoSA+TFuNcJz5fsgSEd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBCyYSgZ3dbcOHRZmq5b9Yc6wf2ahyedhro1IQOgnvA=;
 b=l95fRwHjj4D9Fqat7ihWYDT4uNHBUUQ0SpBeCuxxHqVnXUPqVORND9HBaNPw/HEJn9GbwTzxDVTFdIkihdjbfrOJ2ap4t6sfQfgRxUBJ+Ld/LKxglIT4Oi/JOAmlTWKacsgten2MMhOwC5G/Db7fcRU8u9MQqwf1t8rZZqe2/KM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:38 +0800
Subject: [PATCH 02/11] arm64: dts: imx93: add dma support for lpspi[1..8]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-2-da8ac02e8413@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281223; l=2630;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=eBviQjjFgEN5lnYsEmqMS0rKXbfK975Zf9b90AIzx3k=;
 b=iV6D7qnDYiRSplSNenwoiw9hA6BNf+LaFIysCTNHARbKUZ1k9A65FoKbrmxHQkKwIykCv20HC
 0II/ANZ7o60BwEexubp00KCG6wMUNcGTsh62FztyMBlIB0bTE3S0Oeb
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c33ecd6-43f8-4f73-7d72-08dc5e288ac9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IrBtVg46G7qLmfWyUcvU7YLJZ/ppxluIova2z7IJAWupldWcdbUlbZBG67XeKB525q1LozQtDPdrD3JOuLDagtx+muvMtD8YrCLbhf0UYLQBmFRkNteg787lW5LxFaS9xhaOpgd15D41BQHJoy9FmmW1opJyTPXluXixL4Djhtxvt1B6k9cLMJyZ0gjWN6nbUIHbTQadNc73lUGriT/FuUCjp2BgzJzS5JkjITYQXmmDOeOsKLK8bm4y0iuzrdKj5XTknNX3LbOqHtnllP6AiaJJNJmCYbzMGynt9SvLI8B0wS3HMxLwdNRS4D63uPN6KmX1K6ZTh6QLKcDwjoWMWkOQfTvtXSWL0asAtvEpJPe5YpvEHjj0658I9E/NplCi5gyza4UgteVmQYJLKRn/HhsJLTIuooqKB8jGXM/trmheQa6v9Rilk/Glh2XDJ43UrVipXaThC6nm8AYPpXFuGFq/LH3sXu3RBAG7fX45CHtApbaa9q8csWlRrAXvelZjN+/ZiJIIfC8eHLlX+wCWbCMcwQSNUv9G+Rmg6VYH+AvQ9BLMb3VPxU9B+MQ9F68xM4t9hgc6tZiM9F+djwUXuEO3mNo6E1uJyN4hHmbImyLKPcuoklgjtWlc+hWcS3Z/9nLgeGubxz9fSarwmapDxCEVEah5+kqKmgIWUAQa2eJiJlFT8ZE7sgX3entxnqMQc5kLvrWVJuvGFPhBYotwejjwwhJnFP9AMwCNJ6VUVss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmZvczZwbVhxUHp0OUwrcjQrbmdNeXFrMDJhYmdPNkJDcW80OTZPNFB6RlBt?=
 =?utf-8?B?VHA2ajFyR1IzaGdCcTY5c2N1RXZ0QlNFSEt2U3ZKZjE0dEZqQTRodmwvMjZa?=
 =?utf-8?B?OGNXOXprYWF4OG1saTJSZENnUW1HREloWU51K0orMlc5ZDhoYXJsTGRabXNv?=
 =?utf-8?B?clR5eHN0b3VHQWl6c3cwc1pjby9qSzdhWkFFL1o0R05pOUdEODBuMmhkbnlS?=
 =?utf-8?B?QmNpOEFOaWpFMnE5OW9ub0RxMitMOXZCMG1KcnNsM1hlNVV2SGVLL0Q2T3dM?=
 =?utf-8?B?dk04QTdkSE1QNGVFVFNpQjRENnRkdFFsTGRJV1lKaDZzMVFyaWZkOVV2Zyts?=
 =?utf-8?B?dkhjNjc1WlEwWXlYcU5GaUhTZS9jUDN0K1JhMzNNOUljV2d6UGhETFgrWU01?=
 =?utf-8?B?V205Q1dnUTVyOXVUUGJWUzFjY0RZVGNrWTFtZ1g0UHJRUUNtcUxZYzRGaW1s?=
 =?utf-8?B?SFVDZDJaNGUrUC9lZHlsUld3VytkNzFVTUZBYXdBS25pNUR0NlVvZWdWMURi?=
 =?utf-8?B?U2FVZ0Q2eENXWHN1dGVGMC8xZ0phTDBUNitNOUQxeVpUcXF2MlZQRkM1Uk9s?=
 =?utf-8?B?RS9SUDVsdlJqMlBUckVtNXBYM0lWUzJkQmxwNTIvUXY4bXA4VG1MLzYwMFhL?=
 =?utf-8?B?VWVqWGQ0Y1g1d054MnpQV1YvYXpybndNMlZDTDQ2UzIveGZTS3lzZ2JkUXNT?=
 =?utf-8?B?QkdHNnJLSElRSTVBcHBaQUFpbzhqZzhiT3RZVEFoVXR4T2ZNMkhGc1VLeG5U?=
 =?utf-8?B?OWJQd1Jxajg4TWxTUEh0Wkl6b2JoM2FoTlFyTzVsaEpSVmdId1pPK0ExK3d5?=
 =?utf-8?B?QlphNlRIaUszcUY5ZEtYQVdyMWVrSVY4UktvWE9vUzVXVE8rcnJkaG1jQXdw?=
 =?utf-8?B?WTA3NmlnRkxOZVJBUVlpcEc1T1d5OWplb1N5bFlEWVJZK0RtTzgzSFdnUzJ3?=
 =?utf-8?B?SGZxb0JoSktBejREQXF4dEFMRUZxZ1ptUEVUS2Y3YWJkNEhwQ1lSaXdVTmlQ?=
 =?utf-8?B?em5JNmN2K2NnaU5zd2tYSU1JQ2pHL2Y1amdhTWk4cWlHQ3lObWpNY0hkK2o0?=
 =?utf-8?B?NlB6Sy9hMGxKWWpqcUJkZ25xcFlzbHdSOFlFZ3lrZ0pwS2tVc2JFR2lvUWs3?=
 =?utf-8?B?M05GV3pHVi9YcnpucDhwT2VOSnRIcnlYSlN0TlV5c3RKUFIzTytRV0t1Ukl1?=
 =?utf-8?B?UGtMbmdwOENkUWlrQjN5MmdQSXJ1MG9HS1MvU2xZYzVsQlhaVVBZcmRiZ25H?=
 =?utf-8?B?djdRRUo2KzM4b0FDOXF2RWRTQlN2cFVUYTRZUlcydVRkSlU0cUpaV3B2YUNh?=
 =?utf-8?B?ZFkrRnZsb2dZTUtiZ0t1OWNzUjduVzg3SHh5RTE1VCtqOTBzV2l5VmZTSGdu?=
 =?utf-8?B?Mjk2bDhUT05TLzZ2TlMvQ3BQMW43SnltV1lZc3I3bkZUa1hvdFl2TDA4em5x?=
 =?utf-8?B?bHJCdTFRZ2IzTFVQU2UvMWtKblhxQWNPbWpnOWcraVc3WHZMU3ExUHZWcm9q?=
 =?utf-8?B?ZXdOODc3MFZaVG95V2pjVm5JeGxBeURnYnA1UENQL2kzNnJCSG56ZG05ZHRx?=
 =?utf-8?B?SU1GbURCbkVkZ1dKbTIwNGdKQUxpb0pEZ0xqbUFpNzhRckdwTWF2SWpuZENZ?=
 =?utf-8?B?a2lKZ0xKdXhoRURyUTk3YUNwVmZBb3dnamswWDBkcFlBQVY1RTIvc3g4NDBp?=
 =?utf-8?B?dmo1bVBldTIxSnRGeWV6d2VvbkowWERhbm1YRXpidE9rWkIxQlJXTlBVYWh3?=
 =?utf-8?B?cmlCeE50SlAwOTM4bVJJdzY5ZUVob054c0RvTUJaMnY1QW0yVGdPZGJra2dp?=
 =?utf-8?B?b3FPNmlocktRYTZsRkJEUnA0Snc0TjRZcU1mR0t5WHNSUWtRempsb2J5VjNx?=
 =?utf-8?B?dkJqYXNHdTN3b09SQkFYdGFxUUVReE94T3hUTFh4U0RWVlhGSnF1Q00rUTFJ?=
 =?utf-8?B?YVlUSS8xRHBkMTVpSEtkbEdOQXFjaXdFNlNDblhkSXVpc292TjQxM2dGMWdv?=
 =?utf-8?B?Z2wwSWIySEp6cm1PQjhSMFA2WmZEMUJESGx1OVY1ODVTdlYrV2s2cHFVem5Z?=
 =?utf-8?B?SUNhM0lDSUdITThCZEVNQ2t3NlhhM3NjZmhsT2VWLzRlTjd1VjBhU3hJUzlL?=
 =?utf-8?Q?ZRWHlP21qDYAKhQ8SnpS/JQ6a?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c33ecd6-43f8-4f73-7d72-08dc5e288ac9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:00.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9CY+D8CeXwnhvpZfKDe9CwW3wk/KaYKCv8EuG89mZejtD3L7I2PzFMLzYV/C01uOHX99H9he5IHNNx3Hjyg8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183

From: Peng Fan <peng.fan@nxp.com>

Add dma support for lpspi[1..8]

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 5c08e8787989..00f2526c4011 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -344,6 +344,8 @@ lpspi1: spi@44360000 {
 				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
 					 <&clk IMX93_CLK_BUS_AON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 11 0 0>, <&edma1 12 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -356,6 +358,8 @@ lpspi2: spi@44370000 {
 				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
 					 <&clk IMX93_CLK_BUS_AON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 13 0 0>, <&edma1 14 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -724,6 +728,8 @@ lpspi3: spi@42550000 {
 				clocks = <&clk IMX93_CLK_LPSPI3_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 12 0 0>, <&edma2 13 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -736,6 +742,8 @@ lpspi4: spi@42560000 {
 				clocks = <&clk IMX93_CLK_LPSPI4_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 14 0 0>, <&edma2 15 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -945,6 +953,8 @@ lpspi5: spi@426f0000 {
 				clocks = <&clk IMX93_CLK_LPSPI5_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 79 0 0>, <&edma2 80 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -957,6 +967,8 @@ lpspi6: spi@42700000 {
 				clocks = <&clk IMX93_CLK_LPSPI6_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 81 0 0>, <&edma2 82 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -969,6 +981,8 @@ lpspi7: spi@42710000 {
 				clocks = <&clk IMX93_CLK_LPSPI7_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 83 0 0>, <&edma2 84 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -981,6 +995,8 @@ lpspi8: spi@42720000 {
 				clocks = <&clk IMX93_CLK_LPSPI8_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 85 0 0>, <&edma2 86 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 

-- 
2.37.1


