Return-Path: <linux-kernel+bounces-55703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D474584C044
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608A31F23DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5861E1C2B3;
	Tue,  6 Feb 2024 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="faS2cI7p"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864066FB1;
	Tue,  6 Feb 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260365; cv=fail; b=pVmwxAZmGiHdgylJfDqTh6oIcoVk4Z2ykt3lm9nFAAe8FJoGz+vYZiINl7fsl9Y6V81HPJ94THcWg404eXm0ESQGSWnAfalJt1FKaQBSxfTksjguBmkFSAikDGuf0/Fa4qpnrNWXcSERcefA+SE6SAlhsP0I8uzx2+s5i/BugKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260365; c=relaxed/simple;
	bh=eoSClNdlcVD5D0ny0/Gs4JmVdcow0bwnX4Jw8pGgvDM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=joz9bFUDJqrmC+hAx4/hq8QFpN0hWoxdtFMN8iPhNQwRQgKfYHgw9rCuCvUZ6JGfBFXf1ILbMipLnaivNi9E7huF4me4POoVjmYqHYDy5Uqb1zK7/WcmZh+g7ASA5os9FHGM7jiPUoS1H7H6O8rSYxwqbedlLu/WizitgbOdyrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=faS2cI7p; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDFZ9G9SFeSXFaKb1dv6yWW2HPBnntOFi9Ztob9fnkt9lrEdto/strV9qhgDEwiYddgKu8ARUM1G+bzP3UJV5Uk6QjIqgM3UZVkANQmFNKrYJUZMfHLEqmBO3WAdZS4XfhMhanzmzYKIaTXMX7uLbrnT6WfW1tisVXAghAxzqmT2apLKCtqEg7F3XaiTrKuKuxURMrWufsHNxheW230IUc+l+Cu0ACjlpA4RmhInRu4yLRS/VsHhxHvafLJr6Bip7a6jGE6Bhn/AQK0xBI74M0JfyIEQkWjK0g6O9bjb3hl9uHYWQ8oZsKK8GyYhJA9ffMUgStXoWH62ZVxRQgdMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvDb7vBjThHZvf36phv1oBwttLXZ9vnyKblGLjJP/Iw=;
 b=ctyTS6MaQAycvjCiSjJ6AI4GY8jZUTwMM7wvweoIe8lwQy3NxdR7Qw5+0KqUHmUnRHSqxwmXIyPVn8i2jsTrZxLTVO6Y6r7BFDVwoqGGhAdYbTeomng+i+St+zqetuuJxvbYWXj/yUAzmgkxs2ovgTT/IjNB0iYvJLSfcUvesgqKlw8ASa8qX8CTo9oOdQY2SIji+WdC/5qny+m5UUiNmKfYAHbmtcW0E+JlIDNR+Je9N274CcDNHK72xOvXNLWOH3nNiKjnllcjbDsEqGmuaQCmAb5RTOiYrqIM5pC2LbFBAtQI63sRW7VevXQJ3jQKnnzlF1ZdP5bRV+hQsNLL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvDb7vBjThHZvf36phv1oBwttLXZ9vnyKblGLjJP/Iw=;
 b=faS2cI7p4+icXGwaP1ZPl/JklOJUKSRDbnkAWMxQ0EQ1/OYCxekah2I+PA7coxMSh1bbfxWvKm0SuYH3H9kkHvE3l+c2yjvcpmrMofGneHXHFhJ7fMQ6SVz+KhZ+6Rgi9NM66K9M3OxDsWFL2yylaLweaAqYdefYM001J8X5UCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7988.eurprd04.prod.outlook.com (2603:10a6:20b:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 22:59:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 22:59:20 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/2] arm64: dts: imx8qm: add i2c4 and i2c4_lpcg node
Date: Tue,  6 Feb 2024 17:59:03 -0500
Message-Id: <20240206225904.3565362-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fa1eb7-53bf-4148-3c68-08dc276740df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b4JFA+HBGB8Vm50ZE/q/6B5a7fUGhI7rM7AyTRQKOeLngYRBBhQcbrwz8X9fZwMkrW6zimtEuaR3U5LA8rQrdEutKlBVrJ+y2t/ADjlB3BQJ1NZAc7+DcrIwwCW0Xj2EvorvwLkqvPC+9LPycAn7uUgvbsUr7qVa9ujREA9K6GOJ3G4ZxiNuZVkkOzD/KdUWzBtaQ9FVCFz35oYIBhQwGnq971Jsbrv3S8w8YhXuEV8YVsUg0MtdGPpIEuPtPRuqsQIoKKv6TyTj6D94E3tyNVv5zqSePmR3WSn5BY/Tv+8qCoqTDdvrm8wikRJFZUei+Ui8loTfFBHAwR5MDUG4Ufd/Ty9HnGWDFQKQ0PbJn4CcNG2Llne2Ql2L/r7FLk6fLOwxnb2xqvEZDBGC1NdCPGdP8vhS/vtPmDYWx/H74v/OzjXtxGlrwkqZozin4kZ9RtLnHIt81EBG+DUkmb6SNuA3a7RER4CqAIKIOSCSRBlA1728hyP/9UX/XGROivlwtgSVoE/xpcTUS/UWrXjIkrmLP7uKWm5YZ174GTQt5CWU9Xzlk3WgWUNZ/7x1GxLhNzLzlQ9Hm8vyXI9a7BGEgd3iCwIk+n+8xlIVKwtqFbKk4UKuhxtHWAfY0/OK4Wbh9lZbwrye/E6SjtiW/bg/EA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(110136005)(38350700005)(66476007)(66556008)(66946007)(316002)(7416002)(921011)(5660300002)(36756003)(4326008)(8676002)(2906002)(8936002)(83380400001)(38100700002)(6512007)(6666004)(52116002)(86362001)(6486002)(26005)(6506007)(478600001)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WeGPxprIQq4cziCRb9dPtyddLO1klmVyh8UncVbH4QDPDjAeOg7/XWyxgZqY?=
 =?us-ascii?Q?mdkpIoumKixBNwKgQfTvvm4aXvwxAIAJk/qVLmREbaZNdYXmZ922VaWox18c?=
 =?us-ascii?Q?HymnS2alouggae1n8WcMvo6JCLRR4wh4Bkza8KC055u9XBIeAX7BR6RJYIiP?=
 =?us-ascii?Q?T6etSYDNxuLoN0PXQAx1VnNUj9XyOpBFkkUgW5eO3EDSi93JruUh27nSs5iZ?=
 =?us-ascii?Q?x0uDWya2cv4q6gSHcHUTPm4nFQ/UPaBodhWk3ipMYPqXvuOVo38OYA9zLpOi?=
 =?us-ascii?Q?UbHalkf/yYfq2zoOeHcYkSSH0vCcMxnh6hPrz4dXZg+o0XVULwb0vs33mJ9k?=
 =?us-ascii?Q?aWsc677Nzdje7vUyC5CSY26qSugBeBvLTC1XvJo5WV7XcDncVFYkEptjBMO0?=
 =?us-ascii?Q?+u+d9psIqEPhE7JeQvFF1HOaYCLaF8rnj1MXMfSehN3+b+frxfSHHNG8Y4Bg?=
 =?us-ascii?Q?RoWd+2v2bwiIg3MvPozKJd8NEFQzP5LuCuXoh9kL/gYGBIce9vuaG9hG1+hm?=
 =?us-ascii?Q?Td9+CU3K141OozyknP+2yrCXGBhzjnyC6PrQQ4u25FosIRDYbEAuOlGAdNyT?=
 =?us-ascii?Q?eEYKFbOu4UdajKE21PN3dDRw2nnGRHdxwr8PFLhaX9HBhJ3D3HIhplm4QBU0?=
 =?us-ascii?Q?bk6lvSn3xSUISiFovt9FkIC/W0a1F0tn4sJtPdyvYIVA9VDApdoqPiegON7F?=
 =?us-ascii?Q?issk2hPu2/Rds0YCXVlu5uzWEf5SPnIQPJZJ6YymVr8m+6Wv/keyqXXolp8N?=
 =?us-ascii?Q?XPclWfDTcLpmM0oS0kQil3B7vsLSEiag1JZEKrSsRAfuG2eEuQIwHCjCBs2Q?=
 =?us-ascii?Q?+fTt0goGpiPkJnRsn3ja8J0ialpTJ6kwBaIaqtohBLfzWPL2KAEpsoGV/xLD?=
 =?us-ascii?Q?Oqe57jJP6yyyNehN4q8A9bz9UjPjtUFa/Cght2p2KjVnkExDFaqHmpDmcLUt?=
 =?us-ascii?Q?UbAwY8v1RaRH/qnQtY0BuTnm51k7XOCykJoHXzOoMPdJ6rZKSUXM4Q3msBMh?=
 =?us-ascii?Q?mY3Yju4NBNFfRankyIiqQ9g74DKXdHxX6eLpOp6WO1QEb0qp/90JpL11dtxW?=
 =?us-ascii?Q?jPaRLY1dzRGURsJ54yWKI91grSPH1HVmpPM3jcc8bWtnCbAj4mv4IGgXmurU?=
 =?us-ascii?Q?y7bovwm/S6Os1nKd6Q4vHRdzbkES9o8OemcdpGc9nUE43ACymvIgTS7HV5mx?=
 =?us-ascii?Q?x4kEuyuNaOQJzcwlj7sQolgD/jGZCsEceQEcCOiznjQCMEkLRYPTDLy2b9Fs?=
 =?us-ascii?Q?pnHUld5Z1WXdKzrZNID1Moi7+rzJHRnYLvY739+CrnK8KRrduP+PK5cmCKWK?=
 =?us-ascii?Q?Uo7fT+kSaMZVAAhEY6Qpbe275EkC/79vA/Uh2/JYNISWkDOao6fWEO/hxLu9?=
 =?us-ascii?Q?GqXaEOpxQVqMKiZvko0OgWyTPM2se58ZR1EQ1q1NN7xOTAZ2I0nRScC90klt?=
 =?us-ascii?Q?atDug2hZcmoD9IQxR9bCLqjQV6xZ5pifFfSr1amSQPQTzD5zjWiWm/sesVCX?=
 =?us-ascii?Q?kmVMkowo/ucdX8gBCbB1AR5ujSgzEKxrf0N31dBcv1A+TcqZSlmMrqwhD+wQ?=
 =?us-ascii?Q?ZOaJL7tRmfYNTZ4L0V2bUFdN7oxtJV/w51kLBCVc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fa1eb7-53bf-4148-3c68-08dc276740df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 22:59:20.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkPS/SP9pgS2KRxlqY8KelK2HEvJ6OPSYooPqi5BEwWpouuR47Lqzyogm7BNvJC+kOE9TIz4Wlx7dXh71GF/XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7988

Add i2c4 and i2c4_lpcg node for imx8qm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index cafc1383115ab..11626fae5f97f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -17,6 +17,32 @@ uart4_lpcg: clock-controller@5a4a0000 {
 		power-domains = <&pd IMX_SC_R_UART_4>;
 	};
 
+	i2c4: i2c@5a840000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x5a840000 0x4000>;
+		interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&i2c4_lpcg 0>,
+			 <&i2c4_lpcg 1>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_I2C_4 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_4>;
+		status = "disabled";
+	};
+
+	i2c4_lpcg: clock-controller@5ac40000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5ac40000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_I2C_4 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "i2c4_lpcg_clk",
+				     "i2c4_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_I2C_4>;
+	};
+
 	can1_lpcg: clock-controller@5ace0000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5ace0000 0x10000>;
-- 
2.34.1


