Return-Path: <linux-kernel+bounces-31169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA8C832A09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8AD2842FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DA554737;
	Fri, 19 Jan 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GhflzadK"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61354650;
	Fri, 19 Jan 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669368; cv=fail; b=aK+rjzUjyqjkxYrhtn+5j8StbM2NYnExzp6n4feAdLs/Jk4nGH21dJKOBQAG6bVVlqhvjsSNsVghTUJjXhJZ0vV2XbZhf06RDXK1ZFH44QO0PQ5ZrmzqQzyOc1qN8BnkzQSiMeSfioSy7QBPaN75PkooU2HX6dqT2cloxE1+hh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669368; c=relaxed/simple;
	bh=+PgzEpnAg1czOf8xyi5Wf1qdF9BhXZ5I5UHBPyDq7IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1DZE9iHq6c3R4xZeGHBdVE85kVvbRQLA4pkQFPaq+XSw/qH2C5TxWJPRYp9PmRsF8kK0Gw39OhxVMXIpQbr6niNVHtR2FI+whFl6Bv/5YNglOTAj/oLHGQtkn74+6DiVI3ElqPQNB5+wNvCbqXJzuRlK+AQbqUKIYmvbaRIzXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GhflzadK; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdl1Md5O0DBrdUp2/xE3DN+YS52V032D/fGecC2GiJc+Wh2u2cKAsUhBbCcwO7BODdSdlcslqkyQMm8cVTpiiurTtPEHX9gNoi0EgE188vAtnRx0KQl7Eg1gvY13OnVXYu5wWqEAQhchCLT8yVuvEbzlr+zm/i0PlTaM0eiEeAbKYroM1Ur5GUrgydkKzL7jWXV1UYBBT3nlET+KuCBnFqc5ffAYB6t9U64xAXBrSHyxqCifNKgXpE9J4DUzjrUKo/IQ7CXdjF4l7JfnYJZn8Nxs2O38XWs7X4t3pWzA9pFt6HI7Vywpekvo52UM+/IAFHMN42XjMJQgWgsRbahWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsusw1b/tFRAk3jIdDEQ38RIXrnhD5xUlJ01n89XjCU=;
 b=mJWS/fr7UH+j61T+1H4UmbMvSnxJdQv67tz9z+5GedhdeXM9ZQ9srsG7d76h9B16TbCYFlV0S89hQKy1TT9+t6Lo0N4rkZOoe/bc67PoRKNN0GjRK44Sp3e8Y7cHXXo6UE6fG3AwdLSWEuwPHStJbVE1JGuavygUj5nYHioZftH7v1YzQ1ovE/SJEtpT3xPsgkP3/oFKFAI8P1kbe+B3EVuQsW/2Ho4OvOyk/mK3D7Ra+in2FW+RmOqUxsf6sFSVfd/D46eVA5Q2VLWCey7VHccZBqtpH3NXu1Ki8zeHnvv+rhAsd4HClHFfASy6Nlht5f5wyBrqcckHP5r8B8DPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsusw1b/tFRAk3jIdDEQ38RIXrnhD5xUlJ01n89XjCU=;
 b=GhflzadKQ0Q82azs8GqaciV3eznP8KkH8SRXrdcTPLZa+cx16qZNZW6PJthPZ036a8dAqJTLO/z5UtUAanTl7Ll4Zfp9i3PIqbPrkfELDxrkPmlaitqBH8jhN3EHBXg4x8OfvE3Mn8yZ4/VP3ETjD7FB3zSlD+xpzKpMISHUi+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 13:02:43 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 13:02:43 +0000
From: "Ghennadi Procopciuc (OSS)" <ghennadi.procopciuc@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Andreas Farber <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	ghennadi.procopciuc@oss.nxp.com
Cc: NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>
Subject: [PATCH 3/3] arm64: dts: s32g: add uSDHC node
Date: Fri, 19 Jan 2024 15:02:30 +0200
Message-ID: <20240119130231.2854146-4-ghennadi.procopciuc@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
References: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DU2PR04MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a07f8e0-32a1-49f0-75dd-08dc18eeec6b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pzth+UVcy0TOKFGbNxZw1TUTzdSOvaJZX87DOVncUdHw8P6QxY/k0YgVsE7MnuoI5KS0IN8bLT8eTAkIQZD/FJcy1pjlqB1C1gnagQTgddN9ckrWgcioRCLxwrrcDGzPaUPUA1E/cUqCvrSnDiwKMur12IYlrdtu65VJqyvoA/nyA5B/GRBXa5rVfh4dl2CM5wTLHPIoFaO1gZ8my5w3fR2fwC9qQHPOm0NjTroPt+dOWiLmFjU8sNIAhxXSMIev1F8mqpMzUk+sPT0z9EE2HP+JVro4gQt8jucLwtKkI7IEl6RETquiWN0KRJovfgl9gVJlYNy3Wo8fo+sLfKI6hjhOK0UCDB58mjA6vbJJq4K6ZAQslvtZ0s1z2QKbMdZJc1m7l3z9m73/7MWJjnoBSTzH6JkGu1ExUwVTLQsSviadt4Wsqg8S6V1bokfVQMjBt9mLY/3f0jgSxCrBrZSPwMz0DVzxBY+QElNHBfVT7YxWfJbY/+gOj7eqR1GnSPtRlBewqiqCsSIhxD8mDs/xmKg2fTS1+kzfHOu3NVRJwBmrSJ5SGjZBhQ0Th4ZQz3JWVQdNH2Rzk4P+7fxk5Ums4igwQgza4SqvMbkFQojDyVQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(6666004)(6512007)(1076003)(26005)(2616005)(38100700002)(86362001)(8676002)(6486002)(2906002)(83380400001)(41300700001)(4326008)(110136005)(5660300002)(921011)(8936002)(478600001)(7416002)(66946007)(66556008)(66476007)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3tKjbgbA4ASDHyayI1TGp2VuuQ57hSEUJysfF3iiAU13xnWVHAt17Lov6zcQ?=
 =?us-ascii?Q?GDyemrd17yaCbHBkyTpcyhwQUE0RUZIuktOZpVS6L56NmqRYcNlGS4kbLIEI?=
 =?us-ascii?Q?2nAjQ2Tva7fleLeXhiZ+JhOkt9PYJK9gIn5rBo/9ls0Nq6Tdk0XiOZRyxDC0?=
 =?us-ascii?Q?OfyBr6uO3Uj2LAp3ObWzhU3IEIjnwHNjFFs37aCXVhmRSxjAaCrNk9dF2Wf0?=
 =?us-ascii?Q?Z3+Hd3mx1X14J31zaq86Q4v/aXQm+SnN4vIYzIidLQHDcuVfbIvcLTNzuzQr?=
 =?us-ascii?Q?ACchqz29/6Zxof6N9JZZkrgnfBiyCa4EPyuxvJUFLKoihygpJSJURo/LQDiV?=
 =?us-ascii?Q?VI8KiVTYNVxIYL4BQFCHjyLx0acidH6WuqI1kPDi09DDpC7mQe6xNq/OCOjp?=
 =?us-ascii?Q?AsJJe/6r6OYB13FXkIBE5+o27twNPqJmohCqfdYKIT8Dqd1Cl92k/G0YNBsF?=
 =?us-ascii?Q?cb5sX7m1gvwEsfkf5quqILDrrHQu6uEDbRlc1CWGFyXqyJBJG3PPzwoRyr7H?=
 =?us-ascii?Q?OIubRkuB1CWkkSwS5OQz/UHkwYUYfJZxKGa6sxLFV3IPWduUqElSk1rrbG6B?=
 =?us-ascii?Q?pIahcjPGz+A4gf9v9VJDWEuNmofxvSV7PtscYySWbAPcKyGxBezTRWUObX+F?=
 =?us-ascii?Q?BSJS/d3sleN4efuTwo3R1QBWMgnrFK6+0tEP6ZehBKJc7u4DsKmVMfDmd6bo?=
 =?us-ascii?Q?mZrzQqqePju+U5MjHtIxUqLhmZ17nvA649XG9sIA4S5bgPscYP6DsWKaihww?=
 =?us-ascii?Q?/qlz5U8t9H2Scg7DTi/KzUsefY0n9veAtdA7Zpq/ePUiHR8aucJCWUdarWRL?=
 =?us-ascii?Q?X2OqMGa/l8VwwvswMLfnlLd9m3GvDArEYExhGcpGIPt364thGKbyjeOh2nun?=
 =?us-ascii?Q?kK6fZP5BHb7QYbGMd8/fqSqgVtzBEgjvxPSd6ZIM66OI7Nht1HCMpb3F2UBU?=
 =?us-ascii?Q?o+QxSUOobjLfyjkrk/G1CzLJaxgOSvPY09d2slplINoZyPbeuO8N6DFnEDPJ?=
 =?us-ascii?Q?NP/D5WfxDoLzZcHJfDl6Z5RBWy4xa1BmFnntW2CMeFQdy7r8J7hMujAKDs36?=
 =?us-ascii?Q?a4tk7SQ7YMmptS4PzAHEIC0mMPbXqXX871hnhvKQ5rLVeI34q2ozW1YNZUBf?=
 =?us-ascii?Q?bxZr9hXPTdFz08hT5fHby2Y+W2NXfF0r/AXd5DaiUv14b5LEWq77lQ7jHApr?=
 =?us-ascii?Q?J+syheO+kkUnIHbZ/3Y6u8Hqfg6uz13ipNC6BM4oTupbkCZYMBnhg1y4BaeB?=
 =?us-ascii?Q?dlS4AVLh+t00F3kDhUZ6TnxOtD+Twv2QaKeDYakI1p1TDjmAS+rUa28nDuOU?=
 =?us-ascii?Q?CfuMmmb8ZUkIrLm84zi9qVxoMv7QqPYSM7R6NPvibaVvk/1IcCXTbyWbGKog?=
 =?us-ascii?Q?AZYb/iAAWgkGbkU33euc7buBrhvVMlWuE34Td3KilHHIXfYzCY9oRc8yhafV?=
 =?us-ascii?Q?j4qsyumf0clgR/V34QI8qQuvzCTvz+WJaRtiMca3o6qWBEmMO3YOIvivvqjz?=
 =?us-ascii?Q?vUWqbSxbqVkEeI1iGo9XlYM+WnG6recxXaxUTDd2+tAnT8+86lP4EjPKrEnw?=
 =?us-ascii?Q?W7yGuKffzhjxIH7geqPffDLAK9o7sak74aESyZXT51W9JkkQQcKjN9+aCQlT?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a07f8e0-32a1-49f0-75dd-08dc18eeec6b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 13:02:43.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yji2Q0GxPS4V0JgLjdNwFO+e+fl3rHgnY0PLlr524cgRHp7SBF1nXL3sIsWNZwpnVGu5Aaz2gotmpkWv0t1a18fN+EIdy3DithjGqFMhsm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8951

From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>

Add the uSDHC node for the boards that are based on S32G SoCs.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi        | 12 ++++++++++++
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  |  6 +++++-
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts |  6 +++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index bbb5e979ba93..7a4d686d8c6d 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -139,6 +139,18 @@ uart2: serial@402bc000 {
 			status = "disabled";
 		};
 
+		usdhc0: mmc@402f0000 {
+			compatible = "nxp,s32g2-usdhc";
+			reg = <0x402f0000 0x1000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks S32G_SCMI_CLK_USDHC_MODULE>,
+				 <&clks S32G_SCMI_CLK_USDHC_AHB>,
+				 <&clks S32G_SCMI_CLK_USDHC_CORE>;
+			clock-names = "ipg", "ahb", "per";
+			bus-width = <8>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x50800000 0x10000>,
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index 9118d8d2ee01..00070c949e2a 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (c) 2021 SUSE LLC
- * Copyright (c) 2019-2021 NXP
+ * Copyright 2019-2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -32,3 +32,7 @@ memory@80000000 {
 &uart0 {
 	status = "okay";
 };
+
+&usdhc0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index e05ee854cdf5..b3fc12899cae 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (c) 2021 SUSE LLC
- * Copyright (c) 2019-2021 NXP
+ * Copyright 2019-2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -38,3 +38,7 @@ &uart0 {
 &uart1 {
 	status = "okay";
 };
+
+&usdhc0 {
+	status = "okay";
+};
-- 
2.43.0


