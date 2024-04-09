Return-Path: <linux-kernel+bounces-136873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893B889D949
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30451F225D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D712DD97;
	Tue,  9 Apr 2024 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="Sf6ZjFcp"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2090.outbound.protection.outlook.com [40.107.7.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CD222318;
	Tue,  9 Apr 2024 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666174; cv=fail; b=UHlWB/Tg/Wj2peRAs2FkuwdFitx47Qjn05MaUrNXO1Gc+iGKKNiK3zoG2XOHSSZ3sYjU1I23A1YOjQAQGBQzVP8ic6BX3GsPkqiJ96MRu3CE7emfXoVyutPQ8uz8+mDFU4equcwFA9ecEQo9mRIQQf4+63DNomBGIY/JB/TdWeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666174; c=relaxed/simple;
	bh=MFForTQzN5Qa+UHbwt0JaQx4QWygDeFKcHHdb7Clh4w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=EuArIj7ismdJlPkYpcgF2LiQD1J7uPms0r+o5ebxbXBcv9ilYAQYMCWog/k9gYxH41ubokMAQDzFZOV9ambkJHei4bddV9J0P1QUl605zG2Wkxq6NhmkHKWE1hzoyUyqTI+g+GfcWI0vRb3/ZurDwTU7kLMsBdEPFXqIPfODRsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=Sf6ZjFcp; arc=fail smtp.client-ip=40.107.7.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqanxiaUf83Nb7vEKYg9AYSua48lAJK0IgygFryVf+4uDy5ZFH4MlqMC2XGvDE5nV53ifW3h0m50np45ZfOq6QgkkS07UEGRwLPGHmuqcKxjuipdvlwgFxfa4iNtUxQ5gRpFsAvcWDn2Mj8mwsxjsjURs4EpDUrQraCXeimS1Vq3snWSat0v6o2UGGzeMOJFvqNCAOGSfOcCrbc/sBQ5DcTpy8yCjICqmFtZnAIAjrnPau588LU56xFDaAr9MEQyLuGWzP3kSDkw81QWSEDds3uMN7amB5N+aSL4b8/Tcm50eq4Q+u7jEh2DgqdJvrMYo66mo37cuwpTVl3pK2JXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urQe1otZa0oNBCe+Gg2Kq9t2HgCddciPTKDJI3piyvE=;
 b=OCH1Bm35bDnAnalag9rJPGJGyyHiZw64gpKCZ5glSSH0fMmJpqgrIEesald9Xl3yCoAiPzWgMiGDflrby1U9uKMXVDcrHooU1rvIrlymxopvT507mVSDQtkOOiOIk+0/Ttod+FZbyhX8ZJx407hS0+9FR+SVHJVwBZr3WRXGGSp/lTd8S1zmLFhYitQgQrYff2C9zKgKwkV3Et6/40aykesWScizRou/hFCQaRrD2JED8msvXVsFc4BsfCb1VVWqR8bwDfVlsiyR+DjrpKrypY6j3VlRr9SoRX8crFOosbHwCVVd7jbwqcVeVADvFSMqDc5WRO9QBDG1y+l9T5QgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urQe1otZa0oNBCe+Gg2Kq9t2HgCddciPTKDJI3piyvE=;
 b=Sf6ZjFcpBikgDSXC5/FYBOenFGS+0pKpjNM2ed/yMOEZPXuiW/OODLfOrKLC4nhJjqQE41uthVCruXB622axhnmpq/iFpwYZ/rM5GxGqKQ/bOvhSxb1LHyyApYYlsWnpSAk+SaULJk74h6ehsV1aSuolT1hINtV10+OULo9fVU0aw/OZofopVkFaZRS8yhIP7wAatWDsvwsMw3IMpTLRYNpoCgU/DJKYud/3fm5P5E2Q24JHkOPMW3vGOQYpxIHW+aFTMqKkxh7VVic/N4JL/Z11f5V7T9/2z+KpC6IJIXy/gsB/o/+eTcz4NNSkW6RxqwM5TxaEZlLX2g3JNGKZJA==
Received: from DU2PR04CA0178.eurprd04.prod.outlook.com (2603:10a6:10:2b0::33)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 12:36:07 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::b) by DU2PR04CA0178.outlook.office365.com
 (2603:10a6:10:2b0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 12:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 12:36:07 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 09 Apr 2024 12:36:05 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM9PR04MB8210.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 12:36:01 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 12:36:01 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: power: supply: ltc3350-charger: Add bindings
Date: Tue, 9 Apr 2024 14:35:54 +0200
Message-ID: <20240409123556.34299-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::20) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM9PR04MB8210:EE_|DB1PEPF000509EE:EE_|VI1PR04MB7087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 1m8pleBEpOS9HoAaFgvC/cH6WCuYi69p+z2ShhYT8E5LeFSZTtIU0hz3L/Xm6Wx/iAJbOX2u/U5yJAT18rJ3l732Vb0SartIR3QdUKC1xVbvEBrOuKHDyQaLpIvLpuUK5wLOfsFnpaLbgxibuE/Oe/qeSJD+b2PfpYh4RmdiuXuT5YC8XEgl8b1UuxTSJZkotKZd7zOcHgTHmkhFXm6XmAJzS2hiuWdhCt4ev/FLqFhIPJ/oX19/J9yKLF9evu5EwKoT0ZVJean+/q1p4+Z9u6IQAIdEfdhcHpPLyZKHMuA+EOVGJ2CCGMf0BK8u0gdBt/p4gwXMW5G8MhWiF74lERPOpD6vmFb+OdfH2cdB2HFFaDtuV0IafbUkNboXOPeBVtmK/Wa5cHFJibmG1OLFzbLV5fLlovSVNMJi2z1KJPJOQZcVx8F0GOMeSK0wPt3OB9sSz+I9b1PW9rDSxqdJVdL+36COOa00QojEyExqPnW9G1sV+a2NqZPx+g2g1A+LoUN/nDAFDJgBEgY4HOuKWLj9xfDQ+uHe8FCwofVeOp/vMTKUiSW5nItPT1qXsSrm9N0XtSuBFttMIC1Trq00C+eWNwKDhLXO3VCWM7S2j9KTaxnMq2iAahabV9bNmcGy7ZBjMNDr2TZ/MQrP/zZGHI/gxbM6krcnoV66gcjWGUk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8210
X-CodeTwo-MessageID: d4f6c611-00df-4b97-b129-0ed5df543daf.20240409123605@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.67250ca5-6a79-4048-b845-3d240ff83a75@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bb0caf9-6ad5-4be3-f772-08dc5891a0c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JBxhzerzm2WnPRiqFvHfvzlgSZpsUywFWdwFNxwtAbGlrmWktIN7L0bjgCbIbW8xuHR2/1303LqMybe2cHToLSZY/P6kZgbBo5NO/cjS0S3cNFPWv/FVL7T8H8vLohQ+6df4OPbovZrnF1rXlya0U63fzQ46W63A2RN1wf/bh0WuTtrfJmtUQTX4bCDwwFzGiIcJ/Y/cd86R20i2r1J8rO+CD+HyZEw/dgd6dyyPjoM7kZLgap0Te8gySYZl3ewECtbt+vbkvJ/1ilZYBGs4f85QBTJP+VRkbEro7Zbgl7l3iHuYFngYYR3zjsUm5ySOuwZ71tQUaaefQmdFdgsPH0B9eko0rISbFXsJXzt+RoqEzndLJe9sReFsoj3W/iubypnb84nD/qrdkmhOPv3ceV0SJYaRy04XW7rj1ATTJSuKB4NEarWxmBwTSXwydwAWRFhrqFxFS/BwBxp1DuRUvbzvTTrdJHvLg7FXp3WC2oWT3JMsqgAQsg71xAyi5CgVz1Lv+Jq+ovKz/Wg7Wx2Y5DNBUUTeSd2B37SId8vpUAn+pY6q2j/OmYrMqh6uENzMbM45fGfKn7RcFESKBmDzDUoEaCXqSwvP0DXJ55Tci1ZADQYikIl/b3BWLmmRaLl9HFTRcXrZfTN++IHW5ZkYFAOK912LHzpwG33aFNkKCnOFcHh2GJNea3zVOQuH3ZmUq1dxIvEHqVLIz7WOwpEOhw==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 12:36:07.0180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb0caf9-6ad5-4be3-f772-08dc5891a0c1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087

The LTC3350 is a backup power controller that can charge and monitor
a series stack of one to four supercapacitors.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

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
index 000000000000..c8e36523c689
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lltc,ltc3350.yaml
@@ -0,0 +1,54 @@
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

