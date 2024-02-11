Return-Path: <linux-kernel+bounces-60818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3B8509DD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82931F21CEE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F815CDC9;
	Sun, 11 Feb 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Q3WkUBp+"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2122.outbound.protection.outlook.com [40.107.15.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC05B699;
	Sun, 11 Feb 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664086; cv=fail; b=sHElGBbvmVkOtuHfmGWV8p6QEz92Eq59D297WN2CtzM0b1Ho9y5h80eSLaO7tgpDURcJEkuoSjst55L7knoEAZa7GnXW+lpGWI61sKT3l2bjjWPuhGBnIf8HEJ/ne/Wngv8Il/4cMyaHIjVkRJ4joS4gERsGA1iGvDhpCUHYfK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664086; c=relaxed/simple;
	bh=2bl0qYTONqwDfhtFEslbYUA39JS0IJW59CSiou/PNiw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=olzDgV7VZxR+jBRmso0Wj5qZE+zMT3UrFWKwy8ENHg9L76uip5iQ2rA9HOO3nqU7b0KK+0UkGLAfVEQZB+bxu+GwzLMT6eLxfgVYq3hlkb5njSg8041BtJgRjGnC95FRZhGES1qP+CS2PXMFOrT2ybxSDG+8FoAg4QT22F5oWr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Q3WkUBp+; arc=fail smtp.client-ip=40.107.15.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuVu/IYEN0q7+tIRwaCxxY8olRV/Wui7Fo0FPpceHYgeBayPg1NUsNLXMylzumQLaiO/m0uQsSdLq8KdIRtDatBc1QRYLvd/komaPOPF7fsW8+l3OgRmepQ1yZECbdelQSpwXWC+QmKTvhKWXQ1zTsLC3g88NWrV4+VZUv8qFVMWz0suqYQZh2KdAV9SlugTe/xp+YfJ2+SyspYTEvfk1z7sXSmTWAS7zzDYgtbDRnQvOUiNXFJsG1eis0xZzYCL9JMXyrtwBEcaTdTqLJEUjsgZ5DiQIAfXDgegos8qiTDces9AzjeBvlPW4dBau0Ic0GZ4KAxly/2/fiQIeKhS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0XoBzrV9zt+MatjMdVkn4QnoLKpYCLDHZz8+OlQ+a8=;
 b=AksPl0dKzgrp8JoA9sgUbl1V7tZV1Ot0zCRJHLciMhGzimX6wMaEHPX/iPJeJquzG+CgZI6cRgqvKZ9ucZf3Y1xMZpaIQ8bbmp8cNnNg0ZyN8VwA3hXYgFOJhGJ1P1/l3CQG/p74hPY51aNDD4z184RIWVGL2LpqfZJ6EZEgkBxWy5vWUUHc169dsSi7G5Jl/fELpf+OZlV2vFYi4ksPOEKmHGW27li0HjL90rfc/ooAmSx+c0th8NkQXGF6D/kFIWs+KY5W02N9sfzgAQF0muWiBqqFCaWfzyp03cceDG5OwHpnFpScZl0xTVoN2CE88dg+YMmdG4v3bcJYDMeuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0XoBzrV9zt+MatjMdVkn4QnoLKpYCLDHZz8+OlQ+a8=;
 b=Q3WkUBp+bAk0NwtyHdhVMHTCgPM+RR93UPjcrv0SbEICVGxZJHe++wbZTbvWLsz5PUoXzWyBybuXQD8TFjYvm094iYxTgxMcCX3qXGMmFiSexzKq7iYgkDLsUDyo+QSjcmljjOSqot0uDUK1v2GBxhDH7SbaSmFZU0eVbFlLJjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Sun, 11 Feb
 2024 15:07:59 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Sun, 11 Feb 2024
 15:07:59 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 11 Feb 2024 16:07:57 +0100
Subject: [PATCH v5 2/5] dt-bindings: rtc: abx80x: convert to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-add-am64-som-v5-2-790ed7121249@solid-run.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
In-Reply-To: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
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
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: d41f8e8d-5df7-46fe-3fcf-08dc2b133bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d3HAJPa6XTFFjvtl5JvuyQHxkmB60d9NGg4DVpg81X3qri9sFCOKU+jR7cnzLrxQqqabEZHUf14x0iYALWMGl9hUne0CynzoWlhlYQkwS/eU3iRlrBAq+86PIW/CTieKiTi5i9w+j4ZNxfgSDasta9ycPSZ5XfUv9RS4yv4+ERWD3a6OsWjOxPYoCvqunorHtl4kMNLu187uJmCZyXySie/AEGfO/8d+0yZUUdRr9+mT8cMtIlPKZaAXcMCy1I0tp4fzqJVWRULMeNwFuZdg/OPuZ0wsI4pZDYtXmm7sBOsdUTMb9XVK3LsUEOqTM3XSOjYJfyQk+39E+4bM0X6wcY9QGJuM1R0/v2c1KCCR0JRAEgIt2J5HR5vF8J76yjLEAG9MlBMwres/h2E7SJdVwmVp32tIcPlU1H7OJ8ma5QGfHn3WER48YLFfKox9evu5deQT619M9fajtZkfdRMxJKbIzwPSUGYLsqoCoo0E6MWulas6gSBhg7be6NYPKmob5xisy7nOL2DkMQYJ+S3cufNaB0imW89B5nJxJcKAoJTnpMInsrft2sJX2hbkMTuP3CXoz5xRteIIdQCW4ILBScp4M7pylLRINn2BslLgWOw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(2616005)(316002)(966005)(36756003)(6512007)(6486002)(66476007)(66946007)(8676002)(54906003)(478600001)(52116002)(6506007)(66556008)(38350700005)(4326008)(8936002)(86362001)(107886003)(38100700002)(110136005)(26005)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0JDM3hPQjhUb3pqeXo0c1dCL3g4dU1wbDlTc1p3MlhDV0hqM0V1anl2RXRw?=
 =?utf-8?B?d3Q4ZytWeFQ1YUhOalJCUS9QUWQ2RDVYVFJQVzRHRyt1cythVUNLck9FSWNV?=
 =?utf-8?B?RUNGMGJLVUxiNVhnb3F1SGVWQm84cVYrME92RDR0eW9xeGRyYkZnTmRIOUsw?=
 =?utf-8?B?cW83bVJjd1pITGJOaHBta2NCblUwM1ExeW90anVITXdsdUxiKzkvNnNYbmcv?=
 =?utf-8?B?V2dkaXU4N2p6aW9OcVRkbFV4R0ZqOEM0cG1PNFdMTGswK2hobE5kK1JFRDhp?=
 =?utf-8?B?OVgrZ2hDM3BTNjF1Q0FIVFU5U1lEVFdXVURqU1N6NUZJUGd1RkFDcUZKMUZ3?=
 =?utf-8?B?N3RJMVp4MVdSSkJyemM5bmNmRWFuV3R3SE80ekFUM21SbkRWL3p1L3pJK1Ay?=
 =?utf-8?B?OXZRalB4RHBOblkrcTQ0c1pyRkI1bTk3cEluM1RIcStHTWRtZUprR3lBQWJO?=
 =?utf-8?B?TytZckVGWWVQVDNwVHJYS1l5QlgwTmZSdmZZbWVaWmU1UUJmRG5Sdk9UUmIw?=
 =?utf-8?B?ZWgraldPa2pGRDJ0U2FZNEdNWHR4ODhlTEcwS3ZFcFFBck0rTmRmSTFhS1Bw?=
 =?utf-8?B?N29NT2dEejVWbmpxN1l0Uk94SlJ0NzNaVldIaFFqdG5KSHBWMHkzQ1gzRmdz?=
 =?utf-8?B?dHBiVm55RVlsUEtTdnlBUHc4aEE1NGI5dmwzSVZyWCtFVVZjRVgxWXc2dkxY?=
 =?utf-8?B?MzN4T2g4VjQzZVpvRmVzQUgvOHlLMzV5QWEyWVM0RThWTzBRS29zVzJoemRY?=
 =?utf-8?B?eFUzdk8wcFRRWGI5V2FYRDd3dFlod2ZycGdYQ1VJYzhZb1UydGx3UEVEdm1h?=
 =?utf-8?B?bUMyQ1hOdENma1RVeVlYV3FWR2sveWdaL05YQUZSUlZ6NzU3NDBmUzl4Y2pQ?=
 =?utf-8?B?aE9HcU9DcDhZczhZa1hYUEdXR1ZTdmxWZUoyc2RDWnFWdDR4VGNCVWs2MHl0?=
 =?utf-8?B?MUFZSmgzbXBLZ0ZMQnA3alRueE9tUmVKNkltRkN2K1dRTWRaZ1BPb1AxU0ho?=
 =?utf-8?B?blpLMWRFNWxPUGswVGU3cklWclZ5RzNyc0hoeDB4aXlkZStIa254SDk0MkQ5?=
 =?utf-8?B?YlkyR1hGMGVwUk5oZmtxdXVQYU1ISW14QXBYRGRRUjZuY1VqYzBBSUdGV2sw?=
 =?utf-8?B?UmZxYjJiME9ZUThHWC9FM1p5UGZ2K0xCS01hWStBUkdRRU43WGt6MUNieHFK?=
 =?utf-8?B?ZnpJWEw3WmJzWlVHNHN2dTZKQmVVUy9xTXAzYmsvU0pUcVAyZDBiTEJUOVZq?=
 =?utf-8?B?OWJmWjJPa0YyNzJ2VTlJaTZ6MjBWUllxa2RwOGtrZ2kyQ29OandCb1QwK0pZ?=
 =?utf-8?B?cDdCWmNoOGgrUzFnbFhPVmpEMis2eHNKZitHOTNxMnYxditZaTBvcitOSnRU?=
 =?utf-8?B?cndWYUh6NDFlUlc5d2Q1bUJVcHlMWE5qcmoxNjRMNzNzNnM2aHQ5NWRwaTd5?=
 =?utf-8?B?NDQvdFRGa2JnVXd5UER6cGVadTNuSkpWK0dha2kzL3BIdFV4ZE9KVkwvR0Ra?=
 =?utf-8?B?RDlzWVJSL0F6MUxEbjNPTXRlY3RacEtYMWZ2ZEdvR1I1a1hBcWlvdlZkWjJU?=
 =?utf-8?B?VDJodXV2WTVkbzBCTUtpbGptREZUVTllcGRVdVdPa3lGUFJLRTJwMlFyMHVm?=
 =?utf-8?B?NUtEVDBPc2Q2Mm1sbjRJdnRiTDRZT0Uxd0pNZ2tONnJaQ3ZqRzhOWHd6V2o5?=
 =?utf-8?B?ckVTU1NYblZ0QUhRc1RvS1BTd0xBYWpRTWtyUS82TTNGa2RNVFU4QkRHZDUv?=
 =?utf-8?B?MWFCRE9xMUxHbHVlTU5lZ2s2Q1gvNmhrWnVieUlPa3dPeWg1SmVJU0JoWUgr?=
 =?utf-8?B?OXNDOTdNWkh1WE01SHp3THVVN0g3alpUcVBibXRqUTJHRFEwUUtoZ0trSFI3?=
 =?utf-8?B?TVdBdlBaS0gwa0dpdTVDeWFVM2p4T3JmTVNadEwrTTRRTmtVd1JxVWRuRXBw?=
 =?utf-8?B?QzVWQzBXMFNsOVZabHJtVEZ3WURxTFdxMGpWWWl3ZEdCTTJHWlF1ci9QZnNs?=
 =?utf-8?B?djd0N0EzeHl4dndXU3RuYldKcFpKSDhycW9sanY2eUh3cmFsOU8walU1T3Fr?=
 =?utf-8?B?cnFvOGQ3cm13YkpkbkRqVzFza2h0T1hYQjJPa0lJdkRudUxuZStmM3IrTGU0?=
 =?utf-8?Q?rEU8bJDPbwmn0wlVj2FK1Ukvw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41f8e8d-5df7-46fe-3fcf-08dc2b133bff
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 15:07:59.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sS2ujjDwqnavioRYtCjV8bWmDFVpChALwkbRmtjZKDgHK5/O4YLrO744Ku0HDE4KZkVL8SEdCc1MuAIeHzpuYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725

Convert the abracon abx80x rtc text bindings to dt-schema format.

In addition to the text description reference generic interrupts
properties and add an example.

Signed-off-by: Josua Mayer <josua@solid-run.com>
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

-- 
2.35.3


