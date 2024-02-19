Return-Path: <linux-kernel+bounces-70786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9C4859C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D70281C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7173B20327;
	Mon, 19 Feb 2024 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="hi4p21vO"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2094.outbound.protection.outlook.com [40.107.20.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F3653;
	Mon, 19 Feb 2024 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325446; cv=fail; b=lOvIPJ2Hu8M0msoIty1VxEVoP1ln+H7crIaJIqRr2NNFQEXjI5fqARZ9bYJ+w+N+A340cl/RRUmVpXJcFcN+rwqoVbmHWL9g1HmHh4vZkMTPH/JjVRKC2sGd+FpiCYC8qDkOAuD5V9WmZ6OUuTAiNq+aCQWfbZq4wv6nzx7/Qhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325446; c=relaxed/simple;
	bh=XW7RUxS2fFBK12nq9gpHr3ocUsd2z7/lo/yKrDOa3sg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=THpmRHaMBZoUJ4pnPr0wG2r1LtHjNc+23Ser/Urn6/Z58JNhebewNZbM/LQa0b8pvYZb84iWH/7beVjQKPXmtGQ9Fp010acMZ6HYLBkSNhAbUxULrz2CNSp/Z9i2Da8bl9iwTzXivZjTdO4/6H5gE4FwLlUVNK8vel7jllD7ozw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=hi4p21vO; arc=fail smtp.client-ip=40.107.20.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg4HLTPNQDXk+PRsnfq+iFw6jbj00A18T4gaNXMDzQZDWPWYbTJnWxOmYeaxvPr0utDXcHghELW7xORRzAZANx6xYZLCAQBNDRi02i5pVkd/tiba0DBp+XqJhpdJaCTjHEmu5zfbPcpBRc3LkXHrKBplY0nonVvUg/+POBxrhHEAiZ1E/R6LnIAh4ou2PQKP+MWBBoU18efRlPkhYO50yGJzUbrYCwdqic3c/6fB5sA3seNUTe+ZbMBuiwt4E71RaumO6cRu5JH4aiZmLKCC/3//PJ3LX1IUR+P60pwo+sOzSPO65qSMsaCP7VQaGsOXYhnynRPPllKx9MTRtJ8mTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+3BwAXgOaFREP1ZBZj6WNbGzqnuCm0kgqS/W1k0CVs=;
 b=PSTj6NZl/b5/WgtG/Iyh6xrAj4RUEmhn+VVO14mXQYBhUN7vStlmzkZL+/nBW+Xz9zaBT80xRbggimuZ8OzTGQWRm3kurof30m4Xa4Ly2wNA/CyqFB/AUVwvD8Z5afBJiHpXnWd8g7u+IqPrwnSAj6JAkKJLwYNjqRzfGwlWlYTBxuk09XFubwp6KAiAMZvFntDfUK/uv/ziCgwV09hew/TSsArMMIfFJfqUeVDDB3C8/1wPU2eW7wKcvOtiZrtoxIg3Z8OSWuxe84K3byelQjhgHKwrjb7yxbDT8G2v9xxgEOjmytjesXwJTTkQLwXWomx5KM5dfLYNIfYY4VXvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+3BwAXgOaFREP1ZBZj6WNbGzqnuCm0kgqS/W1k0CVs=;
 b=hi4p21vODJZ/hOQc+CKE1EBlmWH9+FHjHi16MHwo8AG4lq7a4gSOYB22gr9cOQF3/dz0AdpDGRspxomGPRLQD2ZPfmHKAz4t/LXYxzGuS6MyDJoyyFEbhG/nRIW4qdseEugds9QU3X94SwRH8lNEZ2j/aDeCUkY/05UWkgH6QmlTP4K92eCeVdPoEelgq6CuyP5ClCpqeW/riXeUWssYEVjHBApLCm1c4I6zMy3rdyLXdJkwpLzwCiQVgNWCvirukf1ecyo5GAc7xCGZ7gqqefto7twNpeijz7xmQIDkYSYJLuQeScfFfKTZXY6WAo1E6t3eqAezMQJPQ7CxXg64pA==
Received: from DU6P191CA0071.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::28)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 06:50:39 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::4b) by DU6P191CA0071.outlook.office365.com
 (2603:10a6:10:53e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 06:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 06:50:39 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (104.47.0.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 19 Feb 2024 06:50:38 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 06:50:35 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7292.027; Mon, 19 Feb 2024
 06:50:35 +0000
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
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: ti-ads1298: Add bindings
Date: Mon, 19 Feb 2024 07:50:25 +0100
Message-ID: <20240219065026.578517-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0095.eurprd03.prod.outlook.com
 (2603:10a6:208:69::36) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS5PR04MB10042:EE_|DB5PEPF00014B8B:EE_|PAXPR04MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 942d2320-81e1-4c4c-7ba0-08dc31171573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 AEm0o5ZcPY8nkl4jjoS4VvDUrQfP8rkuOhVi0O6x9AdG87Md7dP3pLnP38Bmjir5zxSNcxbtNhEVqKWvv9kOcbK/4aUr8WIUW3FHzK40ZCHGVHzurKab5D6kTOnPkR6w/TFMeqo3UZD0Odp5s2tlpHH2IXHnmzZtdgXrzpGMXpxs90R7PIwniKZ+yCwjUjeJMIIyMPWHVRw0mRnbYNNCDdrPI++aOj5wIOS/mW0D5gPcawdH4rilXWN59rRELEDyRvdjaxrg65bmUwfIMK4F5hl4jd54TRf4XS5UjsCzK8F1PLYZS/FSshvrrJyxJGiBlt5NCV0UwEa3/KGFj9I9LpLhOkyYWOp7erlIPKgfKTbX++/g5mEuzTF5U8Dehdi+sfT4AuIBW27PvbWKdwLENLOuGV7O71hXHHBjKTWnWhH6vzwss1YrSKiviJwVuKAK5XQ5P6T4z9YLgd/W2QP45lrezXoKW3ZVTWJ9UHuJ8oLeKXqxDrLBzH5u6txkhBrybjppdUDjO26enaG+8Q7jbPDxflrRmKRIW52NgdjkZb+LK7pLhwbsWYxSz6T/TDHLY8rsDS/J8pedOpxbA9IYmRjKKUMaoK3pHIZVf4vAq7c=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(366004)(376002)(346002)(396003)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(44832011)(38350700005)(2616005)(36756003)(1076003)(478600001)(6506007)(26005)(6512007)(6486002)(966005)(52116002)(38100700002)(83380400001)(86362001)(8676002)(4326008)(8936002)(66476007)(66556008)(66946007)(41300700001)(54906003)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-CodeTwo-MessageID: 070c57f8-bef9-4f6f-a43b-ee46d3e31a48.20240219065038@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.34241f85-94f2-4dc5-88fc-82d371821088@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0be235c6-73fe-4f77-5d8a-08dc3117131d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I/IQtFwVWJE73fHbACyKNXol187UTSs7QIbKgRTNAJAbMdkmIwYjny4F81jQA1PT4WCVb2/r1ek9zWfRuK4zRVQ638/hTC/WKJn3r5zJhjRcARnOXAFqNMFy0AdP5FauRPpjvMc/+FbmGaF7sF/cf9ZSUpGGC5HesgysHupRy45pMQ62aOAH1NMkxZvITAZ+iW8Tc8fhAzQ0ag50jkud46OQB5Kmzvb4g6ZTiq0rDS2h7pgPTQsDnw9zwkPT64XAtDoRxEdojuO8kGzGPeBwWFY2ZQXk+RdQSh3+Hzp/3qNqRdx5wys6sdOg326/tdxql881pvz6W5YfrRUufeMGIBBh/KJ0JIZCXcbE1R/Wb8tYssL3Lf0zTIRUwWdnxtVh1vpy9lt+SnN21ksMkZICh+Y35xybzZgNqdJu0k0PQFYVcSQujj/xlUGxQ6VE6eubayOKexv+Vt01gmyDKS4+l58PNMQw28CY3p1+OXfjtd5ui7TaSwV5MwR125uYqEOWgqTgdIqhLD+ZpMzWv+S3Y0PiNVR9Bt358wEYirveCaRlP1DbLYePjdumMaDjeRa+jW5txRIPJQdyKFAkZ6rRsKHSG/DF+PwHMkN730W1Y05Jz3LCeP61TzauWP7hP+TdQifEduWZNWtDzChez6SvfA==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(39830400003)(376002)(396003)(346002)(136003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36860700004)(46966006)(86362001)(15974865002)(36756003)(356005)(7596003)(7636003)(966005)(6486002)(6506007)(6512007)(478600001)(316002)(6666004)(54906003)(83380400001)(336012)(41300700001)(2616005)(26005)(1076003)(2906002)(44832011)(4326008)(5660300002)(70586007)(70206006)(8936002)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 06:50:39.1791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942d2320-81e1-4c4c-7ba0-08dc31171573
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

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

