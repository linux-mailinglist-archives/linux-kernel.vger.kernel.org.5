Return-Path: <linux-kernel+bounces-144739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB77E8A4A16
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617B62834E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD140853;
	Mon, 15 Apr 2024 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="PVW7RaRp"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2117.outbound.protection.outlook.com [40.107.6.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FB3BBF5;
	Mon, 15 Apr 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168810; cv=fail; b=RtV2XDI2wrqSTPEhebLRhQQuJPANl4BIFRfhbBgA+0EjLMJsQMs49/1ejRwaI6oKeLs99PiKEDtSbFamaBzB2RP4QyTi4+bRuXGVEVw18ltY7s8Vu2lnWtzKNiFWWg66aPYKGD5yH4dZA2x4xy75NJ7M8HZJPZ53ipr7SakTA0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168810; c=relaxed/simple;
	bh=u2jNXUdlEl0kN1j8OchrByc+t9mhlXMj8KWzl9eF8sU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhjMWt6ZcvspOdtrB4cFslpUXSD+PaQyRMIIJs/hRHHh9HLMTqsnheyq3Yz5Enh1esyTmFCqmUIoFzAeKe8Ujv4CfEsAU3JYPx2X6m1+m80bRf1Jdp6Hx5hw5WTFaSjSsFlmbjJjf1HWvj71QbCZKEQNQTg+KkeziZUvd0SdlG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=PVW7RaRp; arc=fail smtp.client-ip=40.107.6.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBG5NhOQ31n75EzTLGL3PvtFNml6loPKlnZblWJRYdLUyAmt0yZeRoLSrgHZJwQZfAP+PF8QP4tfkbaEk/YoX2xTkOICKm5IiP9qz5MeIsONY223q2nb3rDtkQ6OgdWY7vi3bCOYjj3V3lzhas3ajadsiYlSv4CWHf08l/4d064ijTwaQzwqEmzfBF5RH8/6GBMCPVPjZI28orYEthZ985tEUCqK9lUNG0NG9v6LQQgi/sN0EKuv8mjd4WypH5fYyxveOjPt4U43G6um5iDZKSx9CRjfRdrOkvlRmclIi6dhy43oiakdSSRjB4OcaEmqTpeAGv8cQYSh/icJk6jISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qkr7nM727EHH45DBlYjU1b/MAYY/KynsP/yC64XoSI=;
 b=EbIBfSMOn7Kh4i8Gv0DOjWFd0wtKUS5JTvxFqF8ZzCRV77DdyzMQM5gkmML3TEBeWAnQ8sfhjRGN4zmgKKgqX9uYZS7v3IyAxIv7KpXAA+i5TEi674aqANDk71E5O5xTnU0cs9RQXM4PAYkp68FHfLVsBbvw2IcCtUqIkWhy94LCgNiFe6gosUzyUn1TzHIh1IyySnt/7qXRM5G+FIZiJdL08JNB5tv0QwCTEBUsVJVJ6SyHwwMeFIlj0HXfN14cRPoX6eyKQ69wKkjCoIwoaEEBoXMTXaHe58X406uI2UlRVhxULHWs5m9jiN6h0gP9vKSOXNuBGptncVfPJ7thTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qkr7nM727EHH45DBlYjU1b/MAYY/KynsP/yC64XoSI=;
 b=PVW7RaRptLJgD5x/gBS6C5z0X1ilEp9WYcv+3+yZ3KWYhzooP9Rxe0Wa6QGtBb+vgWmXxsoJ7FCMO1xD0HRS1uGy44sJN93zEdJiBBZKkWdjucwbTVmgvyP+SCh60WoqbfaaHdAzN124GTKHTpLVronnNBtG3zOreSWc/geM8y3eMdfMD2HYs6Vd8TgxW/+wchdhH0D6hA9dWAXWs9zPooPA8Wy/wME1kwEBOPMVFpB/qSA7imNGIEzmSIr6MwCqFryX0HL2oVkaixvQbMS5mSCjlU5OtJdzyaMYOKmSqIKwz1iiKqXdSJp6T/siiEpWUWohrlekPosO0hvB1Q/c8g==
Received: from AS4P251CA0003.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::9)
 by PA4PR04MB7968.eurprd04.prod.outlook.com (2603:10a6:102:c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:13:25 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::92) by AS4P251CA0003.outlook.office365.com
 (2603:10a6:20b:5d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 08:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 08:13:24 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.105) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 Apr 2024 08:13:23 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:13:13 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:13:13 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] dt-bindings: power: supply: ltc3350-charger: Add bindings
Date: Mon, 15 Apr 2024 10:13:04 +0200
Message-ID: <20240415081305.316107-4-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415081305.316107-1-mike.looijmans@topic.nl>
References: <20240415081305.316107-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.9959538d-6257-47d8-9ef7-78f72d89b9a7@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8288:EE_|AM4PEPF00027A62:EE_|PA4PR04MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b71392-f1e1-4f2f-498d-08dc5d23ec3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 9wXLUpS72pTYY3Dyot8GMKGc81wXqrJmV2D+rK/5nf5719YWchM9a/WQKg2BI9hGAnbfrQpA9L0pMzJlQGgHgeDlq9hPhl+JZgrZB7AwCYJEKW3RrMFUVxFDR6ruGbS1DNFKA8WrX+bPCGkQIV8Z8cjnFb1oFyC4VESZ0S7teolz5u5FHp5f9912R6NFloMWeyTVgf2zUkyTTSoa5ZTx48CUN68eqj3JcUuBtDjDeXknGYApyxobBap1iPImAQcgKN2pqfmw8ATEKWZJGf29uo9m0nMYcHUaqrRiXHI6uPv2nlmHlr21kHUfLi0Ragb1uQO1dkWuG7ehea9RH44aTAUresGVqZDdGcAir3WG52kIem4sVe/563w/3HC/yXIZCpqS8ZLEbGZmD4gBhpfjNcgS1/o66d4+r3ctYauzOmdBwZyzdAUJOOStc5DDbhAlrgyVRUZjUm9SIrRluhXD+NgRqjVOZFoA6OqM8SmvJTJf/85iAFIifHpZiVOINnAUKLDJQu6ojEQ1RiT3gLr1lvy47cdPDqGCOOgtBjPT/ktZDC+4s26jMK4gmY6r+D18qhLOB7jJJKDIKzOpfL7cO6/UQtZXpukfLTkMu+bAzVMdTpICnPGhO+LgvoIc108Yli4kFvP0SXWSHQamUUwu2Y0gSzfD1slQcegBosgMD3Y=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288
X-CodeTwo-MessageID: dfa4f5f4-9248-4977-970f-28c6487af4be.20240415081323@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0f4714ae-9dcc-4a6e-8bab-08dc5d23e513
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zdE3xn9FtIUA1nOsYGaLZNw4iCWEnYXji6Z5prp4femZJh4Imy6pAibN9Vcwd9gF04COBANDgriueKMUBinKDaLoJa5DTWxu9T/0Fk7usi/KjTvRx7JFMmWQT4D1QeQLSPqfAc6GO6hmjYjy13Y6ffxF++xBQn/jDvOXPZ+sTPDsJ752bbSW7nl0MFoMGqdP3h4IdxoUE+eTRSrDgqAohjA2DPwP0fSrYGoQUo6dvkKh4jWgMgsXubyFFm2nw5rbvKnRpuU4exXMtIc6ZEH907VPCoFownZuoeFiOvZ3KmAH2uHicS+wI3EVzlguMzFqg953L1KcSabt60kLDpyuG0pIkuBoEpmZAkZaxivUNPnVt8gDwKv7ej5pFQFpt3aTuDM03wYq2atYr1RIXUx5pgrw4ZTdmTDRanrtnR9Xfiv6QZuDcSCsorPgN6QnpZo/3QCEgxiu1hpvgCDRmv/aWnTGFF5qEM6GQ5a1uLPob7g5Cfq05Qtqf8vhBtv+S+Wd4hiARIjE9lLlpmCOqkk040Aw1YG24wxFP5kYniTr4lOeegseWL/D4g+nQJghcoLTl+bAQ61teRJGIIte9VKsyQ5+IQUnNQK1acHtHJNLGhtPi/u+ZmLTtJnhrCXAcuDx+qM/1mA7/Xmz5ZDghNJVz9Gk6xtkGJcgZ/t5VvgP+X/53N+9tASjb5dEdu/uUd/yMh74bR+voL5+cBJyj2u4Gg==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:13:24.6858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b71392-f1e1-4f2f-498d-08dc5d23ec3f
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7968

The LTC3350 is a backup power controller that can charge and monitor
a series stack of one to four supercapacitors.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v3)

Changes in v3:
Fix $id after rename to lltc,ltc3350.yaml

Changes in v2:
Rename to lltc,ltc3350.yaml
Fix spaces and indentation

 .../bindings/power/supply/lltc,ltc3350.yaml   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lltc,ltc=
3350.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/lltc,ltc3350.ya=
ml b/Documentation/devicetree/bindings/power/supply/lltc,ltc3350.yaml
new file mode 100644
index 000000000000..dca7fe0f0d8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lltc,ltc3350.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2024 Topic Embedded Products
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/lltc,ltc3350.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology (Analog Devices) LTC3350 Supercap Charger
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  The LTC3350 is a High Current Supercapacitor Backup Controller and Syste=
m
+  Monitor.
+  Specifications about the charger can be found at:
+    https://www.analog.com/en/products/ltc3350.html
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc3350
+
+  reg:
+    maxItems: 1
+
+  lltc,rsnsc-micro-ohms:
+    description: Capacitor charger sense resistor in microohm.
+    minimum: 1000
+
+  lltc,rsnsi-micro-ohms:
+    description: Input current sense resistor in microohm.
+    minimum: 1000
+
+required:
+  - compatible
+  - reg
+  - lltc,rsnsc-micro-ohms
+  - lltc,rsnsi-micro-ohms
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+      charger: battery-charger@9 {
+        compatible =3D "lltc,ltc3350";
+        reg =3D <0x9>;
+        lltc,rsnsc-micro-ohms =3D <10000>;
+        lltc,rsnsi-micro-ohms =3D <10000>;
+      };
+    };
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

