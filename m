Return-Path: <linux-kernel+bounces-49943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6FD8471D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B602914D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56706146901;
	Fri,  2 Feb 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rUAfYV3j"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2095.outbound.protection.outlook.com [40.107.22.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B213EFED;
	Fri,  2 Feb 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883751; cv=fail; b=TNcE5yVXAKbMvt9Nm6dC7VS4YYbY1jr+/KxGJmDF74xZjG0E8t48LRVKlhxSrXzJArUR0oikS8/e6abRzr57XAwv7U2MO6HwQsbF1V8j+aWJmCC2SbqnWFI0sxrnrDgFRBp6+WT02TF4MeZyT38HWxzsncImrVTDQ3H/Rstys5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883751; c=relaxed/simple;
	bh=LB2Ryn4lgStnKggJCsftSlS2OR2xOegMn+CXH0G54Zs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lCADR0Rbbdv1PrbCpiBECSA4ASUXO9/SZTnkNNeRbzL1JFioG9pdBnSGXVv9HtfhTjiprX1nibHdnUNzj5Y7YeG261nUFG6U6iBuQ69601qly9fjNptRa9zSmR/Os19j1WRTTMswwfGE4D9ewCiyjOmdcZgrduURGecnzbH0QoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=rUAfYV3j; arc=fail smtp.client-ip=40.107.22.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVYSLMTRQpx+8MPF2CaEbASSBfyqLqPOCn5oMtT8XAbsUOy+M6hDIlyqI6lbkrZK/sC4bcFogLZQ3Wrso03kXa07WXa6Qc5BoZ4Mc+83pioKQis7TdSfphyUDnq4TjmeDuLNdoD8rlJb2rF/kAXdItbqoNO6QmdYxBkU/yjZJ8mcXhg9POEFqGd+6hsk2Y4eVAU2gIpGshZIWLqNVrBAZsutlGZTOd/PydKDY2lnzQcogyrhN8ezDpOF80auwedZUzDSkA4S6J2W44gGzSa25QsoBSkZDq6hiesY6jSaJCR+0L0/VdUN+KHL+DCFjA+F9tkV0LkGdu0SD9oLpUY4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ub35LsPDmUJ5uZk6wMaz9doOf6058r4EEFssfdGLy/I=;
 b=Ic610RjiA5RfhF1OBvUXV4OtLVDLWCojmFK+TMQ1YsXNS+EqNTrvCrB8nG5CDVPoEW/W1hxzen3cnYmV3OWUJ0XBBC9tKSqpIgwSouC54qBY1pnbT9mBk5nlkPYx97d6SsOJ7y+6TDVL5K4pl+RNmY0Fa4snbq+R+QpwhHVoZBfHGc65vyk49cnj5w0X/cuNeX3lu5Ra5AR2ag8r59/7mwYc6kr/q2pOQ9vrr6w8TOKiymEf6iXOuV4RsQUGWxp/xXowGMddnkYc7e5FKLYTanEB1qDRg48G3bqiNa16VGzG6u0cvHP0NWw5tL7/IO/JeBea+eRMMofS2KSreSjaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ub35LsPDmUJ5uZk6wMaz9doOf6058r4EEFssfdGLy/I=;
 b=rUAfYV3j938ymptkia9S+dYIPHmpvZWszo93R9Jt0jB0GpUuZ3oXny4D6yWDKWNwIGxP9pVOBG0dsi6yB/N2/N8EXl3G+baooA2W4NeAwsozTqpn3FF6o1NdoE/dlsI0FvVuZ9zm73G2NpT6yxJOAI05AaL5kmiFV4PIRc8f6Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:22:23 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:22:23 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 15:22:18 +0100
Subject: [PATCH v3 2/5] dt-bindings: rtc: abx80x: convert to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-add-am64-som-v3-2-2f44023d50e9@solid-run.com>
References: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
In-Reply-To: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f76430c-8295-4218-2c14-08dc23fa5f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t/Lk3pNLUteuYqJ+ehl/pF+3/g/3kjmHebtKSCwHFKiqnbbiDg9KD6suDYkxGjMcO9WsvqLTCcHYzFejqmPDhPufJfxPJRUwL/PVaaFhPLMOFEDbACxOM9EDWA3+9+omdvo6ui9Ref/ujQj4P2NqwDgtfqY8yefzPUjlxcez/8J/aNUcDCMn3LtSNPpZQvBuLvuerUWfHkFuQFW05/2tr4/OKGCcAoxkWQz4oeGgzWOLIZbusyf/DW4SlcWiDRb6Ydwb/oVKHgyWm9A06NSOpA6M9vjXTAqF1akooOMpfUk/Dk8WsCFi0Eunuwhn1P87bY944FSYidDo0+nDEuoi0vKs9ad8rCh2sMkhdzCgt9nop4aAMxyGEgGgc6grJBvDg+cqlVd7Vm/1WrFi0xeRfB5lp34Fqr0T+4QAtTSTvZfOZ5/gzMZNLdCi4TsPljHV4/X4C2drM1+RIyyTMbiQjvAR4NFc3eVBcvHPF7zh6A1U9LWb+nFftaL0VzW0C240DUjXOrEgiH1DEwW/blTqQQNhMvdGJeY3nHxiBCdAGr0vn9mn1WtLBSVDtI6k3xWDH1KWGh6tCLXc1cfMOP6knaH8g77M24nBqcwqzawuoTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39840400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6512007)(38100700002)(41300700001)(8936002)(6666004)(36756003)(8676002)(6506007)(2616005)(52116002)(26005)(7416002)(2906002)(5660300002)(54906003)(6486002)(966005)(107886003)(66946007)(316002)(66476007)(66556008)(4326008)(110136005)(478600001)(86362001)(83380400001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzlUMUM2Vm5NOTdsUEpJaStNcGZ2NU9jNUVZdDk4eUdycWdLMzhYR04ralgy?=
 =?utf-8?B?Z2FJb0s2S3JzT1ByZkRqdE4rQkFPMUwxalo3REIzTHlVMC9TRzNqTVhoYXE4?=
 =?utf-8?B?bDZBRUxUc2ZpTm0vQXBLS3dGSDkyWVFNTGtWRnNyRTB5WjY0bEg0VWhvZENC?=
 =?utf-8?B?ZU13dmtacnNKT2QwNVFIdG96U1FIYlYyOEhmOXVxR1JFcWxFOVB3dWFuZExu?=
 =?utf-8?B?N3phN203OVM3R0NNbWhQS0RiV3pwTUVLZk5FWE5DY0gzOVpUc20waDZXUExx?=
 =?utf-8?B?SFRTVlJsZmwwTTJYbXc1YktibHZQMXd0L2Fnbk8vT08yc0VKbldTUEU4dS9y?=
 =?utf-8?B?OEJOQmFmM2gwcS81S1k2blNIODBqTkRsRi9ZVmsrN2g5c0FZNmVDcFFZRURm?=
 =?utf-8?B?K2NDSmVYdWNqVUtWNmZJTG9SYVZkaUFlV250RFBwMW1hdzlOa0hrTmRRUU9q?=
 =?utf-8?B?SjNyM2M3SVg4czh0WTJJUG0vU0pncFZkYXRjaXRNanFCSXg5aWhoTVIzbFJ5?=
 =?utf-8?B?OEVzR2VGM2ZZSVloNkFQR0c3aDhhRHdOVVNyWXpZYlBVUEVFSGZLUlF2UHdU?=
 =?utf-8?B?TE9PbjRhMGVYNWNFUkFmVlpPZGdGaFFqT0FKYjU0K1hyd3JCb21kNzhHckRQ?=
 =?utf-8?B?dVAvSXNUMTkzclVkUnIrMUJLd0xHVVpkc0kxbHZ2Z3JqUmFEeGZnZ2VqQWRZ?=
 =?utf-8?B?OFhBNFltamlldU5ZQ2dNNXdzdWRwdlNubzY1aHQxaUlNM1NLdCtQR2I5bU9i?=
 =?utf-8?B?OVJzUjF2SEg2Mkp3ekpadjNJaWlsTGVpdUJkamI4eVBray9hM0tUdU9Ea0hF?=
 =?utf-8?B?QmFXRStsUElmRURRbS81YlNoVHpyWEhFZm1uaVVyMmxnMU1LdnBBS1dNOGlx?=
 =?utf-8?B?Z2dlVEN1SEprUEdPT25jK2gzM0dtLzVVTk9aSlQ0cU5teTdtWnBtYXVRTXpK?=
 =?utf-8?B?ZTJSaUxvOWRiSm03bTBGbVBoMkJLSE9QU2d2Sm5Cc3E3UENkVzJVL0FSOWFw?=
 =?utf-8?B?emxWcVVOYlM3UXROMk9KQWlsNVFudUhPMS90T1ZaSDBiSUd1Z3ZiZWlndVY2?=
 =?utf-8?B?aC9jK2FFQVVqSEtLTWJCOTliTktKdXdoQmpjR1dKVHpHcmFsRUIrMnpLSG13?=
 =?utf-8?B?ZmFiNjdtMTNSNTNzdkNDNXZaYkE2QlVGajRZem4wbDZWZ202YlJRdTdGc0dT?=
 =?utf-8?B?RXlOdnZRVG5UZXZWWTM0SkhiYkQrZHdlYUpSWjdNb2xJTEZnQmZibUtPVHhF?=
 =?utf-8?B?Y3VKdEk3djI3NWZJaU9YU2lVU0EzcjMvbmNRQUpYSDVRUXZJNEdzdWRicHR6?=
 =?utf-8?B?ZndZMXpJZGdEblIza3dEaFgyWFJtTjRVUFpqaFZyeEwyV2ErQWEyWUMzREp3?=
 =?utf-8?B?Uk5ha3RtNXFvbjFnaU5aZmtCNWxweSs5dzFMT2pSR0pRZFpEMUtIR0VNSTc0?=
 =?utf-8?B?WlpZYmI4UFdjVEhQdHZKMGNpMGp6dVVOOENHeGJua20xMTZ4MVBsU0YvUVUz?=
 =?utf-8?B?TUI3aWdjaWk0NkxMalArcVdmUWVDR2NQSlQzbkZNWmd0d0RDcjRubWxFVnpL?=
 =?utf-8?B?YVZtb3VrSWlybDdERktHVUdIZndna0tCTDZCcUFvaU43T2dZVVdSa2pLL1FT?=
 =?utf-8?B?QzFmU1JkM2FIZWRhaE5adXJQeThLMHFiSDFpdjRWM3N0Tkl2emlLM3U3OERs?=
 =?utf-8?B?M2Zid3lVdlQyaEFSNWRRQWlBa0Y4ZUVBRVdJVDFla1VMUTZxZWtQZ2VWZVpZ?=
 =?utf-8?B?QktGdnE3RzhJdGw1MHpXNzcwdDRvZVM5NFZnNnVhbmhyWlNhN3ZmQlpqeWtE?=
 =?utf-8?B?cmhiR2NjQnBYbDJtTE5HNFlRMFJWZVJ2WW1yUXlXb2xESWJCOFdEenZJbXhy?=
 =?utf-8?B?M0I1endkcEpydDBTaWJhQWpkakxLeDNLcmxpVUJnU2NRYlBDVlFmSGF5UzVu?=
 =?utf-8?B?cE1oc0RXSjk2Y3ZoVXhzQjZXazE3MVFTdThNb29wZHNBZHc3Z3RZTzV6eHJS?=
 =?utf-8?B?dHBRSDltTkdGYjc2bCszVklwME5TNWIvTVQwa3JwNElXMllLOTJ5ektaajZi?=
 =?utf-8?B?cDZ6bnhNNHYwSUhPMUp1VWVlUEFsSHFHcnptdzBSUnJYZzBmcXRWZ1pzOXpi?=
 =?utf-8?Q?+B+l7li8BHpnphytulJTzBeKD?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f76430c-8295-4218-2c14-08dc23fa5f97
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:22:23.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uA44vqWo1hkSeYQ50IlhXt4Dhnr4xV8F/fV36EBCfEJ7HkkcH5uWeCl9+XUKy30yS7Or/bpjWJws11m8TXTtrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093

Convert the abracon abx80x rtc text bindings to dt-schema format.

In addition to the text description reference generic interrupts
properties and add an example.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ----------
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 72 ++++++++++++++++++++++
 2 files changed, 72 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
deleted file mode 100644
index 2405e35a1bc0..000000000000
--- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Abracon ABX80X I2C ultra low power RTC/Alarm chip
-
-The Abracon ABX80X family consist of the ab0801, ab0803, ab0804, ab0805, ab1801,
-ab1803, ab1804 and ab1805. The ab0805 is the superset of ab080x and the ab1805
-is the superset of ab180x.
-
-Required properties:
-
- - "compatible": should one of:
-        "abracon,abx80x"
-        "abracon,ab0801"
-        "abracon,ab0803"
-        "abracon,ab0804"
-        "abracon,ab0805"
-        "abracon,ab1801"
-        "abracon,ab1803"
-        "abracon,ab1804"
-        "abracon,ab1805"
-        "microcrystal,rv1805"
-	Using "abracon,abx80x" will enable chip autodetection.
- - "reg": I2C bus address of the device
-
-Optional properties:
-
-The abx804 and abx805 have a trickle charger that is able to charge the
-connected battery or supercap. Both the following properties have to be defined
-and valid to enable charging:
-
- - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
- - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
-                          resistor, the other values are in kOhm.
diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
new file mode 100644
index 000000000000..0c2cf6410604
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
+
+maintainers:
+  - devicetree@vger.kernel.org
+
+allOf:
+  - $ref: rtc.yaml#
+  - $ref: /schemas/interrupts.yaml#
+
+properties:
+  compatible:
+    description:
+      Select a specific compatible chip.
+
+      'abracon,abx80x' has special meaning,
+      it provides auto-dection based on ID register.
+    enum:
+      - abracon,abx80x
+      - abracon,ab0801
+      - abracon,ab0803
+      - abracon,ab0804
+      - abracon,ab0805
+      - abracon,ab1801
+      - abracon,ab1803
+      - abracon,ab1804
+      - abracon,ab1805
+      - microcrystal,rv1805
+
+  reg:
+    maxItems: 1
+
+  abracon,tc-diode:
+    description:
+      Trickle-charge diode type.
+      Required to enable charging backup battery.
+
+      Supported are 'standard' diodes with a 0.6V drop
+      and 'schottky' diodes with a 0.3V drop.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - standard
+      - schottky
+
+  abracon,tc-resistor:
+    description:
+      Trickle-charge resistor value in kOhm.
+      Required to enable charging backup battery.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 3, 6, 11]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc: rtc@69 {
+        compatible = "abracon,abx80x";
+        reg = <0x69>;
+        abracon,tc-diode = "schottky";
+        abracon,tc-resistor = <3>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
+    };

-- 
2.35.3


