Return-Path: <linux-kernel+bounces-103286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1A87BD7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DE31F21CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC74608ED;
	Thu, 14 Mar 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c3JrFo5e"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D46FE17;
	Thu, 14 Mar 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422267; cv=fail; b=LTwefnlIG3At/n68tX5mJ0h6y3Mmja6UVwxP0ONkqZh2E/Tdc2UFLX/9w2Rdv8MDv3irkrGFq2Yxzfs+Sn0urQUEiGbGU+Elu+WlTLiATKoVMfUk91WnNSBzn+A5B5NBi8IKvds14XGWs1JYSxZJm3+9eQVxlehPUf0btRyLLlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422267; c=relaxed/simple;
	bh=tvYViUIbTDid4Z3f52ufjF9u84Zzsm0G8UO0Xsm67dQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WxLsYnVWrizCJh7WalfQSn4AAPk5SR5fRHOZJOsh2jFRIV1k6ICYya9jkCQoXu2l5cAUOXjjTkQXVkUR5sGTx03zStOOlSt9KaUJv7xO1jUhOVwaPOzFV6N4AL6PQNofOINGjXZE3k7YKYze+aUS/q0/kP/ktRkM+m3ROeWutB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=c3JrFo5e; arc=fail smtp.client-ip=40.107.8.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9M2PHsegJScce54OF+snn0d38Qtk7TDInK5fezeUHrdASYHan5jF7IOpTZUIHt55DP4J1zAB0D1xjLUzSFFGuz++cU8zYV9qYKSyFQTj52p8q2x8bgdXaYdAWvYQyTMlYfvmyseF61HS752G0GIn9zep8FPr5Q7JUYnCfvxwi03Q+Y08oWyYCOBQoXAeKpxmoL7kER/8eA6nGFKjADsgRZ+p5MV9YkjuGSWROLD4+ZZ4nvCTzLOdXtTeRWzTYeOD+bCvp144wovhiXwzSxLEQ63AgmHrOaygNqEZlrKnySEzqirDLZGo29cGu2Dygzr8BqSUAY6JR+wFITECxLNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW+4AYAvZQSkGDIj7tq5Zshnwji9hswWack48oYQjRY=;
 b=J2w67VKY8qE/qHNXZGGH3W9+lSTvq6PU7ASGCFm7dVUhCGGFQkJTCWLmT3I7SX6S4qpAHmtGe+nFpIPTARiLgYxJtwkEW4/WK0jN8jIiPv6CIVgCxvrNbQzEw6kEqVwgaP7cpZlBy9/9GIUuftez6crepq8M6i7BiCzBVeIVv50bMbHabAWlHYvk6YBPPZBWi6kSQfPkVktvR4ECPcB9L3/QcCXxKcirifi6qvuMQ4hKXyqkDAxUWjM8tQ4v4R/8AM/ATE/iDsrC9nL0PcjQQcddoK7siLfx31cf5P0k50j7g6+sOgrz1hzs29DVd8QFQ56lWHqqwYlJmvsxhM9CGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW+4AYAvZQSkGDIj7tq5Zshnwji9hswWack48oYQjRY=;
 b=c3JrFo5eIdhtnKn9g4I3+PUzkfaHzZ2K5iGrTt/5KfXIaJfLHhuereLxJ8uHfsMPUniauoI9BTf4lzZv5kqXQfpeoHA2LO8I7bV93a8rtDILjSgodUdD7nna7akhRGFUJRlvkAdhL3ID2CgOhBfjGTM6hqat0ygBg+SCSPTZrvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 13:17:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:17:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:25:12 +0800
Subject: [PATCH v4 3/6] dt-bindindgs: clock: nxp: support i.MX95 Display
 Master CSR module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-imx95-blk-ctl-v4-3-d23de23b6ff2@nxp.com>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
In-Reply-To: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710422742; l=2095;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=LKYLMnnCKB4MgzS3T/KewJADSUUHZSkseLlKc8xEZLA=;
 b=x29dXCyItrhxXbgMwrSVYj9WeaPkASJx4Bz2t9PwjlvuYRIoHFWD0Do8ikxGbsKG6gOoX/u2r
 XQEHrMbbj4tCsysqWsnuZfl/gxUZ/HNPqrmOlR8H/9YKv7lX47Y9jg3
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f47e5b0-f645-466c-0dc2-08dc4429210d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zn8jp0gKO4v7EU7dJIOjSTKTPMIhlLopp0g2DdqaCIc+0GvaMp8b3ywxhL00L84itiwZq0jfSY0F9lal2E0kdJczV2loDBNzIoSssKTb6iWxq7uY+9axtHpPupsnIb887KZdUEF8w+7pEsnFaZYda8rpaZ+oZfenG2TacHYeWeUlsI+84K3c4I9OxY7yO3ab8pvn+30w4/eoWNs0oaEAiJXMKMbd2HLS51S/9OwIxQ5TUu7Ofniz/wrjbBuBYOls7CrMdSO61oTzqrmmlUlGWkjV9jPCQ9mdqhwfiEbWX2EHWUtA5fSxp7Tu7ZcBL0JDWUOTj3BMm+thnWBqTcdPFoWfoTlMXkx5Mwyy+z/rrKyq+qjMwa8khou63QCJpPkZ17FmmYnLrmwYib+aukkxPCfqsPF4fw4TD0pFJRu4RelU7t2Htega+2ctBIOTou/4iRSAkROwpY4rpUQmwbFU7t+v1zfBnJLPenD/GmS0B9R6BKRb1gCXCmuVEwtfwgpTHub3N9Fk8bAE1mBOgSdQK2z9jA2Ha5MeM+Qc6XyJHb9rldi4bQboQKaYfu0a5/rtRXZ+v/9GYnpCyjDHvhiiiahAzNGP4GI1f2a4MIDO8dke2cYTG2s4LfG2+53uoQXYXTC3D55zMw7n5m2igKYmysthpn65docUHE1eXLnN6HapBH3+vckacWSU443WWH7C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkZiR0owemluWjVuWG9TYmpsLzdzUXgxOFU2T2JRT1ljd1NBU0FyU1VIYzRu?=
 =?utf-8?B?ZzVsNlNPSE5nenJKYmFKcDJpc29URkJzaExOMjNNS0IyRFZ4ZlNjcVRlUlRJ?=
 =?utf-8?B?bjlJSjBQNHBUbVptTVVnSmY4VXE5R3l2ek50VlMzZks5a0Z5UTVheVQwdnk5?=
 =?utf-8?B?aURvWWtkcmJKUjhmUWVaREJVNzJmdGN2V1hyM2JlL01Yb0pxajJPb1dNbzMz?=
 =?utf-8?B?SXVSWER0MHZyY2k2VTFqVG9yRllSQm1VYU9kMEQyVklRVEdiOU9BalV1Rkxn?=
 =?utf-8?B?blNIbW5rdFBvdnpaVjA2d2pUajB5UjNqT0d1RExjbnA0bWt4bXRkbStWazNy?=
 =?utf-8?B?Q2ZZcG1tWVFBMlpmbk0vcUFmZHhURDNpRis5eWNmVEFCR1cvZHdUSlFTN3Uy?=
 =?utf-8?B?TUN5ZHRlMzFaOGxVQlFJTFExRTFDMVJ5RGZXaXBFZ1l0cWZwcEF4VWZOMU1T?=
 =?utf-8?B?TFhDeWxWdXE5dURwZVp5dzR2dXFSNHArYzNBN3AxZ1ZwcTlZZXVHM1NMZTFU?=
 =?utf-8?B?d2hzY3FpTXQrYXByR1VZOGJvSXA0Rkg0Y2JBWDgvMlpPNnF3aGdUbXdocG5U?=
 =?utf-8?B?TmtpaUlaSC9WL3FVbXVmajVuSlFESjFCVkxkNVEvYi9DbVhpTXJMcWNiODZQ?=
 =?utf-8?B?V0RUdHgvdGRFZzlJOHFubmFCZC9PM3J6alpmcjBqT1Bna0tiT3dsRlQxUnBQ?=
 =?utf-8?B?UElONkdnYUFoNnVzdzd5MHZaWlhxeUlmdHlwV0s4TlIvL0Faa3NhVDFTTFd4?=
 =?utf-8?B?cWFCTmYvUkNKSHZKT1c5RTZRVFBKYmxhNXFwWXI0ekhLcWxROGgrejlmL3FX?=
 =?utf-8?B?cVc1VGVaQS9wSmpzc2ppU2NyZ3FWQVVlSmNad0kvdXVTK202akNtOFAwcU8y?=
 =?utf-8?B?YnhJZDVYUHI4TzREVWx5aVVXR3k2a1dhSWNsa1o4UGNTY2hlek9UbGNlbndR?=
 =?utf-8?B?SEtyZGx5SERaUVNZOEdQWkNOejQyNnBUTEpMcXJEZEc5NjZubEV0WU9UbXRy?=
 =?utf-8?B?OUNKeW13WjlXVWRDQUJrOTUwdm50QUFhSTdKRnRLODRlcWhHRCtiRG9KRmRs?=
 =?utf-8?B?NzJNUlBDVEJOK3QrMVpsNHpTd3pIL09mVzFxelAwNkgvVks3bUNNajM5eUY5?=
 =?utf-8?B?WnllQUJCSzBBTE5FQkpqeGlNWmlMU2VJMXFXTWhzVkR0Ykd6Q1AvUUJCeTcv?=
 =?utf-8?B?S1NadGJ1WFpObjMxam9LQ2JSaWFPSlBtemlGNy80K3pMamhETzQyQTNycldM?=
 =?utf-8?B?blpIaDN3emFMTnc3bXQzaVo4QlpsdXRWdzBZdE1RWlE3TEdLcy9Xck9sT3lh?=
 =?utf-8?B?YjZZSEY1WUIzSGJDUXpWY0hnM3lrb2ZjVnpaSjh3TUVmSjM1VDJDL1pFWkJl?=
 =?utf-8?B?c3dod0JCT3JFdG9EKzRnNklGanZXTXJzQTF4UFk4TlYvcG1SS2FGbjE3dE8x?=
 =?utf-8?B?WitpVU8vVnRFRzgvOE8ydVMwUTUzaXBuZWYvMGlOckpFSURLR0x4ODVBZnhs?=
 =?utf-8?B?MTJHRzVPV2Uwcm53aGpwZXRhUHpiNmZuN0k4RDRhTmhrekNuUkJsb3VVOTcx?=
 =?utf-8?B?aXU1OHc1UFRheTJiVFBlUm5CTTdGQ2t5VEFwY1ZNZ2ZrNlhWelBIZ1hZZTdv?=
 =?utf-8?B?bGlQMC9HYVhNUlVXMEFsVmlZaXRGSFcxdUd2eW5TcDc1SnFsZ2ZPNENJekVa?=
 =?utf-8?B?WnQ1VTIrMktQdGF1b1gxVFV4VmkwaGNwRi84TTRBQzNOSkdxbDFxTDFIdi9C?=
 =?utf-8?B?TjRaVENiNnJkRVNKKzlpU2dydllmQ2RFeGdQamMwWnZDNmowV0JCTEdvOGxY?=
 =?utf-8?B?b1ZHd0NFZlRXMHg5R1ludlJKNnV0Z1cxZThlcTFZL0ZYR3lkVzRnL3Z2OFpW?=
 =?utf-8?B?eEE4cUd2YjdUcEljaWVacm1Cc1A5aHd5c3pyTXB3SVMxVmNULzQvNUh5K3M5?=
 =?utf-8?B?TjQ1dTArMFFPU2ZEZlppaUNHaEtmdlZaUnlmOEViSDJmSFZPaUdZSWVZblNF?=
 =?utf-8?B?SVFhL3pGbjVGM1ZmQ2Rnb1RDb1d4VTNOdS8zdDk2RTRpaEQ1eE5OZnVuMUtS?=
 =?utf-8?B?OUFWREt4QjFMNlFzaTJEUUdZc1RzeUVHb2tMTzZncWtCK2pFSHN3NVpoZHFo?=
 =?utf-8?Q?KZJAh+P8oY5GdGEPkOjiV96Tk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f47e5b0-f645-466c-0dc2-08dc4429210d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:17:41.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Y5WsWKmEfSZBxh9xc/N63AJX8GV96uS8kICDruSk7nlUNd+99Ru9ZxV5LaCWtuQeTgCqDZQ2NXiCFrjUMnNdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806

From: Peng Fan <peng.fan@nxp.com>

i.MX95 DISPLAY_MASTER_CSR includes registers to control DSI clock settings,
clock gating, and pixel link select. Add dt-binding for it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../clock/nxp,imx95-display-master-csr.yaml        | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
new file mode 100644
index 000000000000..ed0ec3a24d09
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,imx95-display-master-csr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Display Master Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - const: nxp,imx95-display-master-csr
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
+  - mux-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@4c410000 {
+      compatible = "nxp,imx95-display-master-csr", "syscon";
+      reg = <0x4c410000 0x10000>;
+      #clock-cells = <1>;
+      clocks = <&scmi_clk 62>;
+      power-domains = <&scmi_devpd 3>;
+
+      mux: mux-controller {
+        compatible = "mmio-mux";
+        #mux-control-cells = <1>;
+        mux-reg-masks = <0x4 0x00000001>; /* Pixel_link_sel */
+        idle-states = <0>;
+      };
+    };
+...

-- 
2.37.1


