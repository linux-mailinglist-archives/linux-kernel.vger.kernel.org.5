Return-Path: <linux-kernel+bounces-71479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED485A5EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48C41F257A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908531DFE8;
	Mon, 19 Feb 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="RIs/FzL2"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2102.outbound.protection.outlook.com [40.107.6.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B671149DFE;
	Mon, 19 Feb 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353025; cv=fail; b=ji0nsCOv37sbUaCwKf8ZNxRtc5pyIlsCrS+UFSt9SUJo81zRzCXM7J/BhZ76Fu57Z2xp9MKj/kpoVh8J4KrU6RLIjW84ulm7x9syd2nPHWWV9uM48/KMWuC/ecWrkk4jT+6r0Jt9juTZzAdwdFmKwoqGqwlQ9fGjzGLdgd+l5kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353025; c=relaxed/simple;
	bh=p6bAOIc/y3zSfNk9WumFmoexjhd4IIp6lJHcWWbMGOo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=YDJuGTu3nkiTc4xDP0pXfqSUpmZdyWDensS+ZyPeUdk7Pn8E+wjAbZugLwz62ZaNmWtkm06AwJsXVbeYPQJ1lUWvHHvvawPZSUrMsMo/zp08l5t17NlG+vLeeLDYcyoAr2khpnOdatgIsnvYY0zZO/74yglFsS6/9tO9Hk0xVQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=RIs/FzL2; arc=fail smtp.client-ip=40.107.6.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivFO7F3jABlzUHea7KJRz1U4mzbJtkq4ZPRRjBhb1oluxFHN/jnSMBG28CJ7adBpsLUQ0arc9Wzbq8Habmj8Rxv13OnOrwtO1mYqtPtbEqkyQf+FOapX8vyyK7/HUethz1gKvwZS2+mIKDBEoVRuQzWQJV9XG8b5pw8T+Xi1anmhex8IupE3aJETqH13m9x8Iyfw4KYbfipt0C0JeDpdXUIuF30ddqxEAc5IefDySYCV10GOAUZvXliuEFqKs5VT8T1lePIYgvCfE1Sh8RTCKbuT2voPJdutLgoYySrHCakPRM5Yiz+C8IWLxija8v86BIbg3SRpChw/XNBWisRw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqX+2IjaEkj5tXWnkYh4XHYiCHnMGoBROf5VN4IEyc8=;
 b=dfghau0IWIiRqjjGgSC79az1dGHqE8h86qhEQRUzhodYVwO1hSuaZDpZY0jLvTGV3+6Wu1w6mi7ncx4miiD7+POxqC7taLwe/8YRBErky8I9+8RFVeIIRP+hVOSAfkDK2t4z1FpI4MlM3zSEfTpK65dtVbqbxGYuiJ5Vzpj3hKtOu4PECPMpB0npav4f+90nuPiHSIbq0CHJ8ofpZGlxapFINXPmBhmQrHhN5hh8dmwQGcLJG6JVr1JKjnmJf+7scK4/1EQWhEGBfP9q3TurpQaILLz16hxlUmO+EbF7wRhGx3kM1L+55uMIJ8l++HElTDYEchoMiPvDV8cXgjTsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqX+2IjaEkj5tXWnkYh4XHYiCHnMGoBROf5VN4IEyc8=;
 b=RIs/FzL28f4I8/sZ6sy4dsN0M9TWsndvNRg46+4066ttLwHmlI0B+VRvNkc9GBF9nCMVwb3OtRcU8S+nyLZm+QoKEf1w5XB40j4+CrcBbVHkGM7S7dIU28Ptx6v/dHcIsQQMJzWm6o+eTbvIDjlo4twe40Pi1uUPgramUrdPOlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM0PR04MB7106.eurprd04.prod.outlook.com (2603:10a6:208:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 14:30:20 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:30:20 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 19 Feb 2024 15:29:45 +0100
Subject: [PATCH v7] dt-bindings: rtc: abx80x: convert to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-rtc-abracon-convert-bindings-v7-1-aca4fc3b8cec@solid-run.com>
X-B4-Tracking: v=1; b=H4sIANhl02UC/6XNTQ6CMBCG4auQrh1TSgviynsYF/0DJpHWtNhoC
 He3kHiCLmbxzuL5VhJtQBvJtVpJsAkjepejO1VET9KNFtDkJowyTlndQ1g0SBWk9g7yJRsWUOg
 MujGCoB1vhl5oyxTJxCvYAT8Hf3/knjAuPnyPtVTv3z/MQBoDcm45RD9DaoGCEr01iil90c0t+
 icaCG931n4mO5ZYKdCUArwUEKVAWwJs2/YDoghkBQECAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM0PR04MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 064727cc-b3f9-4c22-428f-08dc31574d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WK5kV21djBn7xt/8Eo1n9rVVTP1n8ju62n+dS/sUizxZzduSZ1e/ZvIFqkVP0AYS4HyPtxRDMD/xroWaIg+E5ntmzurrBbvPb12ibXnySDP1J8WoimptgGJ+DOBklFTfWi9rVio6CYTatqnXudaBN1lV2/I6/BxfCOvHVLDQiKukKxQOfgki0HN9WRwrIwPlki6ATHOX8AqzbqNAtajaD68zEvSS0iHZwNo26euJ6m4n72qqrg36W0wVW7Xlpy6b2eaFYtiwpf2suY3GuqdGQC/XKlLoN3kAjq5Ia4b4zQyR528h0aj+ItuenNufJBqEICtSqY3ai62HZZ5EkBZs+XvycHA0XGxEuzKM+0q4LTftIGugWHBne3GzyjMLEfMZspqK/qeqfs3HTDo/CkvmEJApHIoB3x97B1H82ZU71ZIsMzfnxymOaAOE2lFLABuNGNM/PUCTkULJnw0V5creOuS0ofP2zaJDU+EMeuTzmbjaseHZ1HXaqo6Bi9Cqp9Rr0dTjz4OLJYQ0h6Hk5JRDUgxWdHBADfPmSWubH76b49r/ViXzAW36LSEIEJdIqEk8aJQkbo6lKOiDzcT5L7UYgb8iGUOlnNSOARwVDIuK/xU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHRObHE1aTltV3lsdk5IMldGTmZBWm9uRFA1bng1QlVHS1RMd0ZQb0h0YUZY?=
 =?utf-8?B?VkFtMGtaWXBiTHZYYWc1cHdleGlYdHl1SkxpdjhXVy8xUU1GV09KeG5BL3Ju?=
 =?utf-8?B?S1NuQ1ZDOVdtSkhHSFJ2elJkK2ZoMVBXc3JmQzZLZS9qWS9FNzNhd0Yvc2NO?=
 =?utf-8?B?ODVtZGFmRkN1NmZWZUxENk5wTGtWMFU0bmN2QXhxeS91a0Z6aG5QUFZGR2Nt?=
 =?utf-8?B?b0NXSGhJdVJEWDJLT2toVDNLRW1qWU5xM2h3aWlneUMxSVlyQXMzQVdVMDNy?=
 =?utf-8?B?Ujg1V2t4K3dQTWQ2V0VaZXRMYStyVnJIcklMK1U2bnBRMGZjdzVYRW9wdFRu?=
 =?utf-8?B?bWM1LzJCT1BJbHVUNjRtamg4VUlnaFFMZEdRK0lFRUFyTXhNdUZyYUJZQXl6?=
 =?utf-8?B?SjRrS295dG1iaTlnZG5ES2s1YVVud0xYQkY2S0Q3cnZXWlI5aVloZko3YkdO?=
 =?utf-8?B?cExoY3UvdGNXRng2Zy9nZjFtQUVTUnA3Q3RZdVJRQm1CdFI2emIxWHFJOWJZ?=
 =?utf-8?B?M3pMeVA1UXdyalVIZUZueGVWb3ordkN1OHlTQ1F4dEExQm1tZzNNeU42a2Vt?=
 =?utf-8?B?c3llS2RSV1RhWGRGajRMY1VGNkJTYWZiZzlrcElNczdVV0Rkd0ZOQ3BmQ3Vp?=
 =?utf-8?B?TXo4WnRVb3lXZHo1T1A2Z0Nmbi9YaGpjMGFQUjV3RTZ5TUY3cXhZUzhpK2R6?=
 =?utf-8?B?Vlh3bmdwZ3gzd1VrYU9OVlVSUWFjMGpzdXNET01kdEJ4cHdYd1djTm1hcGRY?=
 =?utf-8?B?cUsxaTdGQWx3VXVGdk1tYUFXOE5UQmgvSE54cHh1UXR2RWFSNlBGU2hiSjAw?=
 =?utf-8?B?eHpXdUhrSWtXOFpLRmJKMnNRQ2owclRBazBaZGdBcHg2aDYvNGF0VldFbjRa?=
 =?utf-8?B?SG4wMG9UVHNabk5GTVhnc3hFMVgyWkpvcmw0MWtCT3ljZEdEbHA2Y3pWbUxC?=
 =?utf-8?B?QW1oMDlCL2pmTzdKVGt1WXNLdkFueXF0cnNpQUhsVDZQR2VwTFFoYWE2YmUz?=
 =?utf-8?B?U3R4VnpyUWJNaW9GZFlteVBDMW5MVFJ1WFpISTdka3YzZFFqZHV2MGZUdkxY?=
 =?utf-8?B?bTRnSU90ZkIydzkxV0RIMElUakZ5eEViMXdscExuU2FLcG5BSEl5bWhBVEk1?=
 =?utf-8?B?T2FGMGViSGpOQWFRYVE0Q2ladUY1Und0Y1FXbjZwck16YjNDWG1raU55RUxq?=
 =?utf-8?B?bTRFbEhaSHd0RnV2S0c0Z0FBYXBGcHFyVFRTK01kdEVkdGJrWW9QV3lISUlk?=
 =?utf-8?B?cUQ3T2tTVXdUZUxaVmFQcGp0cUpkanUyTzh4Vnc2a3E3NWxqS21xbVhwS1VL?=
 =?utf-8?B?dFRSWnlabWNDdkh6REkwUHU1c3VRQWI1WExSSUZwMGVXM1haNnAySHd0b0t1?=
 =?utf-8?B?TDR1cnEwRURsRnNTaEN2WlJQZnlpZHhpVWZUSmtsckIybDdPSU90N1JvdTYr?=
 =?utf-8?B?SVFkZFUxN3F4aFFKakdXWExUdElQMVVaSW4wVXUvaVhKT2lxTmQ4bHBuYXlw?=
 =?utf-8?B?QTVINWlWZDBOMHc0M0ZJYlZBODlVUDFGQnJjcDV1bmZDY3VWcTdPQXZtSXEx?=
 =?utf-8?B?Q3kxSzBvMSt6anBJSVQyYVVtYStUMWdxVGNUNjBaYWk2cTR2cEtOMFZETVhx?=
 =?utf-8?B?MDZSRWs2d2paZ1loeGJ1NmlBdGVlYzZDVlRJbXN5OEg0eHVGakd4aFZ0cVVT?=
 =?utf-8?B?QzE2UVFzMmhzNHA1aDk0V28wUDZtUmxWcHFwak04eXN1T3lWVHphWFpFUVlE?=
 =?utf-8?B?QTZjVTdGSzlqNUcvVGM4RU1jTlRFNWd1ZDRyNHJxbWo1b3EvZFFXVHdzUkdm?=
 =?utf-8?B?UjVEU1ArczBuRWtkaWN6eVFBcUUzK0VOY2hsQ0NLSnlZMXVoMEJwYk1RM015?=
 =?utf-8?B?N2txbEpHZE5VOEhnamN2TGt3WVFmRHd3Q0ZOMkl3eTBSSkZ3dTdQbWlvYnRq?=
 =?utf-8?B?bjdxcHFGQTNGOHlyRVFTUFZnNDB5WFQ4eVNyMkJVc3ZFdjB6YXlVNkN5djl6?=
 =?utf-8?B?VlI0SFIyc1FtbTh4bnJHd3IycHNmVXhGRmJXTllkVUhFZHFqSnBGNWNqaUNj?=
 =?utf-8?B?QlVBSkRObWV4S2VnZHNnTWsvL2R6YzZOSDlYY1g3OFVQUkpLL2JXZEZ2aExG?=
 =?utf-8?Q?24uCRaW6QTxiFpqweYmOS6/TQ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064727cc-b3f9-4c22-428f-08dc31574d07
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:30:20.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sh4pHs9wJSfD0uy96Y2Q3I9y3G+DG9j0lJ5hCUWr/Il4fIDAMQBHCHB5WZOqQaYne/+rL2Hb7MRqi/yTjfIufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7106

Convert the abracon abx80x rtc text bindings to dt-schema format.

In addition to the text description reference generic interrupts
properties and add an example.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v7:
- split out of original patchset because it should go by rtc tree
- collected reviewed-by from v5
  (Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
- Link to v6: https://lore.kernel.org/r/20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com
---
 .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ---------
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 79 ++++++++++++++++++++++
 2 files changed, 79 insertions(+), 31 deletions(-)

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
index 000000000000..58dbbca27deb
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
+
+maintainers:
+  - linux-rtc@vger.kernel.org
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    description:
+      The wildcard 'abracon,abx80x' may be used to support a mix
+      of different abracon rtc`s. In this case the driver
+      must perform auto-detection from ID register.
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
+  interrupts:
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@69 {
+            compatible = "abracon,abx80x";
+            reg = <0x69>;
+            abracon,tc-diode = "schottky";
+            abracon,tc-resistor = <3>;
+            interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240219-rtc-abracon-convert-bindings-50743f95ce2b

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


