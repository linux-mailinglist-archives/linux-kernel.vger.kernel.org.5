Return-Path: <linux-kernel+bounces-64802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE608542FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A00B1F27813
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6248111BE;
	Wed, 14 Feb 2024 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="x+0oDbPn"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2110.outbound.protection.outlook.com [40.107.20.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0518E0C;
	Wed, 14 Feb 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892676; cv=fail; b=T8haz4Cj5QIPT+8hP6UABxd2B+Z7ExZ9W4QID8VMGBwWSZnqjFNGhhpLYifYh4Dajyys7klZMbMkuliIk8TpPFZDZcpiQ5WFwx2hFlTjb60RxNQwYkyh2RSsceg+7UcD47/+HVDl7geppjGB6ZpuPt3ZS3/p0cPr2VKPUFJ3Kr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892676; c=relaxed/simple;
	bh=XW7RUxS2fFBK12nq9gpHr3ocUsd2z7/lo/yKrDOa3sg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=DtBko21KDuT5sjDNLfTOkpJADQA1Xxo6+2P9D1435iRf0oFqPzVWOwh7O8QHa4oqCKpemNgy2fOE9BnEFIuOcJiqJves5NkGdfGbUSy97NqZgpiPiFc39x+rPAuyOJq8irDsTByMZN/rxHlATgq9/+LiqZvTnYnhkwU/OTfbJYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=x+0oDbPn; arc=fail smtp.client-ip=40.107.20.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+7RoFKPlgrZkuon60imC1iOH2T4MR1vEafeOCeMgTG9fpkf9tesIOtSIo0ZuzzdZwvLNOSiXbHvknlCs1HB2Ow+D71sD0D2+5M2kjR4Xj0gSzEhBPrmN+P5vW8/b89Hc0YF54zQWQZcbgxXiNS37qaEKZeIFutSUfVS0/BsEjus/ue7GatMzBKOxIonHmqbFfemU6TLuN2f5XQzwGx2syT1n7y0KRRO7g65Y8F0BSzke7mo8AgM5cRv4EwoYzeW6Z4ilzh3JrSH+J9vEP8kGtK4CB4VIS9xVr88BRbgksSjJ+hZxKefMPnV3MdXDbRUPduRZu/Wis2vfuEMnpmAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+3BwAXgOaFREP1ZBZj6WNbGzqnuCm0kgqS/W1k0CVs=;
 b=BIjUk4ssjRsZW7X3RojYrZvkaUzBfGVfOF2SzsQ6tGZHojjliw/uY+VyWvxJ7RdhMj+0F+ORfccaFb1LD/aLkin7SZsmTRZ5qX8EMwOjx8AX8SARLL7p+If1Quw0DJryPKQwXWaqHpNBNgmxrYf6LwSzq4+vo8z1BPieunkBBhTT+btseIp00k9QQEqJIRygGGGATII96FD8Q8FXN5iadqA8OGOhTMnLEACOSpROcifBhDhdW0lvYEZpzwBs9tGC2iXACURAbv6muVT7hUcDEPZFJRwXjGXckuN4hwMPZetBS2tYvV+fc6g28JOhBrgI5qo9EmB0K5hhkplUl77rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+3BwAXgOaFREP1ZBZj6WNbGzqnuCm0kgqS/W1k0CVs=;
 b=x+0oDbPnSAKiiEOMzAe7xv9k71aZnl1ro9uU9I71mkrnnEr1AuuNY+UZ3/RwGA57GNEwcff1jXLWiGE8nhJPppVnsvCYKSo8IanzZ26XXMuToZz0Q93X8yEpxTRxQCMeKNZoVN67MZAcSxa19UIarm6vZAz5/MI52fsVr35147AhFzs6lxRp953rzrE1CvLV68b9phXGusJyvbXoe/rj+SwbS/8ot6DeDBzet2PtTW8PXj/CfuSYHDQJitLeAXRbWXmNamJrCvBN2oK6BzsQCbNtSq57orqfJ4V8eblm9ooOINFGxDAlCO1kbWbdDjitbKfsRnhZohp2KeIB9u4L6w==
Received: from AS9PR06CA0722.eurprd06.prod.outlook.com (2603:10a6:20b:487::30)
 by VE1PR04MB7246.eurprd04.prod.outlook.com (2603:10a6:800:1ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 06:37:49 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:487:cafe::8) by AS9PR06CA0722.outlook.office365.com
 (2603:10a6:20b:487::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 06:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 06:37:48 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.41) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 14 Feb 2024 06:37:47 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 06:37:45 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 06:37:44 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: ti-ads1298: Add bindings
Date: Wed, 14 Feb 2024 07:37:35 +0100
Message-ID: <20240214063736.88283-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0107.eurprd02.prod.outlook.com
 (2603:10a6:208:154::48) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS8PR04MB8088:EE_|AMS0EPF000001A4:EE_|VE1PR04MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dbc749-9bf1-40a5-a834-08dc2d277601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 F4PpEkkTIefS3kLsWOP0QJ0+Qf9cQCWKOkHH7W5IFvVIljLZgDXba1QBLCU4UHi2BWWVagrY2Ajy2KciTrb/XtLLmlR85n8AD/dpvgtBF+Lqk5eqxiwnhbYVi0mBdXguMV8Q5Q2W7R7UYEQM2MLay/09/xlHPkFskJDVKj4sKmUzANXcf2wyQOomsrA/gU8HRK7CArboqK5JcydFdC1VxbUByzXsD/N90Ev+psYMtDv05RksOlVUgq7LyqBKP47lFIsKrP1BS6LsqwNraXs6t2dT3HmeJDDlpvC4X148jls5O0EX8WyvEGl5gj2nktdCWGBeNYxHzh3RFbIX9EjhxeHe/8WvuTZ/+n6zynfpniRUuMKrvKVpNCwjjIvAoDXucJNq8f6duo+AfrDBsVYgoVkMQVSbEMkkRN5hjHYQldTFm29+K72Ux3ns1XY1ACH/qDO9N3DGMfTQsputBDr7MSDE+NLk7gc03qpuQ8+IS4YV03TQF7wvvRDa8Y76uaSaAu0xyNpVzn2GpdEbbQneRYlfyXldZmY3E8dEcGaiHgh9f3kGgfHXaXWs+bfVKFGQhK+P7E+VyJNkAOyAxX9n6QqoHfnvLoVR8e/hHKqPSp8=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(376002)(136003)(346002)(366004)(230273577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(41300700001)(2906002)(6666004)(6512007)(52116002)(2616005)(6506007)(478600001)(966005)(6486002)(36756003)(38350700005)(26005)(83380400001)(38100700002)(86362001)(4326008)(8936002)(8676002)(44832011)(1076003)(66946007)(66556008)(66476007)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088
X-CodeTwo-MessageID: 2b00ee97-fdce-4b5d-bf7f-f04105b6ce1d.20240214063747@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b967e427-f7fa-4912-936e-caf944d735e9@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8d817d6f-1f4a-41d8-ef5f-08dc2d2773a1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ET7SzrE03UUtR40dDTUfzGh0nJCKCFwz4Gln3qsKxhCBR0x8pMTkHeNBYZ4Caz1KZOhjqARFaSMjhQNY3SDfWlbT3Ue0vdx5tmSvsJ8bw2jeHp9NwiexzUo5NowKgXGI2AvC5SmRkOr0GuwtZzSuWjs2zeRfLhbbqMl/1LRHLfEtUr/p23BYZihC8yBIw/9f/F7lfuBAtsIbLRADeI44YH0rFzmVF/q5X48Ti8nUte4jewSFmuT4TYAkl78kGug6rIhT4MTiCA4aY/In5HEdisOepfrj9Mx4ZZKJ51FoGtJgdmkK0s/4fh0yE8K/yTCiSrZ8EEsHZ1HlYILNl7DGuUQIUKCcz+4VtRjnCDck8hCoXQ8rto4imlyOzXMqsdYnzgyDcb+OuGNCe2fOQp53+9h5snfgthU6jCzAhHjs1LBSHaKN5UarS3NvJpWcii1e3LItVdZQcg1I1rQIEFX6kMhvQX9eA0jPJxLZjKYvox36Y7AoYTpshDFw4ufkwDUX2tUYi0e+iBB7/csreXpw2H7hBoFWWQwuKI2gpy0wGra0tvovCuFBuI3bBbHoeQUZ/C7/w5lcPLb28J8Cq6l1rA==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39830400003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(5660300002)(44832011)(2906002)(336012)(478600001)(966005)(6512007)(6506007)(6486002)(54906003)(2616005)(26005)(1076003)(41300700001)(70586007)(70206006)(4326008)(8936002)(8676002)(6666004)(316002)(83380400001)(86362001)(15974865002)(356005)(7596003)(7636003)(36756003);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 06:37:48.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dbc749-9bf1-40a5-a834-08dc2d277601
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7246

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

