Return-Path: <linux-kernel+bounces-125179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0B58921B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E741628877F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC491327F5;
	Fri, 29 Mar 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYVTtOZI"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2099.outbound.protection.outlook.com [40.107.20.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03AD4EB3A;
	Fri, 29 Mar 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730257; cv=fail; b=Gev6mcFZqRHYyJ+oIZLV8n3sUfbyKvJP31boCSj1qtmoy1aFzRajzeVT4tf1LtjGsJvpdyyfWoCmGkfVoTh2SzUCIbaLBiX6tjX4HVW4F8M3v8lAteIY7we/y5fX63ocZlT4siHKLkIKJXLMabJVrMJqvKUEtLoRWtVlzv8kvaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730257; c=relaxed/simple;
	bh=dOeZeAUvloPeeidWgnXfhXQtR05/IECSplwlhT+QJcU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bsVTWszp6C/obqKuuzkOH5IkN8Wp+i6VGE6fl9BrFfmRPZXBuVjHNFY62SqRI+GBeibSDkHpFKZCoN0smnRVS1EOaxaCnvmkyAh/4HmowImvZBvY/ATz7aW8c+woWVYvp9PnAECc/QrQ4n6rSBXRvu4l6NJPhMQUUajnRnD+rws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hYVTtOZI; arc=fail smtp.client-ip=40.107.20.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQC2RXJoIDAYtJ3au4GLWg2d66d4Os7cUEfrg8qgMzQ9X7uEecdmOZU+ibAi4xIFkwO5cyZyiiwN1HPSldIITDWjsIDpzBMq/kPdQWtIBlmR6FgZ7clsWtj9uiz//zxoHDoxY8wgXFzBCQj6LPA8M8fFVieEcoJCiYpdbblxPIlFaGFjmXr0k7AsEE3enZyRZcxjHWqOZ2mvDBw4pVx0WXfontohZO+XVVQwC7FdwsX+DSZaslOP1L/zO7rFh8PF726jxrqpHq3e0XK6eGLtKPlCKrfpReU1Q0iP4MAE0YWvxmM6RCvjk2aB9T/ICy50Ki2bP3SBhMJDAni1vbdv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2rw1oqSTZdacWG/cwOrqdfQzrwf/6JpkaSUhLG70A8=;
 b=edtkUffnwWEzQacq3jochRAaxUTSC4IZ5c+lUUFI+wD648v5Wyn82sxAgKCy21KUuCJ7fIUWB+4rlbreoHSas1RNed7BzZStJoIi5p8ftmut3lskHMjXj87ZJgkMgXU15szfBYDYe974yEMnf/foW6RL30LTMOiUhIadz8o9yTnzRpcpPIlTSNrFDN5n/XPCADJkX3eP4nLrPCr2iRF7A1YXTBC+fik1kUfAFKy60HJO+GCXBezpe7m5ThxdTEAUUPsyUSIjDtHl3zu+kR4TigwGZbYHtAKp/vmXMhcpVY7JrUArRUnvAT9mwcLXQoIB0a8CudwY17X8Q9HYAEtixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2rw1oqSTZdacWG/cwOrqdfQzrwf/6JpkaSUhLG70A8=;
 b=hYVTtOZI8oMoTptbqmH0G5fuwul8bt9z0oL4aFdJpW2voo6jJyNRYHMvHEk//xkEMCRRZ0pD3jfIQVCq2CHNCE6zvHcn/dvG0myQLu9CwgwG1smfJ5adQ1pCOfmazHb2O+bw/wI9Qz8QXB39TcxigG2+aExSeakvduan71GQLlQ=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Fri, 29 Mar
 2024 16:37:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 16:37:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 29 Mar 2024 12:37:05 -0400
Subject: [PATCH v4 1/4] arm64: dts: imx8: add cm40 subsystem dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-m4_lpuart-v4-1-c11d9ca2a317@nxp.com>
References: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
In-Reply-To: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711730244; l=4034;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YYD53f5H6P5t8Y6j6ors7i/mUq8K5MjiTFgBNdhRNZ8=;
 b=Xxg/B0U5ysw80iR4Xb5PvNSG2Y4SWf++XPxIo8hZgIKblQ23YeOEE0/IXZnsva/qPE3vjFl5L
 +Gm00L1o1OGAOuhKbskJ1suWSsgb1VgT+iE/MU/8UFtnWGih3LEhGTA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YFDy5rDOBQsmHK0ZwpadlVc7NXto4BoVoV59Ij2RJZPmoa5no7ybJb/YeJ1F7JfZ5p7gQ5We23kIlVLMNTIFJNGBKggR4P8Zu2of3gndX6j4hZL4m8CL9z+R8fqt58B1ou7YF3otdOv/Xh97idDlUFT+MTYSfBhdvkBvKSc48n8NmSNzfmJoBwflqJMUaETev7VsAhKBAbrIudz72knDYiWtJspXkhkkU9lB/hbY3l5dW2j3REzULWwzIHNgNl2MO17k8mypl9Hn+U87yNQSn7O1sIEb/DwcmOMPRgyV/jeuXosTku/rJynKBHytvZQrG5bUNhtA9JHlr+0UEl/gMWvC8X7K3d5HDP/VChFtp8G0SjB3LiE2tP0xc/6dooK4q+xsmpH/h5yV7WFuTmgKWzIOqSXu++92rBvQ1X0XguEgw4kapvb39UgLgvenz4dcJEj6VOlDwthqcoB6wrBbrFgRyJrNQnj9YLifqZkRdPCes+5noyrG0bTipeXALgNL2/quPiypkY/u8BeB8tlt7K/dUDnV62qSJiOVhiV9XL2A6gT3CnjG7xcxjSMGABH1+4U05wUb08ekr1Se7F5Se7OkJwV496U3xQJIOMdLupaLuGjAHSO9tD3EW2U3raokDUdq06wphuIypWyJsRwkh7abUdjNpb+nADpndov/bkDNY+fgWxeitrhdQqMXy3PAb8YxpanhOvzlCmixQDXdRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emQzZ2NqVS9KZEJwWVNVS1ZJa1EvdWdvT0N1QWkvdUJLdS9RQ3l4WXpwQTR2?=
 =?utf-8?B?YWRrc1lDeW03Z1NIeFh3c1BwTG9XMmQ0V0ozRVV2QlQ0SE1GVVVLUjJhVEVa?=
 =?utf-8?B?WnVDYkF2dlpMQmc2b0dKL1dTMEx5MkFWZy9HdDhxd2pMRGVsZCtJS1VhT2lw?=
 =?utf-8?B?b2RzdnRST2Y4eWsyamFxN3JCbmdmTms3dVFPbklJTXVDRnllSVlpWE9KT3Nw?=
 =?utf-8?B?LzF4MlhkcEJsL21lOVlnOHhva0VRK3NqdDlWemxEWDNnQTBsRGREcndxVjQv?=
 =?utf-8?B?dnRDMDJ5b2VLa2dyNlVja1pVVXhJSlJRUDVrODJKdG13ZUo0M2RRYkZXdlM1?=
 =?utf-8?B?NFFtTEk3VDVtRUU2NzRKT3pwRFBodXdnTlJBV3NWKzNYZmJKaHZRYnRrck1t?=
 =?utf-8?B?bWYzYWZWVDdqQkZRNUliT3M2eG5YV0lMK0xscEZOYzM2ZEkyZ2prTGJOSjlL?=
 =?utf-8?B?UnpIcTZuOWNncnNJMmc1cVVZSnFzUWpYUU4xUVdJaTF5NnJPd0t3Tm5SYmZQ?=
 =?utf-8?B?WkZ3aU9xbmxrclhnQ2lGOXZ3QWlVMGlMTzR0eHRCSWdxYlRMWlNNM2d1RDdk?=
 =?utf-8?B?eG8xckxRaGp1b3UxczQvOVJuOVhDUHpWOEkwNHF0QXJJSXBPUUJOTWRCVnJm?=
 =?utf-8?B?NFVMWnFZMisvVVk2Q2R1SHZ0UEo5QzAxdHlGbGU0MmJsZ1NhcUFRUWY0U0tn?=
 =?utf-8?B?djlRUEJUbE1hczFXUHJybWYwTWRsOFBRMmo4SjBFbTJBZHRJRFYyS1JkT0pD?=
 =?utf-8?B?aGc2blQwQ2NIQ1JSRTMyb3BmUndqaEJEZ0NOcGNuc1hXZ2VxblRPNnlYdWtD?=
 =?utf-8?B?VUFXMWcyZUZVRkRIWUI1eGI5S1NyV01xZjVGOEpqTENPRkpSdTFGcGQwOUEr?=
 =?utf-8?B?QW9ETjJJZ0wvUndvVTJlN0lOT2RWMWRka29ncDFWanphakZhaC9oYUl1VTBN?=
 =?utf-8?B?Z21GLytOKzBLbTNsMmwrTWwvVWJzZ09tUmpPK0E2WEpBQTRFTHZtL1NTNTRB?=
 =?utf-8?B?TDRFQ3NzWDRENm1aTGVoNHVKSjJ1bGZkMzlNYXNLWWY3QWFlTjkvTy9pTDlD?=
 =?utf-8?B?bXlrSEZ6L3FMbWJpQlhrNjMvVkZwdWRRQytkcGFvYit1Rk1FU05nRmtCZndY?=
 =?utf-8?B?bmdaMWNveXdzWWFrU2hBMTZUbEY3TmZlREJmMGJOblZScXhxdWVaaXpnN0hk?=
 =?utf-8?B?RUxjd2ZiczRjanFTS2lGQUJyd2VSeUhhaWJZV2JIemNBZ3QrMXo1eng3cStr?=
 =?utf-8?B?STFSd2Ivdm9TM1ptbUtjcUhaQlNpRGdLZzBReWJxakVnaFhvQWpSK1UyWFJG?=
 =?utf-8?B?c00zWXJqTGFtTFFMSlQzcU1oeGQ3dlAvN2RhY2ZrckNmUW8xelZtN3FZc29z?=
 =?utf-8?B?UlBzR010aEFSdDFSa2pzcUhoOGxjSnM3ZkllY1dpekNTYzl3Q3dRbkk5d2c1?=
 =?utf-8?B?UTNGTkQvZ1VsWEtPbmRUaW9JRVBkbDNhNVYrUUJLNVd0RHM4dmQyVDAxN0E0?=
 =?utf-8?B?WnNZTy9LMGpHRml6d01JR3VqY1NnNjcyamdKWkh2NE5nOEVGZ3NkekxES0hH?=
 =?utf-8?B?SlMxNEErRG80NHlqakJIaTl2S1JqTXIvTGZ0RlZ4TVRyWVlhUGdvdENoK0NP?=
 =?utf-8?B?YzRyNjE5Z0crY1RHMWs2YjM3Ri8zdFFyeFBVOUswcERHN3Y5TS92SDIybFRH?=
 =?utf-8?B?RGtKWTZhR0NlR2Vzc25KQlliQ3NmdGxoNTNTOEdkVE9CMEZQQldqcDVaRCsv?=
 =?utf-8?B?QkpJMDRIUy9zOUcwcEdFenRpY3Zqd1hFTDNOMjk2bDYzeTVhMndMRjFRU2d2?=
 =?utf-8?B?RHFhZm0zS1g5WW5OMEMwbnI5Z2ZjWk9oem9PSFl3UVBhanBPY0p3UkMyZFRD?=
 =?utf-8?B?T2lGN1BHVDFVSjl4cTlyRkhUZmpOVkV5MHpMRkR3STlIOVlkckdTbEVUYVpR?=
 =?utf-8?B?L3R3RnZRMEtDZGhpYmh6dEVtQjN2MmZpOVdpU2VPdTdGeEprMjhTYkFweWxX?=
 =?utf-8?B?WDg3Q1hIKytoejF6Ukp3Y2h5c2N2QVFiWUpDY2xvSWJpcUJiV3k4OXh6eXJW?=
 =?utf-8?B?YmVKNktpQnlCaEY3NGtVRm4rc1Y1dWluSWM1cm4yOW9vK1haK3dWaU16Vjl4?=
 =?utf-8?Q?sHtRXgrl1eviWrTZuDqlBpnJy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0727362a-c8c0-4d15-b0d4-08dc500e876a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 16:37:31.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNtflomEEvCkGSWzUIO+oYtl+3hZ9g2B6eoB8UySmhUCof+4tITOMbNzEONmdEY0Xo6QgUm/JvKEHrVDIskIMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

From: Dong Aisheng <aisheng.dong@nxp.com>

Add cm40 subsystem dtsi.

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
index 0000000000000..10a05db06ade9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 NXP
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


