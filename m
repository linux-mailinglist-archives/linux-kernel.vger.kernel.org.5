Return-Path: <linux-kernel+bounces-77610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C486080E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E2A1F236EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423E1C14F;
	Fri, 23 Feb 2024 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="arQqzowK"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3DBE4E;
	Fri, 23 Feb 2024 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650535; cv=fail; b=ETwtqlz3qL4EvvbMRtSEvrLs7pmJPv2WMM8ndDchTU1TFM9Erfg45g2AtSbyLLKvPWH3mCMDObC+2eUoGiv+3tUUwa+ZC9QlMWkV4haMLfoDWdfyBYenf7uB8fEdkzI5z9S3Znvq2dIH7EU3/KhW3GvCtNpFbz2/oBNXxwhhi94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650535; c=relaxed/simple;
	bh=Lp5urJcXxMhFvLEjMl/gU+u8bqJReXBFK776pK6/zCE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nu4tlgOZzhlvmEM1R/oUV/qwQgkx6vr4Qo8UkQGFCENvQU8v0caa6SjYpMrOQON68lgmxwuUW9UOw66rXZ3iTDgYExT11IPVlLCf8sDvERTaQAAC3QQYTUC5YS/ZvQoGNgpSCJBhYfJQmi1YzUqLlUPpSk6CuZtYEQSpNK8/orw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=arQqzowK; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKnQVsjuZPwmN+EcYeOyI5ZATNtd4DaTGSytUPNN/fK3eKDGPZh7W5Y/dkpg+lxBFVZ8fYqwiTyfZVUbfJEelJr4czPaY5avteRUeSDPiOjpudY55g88gGS45KQTZ/E0yAuN+6oym+T6jiK+4sXfddS3H1blWm1sN0LsvauHuSc4F3SjzTiLcwcGS7cAMd8EvnYZp4V8NbqxKd+Wv+MGdrTFsTCWE+heFjnzYeAMpwt7Gy1td6lRcZNRlqpOp6EcwctcX8VzkaNPqV/evKBf7rdioODdqCDibGrYDafWGFMpPF8h+m2vOyNhvjGvjzrHHBek7j4FEBzskrC0Z4yQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQmOgq15KqTro5dgNBFbE6fRWivw0EMchUXspHRUUpw=;
 b=OW90zeQeHd5s/hFRCNco3swJ2Ls5P4uSBkJ2jQn7IECgxcWF8i8jZN0aRSSX6vQOnbFRQLHIroWRjZv7GGLFdPKAzAxYoPqHfDwuMJljPsgk/+1rjG3aQhoSlkwDVJSf7uawSAJXyeVFypbFybaUOxaXSsTIwEj/rqGFtKtk6wwU+ryKgitb5nDQoQGZq0mBLoDovWFnBE7HInBXDTTWSIKfSCOCiPf7XptHMfNWKD/Yj6Qy+dUE+LnxHiDYEJmrEcL8PZALoooZfE9j6KQyJCZWv/IkUYl1L+KibsyAeb/WW6G4NnGkYk/6RSLzQP3CRx85rXVFHBEKfJt/fesJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQmOgq15KqTro5dgNBFbE6fRWivw0EMchUXspHRUUpw=;
 b=arQqzowKDbl/Xn8KNAlZeqUP4I/tgcj2Quadl6oVnvpLlHIEVv0BnQGa6e+XuxTcSjYhrfnsWWDIqmhsbavJaNCTIvrg9aPBfn9ELL1jgIIkidv6zQiKgQtXBlKKEcaEkjxNZ4GV8yMios7xRtvNm4WpTVfxU6q2bbJnjdz19w8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 01:08:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 01:08:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 23 Feb 2024 09:16:39 +0800
Subject: [PATCH v4 2/4] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-pinctrl-scmi-v4-2-10eb5a379274@nxp.com>
References: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
In-Reply-To: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708651021; l=2375;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xWNejZclzOUqKROUnFYHgVlFI6BqdpjzWE8+IpqHKp8=;
 b=MMWisZO0cIMNuCFhs4TThTvnZCbROjAupBO38AJhC9yOfNJECPOnjA4QuAQghVQUx1JuAlZpw
 I42xmfpmfEnAD0hgZlOqpKv7JBW4307RDQmBseoLNI5srapjBb/Zm7f
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: e9647205-5c80-4dba-4ae3-08dc340bfe85
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bJ4JFuWq+ts2ws4VMt47v31HqZ7MWLhs0sl/Frb1gZ0hXF5bbZJIyj5E8tNEtzkfRqzggpIy5MbMbL4YwtsxH+mTj9Gq/91tRol8WNgQlafGUoGu6E1owDjN48eZu6GVeBzTAjsXyfe7gMpATatKC7LjGyTtbJLBdFERoYBQ9UZHrgzmclsa9/tNzklsjN0l/wKTT6fsuGGQ28wrxRX9RaKXk8yQFMzDVHBbuz+FsfP7zNozVoX+CiGuu/krTMRpTFmJobnLPba7+SNTLB0MOe051ibyO+MI8T8g7EIdlFulZ/U0N+iJ6kRHe0l4JgRMz1Pc0SBdTF+OTCaw5Nkj9L3KsO2B3DQaZPFmp0O38NSrTC5JlbTxvdSpSd958I+/bQixNSbqTc5c7xXZPPSn4Yb0eArEFXdaDpu1c157zzrDjzWi7NLQCa1po6Mp8cPWsY1D52IbyfgsYcwFzcNoCKirDfQuAAYTjsg+QphcJeK1elI5otStYm3gA0Ch7A7N/82msUdgCJYA0Sv6lwAyeYVZ3+PkGfLygxzh/1DW5uPYzq+dmGpgPb2SZsO6xDENCnb6Z2arFn2GePjw1ELtqnbkuFYhPi4ZTKXoTWYWTt9ngTp2j0MQS/wu4C6gnoURUZAu1zmXj+yj0JSjajjamQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um01WVdnamtxZEtqY1kxc2pNNzhoL3kvK2ZaOGxOT2hTNk9sYjJINnExMmcz?=
 =?utf-8?B?NFd0QVppZTFRdFFRYXBIaGZ1aG5lMUhPaFVNbG9sOWIwaHUyZWZ0ZGdoaG1F?=
 =?utf-8?B?VFZmbVkwb3R5RzFNWGVUWWhEVjdQK3pKdi81ZXJxQVpBTDBubEo5VjFpL1JF?=
 =?utf-8?B?dFBhRnQrZkFCK2IwNFNVWmVvL3ZaQzYyVmdKYWd4TDhSRFdNelRLVU9hUkFJ?=
 =?utf-8?B?bEtvYnovcUI4aXdSdEpua0QwODQzTVdrbzgrUHBtRCtReWZCYXhVbGFIVmhL?=
 =?utf-8?B?dExYV1pnYUl5UU85dHhYYTFRWGFKUFZBM1U3Ui9DVTI4RENtQUpDbU5nQUcv?=
 =?utf-8?B?VmxMYzJTenAzbmF0VTBSaUtmUXhOS2hGUXk3WVBXeWdQeldmbTZ3VDZ1eG5r?=
 =?utf-8?B?TERLbC9PajhlVHMrY0lURzhWMWFDUWorcy92ZXQ0U3dxR0toUHFaQnJOT2dP?=
 =?utf-8?B?NjRkM2xDNmlFSHNXTFJvRUQyZGxKQzl3WUZ0eVZaa0NnbWdtcDhOSWdmNy9S?=
 =?utf-8?B?YUx0aVJuWUcrZ0VBWHd6Q2h3QVRqTENSK1VzQnpSb0IzU0tNVDE3elF4Ylov?=
 =?utf-8?B?VkVCZXRNc05xMHJTSDhMb3VNbGR3M0w4ekQ5UDhHZENOZDBtN2VleGlFdnkr?=
 =?utf-8?B?aGI5Y01ZU3pDK0U3bk9rcGxOWExTTFZWeHR4THhzaGZhMzhuRTZuaHdYU1Q0?=
 =?utf-8?B?RExJVXZwZUpMblJiWUJhSkovLzVOalZvK3lOd3Vydmt0Njg4SUZmbmtiMytY?=
 =?utf-8?B?MURGVkIxSldXWlc5TkJFeFN4SVlidFJHOXFqa3dockZJNEtmY2FMVGlGb29V?=
 =?utf-8?B?YzNJaTlBZ2E1eU9BNXprQ0lhc0JJYnRwSXFzRnIwVjM5SExuVVRWNThtOVRj?=
 =?utf-8?B?NGRDUTN5OFE2aXl3ejB3by9UYTdhcW0vRURPSFBPUHJSYnVoSHpJYkFtNlhL?=
 =?utf-8?B?UENETUxIaldnVFJWZWFzb1kxejBiMDFiTWpqaXpGNllCUTI0eEptWDhyb3ZR?=
 =?utf-8?B?V1NrbmRZQ1RmVzZ5QkYzRmpYTDNNYXA4ak5KYkFJNTR2N29Xb1NPOXhzNkNr?=
 =?utf-8?B?RVdYMEd3SUdHcjc4K1MvOVZ1cXdSbm9qTGE4Rm03bmZvZG1qWi9NSEdaMlBz?=
 =?utf-8?B?TTAvdnFtcWlWY0VTYWMxV25DcjhrVXF4U3VISlNtaEYrenJoLzVlc01LVkUy?=
 =?utf-8?B?OEhDQUM1ejR1V2FkVS9SN1RMMzg0cGJmazVUSlJPR29LaGlFVUI5S0lBTTRM?=
 =?utf-8?B?bVNJREtxczluYmN0TlRZVXdWamlSQ3Z0eUlFVkRISlBtWU94d3JHWDkvQnRq?=
 =?utf-8?B?YTlkQ1VBdXJyaVBDejBLc0UvZ0cvQk0wMzFVeHRpQmlHQzVoeVgzMHAybEkx?=
 =?utf-8?B?Y2E0UENIT2F5WVdGeVVWRC93VmlOZ1Y4cGVJU1dVZitvQi9nSy9WVzRjRldu?=
 =?utf-8?B?V2UwOENFbGpKNGhGeUFjdGQ3Z1ZQYVZlMTIzclR1ZksyQ0NUZTBudVNSU2xm?=
 =?utf-8?B?SkJGcVE2SjZnSUs4T0xMcGZYWm55eUU5d1RyVGdLZVB1b1RKVEFXQVNHY0xV?=
 =?utf-8?B?VEh0anN2a0o2U2QwdnR4MUY4Ry9Hcmh6SkMralo3emhUMi9vWk5uem1ZNTVG?=
 =?utf-8?B?bFJXZ3dTdVBIcU80c2Q4OXhlZ0dJK3NRZjYvM1BFcVB1RU5zQ0t5YnlYd21E?=
 =?utf-8?B?a3J6YytIbFNmR29yR2ZWZVErNDJtTlgybHNydXR5SmxJY3BqWFZDSjFVZ0t1?=
 =?utf-8?B?QUtxajducE9RbzA1ck5hbzlMVlNSYm5Cek54dGU1cFV5ZkdXc0FGQkRBZE5u?=
 =?utf-8?B?T2xDVmY1NGxzVHFMN2d3L3VUWTAybUtzN2tYSitvS2cwcHVvN3BVaTdINEl3?=
 =?utf-8?B?ZTJDaHlYZHZJRzBORmI4NCt0MldWWkxMTzR5SU94am9UOFY5azNJN0I4Qlhh?=
 =?utf-8?B?NEQ1RW9tZ3FVWXNGdmlNYy9nd04yTDVmMXdRcndUU0FNVUsxSzlxZlBISnZQ?=
 =?utf-8?B?M0R6dEQzSjRpMWFLUnFER0tzUlVtSWsxcE94aFNuV1lyNW5XN2cvbFRPRTFn?=
 =?utf-8?B?SDVTbFM1cEs0M0h2N1pMdXdmT0tJNGVqcWo3dlM4TlIzMXY1QjhoaWhrYXFo?=
 =?utf-8?Q?NzkxoXyfnUwu8Ucp6nScIMGdi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9647205-5c80-4dba-4ae3-08dc340bfe85
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 01:08:50.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBH104hGHyC2oWozvoq6hK4l0XNi3xzRjMJlkUe0fKK1GeiA7JePvnKasNwGF4EzyHjm8qlz4lmeUFskQEiU+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8418

From: Peng Fan <peng.fan@nxp.com>

Add SCMI v3.2 pinctrl protocol bindings and example.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4591523b51a0..bba4a37de6b4 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -247,6 +247,37 @@ properties:
       reg:
         const: 0x18
 
+  protocol@19:
+    type: object
+    allOf:
+      - $ref: '#/$defs/protocol-node'
+      - $ref: /schemas/pinctrl/pinctrl.yaml
+
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x19
+
+    patternProperties:
+      '-pins$':
+        type: object
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml#
+          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+        unevaluatedProperties: false
+
+        description:
+          A pin multiplexing sub-node describe how to configure a
+          set of pins is some desired function.
+          A single sub-node may define several pin configurations.
+          This sub-node is using default pinctrl bindings to configure
+          pin multiplexing and using SCMI protocol to apply specified
+          configuration using SCMI protocol.
+
+    required:
+      - reg
+
 additionalProperties: false
 
 $defs:
@@ -401,6 +432,25 @@ examples:
             scmi_powercap: protocol@18 {
                 reg = <0x18>;
             };
+
+            scmi_pinctrl: protocol@19 {
+                reg = <0x19>;
+
+                i2c2-pins {
+                    groups = "g_i2c2_a", "g_i2c2_b";
+                    function = "f_i2c2";
+                };
+
+                mdio-pins {
+                    groups = "g_avb_mdio";
+                    drive-strength = <24>;
+                };
+
+                keys_pins: keys-pins {
+                    pins = "gpio_5_17", "gpio_5_20", "gpio_5_22", "gpio_2_1";
+                    bias-pull-up;
+                };
+            };
         };
     };
 

-- 
2.37.1


