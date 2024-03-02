Return-Path: <linux-kernel+bounces-89504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC786F14B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A12A1C21111
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1942C224FA;
	Sat,  2 Mar 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BKHj/2Mm"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A491B599;
	Sat,  2 Mar 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396896; cv=fail; b=gx0aDWeEshIa6vRXfgIKcP/mAD5ZogNoB2nZAhfUlq70nH7VVqPQ3dDY6j23QMPEPSuFWKo42m2AbgBLTSPjkst0Dh6lCZUuY7SPjTE9jwZvoPAS0UGHc22lGZ2SsKv68ZpscrZxwNjQWjiAaD4qScorrQA3mzWKsbGbyc2L3Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396896; c=relaxed/simple;
	bh=uehcEhfC8MtsFXaReBML04FTsNRekKIoJlNMkavH+Ww=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D73ML+7sCy/YdMoEG37dLvJ4cs80OeiSuiSa22KreuONwHZuBhgoFk1BDENFK/axl4hraPXSNJYtNeRZ5F/Fcfa4XNBaVyUB/R5zDQKIWxJwGQ/vWK+6WEH+2Rn7DAYKhR7zuVnWPATzaDCAjIVIcRsMfWVkRUpYDqZBo95AoSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BKHj/2Mm; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0EQQ+yRgO8A59q47WffqbrDxkzeD1il9jzGomL9GvxHmKiR3oSBqPQVnQPxEiMcqPLbi9+gwB0XDNRwGmFrBtYFd8AX2ZA2SdTavWfNwPpgHQS3fbYpCfoz6vSrLnjSwj8nZMsRMdgNw5sRDdWe9PIBxaUNFWpGeIEjkklyKp0ZeKa+aneTIU5jir/CXifibbigLu3rO/iBk7uwmeP96LcaJzUHKCAgE5bPXlMc/Y2Vxlq8Xd/29hrz7KZM+cHgMWwexLHYAQzzBvXMyKrpo84P0f9JLCHVOXIZKDQIEf0GfQ/xy/Q1cTwceXnfkUVlvKOJdv4OUy/GhfSVA98bpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SH/BBXY7li3g5j1kF8/dwEGeX5oS3kUgaAVv6dEnmY=;
 b=f0eSEscfVccW43LH/q4jPgYAcmQU4hpOarKj8e4cEYNJKLmtv/5VRmQwkd8kvceNYVwTcce/ZOgh3wRNDmXpA+WXtZDmJ+QilSPm3NJYYA4WDKzb+oM2L0+q9t/3m1iXqB/kywVdiPm2GK5p/9cv2z1O1ZaC5Wdi7xbraWEeEKSwFEcv7dvu72BrrFG6reSxA5jQ3GKaHDA0l6VduFrGYLxdXyDGmzcrWo/bZhSkbdY2L0toll7FQ72Nt3DSbVVVa4D02/n2+wcZdD1NG8IICVBDd1QEuYgCRWmtVHJjMWxRORfE3bdwjnU2rEvLaZeEqZCmUofEZJPp35MkDgRauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SH/BBXY7li3g5j1kF8/dwEGeX5oS3kUgaAVv6dEnmY=;
 b=BKHj/2MmNrgOBvsomjvV5dhhrJ6N+nMHoHVa/wgR1/pAoT2qae3fJzOOQESOWZD9EFCFb/VvAMGyCS9R5M3hzqdOnTg+7RGHyZJ5sI6D7YtnYuzdwo3J8SzhZZu+Nka4xc4/q+ivdhiIy3c5nAn3+jgM6f5dkbVYzxQ69Vkxp6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8385.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.36; Sat, 2 Mar
 2024 16:28:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Sat, 2 Mar 2024
 16:28:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 02 Mar 2024 11:27:44 -0500
Subject: [PATCH v2 1/4] arm64: dts: imx8: add cm40 subsystem dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-m4_lpuart-v2-1-89a5952043b6@nxp.com>
References: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com>
In-Reply-To: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709396885; l=3944;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LtX8m5h6xpX4D9pf5g3ZNdOQ9AFWkHcila8AETmD7C8=;
 b=G8p7SRhBFpQD8uVluncZxR2R6wz5cigeNmXINyIntm28w/TeKBWBHe7pU0Mlj2puL6QGDNzUD
 7bLMPSQ3+0lDX5J2y9cyFJsAkG8pr2ZYVOC1cRnGYK0icpuR1JAxlXy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdc7a46-3bc8-4b3f-e9ef-08dc3ad5c0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XPifMdxzSjTNyse3qUhAD9xLVYE7+bzLghcUzCigf3AObmVPBtzG3cUj7AImcE2rmY+gMLgkfenJu+cV7DCWgnno+9NPAK6MIpKKWiV+EVqO/O6IKEQUlRLI/R7W591djQ/9b5zsa/Ny5i4q68zNQ7oyGNHIazS+wQ5BE5nCfis2OqwVDzLJrna0qOhDwe7GhF/wwuFMXVCpud0w0sUzU7IVqvlIDuRl9ZZ3/Oyw6t/DCdVXKNwXDw+JTjSs5wkHqDtwkkTQ4MEtBrKP61JZNwPkZTIK9IEej9Q3J6+Q887OKICHn20mBC1kw8XSMpnH/tWeQjwPu1VBxFQNB7Ui+EBMUGZpo3EZAVoepF1kAn6vfDLOcYQfklBvSbreXgUKzqIISYYXTmwSrJ7/kQUY3PaCibJzmETQPWFjV8vaen8Vpzz44Zfl9u2l2Vkg/LQz2xCLyqf5scjTWVND196hY1qsDcmryHiaScRGg144E1JjtQzqImLuWec+YxOZiqELFWHyibXF276VOJJk1yb82B/yDMAqEtGSJUAKaQp3rI8ocDPg4iOfFnI9cssQr//LIlf1+4FNjv5VK4ksg48fRYP2Ynh0rnxuM9IWNyLT2Fg7Snpj5iLL3jkt7+doFyVYHPq1qLtj6ulzWzgILHZ16njY//iaVhCbrOcmnRIdq+dqKDPPLT0AoK9L4UzO7fTvUfLk7BVvjijxHZGMD+qwJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGllclBzWUh3Tm1qM2E5dnFLVnBlUkkxVmZidzA3TWwzUUFKelQ1cWxQM3lx?=
 =?utf-8?B?Y1V3d1JVZHgxaVRwSUhackFvRXNkYjNUNTl4UUU0MHZLejAweEVqRWZGQis0?=
 =?utf-8?B?K2dtVjA4UERBenhJOUFtTjJ5M2M4WTVSck1kdHd4QVhxcGpaVVZ1ZS8yWStX?=
 =?utf-8?B?bWY5ZVBwNU5wazRnMkVYa1pYL1hscWJqM1JBOEZyTW9BcmFEWGsxT0JJYkIy?=
 =?utf-8?B?S3krZkJnbllkK244dUg2aUI3QmxZdVFNWUgvakpDZ0JxeFFiL01LV2dtSFFS?=
 =?utf-8?B?TktzQTFyTU1UdlJNUURtTlBJb1VwaVVCMHhFTWk5Y1VtbWEvaC8rM2dnbE1p?=
 =?utf-8?B?YUM4MW1EeHhDdThBMFQrbnFuc3pmZGJxUkVwOFd0WFk4NGZ3Qk9YQ3g0OXJ3?=
 =?utf-8?B?SWNMcStRVStiMHJqdlFYcDArUEE0eEYzMk9VM1J4djNEbVo4ME55V0MydzVU?=
 =?utf-8?B?RC95bU5iWXJnSEtYUVVJRTNmUDFtOXp6ZC9aOXJERkZieS9iZkMxd2hHT2ta?=
 =?utf-8?B?NzcvR1FCTXdwVnRQMXhGUlEweFJJd2R5YU93VFFlRVZiWjdGV0ZlaElNTXJC?=
 =?utf-8?B?WHNGdlp2dGt2WFA1S3ptOGZaRHdmQWhBK1d3M09wZittS3FaV3FvSUZEYlVZ?=
 =?utf-8?B?TW9NakNTQjZReHJQdVJEbVhOZnJ0S1pHTFdSM2x5Sk9Ta0hJbHl4Q2pQOEJL?=
 =?utf-8?B?WTJHbGJzcjFsN3g3MktVV09RZnJ2VjhrY0RmUHJEOWEyQ3QvRjRHNmtiTHlv?=
 =?utf-8?B?YmVSWDQyMnd3SE1HVnBNUnlHdU9QbjZEc0JLNnJIayt1WFI2akhDYy9kbmJi?=
 =?utf-8?B?VWZuZi9tK2k3a0ZVMUp0STQrWlVFS2tnRzZFSTRFZFI4OGUxK1hKT3dnZTlR?=
 =?utf-8?B?UzRFd2pjVFhsMGszTDlSQ0pPdFM4OUEwVWwxZWhLVUNWY2hYRTM2V2ZTdkJw?=
 =?utf-8?B?ZzFDcnc3QjByaDlHMmVYWEZxMEhZQldMVThQcm9qRUJ0Ynh4U2d6RHhKZ082?=
 =?utf-8?B?MGE1MjV4MkJuSm51RXFrd3NaQXlyeVBnaXJXK2toZFh1LzlXRGhmMDFJbXNo?=
 =?utf-8?B?bEY2UTAwaXVVbTdKa3NBTVovTmlTVi9XWkZoN04rdmZVWXI0OGpYZW9Fa1dx?=
 =?utf-8?B?cm9EN3pYK2h1OThhckRpZWNTU2dBdDExRjhtMXo4R1dxQzF5ZkhJZWlLcFI3?=
 =?utf-8?B?b3duV0J2cE9iOVdQZ1B0OEdKNXA3LzE0UVEwWlRGSUl1VmU4Z0ZOTGNVdS94?=
 =?utf-8?B?Nmg2TG8vUENxYXgwOFpXQnp3MWRKcjlWbHArQnRFOFZBVmptOS8xazlpRmxT?=
 =?utf-8?B?cXoySnFLMW9tUGRnRUVmV1MzTVZLR0c4RG5hT05yWGhqb0ZMdjNSdlNaVUh6?=
 =?utf-8?B?QWNtVnRhZ202T0g5WEhpRXhJSk9DWTl3ZHoyL2dmR2MxYUxURTNCOGkwdmRr?=
 =?utf-8?B?UG8zUE8wTXlTQmxUMDJGTjk0Nis4b3ZJYnpVbVJwbHNYOUVLOGxjMGhQSVJq?=
 =?utf-8?B?Ym96OVRGa21OdHhvWkNaeWoyM1piQXJ2WGVtblo4SHZIMDc2Sldmay9nQzN5?=
 =?utf-8?B?ZUFEUHQrdGYvbHFVdG44cWNIQ3VGZUE2MTRlWjdDWFlMdVRsNUVzQ2lXbW5z?=
 =?utf-8?B?TThLZC9kYVlZYlNBQzFwaEN1aTdMVUtFZW1WTXNWaWFWdXVCSHdmSXBVanJR?=
 =?utf-8?B?MEVhd1Z3YU9pbFVxWjNmK1R6MGtxRkhSUlJwcnZ1cU4xb05RZ0NSRDJqdi9L?=
 =?utf-8?B?dVRxa0dIYWN5L3c1K0ZqTUVCanVzVUt1c095Y3pnRG5oK21saEFqeVEzV29K?=
 =?utf-8?B?NDdSOW5vQnJmQVR5T0R1bW9kdUVCWDM4Szg2Ky8yYkdJK3RZL2tnNmNtU3Y4?=
 =?utf-8?B?amgyeXlCSFg1L2J5TENnbnVWTm16azlSOXZtaEJmdHdsaEU3VTZCWlpkRXFO?=
 =?utf-8?B?NjBNVkp1OGk5YWIvRXlVcDNCM25udS9ETHd2T1EzekhOakNRK1haT0hlSk5N?=
 =?utf-8?B?eFhKbUllblNOV0ZzdmYzd05qVlFtWUtSWExHTHh3eGdDOVNaNDF4cmh4NXlX?=
 =?utf-8?B?L2tseEtXVFFzNm9yTzZlTDJvV05tT1VCSkRJTnhyZzhVdDJ4L1daVlBJMEY4?=
 =?utf-8?Q?1nGs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdc7a46-3bc8-4b3f-e9ef-08dc3ad5c0f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 16:28:12.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCfTVDEh8Vw7jow3A3pobIHSqidFSJpwjhsKWTd0/RZ6oe5aH59Dncf5AJth9fdtZBlPx8WnPJCwMR/99w8ncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8385

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
index 0000000000000..68043ab74e765
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
+	interrupt-parent = <&cm40_intmux>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x34000000 0x0 0x34000000 0x4000000>;
+
+	cm40_i2c: i2c@37230000 {
+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x37230000 0x1000>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cm40_i2c_lpcg 0>,
+			 <&cm40_i2c_lpcg 1>;
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


