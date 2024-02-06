Return-Path: <linux-kernel+bounces-54381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A684AE8C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EF91F239E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043A12880E;
	Tue,  6 Feb 2024 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="cmWnmJNb"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2096.outbound.protection.outlook.com [40.107.6.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AB482897;
	Tue,  6 Feb 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707202720; cv=fail; b=SvZlkmcAb6O0YDlcZAJ9oHp6sY5j58sij3dIEAZyZzYRXwV6LDVrD0ivHHseIhqqx19F89ACHzOGHycSyr7K2LmI2Ld79Az62SK94fSqJGBIbUWCcFLSGhHdWzQP6K9KYdHyWLymqOM9NXSDAwmbHgBLNgKyCXKgXfBFbw8P/VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707202720; c=relaxed/simple;
	bh=hvUWXNvGIfjXZ9YEhKWqj0hh61196rXpWIPF1Atimi4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=dT6V2gvqLUDGnSTaP2BehF1WZug4UJddQYpK6fhfZooMlVSSwyHY5OhCi7es8UIKazJ7SXBYgOUIJ1f9j/8s0hFPqM9WgJrRnmDl7kiIuR9bJAAIolfqMh6O5mxodhcbAU7O5Kzsfc5/mTjy0cstCp5A/xse6qTlq0kKH+AU0B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=cmWnmJNb; arc=fail smtp.client-ip=40.107.6.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBQVpwQu15yA/jfVoRH6SDqK5QMgbcHbUsgGz1ATZfJ9SBtxDfewAxkUIiW/Nji4dCU0mcD1spdbeRcAqtUMQIGyR+2/mc2b2cx5yGpXQTqbtdMaXvqX3YVfBeywjvxEzxpVEKBIG/gEi4eZcd0NYHbbvfCYL1R5dKQNejNuwQcIBfZWimCEBztIFVV5WdlmnvtbtSMD8YmPcy//nDcSjDLndQe9MyMEf0rlcIO2AeenbbQJ2F7AoN6mBPOH03llm+9GsHf7Dg8IJPoOtC8zwN3z1fklyH28cNJ7Svoa7yacoVVxdJS2rRvDwV9cl1xizpoWyYAKkEn+PO05m63bgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDbjHSh1/fIvXfuARBVeEiC8XjSZLW0jvU5KYnvO8mY=;
 b=PwJ3v/7nJqFMBMhQt/DXYZ80LBGaTdy2tlbMwvu+5ppShDHoZBeYhJKZSJPDVIkFy0cVPR3/ySNylP3euFC1jw93tW/9Mdf4FJkJ6sC/TILIXEyDx48mBOJu9VNPPJ8kWILbX/nouxe4iQTi/Fm7Q8Hc9VPyGPtXdAzczUKAwJwDsqnltPbYhVjKavBurvw8RAXiDeIMWb78eYc2XbKmRwQxuwg63cn6TRmusLhZPBdQ7uczc4iAljaGRye8IRyag0cNaWaClQC+/Fzlw5UPlSEqBW5XHfWs4SP5snIR+8tZlPkhNdat5h11DdKB8X7i/gjHrtCqOTYVEAHGyBLdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDbjHSh1/fIvXfuARBVeEiC8XjSZLW0jvU5KYnvO8mY=;
 b=cmWnmJNbYOpaWFMuNvY/IXbMGL8Fbtc/pUv6EH1fDBOafRb4pH/oLju+u0r5OEzXxv2nFT4+OhYx5dBgPu5VIR4gzU7V3vsQG5FSSXJCrmFX1HbojNv+k7qi8lEEuOaoaQ8Wu9IrNsUXFbkYvRekFWJBQA2fI400w8/17BrsTg/C0/DfQM3s5wlheXLyL+lMdCzqog5/rHzfwXKj7YfunS2fk2JIuRm/0THerQGvpbWJ6c90YJNUafWzWmxzJgEuYTMB6sZbOyDH//kV4kpmlVHyoPKjvjLwq6L6AdzReRSl2yXubZ5Wx2V9x8r7fte9Gs+JZwTAxLsJTgofXoEIpw==
Received: from AS4P191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::6)
 by DBBPR04MB7754.eurprd04.prod.outlook.com (2603:10a6:10:1ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 06:58:33 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::1f) by AS4P191CA0046.outlook.office365.com
 (2603:10a6:20b:657::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 06:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 06:58:32 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 06 Feb 2024 06:58:32 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 06:58:28 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 06:58:28 +0000
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
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: ti-ads1298: Add bindings
Date: Tue, 6 Feb 2024 07:58:17 +0100
Message-ID: <20240206065818.2016910-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0077.eurprd05.prod.outlook.com
 (2603:10a6:208:136::17) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DBBPR04MB7787:EE_|AM3PEPF0000A797:EE_|DBBPR04MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca01208-57d1-421b-7a16-08dc26e10874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 AbO/JB+lGGPMge7YPKbYdH9Cb5wEiQlU7ABnDega3hW3ogBVQmDn72nNqTDGhS/xnbbbgOGK3tK1SrCgcGYSz/jKkirCfiuvPf2cYreT0qXwv6VNcff90KnwBvbpoxhyoOYmcs5mcyGFf4A/I39XdT2e14dDHNBRnYJFgscRJHI0LqoSVexrg5Vzqx7FctBtOiTv8FnEZJkM9UhG7wI4bHAV/6Fo0zvE0dk1fzysKK8BYN/AurXjmyMO8K/3Pcv4IN4PPJWZ1n9V7kxIMrNRzNBGBeaAEDwXoPZg8Db+S3MtpLswpdlXpSMhUzzZqmKU4xaHFI5R3Zwg9OIa/7hwYVVec2EGLI49Lzf9xp30hqi9XAnWr+TJhMm5BzDj83ZcXW1MOaSGVagQzCgSvVCtaoKdsAbHAD41ZoDLIN6I9Gb0cbYJeEPlYgjW6aCF2rPXAV33EdqEaQs5hw6RI3nUdWp9yvAfCUEzHveTAJRzcGaUoM7AIiqEKdJYn89cr/s02txc60PnntWSUg5NVLSZJb/v6hHznkHVWlPJMaEs8isukRpLM3sD8qlWjqpH6LE4ni6se68F18KZvWcwMsG+BYbCPQiC648OtvtD09XCKHo=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(396003)(346002)(136003)(366004)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(83380400001)(2906002)(54906003)(41300700001)(26005)(316002)(66556008)(66946007)(66476007)(86362001)(38350700005)(8936002)(8676002)(4326008)(44832011)(52116002)(2616005)(6512007)(6506007)(1076003)(6666004)(6486002)(966005)(5660300002)(478600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787
X-CodeTwo-MessageID: 0bca6c5f-55d8-4df0-b6fc-753b31b90f66.20240206065832@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.ad72f8ca-a017-42d2-9c07-f17f282264d0@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	703edf6f-83bf-43e6-c2b4-08dc26e105ae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7d6SypoZPzvZAdqZ50Wazq4dztl7lSJxswlcZcyAP21BSFxVkSM1GybPmBWkAgTAeHPYdwGC9L83vpOZRPhq2pD/AmvbBlgBr7w94AmXsbaJtJvEAEaVqHxtdf2i0w9rRz5C3a/WGVhbuhi00EcuJxVJqG9mioK9eAGc38qCpK5umfta9iaikugUNKzPq1LKPeWE/9j4X1qKmfgaTeDmZ01xlexZFnzyd5CSHOp1Gih2EnS+4b0viT2gGSF+bnqUEF3ByHBtb5yplgVyLrDd3a3po1JAn7+vbc3YjS+UdotH6kXALSUqm6OI5WF03SlIxXSLVtq3URUCVqb/PfW+4ggsK5YflUf8xi3b7sh6wtjW1GkvulePJTf5dfWruujAHXb2surqJLoOvilZEzz/1zUuG+upVqD7KQnXVEtRvq7cNpsImksYPy4iQvQVaurTnYkK79HVAoibB/UbOA4C+4Ef8jw1a8/HdlUqmluAzL7kZb0IdGHrKRXnBl9Dv0+uCy0UWyPT1EhkwZqP+8ivxy/Koec1yaDQbFG6stsiiL1Af/OUudO9gcMDZ4RB05EoZBOOp7uVDk4tw3TKNFBpkxFtUbVC0mOxMghfa/NdPZAE/CgxZViXsUE8nll0WaAnKpe+TWryf+epHbqUo8f77PuO+3j2H24cUz28X5cp84DBma4+Y/o21WGeJlDYV/C6
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(39840400004)(346002)(376002)(136003)(396003)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(36860700001)(7596003)(7636003)(356005)(83380400001)(2906002)(40480700001)(41300700001)(47076005)(70586007)(26005)(54906003)(70206006)(316002)(336012)(86362001)(8676002)(8936002)(4326008)(44832011)(2616005)(6506007)(6512007)(1076003)(6666004)(966005)(5660300002)(15974865002)(6486002)(36756003)(478600001);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 06:58:32.8615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca01208-57d1-421b-7a16-08dc26e10874
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7754

Bindings for the TI ADS1298 medical ADC. This device is
typically used for ECG and similar measurements. Supports data
acquisition at configurable scale and sampling frequency.

The device has so many options for connecting stuff, at this
point the bindings aren't nearly complete but partial bindings
are better than no bindings at all.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

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

