Return-Path: <linux-kernel+bounces-145836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E066B8A5BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAD51C206A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA7515E5A7;
	Mon, 15 Apr 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VbiK2lC0"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03515E5C8;
	Mon, 15 Apr 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210438; cv=fail; b=eltrNxFaTfp80rcIDJdnnAFdAtVfwrg2W6vMwtVBhSMIZ82Ll2DdCuLl+8VlkLoc8Of90uDOQGzP29VO/7DZ3kCjlhX3sHtr4tcIRJeyNnrf7TaAiKSH3XpaKvLKCp/l3DIB7Jz8erOLQgzNn6oy/ig1khsoT7mGIcogGrW/2GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210438; c=relaxed/simple;
	bh=tBWF0Asy9OzGdJVvC/vxC7/ms1YGwCbPE2oc8x07IEI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iviTxJowBhZdTVhFpKQW7UbHPiJW46stjKchTLW0mVHu4dAhAz33zdJ0mur/kdAU+YRhS3BBR5mMws5UGtkomfdqvMgfJX0ky+MJaJdXYBC12azPeWrFHDjoG3iT3nFoB+mBUGid3KgTH4fh4BCAHFoIKEKgiGFV3iRPMqopToU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VbiK2lC0; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrSqlT/iRDuqHTYWFGXAp3fIffi1G4M4JjZIeSAtJNDdynpxOJaQ9t5D+qOJeGZVStATe3cTL2v//i8myBAnGMStjHxNWiu0hvS0vRRNN331mK5feyvvhMxVIiQIHxjctUjOR77p85WUPSLrEHDRUdc3DYr0gwmrVHhEx3yXPfDQH3kL+97GTrsk3zaP0Um9aueNAjr19SCQgDgTKRhtZhpW0Y3WpxaesieuGXFj32ljkPK6j7TpWdZQ8lESr9T33bUabQ3MocdM+FpiT0vBXY/y2TCy29ED+gBI4wdIWjq/rYsSvUCUuh/uVGmccefcYNaawiHXXNV4FLvIszzO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pfVE0FL5EjoFxtfQHO9cTRC/GSrOq8OvMAS142KhT8=;
 b=AK8VNaoiHNDDmmtahFfg2UGjl6ShOU3S8dHWdUYvG0t1JsA1GV8xkJZXkoDqrj+H8M+dW+7pAz5Okqv1U5F5TKIY7ZFEM+i5SlLBR7bQdwbfDsuaNi4+rkZE57aAR5/BuetpksTrN2aEaWhm3NtzZorIfMCPG9ZqINf4SqZHuiiOTrAvCMuCfteEeUjoumx/qOkC5EiAK0KEwa0TLwJL1VUoSR6Ile3MTaK4c2jsvxG+bvDBwKEhtAjrS1QLFdI9zhNhfE2Bhn/RKqcyP8uoPVyu2vV43x0ZC4/ek4LyjTOpQh5dElbRP9Iqrq38qwoLCqnYTsbQB0pLIuKU4usthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pfVE0FL5EjoFxtfQHO9cTRC/GSrOq8OvMAS142KhT8=;
 b=VbiK2lC08GgX0sJgZ9XkGm9EH1NuAZbt+2ym0XQvMPXgIq3UeRi+HH+5++7KnqYPHhER3lda68smrczCfr0VQER8eE9zWUdE2jZzOWsseY9Xqc+Hx5UeTDKtSB52prxkoSjb91xOnxtSJYyLyKDhxoqvBTgqbFMB1BmM33mD7yQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7290.eurprd04.prod.outlook.com (2603:10a6:102:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:40 -0400
Subject: [PATCH 04/10] arm64: dts: imx8x: add cm41 subsystem dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-4-2976c35a0c52@nxp.com>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
In-Reply-To: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210421; l=3146;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tBWF0Asy9OzGdJVvC/vxC7/ms1YGwCbPE2oc8x07IEI=;
 b=+IIuld9v7c1Bm1gy55LV3P/ivwJmp0yQffUSH4wtn/v+nXyeL7eX8UKnq8mdxjxoK0J3md2cF
 PTdgbLlIwQrAtclKUzPWH2Gjb3yQyNMrmsL+mfx+2RK35O8wCinMRF/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1d36d5-eac6-4290-8bae-08dc5d84da0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bNkElvTnA+Gkgv1g1XgboBCP0e+pZejH+N0uVGgxAun8foC5VjEPraoVccHD0e+NMxLYdrNd85rVOoaN5ObsHYiDhkzgi5Lvs80HMNVme9h6nBg+Ecuydh9xk5yC9Yah2jzYt4cNY26lfY9p9A/VqAVpZZpiZ+EJsE7W5lo6LUDVs2OKIayJq0bBclvGXq99J2xXVYSF8Ovgt71mX9VwKWKb0qo1Z/a5sxNWLt+0BTdj5dEUuUb+EUl7fT0NPDu9Jx1u5A0NhyUwQwbsk63PIW6TKihafzoUiYMwllrwEQvkPZGFt0S1hR9ApHKjTauLn/u1UG5sxYq0MZx8w4iQ5Dq8s4WbuMTg2l9paP81At+/VrNqEXIjMsYzhqSMv6GLNtMU07VsG3tPn1Uyp3iBdXknVThaAkTRjfuDDuGASBfdgqmNHfQlbL8bDHEDGvgM6Fmu4PqsOu0Cd/Y8xpHZZmPLx2TOsnN7xLl9W60upYUezConIR6apTGYo56A68XFBQ8QK6VzA+49H9h8dGWQMYRtn5U4CTnT8p46vqB6UXj8xtcVuFSIiL5cfA6Z80lB+gwmfegdKc7iYq2JjAAGfz94DQQivDTZ38BKoTPvpoP7p6HoZ/+P8pv4v3QZ5YixeqpsbjT27CcKRXGPgVXqQZ2BqmtwM4RAlywPFvHi7I57+ZDjh/Vp4yHvGm+pUTUA2nFpcAA6L4wWV0Tsch05uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clFoRVJOeG41OGJvNmNnZUI2b21qOU9NQ3BqQ1RHK2ZGbzhVTytydUlMME5y?=
 =?utf-8?B?cTQ4dURvNFRsdUZpRU9JdkQ0ZmkxWXZSenM4U1Y3NWVRbmU1WWRTVnNCRG5u?=
 =?utf-8?B?QTJBQ0c5V3lQeVJKbFdYc2hjek4wNmJ3QmZocGZDblN0b2REOUpKZzZpUGly?=
 =?utf-8?B?RFJKSVplalY2dnJrWnk2NWxJd2I4d3U3NDF0NVRrMGFQMUFMd21IeGxBNkxE?=
 =?utf-8?B?RnNldTRiQ3FvdkhvUWd4WTRPOTNYSGFIQzB4MHVSbHdVWThYWTZUVDVrTEJ5?=
 =?utf-8?B?WHRwbG1CYUluZ3VvZFlkRzF2Z0l6NHc1TGF1NGt3QUpuWGNYSlZoVU5oT20y?=
 =?utf-8?B?VTlqVjhaSmdTYzMyS2xaTFNzeGZzNXJQeEk5TzlFNzFYbzVKeDc0SXg0d3RS?=
 =?utf-8?B?WVlZdFYrd0JrKzBWT3FjU2s3Q0JUQUlNMVBRdVVzb0xXcW5mc1ltODhQaTVS?=
 =?utf-8?B?UXYwaE5nMEhEcG0yS0dsVFR6cHNuQ0d4TkRVSFdzbklPRER6VzZ5YVNjWThD?=
 =?utf-8?B?ODBQcXg0NW9oVDdHU0YvdnRYWU8yN0xNYTh1cytOdUZzTlduTXVzVDFqRTlC?=
 =?utf-8?B?ZUtJNmNldUhpcUZFVFNycEVPNEZXem1kdWI2UTB4blUrWmtGRW4wYVRWYVdz?=
 =?utf-8?B?N2VHeUZDbjkzb2ZDMmx0dU5DWUhVTHkzbjZWbTdkellMQVlUSDdXL3A5SXk4?=
 =?utf-8?B?c0hFL2RrR3V0NXI4RHhoN3ZqNEJIWk43OUpSb1d1MUJEbktYMTg4T0VJWDRn?=
 =?utf-8?B?MlhGeTBoSHQrTUxXdFZidGFLdzBrWG9DZTFqUnc1OWYwc2t2cDc2anNUYTYr?=
 =?utf-8?B?dCtjTXdUbEVZclUvY2lXS0tjMGllNm5iK2FKQ3ZiekorT2ZTY3J4T3ZOMHpT?=
 =?utf-8?B?MlBmWWU4ZXI1aUdoZUo0cnhvTnBDM25xakZrRzZzMWlRbDAzc2ovekM0Tkh5?=
 =?utf-8?B?Z2lXRjk5cFgzS3ZPZUY4bUFrNm5lQStrUStxWFBLZGJpOURSeE1aQ1dOV1V2?=
 =?utf-8?B?STZ1b2dsNDJRc2RMOUFBTlF3c1I0citCaFVFWHJHVHZicGI0WlgxTmJvQjhH?=
 =?utf-8?B?aVVFakhxVVExQVhuU3BrTjFLNDQrVWRNY1J4Y3FOM0lqRE1aWmZWbFYwTkVJ?=
 =?utf-8?B?TTBORkd6dUZXb29JRFpWamNuMFErZEpUeTRVeUVSdXc4RjFWdVhOTHFzVmVN?=
 =?utf-8?B?SVBkQTloakprclcwZ0R5cjRHWnd1R3duUWNka0g4a2JtcjgxbVh0M0pHcHIw?=
 =?utf-8?B?bjJFYlJzeXNLc1NlcHhMSndGSHpzNkxzRm53bHgxT3JHUis4RTFvYWxyU1V6?=
 =?utf-8?B?YWhoaFJjQ2Uveml5aGd1bm5GNHVFTGU0RytHOVBSaWp0UkNheS9IS2krdEVk?=
 =?utf-8?B?V3JrdFpFaitTR2psbSsyQTdXUnJTeHJFWXJIbnpFSzY2WHlNN1ZPL2RNd3hk?=
 =?utf-8?B?aXJZS1oyakl4KzNUODkrZTYzRUQyQklpVmFGdk9UVW1XMVpzb29QOHhVWnl2?=
 =?utf-8?B?UmlZVk5UWC9yc0U3TkhkR3ltVjNMWm1yS1VnZWhacHlDTTVBT1dUVWxjVlNB?=
 =?utf-8?B?ZEd3WFBuUlBuODJwK0xuR1czOGc0cVZSQjhoUnVCYlZZL3F0a3FXS2hUeGtD?=
 =?utf-8?B?dC9VY3BJUjVNSzFRSEZ6L2V2eTJrK3A4VkthaFhEdEhzbm40SkdtOXpHYkR5?=
 =?utf-8?B?NHp5QzVIR2xzVW5tOWttRnluRFh6VVBlQ1VmbFA0WVE5MnFYTFhRWk5HTEx4?=
 =?utf-8?B?NUJlOW9Sb0lISUZEVmxDWlQ0UkpWNnRIdHpJdkZiczRLeHc1V1NxZy90bnJL?=
 =?utf-8?B?OUViM01RN0hUdjdXSzZhSDl2bDU4LzVHVGV5RkhpT0ViUzhKTGtoVUdXNEp4?=
 =?utf-8?B?MHBmbXhGRHp0MGV4c1Vtb2lla0RkMlZ0YTYxNDVsUWt5Q3dwbkxFaTgzcjZl?=
 =?utf-8?B?YlhpUHpScXpvS3BPQUM1MlF4RXVSeGNhNmFYdlp2ZmVNWTJpQkh6dHk5dGt4?=
 =?utf-8?B?ajAzTVN1bUcyTkozaU1rMjRvdjlNbHVHODdrR3dDSU5zS1BDVUNkeUgxZTNF?=
 =?utf-8?B?ald0Tkl5aGthcEFYV0dmejd3WDF2cEx3VERuSEdxZHR4Um1MVWhmZjZMNkUy?=
 =?utf-8?Q?Ur1YPZZhFbSRMsayGbkoDM37Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1d36d5-eac6-4290-8bae-08dc5d84da0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:15.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr/gFYhPrLX7/sd8mQ76rcTQ+5bEb1yG+yWOE5+3mK4s5Y1Bd1xXhaO2FrU9Hp67tWtushqAtZkpNqgCVcmVcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7290

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


