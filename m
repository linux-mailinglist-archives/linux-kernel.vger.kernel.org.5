Return-Path: <linux-kernel+bounces-103288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2488887BD84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4B1F220E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CE870CC5;
	Thu, 14 Mar 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YmdwgkJ5"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB46EB46;
	Thu, 14 Mar 2024 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422277; cv=fail; b=BgZ8HWnFSJVbQcUZyqSxAZUOLoJ584Tb3hOwl07+oXWliK/KPSPgdfrZ87+XTEtZ1SICwrT0qdnz61AMuNUlhTWR4Xp22rOgLZJmIOy/8iHLU0ocX4WsrIsLqftDLF7wtBccAxZN4Epo4SgiypnyKkQKz2jiP92zSjVhNLSo2lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422277; c=relaxed/simple;
	bh=sSK8gjyJnvW6e4a+Q2EikU+ow972rVeEv2ldkP+6QDk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JHKbs0u5bsPgPQkad+sw9G+uBM+HMwDqm1Dd/T4NVzfJxjDb3c7Q82k2hMsYg35JeVLprFe/kb1UaVhvw8FeLM+CDFevhdA1QndPH9OibrAmCl0iBE54v3IXLFcjaLdDe9MLYXvjNum1Hby9MuPq1edHUEiftmgQN5qZ+QFHc3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YmdwgkJ5; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gt2Jq+YK6/gnQWT3WPj+F0KFLMHPhawNndKOzNn6/4nTYQTofAfUQyXVb3BVpDScwuQCYDO0GCcOoX4isG6/l4bDJQvatvuWI7rIpZhlgkO7qFQ0z1UaxIwr1444dKu44zHdGG5FTGX/632iORZa6C0KtF9QnCAI4bIyzF/jMfvS9IGDfE0r8q50ylNGyQ6G67gzG1tHG8P+l2tHj8X3uw5VXkm1hQRmhFrmEJSAzmWvvzZQbVTZPlZvUgpyDgfIs93k89CXITRTdVStB74xOnwgN94Eg/88nR+5xVMxoQk0CasXLj2LLboOiz7T2nOC5yjCKEJSp+U7vIYxTzPBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXMqNr2Thpwr7yrmrWKRTfbmLVbzJoH9mHa6ZiT7qIA=;
 b=NHbZPyLQazbnjIubmIp05QknlVoHjG5Uv3CA7w37W6g72yZRvJFoWVmaK4YyWRvToGisk4YMoY8GIqgVIs8WV4ZWxLJHJcEMyqVworvSUstsnIWqQFttsq+VI32U6SAOasKe00n6ymsY8qQOlJ/Rg0PZG30D2NCOfSl7XMGr2TaWATOBx3fcX/pTXoBPzPk0IHwJ4Uw84l325llA/6TzoPeiJAfak2ap1YTO5JXKXzVuqiN4CxWVDIhkwEpkxlJfDrphtW8SqCTz3fNEYm7JWWaM0/aEqCjYFJgqeZw60tygKxJlWEXbPV2WoTA4F41ZAIMYTlK37Pfp/4iWWwZfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXMqNr2Thpwr7yrmrWKRTfbmLVbzJoH9mHa6ZiT7qIA=;
 b=YmdwgkJ56VNdzB25DOFEnnMtiM2nBEx3tZ8mTUSPW5n5ryAp2iQz1hEQGC5krO61SvnCxJcweC3ZEW/qSVCT1vaflpStgpIg4l4YdVKV4SgS49yWCFwm1PbGpVXFRVqvmkn9lq+pnu+tV81QTjVX/B5x0fo/jqD0PG97vX0f3qU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 13:17:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:17:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:25:14 +0800
Subject: [PATCH v4 5/6] dt-bindindgs: clock: nxp: support i.MX95 Display
 CSR module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-imx95-blk-ctl-v4-5-d23de23b6ff2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710422742; l=2504;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=XqFgEepwtB/bROiSRZialKF+ubq+o/cNyZq02Ud6c/Q=;
 b=lP1flMguI40d7OFmUzdMDlQtNqqborZdq4jNFfBso/3t332L5dmTFibQfndG9s7tushhpEk6w
 ZQmFd2ZJfg2ClmGWlPcIaZHeyuvSJcrAoLmN+7gHuhcBHwqqiC9bter
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
X-MS-Office365-Filtering-Correlation-Id: 40e360b6-6ccb-457f-946d-08dc442926ed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S1RJUzF5jpLMdgR4/+A9xDwmCfneoPBzgAUqmcVhmQbcr9sk5/Rkkk549LhpknnZEwMMDdyDxrJ4PwiDVvk7GUGMM449UqwUNSQNd9skllb5x4dhgS7qx5HaY5Emf4cVFPSX/YqovV2HT2xIyu5yF+tOh24lgLkN84pA+mwJ+mYT3LuvhaiE6mFZyJCbDhqxdMsR1kFtNjqATQs7MZuBN56j/tJDEC6lwQXv5IL4Z+vpEwk27KAsbUwZ1l/43udu0XSoEwL34tzPBpjaADM27uDHO7KkYtJA7Bl7o7R5/oDA+GEqKnapk9KElhhye/EVQD+HqxagFShfEdU9ZWG3MSFoQYx6ckWfgWbmzNrCTwyj2BB+svHyp/AVF/vMxrsuLI97tWbQgIpfJMjpZImZJcS36gqnlOifeJYKd4TgEsHfvQZGSMqtTZXx2cYGcQyWfs6vEtAz/2ueqH03TtT6uWVafRGL8GOwmLY+qkN1bL4+uQctZB8UbcsA2W6b3zAM4Vf+VLnorW/teYk539MfIGQP9XJiwvhjZtntK48G1O2yDKq3ePVu0deUT3GFhUzGAMKF3BkfI7Ruaq2ZVmHOzAeNeCn7x3TMulXmh0ob84xbeP+2mlsktSPrzvvubPRYKy1aShEqe5KwMmH0MebTyaCi3B9dOjp18q0dnwitT7gcdoaAzT1bL7fvbqQPwB6K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGEwS1E2YnpHZDMvRG9GYkREajYzWmI4WkoxTTJKcFczUTQrbGs2WEVFcTBH?=
 =?utf-8?B?Z0tzNUkzb29tRmMxZG1MbUZ5dk9EY2R4dk1KUTRBcSt0RGZOVTRudi9YSXZk?=
 =?utf-8?B?MDZYMWFXMFRZNGVlelpiTG1rV1p5UGxpY1JhTTdqTGtKWUVDNWlYU2NxK2RP?=
 =?utf-8?B?V2JRYi9oRGRNbGNDTWkvbGtzM0gwQzByVTlUYzBRZG1jeGttcHlWWllIRHNt?=
 =?utf-8?B?eDh3YlMycWwwdUcxaGYvV1NjUEFTUmQ3TStEdFM1cklLUkFObnExNmdHN01m?=
 =?utf-8?B?RFBZNTgrOWxkSyt5aXdKb1pmN0wwNFlDci9hRUpYTHhZNFVOYkdOcnd4dzhJ?=
 =?utf-8?B?aWMwblNrbzd1Q2VJUjJZalE0YklLZG5Fb1h1Rk9EL1N4di9Id1prMU5GSUFh?=
 =?utf-8?B?L255WVh2UVlDaHJoeExBZGkrWFAwa2c2bi8vdTd6bUdaVnZjQ1RBOUdzdjgr?=
 =?utf-8?B?OXNWblBnY1RNYnBGdHR4MERYS1V6QjVNVW1DZkJ1SUtyQjJ5SE1uVTNFZGtZ?=
 =?utf-8?B?dDE2NE9XVnkwVTIzcW56aDhNalowbDJqRnBMZFFpL2RJZUN1NUJoT205bVN4?=
 =?utf-8?B?WlBtRTZkNjRRT2k4dk1WYlBUYTUwc3QyVGhrT1ZKaXFjT0pkbjE1UWcySGZq?=
 =?utf-8?B?YTRnb2VYUUxhRkRRT1NQYnF4OUtEa010bVdjcGZOMzhiNTlMcDJnRmFJcS84?=
 =?utf-8?B?KzBIbnhKNmJSR0RzV3dsbDZ3Z3JYSGRNd1h5RTFBc1FDTmdKVnc5aXowQ25i?=
 =?utf-8?B?UW5WYm9KVmtZbXNyZmI0SVZzTHNnUExkZXRvajhJZUxhcTJKOUhIUTUwc0E1?=
 =?utf-8?B?VU5OeC9vMzM0R3dxbWpXM01HNU9OajVDR3IwclpxZElPbFZYN1cwS29vUWdP?=
 =?utf-8?B?Q1NTVC9INzNUbTBaREk1VGY5eWxFMU9yOXJMcGtldFYwSU55U2tXWmFYSEJ0?=
 =?utf-8?B?N2tLWE9nWFl3allWK1k5OXo2bmRIZEJxVGtTeEZBbVNrQ0sxT25ackkvcXdu?=
 =?utf-8?B?dmptM3p2dHJTa0YrbFpDL0picnFjRUMyNEIyTjEySHBvRVhUZGtlWXBZTXBU?=
 =?utf-8?B?MnZBMThCQUdjaGdtVTJNV3lvcUJNWlE1bk9hSUc3cnBTeDdoUkRqd01ic0pt?=
 =?utf-8?B?eEhEc3k0aUdqUHg0M0FxVjAvb3d4djZQRXdmVGl6T1FVL0hySlVBMTA1VWxD?=
 =?utf-8?B?SGpSM2UzT2Urb2dIOGN5N2ZuQ0R5NElaamhlMGhITnFDend2K09IVW5kV0Zk?=
 =?utf-8?B?Yk52bzZubXk1MGNCMzFCV3lvTWYzVkNleFF3dldvQzFxRmNNNnhOVlhWUTNh?=
 =?utf-8?B?azhnQXpVZFoyelZKK3E3Tk5YZ05FbmdydFBzWitFQTBXMG9RRTVaeUZtNlZ0?=
 =?utf-8?B?OFlzWWxCWUI2Q2d3T2p4SFNnazF3bzg3YTNaMTl6MGZJSWNzVFd4NUtaaU5B?=
 =?utf-8?B?SFFZbWRxTWY2SEdsQTFyM1dlL1F6MU10SkVQb3hlQXdaaXcySXB3MTlCa2dm?=
 =?utf-8?B?eTk1ZkxvT0FDbG1jYkFqb0VodlJvc2ttY01TUXBCSTFQYzVDOHBTL2xqY0lR?=
 =?utf-8?B?b2dKbDYrdkhJUnRTMlZ6T1gxWVRiZFdEZEdGQUdFaDE5UWZXR2lGYW9FRFg2?=
 =?utf-8?B?Q1pKaVBST2NFSUV6OFVXQi9lQmFxUVNUMnZydHQrdEVuZmkremtQZldTc0Zs?=
 =?utf-8?B?KzYxK3R5M2Q0bmRMUTZsQTI4SmQwREhHZE9lU2I5T3JCVkthRFNSNDdBRHhQ?=
 =?utf-8?B?bWhzcHJuUWk4Mnp4dXpXSHRsZnVXWllJbGdYdjRYWnZTOUZhalAyR1FZQkJ5?=
 =?utf-8?B?K3g5eE4rNktwbkFHYkE4TTdjUVIwT2lFYUhpVllPUmpTeEV4ZXpTNXJtWXNO?=
 =?utf-8?B?VmxZdiszWGpPNEk3WHYwYkxkUm9zVDZRUUZEeFdmbmNSdjA5blZHWnBIUFB4?=
 =?utf-8?B?Q3pXS1lTN3R3c2RRaHNHRTluTFA2Ulp3K1ZUNzhIZXhwRURWeVo2VzJydldl?=
 =?utf-8?B?Y2xGVXZ5dVVVMW5EU2pqSXNzT2xwQytoU01NbXE5bnQxYytvR3MxY2doNSsr?=
 =?utf-8?B?dkhzTXhSUlVWWVhtQXRIUCtYT1NzcmM5clNEQkJKalVRSXNMK0xkaW8rQ1c4?=
 =?utf-8?Q?KyEf1Rdbitk6Zo8ttrx5j7doP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e360b6-6ccb-457f-946d-08dc442926ed
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:17:51.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgpmcz2ZKuPvftWU60S9oH+toJHYdAzh24CHUCDH3k3DP5Wcd1DL4LoL4sAYOnB+o+KWDigmVasmwzYqLHuBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806

From: Peng Fan <peng.fan@nxp.com>

The DISPLAY_CSR provides control and status of the following:
 Clock selection for the Display Engines
 Pixel Interleaver mode selection
 Pixel Link enables
 QoS settings for the display controller
 ArCache and AwCache signals
 Display Engine plane association

This patch is to add the clock features for this module

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/nxp,imx95-display-csr.yaml      | 50 ++++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  4 ++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-display-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-display-csr.yaml
new file mode 100644
index 000000000000..9a5e21346b0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-display-csr.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,imx95-display-csr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Display Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - const: nxp,imx95-display-csr
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
+      compatible = "nxp,imx95-display-csr", "syscon";
+      reg = <0x4b010000 0x10000>;
+      #clock-cells = <1>;
+      clocks = <&scmi_clk 75>;
+      power-domains = <&scmi_devpd 13>;
+    };
+...
diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
index e642a54c81a0..83fa3ffe78a8 100644
--- a/include/dt-bindings/clock/nxp,imx95-clock.h
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -25,4 +25,8 @@
 #define IMX95_CLK_DISPMIX_PIX_DI1_GATE		4
 #define IMX95_CLK_DISPMIX_LVDS_CSR_END		5
 
+#define IMX95_CLK_DISPMIX_ENG0_SEL	0
+#define IMX95_CLK_DISPMIX_ENG1_SEL	1
+#define IMX95_CLK_DISPMIX_END		2
+
 #endif	/* __DT_BINDINGS_CLOCK_IMX95_H */

-- 
2.37.1


