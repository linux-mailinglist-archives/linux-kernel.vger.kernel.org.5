Return-Path: <linux-kernel+bounces-84621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9786A919
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1AB22CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939F286BD;
	Wed, 28 Feb 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="izG0CWXA"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502C25778;
	Wed, 28 Feb 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106023; cv=fail; b=KdfbxOAyLX+wi2IzPjOUGDqRaK5Cy7d4f9crPx3ZYImAtDey3dYq0dvxcLQ3aOtRfEYFpr0pMg+aO2emeSl5q8YJb/5FKoRFlKWDdPl+6+VJDp4dR1JWy4Zqd25czUbZ0HYMJB6YDaXCBlZIqn9qwxH1GQ/iRGCBpjmzjh8Qqs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106023; c=relaxed/simple;
	bh=GlU/eiHvDznANxmGcF0ERUOiLUZiWcsN6+0A/oceGW8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZsvSWq7V8HSCgoLbJwMtzt6eD7xi+mKoN2cApjdfPRnpP6avXndHHo/ptHiXMmcpurpzzAZUUSvLNrnKfG0PcvREjbNRD7NLrSfpeHXwDZsU7QEsu4LbfXx7NBNiNASAokedRHxMm8o5mTyxysTH3hOZ+MdxeyfE8r4wUWOMlGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=izG0CWXA; arc=fail smtp.client-ip=40.107.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFuow54R4h6bEGE1gfMNXwPr+IqV8KODADbcdlY8TTIERR2w/SSSaVyyWC0F4oDk+UpsHtf5y0LRGtm23NcXwkPULJVdv3/kKJMbgZg7ypzMedL5CJNAfIxdlL7EQdfH9/PxC9ETPF4S0BbjUw3Xkb27d3x75g3WfYoRw2C+vwpv+eYSMcqBlpfZjtlCEdQAJjYZIAsFJBBpitRjA12/iBOG2vD6IEBMmb50l8HyemLbLRWc07s9/YS0CCZQfwBcKWKrc6tO4QGBdLC0WKx0Peimjz3d8om2pmruw2QqhXaRqBJzOLg+LqrejhH0j32j4b1PnJSLmzqiqxKDH3gHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQc0GVce4gyfScQ0+2/NaBFXb/RM7XrxzLkMBjf6AsQ=;
 b=hphpGr79V+esGsRcVjEkoRNWvm5VFReTomjDVxXaHzHFKatpaOQOQBSVxeymnICNplqf21H4iMwZohkUFsd9Z0dH/GEn7UmjB/K+7u6fMFl9+LYSyY5iB9XeKFH6OKCo8VsE7rm9CrABehMhGk4k7Kj1M6ntJhwVluA3HRnNq5P1AvvyOHfPRAznyupsjQprF4bJYOT8MnrpeHa5jk8FLGcfFQjUaGH2kODOiGgg9dc8YMcsGbTpV+zBwRKEvgMr+mgbx94texltnLSlCq+WUUvruRmvMUnINcs4k17P0r5+jEvQ1QRjGKdccwNT+YVhqp3hUkPdMxEJbV4F2Dendw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQc0GVce4gyfScQ0+2/NaBFXb/RM7XrxzLkMBjf6AsQ=;
 b=izG0CWXAU1pZweR9aF5m4HIOXjQQMowQ74KmM9VDO3SJAEPWBWxawpmDhdoe7bH11PqmgwwHVoP+HAPbKeDO7m84HGEefwe573uyXvDu9L3O6V2p0yPyReXhf7i1Kh/0CpT2DnojHk/81GFvSFrJLcT+xQi0pD0EH9+NUCBGvQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB9015.eurprd04.prod.outlook.com (2603:10a6:20b:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Wed, 28 Feb
 2024 07:40:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 07:40:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 28 Feb 2024 15:48:22 +0800
Subject: [PATCH v3 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-imx95-blk-ctl-v3-1-40ceba01a211@nxp.com>
References: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
In-Reply-To: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709106512; l=3472;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=JfHNDvv+LPGya/rrOIhnl+dRILQQPy4kzO230r884iA=;
 b=KdR3D4sYUsKM8Tl6fmjX9HJ279JCiNUr7srdHSFOuzfdsnWq6or6QwvtaWQHV6SyQpuQeRZHV
 041st4q9MGMBW755hCHlHV+jT3gRfChcsjGinCrUsYSFGC9qL6mUU1A
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fcb97e-bdf7-420d-c9db-08dc383082e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NpgdY7bNvYdpuXhfGM7NoZkeWgRUyI3C2ZbNzYfoHWk8ksJY63sf2sLZ9y2GeFEgFW/am2XOcFU0+n2z/vTlZilpe1jycD2hMLiOUEArpI5gXSEepYpqWM8tKPuyJw/UDj7iTUJpgnMoFdhHsg72Fa3KvHnd0Up5xCyGcvVryKSvJPgRROtyCPsK/3nL/QeqlrqRI4eXnHGNfngF5bNxnDv2GhkBOQRlCFW61buy3juMBKRzOhYwHZKgWxQr5LHZlYM/JPs4aiPEybcJ9MO0rbtalUkRieWXba0pINU9x9spB59bCThet/f1T7yDY0pZBHnfekWkmtQ2RXM1/w36vtwTojcCho0pRLelqeSSAeNcwjOT/SLAUakKJOjEExARQEH/1HYQjVX4Lu4qS0rr95ryUFjCuFjV6dUSAXOP12MEdqaqAxzyS2AVezNbuFQoWpMQSqW9XimBFvqN11euOjBofNt466Zg1Z1k7UGsLHcdl5W4o293/oaQexIU6ERQgakrmXoOgA+RrmBHAz3wi+7Wko6WNrR2vHaqMcQ/2sm127KJ+joMylavJgez6WspmQoEQHRdKJbhOWsm6nE3GmiSbKymsdI/WKuIVbZO0AFidvWSzftPae8TwfB4UmKSr/Mf5RTU6zLwhNv+tYHsGL1jlAmkMw36MwfsYZDCNMc0jcoHAx5fb97aTfjCB216aaw6nv3Sk79r+WEqfpARounUrNEOmn24o3xW4ppfHoU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW0rQkRQU3A4VlppTi9aTjNDMkY4WmtiVy9jSjE2UUtJZlROQ3llQnJpK3pa?=
 =?utf-8?B?a00wQ1JWSU54a1B5Z3hOYzdUcWpCZHh0My9pcEsyWFllaWJmRnMydjBmZUMw?=
 =?utf-8?B?eDd1QnNhcnBTWTh1cUV2ZnhHaGwwdTIxK2tJdzZMU25ieWcvb1JKQVhmM1JY?=
 =?utf-8?B?ZFFuUGN5UkVwTXlSMkc5YmJVWWxudEhGaTNvZ0lHV3QvSUxkMnY2MTFYdDV0?=
 =?utf-8?B?YWRVOWJvaFpuUVVXTUk1WHpKejJDcjdDYmxva1A5QjRwSTd6WmZjQmtmbkVw?=
 =?utf-8?B?NC9YNWQ0NlhFampEK0Z2YnFyOVNJRGVzeUxRUVFuSE40VDVlSkFiRDFPTW1y?=
 =?utf-8?B?YzFDQXczRSs1K1lVSVZGaXYzM05HajZ6WHZ3Z1pVQ3JJQVlnbkpJYm5veWto?=
 =?utf-8?B?a3A2bXdJUllkQU55WDI1bHd5a0txUVFlblFmMWxRZmZHSUVpUUJWemJFVzZE?=
 =?utf-8?B?OXNLM2Z3bytQSFlnVTBZUVluOG9xUW1LYXVZbVJWckVBSlFrM2dCTm1MZTZk?=
 =?utf-8?B?aTY0YUVha3A5OFRSMEQxS3lRN1VDQm90clNHdUJEN3RjMng0TDBXWlVHMCsr?=
 =?utf-8?B?aVlaNWZyeU5pM2IvdVdsMDZHbmtDdnJjNXhPdGFYU3pLRFR6aU8xc1NOMUlK?=
 =?utf-8?B?c1dhK1A4ZGFybWdneTlpdmV3clU5Ulh1TFJidVFFem4wS0VtcmtwNTdHQ2NQ?=
 =?utf-8?B?UHF2UFkwODdZU0xScGRNOGliQXI3enc4QTBVeUtoS2dVWmFTL21CKzVqOUxT?=
 =?utf-8?B?c3dmZGpSbVBrQ3NyRUVSR0srM0IxQmkrK3ZVendsNlRyajFrSWUzMzZyd0dw?=
 =?utf-8?B?Z2lZSW40ckRDYnp4U3UyU2UyMVA4V3JJMXRiN2llZ0tXTUUvQVdtZ3FWVXN1?=
 =?utf-8?B?NTlmWFhPREVuUE1DVGtqV3F1NWVIODk2N09JRTZxOHlvN1p6SUVJR3grOVc2?=
 =?utf-8?B?d3REb1F4VFZuVGcxMzhua1c1LzJLZjR3aW8yU0V2Uzl1MTRONmJ3WjB6SkZB?=
 =?utf-8?B?Z0d0bUZob2tlUVNUQU54dVhvT1hEVmxCak45N1B0VGR5UmRqeTFqcS9LY0FO?=
 =?utf-8?B?ZDdXakNXSHMyMlJnTGFTMHc1b3FZSXlQd00ycU5qdUpxVkJMNzdjd0ZjMlJo?=
 =?utf-8?B?VXR5QzlrZFJWbzVSVjRINU1KeFlsVi95eGpvR0pTcFljQmkxUWhaN1c4Zi9S?=
 =?utf-8?B?K1A3MXppU2NTci9zbk1tVjd5alJuZHhTMFEzang4V2xsMWRVcmJMbmJXWWhu?=
 =?utf-8?B?d0kwTnkzdGZZRGVLbWlBcG1BaWllUURVV0k4NUlET1ZSdVJ2UTBRVjB3Rzll?=
 =?utf-8?B?bEdYRldXNVpsUktSWDhuRnFGT0pVcE9rTUV2bExxUU5ZZTcvMklsUmpGdnNw?=
 =?utf-8?B?dEorZ1BMT3FBU0hrUDZJVWJ6ZGNoaUJPSzgwVHhlVlNYckFpVnlDMENDTWp1?=
 =?utf-8?B?enNJL2FJUVlpcks5akc3akR6TXRyOVN4T0wzRlorOVFzbkRpSXFIUE5wcTYx?=
 =?utf-8?B?Y3FOcnQ3UWh2Um9lNlVJR2FQMGVBS1QyYzdEYzYrYzFpU3RVb04ybzUrcTla?=
 =?utf-8?B?NDczdE5BY1hTTUErWFVlSXhkVWw2VGo4R1hCOTZyMFJnb2dETU43ZWdiQWtW?=
 =?utf-8?B?a1ZPNVZURXNwVm9lc2RJTFJwTWduU3ZmRDFnK2NqRG5vUGdnRU8rOWRUTENw?=
 =?utf-8?B?OXZtaWIwRnF2Yy9uMWZudEtZZ2ZNWlFqYXI5NFdIMmdVdkdTUklFSWFzLzlF?=
 =?utf-8?B?YTllTHBIMXdxL1VpUkQ2WUY5aFFJdnlYTCtiY2RPVGoxeDdjTTJySFdkVFFS?=
 =?utf-8?B?ZnAyUDFzL2JWM1pNU29qdFI4aUtWR2lWK3p6S3cyYVcyK2U0NUt0aU56Rm8x?=
 =?utf-8?B?ZmlDbWFxMndBRnlOU3owSjFkczNVV1BaS3dIWGJtdzZ4NnBNNnpkS1NxVVc4?=
 =?utf-8?B?MVl0bEJvM0pFTTE3a0NVNHQvM21EVFBJTkVLMWN6TzEydC9HcGgyOGtyN2xq?=
 =?utf-8?B?MlVDWWYrM080emhScldwUFlUSUk0T3ZlZGRDYnNmWS81M2dLVTVkdXU3Mnow?=
 =?utf-8?B?Wi95WVNIZ2RESzhxZGxXNDhyWlBGNzNQOXQ4VVhzajhEVzVxcFhjcjNHc25U?=
 =?utf-8?Q?cdpKdT8U60p/VgfQPMXpQBaVY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fcb97e-bdf7-420d-c9db-08dc383082e1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:40:18.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XekR2B8bxeu1OCItAeEuj+M5M7UYcq5WVA6T1b5fwYnUvccdD1I3sGdeyY0pUF9yN5/hvD49iqcd//8MuIyBWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9015

From: Peng Fan <peng.fan@nxp.com>

i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
VPUMIX, BLK_CTRL_NETCMIX in NETCMIX, CAMERA_CSR in CAMERAMIX and etc.

The BLK CTL module is used for various settings of a specific MIX, such
as clock, QoS and etc.

This patch is to add some BLK CTL modules that has clock features.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/clock/imx95-blk-ctl.yaml   | 61 ++++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        | 32 ++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
new file mode 100644
index 000000000000..c8974b927bee
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx95-blk-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,imx95-cameramix-csr
+          - nxp,imx95-display-master-csr
+          - nxp,imx95-dispmix-lvds-csr
+          - nxp,imx95-dispmix-csr
+          - nxp,imx95-netcmix-blk-ctrl
+          - nxp,imx95-vpumix-csr
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See
+      include/dt-bindings/clock/nxp,imx95-clock.h
+
+  mux-controller:
+    type: object
+    $ref: /schemas/mux/reg-mux.yaml
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    #include <dt-bindings/clock/nxp,imx95-clock.h>
+
+    syscon@4c410000 {
+      compatible = "nxp,imx95-vpumix-csr", "syscon";
+      reg = <0x4c410000 0x10000>;
+      #clock-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
new file mode 100644
index 000000000000..09120e098a97
--- /dev/null
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX95_H
+#define __DT_BINDINGS_CLOCK_IMX95_H
+
+#define IMX95_CLK_DISPMIX_ENG0_SEL		0
+#define IMX95_CLK_DISPMIX_ENG1_SEL		1
+#define IMX95_CLK_DISPMIX_END			2
+
+#define IMX95_CLK_DISPMIX_LVDS_PHY_DIV		0
+#define IMX95_CLK_DISPMIX_LVDS_CH0_GATE		1
+#define IMX95_CLK_DISPMIX_LVDS_CH1_GATE		2
+#define IMX95_CLK_DISPMIX_PIX_DI0_GATE		3
+#define IMX95_CLK_DISPMIX_PIX_DI1_GATE		4
+#define IMX95_CLK_DISPMIX_LVDS_CSR_END		5
+
+#define IMX95_CLK_VPUBLK_WAVE			0
+#define IMX95_CLK_VPUBLK_JPEG_ENC		1
+#define IMX95_CLK_VPUBLK_JPEG_DEC		2
+#define IMX95_CLK_VPUBLK_END			3
+
+#define IMX95_CLK_CAMBLK_CSI2_FOR0		0
+#define IMX95_CLK_CAMBLK_CSI2_FOR1		1
+#define IMX95_CLK_CAMBLK_ISP_AXI		2
+#define IMX95_CLK_CAMBLK_ISP_PIXEL		3
+#define IMX95_CLK_CAMBLK_ISP			4
+#define IMX95_CLK_CAMBLK_END			5
+
+#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */

-- 
2.37.1


