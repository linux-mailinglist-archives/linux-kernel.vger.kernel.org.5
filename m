Return-Path: <linux-kernel+bounces-127283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE4894933
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2111C231F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520CA14A99;
	Tue,  2 Apr 2024 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kVkKN8+Q"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2109.outbound.protection.outlook.com [40.107.6.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550FE125C7;
	Tue,  2 Apr 2024 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024074; cv=fail; b=QApMBwf8JUbwmvLsiz2wOcNnT4o9j6SIliBcPARGU453IcYW9sJ4qGW7+RqSriW4e90ohbpH1bPPCUR1T6e9zbnxL0/Wi83YbdExEn4YyM+W+89zoECX3qlHtRP4vaPpySBCAxh8K6eyxnw5Lu2kNgvsQKf4m0A8K5JaOe/CS7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024074; c=relaxed/simple;
	bh=VyUgp1uqg2sd9efaIWkIGYr2e4EYKfjV9z7DdHViSYo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OaGXXpqfOLpsLShEyTtEWwWBDAfwo0DUdj9MIsgXIggjvw22bhlRqTE6bd6JL4Y5UvvZ4vWa7Q4jws15b8faJ6zmQyBlusqrQY9/MXjsFFFA2Os+4HGRoIL+u8po+vzjUwDWV0NU6DuqpDegn9n0X0GNtpy0iPXGJUtPNt/d114=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kVkKN8+Q; arc=fail smtp.client-ip=40.107.6.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNWz73kvzn+pdbMhZQChM7gnFILcx9OlXcb89CiqrMcRDBOLGfKl028582xgejQYbdACSGCLN1MtWfpN6yIPWi8DjM9BHihnShE2kVRG+TSGYDjDrc+X7MiZiHH/kCzw5HNgy/0uaPDFtm41LVPVIb2XkJ1uRRtJEbZPlmBEOrjWhLkv1SfmxIxlcKR14gBiOzpd9tOTXP8WbqB+cU2sjtMGPyUw3s2dFOwCvd0dkWCZu5yKyO95Dtd7F2+eONx8nwLZCbX6lrEIG6wCcWldxhQTJu0Z8bM1S1ujIht7LjBq0Pti1NdjBEaPdcWLGNB/caiocz+syoaBwGabWJm1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/BzLovi5aKNOiOuw8s4YMGfV7RBPkidh8VfX3S2pYQ=;
 b=Ffw0wTt91u5Pejb/R09iiuOnfYpdxB8khjROusUVwI/KK5ehBumsb23h8juxL4eGFi5PqQhmD51m4TDYKzDwX8kyWytqYr+aoLatCXLduIbsJ1M/HRQWif47I7o/iG9vGBuuwKs4iGNKfaM4iG0zVO+tIOaSetYQFu0q5o0MQMH7K14lLlefXpmxdeeCr0glLZeDTXB9GdovMHapEhjBZoNQN6BxKpl9Z42kprsgay5RCiphgeS4fDQeG9O+erL6d1jF3dbekVarGGSYc4zyq3SuSp4AfgK77aArEtNZrWKLP8FaYC7eUSphhj5ocl/n9yjLoMukXSzZbv7S6z2vkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/BzLovi5aKNOiOuw8s4YMGfV7RBPkidh8VfX3S2pYQ=;
 b=kVkKN8+Qal41bqPveCuRWbcUdY097uBskLeiDhp9uFDNT49OmVE6r5rrK8MU6ZDw0ew4e98TRcud9ZREA/8dro+sAYS09Y6z8W48k42/NqhfZgKGs3Mg0kzLc3jOdi+o4tRCBSacgAYcH0JHbZTIKtuOc9W2OvoziKItn0GqjVA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI0PR04MB10163.eurprd04.prod.outlook.com (2603:10a6:800:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 02:14:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 2 Apr 2024
 02:14:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Apr 2024 10:22:22 +0800
Subject: [PATCH v7 2/4] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pinctrl-scmi-v7-2-3ea519d12cf7@nxp.com>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
In-Reply-To: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712024557; l=2362;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=1H2rME0+2KWUaw0j7tYsXFokSaYx/bEPhCjn1uDoVYo=;
 b=CnToFQguE8XWssO8wp8RiiXw25ULCoGascUwv6rvQsxgBT0F1zNAgVL+8pxr3RYLCO8xwOeGd
 GxozKIphA8gCGc/NogPJBPWbeZOH13cc8HNw9IluGUxkMnSBrpeHC4f
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI0PR04MB10163:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pi8sBonqQ0wsBYe+MySU/uAMNb9zE/hhp4BLTqRkJckfXCLVijQE9snQ4Xdww1b/deW+1x1p05fF8DX2AddCiZJ1c1yaFjq+J0fxPrKjjxj1BIWcT0dQajPU3Fs5+r6Q8GWuxknQ0I9yo7hjnBusrArLlJYwDOF4cpCXCc7lpguKv0fsTVzYZhSiQHOA2xHmt/4U1OrHciuADS70wOdiknLj/ajmxcQ+v5xz+dn56ZZSWSRqP7MPXe+ogXK12C3eEhFmdx7Q5XPRh/j5zk0NaVpDr/bpLMYX6EcWTQsnMJODxOCLnVxjv0HHU/eYxtpiOIiOnX8v/lBmWdb3YjfsogOcOWtN8zqLascv+ouUDYgUYxJG7lGhpyaPHttJGPsuOrMTstccgNoe0jXuYP1MZTumZ6TCAr2C5Zglrs6+PxCO+TTLaxxF4isZoKGKcrELl19Kh3HDQyJdIuMPURapN82zoUVsc47lBmLKAidO31IQ8/HFKuCkYEWsVCP1UCW3IX+dW/PBb/L0osBN5FfO6TpXuOT99wKjtLzvU6bHkvFJIfuKRJ0ezqzB2qRccDUEvVHiMbCNrkSn835mP5T0hrT4kot2IZ8FR4QlSXLCL67sHF7jcNxGUPGKUk569HlNxouVLHxo8h2HrKsfQqM6inVXu1sJh5P3YodTDhag6CJ7p3299NG4w4hjiMKYMGO0/xUD4eTigCnnMhM0v6lMVE1S3+2/6T+zuEoT+HEPrZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0Zwems3Ukc1WkpFemdEM05qUytIT3JsanZyK3NzekhPODAxV0gyOXdMS081?=
 =?utf-8?B?OWVHTHMvRDljL2dNSlBVVGViOXB1WHludm16TnJZUGwyM3JPM25oaFBpNkdi?=
 =?utf-8?B?US9hTGhmcUR6aTBxZXJ5WGtzZC9Fbm9JQi9pbDhuQmIrM05Fb0tSNHcvckVt?=
 =?utf-8?B?WEVWL0w5NnFJclJxYlJuZlNNWTNULzczWDJnRUZmeS9WN2J0L1BXRkxFejhD?=
 =?utf-8?B?SXhUV0U0Wno5dy91bVhPRUdYRk40bU5xOGpjbkpSTzRrN2FSOUd0aWZVK0kz?=
 =?utf-8?B?dm9xYUZNek43RnY2RUNKd3FSZWl4ZTFWWkxwVHdaRUI1MUJ6ci8zeHZrSUpr?=
 =?utf-8?B?TE1VTUpzVEZ0bGlmWTByeE9xamNVcHpWZllXRE9meVJIeVlJK3NMVy9tN2V6?=
 =?utf-8?B?REYrS3ROeTNJYTBkR3U4ZTNRb3I3TGdnN04zWWFUT2w5dzRHczhES2JjL3pq?=
 =?utf-8?B?YkE4YXYrSkhKQXNxa3pLUzFQT0xSN01oejRHb014TkVCYS9BTFU5bFZJaStL?=
 =?utf-8?B?czJ3ajV2YllSVS9DQnFpS29kSlc3SDVQbTJicENLQUliaHhRTjZoTWZwWjZU?=
 =?utf-8?B?ZzdqYzIybSs3YlFGbnErSzBVTm9sSjY4QjE3UzlEOUYwNEJleE1zYTNrYjNH?=
 =?utf-8?B?MnNmRFR3RVFidTJFcCtpRjFWeGhuQngvdjRxeFd5SUlueWgxUU1hNzNGbHY5?=
 =?utf-8?B?WjIvTkhhTlZkdjhVOFFqYWtOemxZZXJKNFp4REZZU1pqSjZUNUlHeUlCMTdX?=
 =?utf-8?B?NmhVUytNT0JuZUJOMTdiSzBDUVR1elFRMTNxL1hzeGNNUlNWK3g2Wk1kOG16?=
 =?utf-8?B?Z1o4YU9TMjJiVlh4ZVlTS2c0dm9qUkRCaFltbHpvblFLMVBtKytvdmxXSEZk?=
 =?utf-8?B?OGZHUVZJZVh4YThWZDRUY2Q5TnRkb0lGL09KZVJwaHBXajNSMGhpTUYvbStR?=
 =?utf-8?B?cTZIT2VWU0d4QjErZ1lCdlppZGZyU3VPRFJScWpwMkdQNzhTZHYrRGs1UFZE?=
 =?utf-8?B?U1pEVEFtamJCTTFiR05raTdWb1dydy9JRG5RS1dDMmh2a3gweU1TeFRUeURt?=
 =?utf-8?B?bkQxaEpTMnJIWmVoZTQ0YzdqZEZBdUxtK2t0ZEs4ZnhwV1FBMTFodDA4Vngw?=
 =?utf-8?B?SEdOSWlBa3h4aWVVSnAzbXB4Wk9DWlJ1SkRpRm4vSW13blVjS2JHR2MvR1Bv?=
 =?utf-8?B?VEtpdHNWQ3AwVnQvTlVqWXpEQTBWOEs1S2pXLzcrTk1rQUIrd0FFUHRIc3BV?=
 =?utf-8?B?RmJQZUlvUkduWjhHalJrK3FsMHN4Uk1xdE5NSmp6L1pVVGFja1c3MXppV2o3?=
 =?utf-8?B?dWxIWDc4TDdEUTlnMVNrMHkxZ1dka053ODFyMDZEdzdRUWordC9NeEwycVhi?=
 =?utf-8?B?Z3VQYTJWK0RzUkJsYTgwZ0UrNUVSZnhWWjV6SVJ6bDNjbnp2K01tRllLMk9m?=
 =?utf-8?B?RmZFV3N1QWlJQkxSd3hSamJCWHovcnIrZHE2WXFYT01Vem1nUVdmTzdsZG5x?=
 =?utf-8?B?cVEzMGxyOW81UTJ6ZHl2NVR0OXBSdkVXMGxjU28vdzdzTHVwUXZaRENSdTg5?=
 =?utf-8?B?QmROMWM4dUczcVhWOWZvbFBUMWJaS3E4RTNMSitCSVRQcDA2aWZMaDNYWkM0?=
 =?utf-8?B?cXlFKytmMTdFbjl4ZVJrSVJwYlhPV2ZOWkdka3ZQc3RvR0VySWZLbmc5UGpt?=
 =?utf-8?B?a25wbU9tYnJIS09jUnJUMExMbk1CNTJ1K3NOejQ1TkI0M1FyQlZodk9BUjgr?=
 =?utf-8?B?U3BjWGQ4dU15SUtZVXQxdGVZUlNqTE1ROXU0VERCZG5rRmIzd2x3UlkyNG03?=
 =?utf-8?B?ZXpjUDVHaWxyUnpGdVZQOEVRNkxhaGJacW1YcGRCdzZkWDdPaWNMUWg5RVAz?=
 =?utf-8?B?QmFvK3p1aDMzWGMzSEsxM0tndEZvWUdobVZWWU5oVFBpNmJZRGFEWldVK3N3?=
 =?utf-8?B?eHUxajgyOC9ZeGhEN2x6TElheUNDWDdraXF5ZThIU1hQV0p3b2M2bFo2c3FP?=
 =?utf-8?B?eXRIYzNuekJYL0tiUlo5Vy9DMnhmKzVERlpoeU41VGlYTmwxLzBtS1h4QmUy?=
 =?utf-8?B?bVFyYjk0b3pwVy9FQ1BwYjAvbnFiVlAyYUc2Ulljbi9TcGpsSGRFUGl6OGVF?=
 =?utf-8?Q?7+M1apOkxGOUK5L5h6TZJEAqy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48e070a-faee-44e2-8567-08dc52baa11e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:14:30.0943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5YquuwUKCTDzqi5qdMEYjBk8txOR44MKjZMFG7XN2B9jeyFALIJ7o3XwTyLbb5rpKMRuUfG6pNwM+aeXQoVcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10163

From: Peng Fan <peng.fan@nxp.com>

Add SCMI v3.2 pinctrl protocol bindings and example.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4591523b51a0..e9d3f043c4ed 100644
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


