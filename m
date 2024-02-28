Return-Path: <linux-kernel+bounces-85647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3186B8A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03423B23166
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999174413;
	Wed, 28 Feb 2024 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sqNbLgBv"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2072.outbound.protection.outlook.com [40.107.15.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09395E086;
	Wed, 28 Feb 2024 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150133; cv=fail; b=G9l4qO2+GWVw/xs9HiQBwpdLsDfrqXGC4p/yP24dZij+b8O54oYSJy08yRW5NAsqj4JMv0D6N8PrTEPUHR802HXMtg3NbicVcxxLwM8fExpIsiu/rG/pzlNEAbV1H1BBAHWvVmvPK9dfBphyNa+EnPMcTrzTcCHDc4fHdk2avxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150133; c=relaxed/simple;
	bh=3GFeXaibtTbGABz28wcbZRbFF+UIHCNzCpx4iackVug=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d88dd5MKMEae7d8hy0elBuZnGqWpIOwdWZxSGsPBu5J28Bf+z6Gf9KTv1dsaWRvxsWIQ0ACvF/vYw05DMu2FLsCKK9GMMTAHITYeag0xGHNaPvDQ2Y5GO27Xncs9RCsQKYcaO/DJ5fnpqEjK9AJj9aryupbWHvbUCNAyPFMjGVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sqNbLgBv; arc=fail smtp.client-ip=40.107.15.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbzu0zjqPvquhO5go8F+5XKf2Ds/ODYt03/BZAssZ6FH8XcBtmdkU0e8MgA6vYkGRMLQ+70vWj/W8n5sOvwO7lY0VSzIo4su9spUYoCTZyM/F9GMXnibus1EWDIPoyNHciDowxalquBPHsUPiBFZZ5rJfUr+qEBrIWDHFKFUmPzbY2trYiI1ArnsG0sEdzi4IStezhUOwEm2+NANlfIefVA5xkomdnpUAe8B7rIPya9fkFJe17gthByUx9tF1bP1Go6q7XxT8/ZJ0s/qVo2iG/90qG0p4faohxzFohyfU4vnOPv7P5Iakja+vuq1Hbog96GQF94SgCZi66A/YKe6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvqlymwOven08/LkqBvx28lfzZ9FKYIhplmEtK0DmS0=;
 b=PBteOT3Fx5xf3ktryF8/fEA5KziPSIqvCffA4XIOFNlp/gi2xesMNDW3Oud1DxOMqyOrH/V+8+6VaWvVHS7gX/tjkf8ayHXDqiIA6szrjrqybP80rvlbdecOMdA3Ywx9ph9V2QlqLpI2Ge68XsBan2E6H2AutqB0wZfgf89VREoyXI+S24NjNEMDsCulsvvR4lhfvyRUlT0OeisbLNNt9V7TiPdXw8IHsTX+WecAZ8AZOIeE3M1rf/GZyV12GjGHBEhWwvb9AqsgHLToaqQH6xKaMCIfB2OzHGOw5VVicnJIPMtlKPr6hO5RB3pLl2fRwzneh1ya7ROME/xOjT3hlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvqlymwOven08/LkqBvx28lfzZ9FKYIhplmEtK0DmS0=;
 b=sqNbLgBvOSelF7/qD1nJqtVQnrSLgB1omu72SRWhfCLUIqDnBycaUQwRY9ELaFfMtEcM8uFikoMoGdDY/iN4Riip9P/7/bVaaOLQsLuRkBwRsDQgfoXFIuLjGdFakUE6qP2BgPn50TJK24ScHLJFnMFyZQad9mfPZh4pVAmSdLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7732.eurprd04.prod.outlook.com (2603:10a6:20b:237::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 28 Feb
 2024 19:55:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:55:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Feb 2024 14:54:57 -0500
Subject: [PATCH 1/4] arm64: dts: imx8: add cm40 subsystem dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-m4_lpuart-v1-1-9e6947be15e7@nxp.com>
References: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com>
In-Reply-To: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709150122; l=3922;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3gJPWPA/hW9bx+8iu1yluleIzFVW17Tf1dIfM3jpNMA=;
 b=61pOPWb/JuZcsCeW22rKOadutubdKo3eKJNWdvu7z+fID0X0GMe6y8ELH3RNEpg+Z08WmwQsc
 FF9kiCPkOcvDdL8uT8nUesLrKZrn63luEILtY9wn/3pc5SfPwgYGrab
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4840442c-981e-40cc-58fe-08dc389736ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H9EO2IiobHrxjqhHJU3Qi1ndTSNC58xJ9IqXTY215cQWNT86+pCF7z3LaU5CXSGqmZeOQr6fMIcJMYU57aEDITTDhNl1L1sBLFaMS1Coa/lAnWLb5Q60GHXO2SekQJuxSWmhVD7qrMyfgRV7ptij+DeOiDQduDPgrFKYPAxjgIr9THg9nxsNIbGp9F3lS9pGbXc1dcsCwqnahjLgpEUoWhDSo0WuC7gk2TvZXl/YlvJOLCxgt6GnVImZhvCENxY2p+PqQWHBprmjju5SJ7KuJ9lm6wnFJgIGeDwyXFHKBP0APwJJZ0dIy8j4p+Jii2YhrxnZsfGatYUTzArc367CwqKt2XSBFJOJNUamXWRBLooDylPMhejAr6TyBbG3WrOszToyMyx5rqA6hgm1ANurFXVN6ajmxK5+rhJxdVxl2lxekGLtO45b8OFLTfYw+T9J8giZ3ZLpsA80YasSw1OpxM29PUteiiEI4d3OS/YPXH63lIkMV9KtofYuxDdxKI/HWVEqGx4Uh3HedOoBlApwbBfwUI2tF0XYsvE1PXLbHk5/E+bAlzISo95IShdnHrROLLJz+7PkFynD+BTeOcp+C2uZi/q8BJ3hsfheAfAP3Qii+bOeR9hXjOVwgkj+tlQsgte7SqnZDDSIxlwore8KvzVxZdCM3xfSt6nvktbwoA64KzRMG9oVv4xcY3pvQzgZZWRvSdr4YforhlC18zvu7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmlTcy9tcGFwWHRQdXQyYjBHQkdPZ3hydUx3Zk9SVGRkaTh1UzBmUUlsVFB1?=
 =?utf-8?B?Y2RjallnRVJ0NTdGS2d4V2tQeVNBbThwbEw4MUtPWTEwLzNoRW1kZFhCN0g1?=
 =?utf-8?B?MnhjbW9lbHA4UUlQeUJMcVZMR1pGQlR1QzdUVHR5dzc4N21KaCt6THRVZy85?=
 =?utf-8?B?VFlpN1dESktxNDZaMzRqRkFtQzE5VDNxRG1RSEUxbXNJWmpGYkY5cmkzb2wv?=
 =?utf-8?B?amtYRG5BQkFvTnpMUU5aM2h2c0YwYVVOanllS3pKVFJvZ2x0a3UwcS91UkV1?=
 =?utf-8?B?NjJEa1ZtbmlIZURabG5iQllzUE1kRTRaU3Rna0hQdi9oc282dXl4ZU5nTUh2?=
 =?utf-8?B?Mmo0RVk2dUJ0bGFsR1g0SDFldnFKejZjTzcycUY5Z0ZzQ29TQjJwMGlNTTcw?=
 =?utf-8?B?NEQxNE92SEdZTFdCUWF2RVVvZGJKU25oVEpxenk1ZkpReVJxNjJURFlNd0ZY?=
 =?utf-8?B?QmNjMSt5VUk5SWxrOWJNSStUT2ZibnJaVjJwR1hkOUNaZFAraUU4S2NpNCtk?=
 =?utf-8?B?TnVxN1dMT0NTS2o4WG9aa0ErVVdPeEJUNjJvZUFiL1I5SGlsL3RIc0tNRG9i?=
 =?utf-8?B?MDJHZ1dMSmEwWnpHUzZiZVA0eEVlU0c1a0tNaC9PVWkxcE5RYU93OGE1Y3pV?=
 =?utf-8?B?T0QzLzU4OFFNRkt2UDNCNHZhS3JFMUkzY2NYaHZtdUszZE5lQk8zVzlPbERU?=
 =?utf-8?B?dkEweE8rVlVrc0ZJeHBnMVRTNW5OZytkM0o3enFKOFhBUFZvYXc0R1JIbFBz?=
 =?utf-8?B?VjFjeUZHVzFKVmg5ak90bFNHMWhuWk96RVVwRE1BZzdTTTNHeGpjcjExN3or?=
 =?utf-8?B?ckpUYjFCMnpydUpCaDFDeEdLbElIRzg5U3NLR2wxOXB2WmFHRnVxYVI2QlRy?=
 =?utf-8?B?TlZFelg2NmpmbE5aNjdmRGxrZDR0b3NPeFEzN3ZZU0MvYUFiODlSSGs1ckgx?=
 =?utf-8?B?cGJ1aDBhYXMzVmZ3SVlhZlM3dGlPTzkyVzhlTDc1VkwrK2Z2ZVFKZmdra2FS?=
 =?utf-8?B?aTNJUnh5RHVFeklhVzVuOUNrSFFySlhFczI2eng4WE1SN01POXRWTnVxRDFX?=
 =?utf-8?B?bVBRTHF3M3FEY3hXT1FINnVuSEw0SzNHV1BVL0VybTdWZDljbU1XSWFFRGlk?=
 =?utf-8?B?K0prK3NydGI0T3p1YW9oR3hURzJhZmdYZU1temdtRS92czYyZEZFcWVoa0VI?=
 =?utf-8?B?YXloNkp0Q21jRDJiU3dUd1JWcTVDZi9mNm1KTU5DbXVjeGs2RDJzMDdNMnYx?=
 =?utf-8?B?cndJMFp6bHFTY0J4REhqbHlieE0za0RaSHcvdUFpOXdGd3U3b1VPd2hpN2Uz?=
 =?utf-8?B?K1dienZTTWV0WFpLMVBsNEFmQ1U0MTJQL1ZGaGVxQkVuSVI1VkNDMmRCUDJU?=
 =?utf-8?B?MGlrSVVZc0Q5c2twS0QrVS96dmxQMzg5aTRNaElxUmdSelMzSDZJaCsrOWps?=
 =?utf-8?B?MnFHZ0hQeHVETWcvL1VhNUIzSjFHbFN3ZUJkYzd2UFZKM0FSeXArbGJXeGh1?=
 =?utf-8?B?YzByWjYzSmM0MysrRy94d1hvY2JYSFJINGtYZ3pURjVMOGRiYU9NQUl1cDRv?=
 =?utf-8?B?TUxHNzI0K0dkNjMvdjZIM3duVTJxd005VGU1ZHhITmY3anNDaGgrNW1RazZr?=
 =?utf-8?B?TFRNYmRmVGdSanhaQk1qRDlLa25tdk54TW4yTlgzdzkrS0pQM1E1UnRuMll2?=
 =?utf-8?B?TjBFNDdJUS9wTVczNWdieU95S0YvcXliZ3RXNGR2SEpUbTFKTG92QzhYV3Jt?=
 =?utf-8?B?ZXBtWDBFQkpuTlBkNGtnZVZtTGRZTGJacUQ4RlBVWWdRL1o2VmN2ODN3STFy?=
 =?utf-8?B?VWhEVUxEVGFmdjFhZmlsbmxxMWU1cDVvV3lhWXIvWWVmRytDdDdTTC96OE1G?=
 =?utf-8?B?M09TZnM1bUxCZjJNTjM2K3IvMEJ0UnU0SDVPUTkyYTdIOFQ2cnJLbGNxU0Nj?=
 =?utf-8?B?Y09jaUlPamY4bXRNak13a3JnLzZpS1daL2ZuN2YyOEtsM1UwUFJONTJwdi93?=
 =?utf-8?B?UUFONmhacGxOS1RlYlU0bW40SkJKQ1lLOTRNZWszcERnVUhKWlAyMnRycVlr?=
 =?utf-8?B?SEVBOTFaK2VqbkxpSENlUmowaWJoQUhxdS9kZVNRQWs5NlJXTXo0ODRjVHVv?=
 =?utf-8?Q?vRo4bSEt+080nFKiJ+cfYFss9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4840442c-981e-40cc-58fe-08dc389736ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:55:29.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmJ1m6R+s9k8MbnAHcb+4OpmqBpGuJf1WG7IMF3xPQ2l1KvyFhijMKK1qfJJSki4Ona6/JCc+ZGadqlKEbaUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7732

From: Dong Aisheng <aisheng.dong@nxp.com>

Add cm40 subsystem dtsi.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 67 +++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi      |  2 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |  1 +
 3 files changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
new file mode 100644
index 0000000000000..b1d626862ddf8
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
+cm40_subsys: bus@34000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x34000000 0x0 0x34000000 0x4000000>;
+
+	cm40_ipg_clk: clock-cm40-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <132000000>;
+		clock-output-names = "cm40_ipg_clk";
+	};
+
+	cm40_i2c: i2c@37230000 {
+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x37230000 0x1000>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&cm40_intmux>;
+		clocks = <&cm40_i2c_lpcg 0>,
+			 <&cm40_i2c_lpcg 1>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_M4_0_I2C IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_M4_0_I2C>;
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
+
+	cm40_intmux: intmux@37400000 {
+		compatible = "fsl,imx-intmux";
+		reg = <0x37400000 0x1000>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <2>;
+		clocks = <&cm40_ipg_clk>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_M4_0_INTMUX>;
+		status = "disabled";
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
index 10e16d84c0c3b..c49fb1282ae65 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -316,6 +316,7 @@ map0 {
 
 	/* sorted in register address */
 	#include "imx8-ss-img.dtsi"
+	#include "imx8-ss-cm40.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-gpu0.dtsi"
 	#include "imx8-ss-adma.dtsi"

-- 
2.34.1


