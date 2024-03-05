Return-Path: <linux-kernel+bounces-92638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD21872344
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D851F25F20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D492128831;
	Tue,  5 Mar 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M0/JQf6A"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCCF128807;
	Tue,  5 Mar 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654117; cv=fail; b=OSTHmUhn0Zbx5A6KgF3uWUTmC2svvI2CBII9sVPfV+tMF6YMQMpyT3Fz+KS9oi35KFIpkshrQNyx7RStH8A84hJIXAV+fTkKtg23mq81EEuebluteziB7pMTcw4M/DRzL3FfE+4hvJarp7v4+USz/vxOHjeAdKFemtlY4dS372M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654117; c=relaxed/simple;
	bh=zMdWwOjkp1mDMi1zn7OQ+fMoAXnWokjAGqL64Huq6IU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ElF33TzP3FrFWuMM2y0ZbXKULEqPQZMlhZwngNYU8+Rp6uuVzn0Q8rDO9SeJJ83qixhwQA5yeQweDguXVuziL1njUlY4USzufuX12psNnulIS0/g7Q6UzDa5VJcFsmmmdWCflGM7AoxqfNY6CrGlnyOq7YJSDUE4fv1LG6XCvfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M0/JQf6A; arc=fail smtp.client-ip=40.107.8.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGad49igulrafx1gBTE+tHj6ZC/gzJWGCXnvOWVskx7WAMsEzEvN8H3ARBeIG7zb2PwUtEcFOAUTvzAwMgUGyOVMOg/D68tICu5466eUsVESbwCAaULE87zNAppCT32PL4TdEue59Mo2TW3kNOtoSCe0I/s8uVGvo0GE5TJfH3+7cmaiZUVOL8L2kyA3q3QzOd9KAcFOG6VpoNc9klQvCZjGUVZfvL/3b01BQ5QRgmXz9tyAKQUX+9CkzSoMOrwnI6GivE6nIZ1gvIMMeruW+vWrBtVIUsPS5ouPgw8PAD7ekbPhSzgR0lzndSTC50gjorZlOk4obz9Sy9Xrom4FBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaxA4pUeprCKWQVArhAn3BS4sfzcV6sLPhPKTU8KK0E=;
 b=dPYhIdbM1Ze0S0gVuvCF1xrk7DHMnhJ6dZ6FiHv9GJuLoCuv1i3i1W98dszwu/k+Wut97PTHqZSpq1tJ4ywtLnvXf56isJbley0HvCZS5l7nHWF9BqCt1Iw8K6PiHHbpFZfuUOkxLWHq0xXMZpdmNre6tFbhLWkNQBsFvTaCBpZqgXrSKikERk5p8v7TsZJebmb/iZHurL0Pku7mJk40cp57X2R22leqd5THigQpBROfiSMGx6eBeetO9BEw+/OHdSTZT8fz7U8lRGt1SXww6I3QcHOIc/UfGW9gxlaA581Mp5EOrV9N+FmdQkJRPqbYfGQ8gpfBPzp5Oxu9lDaiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaxA4pUeprCKWQVArhAn3BS4sfzcV6sLPhPKTU8KK0E=;
 b=M0/JQf6AFeDisrrkr4vmXhWkuplacAE19LK8XYTMPweTYE+ifGijZVrFOu+t+eYu+fL8BASGX9ddAYUQRcx+wiEczDOKjGB4xSFfqDEojayl0GAwMaiAwKT97iXZ5N5NpRYFeu3Pz4qIWzc/KCb9aulKhqU8STGC3HeZJ2V85z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:55:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:55:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 05 Mar 2024 10:54:55 -0500
Subject: [PATCH v3 1/4] arm64: dts: imx8: add cm40 subsystem dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-m4_lpuart-v3-1-592463ef1d22@nxp.com>
References: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
In-Reply-To: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
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
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709654104; l=4008;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BmPizfG81J0ME+YTWxEqbesgoz7kAmFt+mvSCIy01Xo=;
 b=6FhPkRr06k4FHeBACOshsz93gNW32ELjZMu6Zi+/AvDdGV43BK14SBosDzqxuAbQfWRsbaWdt
 1AJQsyv+SM4DgRJqJhs7CdqlF1oChfVL6OKAD2KYmV/o/03RowvJj1s
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bf7838-2841-4541-841b-08dc3d2ca38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zeLKdgC5k81xjtvCgMPgm4tJDs3i3mVguUs9elzTRIxp2VwpYqnLbm9U/xVzxh0KaIlhHvOzSfkdmKoFi9BLq4i4dQKWSLV8b90uTGWNju+N1raPMe//PQLzPngvESZsEMGjGZ+uSpixVggO9gXtkUON4YbmhztntgdBvYq27aCbaKSD/ePJHnOm9fUed2r0jLgQ39Rm9ltqKWz3y5Bw17DsD8+ylvRGx7tQ7jhGrGwnbJ+kHWqblXOp/zZhvaXJ1A1dlzqniN41XlkLWmYGnVPYEvRjEqIGOJ7ryxBFSzJ567rDoQc2AW6HV8/CiQFD7hh89NknWEorIEWsJdesd/jzSouPSVzyxxsvQ2XMSEsNNbRqQrH7eDPmhSc6BOsbkEzUOaezK1QK0iRp7ZeHW3TENy1b5+VvJOSHE4gt0DDZkuUAaPqwM9ZOxRnp8f1XrLfhkgO+l6Kjwf0Hl72B45E/6Orgxhfz9vSLcv6McBQRGV6m8sCxv9oM6RiSg6DGDT1trEkBwozyI3ztJwv+wfWJNuprStw34xGa7mhF6YxMkyx1uurCTiFgex1EQx2gYZE+GP4esd8KMhEnbnb3velZ06kxucUUFg87+Bo9tAIixr9fck/Q9yEyUQKwRJjo2EMqL/JHltEzth6O+5297S3pQVlxazV1J/gMDp6MEi1fsrcQEfS8WUyTcx17N2U8ERBpgCPO8L8+xMZ03F4TwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aS8yOFplbkNpNGVEdWVreDZSSnVSYlNzcklkN0FsNnpMWmROYjhqZ2VhUm5Z?=
 =?utf-8?B?MTZ4MXpuK1NrbFJyNGNrUkh0dWowMzVtd1VQU0NSNDB0Q3plUWkxN3ZUOW1z?=
 =?utf-8?B?YUtMQnF6NE8wYnh2UTIvS3pqV2k3MGlPZmFaVllpU3pLazU2QnRWS292bjdl?=
 =?utf-8?B?TVo0NkVSREtnUHFiRTFZRGQ3bnA5STdsVDF0M2hnYXY4OWhNbDZtTDE5N1g1?=
 =?utf-8?B?cWNrSEFIanJ6YU1yeGdVL2xLZ21NSXlTUFpKYTNhTjBmRml3aEMzRXdjUDJx?=
 =?utf-8?B?QzV3RktFRDhRNUFxbi9KY3FBZXhTUW5kRkZEdDdFY1d5YUVMc04rSHlVTmN2?=
 =?utf-8?B?VEVOUHlWTUFqc2dMQlMrSjNJZnplL3ptMmdVcEJLMC9hZmZPTUlJc1l1OUla?=
 =?utf-8?B?UWcycllLTlhPUEMyNlYxQk1IbHhvWDF0VEQ4TjN6NkNHaHJ3YzVqY3VXelNk?=
 =?utf-8?B?S1VTVmo0U2QreGhLclJDL01KQVJEOWR1OTVtT3BGU2orU2FBeGw5STkzam9U?=
 =?utf-8?B?MUg4TkZBWGlWS2Q3N3A0eVVDajhPSEt2VUFiMzRTUm9wYTdvZk9IenZmeEdG?=
 =?utf-8?B?OG9KTEdzSGU0SjhWVnJmVmpXMTE2NHJjTVkxNE9ZOHp5bk9SSXdTOTQvR3Zj?=
 =?utf-8?B?RUZJbnRBaDVINXFVVTdQcnJCNEs0YTg3S3ZOQitHemQ0UHR3dU5wclUxUkp3?=
 =?utf-8?B?VzdqSDJDODg2bVJlU3crRGs3WUZRK3lRam93U0gxVTBjdFk4b1E1MVVaU2Nj?=
 =?utf-8?B?MUFEaXFBOWcrWnJQejg0N1dueHRCT1grQ2dSVHM2ajk2T2RqT0ViUk9ISFc0?=
 =?utf-8?B?NTBoSG5xV1N2eFRZdUN6bWF0Ynd5cWxqeHdBOWw1S29lRUkzWms5NDJVQzBE?=
 =?utf-8?B?Q3lMWlNYWXllZ1BkQ3JWOHVqREdYcU5meDZnTkcxRFJGaTV4b1VmSVI1TUNn?=
 =?utf-8?B?QysxUWR4SDVRY3hzVUlBc1dpMkNuUjVmOG05bXpxMTBzazlUUktlU2IwUDY0?=
 =?utf-8?B?dkdsRFdOa1o2R3F1M0JaLytqNXdUNVRDLzRCa2tUSkZtcjZZYjVhbklZbXV1?=
 =?utf-8?B?c1lFQTJ4Lys2bXhaT3NzMHYzRm5aOEN5cFduOGN4aFVNbzRKb05mSGwwU29F?=
 =?utf-8?B?VHFQWndYcXR0NE9YMlJiaWdKdmxNMXVHLytUa090KzlvWkZkVHdjL0FWYThD?=
 =?utf-8?B?MHprbU9WdndSVU1yN1NKRWVoSE5PYzJPUEszcGI1UXE4ZVNtbURpNTVtOGFm?=
 =?utf-8?B?OE9HZldoaWYya3V1d3ZnTE9uOVEyYkxLV1FOVkU0NjZUc1V1M3RjcUQ5MlFa?=
 =?utf-8?B?d0VkNTJ0Y2cxbzR4OWxGRkRKUzJ2eUkxbnh4RlJDa3RKVFM5WUhCd211QXBm?=
 =?utf-8?B?WlMxKy9WMTRpYVE5MVFRZ09VSTJNdk95eVZUY0d1SUtSR2VvNW02c1hYWkFP?=
 =?utf-8?B?Y0JIaVZDbkMzN1lpenA3M1Y5MGgzOUlNSS9tMlRGY21aRkNVZjl3VlkrSjFi?=
 =?utf-8?B?MUhNdEk3UzFtc0lSNUpNRHlhSld2NnNzbVdYVGp1TndOUkpnV0NTNnU4ejdq?=
 =?utf-8?B?eldRK3Rwb2htdUhrM2tNbUhMTnhZeEc1K1BsL0lNbDZFMlJmL2ZsQ1dFcjVJ?=
 =?utf-8?B?N0xBenVsOUVhTFJjN0tKTkFtdzR1a09hcUpKZGZLRis4SFlhdXpHTDZCNVY5?=
 =?utf-8?B?ZGcrQWpCVzlNMVFwcTVObUlTQ3ZUa0xabnNndjFyai9MUG1sRzMvUTBBc3M1?=
 =?utf-8?B?M1lkSDNDODJVaEJyVXllM2RkZ3Z2MXdQZ0NtWW9yNG5sbHk2VGVtaVNyemFC?=
 =?utf-8?B?QVVvUVJUSjZjdEQ0K0tGZ3l2QVpHaHFnc2dhcjAxNTVXRUtQYlJydDVqdGVW?=
 =?utf-8?B?WFZHM21wS0JpZElaMU03NEgweGptdUdWNUttdm5LM20xdy8xb0NiYUhESStC?=
 =?utf-8?B?a3p3QXp6cGVFbUdMRkh3TWY3Nyt6WW9KUnIxOVNOTGxuRE1ZOE9Bc1VTV3ZD?=
 =?utf-8?B?ZVg4RXV4YzkybFBSK2xqaXNwc3pwTTJVVDRDdElqZTNLbDdVWjg1cURiUGs2?=
 =?utf-8?B?enlEOHlKYVdZY21td2RRc3VUd1QvUEgwcS90UThmZm1PVHhxaWcyL3ZsYWtR?=
 =?utf-8?Q?du0i2VbNZm/6E6wU3E4qWFRX2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bf7838-2841-4541-841b-08dc3d2ca38b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:55:11.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1J45bCHWWdo5Z+xyULOihR0kYQKXZQJIkGWoNn59dLHMv8anbhpQseBpTEDnti/9bV+aF8lOhqZJMMWEbrHcuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780

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
index 0000000000000..e918ebd76094d
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


