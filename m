Return-Path: <linux-kernel+bounces-77973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFCA860D93
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3BBB25AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F75D1AAC4;
	Fri, 23 Feb 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MFyrblG9"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30D28DB7;
	Fri, 23 Feb 2024 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679270; cv=fail; b=G2HC7heV877d9xNwtVdAFY8AAp4eYssyJGsWV1EpyZGohS3LwyOQTV8dRdD1QkmoSRq8oCKeKW1RjlDHNiWqRuDiQWW8fbkUovA/qRz1ZnezjM0EGkt4i1o48WRE3I1S9d0keBxmwLR6LDrnPdy8Oe/KT8A7r9Zvx3Glk7fe0+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679270; c=relaxed/simple;
	bh=/brJHTS0f/cJY+OpcU4MSq9UWHTJHDSGEAEGhzhWnTo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L5b9bnzumsL8QrJE++Outul3UTB+C0+KOSoOp/tkr5Zp7k4QgVxzfoa07RpdlGn0UWySghGbFnFAddu7rmnTYNn2/psudZDiYnCglPgEoONCNM0YocPW5KdN1VGB1wiTiHrZp1BMr3CCGfQt9SWA+b5a9pRSE9rV8julY8RR3cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MFyrblG9; arc=fail smtp.client-ip=40.107.247.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki1YTN9/Dlz/S28lzY61//eskHc31YFO/FLHePkeHsc+JipMDhHUCR1uxRAnjoEPTTkt23o8eaYdXE8Kd1Z4Yuzpcg2rToyhcLpx/I4mOvL4Kf5OSF0/s8h0WJDOolUvhp62c4MqN5qLs+O+nj58KT40juqVcYOm8CQygaYtH2bXHwnPXMBt0J/HZpDf5eiwOhx2uo/LEnTQfdtWOOKpz1UyrrE6lXOfqr1o6ky9OnXn5USm6eZYcxm8bzN0acT49/7Ab/D9hLRRdMAfIownXP5eMAWkF366xlfw+mAoxGFWkha3jrfeSww8MJqE1SSLHcHoa9qrCHOCCit33erwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW+4IBWZfro2j8dZUHseL5uNSHSzkFQGDsADZByp/hU=;
 b=kofTmNfFnwHFFCXBkk9HQxyU2+x/12gWUIBnAmKCXniKL66JhIULMXr0aKM7VgyvLUtRZ5JZyhpYXCrzC8dKV3zd2XjUU116U6nIIswGDZaNNlakowMErkqk3GjEFO6VmymcTFApB6QxPCAxtAO5ITr7O+lCBRV+ZqVfUIco/sD6Rtc7xYwvY3RX1jOtyuUFbiVkKjpzx/V4/KqKN3VUH9r6RqjC7fSQy8QClS/rz5rfmvr2ugcGOZY4+q0LCNfu5iHxPsaMAJsuqEhe348ATZQzPiF7JbeEFABpgKqt420PPXbynnNScbpLHKslnLKWKqtKUDvkaq6awSOUisRWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW+4IBWZfro2j8dZUHseL5uNSHSzkFQGDsADZByp/hU=;
 b=MFyrblG9p/2164NJf0Qi+1SjS8VM9x9dm3exkCk3e5W46L5VbUzgB/pYQUKA6BRc49PKWuChmvuNXuHF5OkUhmgDeMs/1sM0Q2+snJkKH/oMPA/RucGMKt8HtvKI2O5CCTSy+uhZCd2njKN0h+Q1L5Rtd99v5f4+O4S+yKHlFSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Fri, 23 Feb
 2024 09:07:23 +0000
Received: from DB8PR04MB7051.eurprd04.prod.outlook.com
 ([fe80::897c:cfd1:362f:9dd0]) by DB8PR04MB7051.eurprd04.prod.outlook.com
 ([fe80::897c:cfd1:362f:9dd0%6]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 09:07:23 +0000
From: Liu Ying <victor.liu@nxp.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	l.stach@pengutronix.de,
	alexander.stein@ew.tq-group.com,
	marex@denx.de
Subject: [PATCH] arm64: dts: imx8mp: Fix LDB clocks property
Date: Fri, 23 Feb 2024 17:15:22 +0800
Message-Id: <20240223091522.2880155-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To DB8PR04MB7051.eurprd04.prod.outlook.com
 (2603:10a6:10:fd::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7051:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a6fccb-972b-406f-bbf5-08dc344ed8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eKbNin3E09eSLAlbBX7MJthOlwUU598r7oGnVL8YN5VyrHNLHB1oWx+6u19cJCtwfPKKunEup58bqjTgjOOnwHMQyg99mVITV3L0vO+Muddx5T/qFcPB0y3owHISkHArJjRXRy/lPYPQM6EsRi36YGxF1fTCqfr+LjMtSJXOD7eHmfr8yFCB7ILknDSOF5Yj+Z3Y79zbjBqMOfzeqPfVVT5d+FrnWmqRUEKME3l0PHsQn6yVlns71C/7w0CSWRa1fyTqDuuVg/rhHICZqqJLWuJvZqu6C7YRzFVnDEWHO4v4rcyPhLvp/RDA+fNZmYr9FzUyP2VEo6c6sWstbus45m/xTXjAVBVEVqmGTzU/pKImyYloLFnOXvKXkk83ROGB+eTwrzP0BF3+T4SUKgeJqIr6dtTQIffZ97Fi0kFafOcqIhYNGu0/hyJSgpMy6WpsdKiXu1Zl3mW1wK8Mgj2PyWCwECKSLJV7pOk1ZiRdK45bOnJJuCqEIIlJDJvNZensn19IJAc95qo9kSCbtRQJUAl5UHg4P9qDLSIlN/zx3KjdSDlAPwkMTuWkDy2IAMwV6MZyzz8KOmLLYNzcyxnmWTQP2sNNENoBM30hu3QFYSHiauwB2avej3PQVZ9bmzkR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7051.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjyVmVJ5rdEGFvA4+DMXfOuMgqiLgmynLRCxCOlK/sCsMBkN2LLYC6JXAYu4?=
 =?us-ascii?Q?ys9IMzeWgoeSMw2QVzeMjpJ8BWonT6L4vceowjSe43Lwk4idcCkWVdnMnCTC?=
 =?us-ascii?Q?RHmF46bNx6fxXBpQjHcVELGlVC1a3isDOOUueeBJAdFqk6Csh8VEM36oCpfP?=
 =?us-ascii?Q?mUdfa93sAqJUytDwHiRgc9fxoenyReigseX5kHoTGuPKepctC2aANcWq5ags?=
 =?us-ascii?Q?upghRUYcuKl8EwMC17UvQ4PmIuCK5Bqza/krxB4gvgSea5aGcShdh8kgM+zn?=
 =?us-ascii?Q?vqke7GhhKnZJEuKvFJKL5AWaG9Nfahelj82rI8/SM9NP6//xv/4ma9OoVHYe?=
 =?us-ascii?Q?u7ag/nSPEPmAePaX2kem+2cYwQohJsKN5+G5HNg65UlAbLQ+91kc7ttUEjJL?=
 =?us-ascii?Q?mh3xw7MY/c84teeJq4UMVruPKWKO/0e7m7TF9jMqpFrMnbOFrYevLOvFLpXY?=
 =?us-ascii?Q?L/kDeRQAbLTHL2SKxitoLu4XL4sNb7cFiqflhbY9AwDFVQCtIJErwVQ5XbW0?=
 =?us-ascii?Q?u0nTqqnkSceJnnX6b5gT+gYFz8cIlmVHwWqHJ+FQaEqtKV1mZUW5Uv+BFryW?=
 =?us-ascii?Q?7zdbP3yS+3+QEuEvJbnUwpSJ3vMBWFoX396zRQ3M+BiCee9SPy025GAcIjsL?=
 =?us-ascii?Q?6/AZPil93F+biAkmIiN/sMvSC9jw+dwLbg0bRc3UqsWOdkq+VHMQ3p0D8iWo?=
 =?us-ascii?Q?YZsAIoEKpE/1JtvxNDT01RquzHORhzGXEhwwLcyF+7XIo0K52Mvd5z3UgbHf?=
 =?us-ascii?Q?5zDLdsF2KPYOKWCiGjO6EkHyAu0swmD3lu3WMaFh1hPeqKkhUbdVwAeng6t9?=
 =?us-ascii?Q?Ja2E2RM4aUlAOyOtIllF9hKR7sTT81xhUSX6RHGMxfKYv9CP/sXhpY5phySc?=
 =?us-ascii?Q?pa0zM7z0jqd54sjuKbnWaRdIpnEDRtdd0aLbJMBq+ND5sf+AZlq25FwgpIr3?=
 =?us-ascii?Q?R1LgocU3d/Btcilasx6GX3Ee9h6k4ntAKBU8MEo11+QJGps/kpJawIRVxOfl?=
 =?us-ascii?Q?eQAMAFWjbGAMw6ucbcRcVzkzX1NgpS04keKl2y3RKor6Kt5MWCXaIh5y92aA?=
 =?us-ascii?Q?ZgqI64J/lUB5wFjfJ7CGQUDd+3hGyM6np5pgsNMPc5DP5W9yaHSid61hAAfp?=
 =?us-ascii?Q?wgjlUqzZZe7QMTQAqMrnG0x74rj1D9YM6lksCaJhAI+irgLMwXFCxeepoAFf?=
 =?us-ascii?Q?53y2DnA1hOIc0U4q2j6YpHWefr4XAXjYYE+hkyd4BQIbODi4KMCf0+BHVg+N?=
 =?us-ascii?Q?KPd1TN1zcCLeSLAsrSqdO8EbeMjsayjMcjz5PtRnfhaEvIOnmz+N4gi2Kmlf?=
 =?us-ascii?Q?N7LCIcmYyKarWmFjptMIqMKJHHDa7Wv24yyOw7SZQWxWaN7HFEli8Uea39n0?=
 =?us-ascii?Q?dtvpuRGUDk17hKkw2pkTBVcXHmlPOgvzKFBVN+yDCuAoBfsxklVDUrw+46a2?=
 =?us-ascii?Q?fAdh4vxBml5aK2rx5nATv+juGJRG8EGjaTZ4tXqiHOPGl+4xTgUTsJZj9xTZ?=
 =?us-ascii?Q?uPyB9AuccurnWcA08sHvLWJLqVkJAl+6vKwlLwSBNWMHENfwHTZ5U0guon2l?=
 =?us-ascii?Q?JVQLi1ztMH7ZcRnY1Fhy/sBlrqQ8Jb7O1e2Q1QdY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a6fccb-972b-406f-bbf5-08dc344ed8ea
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 09:07:23.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0XPdK52s682va1xKWuhCU74p36Nii8d+hD4ROAY9vEI//ALgjXvur0xRw+c9Qw6L/kv5s8b/CdqmaC6YfsAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

The "media_ldb_root_clk" is the gate clock to enable or disable the clock
provided by CCM(Clock Control Module) to LDB instead of the "media_ldb"
clock which is the parent of the "media_ldb_root_clk" clock as a composite
clock.  Fix LDB clocks property by referencing the "media_ldb_root_clk"
clock instead of the "media_ldb" clock.

Fixes: e7567840ecd3 ("arm64: dts: imx8mp: Reorder clock and reg properties")
Fixes: 94e6197dadc9 ("arm64: dts: imx8mp: Add LCDIF2 & LDB nodes")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9ab9c057f41e..bfc5c81a5bd4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1824,7 +1824,7 @@ lvds_bridge: bridge@5c {
 					compatible = "fsl,imx8mp-ldb";
 					reg = <0x5c 0x4>, <0x128 0x4>;
 					reg-names = "ldb", "lvds";
-					clocks = <&clk IMX8MP_CLK_MEDIA_LDB>;
+					clocks = <&clk IMX8MP_CLK_MEDIA_LDB_ROOT>;
 					clock-names = "ldb";
 					assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>;
 					assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
-- 
2.37.1


