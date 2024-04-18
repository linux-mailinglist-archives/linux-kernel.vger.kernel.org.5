Return-Path: <linux-kernel+bounces-150504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA478AA03C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEB81C21F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC00174ECD;
	Thu, 18 Apr 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l5NCTrZx"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938C17279F;
	Thu, 18 Apr 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458229; cv=fail; b=CXWVCdKQSx1vzaBL9OBekE8OTblraXW9o2l9DjBSzc4Le/s7RiHCwG+jwssRP+UgSOVsQp46e2NjkSDNcjJtogPhYEfJU3d/SE5NMoipimCf17Z5egTUH+otAqd4sYh6xLisRRN3opjIAKOhGpKwWitjb45UPBrm7OpmuiroUcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458229; c=relaxed/simple;
	bh=tBWF0Asy9OzGdJVvC/vxC7/ms1YGwCbPE2oc8x07IEI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uU4cZvpNvUA7j/F7FBfBAkpkY5R8zmkqgW2ZnHF9+P4TtLUasKIVqhjf7b2CU4WnfnAEhnjG0gPHdcl4uJH6EtQbnr4ISkgnXBSxLTkqFIh034yz6zi0uinXtBDoi5Z+KBJR8u24CLUm4aoTF9srsV6IzokIr6Iz6hEIaoXp710=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l5NCTrZx; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H22ZUl59XuH3ZBpctgkvs4hwue6aYsPJTIr089gOypyGM31EML4WE1IJA55jkuFiC9G0hsi2Z6xuSmJBzzjeAiNq5ixD5BbGzUQkNJ8/irl9N34ZwQwCv4SHozOS3TY3fBqyiAi3EdcRiVsrLt8rnoBCHgWB3qZ57RCXImftf52cV6onT4SddiQqbbqskwPEuW18XLNnvMVokSNTNmDu1FWaYafkJranNalpldkE52sR0httDyW8XCjfq3UoC2OZXiCqvG8XwT4qEV6vt7jtXhfygNGD6tf90Ll9Kpun/nlg6zeeL/FxT26mTENT+aaaJXAu2yjoduIzMPLqXCJWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pfVE0FL5EjoFxtfQHO9cTRC/GSrOq8OvMAS142KhT8=;
 b=Jv0QzXiII1MhyWQSVK2jJvnaYUMgGxiNUgof09IWjkrGL5w9k53+6q6u5Uw0wdw6bqvT6LaiirHv7ZCUsp27QnnF2B70aNP91Mix39RA46v3+mFerByXyEvG5TqyAQGhKleepARTF5oPjKiOofnhbNQu20VFOcGtTc8mBwmSS0cEDt+LfXdYHVi47MF7zLq3hw/cPrFMeip/05evt+ToqSnrqlL29Nt+2b0GbN5/Ab9akmVhTh6lzYTNEATeWufwgBxLYwLbuYnH3IJu+1IOalkEbJF9NEDUeSzVAs2cZLYJHdLPSPyXHnSRqxpbv5Nh0f+zp4hm4Rz4VC0h8PAIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pfVE0FL5EjoFxtfQHO9cTRC/GSrOq8OvMAS142KhT8=;
 b=l5NCTrZxu5paN3oMssUAzus7/FWrAeHaY8tIhIGAeNKd/xTLM12JdEQzrLo6jVO7DE3znHhPOT6pptjMZ6/3ueoSAixANbadVdL5NjQ7Wb5Z9HvbXMjGUgFnARnUEP8K774vbldo2ZgBLGMnrqZ5ZAJq0Lhu0w+OZxdJwigdCNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:37:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:37:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:39 -0400
Subject: [PATCH v2 04/10] arm64: dts: imx8x: add cm41 subsystem dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-4-e40fe76b60a6@nxp.com>
References: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
In-Reply-To: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=3146;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tBWF0Asy9OzGdJVvC/vxC7/ms1YGwCbPE2oc8x07IEI=;
 b=sv5z0pkXG5/erE6XXJmzdqGCQSlFOFbFtTneC/tMplo5v8k7daK0bn1jJvRwk7Ja9Eq2zpAsP
 MfWratKHoRLDc7UnE7rxDb88PdnQDcy1pMfZGZ7UCw+05gIYlmUhr8K
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5fc490-1702-4f86-0002-08dc5fc5c8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5ZL0l5idfJQTOXb7WkpgxvFpiAZF3uyUNtkmfqhkub9rN2POU0S0wzQmbKX6C1jZTqZHqXMfOLysnVTT3VNjz2yIt13eAFXVBTd7CT3Ldbol8B+74g6OQ1ml4+uW5pooj2vDeuRfMtTg/TSFbc+Itt8ZvufXDvpFiDhy8QX8c72gBhGKFYJdaLX2J4lh7VIZeOwVKCB2G/1oAZejMi2VJ9EED3xDY8rux4yrWEraUFROdzifQ0+6ZKNRZkpQsaq3Rb9RTr4NMf9g197iWx7UT1kd1L7ALUszw3yUQ7GJuW0ODlLz27ssZLIZGRlixa/AudfSCryAiJN39KRzSpFEJjmDOxHhqk13hqYKqRmKr5Mmx64sLk6/TxPolAecv+pg/LP7KuRZ2quj6X7bCHkQYx8ty/BhGblhrYmOKwhj8PUYacAFbPc/VxuxTZWvavRVy4F2T2OG4CSROtWssnQiSKpzHzyP+7iD+mwApSG7Eb1g2X2Z5t+CQc0Nuc9ZiguCAjEwiJsMk4GIJYS9sMVgmarXIHpjbkRlFxwn1EaqMoK29mZx2FV15VcERH8xV/JSRCuQDstocUHqF0Gc9LJu2H0dv/pJDW0JJWM3RwLhb6vUSTqgzsMGyccrv+kMyD1j1aPMOa+DSHm0xq8RApAVDAjg0jgTqrskscv1oNJvVxZbNujNxxyPvI3TY9HcpNaBzaqD/klcnQR6YYXD4VeoPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1dvb2FGajVYNkVyT1ZWSkFMQUJwRlA2MExKdlozQ3BQUllKR0diUUhBeDJm?=
 =?utf-8?B?ZklsS2lXWUhVQ1ZPMXVWTGhXQWppRUhrUVY0SUdScjBPcVluREtxS1h2akty?=
 =?utf-8?B?aEY0MzRrb2FkYjE1UlhtTHR4OHFHRDdJbVdhemNqVXhpQ1hIaXJwQzQ1ckFi?=
 =?utf-8?B?Y0VDcXZ6VTJBRFRjTW0xTUp4cjFPcGovZkQ0Ty9iV1hzYk43Qkt0b2hDWTVa?=
 =?utf-8?B?dUpLVE1CWS9uRHdGeEQ4VTNnK2w4TWYvTk5aUjJ5TUxsZHd5QndGV2lTQXNr?=
 =?utf-8?B?dEI0ekRydjJiRDF1SVJOOFFJaDZSWk1VMlU1Z2dqTVcvMDFzTnl5WXZVbE5Y?=
 =?utf-8?B?SVBkN2FDM0plOFcwNkpWODRrYkFSTnpNbjBoQ2NPS05hTkpaeHJYVUpUV0Jt?=
 =?utf-8?B?S0Vzc1pvZWdXaUhZWGFETFBxWDlOQ0lOeU5YckhRRFUxdU5OU2daVmVlUHp3?=
 =?utf-8?B?S1M2Ui9YNEVweFgxRk5QQ0U4Nlh6YWUvU1ROSHYrbHhkT2ladUZBamg4RUZv?=
 =?utf-8?B?R2k4citFVnlpdUFmOXVNR28rRmptaG5xQmdvQk51ejdIS2VLRERicGRlMlpI?=
 =?utf-8?B?emlsNlhOR3ZoOWZVKzVMN0xqNzdScVJuNk9hS2RkcE9hQ2c5QnZSeEhQSXZK?=
 =?utf-8?B?M09YRGJkTFpodzFNQXlBalNaVlA5LzdWZ2FVa21jRHNoNlNzSTVvMWhlN2pR?=
 =?utf-8?B?SDRGN3R2anl1d0tydEdwLzlYaGw4cTJCMkUrN1hBaWtaR3BzekFHb09rWFov?=
 =?utf-8?B?L1QvQ0Uxa1R1ME12TGtZUDd2ZjZyQVJwdzFJTVJiVGViM0RRa2svb0xJQlNo?=
 =?utf-8?B?TEF2ZUFkajNkK0o4bElXTWdvZmQ2TTRoS2htU2JHRmtVWGozRkdTN09qUjJl?=
 =?utf-8?B?czBUOTA5TEJOdEdTMGhpSktTbmQ3NU5PVmJNdmFEWnkyT3poMlBmUFhiU0pp?=
 =?utf-8?B?eUI2ZUd1eXlKMUh0dW1OKzg1ZFY1NHhHZTNGUHJ1WCtUSWdNY1BiTUpqczlt?=
 =?utf-8?B?VjNsWXo3Y0w2SUQzMXJ6YlgvUVhrTzVCNXBTN0lvOHkvZjJkU29wQkJUaGh1?=
 =?utf-8?B?Z2hKTEdML1ZtNnJDVzRkR2NYVGRObnZjL0xOb2RBTFBuazV6bHBwSEhYN0Ny?=
 =?utf-8?B?VysvelhvSjduczZRTzU0bWl0Q0h3MzhOOFlmbml2dzdPU3czNkoxVThuemRu?=
 =?utf-8?B?aUVLZ3ZUcVhvZlVsMC9UeTZxWU93RGkwSGlRMm5lYVdxRjFHb2dUdFJIUzZv?=
 =?utf-8?B?cnhxckVuMDRQdVVxUDZwTFpMMzM1c2Y4QVlrV0gxZzdDODRpOG96KzVuUDFH?=
 =?utf-8?B?L2hMcVBhTjNNd0o0N2gvQnptRXdkVldPaU5oRVA4anpRelZLOExRYnBsbXZr?=
 =?utf-8?B?ek55U2lKY1l4QjgvSS9WSkEyQy9UeHcrYitkeWtkYnpOUlppRjNjYlI3WjM3?=
 =?utf-8?B?TnU4djFUeVM5VllieHN1T0lqd2RsdjExY2ZmTTVjeTZrazNZZXBzMFpyeEQy?=
 =?utf-8?B?Vjl0TmdqVGJBb3lLYVUxMXBjTjVRbThDS0xMeXQ5OWdGeDN0L2JZTXNIV1RD?=
 =?utf-8?B?T0tDRDNBOG1lNjl6aTNTemI1VXlzQzRMRHcxR2kzK2d3amFYQ2FMMUZtNW8w?=
 =?utf-8?B?OU4remxMaXdVckw2WTJYVzgzYTdTUnVKMllRYVM2Y3dleGxuaHQwMmJNMkkw?=
 =?utf-8?B?dWFSQ0VhSGdEbk5VclNPTlFac3p6ZU5HYThKZmlmalRTdUdVQUo0QXJjUVVV?=
 =?utf-8?B?Y2I2T1drV01PSmpGVC9IaXVORklhTVlkeDd6WWRzT1ZZVjBZMEc3MWdKZSsv?=
 =?utf-8?B?M3lIazkvVHFMR1VROHhxTG04cXFiWmRSaHhlQnBaVVJwOUNtN3lyQWdTaUJ5?=
 =?utf-8?B?MjR6YlhxZitBeW0rbHc3OExmdE5ZS3A3SE93YWlwd1E3MVVHRjdJMEdkTUlB?=
 =?utf-8?B?NEs0NUMzT1FJK1B3eXEycGdUUDBCd2YwVTMrN1Rsdi9ESjEwS0Rqbis5L1l2?=
 =?utf-8?B?RUJuOHR6ZnlUNDRJV0lRWm5kOG9OSGhrSnF1Y1pISkZkVXhUN1JCYXhXU0xz?=
 =?utf-8?B?WlhYL2FHcTg3YjFmUTJLODRxOHBvV29zMlBaQXJyREMwZEpPS2RBZ1J5eGpK?=
 =?utf-8?Q?bmI+dqpZJ0mbr4ytgM+F1MvTa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5fc490-1702-4f86-0002-08dc5fc5c8a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:37:06.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLvhx2ArZv1OZP6JI26FjBsJgeRNR+amZwM9eevUtRzWWWqQTbfepmRPZdg05KZGDtLJ8wX8kfcL1sdZPpiwSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

Add cm41 subsystem dtsi for iMX8X chips.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi | 68 +++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi       |  1 +
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi
new file mode 100644
index 0000000000000..d715f2a6b0378
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <dt-bindings/clock/imx8-lpcg.h>
+
+cm41_ipg_clk: clock-cm41-ipg {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <132000000>;
+	clock-output-names = "cm41_ipg_clk";
+};
+
+cm41_subsys: bus@38000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x38000000 0x0 0x38000000 0x4000000>;
+	interrupt-parent = <&cm41_intmux>;
+
+	cm41_i2c: i2c@3b230000 {
+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x3b230000 0x1000>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cm41_i2c_lpcg IMX_LPCG_CLK_0>,
+			 <&cm41_i2c_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_M4_1_I2C IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_M4_1_I2C>;
+		status = "disabled";
+	};
+
+	cm41_intmux: intmux@3b400000 {
+		compatible = "fsl,imx-intmux";
+		reg = <0x3b400000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&cm41_ipg_clk>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_M4_1_INTMUX>;
+		status = "disabled";
+	};
+
+	cm41_i2c_lpcg: clock-controller@3b630000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x3b630000 0x1000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_M4_1_I2C IMX_SC_PM_CLK_PER>,
+			 <&cm41_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "cm41_lpcg_i2c_clk",
+				     "cm41_lpcg_i2c_ipg_clk";
+		power-domains = <&pd IMX_SC_R_M4_1_I2C>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index da49d4bad32ee..96a940c6046d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -546,6 +546,7 @@ clk_hdmi_rx_mclk: clock-hdmi-rx-mclk {
 	};
 
 	/* sorted in register address */
+	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"

-- 
2.34.1


