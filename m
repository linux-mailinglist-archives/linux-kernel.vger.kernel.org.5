Return-Path: <linux-kernel+bounces-50112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32319847466
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BD41F2EFCA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9FB148FEE;
	Fri,  2 Feb 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QdhXxqB5"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2130.outbound.protection.outlook.com [40.107.8.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358B14830A;
	Fri,  2 Feb 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890264; cv=fail; b=V2EFfXgPtO9+G/HdgXvtfqk+7MXuj7apY5S/knZS5UqUjATlFk270gr1jU6Ko8C/b6pkUVM8si1/3ix4kaIBliXDX294SIdbY5nFbi56mwJD+Il7qjZWI/Mq/Kwa4/25xn4GvHOR/w9Mvs8UGsbvVsivNERjFSgIssfrW7hXj5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890264; c=relaxed/simple;
	bh=5j8dujCNX1z3Dseon/Dm5KQ04LNpIjgEL0V1TupaUZA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pcn8wk4v7yqZEEwDYh5RgC93nzrydBNRoFZBXD1ngBXIgHDVsAckVEwEp67L7CNscH4rhiNXHyxjqEmrv36IogdWm83GNwi8rJNXfCsVig4YUoXkm5Hh/xDI72QoaB0PkLIYSlZf91tQBplH2lmcTPUia9T8LUw1JxfKKFaEe+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QdhXxqB5; arc=fail smtp.client-ip=40.107.8.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYga6yuHxWA/w2t0lzInC7b+TXHBLfW20PN4Mp61/UKlyyc/6lauccCXmN0AooEW0BlJ5j/ru+hy8edjKH449rfQaQE9MFMHNQLgt18D8oKGujEwT8zLs2iKxHGwQX+QUhg93gIPHuc8ta45n6kX6mlnfgLrHx+Wyj2yPtOjacy21n9BNi31FrBSAZzodX/2zS70IGOCY27+9I9sYyLJIbSipQ+KAEJ2b+iW5gnE3vPEDuqZbcg9fnu2Da9cn2bHI80Gb0K1+hVAzzcKf5xEkaRxN+O6mp70IKACLWRhOyE2sRNR4qsaAcgOuV/rbME9NNf1mAxRwWDIh6W3JDBwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGYc5FmFk73gu6M4c/VgoZNH+SKZtBH9GUCwk8Q6d7k=;
 b=BEhoWGjyPjUPh7NccpsAtSFhsnbObtTL0Un0+fSbm+8xqH6/Wq/IQG9fmF5YDMdxu7bwKuBL3U5ze3NiS8cbk+Q/AMtGUArfwvJEom3Kyo3BzRU3etmYa6gTjlQQxkgzElUQU5ozHZ3e+xP28t4SEaqtQUlCbibTp2VcmLwWm6FsGdgLnKzkBSIg0C8UNtpiNb8LDbAcFFWU+77NLAhk5E0QPdCZp+bJyeAmhbQ664EE1C7rWLFODc0RT22hZyca0I/i9TruTW959dRFRhzsGGh/S4UayibiQE8M60jBO28AbG+61/KP4qiLZcxzoc7g+I1RuTDDnTY9ckoIYurj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGYc5FmFk73gu6M4c/VgoZNH+SKZtBH9GUCwk8Q6d7k=;
 b=QdhXxqB5gfyGMip67Fd6OeSLoYrfW+lGH3EeW/ROXbyQNTH6ePAAhIZ5ZWC/llPIpsu33cNBfnDjuD/IputFp+SN4LJSNtMmZbdve1OoPBkYxowBXV1jqqO2LeRAsrLNsQACsbGxBoCl5kRp7TojxdaHsGgT23K3Amrkc8tdBHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 16:10:53 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:10:53 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 17:10:49 +0100
Subject: [PATCH v4 2/5] dt-bindings: rtc: abx80x: convert to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
In-Reply-To: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
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
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b36cd0c-ebe0-4339-14a5-08dc24098774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bSbONFPNve9DJiMVBHbRkNv+J4mLyBwvzpLvOQKpwxCjl5Byqc6sOZ2ETixm+JrRsIBogGwJpEXoBLLLZ5vz+SpcHMG3D2vF+c2/WkR6bh/V/nnHAgc10dKz1vo0iEReFY2mSODBL5TMgT4foJ2uA7MYEr0qd2D5cyE+9xn+yskFD6D+SfbhxTjcDISyEKcuXn/zla0A6Zf/bRp2ze1i6MpUClO4xP4pyIZBbbYPcXNft8VG4smwbIrLf96nMzK0El12D41UfXONg//ylPchT5tbHr5CaUEPebZvudfqmE983u80ZBraAn8oNQ2Jo9Msw/ArAcnRwwQc6Lo7KDDHYswYJ1L5+2Feev3mv/NMLt8LOCBPgOfxpAXzZ//8A3qCvQ3NaH3qJi5gVeji6Px1gc+ErJXCIctrT4GQ91+2FO3OMfHg2MM2clCSDuAgkOFPQsZEiufA8mV5HAVxIN6qhoLX/G5FArq7yzJeDLJEL8wikgaUPDV/UXmPl0PqQIEGl8RrqP/URVhfWIwhuM9SB21ShLSMc+O3z2h+YrLtvVZI40/k43tdzzmcetA4VINjABi+nvV3xgCgj+1s06MiAJE40n8REC94UuOCaNRYr0A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39840400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(7416002)(478600001)(6666004)(966005)(6512007)(6486002)(6506007)(83380400001)(52116002)(86362001)(8676002)(4326008)(8936002)(66476007)(54906003)(66946007)(66556008)(110136005)(316002)(36756003)(38100700002)(41300700001)(26005)(107886003)(2616005)(38350700005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qldod0xEQkxubklVc0hiaEx0M2t2MXhjZVNGaGhuTEd4SWV3WEk1WHY1WVVY?=
 =?utf-8?B?Z2gxOENoVE9wTDI2NVpQUFkvTUxGUlgzYXJiakxoalFPcFpoZEhrb1ByVU1V?=
 =?utf-8?B?SnNhcHVTTXhFWVk3OXNGRkdtdldLNis4eWtVUDc1RGE1NXR2SGdTUldScERS?=
 =?utf-8?B?dWxYbGdmZXlXKzZDZ1hQTEE3UlNUaXpPYkIyQ0M2N1Y4VHJhOXpJWmwyajN1?=
 =?utf-8?B?UldQS215QVg4ZVVmTHhSMWJ6ZktubHQya1ZtcWhzakpZVTR2Z3lvYkpMcEpW?=
 =?utf-8?B?VzZ1S0FGVzZWYlR1Q1ErR3NydE1JR3VZN2tpeU1Hd1VLWW45ZnA1dlQ4RGlw?=
 =?utf-8?B?bm5KMWtNZEJpbFJORXFVS1FHZjBYNVRnMkFIN2tqMDBZR2xhL1V0QXV3TUtC?=
 =?utf-8?B?bTZvVmNMbkhEbGcyTU0yMGdXRG5FQXY0UUh3Yk5LYmN4THRBQm50RG4vMURt?=
 =?utf-8?B?N3laL3hoS2JhUEptNVI2MzZYNjdKUnlHZHpHbVp5Wm94UTRUOEFxQzc3aWNw?=
 =?utf-8?B?OVZuWEpGaWw3MGFaUy84bEMzVndSQzJHTWJ4UXpaN1NsTG1aY0trT1RCWFJE?=
 =?utf-8?B?VU44V2hYdURMVDRyVXROcWRFRGE0WENYT1ZWblVKTExDa0JsbFl6YzdjeVYw?=
 =?utf-8?B?SUtQZk15UnlxRHB0TEUvcGRmaVduQjE1SUd3aUgwTEU1YVY0djBOY1F2L2lH?=
 =?utf-8?B?M1hpeXFkTysyTkhYMGU1S0xUT0p2TzBiYzdubXNuM2I5RURlaU1STEIzbUVQ?=
 =?utf-8?B?ZWx6UFQ3c2FPTnN6SzRhM1U5NW1BWXFwWDJlUG5QU1JwSTQ4TFhqNFhaSlYx?=
 =?utf-8?B?M0V6UHZtNmlKMXNnMWkvc3lEeWJ0Q2V3Q3VDazBzcUR3dHExVFFPeWpHNSsx?=
 =?utf-8?B?NHQxUEkzSmNJKzdBbjJyanorMVI2OWxUYjNFUERiMGhrMHY5dUVoZ1QrK3lP?=
 =?utf-8?B?eWxNbTZWcTEwYTlsVUJwa0c0TVRwWk50dW1VNWtQOVVFSzJSSU82dDlYT2pz?=
 =?utf-8?B?YlNOdHhzRVJ1V0dxbDltQnJlTjVFcTVJcFFEQUluTVYvREVnR0xFK1RNNjB6?=
 =?utf-8?B?VTRsWnBtMm1xQTZFbmd5UVdNcGIxb1E2MW80bDVpYVVENXMyQ0NEbUR3VDBs?=
 =?utf-8?B?RGYxcUZjQ2tTRm9LY2VSNmgxTENnb2dYbGtDQWlJWUt2SnNzT2NwbmJZM2Jp?=
 =?utf-8?B?NEhwRmsyNkI3cHJ4NjEwK1A0dkpkSVFJcUJTckQzRUlqd0hJeEZKS291Kys0?=
 =?utf-8?B?bHY2TEcyTjhoTkNyK3N2c1VOb1k1NHpoTTFobDBQcDRQU2JySFFucDBlUDg4?=
 =?utf-8?B?cWgzREdGU0hDdWFyTEpYRzJ2cEVVR084Z0xFRTl5TFpaeFFnTXVTSHFSa1kz?=
 =?utf-8?B?QjRFREVKZ005UytzNzg0YW9GVTRPNlUyVHRVSDAwcGh0UmMwaDBTemdRc1hS?=
 =?utf-8?B?WnBNbEw1VkxhVkg1UTRUSWVFYVFzUXllczVFZXpJL3ErU0o4Rno5M0E5Rkt4?=
 =?utf-8?B?aWhua0FlRVVQUTJZajIwQ0FQcDBhS1ppUktLcHB1RFFnU09Vakd4cDB6WmZt?=
 =?utf-8?B?M2kyOUY4V2FoNk9MSTM4aWtUcEx1dEk1UlVNZTNmWEd6ekZ6MCttSm1PY0k5?=
 =?utf-8?B?MjZtWnMzOUViWG92Q0ZvWnBmckU4dUVIK3h4V1J2aUkyOXRBZktLWHZnMytS?=
 =?utf-8?B?NzdmRWNmaHlWekxGTnJVbWNmT2U5cFBYK0Y5Um5aVjNtWTdKZnVrb3l0VzYr?=
 =?utf-8?B?THNBRU0wMU04bTJBRnRpQWRQU0czLy9QbGQ3RlB1a1VnNTZUWUp3cVhiWi9m?=
 =?utf-8?B?WVl2WWpmWUNuRnVURE93a2JUckZHa3lLL2hyNGxJUDBqL2xhWk53dGlpUzVG?=
 =?utf-8?B?MHR1S0lWbWsvZStFdEhPNUxnSm9BVERVNDlIWVNaR2Y4RGtreU5mRjQwSHpH?=
 =?utf-8?B?anltZzg5SEJjYmFnVVdwYmoyY2FsYURmUm1tSXpkbU5XR01JM2NaSU4xTVZp?=
 =?utf-8?B?dktwZ2ZZS3ErMitzdTBIL2puV1hqYlREaDJ2ZFVJTXBNRWFoVEh2R21qc2Fq?=
 =?utf-8?B?d01STEtKdUhJV09ZdFZldDlleklVSUZCbnRBa2c1TThGYytoc0lCLzA5VUxq?=
 =?utf-8?Q?yw62IvzVCuxEFo4sO9RgoNzYw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b36cd0c-ebe0-4339-14a5-08dc24098774
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:10:52.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YS+pP9ctBcQLevW9gE1bfBF5YZwiJK3HoZ5Z4o39yKcDY3NuLitsOaWUitILLpf/VxZM3Vc0cGBEBiz4xRZ/lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

Convert the abracon abx80x rtc text bindings to dt-schema format.

In addition to the text description reference generic interrupts
properties and add an example.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ---------
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 74 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 31 deletions(-)

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
index 000000000000..405b386a54b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
@@ -0,0 +1,74 @@
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc@69 {
+        compatible = "abracon,abx80x";
+        reg = <0x69>;
+        abracon,tc-diode = "schottky";
+        abracon,tc-resistor = <3>;
+        interrupt-parent = <&fake_intc0>;
+        interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
+    };

-- 
2.35.3


