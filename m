Return-Path: <linux-kernel+bounces-126678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AED2893B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CEA1F21AE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2159740860;
	Mon,  1 Apr 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dYDWsBBv"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C73FE5B;
	Mon,  1 Apr 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977644; cv=fail; b=hrB66EpqZVINjB6iUCl4jQuDjnZUT5vvVpdioUNoJf66bGmivxcIi9l8Q+jY2/5D/IOPtwazqS4Q4rZ2O5icuvWjrMpEtcQroBAjXdJgrFQmlGQPLiOtN+Xh0bbBp18Tp7YUdmJHfYDoSHgruxNCG1zT2vhPJrWzJ1oWTAr2PhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977644; c=relaxed/simple;
	bh=yMU2tsk0bBYr9rrgjmOE3p/BduPSU3EY4JehKJ3+HHs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lT6Amrpnskcz6KIXP1LS+Kl6xYM1GnJsxj0mbklEu9jdtl75Y1g1A4IA1Zv0lk4T6/cMzVBtBaqCPKCoskIS71IX52qOQ5i7zc+5MeD54oTPYjiOsJoc87DiK2PpnJizgDpr5lHlxEeu+cZspcWpn6J7wVq0/xqwHkSl5C5s3ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dYDWsBBv; arc=fail smtp.client-ip=40.107.20.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5WPyjHudNSzuvLMeqPr4NYSXvVhMLFO/g/jkZN+qmMNc3MOXDgIiUwmtyEakfZQBHEELPIDs+SMqmiUXVHfAjvGV029uiCoXd5Wu7L5QOgTRyHTrCE3v62zNtzDNLRkcHmgJWgol9Um08NkuIJHQW0vNwXo+QLWC8K9Bjep/RCKP5NTQ0pAZgLBBRxu0VolD8h5+6U8ZhpCGi7+JQVAzhsFsbJSyLJ2QCxzZ9Wy9Y6ggWnravfsqBEgAfEWnRLNLpaVlHxGTAP6yRcyvG+CkTJCoVc2ukwNsICHX8zsiJZxUpWTSXHICr4abxE2jzfOaIVjDSKPYIsQ1IkLxqSdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR1Yc+MgmtBS/XMVpGHOILKAceGXdJoxEqfvvyRKRu4=;
 b=Bvuog13QX4wqziIgNbrlesHFUCczTEYP116mBHy8PYeoHV9v7p1WcjEdIa4l1z6aN04btONQkGnMHrSkvc05+ftMe+FmPFyrcc/5uY61e60j1p2i90BN0QvNagJavT5keooHvD3IZgCkflfQyhBDB7spzWld5YQJYHXBwNQY03Ofxxjly1BW/KNBtP79TuuvWIcHDtd/RtmAYOB/pDhIloqVCjyTFUNbBhcXwV+NbHdJlvF5rGLxMzY7Jlxn4lcKAYtITbmqdOgYuwd2kr7K89/+pPCDMzN2Z7kgd4xZjnnoUltgwzp5vh0ULNgYKvcHIep7HCSHKMojVcw4UzWqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR1Yc+MgmtBS/XMVpGHOILKAceGXdJoxEqfvvyRKRu4=;
 b=dYDWsBBvYPqIbocN7Zi/RZgIbF7wIQKES7Ps0rp+KSauvQxBQ7G6oUMx6TevjXtc+YRghWYvE0pd/1zplEyn0CDBkEAqrezgsnAg7ZkSPLZ7R5Ra8ffhSvSmlpdqq+g3MKdTu72D+DjYzheKOMPgEdCvML6Ke5XWFokJ3ea3xlI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8766.eurprd04.prod.outlook.com (2603:10a6:102:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:20:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 1 Apr 2024
 13:20:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 01 Apr 2024 21:28:17 +0800
Subject: [PATCH v6 3/4] dt-bindings: clock: support i.MX95 Display Master
 CSR module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-imx95-blk-ctl-v6-3-84d4eca1e759@nxp.com>
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
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711978117; l=2194;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SqNrvMy0o3qfLIxaorniLsoCwbZbaByT+N0zVp3UJpI=;
 b=yDRaY3CwXqKVhVmwCjceH7fIgTZiXxSvpkuqO39D91s+23cksgzj73ToIelBHZjBYyaaAB6AX
 Cp9WhFCBw25CMYR3iaI4sFoCn7bDwtJcHDl6aLcjgo5XIikAlf+6M9L
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
	nZ/14Khojpy+DCide3KvxVYl9qe4dL9XpiKaJNBZPuvt/CFTGvMxu8x41N4disG0HqKNr7CukWAgjk2dLno6R79QXFPEW7s3Oqn1mVeHCFngICfJ6gHGZoCQCakA/l37NttWXUXpXlaWG8tyt/5jOXE1JpSUD97sYd5SDpOakksjOsnDGxXMCUfmZvRxvYFrntpypzRIbkmhDfvp9j7mv6kxS3TYkRntpp6qxlQyotEXfcAI5/cxxfFSADJ7Qe29RDRjRIF7KlKtLIRBTfyD2fU9hx/hyhdWcKQ+KuOLq/FdkGd5eKy5siBxQKEDp70xWxvGNV2pb7xUa+QGoczKypAVJ0dyKbGadsmm5sM6Qu/Hy5ceLPnmmzk87a1o6xThDKo6V2U/bpTamuXmLk/gRlLRqulO4AT0WRmi7CpjtIIg1kXKf55F6K3iz1MMt8mXai2l3412YJ+bmsXQncXSejuRLuA1/I/P8AHILIPRDpw/s7TCj76tvEGBOe3egBaOnpogpWtV6m3Pdnn5Zu+Uy6uYmZeKNVNaS9Jn0+Eo/+NtWiaWnhFIVF3mappr9S+9H+TJNv7V7Cak+zC8ceAtCm8TcT8LBqujFATdZ/DMZqUVFSRb7bUK1Jr7i2yBc4CRKwdkIV2yw++tCAD5FNdikK3QEXOGIyfn0UepSavALfAtokcpu8PeF0schQEuaz7E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFVUSXFZUVhOVmo3SlJrbnk0MGJwTmxSL0gzTThXTTZmM2N0TVRPU3hCanFq?=
 =?utf-8?B?TVcwVXczMHh5MEREVlZ5a3ViMzljalFyTzJBL3lhaWV6Qms4blAzNmJDVVJs?=
 =?utf-8?B?blhUZkMwbnU2RkpCUFpqL2UwdUorVjN4V2VzZEpIajkvS1JRWE03QWZOemhT?=
 =?utf-8?B?QkpWb2kwOGUwM1RzUkNUaWlqMDJ1bi8zT1pOV3R1ZkdtNmhUTUFjUzF0dnhI?=
 =?utf-8?B?Z2huQ0J5S0xwM2lXZmxPcE5iQ2gvYVAwNnhEZzNrbURjNnptOWFONDVNbjdj?=
 =?utf-8?B?MlJkMW5IN2l4ZzB1ZFpGMGNQNkIzRUFQRUJMcWtSMHBPTVVmREpzUVplK3NU?=
 =?utf-8?B?dzBWcFRlRXFkb2Vja0NFS2g4MmpFNUFSS2M3N3VqeXJCOFpmZEFHcFlNQXBD?=
 =?utf-8?B?Q05MV2pERTkwdXpnY1VaMWJYR3ZUeW5kaW0xZ2lpUG5ndGR2QUcvM3VFOC9s?=
 =?utf-8?B?OXlhT0hkQ2IyTnl4a3RKV0d4TmlQMFZ6ZnJvdDdkVlZrVGQvK2kxUDNZU2tY?=
 =?utf-8?B?alJUNUJVbG5qOG5ZSzhSM2NxZnF1UCszVEJoUkJLVkp3NnB1TzBKaXJhK3Qv?=
 =?utf-8?B?N2hYRlhUU0lCQUkzUGRpSEJWT2c0dldKRFVlUkx5aHpVeS9mQzZuVnF4RlNw?=
 =?utf-8?B?ckZqSk9CL3JrenB3MmhZTmROOVlHSTVmMXpNYUdvVGF5OVg4UkZaWmxaWnhR?=
 =?utf-8?B?NGVGYnpZc2ppcHk3NWE2K2lBai84d3UvNHM2N1JwU3Rua202aXhiM1loMUh6?=
 =?utf-8?B?bzd0ZlVEa2FHUTYzUlBmd2lQblZOMGd4aWNTRzU0NXA0akFjNXpZdEtmdFQy?=
 =?utf-8?B?dHRESXVQckc5UFZYUkU4WUlLT3R6S1p6WnUrRk5CaHR5S0FXcHFoU3NndkF2?=
 =?utf-8?B?TDR5aGlUOTFLTHJjKzFmclAvdWZQTXVPYlhLYmRWbCtkcWhiRWxsYlZZOTdV?=
 =?utf-8?B?eEYrNHRPME9xa2p3WjA1VTJZaGlvcTVCVTVZZG9Oa0JvbWtPK1I2R2xKV1Jh?=
 =?utf-8?B?N203SGt0ZTJISjlRdzlJUFBZVU00U3BLQXcyUVVkWVY3dVVzTE9WL0UzYWww?=
 =?utf-8?B?Tm9xb3J6a3gwaTByY1FpclRvRkI0QkpkRjZHbnpuRnhaMklKQWU3ZXNLbEhy?=
 =?utf-8?B?d0hkR2ZsajVnbkNYMW04ZFU2OWxTUm9iN2xSU2g0cVByZkIrMmtQMnUxaFJH?=
 =?utf-8?B?MklsWEtBTytKL1hYV0RJT3l3ZDNqVkpTWGVJMGV1UGpHRjJyS0hvYlZmQkJU?=
 =?utf-8?B?d1NaVEtYUk5XMUw5RUx4WDFNQWZpTHovN1U5d09tZDlxWXZaN2xodkdTWXZ0?=
 =?utf-8?B?dTVCdTRzMzJQY0I2dnoyWEhxV21ianJaY3FIbWhERXRqcFA3S1hSSUQ2MVRs?=
 =?utf-8?B?OHd6VHErTXd2UkxEOXVTbnVEQTg3N0VhMEUvWGF6VlZxVEJ3ZTE5TjJKNHJ2?=
 =?utf-8?B?RW1LNU42MXdkeHdvVmdUYXFhTVorN0xXQnN3L2VVR0NBbmFLWHRZOS9JL1dY?=
 =?utf-8?B?USszVmdjNUNNZFF5azdYQ2gvVUNZYTZqamp1dzRuR2RJTUw0MjFUVks3bkdy?=
 =?utf-8?B?VU84cUZFdjBaK1BaT2JjVmZONnhtSFhWYXc1RmY3RFVFS0ZEdlN1TmVKVnQ0?=
 =?utf-8?B?MzZVcm1YZnN6RVI5UkRHZWlnMi9oTGQyTWtxdTJzZDRudUF2YzFZTE1lL1p0?=
 =?utf-8?B?TDNDSThoZnJtQ0lmU3BVejlqODVVWGRSemExMXdPanVJZFhTdjhPZXlLSTlx?=
 =?utf-8?B?VzVYblF2V3RleXk1VHd1RWdWM0Fjemh1VHh5d3lja3EwREdiQVJkYlJIVVE3?=
 =?utf-8?B?dTNwMUhJUlQ4MXVpN0g2eVVBaU5ZcTJYamFsaTNGeEgrVzQzTFA4a2pxdm5E?=
 =?utf-8?B?dk5wY29TWUI0U0p5ZElxMVZUalI3L1IvbnFlTWw5Y25sU25KUEpwaGdka1NN?=
 =?utf-8?B?aXZlZkJaTnpXNVBNTzUxQ3RqYytTS3dGTUxMbTBTSHJsYjE4VkxqMlRSd0dq?=
 =?utf-8?B?OGdmUCtaM1hoY3dPeVpDTG04REVOc3p1VVF2TUlQS0lIYVNMSkZwdjJmUi9W?=
 =?utf-8?B?dnhPZlVHSDNFZysxVkkyMVNJWHhhSkhtTHdFbjlaem1QemM5MURDRDhVWGw0?=
 =?utf-8?Q?rrYl6I/Qw5tPkV1Stj3RQQiSp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d78f0da-a8c9-44e5-25c7-08dc524e84e2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:20:37.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OctKSEl5QtCUwNpRzbxA4oeU21hLkYNxT/3vfT5/399MrnkeDDV2WAG1aimAuWXrH29xDMD5lofVjHSZWF3rZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8766

From: Peng Fan <peng.fan@nxp.com>

i.MX95 DISPLAY_MASTER_CSR includes registers to control DSI clock settings,
clock gating, and pixel link select. Add dt-schema for it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../clock/nxp,imx95-display-master-csr.yaml        | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
new file mode 100644
index 000000000000..07f7412e7658
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
@@ -0,0 +1,64 @@
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
+  - power-domains
+  - clocks
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


