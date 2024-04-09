Return-Path: <linux-kernel+bounces-136547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB6489D570
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88E91F234B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E43281727;
	Tue,  9 Apr 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oKEp2fOb"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2105.outbound.protection.outlook.com [40.107.13.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C08061D;
	Tue,  9 Apr 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654577; cv=fail; b=o5rOEwunDrpgl7+ligsP6JUHOpsQVFLlhJQSvKS1aRLr0OABasxw/HDM+kOxMD7WQu3qNtQAlVUEhQTNy99A7ZDF9nf3oeE29412aDWeVZsLzc0OL3Y4FsVyjU/Nkyzqs86dAxWMzb4Z3D2aJyXRyp38le6TXdcQ3/Isx1SL2dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654577; c=relaxed/simple;
	bh=Gzc+z0v/RIB1UUQ4IGJiK+C6fBFgEW68d4jBUvf9Zfg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lt7xnrodWZ5NDnztQejdduXC/rkDV+iQN72Nr0FDPsqwNNunXP9rCX+SDIZmQdm+4/MNhucpBjO93JOzpwmk2PzY6eXxnLqE5EIGun0Yt1kRc3kkTGNLdeqqoyPx11qb8iqPq03Uwfn25H9Q1fQn3JvDl09NhlVqkLyjM5Fprk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oKEp2fOb; arc=fail smtp.client-ip=40.107.13.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdWmn7i8VjpFA08ZLGrE5q7VT489ju/77Bj1ylrNnv9SFc5LyjA9F1GKyLolxXMsqB4PBy2OndufVRL2vRY1sejVpguOd7XHz98sefEK85YGzO7GBJTrE244929X/oLQH8zCq6zIYbtw1NR5yDSlNtAecgcAWTpDbbEcH+er+vBiBXJkAhIniKTRNE4+MzgKOwJg4V6bD08XnKeXm+LbEd64YQ9Ou8651VLy/pNz9T34YdZfvL9WjVf9aqQ+YJr8/kGlThlzNxrldu02J+FX6aSGHtonibijvkr0RhP518hKz3Px5EQd1JVhUTOpUjgfvY0GOomWqgTwdcf6k5GJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01y7rUwcotKi72Z7yEbm1QIRBlYvdU5gNvyG0k/qEA0=;
 b=GXagRJ14X85o7Az9P3USn+TjPzQ07y0n+597zMDXcp6YDSl8XC38mxiVfI3WiGPUNBf2WyLLXaY+gbqqku5RVUfC52TSItNNuCnjTiFsVlQyqVuA7nAVmeffHwMTrObnxJbbuGYKdVWPUMH+eYaFyDHc0MqwiVtFVMtbD05WqM75pA+PTCiG9/LfuyAKJpBYYX84HzbpK/+XiAd7fqaQ8UgjGZzAs/qpj4XBKXIX1JCSn5N+xFSvOlbkUKwTW8CZl7k0mbX+552fua1RUN/YD97h+QqBfMrQysLsKsZ9F2T5iVF4SkUlELryZhmaXOfXia3Xuaau+KTLBSpTyb6dhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01y7rUwcotKi72Z7yEbm1QIRBlYvdU5gNvyG0k/qEA0=;
 b=oKEp2fObv77RzJnEvSPXKeazSWM9U6pFdzpn3l2zBCuts0Ct1GhOxVaHgNR0QA5s19O5PIGdcjcxy/zrw2BopjESfzJawusn8fnmvQ4hyfwYN5dP91Zu+ZF6rLsM21YgaLjAOaZzuTKHoTI33du60jzrpsDymYrHTWTtMvWJunI=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB7679.eurprd04.prod.outlook.com (2603:10a6:102:e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 09:22:52 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 09:22:52 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peng.fan@nxp.com,
	ping.bai@nxp.com,
	haibo.chen@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>,
	Varun Sethi <v.sethi@nxp.com>
Subject: [PATCH v4] arm64: dts: imx8ulp: add caam jr
Date: Tue,  9 Apr 2024 14:50:40 +0530
Message-Id: <20240409092040.3870497-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA4PR04MB7679:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hfcD7w1IIoib/9VMBCZWdl6v0BogzXVGboUteuEUQ2T+KkdDQka5L0uIrfdSHV4wy3LI0PaAss1JCUtQIowLtemcwCimOGQn5Pg2X4MCm4PcPZHZaErewBVYRaeRVGm6oTcELDsOEHUVEZokRGtR4Q0VlpxmFcRS6aUCUHHFTe8kPdsb8c/P9kdM3xEHnUNpeN4A54hJ8nvB/N5uODYgjBq/piq8jIDg/u220mqxrQ88Qety2FK/C3Y3KP74mdvJnDsr/PUqGVG5f7cuOe6Ox9lZP2OMcQluMkktm/2MAmeNg2CnVpd8twEen/DPdIY83RbKdlilbbJdtpuBdzP6hXc3dk+GbyVbSH9fuuZs8fViX8MQ4mDDeVP2hgL0vpLcvBpcBqUjtOTqUuuFfNIPQM19X2sy0eUtgyXqMe9YRDH9EQU8FfQI8liYpAgh931vAwblJlOg1tcsc5vYwEZV9mdMistJlB/SHjuX6F3vLFsK3tes4UuupYXZTA0vqYZF/iPiVtZ+OYoxAr+6qqSgALM+7eoL38Z5B+rxGnry0yhelPHNpSYuLIPMVjk0ttHJu8stuhpDo9T9rnTZHlL1ZfCnHr+MJ/dUbZc3PsvNSpzkbcdleksAUIWk+UoPUNkw2NwiAoOGhUVeN9jzs0r6xKnUAOM7kjmAXKCPAC++XLt4VaIC0HtRNAK3tuhxgPmt5CfqUqghcSc4cyIIOrUbL9yiyy158LL8xIDmI6qDrVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?na4qfg7w8Zt8UZL6snvLimGTbjqyUxWgXvdJCVf2Ew0iYse6I8CcSC8h+NfA?=
 =?us-ascii?Q?lpJ00hjBvuC0arq0xh1s3ocJonPOfQT38Y+UI8DuKpP/bVIC1r//KlI20zJz?=
 =?us-ascii?Q?Mf98oCnhZxxqGuu3UrgtzPAKh+fWkX0A3PJCYcU2/x2tu018hKT5KEdtwPKe?=
 =?us-ascii?Q?HuyXKd7GGvUG+9OVkkibKGXcZhF5TDzAucLDFgrAQq23u6T4voiI9sQ0VTaD?=
 =?us-ascii?Q?uKrie+WJG75DmL57iAdSmD+AufNvtpjYa1xPg8PyYHkn06RHC1tgC/ti1RaI?=
 =?us-ascii?Q?xRoCCFG4m/c+xkvrM9tYtSDDM7dkYNLzOzDMBaXLf7RxRHqZw1rfe5epuWvH?=
 =?us-ascii?Q?6FRTahmb9Bh6DeJm033Nnff2UOfLBBkIAJESUhgjqPMI3Xa2bOXamjE1J6zt?=
 =?us-ascii?Q?pKQr10uzZrtEkVfxuAT/3qEVPPpUMw9J5Kk2zriwUZTgG7eq6uEK9dhMdCWi?=
 =?us-ascii?Q?8egVPEtJGgtC06oxjYhoDF51PKc+zAlcSIvagT157tyqEYDOL98BrEgC4fVr?=
 =?us-ascii?Q?le/KznDnzVHW/uuf0aR4R1Ujgs6EPDwFCcctGado+LU+OGpYOeFjK8Y6TJfj?=
 =?us-ascii?Q?z0x4+0VgwD+3JAzNi1bgTUiyyLRWb6rpSPvHvPSn8nK0oHmuABAS/PlOgRp/?=
 =?us-ascii?Q?oBcwiPSOq5LtGDckwwzu7BsXl83Mrxk08Ny6AskDfqiB2GMVYF6Yo309jYcG?=
 =?us-ascii?Q?3sUuvW3i8EToyx+XM8ri4SBA1avImU5c/TaXF2lZiehSBkuYJpIndpBJ+EPu?=
 =?us-ascii?Q?hF6NomLm5rr9usxcTIaqj8FKwy+XBe0wUXkliS7X8aZtYdRv+KMbPVgpKg8l?=
 =?us-ascii?Q?jTQ0/f1ptY84RHqUOubBPhQLrCoj/0+tv1SAnDV6jQa9JuhHa4Fai6FZDfni?=
 =?us-ascii?Q?T3nADwcQZ9lDHVktrXZeXV2jeB2mx+moxwNc60qsJ2ARHCA6gepQhkdBq1v0?=
 =?us-ascii?Q?yQIYH3UHBeyMbuIG47mz7Z3m9OMX2OPUsGQKlODyIZoi1UAqMLOKtcVLvDp4?=
 =?us-ascii?Q?9bNAOVSuOC8soitlHGcgAstK8IbVtc/XaHqH2tb3mJA9m4nU7Q35LpE7UB/L?=
 =?us-ascii?Q?JadiXWISvi+UrThw4ZoUDBMXpURn3l5NYMQXYHi1wg9vyzg7beeb+QHqKC8Y?=
 =?us-ascii?Q?5tGWMI8JD5/h0y4fWJlZS4IjX0c+VAEsFGSXPKkrWecbWg9vq6XkOdXqGxmF?=
 =?us-ascii?Q?TfsztMYb0Vy/9Rv2G6QypjRaksFGqasxALHbJ8evXC87fuimWn1Nd5ZpM/Ah?=
 =?us-ascii?Q?pjslx/H+7OjYWk4v338+xzafMhaol3gW01qSVeKEbBzHr4cqneaYzeBw1s3i?=
 =?us-ascii?Q?yI8fJedOBClLHaTu3cxKQiNeK81LlvJxnsg1aJZlcJ2utpswWy3qU1D5aZdq?=
 =?us-ascii?Q?WG9pBJfN9FCRPYNlSq6U0hdjBnYRT88fKQQtIJkgUQWE5HqsUkCOpQ0AEmmC?=
 =?us-ascii?Q?HgW0hFiu98AXGFKyxOfiWBKebYURl7iln1NpGSTmtKFi/DPzj89isFT0IQPm?=
 =?us-ascii?Q?htDZCUKhBYw6FkDh/X4h0PnzwS+3IWpSmIGTGERZtO5ezfpTrkW9lSd3GRcL?=
 =?us-ascii?Q?EUmPQmD0CRThsd2nIn85+zABQkOxWr9wYXWUBWwz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac2f58f-e217-4e73-8122-08dc5876a181
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 09:22:52.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64B7H5AfIzx6yMSsWLs83cy527zEWibLj+ULuRZ3YlSe0YB5Qovp2tzYjHSz2jxdWkmG0wY4HI0jd4v0GLD8jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7679

Add crypto node in device tree for:
- CAAM job-ring

Signed-off-by: Varun Sethi <v.sethi@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---

v4:
 - Order of node properties changed.

v3: 
 - Commit message title is changed from "imx8ulp-evk" to "imx8ulp".

v2:
 - As requested, this patch is separated from the larger patch-set of 9
   patches. 

Commit 
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8a6596d5a581..ed86854a59c3 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -252,6 +252,38 @@ pcc3: clock-controller@292d0000 {
 				#reset-cells = <1>;
 			};
 
+			crypto: crypto@292e0000 {
+				compatible = "fsl,sec-v4.0";
+				reg = <0x292e0000 0x10000>;
+				ranges = <0 0x292e0000 0x10000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				sec_jr0: jr@1000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x1000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr1: jr@2000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x2000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr2: jr@3000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x3000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr3: jr@4000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x4000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
 			tpm5: tpm@29340000 {
 				compatible = "fsl,imx8ulp-tpm", "fsl,imx7ulp-tpm";
 				reg = <0x29340000 0x1000>;
-- 
2.34.1


