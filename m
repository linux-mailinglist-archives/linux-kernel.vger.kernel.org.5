Return-Path: <linux-kernel+bounces-128187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4EF895751
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31B51F23200
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE827135A78;
	Tue,  2 Apr 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jqPDefZt"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2123.outbound.protection.outlook.com [40.107.8.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28C13541B;
	Tue,  2 Apr 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068911; cv=fail; b=eojyswEhf47gY78LvC8kXqcZ9HU1qT9jAVROrLe5jKSX1D66EL8lKYpJf9GFTH8bGGqu+bGWq2dFZk0R3nnQyAzKINAGhZpzIZ9qKNm5D/VjCLt1Fa+0KkvumeLlRndcrdENNlELLwD+DI9qCRNvPGDFKqaBsp+4Dj10sa3fOto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068911; c=relaxed/simple;
	bh=7Ax2paGZDKb9k9X9DQKurdk6VYfiFv9mmr29T7MmUig=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nt53eHsUPPB/2CbIciR6UD4B8qaO6EEFUGoxzBlQmJyjGgGt9C6yyaGO63hYxUjiUau9tIj3NBdEeOEcTVYO02b5uTB8uUmtuvheVsqVgl7mF944L63/MfQrX/bWIcTBCN7/2rPzdMRBaIRY5uTdXP//YaP4vxV7eMfdtGUu6x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jqPDefZt; arc=fail smtp.client-ip=40.107.8.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNvLRYFXNe/hNV8sQSgHt4hRAfNLeBFHaGtK8mGRfeFvs3oPAG9vZJuVU0CXhqhJTWFExumOSC5faLRYxAPyyAJIWxpm8MD/8B8XWI4QaBzbklHdQctnIXdKbOHYwH+t+MIJEkAr2de9IoGsbUhymvs919YztHCeiE8AQ5zvJGBurtOAyOyKqsptnQW186dDHsCZAIp79blVh2OGZTIzg9ParHV46kUZ/wXwzyGiQlD03wcejZVgmyAtyrGr35SWAXSeSS0sW/XhqXerky3470M772VxIVjamhWQ4+JD7R9gvTH9ovXKNlMq5s7WGgLgyzdARIWwSjI6La0bm+bWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhayjAFxBDq+dPtGfajzUku56gHGGHq31/suJh8Q9jU=;
 b=Zzor+ZY0oEjbD7bg+cxqPInnlZrMH2KejOVccnlnVCtBYng+9m7IwldLFTBr84NZzaEy/eZPXPcGGV4z2JmTpqE2q9+cJCpKsURPYk9gU9sGsf60UyiQqW01Wixa2Z8ige9YpE/J40OcZuFk4TUL/JvQRP8/qTGA0Tpy7KOXhSlO8gLNcoFtnSKfrDqGvvJ/usUfricNuLavk3UZ+CcdsU9avXCPuqlj9G+v/oVt4Nzoa97qc998MeouCzopSbxQLXOje1p3dAls3AhZKhLE1SfQnx6xj5shmhBKqy5kScuYlny6SBCKQIhq/h28SVJhix0Jbq2RZ1iqfqlE6E3BXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhayjAFxBDq+dPtGfajzUku56gHGGHq31/suJh8Q9jU=;
 b=jqPDefZtaXA0qEjkA97ZvvTvfZWRFBI7jy/xQeY+zvYDhwSOW6ml/P8F6KM05UGGRzXZPYYTYTMoLIi7G1dmNH7GcMtfDoaDyVMUpG0i61Vwl8kEzYP1dSS/UG39FriPBoYhGoYQtbN1NSz9dH5glq0U54EBOrNOO/MShl7OinY=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:41:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:41:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:41:28 -0400
Subject: [PATCH v5 1/4] arm64: dts: imx8: add cm40 subsystem dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-m4_lpuart-v5-1-3292629ba808@nxp.com>
References: <20240402-m4_lpuart-v5-0-3292629ba808@nxp.com>
In-Reply-To: <20240402-m4_lpuart-v5-0-3292629ba808@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068900; l=4076;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+9VTBGTmOpwwZkox2OmYhWQ6AhVjrY5RC4j5tSdMihw=;
 b=dmK981s6AyF5r/hiOSYLo5b6KHA0n2CVfFcO3nGS+hWQTT0Y6yV86D59B/jHoOmV88r5JD12x
 D0ycGKHL9deDLZAkkXH6+3IClQt+gj9xx3LhTV96AjIqmi/DPcnk6i8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:510:324::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g6zionz04VjtV+ruwlzzq96qjnNgF9DhRQeM5JU6h9O9BgXrsfmQvMUE3t/roHFZn/YTWTPaJFtM8XOFEwdk47Niji47HbgwZqDORm+WiUKD7irgUKj2ejRH7wN6i1k9Q0PAjZWDHlDACSVeHFPbHZPav9lKIc4rx0li+q69wGkJaGia8x/tZP9LuC8sGU9zHRvUjWG9bxc2o9etxedLC2VGJTDIjc/6ZCLm9R/p0WAXyio5HBvCux95frYnRIM3w3jWE06da35WvP4zFhuLtMkUVvYqfUPoBITlpq/RHLpJXQlGEiFfF505MKl6gPUpOR1NZUxzoUjqdPGJh5+izYwlYMtFs+KRkekor8dmvNXZRim/jQfMpsJLb93zDw2hhv8WJs7nYbubqnHxDJU/huk236X4D5rKSFgTmbzqXaGLuhebiIy0giBwjBaqQT/44PEPZ1taxydQSqNF+BXiTn6o8/B04WZkuw5UAlGzYrK0tvHqHaJDfzR2YOVc8VAugAtAckA6ZporuVzc9PJ1H2kr+rKpnMJcjByUWOUCPPLpIMjylzT50SO+dRGUg7U6u82wGFr60z1BPij5xlv7tsbLnJn4Pd/xNtsy7RHsxsikMszyNAj0yp7vrj4PKJ4Fj3MtJi6mboCBDSS19XpsnglCx5xykR7IwQC2ItxC6xsAFY/xKTn0wjrQuDuM2GFdZNA1X79zA+27CI3dGU202uw31m+Yd8tnDMbVSPlhFcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wml2VkFSQktSSUVVb0hjUW9xSkRQbVdteXRqOEFnVm5jdFFFWlY3WnRkdkFZ?=
 =?utf-8?B?WFJDK1N6L3JFYUVZZVlxS21vMkFyS2JRU3RIOEN1VnRLUm1rRy95MnArWGxi?=
 =?utf-8?B?K0hkL01jNWJDQVVKa21tLzF3M2N2OU4vU2xhQXJhRkJhQUl0U2dJdjVCK3o5?=
 =?utf-8?B?TEZ0RzI2bWZDakFQdDU5cE1ySDRRbk9paVIvaW1mTVVWWTRhR05CU2EwcmdL?=
 =?utf-8?B?SE1pckIwZEowZDIxNnJ6WHF3VnBEZkFrS1Rwb2laZEJ2RkhpMW5xNGFpNVd2?=
 =?utf-8?B?US9HWmJVVlpIaXVMVVRSc29kUExNMmdVQytJM1J4Umo3Y2YvU1d1SUF6ZUJr?=
 =?utf-8?B?RU9XTStZR2xQSUYxaW1pdksxbGdIS0RSVmxvKythSjh0UDFScWZGZ1l3TlNE?=
 =?utf-8?B?bFR1MGNYTTh0WFdKUitPUTVJMzZqUVAwazZUZG5MYklIMGhmSjJ0TjZuWXAr?=
 =?utf-8?B?R0RsTEdOZjJHVWFpTDN6QmtxeVAvNkxacTNqU1pESGg4NVE0SUJFSERnSHp0?=
 =?utf-8?B?aGRST1JuayszSTlYazNhU3lSTk13a2V3bzNuQVVXNlZWQjhGd1RPNUtzL1NI?=
 =?utf-8?B?MW5XSEplMnd1eHpXNTR4LzEvdXUvK1V4NlJsaThFYmhJOUJQc3d6NHZWTVMz?=
 =?utf-8?B?dGlNUGFqZXVYdVFQS0hsdVRBZkMvOVBKU1dWZE5nTlozcXBtSzhuYjJsK3FY?=
 =?utf-8?B?TnhPRUJlcFBxWVVRUDlXY3lLRm9DMDdvZ3I4UGM1RTBsREVjZGZCR0w5T0JF?=
 =?utf-8?B?Wk1pUmxNSXBUa05ndUd4ZmhoWVloNDB4dUdrZEkzR0NMeFFPcGx5bEZPK3kw?=
 =?utf-8?B?MWN3Q29ha3k5Lzg3VEVXNHZBNmo5cGI5OTBNYUZCazFBdFAxdnhFTWlTeFov?=
 =?utf-8?B?UGo4aHlDZEMzQ0VnR3ora2s3cGVlRzZ5UFNvK2oxQytGWVZlZHRrRnhNTkta?=
 =?utf-8?B?MGtGMnBsVmtZTGdUTVVmeTJjNWFxTzBhT0J3L2xFYmdTMXpWMUppZmxVdnE1?=
 =?utf-8?B?aWhCZS85VytiMW1jY0NFZXV2eHhPM3pSK0d6b09BUkV1VVRwSTkwNkFPUjR1?=
 =?utf-8?B?Y3dUVjg5bjNZcFBUK3J5RGU4bTNMTVVydXRLdXU2eksyUFdtNXJhRnF1QTFv?=
 =?utf-8?B?bUtBaTNBQ0hIb1JLZ3c5QW9rYWg3UHFkaWxVdHZ5TmEzN0RUUDlVdmpGclNF?=
 =?utf-8?B?Vk9sNDFWTlNrcEloZTN2am8vNFMrNkxoanY5UjNKWVNPY2M4cE54aGFrUlhl?=
 =?utf-8?B?eEJVdkRaemVtMDlFMTVJT3J1TUF5RVU4RDAySCs1UFRCTWNlK3FkUk04NUpN?=
 =?utf-8?B?WUVLeG9sQzlDdkEvRENIT3FZNGpGVzBiUTN2ZFRQcjZYenNYcWd6NmhOWDl6?=
 =?utf-8?B?aS82M3JGY05kY1hwSmEyM0VKYnFyb2NrODdqbWdxUkxCc3o1SEdsR0FpSHNk?=
 =?utf-8?B?Mm9acE44dmJPdE8wVEloVzFWM21HY3pqdzdhTzFiV2hBdG5sM0hhaTdBa3FH?=
 =?utf-8?B?YjAyeDNSZklWb2FwajJBNitYL2w1VlROMkNHWHZRYjNNT2NNN3ZuWGFsdkQw?=
 =?utf-8?B?aHJ1T0pGWVFTZUIzM0lDUDBKQXhndWxwNVhVM0tUbXpId3ZrS3BEc29yenlD?=
 =?utf-8?B?L3Zaa1FSLzhoc0RDRWtFTGdsVTZRZEpPTFQrZUUvcFFacnNlSTlKS2c3TnNO?=
 =?utf-8?B?RzNaS292VVF4UGs3d0V2SG1YSDBPeE1NVUpJOTNUcDJCeEltdmZrbkRwMisy?=
 =?utf-8?B?K05NZ1VPL2pIR0tIWENkSzBlL2V4cUtRR0pkbUxYRUFuYWphUldaeWhMa1c0?=
 =?utf-8?B?OGpyUzFqemJCdjJEZEhIMXJvSEI1c2hEM1lBaVRZZmZFQmx4ei9hUGdlcUNq?=
 =?utf-8?B?SklNZGE4RmN3NDZFZEdpOFk1ZENMMldkYlRvN2tIbUJtYnFKemdoYmxJVUh6?=
 =?utf-8?B?Qi9TUW9YeWlMa1RBWHN3Y0RpYWVuWk9NVEh3RU1QTWIzdmd3MmF6ci82SVVZ?=
 =?utf-8?B?cTBsL2FwVEFBQVJKNkF4M2pwdGZlNk9mUUJ1cmRoRDlnMHhQUkVMaGg3QklW?=
 =?utf-8?B?bnpCOHFCa2ZkM0MraWwvb1NzRUd5OHRvM2NMbFBEcjh0anZsZFFwTTRISTkx?=
 =?utf-8?Q?N9kXYXAJH05K1ZGIrFf9meU7T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96931390-cc83-4417-e10d-08dc53230633
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:41:47.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jTNSGW4JcYxqbiAusRHqSSzItAXLkNsWTRZzSOoq2Mw1qyNKXgnbmeiZYeZxdD9G57f4LLMyUESfvjsvXiuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

From: Dong Aisheng <aisheng.dong@nxp.com>

Add cm40 subsystem dtsi.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 67 +++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi      |  2 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |  1 +
 3 files changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
new file mode 100644
index 0000000000000..84d7ae01e5f40
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+cm40_ipg_clk: clock-cm40-ipg {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <132000000>;
+	clock-output-names = "cm40_ipg_clk";
+};
+
+cm40_subsys: bus@34000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x34000000 0x0 0x34000000 0x4000000>;
+	interrupt-parent = <&cm40_intmux>;
+
+	cm40_i2c: i2c@37230000 {
+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x37230000 0x1000>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cm40_i2c_lpcg IMX_LPCG_CLK_0>,
+			 <&cm40_i2c_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_M4_0_I2C IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_M4_0_I2C>;
+		status = "disabled";
+	};
+
+	cm40_intmux: intmux@37400000 {
+		compatible = "fsl,imx-intmux";
+		reg = <0x37400000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&cm40_ipg_clk>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_M4_0_INTMUX>;
+		status = "disabled";
+	};
+
+	cm40_i2c_lpcg: clock-controller@37630000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x37630000 0x1000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_M4_0_I2C IMX_SC_PM_CLK_PER>,
+			 <&cm40_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "cm40_lpcg_i2c_clk",
+				     "cm40_lpcg_i2c_ipg_clk";
+		power-domains = <&pd IMX_SC_R_M4_0_I2C>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index a0674c5c55766..9d49c75a26222 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/dma/fsl-edma.h>
+#include <dt-bindings/clock/imx8-lpcg.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -231,6 +232,7 @@ xtal24m: clock-xtal24m {
 	};
 
 	/* sorted in register address */
+	#include "imx8-ss-cm40.dtsi"
 	#include "imx8-ss-adma.dtsi"
 	#include "imx8-ss-conn.dtsi"
 	#include "imx8-ss-ddr.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 10e16d84c0c3b..0313f295de2e9 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -317,6 +317,7 @@ map0 {
 	/* sorted in register address */
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-vpu.dtsi"
+	#include "imx8-ss-cm40.dtsi"
 	#include "imx8-ss-gpu0.dtsi"
 	#include "imx8-ss-adma.dtsi"
 	#include "imx8-ss-conn.dtsi"

-- 
2.34.1


