Return-Path: <linux-kernel+bounces-68882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089585815B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471A828280D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8980E1474C5;
	Fri, 16 Feb 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="SGeXpazo"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2138.outbound.protection.outlook.com [40.107.6.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61451474B3;
	Fri, 16 Feb 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097448; cv=fail; b=Mx4IzB8Y/foNCE3FGa+V0x20KtA32B7qNoyE1f8vBda5PKFdBVEgkNS9p4M26CaLXNLoEsDXUTGn0Tal7m6F6KRwmHdBjBaLIoEC2+z2/YwV0kbcEDcdoxXg8BD9sefZxL6XZALwNxyAHmZZYS6zE/7VDUCMijrn73K4z/B7iYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097448; c=relaxed/simple;
	bh=XW7RUxS2fFBK12nq9gpHr3ocUsd2z7/lo/yKrDOa3sg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=i1dc1x79c44JNLMVTynkRfYVkscbVziL5k0tdyHKDgNVcJ6WbIjqS8hcrQxmJZDMRuLWKogD/yxgjQQaV0b3b0kqAJ76vDI10gvgZSKSvjel7n2/4+YepG4Sg4j62t4zuIriWP2yTGJYLwTB/fGDR6Aojzzaft3NoLVLWfY5Qxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=SGeXpazo; arc=fail smtp.client-ip=40.107.6.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDeqlufBZaz4s8TpS4DI33qReZG79T3zphfP78BaGYw1483wtZU+XZQSqpkmtRLGVKng26Cw+xp/iGn33o2JtTlyTDoBEV9mQRCt24HjH6r+Yx5jniOMeXVZ+Qhzg+fyIXDJ5hEkS+w+HnzKImLEInVrgnoFgc6I4q36qEHM/iK8cUzmkMwTjPDRNdFagQKW69zNWuq6ygXhddO8KSXjKydh3dMBrw/SITLOTu2tkBKv6Vv5u3MHPGUq4wQF4Y8TcHv7kmNXHL7wJ0hXBywvsFYvlXHqj1JptHBvQF5ZjbQqkLor0M3z7XHx4c0X3K7Muke7lRRVsIHXLiuPoYxYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+3BwAXgOaFREP1ZBZj6WNbGzqnuCm0kgqS/W1k0CVs=;
 b=dZJ2qwmwpSJyneSs6nDwY7g9Um58NyQ9wjDgci/36lR9fgkD0XTPma0fp61Orn+BCRradHr/2a9v4KP3gvATcdHGMZrN4DbjcXVt2K/3OWUIYzjtWP4sh4h6A0wxU0Tv4+8FLaodsCLhu03I9s8Ra/kh607LuapX554FQIy8xzAStSof5PKoRZYzwGY851WbR03ofDjkdl8lVVXi0tyT7ts6zjRVx/3xv45cYiXJ3CHb1v69SKMv/Bc0vzAU3LVam026E0/COnfJ8guPgKNl729jZAxVJyDAy/+H4354RhjSLBO8KOVOcg7I1iRvlYI1xngiakJkynx/mIy8dHk2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+3BwAXgOaFREP1ZBZj6WNbGzqnuCm0kgqS/W1k0CVs=;
 b=SGeXpazoXXrwBrOdMK22y6GM7AsXGvtA22R77ff3+4BxcbfOeqmJ2FcjsViH0y76vRirI6L/R0hy4Dlfp6pVzh5BTqtxg1sbbqfKHQB6XI9TA/Ezu7GCvCIiol48OYtQZwDGzkcj8NXA6wlD43wQtE7hXS+hF9xGSl/X01w2G8OSfh+cyYbSKCvSi/kHHiCqcfnb6ViiTmnAVsDZZgGYvJ+eY7erDSRTkIiI9X4cA50Iij8CWY4P5GCA7ZxFuoVNe5gWDZ2XmE4/vm9eDnyFto+YDpwtnA++6Dm89OPOxCYeZZtb2g43RhcUgw3ny95CxzhAnq1uvIhhic0m8qjx4w==
Received: from AS8P251CA0023.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::12)
 by AM7PR04MB7064.eurprd04.prod.outlook.com (2603:10a6:20b:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 15:30:39 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:2f2:cafe::fc) by AS8P251CA0023.outlook.office365.com
 (2603:10a6:20b:2f2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 15:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:30:39 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.232) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 16 Feb 2024 15:30:38 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DU2PR04MB9082.eurprd04.prod.outlook.com (2603:10a6:10:2f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 15:30:34 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7292.027; Fri, 16 Feb 2024
 15:30:31 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: ti-ads1298: Add bindings
Date: Fri, 16 Feb 2024 16:30:19 +0100
Message-ID: <20240216153020.485201-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DU2PR04MB9082:EE_|AMS0EPF000001A9:EE_|AM7PR04MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: e7531b0c-34a8-4c4b-0892-08dc2f043ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 uRQR3SvSRJiwOwyEA6rO/Un3ePW+mz//sDejw1wZuJOi9Q+JOq7ldZHW4CgfUXtFtiWrwqjCIbvb38FVC/7gRWJV6PaABXGCvXugbtS8aiv+lxsuoikAMRZYYw6Py+5Ey4aNgxpsQqtKAOH+PAE+t9xlxaMtxfjOuFWyx/c54jbWqR4SYRDcZwi+rJDnbUUR4Gx1sUkJxeODCnU+OKYBr8ya+dLtL5ZG58uvo5OhqoDfEwEb2DMVooP9B7R03lsoEg0F8AgiKaW8WnVXrzMmsHmVzUKQE0ycVIl6bHCwFAWuel+Lb3VWFOdqkUzUfwfCJICWmeBq9FRG6zz0kXnW8DWHd7Klthal2CChkOjsBWFUS7q4geSCym/KN83ZDCmVxfDqmWWFncSGPmNXXJfEVlI4ps8bikQ6TGrtUXVJ57t8JyF//f2zJw1m0Dl89cON1N2cPJvy98nUaJTJxY/2uvHmwSS6nd91vTdJKb+v49FB12m0gdpzpefBZhWegBRpxmGMzS0aXzeo1Ft29Og3rr3G0Lgj/lbua8pgjwGpqHN16lCOwPKffijznDZ2yvgn5f5RyWUCdkZkwwkCnbqWvH8fd9b5FL/IWJYxpuMXNgk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39830400003)(396003)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(2906002)(44832011)(5660300002)(316002)(6666004)(41300700001)(86362001)(66556008)(38100700002)(4326008)(478600001)(6506007)(8676002)(966005)(54906003)(66476007)(66946007)(6486002)(6512007)(8936002)(52116002)(1076003)(83380400001)(26005)(2616005)(38350700005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9082
X-CodeTwo-MessageID: 7ebd315a-6582-4260-8176-3b6d1b43b89b.20240216153038@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.70c52742-e0f9-4db1-8f1b-864f11c71a24@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ae3419e8-d4eb-4501-4a87-08dc2f04363c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kbX3ySGJq0fAip5OlJnKOyQ/dZGV2u6SGXfSGBo+ql0taUfh1kAOzvmHj0pqjvx9qYi/E2tEQ9J+fqQNMQAgDYdvtxwXev4HDuktBNyEyHfE95gJkxWtLt0Y1t3BZr9K1hCmo3fQsUKU146FbtS7Imcgv6DyW2AM5J6R0qBJcH33H8YzYxcqojBiV4qCylpKcg1EEoy73ZXPdtxooko0fhiTY6HZX7G+c8TeniVMmlUb0iuUsMYIURwtcaW1ZzLwzHJd9Q40ILdwBWmp6Ls5750j9ykT59sqsxexjCz9euDMHGjPoiZ4Zl89iu+fmvf+tP41P5EBsuY6qgaAvWZAQTvH8GhLYDHXaupQUbhv8jPk+PX2zyVwGMwQXnbZw0avjQJIp/OpofyovFJ+YZDoIqgEDY5YSroZzNW5OJGdbi1SYKiRkzYXcdu5bQ8T1oX573iEJD+HGMA4YyQ/5PaHCXTCjRWQqA5IXg3yCC+z5sD3GdKTTdBvZNHqAhby2KDL/d4eAJkbmKmmbejz8LXBj0fcEqfSDLVDXy/bNsVl2pOcNfvXOkMWVyT8wINNRiB1ionxJSGekaofV7vXmgXwxoWzL6q78mNkHzqHKnDnHslekt01ijKIeGkt+AMCryooJ3Wdla7rOzySZ18yO3hbHg==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39830400003)(346002)(376002)(230922051799003)(230273577357003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36860700004)(46966006)(44832011)(8936002)(4326008)(2906002)(41300700001)(8676002)(5660300002)(36756003)(7636003)(356005)(7596003)(54906003)(316002)(6512007)(478600001)(966005)(6486002)(26005)(2616005)(86362001)(6506007)(1076003)(336012)(15974865002)(6666004)(70206006)(70586007)(83380400001);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:30:39.1715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7531b0c-34a8-4c4b-0892-08dc2f043ac1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7064

Bindings for the TI ADS1298 medical ADC. This device is
typically used for ECG and similar measurements. Supports data
acquisition at configurable scale and sampling frequency.

The device has so many options for connecting stuff, at this
point the bindings aren't nearly complete but partial bindings
are better than no bindings at all.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v2)

Changes in v2:
Remove "clk" name
Add datasheet and "incomplete" note

 .../bindings/iio/adc/ti,ads1298.yaml          | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.ya=
ml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
new file mode 100644
index 000000000000..bf5a43a81d59
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments' ads1298 medical ADC chips
+
+description: |
+  Datasheet at: https://www.ti.com/product/ADS1298
+  Bindings for this chip aren't complete.
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1298
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description:
+      Analog power supply, voltage between AVDD and AVSS. When providing a
+      symmetric +/- 2.5V, the regulator should report 5V.
+
+  vref-supply:
+    description:
+      Optional reference voltage. If omitted, internal reference is used,
+      which is 2.4V when analog supply is below 4.4V, 4V otherwise.
+
+  clocks:
+    description: Optional 2.048 MHz external source clock on CLK pin
+    maxItems: 1
+
+  interrupts:
+    description: Interrupt on DRDY pin, triggers on falling edge
+    maxItems: 1
+
+  label: true
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - interrupts
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        adc@1 {
+          reg =3D <1>;
+          compatible =3D "ti,ads1298";
+          label =3D "ads1298-1-ecg";
+          avdd-supply =3D <&reg_iso_5v_a>;
+          clocks =3D <&clk_ads1298>;
+          interrupt-parent =3D <&gpio0>;
+          interrupts =3D <78 IRQ_TYPE_EDGE_FALLING>;
+          spi-max-frequency =3D <20000000>;
+          spi-cpha;
+        };
+    };
+...
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

