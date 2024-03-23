Return-Path: <linux-kernel+bounces-112320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B506488784E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A6A1F21D37
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC59376FC;
	Sat, 23 Mar 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AWSgKFFn"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3001B7F3;
	Sat, 23 Mar 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195658; cv=fail; b=H1DbdmvaAafpYjn75ka1DjY9FMZkHOQWjZm351KwJWoMyRchRc3Gw/VC7vYyvkIOuGBKHDJ5vYreFeoZeI2YinQOrfCgIoifs25sxjcPURy3nydQV/xos36NCjbRAPfykwDgALMj+g4oyqX37N6fbpSUCG5yh3as+BqDo50yVFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195658; c=relaxed/simple;
	bh=VyUgp1uqg2sd9efaIWkIGYr2e4EYKfjV9z7DdHViSYo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X+Dze/QGgDtasyWYRQHsZVu+AKzj5ZCRKA+05fzRrWx/1eS89ozR3eExABGpyA9yYusjzFe8NNqL2mGiqTzdY7aN6PeTNrhhUwpAawPVYN6+tL/pUYoniUddHu/kzg3JUwlBNlZlVORMpxNMpaPoWg/qxI7YbBg1dCAPLxd9MuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AWSgKFFn; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZrXoPV1Ox9YoUNPV725caJnTOGcm0bOjIXNPejxkEluYEq+0ZNLRXVZIlTSnoAU/1tnZLJXOOgNUsx029Y1v/7xtDyQt7XjS4SRz6P4fu92gCrv1kr7XkIwM/JsllnZdrpGZMNYmXf7glGcslV3MpJkfpY42QnpGHPBJZ0Wrx4MzJ6Wx/K8yOtcgJpb0wCc8XOkRF32slmKTB6DjV8e2lJMzlwlbpBtFUzrAHpXI4EShMYZSHxsSdicrqB5Ao2plqacNTBZoxVdAiAmX1pDn7TFh9SbXQbSYyHlBxZRuikHCaW/g4z3aUVDAKazPdlActTDP2pHCl6CRhdq41v16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/BzLovi5aKNOiOuw8s4YMGfV7RBPkidh8VfX3S2pYQ=;
 b=RT8nJ9OjroTHzLo2WWiFNUtZxE8os0XutrbQkVPdFxwAfzSSLNXQ8sK3/e9e0YsR3EDYD11mBz6cZGMy4aFZR3u7subR1O2NGIeME00LvM5biCXyuuTAVIPhXpjlvwDYa160q6r6xTnEM2UschvzRcce7Xx5W8IIlmWqKtWOlMiQLQ5w1Ve62GBQCIoUuZ89E2xrqJi+aK4tJNLJi0+dZu8KGT26VDoZ1TiALIk9e7gaf1qlHIyQNL2xL8Ma2LNwgv9cw9nkKyA0uM27wyIJYMrg7ch4T9FAVSuVcvXEJA6docW4bgUuGjMCy0MZpczS7BW35IxXFy9R9RlUGZ08hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/BzLovi5aKNOiOuw8s4YMGfV7RBPkidh8VfX3S2pYQ=;
 b=AWSgKFFnY7wAIwtFl8pq6kLxVbiYAbmXRJKKKjRGFu9LndmmpWa10axMFJzk8YVqjm8f5873GeZJQ/6yCTK0WNNPVOAIb7JaTkQxhAzg7yqq1hgoyH7yrbsX2ZRSFaeLKM/KFajJCfUh6EqHRPjJcQzm6BGesP37To6DgVsmfpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 12:07:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Sat, 23 Mar 2024
 12:07:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 Mar 2024 20:15:15 +0800
Subject: [PATCH v6 2/4] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-pinctrl-scmi-v6-2-a895243257c0@nxp.com>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
In-Reply-To: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711196144; l=2362;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=1H2rME0+2KWUaw0j7tYsXFokSaYx/bEPhCjn1uDoVYo=;
 b=yXDqUmMho1q94CJjUWs/Y4/Ta6joF+KXkrSg9P6VrL7fy/5buXTzXtrHYb9IXsx7mpsvaJqLs
 IjtBKb32BO9DH3eS7YvmO+lBHr7TajyVxhAL5h5s1Ys5b+1CPFBANt9
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f366a0-a17e-4275-119e-08dc4b31d2e2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	peanjtGePulBqxLzrCc44P9/HoOJ0WD16nGAf9FrMsdt4AA4Hgk8w2F5RHlg9+KqKKgvMMVxYc52t+w/kME/P+ch9GH7IvKn/a3dm7UDAPINymLJDn6GR9JGdoTjOReWhJcZ8qmy6RaScfvRn25emu+iu/ZBgGY3atpJUBU/C/VZiHCCFLNv26AoLCVC5CWx/1GERkNatQ3wEtFRdbwiYBZhM72Up+Or4FbTcl55Kv+YyhPUI9S/EBl7JC0/zhvO3BlPLnp0XMSHkpLYB0VbSNGZ3h8LRioNk6Bzo+Dd5dxoduKHqMowFxXtjHwDtcQ3iHN9xxdirX4muWFyVEfPiN1ofbtl9UzmbXUWhlFj/vtAzHhk9xAPF2mcHV0R2pdCS82D0XPcd+p8fp6ot8YnavBtZ6ZniIns3RZK6Qd7EQZfEtFAEVtf1ljJb/KC+tYBFbIDjEv5vflNQ3nShZE1ujoT70e/PBRlAVMWIsIhYIKYt6jX3Owk77WBjH2f+/vtMBs54wfjeBle3kH98MZRAUUpQYGXc0pKoF/9MALvMKgVojgr1HNjAktCCa6Bs4TzMS+aKotIrQqyFqu5/OMpTL6Oq1N67IcG13LcJkyCEKeOP91/O3V2YItMLLf3Yb/XEMEhkenl+hnsGLeuWk8zA7vyl5cHfIqDvq2BTGoK1jUFKqbx5Z3PHbtfrvb9FoS5lkLc49ll30PGAkQvGt9aDG2L4gtlDsI7n0/dp00bMiw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDB2clFYVTBtYy9IL3JwYURDTjlPSUpkT2ovallrc2xTT3BUM2NuUk0xOE5t?=
 =?utf-8?B?VlRlejlDSTNiSHFENGI4RnNXUVVUREt2M0pzUHVzU3VlU0hKaWhYR3FGZnhj?=
 =?utf-8?B?S0l2WWJ6dXVUMllYZ3hkNlBpNWo1cDRXeEhLakJhYU9Ra1I3MzlTbFplNkgx?=
 =?utf-8?B?QjVnWG52WGpUWGRNdWZPTThiWnNSdTBJN2h2OUxOdzY2ZzJPK1dickR6STVv?=
 =?utf-8?B?aElkWFZBd3JpOXk3Y1JvOHNWZVovTEMvQSs4Z1pnaTgzVW9KTHFOZ29HY1NE?=
 =?utf-8?B?eUdBS05aWDhOUFlFWEpOeThGRzV6WmVKck5CMVR6aGFLQStCK09WbFFVZjBD?=
 =?utf-8?B?REFEcWFvcTMwS0FLSHl2azViSCtUTkt2QWgzWnVtaXFKbVdDaTdTa0IyUW5p?=
 =?utf-8?B?L2srSXo2UGh0anpoN0pxaWdKdCthWFhCWWxWNENtcVFnenJFcGRZL2pQOFYv?=
 =?utf-8?B?YnlKL0NoTVhXaFhvRWZKWGhzeTEwazdRWU14OXBtdUxIdW9USjMwNHBWaHYr?=
 =?utf-8?B?TERlbktwQjZVbFVDRmF4YktWZUZuejJYckpNQ3JrNjZGdmJqRjR1K1Vla3Fp?=
 =?utf-8?B?NVdBNGx4cXd2SHJxOHJUd0crK2VtSWZWWUVpU2JpNHJMZTZFQWsrNjEycXh1?=
 =?utf-8?B?b3BzUDFLcFpCVEVTckRjUmV3aERpN0VFeGN1ZUxKaTVIbThTemlFNGwyOGRU?=
 =?utf-8?B?RC8zck1rak5xS1N0eUZCMFNKNjJra1E0VWVTQW56UXU4bmtyVjNBa0h2SVVl?=
 =?utf-8?B?TExuU0VMMTZaUnk0OFMwTElyZk5TQXROMmR0Q0lHNnNOd3k3KzdQdkRkakk0?=
 =?utf-8?B?WGJ2M01tOVRsUTNTVkNrT01rZkk2NldTWW5Ra3hsenJOOUpxZEQ1T3ZCMk1Y?=
 =?utf-8?B?ZnVxVFh5cXRNTEplZCtDa0dzTDNBSURTcnRldWc4S3MxeVcxSnFiRHkwNmpn?=
 =?utf-8?B?c0E5aXIrL29WelBodWw2emFWclNrRUkyMEEzdW1aU25lRUFjNWFqTUx4MnpC?=
 =?utf-8?B?WWFKVTJnbmpWd0dPYWZjNHJLL0F2MXE1cFhTMEtpU2IwZEdTaWRwZ1BwOUwz?=
 =?utf-8?B?OGYxeEplM2lSay8yVTF1UHlWWVFOMmJTdk9sZXI0QkVXdWQzRGRPVnJvakNv?=
 =?utf-8?B?MmxxSWJvZ0pUZk5EbmFhVzEyMjFHUzhUUEpGYkhrYzc0YW42M2pUdjBWR3Vu?=
 =?utf-8?B?dkJ5NmM1S3QzSC92ZFB2S1BYZDJnRzA2UTFBSUc5cG05TE16Ky9WMWx0QU9E?=
 =?utf-8?B?SmNNR1dLRmtjZ0lRelhLZXlJRW9QUmxRSkVlUVZ4UXBFNFNXTHNnREdsaWxs?=
 =?utf-8?B?ajB1bGp1M3YwU290SnBZVTlYUXUzYTBOQjBPQWJBK0daRXQyU2U4N3p3dk84?=
 =?utf-8?B?cU9pSTEzU2J2SmZYeFpaT0xwTzR3Z2c3ZVNRSWZmcDk0YUExa3RTZEtVRGY0?=
 =?utf-8?B?TU8rV1BXR3FaK2dwdnZGT3dIditjUktJc2RyaWczOEphYW56SlNqczM0a05V?=
 =?utf-8?B?MmdkcXF3ZTlkWVVHUkt3czJyazJ5OWpkOEhjeWovakEzU1NPbFBSNWZybHhw?=
 =?utf-8?B?VDBWUmlQNk8yKzZSZ2w1Uk13OGZab2ZNQ2ZST3I5Q0VhQzVQYXNOZ1QwRCtj?=
 =?utf-8?B?QlpnckhzZHhuUmU4U0x3SmpVTlc1VndaeU10dDYxdm1XTmpNdmpNam9BR3Fu?=
 =?utf-8?B?VkE4QXlpWWtBRWdmalJEWWVEcHY4NHRtWHJHMjlwMlBQZHFBb3VXMXI0VDlZ?=
 =?utf-8?B?NWVyU2hHUnB0TFFBZmI4YU9nMzk5VjFrYWJOQ2I4N2JtT2lpdVQ2ZDFBSHdh?=
 =?utf-8?B?bXRCTUIzUVpaOXVhUExCM1d4WVN6dk9mSy9YbUZ5NGZPNWtiQTBod0x5akl2?=
 =?utf-8?B?SG5yZTZheFZFSjZkaGY5bENZd3N4SmJNV0l6T0pka2d6VzNjNU14ZmYyTlFF?=
 =?utf-8?B?VnAxdXoyUmRYSk9xYUNNVEkzM2U5TUZxTnphQmR0ZEIySWpYNFg1RFFZa01q?=
 =?utf-8?B?Zi9nMGF2aTlPcVZNU1p5c2VnTWtvUzdyU1pBWXI2N1dtTEQ1dnI4ZWpvQUsz?=
 =?utf-8?B?Z3E3T1Q3b3laeW5YNFJ0T0x5Q3RSOEVPdGMzVjFOYWtWN1ZQUS9ESmpZdVBQ?=
 =?utf-8?Q?pz2QeTxTrbaFQkmI1O6v+V4vu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f366a0-a17e-4275-119e-08dc4b31d2e2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 12:07:34.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GrA2U0ozlBnF0LQ6brQRQgSBryX8T/khWWcJm4Vjwx30FCQPSZKUDEnjna25+S65UW57mJstrd3w3D3PsjADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

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


