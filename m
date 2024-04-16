Return-Path: <linux-kernel+bounces-146770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16C8A6AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BDC1F218BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AF112BF31;
	Tue, 16 Apr 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="Bqo1ki0W"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2112.outbound.protection.outlook.com [40.107.22.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727412A177;
	Tue, 16 Apr 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269919; cv=fail; b=ppz+gm663w/wh1hV8RtH57oM6VfmVvo8I+Gg48uCNr/rBjaWAO0qky3Z25ukhuqAfY/jX6gVu5V1cvbqGWXwgE3G697pP7VJUzFyTWJGYOFeqi0zN64zByXsZYNYgIBNFsre41aj/DG34jKb6Om+KhYOXKuP8Y4+vP4sVwbOJDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269919; c=relaxed/simple;
	bh=u2jNXUdlEl0kN1j8OchrByc+t9mhlXMj8KWzl9eF8sU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGYd03QF7R+o+HGhVRTF9n1+7ESEhlS7lLDutjoVDZETAk/A4uMZqOp2IxpR0fHC7+vSUOvYE3ncN+h8Xi1fv6HIddfKx4k0DFJhbCGVtETmcLpjEHcC47Ss6MxhsojH8bJlUMj6ufoarYq4Av7ip+LNp+wL+7JdF9H4g5/mrkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=Bqo1ki0W; arc=fail smtp.client-ip=40.107.22.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9OjJ7dix/kwjF7yJuMbhV+U/Y1CUv+NU92wyDhVtwE3NOtW6iQnMBRx5RSv6e5IFk1/oZDt3onwcVn1LcHp3c5UDEHg/PW7it4Q5OsxrBXBx4q7bA0SGQkLcjl7RlPpuJEzd6SMlSsQMV5YF/hXmb9NonmCWa6i7wYEO3zZaTbOnDrArg0urx9Q3tFeY/51/n6CBI3i2KrKySoGNztMa1AzTPIERaV7D0WAHggvWo6ORzmm19DQ+JPoQGuB6JA8mbu5cJMguqYiECTnnBfERCeXFuKrkklK0sYYgv+HSBrnXRIJbyEsMro3akPDFKlxBoYUGdMRMvz0hR+Ups+Rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qkr7nM727EHH45DBlYjU1b/MAYY/KynsP/yC64XoSI=;
 b=XSFQFKjN5H+h6ZLKgSn2UjPwvpQb+8B3IX2euYcbq4GyBzr03nIzldaRbJs1YX4AmpYl/+hm1csIfUC2EkYuOIvofBtyShtdm0AmLX8rkJ89WPXbTv1PFtobnjbAO3CMIuiPoz698BptUBXwm1UjcLMLchyX3RWFZG1t7MeuyYd9I6+JPXcaIvRo2SBPAhllR6FNiMyNZy7gH7ThwP+kReVIyXb/STIUiniWvBGGbNtma89qf5K2UtZFGNJWguFPsAY5WDRvkindrdVCqHn6+FsA+vAb4DG6h8+fyOfv1NzTI67kShjLsiDOk4FWtbEhnvzb57wqhVrDs9f+EpHyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qkr7nM727EHH45DBlYjU1b/MAYY/KynsP/yC64XoSI=;
 b=Bqo1ki0WIfl33iPbLUssWCtIoJJwl4PSkoACYkcUMSpPLvOaacVVyNewbG8DlRiGjGw93pG/thqTfx31DMRfeDzlUefdRzfccJNIwYwNQ8hfVhqVq5BkW8UeIzn/2b+7mGrl89VdfYoOU8R0nu/BBrxN6FYUPHHjvoH8F6N3GLLu+QdANxwPyhKcI42abXDgU5J8cp4BYPe7uW9H6MgDqEtQA1oVYjAQVhtfN2RClerbQW9G1/4w8KOad7kHkGZRZyo925iVGdo0PWfQg1TPt8M2gkViXqQo1hr6uiLvo+Lvlo95Xe/vuzPWUVXh4TdqW+zjEBHBs+7bQbkQkCfI/g==
Received: from DU7P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::11)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Tue, 16 Apr
 2024 12:18:34 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::ef) by DU7P250CA0023.outlook.office365.com
 (2603:10a6:10:54f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 12:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 12:18:33 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.169) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 16 Apr 2024 12:18:31 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VE1PR04MB7230.eurprd04.prod.outlook.com (2603:10a6:800:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:25 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:18:25 +0000
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
Subject: [PATCH v5 4/5] dt-bindings: power: supply: ltc3350-charger: Add bindings
Date: Tue, 16 Apr 2024 14:18:17 +0200
Message-ID: <20240416121818.543896-4-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416121818.543896-1-mike.looijmans@topic.nl>
References: <20240416121818.543896-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.217e6bb9-ab43-4da3-b354-1d8d288df2de@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::20) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VE1PR04MB7230:EE_|DB5PEPF00014B9B:EE_|AS8PR04MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 269eaed1-4f6f-4814-f119-08dc5e0f5570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 EElw9z3JSiY61C7ScIOZjnHM+frHco3KHeSPRsWzv/zfDfT26cyoZGxwsw2rAEtmNFiEZvN/BKuKq2ERuDRfjz0m8WHreIuhql36g4POg8QYfGhGZiNU/EMXHhThb6kTNOyfPdnikt1gkaBViYww+t2h1VAlpY/kyaNLwC6f5KslI4gZW9nInwQnjH3Q6NOCuf3eDvhbirkTVzaqhyXl3cNmMG2hvkRjNyj9maogCwsR69QPoNpcaztmRJZJWZBa5dBGfaXNPa6d9uCxs4XatJO6t73nRhq45RJYiEaVRHmRSIR9n1kFN+vtTg+oTDj1fm+bQeLPtEPfov/hljEGlOa+h2Wi8WBLv7vC+LD79JormqgdSyPZCr73GXUFV8M79p8AsutYomT9h3R6R5RvB2d14HySA0jqRTwxyo8ONttQuzLShoShMxdun0VJmHOYskhOf6EISp7RzfAtsTD8XT6XKFRdIDx462fsTeh5QDCuAtk3rmOiEFwErceQ/DzaqZoM6VyaaffDSiV/q3t9XwWxxhjy69Im6ArHehCG9DcvExutqAWnzDu8ybce4wE59PPg2/7fgz73S8Wb4QEHQU7Nr0f18/hQBC5isE+bLVieKldcOi3h4+664aEELmOQqnHoJiETS2MvACVNkW23iWZspP7WsDfRxwtuwTPjJYM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7230
X-CodeTwo-MessageID: 7cab85bb-b450-4b7a-803c-6431a8086678.20240416121831@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	445b5ffc-6864-4c1e-ca39-08dc5e0f50f4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uAI51seGvFaUN0erFhno7YrJGASc3bEX76/q38uzvGmAseDC7mkJavj6fs6wlSih5OGUv07PoyWPXKcrkNou25FaJFM5n5WzPhlM2kDCYl9ODH2Q7nFrfu7vKcTNJYjHkaOGeB+psapqsLBY4YPuvtRk2pdp13K+dvPpilyer+wCZ+6dYUjl1suYAq8juQbdPwOc1/kdoaNaGnJhLvJncpYJcqe7F62zFD7JVjT+4yn63nPC8zjtwWMhbin2m27D5zHSA3Xs/0MHZIq5lw7iXXDHu76PsHt6FUXDlvzIPikrZjKiGCssGDA6mUJa5PskVoL0CuHkSATPDfMIV28wOe74y4NNxsu6mlvmtW/QvDx/C8LFD3S4LyHyP6YJj4JswU3LOu7622kGLe1bUdPNS4ozF9zB2r8LXWBf8xYBi0YrblnUy5VxAosr1g6S92y168gfY+t4iC7FjCoF6s8sOqERbMbOC6djVQXXXPb3G8I4znCy46ogaH1XIiox6Ld7Cxb+h49RJNx9BF4r8X7EEVkM8XjBkeSN+LFUM20Xp6nZOHXAFcU9n2nlHDvejrA1SBURM+CF51jLTTvwXcGZybCxzIAhTHkiJTJtwP+54iXJ0YiceWVg7GLE2qKTomx2tlO6eOadEStZkJy8HdrHitBqwQY7clneBChYk6VZSTDV/8HzD2oXFWpKLdilMDJprPBmBtVh3mLS9a2rKrBC5A==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:18:33.0597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269eaed1-4f6f-4814-f119-08dc5e0f5570
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610

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

