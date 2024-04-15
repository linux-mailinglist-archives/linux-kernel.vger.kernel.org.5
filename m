Return-Path: <linux-kernel+bounces-144782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096B8A4AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDCB4B2432C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D993BBF0;
	Mon, 15 Apr 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TAOZOWk3"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB243AD4;
	Mon, 15 Apr 2024 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170583; cv=fail; b=uCx0lvov+kke9XQjTCzCs4fp2dPw8E2Qj9bXbDEeneYc60DwydXrh8xcRvWU+9q3vYLC6sywVxTkZIxTPcEuiHzVfPupnaz+r2E3Hr2rCdKA6o0ExV7awu8qbd4kW4PUNNaXY0W7l9/pgMD2g7jprPVEsqxSULlP+eMFFXPDfO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170583; c=relaxed/simple;
	bh=1zPbtoCNbOl7ALpohlegcy1tsXoTHb4w9RVFmhetJ9Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CrTH6jO34V+WN/M83p8HzPfdxl+zHLgvfAM/KS4flo7DWMxQp70YgqQ4Ai2w0z+nlVXNrgrGXKTwsjmbNigLPDId8PAmhnI9f2ITBSeK9C4tNK3eerhOknI6qJR5CbidZeSMGtQgbPR+ZZvG0QTVhda+RZJqxiqjJUoqyjVIKFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TAOZOWk3; arc=fail smtp.client-ip=40.107.247.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7W0fLDeDkVoG5AYGCpt/VSPEqsvHx4WB5dEOqAq6YemoysDoGmS1KH4cmh7fAC/5za3NtfVzaek8GGJC0kHQfqRwEJJTH5yXfo89xfvHg/A2gMdG8qlMkWZ3Zvb7M9/8iMkIJGiSdzn9LVyBanXC++xOOzkKPNJjSXyaI6lEsB4J6XXEEH721qaqprSVj1U289VJK+4mtvE/tkkgROixf+W6gfdeKuhC2udPRoyvGPXvOXUV+6bAZLQP6O2UA2yX6jnnNpbVQZACFJHhDHG9Wy+Zh2ujJJ96LAAGOTKZHcekrh6AxCj1YRzV3ob7imt2gSpPhN57sMjaJE1e39XMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEk/KyCGYEIR0nJYohvLG9OMHTkixQzPWb3gCR+cLZs=;
 b=jNbVLkiyXvpp8ZHdlE/Ywp8VMDEyGmQnA3fD3GfdBK1O4NQq0OLrd/VQJ2kpA2R6QwqcSPrHkDytueE381xf9dVYtd4TyzqfVpHu/gYaVyNcV2ElLB6BVu/FvaNQcNgq0MTo5r1cu39MC+lf5L+/xcxf83NAODNr+qJIoSfcki1JSachlTruzsRXNQrpEzpY3czYfZUKFJ/e95nRuFDxF+ojXfxauFXJfOEs9BG+u7fp1nJ4dsvagmjHpSHErvTGIC9bjojh9kXq5+92FaF/Q7qodC44VyaUMz7R1pbPHIh1zDB5fCxczMIP6Plf2im2QkAU82kCAx4VUE63FHpJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEk/KyCGYEIR0nJYohvLG9OMHTkixQzPWb3gCR+cLZs=;
 b=TAOZOWk3AD/GtxQWpX/g2THBdzCnjAfNOjVpv3NyWDXX33NMpfs2nHYPXudzk7GGCWQaYjdnCljdDHCiz2Bd9ZG4tYREYnLJPLBAXIDVlugoR7iIOgEb0k1v0LzEZcIDrkWVdmMmu18aKS6ZqfkrW3ToOY72Oyzglvm2AjhiXGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:42:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 08:42:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 15 Apr 2024 16:50:50 +0800
Subject: [PATCH v10 2/4] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-pinctrl-scmi-v10-2-59c6e7a586ee@nxp.com>
References: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
In-Reply-To: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713171061; l=2404;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VDmWstcwBhpk6d9BmY1+Svq0j29w4hdHyHMqV4zPF24=;
 b=FgQIu1M+b/SSNUdgszCS0d9jFG/pgLRZo05l9WUzDohdJlFc2ssIZFgi+IChVuqj3L2f6fACV
 TdpBkQ7XcB+DXklVpNsi/myah3KnmYgzvUj9uRFta1mxad1McfTHnYx
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0336a2-e374-49be-9eb8-08dc5d280d53
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a1PcyRBVsm9bf7cwF9XlE7NDeGEnLdzPhqn1Nm3L1fznQxACz6NZBHI2BN4l+/5ZxZbZ+LrNcx9uVeVOh2z+F3GgZ2xKwrgwF/NNspGboqtC9dKSaap1Mm6b2M+/XR/F1Ac6oi+4Yz2TZydrZI77qbf8gHJwDTFdB11cecQ790Z5IF33ebHsYJzZYZ4vYpS3852TKE9mmGvqZb8iwBRp9JFUU3NlKfXOr4PLwCwQlW+pxghiqzMoHJ+sPzr81q8rhkUV67s/kbh5hjA59JomS7kXeJBYPgIgf57OnXuH9rfbwzQVEJVeG2tM7WkvRQM3xzIkOw6AhlRUkQY3Ncu5fs6C0Lr6nMn91/XzoL22036UcLyHwZwMzQmQxnhG5+kc9eYub/DZZSe8oPJooQMSeQMd3wep3wWqh82s9TAlDgCFnokL70bXadg+fRlWCcPFrQFO1SMvDhCmxxC1F1ukb+kh7RTXrbp1xQv3aqBn+Cfl9I9O537eG2rp3csymn0E89RvZUm5yjuBrNoi1wkzNusZ4bYegyLEswa+tJ+3umI6d38+KBKpEjJqCQFos0s4pcrW9ZvmcEVAZNvsa2GyYQC0Xb4j1fRZWY03isXNBUl+hYFYkIJ2f3sJGaXYywEWoCQTEdwyt6+AqRYdWmnAzUHeDnF87nNKoN7wHYxC9tlEihAGHaiaJy0VlGsAMIPrA6Ly6RpTqFPJk9ORfUAUEaDkAu9TQqGt8IeudlAbBNw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cURxM0JPd05BQmJhZEY5STlPaWMrQXJqZW5Hbmc3eEs1NUt6R2lNVnNNZzZG?=
 =?utf-8?B?U09Sakx2Q0taYUFKazdWQmRaQTRPd1ViWjM1dlZ5QjBudERBU2tpRDhkamM0?=
 =?utf-8?B?eVBMWitIUXFnSGVhWTVNazNDemN4OCtmNXBYTnBYYkp4bEhUaS9SSW9zOU82?=
 =?utf-8?B?RFdmRUEyekpvcVVrb3AxU3BabE83ZDM5cGVLSjFkOUVrRHVYQ1RRbEV0VE45?=
 =?utf-8?B?NlQwbXI1QzJVdi8yNDBDa3JPTnFFS1lRdjcrdXZESWtrU09LQzgzRkpHUEJw?=
 =?utf-8?B?YlR3NjRXMWN3WHlLNTUwbE1DNUhKTmNZMWFiZkdIWnZCK3MvNC9USTc3WWVT?=
 =?utf-8?B?eTZGRmN3cHJYRFo5SU1oczVmOXRhQVo3N3BlQ05oQ1NsZUg4RG1DUDhZTk5X?=
 =?utf-8?B?MGRlMmpia3Fad05YUkdrRk5wQW5QNWhzajNINUREdGg5c1BmWDRISDNaQ2Fx?=
 =?utf-8?B?bU0vTmJQZFhDSGsyNmJNbStLM0RLdEVYbStvOG1BY3FGTTVzd2VwNzNVNWJN?=
 =?utf-8?B?SVpMM3prekRvOEh6eEFBSkRaL2NjalQra24rU2JXL0tuMTRONUM2ZnZIbFI1?=
 =?utf-8?B?akRDMy9FT1YxN2hBbzI5UnprajNEV1M1QUo4VjNMT0d5NUo1QytVZ0gwM3R1?=
 =?utf-8?B?TTF2MzJkUnpTNDR6ekdqTDVFWG5oU2NDc202ank1UGlXazllalExMDJZRkFz?=
 =?utf-8?B?YjBFSWFxczBvYTRNdDNFd3FjVnE3U1NhYjZOZjdZN1NNRnB1RWJrUnNHMS9E?=
 =?utf-8?B?bVY2b2JEdEZaUWVhak9QVlZOckk2V2VhT2d6T2J0MFNIVGkyQ05jUFNkSFVZ?=
 =?utf-8?B?TUxUenB3dm85Z3dJR01NajlzY253K0s2NlVFUGMxZmpBU2g5MmFxTnNhQUlJ?=
 =?utf-8?B?SUtmY2hjUmxzTFRuVWhIUmpMbXBNdlNVV2MxN1dVT1JlZjBnazZ3WURkUG9y?=
 =?utf-8?B?WmFqaDVhL1VxVjd2c0JsM2NGalFRQ3htUm1MWnFraFJuc21GTENhdjd6c0l3?=
 =?utf-8?B?QTJGNk9sSjhhWU0wTWNBZ1pDYnNOY0hqU3pBYWthQ2JVOW90VVdQaFpMK0JS?=
 =?utf-8?B?emZaRjV6d3NreExtV2xiMmlwYmJUZXVleGJtY0hsa2VsQzJUaFBneTlLUHox?=
 =?utf-8?B?SlRzRnJxMVFlUE9UelliN3hCaG02YWpTNHJ5TWNTbS95Z09BVTUxZkt0SnJi?=
 =?utf-8?B?TDhpRFNyaytFWGVSQ3gxZVpza0ZSb1lXQzN0eVlhK0J5TE9udmpSZ0lyT2Jx?=
 =?utf-8?B?U0NPMGQxOThPeUdYYy9aZk04bWJPbFdkSHpGU1E2cUFjMTcrUzdBdTdNaks2?=
 =?utf-8?B?RmIxZDJTanEvcE92TzJENDI0WjczcTYyT25YTUtGdWVWck4zbjQzSGpnOGYy?=
 =?utf-8?B?M0czNnk0N3JvYW1XVE54VHROejVoOHpqWThlMlRaOFhyOTl6dHZPMEdhQXph?=
 =?utf-8?B?TzdZVEI2MFRYaUJnMWtEQkdyRVJ2T1VnU3FTbSttVFNoaEVZeFYvclhmVG9D?=
 =?utf-8?B?cDVZOFQwRUhWV3B5eS9hV3ZiYUxwaHY3NVk4ZnFSS3lRVzhadmp1NjZBalVK?=
 =?utf-8?B?TGdVZEVLUERrc0ZMMXA0d2FLOUtaQTBRVVZqZDFqdUFrOHo2ZWwvOGYxWlpl?=
 =?utf-8?B?NCsxai9vVk1jMU5qS2lCNHJtdGdybFdNcW95aXNFOHlNdm9wZTIwQWs4T1Rh?=
 =?utf-8?B?S1RORVc0TjBucXhIWkk0OXFRbk13Z0pwcjJUaFVKM2RieEI3dDFOektBZlk1?=
 =?utf-8?B?bEVselJGZGFNVm5QUStGbGhrZ0RQd3lGL25rM0lsRFFrQmFqTVZQb05ybzhS?=
 =?utf-8?B?cHhiY2ZSaWc2WDNvekUyWGhhQ0hiNFhncnRCay9XV2l0Z2d2aGNmb0Y4TzRG?=
 =?utf-8?B?SkJGY1M2WjJlZzNmeTZvbjF0TDVLTXdRakVvaHRQbm9RTGhscFQrOTk0OEoz?=
 =?utf-8?B?eWZTSFRqWldLTFRwYVJQMytZOHFjYkdWTFJkWkRDWVg1Qlk1cGpiVW13eGkr?=
 =?utf-8?B?cC91cUhnU2VWZ2RaWkhBTkZDUFZJQ0ZiNmJ5ak9jbFg1d1Qva0wwRXg0VzdJ?=
 =?utf-8?B?NDQ0djcxbFh6eE1wQnVyVlJkYTRXUHN1amlFOUdqRWJlelVpSFQ3eHN1TjJY?=
 =?utf-8?Q?kaBLIUX/aogkfWwXTG1AjabpV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0336a2-e374-49be-9eb8-08dc5d280d53
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:42:58.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVqB7+J8AkENFPqSV6fnutvtFm8BRzb5aPK1vWxKF8kzOh7IuqoEIm9FXLkFJw6QQdJeukt83iytvGSQgvY/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506

From: Peng Fan <peng.fan@nxp.com>

Add SCMI v3.2 pinctrl protocol bindings and example.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 93fb7d05f849..7de2c29606e5 100644
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
+          A pin multiplexing sub-node describes how to configure a
+          set of pins in some desired function.
+          A single sub-node may define several pin configurations.
+          This sub-node is using the default pinctrl bindings to configure
+          pin multiplexing and using SCMI protocol to apply a specified
+          configuration.
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


