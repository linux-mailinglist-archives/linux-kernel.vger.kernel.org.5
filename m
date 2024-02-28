Return-Path: <linux-kernel+bounces-84650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB586A97F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78820B24C90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36328DD7;
	Wed, 28 Feb 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RPpkq7oA"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC1A25635;
	Wed, 28 Feb 2024 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107560; cv=fail; b=MxQhmKVyFlAAfEFDyu7FVg8tFohHkULhh/80pXMF8dxcG7BsOkYSDpnsSkpA0hkrlfPckbHw6H3om4Hu79NjLPZPt1iU6f9aOVitDlM899mgI8INnYdrITDyDFOmi8E4LJq2LoCjxDzTMFrxBZNyIm2RXgleMh70t+e/d2gvQxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107560; c=relaxed/simple;
	bh=TzMLS4iYJq3SrmulESfNd5lhxUFXcNZZZ4UNmY8q3Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdG2omo4OUw5K4MedLT7y1R6+XNrx8m3OIkiR+M0dEYZCS4IujhvbDXFfBGxn/fpMmO0UWfdLhwmvqdJh5IIn6KSwYGuOm8ImWV6I8H4oQNYUsAkvakax8MzqTqmgSOvdFVCG1FLGB1qb7Uin+tp+QV1f+hAXmpzlZS2HlZNf6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RPpkq7oA; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipqUbkjE8EAiZppQKK5yBPzhzydqlngyuJbT5HLjQfZ7cYrZ4k9lptAz93nhSmei5eV5Ama+l0r13yxw0qX34mgOLPy5spym8IrrpbSmah58VIB9WhLzdSnuplp0UUCaEVpO6WUrOMOWtkCkM9h2jTfmVk3s9cfnoL2//E7nrJTbyZ26sYq3NIAA+BijDYPp7q/fnoqp+7m712G/6TLJ3xjXk0h31zJYHT7Jqs42XaYbsytNXrAMXus6DQVNNxWxKiCPCxhHxlDdR89NSKwOlOE5sTOJmbRoqhQyofwiAxnyL/9o3Y83HDU1StWTOqODmFVYxfeZkDZxFZo70vYw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/Co6lVfHaDQTe/e59TK4ft18fKWGtwTJvfLgf35Yws=;
 b=jCjC/iB0pQAsBex2AVyhhlFwFgqlWb0YDzONcE8LuLXs59ds9ml57/2gjCvdTS5RCam+225Ixn7R0kOfhrxZT4Ul1ZsO3XwMnfXPT0sjhzGtf8Z7FJvOvvzba5jQV+f/bPRWLGDwECwd5bYinQ3E/U/DQm1fLruFImR3wAse+VbLbt/z65v3KUpASc7nXFbGjOE4oK2wJ8oUnUTdtSo6ZPZ5xPKCPoZXmVMTdHLB1Zv65Ul/8yJWX+NqUSxQ+ILzj7l/Za6IHHPLRHYvaRY/0Y7fp9yWLxb84OjFszpogAOY1ck0LS3JgeppwzoY/OMjwuf5oELb/TgALqjRSQMQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/Co6lVfHaDQTe/e59TK4ft18fKWGtwTJvfLgf35Yws=;
 b=RPpkq7oAelT/vwYNI448eKewKpqlB5/cCgBQEbEw/5qDIFgeFUQ+qJDlz5NHx/R5WtgkPqpYYQUCwTatjRhSWJveAnC4ksAQme1vwRpF3wN995cAAMCgd3uMjvsNiNk9zUSkUNnN2nChCvm1lX7CwlXggt0ZOJpV6QI/5Bd7MZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9858.eurprd04.prod.outlook.com (2603:10a6:800:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 08:05:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 08:05:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: srinivas.kandagatla@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] nvmem: imx-ocotp-ele: support i.MX95
Date: Wed, 28 Feb 2024 16:13:55 +0800
Message-Id: <20240228081355.1627744-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240228081355.1627744-1-peng.fan@oss.nxp.com>
References: <20240228081355.1627744-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9363ea-8661-4f57-0a84-08dc38341574
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F7VQP42jEb/+6kldNwla/TExPr1TXp2e/HGAhAFKBAj1Oyc9U+uEDlRQXBXd3iwWiYC7AeBt383YTHAUTk+QUqsWPtq6ue5OzSuHsECJ6SfvY6aqs9J/qpTdfE1oj/CcDId10pMhNqf4UvWwZ/7IrktxIKT3Ai8dtzHx0vEAlnBkx2+Qn3+pNlFDhUXRa1mn/2fPzlruTmhR7OAs9kNhaVBSFUvc+/8AEc8SKY1XLav+9lz3Z7RI4yjPzPqeaMJ/eb8Y6XrUmlDd0Tb95H3973wh+NJmIp26PNAJ2XJ+L+ZMC52peaPY3jLrA97SAThtCaPidx6u1d93+y8ZxC1FknmqPaUCj1gSWoHwQBS2XDB/Ppvj70zgleZ8URqjlKGyBa1lqSNu3Wj6mufWKiIzEAx/uBoVkoPm3UYleG7LNMsREn+oXEMAqh6oeMuXOHug/eIZgVLHAG+5CB9ecR0xkr1HTJj1SEAyHe/g4CEuh1UL4rCOIpCaIc3liEk6IixH+1nT8I2gzHB8Kh7WD7/WBw3JYTeZ8mKl/wnN3x7VLI1LqvsaPe3pzL67znZ+DPxPEs/W/v/nYsLsZVP1UeDWhRi6jj/zTBQi/6IEA/UAgEiIej2Zm4nePjMFa0HkJ/H3wkZcdfT45+siMYlK2nEHAhyK03xpz2JWrJi6vaMaYG0pVp6oE9kkQ9e8dfDwTjQU++dKuuPJb7GZn3wAy+6o6sv+f7BdeZ31ibVKBvjSJdw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?stqzK8AMZ5Wp/ckgBU4SFwZfydWBtC5SkZfD882OF9HbIOXir0pPhBXlYsrn?=
 =?us-ascii?Q?R0h9Xf6eiNBJ+gi0pjbC04Q1isTUB9cWn2Z7Sb6U6azyo64ylHkOtO19LUxx?=
 =?us-ascii?Q?7lEiJT/1iV6zeK4tPo4gayxAn7HBkVWHYah4HmNzVVs1ZtaLD0FqwLBBLkZ7?=
 =?us-ascii?Q?sCKQ/XM1T5FVkExBlh1Ui2MTAY2Gb1lW0pAJSsxA0Yvxaz20FwbiBSXw1BVG?=
 =?us-ascii?Q?XJPniH9jcQ1KG6dolNh0NzkMNEtJazqMesWCSVxmzBltCDSLU/pOkd5v3cL2?=
 =?us-ascii?Q?CKvLou/lf8X+rZHIqAYGoO2L2wRFEfCX6u7qDY2P0smFBE4IYQEsGzxHDbrb?=
 =?us-ascii?Q?PsiTx1u9+4+IaWt3Vs1IU+AvIFjGNvTjKE4s7vVf854I+wmxU9eIusKd2p/z?=
 =?us-ascii?Q?FXD18OOmtXb9tReQFHmBTEhSYV+gEGVo+D4QejE49TBhFVezjAahQ4Re0fBL?=
 =?us-ascii?Q?BCKkW/0J0dHF418FzkvHgH7KIYritNO/ZSRY6YajWNvNlBfHSDPEb/87utIh?=
 =?us-ascii?Q?xLTz0Y02R13Ssik0SvEiwD6iR1l6nKQwEVD7Xg5MIHuARwwFvv7dxbCVKdX9?=
 =?us-ascii?Q?CEnxdXIqg4dx/wbZD26dB+ISByBE9V1Pvph5yNB6xsE2TjlZXa7iU2MHCf8w?=
 =?us-ascii?Q?3rhuGUg/saSyU1UFnEJd6Adj6GBaNkf9JlAbT9/SK1ETHbGG6Ip3tReMHpBt?=
 =?us-ascii?Q?r9+2ppO8x1G4JmcwlBmvX16M1lOInLScLsXlygJKAl2KCvf+aIwXPPQo/xSM?=
 =?us-ascii?Q?J6tGAokLy91w5U72IerWYIbBha0lSoozpDOJA3jhe23IVjEI+GFo3P1cgolA?=
 =?us-ascii?Q?FQm56FM/x45dBwOqYuJTOuAZ6/LOdszxMNjAfiG8XVhXtCMKOjKEWZGN7Zyl?=
 =?us-ascii?Q?0e+pGGcLKf2aej5FnMWVpGppQq38XKAdt4Q0CJtnI3DA+3epe8HJ1nA5VFqt?=
 =?us-ascii?Q?RFXQ3fz71A2a4EL5jPHYoNfmWCL4S2cXkNUGWF1z+4BTEkaSAiTNu6cH2Q26?=
 =?us-ascii?Q?fEMP0Af6ZOzD7CW+2h9QvC/AItEmvRVsU6bESxFRtQnZONCzg5ZQFwC9OxpL?=
 =?us-ascii?Q?PpjRc7b78QTnqCR4pRintl3SzMLsK4H1peTUeEDlmxISp1zhcsy5lxU5b2qh?=
 =?us-ascii?Q?JE9IH1ZyEfufmT9Y39IcPw2EA3wcKnG2PAdeXJc8MjcNOtjD/nhj8mtaZ1np?=
 =?us-ascii?Q?KKBIrlCi/Tc7ENXVtmoqFlgv+ouk3xRhXmbQZs7HFUM4G+2KqA6B0r370u2U?=
 =?us-ascii?Q?WYIac67WAu6Zb1S4ghHtPkEQHa7i1ur2SkKejqXJ6+LW0qSEUXFqgIq/IwK1?=
 =?us-ascii?Q?G5X77gIegtALYzzreZjg2EvkmaWhjpzaOHe6NQJP6F0jgFYYp/KM6Dfgxmqf?=
 =?us-ascii?Q?vI69ccXkNY+zmtFMGc408yT3Qi+YneebJgdLMJbBQeXIwQ/rllxJ6xiOd65p?=
 =?us-ascii?Q?Enu8WzYyC3F1yLVc19P0lVUXWE1TOkf/smzoIv9uC3+7zXQxvr9FrErkFAiy?=
 =?us-ascii?Q?uPAfln00kuQ2GeqHWM08GqOGxzJvowFjQ8Mfclo9J0wkGb8RAcWX2zP6821c?=
 =?us-ascii?Q?Qb6gWeRJVeWYK5Ohi5wZoPmqBTN7dsJ2fRc6T0CN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9363ea-8661-4f57-0a84-08dc38341574
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 08:05:53.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYDcb083oVkM82BtV/vfdAu9I3VX1+bnp18qoPVBVkkJzEZvEVdyom11sFRWGgH7c8QJsKrQ8o1GT4rC32wArg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9858

From: Peng Fan <peng.fan@nxp.com>

i.MX95 OCOTP has same accessing method, so add an entry for i.MX95, but
some fuse has ECC feature, so only read out the lower 16bits for ECC fuses.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp-ele.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index cf920542f939..4f22310920a2 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -14,8 +14,9 @@
 #include <linux/slab.h>
 
 enum fuse_type {
-	FUSE_FSB = 1,
-	FUSE_ELE = 2,
+	FUSE_FSB = BIT(0),
+	FUSE_ELE = BIT(1),
+	FUSE_ECC = BIT(2),
 	FUSE_INVALID = -1
 };
 
@@ -93,7 +94,10 @@ static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, siz
 			continue;
 		}
 
-		*buf++ = readl_relaxed(reg + (i << 2));
+		if (type | FUSE_ECC)
+			*buf++ = readl_relaxed(reg + (i << 2)) & GENMASK(15, 0);
+		else
+			*buf++ = readl_relaxed(reg + (i << 2));
 	}
 
 	memcpy(val, (u8 *)p, bytes);
@@ -155,8 +159,30 @@ static const struct ocotp_devtype_data imx93_ocotp_data = {
 	},
 };
 
+static const struct ocotp_devtype_data imx95_ocotp_data = {
+	.reg_off = 0x8000,
+	.reg_read = imx_ocotp_reg_read,
+	.size = 2048,
+	.num_entry = 12,
+	.entry = {
+		{ 0, 1, FUSE_FSB | FUSE_ECC },
+		{ 7, 1, FUSE_FSB | FUSE_ECC },
+		{ 9, 3, FUSE_FSB | FUSE_ECC },
+		{ 12, 24, FUSE_FSB },
+		{ 36, 2, FUSE_FSB  | FUSE_ECC },
+		{ 38, 14, FUSE_FSB },
+		{ 63, 1, FUSE_ELE },
+		{ 128, 16, FUSE_ELE },
+		{ 188, 1, FUSE_ELE },
+		{ 317, 2, FUSE_FSB | FUSE_ECC },
+		{ 320, 7, FUSE_FSB },
+		{ 328, 184, FUSE_FSB }
+	},
+};
+
 static const struct of_device_id imx_ele_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx93-ocotp", .data = &imx93_ocotp_data, },
+	{ .compatible = "fsl,imx95-ocotp", .data = &imx95_ocotp_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx_ele_ocotp_dt_ids);
-- 
2.37.1


