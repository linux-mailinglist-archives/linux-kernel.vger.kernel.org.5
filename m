Return-Path: <linux-kernel+bounces-126676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94135893B53
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B9F1C20BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C183FB0F;
	Mon,  1 Apr 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HLjzfmtP"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2111.outbound.protection.outlook.com [40.107.20.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A43F9DA;
	Mon,  1 Apr 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977632; cv=fail; b=m5s83A1ldsdAg3Bko9yLelz2sIggDHr+YrUt1kdGDwf0okXP54WMw2zTKl/r1SkC7s26xs9V9Th4kDU0Bg2/AjdV+uzoo88QJzu2J0XLCEi6HA5KjLQfSR0uCfZH9YbaMVD6d/hM4QCc8mZOIoy7t3gHmZVncaVqXS1LPei9Zy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977632; c=relaxed/simple;
	bh=2AK3NNdUGizvjm2pXgTrkSdOLr29w2AMddbicpf/qr0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pMcPzGwdGFT/cHTKk/jEtNeEkLfRuzmzVR5yUNep62y0hndY6MrfLtXnQtXe0fr8eqx9Baa6Gql6Sm3UnG1Mw9q/M5rvNjS4538bGoFWeX1XcgkRMbbGoJv/GQHsd1Mol8nxZFniKW7OrBI2Ge0NEWUnDk265gk6CkF2hI+6kW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HLjzfmtP; arc=fail smtp.client-ip=40.107.20.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCZRL8ur+GoYGUwTMBwDHlwpKeQCfI/7VznDZsPbeUhKNChb6Ucu7NXo82UCt/2OXbqWUnu/bZN1wC3PIiatVswW4YW/ET/nQTAB9aOS2kDs7jFt86WO/u4cQNsPocJve/x7upcwsN57bTJ8l6GVauSECGcNlGSngAPKg5ToCjKFiEPx9Z//hSMgprmltcGnZG5B95hKinBEZ8W1npOtqh4dcXM/a9ekNhw3WSFmdyVsNjTs7jX9IP1CeIkAeRDc5nCIRL7N2Z8GWsrmC28kWKGBiuQITvrbWJTtdXpfmS5Vd9DHSHe3lTyzJb5q7UJeTT7C4adYeKp4zO57auZ+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7rITPJGk/9+IEDfblEOyJleWX1ESWj3DMQucXC3tak=;
 b=LSD4CVrluqyy+2MDZ9G5kzzGz26eIOCgyLrLoBJn4YYkn2nx0X/Xm38pJpXhdY83zg6IJKjgz0Hn21PqQPL7cxh3JWHkxDdxQdK7Vt3ncOtR4cCUIoNjGkodBuLPoZQpfR72vDbNQ+Ky0+ABWoP7dLW47eVa8S+bKtXQZ8pxDDaethh0I+kD5+G0EZkONhVBWTw2ibZPBp4b6gtcRjv8T6YvvtYAZkcTrz3EQDjJVq1NDge6ue8KzzSP/eUT4qoaR6jSD3pMlX1NOm3P7mWtgfqJjZqEs/nCTKKGycPWWleQ+tMav1HQjnpulvU5l8vnERb1/YqB5d3/WKvEGE8boA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7rITPJGk/9+IEDfblEOyJleWX1ESWj3DMQucXC3tak=;
 b=HLjzfmtP7ZdncN67XTpTJ8joaV5tVEA/b2e67P07QohNRySV5fK1zZChwGRDSdp6IYl9FQ2VeYvtGuSLXDBW18Tqp7ejj+cc2NjGC8jhgJeT3KJa2jxBlxP6aq10EMlVWDQGT10+E/rU9LCWPD7dy4S9OBRQKC4XGjKtx7wFuuU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8766.eurprd04.prod.outlook.com (2603:10a6:102:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:20:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 1 Apr 2024
 13:20:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 01 Apr 2024 21:28:15 +0800
Subject: [PATCH v6 1/4] dt-bindings: clock: add i.MX95 clock header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-imx95-blk-ctl-v6-1-84d4eca1e759@nxp.com>
References: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
In-Reply-To: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711978117; l=1306;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=qWBlv66LWHeC+HVqzW36n+KByGWsiUyQrMNdCkAtaCA=;
 b=SPMBWNNa1CIAM+womM5Co/LDN4Jd8wZYaEZqmoWeGxfGODVGKuyFxr39IhWQ6iz3IQpXF7XSx
 xtUWPBoHnEPA+CS4h3ki1aJce0V4BZK++0WXUjSQEf4iEyF+lcbxc8w
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8766:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fQMU4rAfN9/O8smdwUiWya45Mn6jdvXPvxTqWxpm9pDe/4n2/UK7YPIfOT/HH0j2BRHHQK9Ik+bED2JKxLXuWm/l/Qhq7VgWSCpuZMtnjLdVW23kVXO76tsLc5A6QgdVPyE31Uxia2MpWfB+QHXkXJIN350I1hjIRuL9dBpOo8L9zQDdBtqiGYleRiUP3/uHAV80RME20HvON1u3ACViOYA7zCn6TVUJQKXDNFPD/ZabDF9O9xfUXZYyf2XyTx8TiJuoQXjdLNr5UaFVIGqnhwKNYQx2zkbrHxxw95N425w0uK+h4dfSX1EdlhJYCowC1XtfKwx7Ql5ispFH6zUabnhFIOFXuZLr4xI4/QNgmKk4gBUE+tJLovdiWbTRq3lvSg92j0QHVrcz09tXwmM6pXPXHD1BToGP8vgMO1QVWTnlRSx3muYpK1wV2n8SolLeIUMh1ZskdT5FPJgqAU5rq2b4ym/GxNYstFJmakN58Y3l79pji59AF9rPK0ipzZqNB4yjFV+vYYQnAu5hx7ZeeUMywr/4WlJkG09RbsBGrWaCJQtDdXN33dgDqN2nvqOsRQKbEaekohkNwwNbHW37D49D+l9//u9JsBXLDiut/Lk3G1VqarWTnj0+/IMmsaQLRBz1cfyUoBaISygf9MNiIfZaX4dBUEPOfk/ULAXRrWummbOTTHwH+PfdjZ6r6KvkELQ9jkxWz9LgMqpRVPTkxXo5q3sC/cwXoxVjcK7l3R4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2wyMjliUnJsZy9EUFp4U1FTdCszd1NrQVhXVllUd0dBZUNHVm5rMmpodmpi?=
 =?utf-8?B?QkxpSFB1aWtPaTFlcVNqemZkb000eEczWG9VdWFVaXRVWFhnOTV1Vk1oS2li?=
 =?utf-8?B?YllHdEFqUFpOMEJnUWZiRnZ2amhvbkNzQXN4VTQ5ZjlYbkZvdHJtcU93L3l0?=
 =?utf-8?B?Y25OS28xVG96VW54N0VRQ3NZMjk2MVp1VDdIOGtoSUhFdUFDK1V1YUVic3dy?=
 =?utf-8?B?bmhNL0ZsQ3A0WEhNek50bmJVdWJDb3lFZUVNNTd0cFJ3ckZrekN5bGlXNzh3?=
 =?utf-8?B?OTdaWEZTTFV2d2RxbnN2V1hJMzhJQlFYT2hVcW1YdC9rUTZhUThGWHF0R2lF?=
 =?utf-8?B?bFlTcW05bnJwNno3eTRqaHJVWS9sUk01NkRSWm9mVmh6M2dISGtVV3hCa21u?=
 =?utf-8?B?M0ZNOGtNcjBkdzVHekUrQXVkNkNsSkNWNkhxMkdpRVhBRDEwdllxWnpQSGdR?=
 =?utf-8?B?d0xXMEFhb2I1UVJVc3Izc1VqNVNseVRRdEZscFpJWEJwbFVLUGkvbG9oZzBC?=
 =?utf-8?B?M2JLSVovUERCc29ESlkvYWFLSmtZQnYvcWFWSmpHU09ieHBvZkFpVG5yeFEx?=
 =?utf-8?B?aUNvUHQxWng4UXNNUFFDdFhFbUFCTmZlYnVlKzlsK09qaDMveWd3V1hFTlkz?=
 =?utf-8?B?eTBaaTJvUW9sNE1vbU5HWHpJUDBaV25mcWs4WGVGTjYwcXpmemQySlNpeHBF?=
 =?utf-8?B?YVQraGRidXJ5ei81S3FiTmJTSHIyN09mOTA4RjFKQXhYcUZpclpIcGt5MndK?=
 =?utf-8?B?TzE4aGxxWjdJbTllMndidEE0SlM0K0lyOG9zUklEQVJWdWtjUm5vNHhWbk10?=
 =?utf-8?B?YjdSWElDNWpQY0NsM0Y5U0tDTTA3cUtWNm9kQ2p0UEp6NlplQWxpZFVHeGFn?=
 =?utf-8?B?bjlIb0VUMFFCdzBMbHNXd05hS3FvRnZlYWs3Z0VlM043Tk1Tb0txaXZlNmlY?=
 =?utf-8?B?djMyL3JVSVRjNlpGd0l2WnE1TGxleHd1dDV5OHJpQnFDQ0hyS0QvRE8yVyt3?=
 =?utf-8?B?MEh6T0FTNHZYTTkzMVlDb2hnL2pxSFdxR0tCUzVLR25BUWdzSU1pdzAvQzQ1?=
 =?utf-8?B?STRjV1hPRHNpdXQ0Nmh4U3ZYRGd4eDJlN2pHQU5nSW95TjhRbis3emJzeDk0?=
 =?utf-8?B?ODNmUTZxTmdZeWpyRmZFdE9xR1JBdXRoRDQ5K0VDZjdyS2JiMHFXamd2TUkv?=
 =?utf-8?B?RHN6UWc2VURhZXFyaU1rZUZqVnZWTisrMm5pMlcxUC9iTzd4NnpiOU5yRVJp?=
 =?utf-8?B?ejR4MnhiZUd0czNHWk5BVy91akpwMUtNYlY3eXJYbVBnOXZ0dGo5aFRYK3Zz?=
 =?utf-8?B?UzBzQ2d4cS9JbTFGaUlqbmlyeWx4Nzc4dXNaMitNcG5JMmtCNEpQTWVLQWJU?=
 =?utf-8?B?V2tFQkQ0c2hJSko5S2hkM3J2K3hpUHZlTTNWL2M2YW01VVp6c3VhT1RIaG9s?=
 =?utf-8?B?ZlZCZU9tbWJiTjlBT3FZbkxvV0dnOVNxK2tubUlrOFEzUmNJVFNINFdrZVpP?=
 =?utf-8?B?WXRSc3JKNVB1Z1kxSW84ZlVBMDBOZjQ5RlJPT3dQbXBMSjJ5bU90QWNISmcz?=
 =?utf-8?B?STVjWXVHRlpCZnc3UkR0a0tFNVhDOEFhUVhGM1lzMHdVSTMrMzZPN084QjdJ?=
 =?utf-8?B?ZzRDdU9hMFZIVmxaWDNXRUxHRGNibjUvT0JuRWRsVjJBWVNNRk9CZ0o2a09a?=
 =?utf-8?B?QUg0SkdyZEpNNU51SDVoTm4rRjBGdEJGZWdVZU5EdHR6Z3V5RmxhTUE5TUhJ?=
 =?utf-8?B?eW1pOU9rUEQyVXArRGtrT1VGZzBEcFl5Q1lKazU4QTM2OHlwcmVhTVJqNitJ?=
 =?utf-8?B?OUNWVFFGYzlMa2VHWFhCUEtxL3gvOEJiRE1SbFNsbU5scjNsS01xby8vZ0Vu?=
 =?utf-8?B?VTk4MFNFUnhJZ3BDSDdITVdEVFJOYU1qbFdzOHNvMVJveUs1dVE1UUFGWDBT?=
 =?utf-8?B?anhSL0pmSGhUZUE4OVBPSWFDdlJtdG1pTkJyd3RYNnNSY3dUMytZb05nWFNi?=
 =?utf-8?B?bG1IaVlFeWx0czc1TUpBb2ZKcjRBQTlFMGVKR3IrNmpDL1Z4cVRvQzd6M3hv?=
 =?utf-8?B?anNDaitJTXFUaFYycEVCMHFUeW81QXZRVmZ0TW5NSXI4R0Fia0JRN2l0ZFBE?=
 =?utf-8?Q?pGwemgCxMay9BIJvhsCbwnCRv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1245452-25a1-443d-1308-08dc524e7eec
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:20:27.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RDpYlE8ZaShH3IJnyeg2JiowLYilF8gcAdX6dWIJtcta5ZJy2KmVKerK3SDJpJ1urhOko2G7VHjGp4tPdiYPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8766

From: Peng Fan <peng.fan@nxp.com>

Add clock header for i.MX95 BLK CTL modules

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/nxp,imx95-clock.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
new file mode 100644
index 000000000000..782662c3e740
--- /dev/null
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX95_H
+#define __DT_BINDINGS_CLOCK_IMX95_H
+
+#define IMX95_CLK_VPUBLK_WAVE			0
+#define IMX95_CLK_VPUBLK_JPEG_ENC		1
+#define IMX95_CLK_VPUBLK_JPEG_DEC		2
+
+#define IMX95_CLK_CAMBLK_CSI2_FOR0		0
+#define IMX95_CLK_CAMBLK_CSI2_FOR1		1
+#define IMX95_CLK_CAMBLK_ISP_AXI		2
+#define IMX95_CLK_CAMBLK_ISP_PIXEL		3
+#define IMX95_CLK_CAMBLK_ISP			4
+
+#define IMX95_CLK_DISPMIX_LVDS_PHY_DIV		0
+#define IMX95_CLK_DISPMIX_LVDS_CH0_GATE		1
+#define IMX95_CLK_DISPMIX_LVDS_CH1_GATE		2
+#define IMX95_CLK_DISPMIX_PIX_DI0_GATE		3
+#define IMX95_CLK_DISPMIX_PIX_DI1_GATE		4
+
+#define IMX95_CLK_DISPMIX_ENG0_SEL		0
+#define IMX95_CLK_DISPMIX_ENG1_SEL		1
+
+#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */

-- 
2.37.1


