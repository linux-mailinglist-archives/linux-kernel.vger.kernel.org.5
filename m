Return-Path: <linux-kernel+bounces-33140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630683651A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C938928B0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E333DB87;
	Mon, 22 Jan 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J/lEUqOA"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA973D976;
	Mon, 22 Jan 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932388; cv=fail; b=eLG1+IS9aYKBYITuNRxZDwV0SJfoicCTYkjlqTB8y0kS7Hpuwb3obgghOw20XLav1vvjunk5Gl888MIhs2QZzFbZyKXUjkH9SCAcb3/bglr8lNrHqi4n7wky929lY/4OnGbJ7Aht23DxfyuuQ+ZZcCcaLV4gtowumqVf27Rm9H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932388; c=relaxed/simple;
	bh=YWQxw3IFWmQ7EpqPO/Gwf7EaQ3BVsVWBxcNBP0uhodY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7tNBhRO1WfkvK29g0NUHVlN8aODpsLGZMPLUT4jQM3VX7h5ra9/SOwnc2WIhN8lmbO01rUVGEM2bkKlWc46O0Qc9DXUrcs1p4Q/5YfGdNe9+PGmdQrdO1a83UxmCDBMr6C9O/BV3zkzkXKWlVhRTiTKYsTR0nE8W+k01lOgdxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J/lEUqOA; arc=fail smtp.client-ip=40.107.15.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxYbXgPeRBdoym3xI0GhYoAx0Jl3X4f1RDjljWW/OuO+6haNHGVdgHQxUoQpNoPxpOvJVIGDXKM1O959BDbQI/zG76PklOmhxkEnzktkqBTiTh9TE12e785cW8DuWJdQDG2KDqCk+8jUjpLXRr9KnmlMr0ETtVg/avauDq6gQm3yHuWObIDZ6dQ+qVUR6++3W8UuwuQ4Yzr1Zu6cPkXzqr5NR98NUSKWUDVd2ofLGVRydsDwXoZyboWU65usRhatX07nEc3H0B5Pu104XbM8Wm/ih78J0czOer9bIBtnuGXDdVw+xrSkmTj0VXi0hvBORCys4BJJGdWyneV1jVgQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orMrRCqw24CVOqdyIU7ec0WaG1tebdD5twBNvy5ojTE=;
 b=ZZzyMV2Xg9rHoS+LI6uUmdrMr/jLcIPp5JPeT67Qt+FlHlc7zEV4NQki4HQulpxzJB1n6MJjypctCKbszekWkbd8RWw+isBXFXL5ITtgKX3VYE0fu5V8J9fI0faWI86fQ4U4WYESh01f5AJ/0m0wLSILC6wgzQYcaSI756mCdupQZL/ayLS/AKQ0eODKeUcX7nz1EYtD3km0HGSzB4nErsg3AXCI3G5ygZx9HzHVC0zFGMMWzeB3zu5RW/yMtajMlVXgEgxl/1co9dIAcZEhh8yB0yzx9k+oZ8ChFP32ywKQ3815nrp87yy2xYYaLH7rA26s9aVzUVhZ3FuoI/n5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orMrRCqw24CVOqdyIU7ec0WaG1tebdD5twBNvy5ojTE=;
 b=J/lEUqOAmmKw+uxKkJ6VsYp7x5TIYLeV7DMzJjIwtIr504CxKxLbVP+sXay92EugG0g8rnAp704sKC3ueREM21LM6TwUq7AQe3w0Edt6tgKh8FWKuVEGX73WJ60DoJt+qpnGUsZHU8tdCHOEGN+GBHMiiLgbPuMIB2KiptElJBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 14:06:23 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 14:06:23 +0000
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
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
Subject: [PATCH v2 2/2] arm64: dts: s32g: add uSDHC node
Date: Mon, 22 Jan 2024 16:06:01 +0200
Message-ID: <20240122140602.1006813-3-ghennadi.procopciuc@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0294.eurprd07.prod.outlook.com
 (2603:10a6:800:130::22) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AM9PR04MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: ae839d35-9886-40d8-d3b9-08dc1b5350ba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kIBcC/P8zyOhip9kkT2Bw1B5xu9i+gbT9owM5V3LK5ZMvr53P3PK/ZJAl0msWh/QEgv+p+qj4ra7h1sjMqx2L8RTN23w/jE1ph4Vp04NiYEdY2Gj5DF+gto22fn2vZO8XNulfwvyiAGk5Q7H9js+qDMp/uOOAPdgOskW8PXMz8NxYOh8qTJ6u8VIblfL1i11xtWs4L450M7JiggFniZ6rKR5NStw1WJkb0pzCbdCc6Ty8JLjEHHh3b6Ad+0fN9i4Tm+JGfU/0u5diN6Dm28/m3ZXPbd0KUKiG3VJIDBYECqilQWiCJAddJobcnDFIo2rgFbvd7aDBLuETUQEefxu3+Oe55tVasNLJNy5BL8km5bKLOZZEH2wqInwKgavCBGtyoRmt1fC87Vmm5YEvOCMcJgupxIulUbtEI+XOud+YKU21MO6E04kwX2vXPdumhJ/nGESwGLehBe6+3R/clXs5ztoySKgIicHpj/K2IyXHxW5CX8zvLxdIrpueqKvZpDHsnXy4BYGjkF41+oneIl01UZfRr09jjL8F5HHq8IwuXvoBqDW66KFuEDCtJoh0aR46fiHs1CPEWBd1zAJGMg6MumszaFe3pDY5eOPD2ONJW0QIHsC9gY2/jDdYuaroXXtQjMqyok7TNyjKW1AOB4Rnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38350700005)(921011)(2906002)(66476007)(54906003)(66946007)(66556008)(26005)(6486002)(6666004)(6506007)(110136005)(478600001)(52116002)(316002)(4326008)(8936002)(8676002)(6512007)(7416002)(5660300002)(1076003)(44832011)(2616005)(83380400001)(38100700002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZirDk7x3ooOXfWLTKXlIGe2D4/vOD8DgKhoIwo864w9YUYuQLSWCD9WyFcVj?=
 =?us-ascii?Q?tP/ydsLedYpuC3dVZt20JrShKj9fswl47J4lgHk15OiYUXVXl9/ysCzdL7Ri?=
 =?us-ascii?Q?hUenWwswL7ugMlszVVBqoPG/BmuV9tfkdux8hYUhkWxdN8MwxEXRTaqjx2Qn?=
 =?us-ascii?Q?wrwS4X/z3ZMHc694CyNpQuoOamWGZrdROG7m5f8zF1l/zz+1t5iVoMauOwf0?=
 =?us-ascii?Q?Fy8CMS/nz7N4UL8IvE5F29z214iLIbZFGpk1WF0H3gJ6dfWPbomcOm7tTSwU?=
 =?us-ascii?Q?7n5zHd1gdCtR/To/Zku6grV5Wtef43CPhPd1qnGACKCh+KS+uZw98x9IOBpm?=
 =?us-ascii?Q?sexa9+xECTuzbroFax3RV5t8aDpjbOAK0jI95OGEakAZmavHq0Fgw/9utLQ6?=
 =?us-ascii?Q?nHkbyLYXKw65Y7nmB1wOEgVUTrUfX1CUPNR8HyuZtEdwPTRgOQSFY7eMoaeM?=
 =?us-ascii?Q?eJF48nn6Lm754t/f+BM6dTXB+TMl+3zJh5RXZ/dCq5e7GLrMaEb6GdMRZwM7?=
 =?us-ascii?Q?tcIXT57zvNfL7r9NwsNt7XN8si1o5PqP3YWrKusg3+eThsZA74qt1V0JVkLP?=
 =?us-ascii?Q?Ti6pJraimXfKoh9RPo9JaqWOC4rioKjcgm8nH9aZB6gCuG8C2zOe+qsSbAV/?=
 =?us-ascii?Q?A/eY3eU84OjLAQ/blR+CcTAU5uLjNPDOLyNnN+Oc3fv6ixXaszhK+BG9++mK?=
 =?us-ascii?Q?IEaHASL/ODpa/Zv1H8vNUnTqYwO/6dGY1zuhTBSdnRhSQyULM9LxGlceFb/s?=
 =?us-ascii?Q?t44Khixj/x8/gj8bg0gADcX6foE43hpzwhV8ZCMfNBkv7lrrzzLycSWpgdj3?=
 =?us-ascii?Q?CzyvyzPoo9QfyfEIGet3UuLLv/s/qGuFCjC14HAIHrhCB2QxHi0bkD16q8zj?=
 =?us-ascii?Q?YmnAugI9E1dGq5cAPK2yiL/0tmBBWBE60Ot6UNDQSYf63NGOMHDDeMjFLAu3?=
 =?us-ascii?Q?m/thTj2dffk6YJXZuSWkBKNOcKJR+1bQtFkYTpRYkk3U/wU2UpEXgIv1FmHp?=
 =?us-ascii?Q?rqj5HxDOJoBJfZ6A8kU9WB44xyiUT629EZOkzoloDuU9XYEQTuFIOC2ZRa8E?=
 =?us-ascii?Q?wSmVmJ48SGzPkzPRThmsn2iGHns5oeEpt+ND+4e9mrpMDFZY6Y9KqpdgPCPE?=
 =?us-ascii?Q?7QqFZrexJ8kZcpGaHv/Etjjww6Dm2GDO6uSLh4d/isXnOJmL+pt9ewyZbFtw?=
 =?us-ascii?Q?3Lf0wAheCY856rcMrvH3zR7KWpJviEBxfGZfsExRQGcuugmEvm+0+7oFlC/z?=
 =?us-ascii?Q?bxyheGrZJI5L0fm0ucLji181ksz+P2gFFgsU04FU7FLkrfzM0uaY/q/E8oRu?=
 =?us-ascii?Q?qdvR+pY9DS6kSQ5L+CU30o6l04eHDPJnjLlTf61xEcRU0jz0osZq5c/oH2/X?=
 =?us-ascii?Q?5EnyR2Fr8cAQeuMWnOk5qFaypph5RHhieX3fO4k8c05cGfpf8FV7mTHwg1ca?=
 =?us-ascii?Q?6P5z5aqYLNE8b5o6Llc7T5r8DbSp+9p2wg7Hw6jXWIU5Tc8uMn7YuwtabkEy?=
 =?us-ascii?Q?MaEgYYtMmVq4xsm68punb+J0ZD8rLv9FZiqqzHVaS31EbyyXrHxJOjCR9ck6?=
 =?us-ascii?Q?A8Ns2KonnrfbHYt65yvorurDZp1PGL5tiiIS4fcqUr/AnCkMno4jy7XzKsRd?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae839d35-9886-40d8-d3b9-08dc1b5350ba
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:06:23.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dRHT0xtQJaDLYY3XBIuaaFbkxGiUOREo+RCFtOL/ePmWJQwxkNwFxCZcRtkHha4rwEno4G5A6VTBv8tKKDslp99lc0vk07PgLX0/9H4Uuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>

Add the uSDHC node for the boards that are based on S32G SoCs.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi        | 10 ++++++++++
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  |  6 +++++-
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts |  6 +++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index ef1a1d61f2ba..fc19ae2e8d3b 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -138,6 +138,16 @@ uart2: serial@402bc000 {
 			status = "disabled";
 		};
 
+		usdhc0: mmc@402f0000 {
+			compatible = "nxp,s32g2-usdhc";
+			reg = <0x402f0000 0x1000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 32>, <&clks 31>, <&clks 33>;
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


