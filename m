Return-Path: <linux-kernel+bounces-137031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6AB89DB5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0E31C21C44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208F129A7B;
	Tue,  9 Apr 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="UvDhQe6I"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2093.outbound.protection.outlook.com [40.107.6.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9912FB31;
	Tue,  9 Apr 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670900; cv=fail; b=KkgkQAUoVRPGyWarrjNAv4tIZ73mzcYFMAvwLhs6yk3ZCn/2pDub/5CUMjzHPz7Bv8PddlfKcF5W2USX3Uy/u4K7/hHiol7kPvWXTKfWwGC1vipiBku2nsGrG4XYAB0hQKwDZZRBhkDs/nS9Lxnf9eBH22eUifV/HT+2FcAU4G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670900; c=relaxed/simple;
	bh=XgopZOGLk7CTo4oMjEQI0pvEeLHWedEhZBh4Yl7i1pg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=ntp2nyj4b8lylbIOroLQH81TjYyveu1mqDXltSEx32E4fI9H2t0j98Awm9gQU6Mf7Jpy34I9CtvbRWKzsVM3g4DzHBDdPSwZYe9TifL/SdgmazJz0iw/fq0YA99diyRHRrneY83ry8BMgp1w5ZwcgxCfSomiB0b02DOn8daOTPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=UvDhQe6I; arc=fail smtp.client-ip=40.107.6.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLBvWLDBsqbf5gnzRN1xtZ2IPpxeSZURDcSoAxmvk/kMZzxelvFcuQHsobCe66gFAiz0TyVzSqkR2UkmZJmtIJG1hFCLmDvVFI2j6EZ1RPH8fuZkc3q4yMBYNnA7Mz5dff32Aobr/g2y7P2W8QrYQN4fbgspJ+tJUbo7Y2CefbtYfTeimANqJjPLwzDrvHE0ENjeLQbxrZY4YYTIopNkfn5WxdRPSu/nVx8zoBCYWVbh7lN+G4R0KB/3AnMkps/tXpJAgAu8KEh3QewFUzaHMGfFl3tN2oTI8oAW4VultpX7r+jUiwVAJ6pTpuUMd9xXpt223HHyE+Np+TM4xfMAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3OxS24eLsgZC/xwmnYib6VukuvqJ+q6ztRM2wQgX5Q=;
 b=DgbM7vpJ01hVyOyd0PctzPp2BQTFbj2uk4Q7axfeK22qOw6A+IbgZA+8Lg3v9unlajUZYZeD3t6MQOfZCuzVjfqr482aMWWRs98Wbcc+/+dB52H6D4wtAHcmTXLORhD2HRNAhUaFUQS0PSXjBYhOoLSHEezBVo2jBTAsbY6JG3v2YyzcpRiR8QdCyvPe/h4icSYzFWkO6/RSXsK+oXLSEHW9ldHzSzKlUYcjUE8h48A6m/+UAj8FAkdd0kjSuzjQ5qtkVwrpzkABLioDFvfCplpM5tVTozQDzoYzKO8ws6FHqxoEHkAkTG+iI3CItqzq1LX787/acTUGEQHn6q2+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3OxS24eLsgZC/xwmnYib6VukuvqJ+q6ztRM2wQgX5Q=;
 b=UvDhQe6IUlhavKdUlFwtJCL4mKjsF0mWwiuxpToACI1O9cfRLNpcqxVcFYG2mxsgKNRwnC96eoyFj5JXlmt5bUca8GjC0rwYHRYpGf52l1qG0cx68QaqbaPbN4G5oDNLjZKrnIZE03VfQOqU6CNZL4zSgXeqrjMaJ//BuyiyRVUWtETYU3NysKZHl3PBaFjTm0Yb6JFsk38ar88RuoV3wS3sstTWUUM5sNPYeMHVpfPlw93NhtM0MocKGAxHCMvtbqUKKAFMdRpVLwQgxfVVYaVlQtdT68/EsTA7c6w6J9L3E2aGPuf2Xi6BndhVLQWxcSm+U4KjxMCLgPdYFy75Sw==
Received: from DB9PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:10:1db::22)
 by PA4PR04MB8030.eurprd04.prod.outlook.com (2603:10a6:102:cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 13:54:53 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::80) by DB9PR06CA0017.outlook.office365.com
 (2603:10a6:10:1db::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Tue, 9 Apr 2024 13:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 13:54:52 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.169) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 09 Apr 2024 13:54:51 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 13:54:47 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 13:54:47 +0000
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
Subject: [PATCH v3 1/2] dt-bindings: power: supply: ltc3350-charger: Add bindings
Date: Tue, 9 Apr 2024 15:54:40 +0200
Message-ID: <20240409135442.37732-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::26) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM8PR04MB7251:EE_|DU6PEPF00009525:EE_|PA4PR04MB8030:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 CZ2k39dAjUxwqH18/saVqfypwIujv/YBUakYq3cEjp+WLRMwKjXw5i6jzLI7RI3+Ipe6qDt357oQp4ESc0Si0NI4JjlpmUFZlL0UkJuLuEZbisnhwCYD4GsPA6nH8npiPFJ00BI97IBlaTPCfHk/nRL074bEuDhSKOoIHIJ0Fv5thB3Y3aXX9//e4o7xeaMAG65IBjcZwO/74j5SPxxzv68731XMh5jbXXgPTtvcYg5OdNXgiU/U/MNOMMaampP+08IC8xcQIzbw54NhDXzPzDZbkCOtQt21hqSleXagXqmGVxqzwJB63n13r99zcbNuUjn0134ttW4pNQACgFskX85R37Vs6HiAoSXmftpWbxArlZ+7SUftaMXdY6YYnr2zhQYe3JCtUsKDduiGpHIYWtSjy6ZEZtU7tCxkNAlV6AHo2xw9it7AL7F+85VkWWHNzlt0CtX92AW7Hwn0IgmkmA/DITjsSW8vNCpmWVAWzsD4Hhv8ote6wSPjuHApSk6H3Z2C4LOsx9mV5g0iPXfP6m3JgD5uXZenDvcNQZ4pSOKdjuiE98T3o5oh06QnmFC5OOy88a3Vvgb/rfqMDKQ+swpauwva0+Zpd213wUJXTxn2G9+T9go9KgK9Zm+mjcT6bWJWcfwSkEfDt8xWwyxIPbGI9dhne+8q+gwkhdEbDUQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251
X-CodeTwo-MessageID: 51afec89-7e81-43d2-9952-c8e3c2f6c2be.20240409135451@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.66250b05-de15-4489-babe-49dcb09de02a@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f839565-70df-4e99-a4fd-08dc589ca185
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nUsx/ZOWskMlrqajPtlHPMFs0wI+4/Au6EbvJK9UpBY1HlGSw6QaDjnTFUVhaZ88VqCcsib3ctIPQifLCYPUlMYdaAFDCRHNVaymAynf0lPiqmVITYRGl8pJzzbCNLHX0v5QMsVlH/zorGbAg6l4JnPULSYMKDTQIkiNrSkCUyfycJwzv6Akpen7DSsmDZydP8uK0iHHIwG0rL3OnrOrNR1mbgiD8ga5zsydHUisfFneQurNIpHe9Yce4lIdrlIik/uep/rMsUrwTO9fPjkhhp41F58mekQQ0V6oK6WMGJmT6/cmwknZCNgHtYt+GErPuCjCCg3lE0VtlxEfv2rEicBBO6t/aDom23zY3vz4v1hLUJVGe9JTgfZZ5J9RnsD0EdwgyysQPoLCAG1YIowFr/UhkUdRvBQnk93pRrUTV6/h88s6254Fo/KHMOi3m4YMm0i83JQsS3WV9Hv6PuzzCtBXC/Kk4IFix7K8tgGME9dc4b5Aymyxe+xj3u1BSI3g6IWdqlGmw+tmuqq2CE1u0Re2vpsIYYHW5VNSuqlRyLCYwkeXyqpa0cecKlz0a3fF7uW8mIvOhfMZJ+l72nSr8b5m1UAZqYR0LP0YHmiOQulYFM0BuWiH52Gr7iRwHGrk+W27VxDEmZ+EdKKqX4/BPnAAyL4g5efUssVbW2swZD+57ZY/cJZM8o7yx3xyCjCaH/p3HgzRbnVbjz3bvSPmOA==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 13:54:52.7644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f839565-70df-4e99-a4fd-08dc589ca185
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8030

The LTC3350 is a backup power controller that can charge and monitor
a series stack of one to four supercapacitors.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

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

