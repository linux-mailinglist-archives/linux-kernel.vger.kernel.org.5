Return-Path: <linux-kernel+bounces-103285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC2387BD7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2061F2197C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3015C8FF;
	Thu, 14 Mar 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="foMwpdKV"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CA16FBB8;
	Thu, 14 Mar 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422262; cv=fail; b=hak2QpCK78PYXtq/clCg8ftVvGF9+aTapKPrGNBH6Deza2gCwVwUBiGs4/8CBneApe3j3fAgY5zTJ8iSuQDpJyVBMSzPuP7h8yrE7Nw7ypR2tXVm64zbzawCvbjnOgGyYW1cUuVGEjbIbYrbP85lHpccirrxSUyLSL0XEL5Kh2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422262; c=relaxed/simple;
	bh=V7kjEr8z/ksjJjrvKkRb4VYngfsiraMsaNB9cU7M0EM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IE/AVgl51uRhJHMk9G4kae3JY+KrrjYoTQpHrTnIKVKTmK2zkoC/idAEB5zd5PLg/9qvIzUuny7paiPpulf5L90ALov7zWNaOuOcJZCVEDV3PNhkrnmxREDFr5rK+gnG5xL48a8rjy8ifAPoGujREQYT7U4rOO4h8mkwoG3C4KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=foMwpdKV; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN+PTq0BDFNL5lvOUX925mwf0u+n3+bL6gv0CDyZZkR9b4+w0+uCZmxV8J3P+VsSrM+YYMw1xprNrva6oVnwL5yoZGWtGa9kQdBGCxvqXVp2e4ozL04NPEiBoUvFbLrxFGbbIuciA6JbU0zQgg7zV46EKhBnW4rnK1EMOsNxUasj/WxJdYXLC6QCMQ2ZnKbWh62OBHyAgNvBOmDuVykA0vgF04p1Jl1egl2HB9L6saXhkm3LzkfcKsT/z5fESPLFG0z8msTKkipG70097Jedo+n5wh5Xi+k67NIaiq0KANs9KugZMCfc5vMjxin8RjWrkrg3gLOw5q+WFjed6Dns2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpzqs7+B5NwK2KjUj+ZG2uQtOANI6TEgdtbh0cbT1nc=;
 b=L5Gc+/on1fkkc01UKJ9acGSCCzLrpYyFAnUVXnamwAMVa7+72w1pK4lMGZGtdPhP+gj/h/C/yPzLvTYitlPmI6FRgc7Aid9nuTXENwMvVT7cY+Um9/wJkO32V8vDSWBj7mzHCtB/mxyvoVLJNKkWmnjtzQ+qc6/Ghm+394BOaLOZ8hGU2B3BV/rY8CLRqiuNzAGliCSaE88/2HAYk5rNfcb2rY4ihuxJAyfxshMXbX8QrCVZkyee9X26gnYkU37EKK7Eb3qw2EVtFd0+Yh3cA2IreKVTTPccYrkcczMZkdjQIM0xQQyTU2zwtgnZLe9Fgqf+dKEbd5kf3xEGx52Aog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpzqs7+B5NwK2KjUj+ZG2uQtOANI6TEgdtbh0cbT1nc=;
 b=foMwpdKVfJ3SU6jVedgn+bMLlx2MbG0Ign2TmnCxyJJCy+kDQW8ZW2ZgYW+b+2BThDD78RVXtadJ+knevmzBvIljpk3lFSIk9/3A8JpLugqVqJpUXNbj/3bcNaS6T9h20zYCR2MvNmbCxGom+GWeVHb/rBIIGd0mEolvbsrevMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 13:17:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:17:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:25:11 +0800
Subject: [PATCH v4 2/6] dt-bindindgs: clock: nxp: support i.MX95 Camera CSR
 module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240314-imx95-blk-ctl-v4-2-d23de23b6ff2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710422742; l=2772;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=P7z0swJT7PRGt/RAmx6moPJ3qMxKqwVy0GrmLcELtcw=;
 b=5u7Yb9YrFBzedC1TznEgaM0eVWCsRQDuxosTAGj7Bw/saNz7EMUD1LM7GIUm1R+s2zdyvnhgs
 8UrdFAG831dDqgoJyheT9fBVtvrDk69JW9CQL0rr2iIvGB8y1BwieGR
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
X-MS-Office365-Filtering-Correlation-Id: 82be0c0c-f619-421a-2717-08dc44291deb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c+tDPplS1pa6ZIPJyLvIChxw5cfp+TgswJWCTx2VFsorE681M37To1zry2wTyEUlkguwvtIgEKNs1P8KyI43mxImqoQbLBhNq/Ho6fDwk+jyHpyOeFrlP7dH/czs0TaS5cJ2QeukKeObCuPOAIZb6WZLy4p67QyO1WYrla3hat5FUnwH0YRTMXiIkSK2/golNf1M0nS5LsnHV4mWMvRwlfMHnosm4EBl7Fnp3z65pRVKe3jlGVtMyNgUJ6af/wrV4qFKROfxoqmMZpVkM7up1tAoesqCpa/rZ56MuxOfNLKWakJv8GiMtJjRnKAFeI2xSqvEkI/aI11EDs2zQnkpRMomInOVaBRkJ0zhEgIiL/0OdHbdE599wCRUHNKaxKfBYkrBk95S4driLshwK1xk2g/BrGeSX36b5MJBfODUzZcd73ZADZoHQRPYDzdteLvullpfF7LghcEtGl1RNZ6QOquD/nxFHUJv6V92f8b+X8PDzndo9l6xvOGTyB9AOpFZ9g5/7E73lPyIihB3hrXAD7BzMIgKpNRETS9EoijBxGz6921QpRbvLpOWCghh2YzsoQV5+KLos4SdkBkiIT9GprDaekH2ZASnNlhpVGrjusS+FGKMM+u2iNTtkRKKcFnldNwXK2iNWI6tjo7idlCHmw2U6fPqQk7u+9hcC31PE/RIPumaKsj70f5R8oXabUg9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3c3cjVsSi8vdkZmWVBZM3JwREU4SFUrR2FXWGdDV0RmblIvdTlLMk1NOTRF?=
 =?utf-8?B?ZDFSUXJJOVVxNXAwOGorOVVOM2dLeGQ0RWVSSEFpNkhYdTdFa3puN3VCcG5x?=
 =?utf-8?B?RWhITXZheU1zUmNNbUFoeVdjNE9ld2pwTVVscGtlUklBSjdTTm5WckJlNiti?=
 =?utf-8?B?TDJ4UzhCdXlBVlpla0lJdjl5dThnUVhGdzJjTzYxK05ZcXhONFhRZWpXRnRw?=
 =?utf-8?B?R1pYNGtxWmhwZDVGRG9pM1hyNm1sZ1FIOCtXUEdXSVBFS09RaEpYZlNkdGZl?=
 =?utf-8?B?N1h2ZjhUVFpSRnZGREM3WGVnYTRWL2ZaRmhsSnl4WFp3TUVYdGJUQzBrYVZX?=
 =?utf-8?B?TWlYOUtCcXplWTBsVDQ1Nm52U0gwNGh2eVh4NFNmYmJ4Sys5dVNWeFRGYmlt?=
 =?utf-8?B?WUV1ODAzaVg1RFR3Kzg0Qnc2K1Q4VGtGUTViQTloR01MZ0d5WFhvUEVaVGRW?=
 =?utf-8?B?SXNSTWVwdnZjaDRBNVhUMVZlOUpxK1ZtVU52Vm9PZDNXbXVnSzVWbXJrYk83?=
 =?utf-8?B?ZjVDYy9abE1JRjZ2cHJrd2hNNnNEYmhITEZLTUlrVlhwSmJybnZWcVNMa0wz?=
 =?utf-8?B?VGJjTDhia0ZxNHFWVm9PTDJIcWNMSWk1TXo4TTdlV3IvU3V1b1ZSNmJPb3Jp?=
 =?utf-8?B?clVySnMvbVJPMXZZOGQ1VmdDdFBuSEplNVVGcHE3ZHBJc0JGTEdzTWFWdVFP?=
 =?utf-8?B?RnR4cE9ZTzRyazhVOWZWWmo5ck5jTnZmb3RjT3BKN3hmT1hFSDJMMnBuZXpk?=
 =?utf-8?B?bU4rNGFIS1BIbnpxbGo2UWRnd3dITXA5VFUzeHlHN2lSbHh1MkJCK1BEOHUx?=
 =?utf-8?B?Y0szRm5xV0N5ajUxcVB4alBPWWwzZUl2S0ttT0tlWXJDL2lEZmVCU21NVnBU?=
 =?utf-8?B?cDBHWUhZdHNlcFdXTjZlbEtHb3M2RHN3dXhYaW1DR0pIZjVjaUxvV3p4SE83?=
 =?utf-8?B?WjFzdWhISFZWMjNTRVRsRVlmS1VIam1TTmlyTllFamxkNDYzTk1pekRRdWxU?=
 =?utf-8?B?bzVXM0JSS3M1VHh6K1FSaTd1eHpsSXp0bnFFY3NjejRBek9Pd1UyNkZXN0Zh?=
 =?utf-8?B?cWNZZTRWNFRHcHdmRzZOcDJZelpwZFlCNENtc1JaQXYwL1VmV3J6WGxsdlU1?=
 =?utf-8?B?M3VLcCs3d29oYVJycDNtWlg1S1I1dVpDWEJZNVV6bGlIazlJZ3FiTzNBcWF5?=
 =?utf-8?B?QXJsQkFNOGtSb2lMMVprWjdXS05jeGwvTW5OM0hrYnhTSmd2TlpsWnZhN3Rr?=
 =?utf-8?B?Q2loUnZNZnpGWXBDcktVWVFkaFpVR3Y5UTQxeFVveG8wbDlBZ015aGRUYTU3?=
 =?utf-8?B?Zjk4a0QrUkZIMS9GaDFXSjBEL2lSR25tQXhnYklaNUxwc0RXQ0JEOURLVCtK?=
 =?utf-8?B?YVRLelAreGM3Z084bzVEQUZkS3NkbFovVEQyRDhNYTBKd2Y1Y3N1TnRqb3ZI?=
 =?utf-8?B?N1B4WE9ZV0NvaUNnNGNWeklwaS9XdDVUWDdkWHJ1c2xPVEMxR05zL2YyYnRu?=
 =?utf-8?B?aGdFbEtXb2ZHUEx4bnFVckEybmZ6QkdoSWNXbDlIeG9TTHhsU1B6Qms3ZnlY?=
 =?utf-8?B?RDdmSXdhZkpIUUN1ZzJnaWdNV1JYVENLRXB5ajU1ZU5DVGViRTFNMGZ4bVNh?=
 =?utf-8?B?Qys1TW44cms2K0I4MnRBbnhFNytMaW9nM1dWUmNnMUM4a0V0OEk4UHU0UEJE?=
 =?utf-8?B?MExJRnkyOGxlcWpqNU95WC83ZGNNTHFhRStHTTYvbXUydzZhelJ5a0hxaWNj?=
 =?utf-8?B?V2JITGUyWXMvVHYvRGRucXpuY2swVHkzcjFsQkY1YUJFT2ZpOWpRM2w5TVJz?=
 =?utf-8?B?R3llL0RCeGtHQ2U4TVd2Z3JmR3FBeUJvRkFBWFFMSGF5dWNQaGUyNENUU2Ja?=
 =?utf-8?B?blNGczVzWUswbGZPcWwzY1hEUTVVRWZ5aTdMaEU5T0c3dWs0Yy9SMWo0bUhQ?=
 =?utf-8?B?QkxkN2JQR0NvR1A4V0p4RDhQZnhnaWdwWE0xWHRzcklYYk9PaDhtNjFablZp?=
 =?utf-8?B?N3RDOC9tRHFkOWg0dTlPVkUvWHVpdng0ekY5U1F5UG1ITFFVSkRBNk1TU05n?=
 =?utf-8?B?eVdVQnJSTGJkSDlMdUdZaFlTaitITURncnFuSDdKTTJoKzl3dFRFR0NDLzVK?=
 =?utf-8?Q?gHJCZoVRrOC0LowRTtXfkwdPm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82be0c0c-f619-421a-2717-08dc44291deb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:17:36.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uR4QpvTvjokPyDySxkkFyoct6WRqFmo0S4ZWuZq2vZwA2kMymmJ+aacirDruLTtnJdD4XmJiySQGt79BtECJJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 Camera CSR is a set of registers that provides various
configuration and status of the Camera modules’ operations. Registers
are available to enable clock gating to the ISP and CSI-2 pixel
formatters, enable transport of various pixel data and non-pixel data
types, control their routing, and other functions. Status registers
provide pixel data type error information and pending transaction
from Camera NoC initiators.

This patch is to add clock features for Camera CSR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/nxp,imx95-camera-csr.yaml       | 50 ++++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  7 +++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-camera-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-camera-csr.yaml
new file mode 100644
index 000000000000..e62494e3a8b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-camera-csr.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,imx95-camera-csr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Camera MIX Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - const: nxp,imx95-camera-csr
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
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@4c410000 {
+      compatible = "nxp,imx95-camera-csr", "syscon";
+      reg = <0x4ac10000 0x10000>;
+      #clock-cells = <1>;
+      clocks = <&scmi_clk 62>;
+      power-domains = <&scmi_devpd 3>;
+    };
+...
diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
index 9d8f0a6d12d0..c671c4dbb4d5 100644
--- a/include/dt-bindings/clock/nxp,imx95-clock.h
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -11,4 +11,11 @@
 #define IMX95_CLK_VPUBLK_JPEG_DEC		2
 #define IMX95_CLK_VPUBLK_END			3
 
+#define IMX95_CLK_CAMBLK_CSI2_FOR0		0
+#define IMX95_CLK_CAMBLK_CSI2_FOR1		1
+#define IMX95_CLK_CAMBLK_ISP_AXI		2
+#define IMX95_CLK_CAMBLK_ISP_PIXEL		3
+#define IMX95_CLK_CAMBLK_ISP			4
+#define IMX95_CLK_CAMBLK_END			5
+
 #endif	/* __DT_BINDINGS_CLOCK_IMX95_H */

-- 
2.37.1


