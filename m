Return-Path: <linux-kernel+bounces-134859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC81D89B7EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF713B22107
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4523772;
	Mon,  8 Apr 2024 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="ggktuWgE"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2108.outbound.protection.outlook.com [40.107.22.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3511CD38;
	Mon,  8 Apr 2024 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558969; cv=fail; b=KoI8ejRZyIKyCGJBm0PW6Ec/PtW2yoQI1T4HdWsqpYAMaE8C8mZBDrGk7nMM+9WyMNoxOOfA+exnuaKC7LK08UUchsaDhFwE778EXC8E+6zpu+AUThpDE8nnTeBRc7LFTBIqOYqyp7IyY+HEL6uWO+trdH6wLV2GZV6vR6b5op0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558969; c=relaxed/simple;
	bh=94Y6Dow/w5cvJGODjBlu67oAe2aFBCU277b2LUs3oi0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=FIR/ZrkcjPCiCKeKHonDqFJLGsErb0Y7UOreCbqTcVXQjYjjGus8DuwhKxMJ/xqLwcPM0JnUnRWkaFBIyTkj4CoIPfGaz1QiAwjqBYmWqPcUQCGRNttea4yMhyHdJV5J5FxZ/m+ClKVFTJKKADHpjehk9r7lazxLXeEKTXG7NHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=ggktuWgE; arc=fail smtp.client-ip=40.107.22.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe+tn/dp0I/F7NS68lr8tilIt8TchtRF89oZxQbeRyKteDfE21LPmxdwLEn17d/9mSEto4GwaQM1XE5cvT0TDgThkyUEyQZRVhzBbOqG+vrvLFZ1SYWcYxOG6i0f9OxfZToyCFBmq0hzDdsq+AIYmVdTiE+9QffDSJrf+SXEv3lxTu8o2nQfFy7GImrJm3wkywS7nhCQua6MTb1XshPf1ls70EWS0bDMd0LkQ9+JfScpIAOquZKrflpJcPqQ3hpvGDDxwomTFrJqqtoq6adyXrxxTxUQ1o5VRAIvzH86hjTmkE10U2P4cORfOPblMNy5ieWIcNqvo9KygDsi7Az9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0EPT6RL9t9X1m/CVfHnUThriaZ5vQWLHvYj67C/HB0=;
 b=e2Qb/bIIoHwDiHvrLp0dKYGwwDzx0OMgGRfFHNLyiVuVsqIk4WVXkl9bmwyAlI0MNTg0mZ3EZhMmdmJXM9sCAovqYrUSopaXRi5inhSFS6UxBpskJ/hQsNWjt3RZkbXfflxWJLwiGJpzZ3is98cftrQk659TkZ3JJbweFq3eVf5ZDjbOgU9BKga5muFKQABBEjLevKqKRlFnj405nAQp9VLI8Q+y4TLOhM7TQE3y7/r/soaJPUrpmg3Y2uySTabVS6qgOa138lVmOapKlaLY3OaSuPNzoW96rK3ML96Ms33lHP1BJ4xKCsG1or9JX9t6OxPNg3fj+K2gtGAX4ejAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0EPT6RL9t9X1m/CVfHnUThriaZ5vQWLHvYj67C/HB0=;
 b=ggktuWgEuHOz7XIOd0gWJKhLCbgO1YsaXDn7XT9ibEEutkbvgz7ESR7G3H5kDE8D/tQwM+ZjKrqgH92whtrwDmzrjViTRprJ0uTw06tkztjG4Yt/gHFrqEdbq9xgiiiql+fvRQaPO8wVvoOSAn5AE6GkYb0XNUK/SWRRZLw7s9plXr+eHjXXTj+ZRue//kOTUm+b8XWuAmdz3yGFmEoQ/yUB99WvzWJLbJlXUroSmFr/9J7g18vKbVTUi+3C96HxE6yom8c/a9XX3jvK3JMmzYbuNjQyawycc+pz0GuVzfaZU8yyJmrjMBiMFKdn2UFjnjsYIqVjN0+ri1Y7CwMDKQ==
Received: from DB6PR0301CA0087.eurprd03.prod.outlook.com (2603:10a6:6:30::34)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 06:49:23 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::8d) by DB6PR0301CA0087.outlook.office365.com
 (2603:10a6:6:30::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 06:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 06:49:18 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.168) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 08 Apr 2024 06:49:16 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VE1PR04MB7357.eurprd04.prod.outlook.com (2603:10a6:800:1ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 06:49:11 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::a5f9:b872:2a57:cb22]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::a5f9:b872:2a57:cb22%6]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 06:49:11 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: supply: ltc3350-charger: Add bindings
Date: Mon, 8 Apr 2024 08:49:04 +0200
Message-ID: <20240408064905.20298-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VE1PR04MB7357:EE_|DU6PEPF00009529:EE_|AS8PR04MB8690:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Xt4cGn41vTgX7FPBzfi2ruZfBTu35z+KQlKgF0+bqEgGx3bdPBpdFFxvfeeg96lWSq4BlyK9tW7xj+WZPNQIIxc1tMgM8Hir5YaT12TS0qX7ioRGBF4DhkQJKyx3ptweC59+vhxCaDpxejuMNvb3hQpvWm9k+3h2gEXXLDf7SzTP22WsmGxA+VvJefDgNPkDEabtx9GaE3NA5GBkxsN7T66K6Hy6K76GfCWEhy8PwYNt5lQrxWlkgnC7Ijdt9s3Ecu7V9bup2OnCwZoJWOwnApiAjqn5OB4vRgx4+JmcO5ruKPT8tls9Bh2bLNIpuQ+yEaAbD0epQfUP4OrF0IYOlFfsy6dYAjsjj2hRJ/4j1R2m3iLvQsoTcfwhAkak2fIcrOPBP55sugpw/Ed3GLU+Zd+W8QaOznO8a1UVA+6JB/T4hZA8/zC5jfPYhJu/ckvkPdGkQr0c2tNWc9inYHQBhCENRdO/H9O2PsnEOcBrkIH7XzapRbtdunPNNp1S+jr6JGUDHSDRTAu6lQHRHvSvoPuZZRe97Doxnwpx44vzZEXCIV9ve64UNBytfRjlzvOd8kjlJGchAElc1nZfNgsAOTm2C0qTofdixCxsM3w/6GgAglV+kKmhgnEztyYYuH4FYV6Ugutcle+/5Jagbw7q0A4jS5qu+z49QTlYmz64Q3w=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7357
X-CodeTwo-MessageID: 14c4ce94-e146-4fc6-a72a-76507a80e358.20240408064916@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3bc97c8f-843d-4e46-84f9-469b7ba2489d@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b457a506-4c3b-4170-17d1-08dc57980367
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xqjsRY4r8POCOK5tN09wZ6aNHTkdzK3Ze43y+yDxWr2/WJRKOZ1fS34lj+l9Z24vg+cd5wEZ0FJuWVMWGFyDrAj9vRYdv4oQOO2GpF0rtReaQl56QHw/Gy10yWx818Z0uPFw1ipDH5mV25+vloa9BCR2R363g1FvNThxlNqFqJBdiDsIe+fIwFxCWv3PPNk3WZE1mwa9Lv5VBTgRL0mt4q5cdxkKfj3WFYmXs1IiPwpbwOpOu3YoTBI+VS4Yeg7J7V7kpyCYNZuRkd9sHBRdPsMzesU/fkOIlGtH1kgdWuu36qWGBs7tPH9sMsLIfLgdJQPwr4LBxqC49jnuLr80unP1zedPpcgW8Z050i5Daf0xt2RmV6XNmfLdw0llhH1xeTufzF68wpDeyM8RNcf+dqlvx7qrdM7Wmk01RIZd2ym0dauS6bAGZbUQMJhLKKfZ870rsBrfz/O7/4T5onARDgYjjWgg5MSNiUufGzckIuplfSFATddPkntp1TjFgCVgInRA9xrLDAZwzOOaTuidjBuzdRTkofw2X2LpEm6gzgChaxn/Joj4MBeW1biXYu9y4Os/UTAdsH0PGgt6MZ+S350vDbHLx9QOIHUn4/lJjkFM9ajLiOdGplKE1CYmrlFdIitoNBO3Oe21mX3YvZ6nl0+/s9enWjMKBPSz3s5wm7cDVk9pC/EJouaJG0Euzarn7YZcmEdqhIGQIi3HauStLQ==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 06:49:18.1469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b457a506-4c3b-4170-17d1-08dc57980367
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690

The LTC3350 is a backup power controller that can charge and monitor
a series stack of one to four supercapacitors.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 .../bindings/power/supply/ltc3350.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ltc3350.=
yaml

diff --git a/Documentation/devicetree/bindings/power/supply/ltc3350.yaml b/=
Documentation/devicetree/bindings/power/supply/ltc3350.yaml
new file mode 100644
index 000000000000..607a62fd25ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ltc3350.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2024 Topic Embedded Products
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/ltc3350.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology (Analog Devices) LTC3350 Supercap Charger
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  The LTC3350 is a  High Current Supercapacitor Backup Controller and Syst=
em
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
+    description: I2C address of the charger.
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
+              compatible =3D "lltc,ltc3350";
+              reg =3D <0x9>;
+              lltc,rsnsc-micro-ohms =3D <10000>;
+              lltc,rsnsi-micro-ohms =3D <10000>;
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

