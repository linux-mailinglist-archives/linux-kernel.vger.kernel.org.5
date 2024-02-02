Return-Path: <linux-kernel+bounces-49718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54713846E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BCF296F33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275B13DB9B;
	Fri,  2 Feb 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="hAMMuES/"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2134.outbound.protection.outlook.com [40.107.105.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7C171AA;
	Fri,  2 Feb 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871565; cv=fail; b=NX3uOrj4wiveZFXV/aOsYE6OfZgHhh5Ss6rCiB3IiiWujEALxCLq+Mc+DOsRTWQGMdgBrtSne9Amln9ttJR3IF32FqKeqW7nDmkb9yBbV9AfJa5Ye8lQu+dtzXn1ZwaVBqTuVDC+NOpBs+YTtoGQi9TnuJm6Yp8PZhe4dslYT30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871565; c=relaxed/simple;
	bh=JhY5/9u2l/8nbusigI0vTkh14e3ES605y0HpvJWrvNo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=RlhnbB+SnYnT8qGwVlVkUQ/OAxLlhdVrW1NnoSirBYH1G84Qs7lyEifHSznPcmnZS/OOr6KjJVdd4ly0IreadjVeRXh3tlKuTteyktJnTJXJYyx1pcZKIxmDdv/X3ZXHZe0RTiCUFOH9Zgn+kkYPy9G7POkl9rMP3VBGjFUuBnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=hAMMuES/; arc=fail smtp.client-ip=40.107.105.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQrEAYazqw+AWxV4UuMcvurM76qceR46w7jAtY6IYP69jClcardBXdAcNuHSYtIXV7VsH8TuzvZHpQOny/yFHgoJ7FDjk4Vw/3Bp397pf3Z+M1W0kdLLFm5fqRBxukbvi8EnTknS3D42w20kFAhDbnRz3rgHQK3L2K0IG26QKIOL0YqsBlO9UF8r3VkxHiZlZM5jr9DT8VvnHT+qeNLpYZFRdonknWpI3B1Lr4GiJfUNs7vduEdSlyp4p/o+kv9feeeZTRFj60HA5ZVnkQwvqr8jyrL/VWo791CstKtGrGlBpBFmAPE5XqpqGefu2rHkY6WB50nVzneCWqahKDp0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhDDIo9ty5H5gi/d+SJdGh8vssIBwSJNGt0ebqdb2UI=;
 b=Fb4rniQPf0wH+chRIRRGdFyB4DD7o+kVDwtDjWqsaOz19E4g3CtwQGHFjIq55D074DPE8lmhp+USSRNXsnNfH5JcRC/MyaAdZ5LE7qYotzKL2uycXfka/FSi+JsUX7PR3hMm0aIyGqoP8EcfbNiV1l14H5diRbeUVn7kIbVOsXZdqiluEG9wTFoXeQ52lKyDp6KfbT5TjP3KCstzri3sH3l6OlRdqKIhl61InoXIYDI6FiZNvn8EuRNjD16Jpnx539tA5M94HE9sl64gGnyIgOcrxRj2XuTqdurXwZ0bt5bm3iCLd4WegdCyBk1thjpQo/3pDVahShotJtL7mpzRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhDDIo9ty5H5gi/d+SJdGh8vssIBwSJNGt0ebqdb2UI=;
 b=hAMMuES/ffFL608+OAdN5dOJrSSA5gJ6mPp8oIygX9oS63Jkt/tQF4AKNiJklarBLgSZmqmAJfmUDr64GuX4mbFw+3QQRSprHhIg9hjYZA2GQN/VET2cTS2Npxn4yxSFull+E+k63SqKpF/69KkkZL8ybQ7rt364s6Zd50Vssfz+/t80VPGviv7V4DO+oC94LlMO3ou2LMYXIhI0ij6zMYLcpCQAhw9m33hmeFyBbjI8aqxF89SbdJ2MSBSUDJoE8jzMX6Gb2RAVYZDLKcOv0uuVbrYYIXtvjZcv2uoiO52tggsFWDJJ4rNlYv8MkeQOxcu22DClZZxyETOSrQ6ACw==
Received: from AM6PR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::30) by DU2PR04MB8888.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 10:59:18 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:20b:e0:cafe::19) by AM6PR01CA0053.outlook.office365.com
 (2603:10a6:20b:e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Fri, 2 Feb 2024 10:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 10:59:18 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 02 Feb 2024 10:59:16 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 10:59:11 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 10:59:11 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ti-ads1298: Add bindings
Date: Fri, 2 Feb 2024 11:59:00 +0100
Message-ID: <20240202105901.925875-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0104.eurprd02.prod.outlook.com
 (2603:10a6:208:154::45) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS8PR04MB7991:EE_|AM4PEPF00027A66:EE_|DU2PR04MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: 65949ad9-c895-4c9c-f811-08dc23de00dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 3U2ErhR360xAbkZhRqxZF+ktFIWBKRSJSzhFWXY6vPHz68kJKP+qdZ8UiaGLqvCPdlrMR2LPclqWcYiieTvTG9rxRiexCYLTqY0xMnv861BMcnJxaby1iXqNG7eiwPuDw4vJLXioZJClWFFuawza6h9gA8mb4G4GwQqqAZMMiVhQdwzv3nJlkonWKrYws/vR9LVxvEZGDthMkK04B5g2KSXuVnrFhRl4niBlMEBJhuL8QFm73gRxMI+DXzmkET1US4LspdGu8Q1ghSf4kLqcca0R679j/2leXy08cvQyQmVnxTt8b9UphFMKMOMzwoqmg+crl6hRYSX++nmuE/chDPad7owBLpuY9TvoBjgk0HgaAXeF34gbn/bpeTqMWDSOyxPnTpmfIak+2lo3GuJY562sMRR7wGBpaYQRsjlzNQQ4Ab5m78HIEk+U3Lc1qXlqlWOnG9ZhH8sCyct+IC7IiklNqEwN0TlohH9t5WdcgzMftizHiTDYSMZUhpQDpgt7DxmkTcHmTg9P8XIpT5PH3ixGlZRI8P57AtdYe4HZOzjoMGVFxikfgck3mos8eaZ99svVhb/V6F8NwQURDjzOTB5ALrVEngclSUFC/Frby55lRdS2t6HCrXS1zeGsupY/UXAMMs5R9DD7HZBglb8/DQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39840400004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(1076003)(6512007)(26005)(38100700002)(2616005)(44832011)(66476007)(5660300002)(52116002)(4326008)(8676002)(8936002)(966005)(6506007)(6486002)(478600001)(2906002)(6666004)(54906003)(66946007)(316002)(66556008)(38350700005)(36756003)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991
X-CodeTwo-MessageID: 6e63819d-57ca-4ba2-9096-614e5872ee9d.20240202105916@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.50455eb1-2ccc-4e6a-b8ed-0c142743ae03@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a7a9279a-62e5-46cf-7f6c-08dc23ddfca5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q2YlxJtwp2NVyv3qwgTgx0zRjHXK9iKvHZYg3x5eiLEdgUXsXEdtMnAAid+arNJwKe5tI5sAYpwcskN3IPXlN3jLiw79Vu2N7PHukmoudhX6Az3vcQ3ABzktpRisqN7Od5MvgQvhxOJpMAWrLfCAdp9P70+1S8n+v/SZATsrPApOBMkO7rZ3fCN3ft5RJbsdHQmygpJ31cP4OQDEmLBRpbKu/D9wgnVzDhfVLUp5sUT2LoyeJG5Y962n8LsEsZQk9Wng22XwKlxCbX9LZfuDbcReXt/kAM2dJor9b9orxJ+9Yj9iadVGHb54v1S8QXtNadPMFly6Db0bKqbgki7kTo+SXxfOKB20JJH5rAfSun+YQOzBkjm/u8s5bk7/c3K/jlQHuuw9m3ZHm7U4wQZBZNlkgJsH+SQuvAh2lvTHIGn0Qdmq502v5y2xbQNzDuqbpP2dgKSG/PNfylHPgdJTXMwEv1owfvtu/FMe+0xrT6+Fr/Zk/BhF5rzEn8V+bRtS67iDJmNobXrMCpbXN7VEI0vbOE6XMHIKbHszEwahJ6i0nKQk5C0XNqHQTQ+s6mA3/8qCC/TwSAN0n6m6icUHHiJRMIHKXrKi4i00D5O+QUgVQH5fw/2Ycxd8Kj64WKJ5U770IffufddJSUf/bG8inVGy26phTPstt6zsmbrAoOCKDbWDa0HXyIkk33DnCB75Gy+tC6jcw5XHSt3WSxKaAhoEl9CPmVEXkEb/uGanIsw=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39830400003)(396003)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(46966006)(336012)(1076003)(2616005)(26005)(40480700001)(41300700001)(36860700001)(6506007)(6512007)(7636003)(36756003)(966005)(316002)(83380400001)(478600001)(6666004)(6486002)(356005)(47076005)(7596003)(54906003)(8936002)(2906002)(5660300002)(70586007)(86362001)(44832011)(4326008)(70206006)(15974865002)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 10:59:18.3557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65949ad9-c895-4c9c-f811-08dc23de00dd
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8888

Bindings for the TI ADS1298 medical ADC. This device is
typically used for ECG and similar measurements. Supports data
acquisition at configurable scale and sampling frequency.

The device has so many options for connecting stuff, at this
point the bindings aren't nearly complete but partial bindings
are better than no bindings at all.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

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

