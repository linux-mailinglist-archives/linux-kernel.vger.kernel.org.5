Return-Path: <linux-kernel+bounces-3032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA03816655
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47E4B2100F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540DB6FCA;
	Mon, 18 Dec 2023 06:13:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405C7460;
	Mon, 18 Dec 2023 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 146F68016;
	Mon, 18 Dec 2023 14:13:04 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 18 Dec
 2023 14:13:04 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 18 Dec
 2023 14:13:00 +0800
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: <joshua.yeong@starfivetech.com>, <jeeheng.sia@starfivetech.com>,
	<leyfoon.tan@starfivetech.com>, <jassisinghbrar@gmail.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: mailbox: starfive: Add StarFive Meu Mailbox Driver
Date: Mon, 18 Dec 2023 14:12:00 +0800
Message-ID: <20231218061201.98136-3-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218061201.98136-1-joshua.yeong@starfivetech.com>
References: <20231218061201.98136-1-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

The StarFive Meu Mailbox allow communication between AP and SCP cores
through mailbox doorbell.

Co-developed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 .../bindings/mailbox/starfive-meu.yaml        | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/starfive-me=
u.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml =
b/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml
new file mode 100644
index 000000000000..dbc5cfdb90ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/starfive-meu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive MEU Mailbox Controller
+
+maintainers:
+  - Jee Heng Sia <jeeheng.sia@starfivetech.com>
+  - Joshua Yeong <joshua.yeong@starfivetech.com>
+
+description: |
+  StarFive's Message-Exchange-Unit (MEU) is a mailbox controller that ha=
s 62
+  independent doorbells. Each MEU channel consist of 31 doorbells and co=
nsist of
+  a pair of Tx/Rx links that shall communicates with remote processor. T=
he
+  sender set the bit in the SET register to indicate data readiness for =
the
+  receiver. An interrupt will be raised whenever receiving notification =
doorbell
+  from remote processor. The receiver will clear the bit in the CLR regi=
ster
+  upon handling the doorbell notification. The sender should poll the ST=
AT
+  register before starting any transaction to ensure all on-going doorbe=
lls are
+  processed.
+
+properties:
+  compatible:
+    enum:
+      - starfive,jh8100-meu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: mailbox0
+      - description: mailbox1
+
+  '#mbox-cells':
+    description: represents index of the mailbox/doorbell paired channel
+      channel  0 - 30 for mailbox0 doorbell
+      channel 31 - 61 for mailbox1 doorbell
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        meu: mailbox@1f370000 {
+            compatible =3D "starfive,jh8100-meu";
+            reg =3D <0x0 0x1f370000 0 0x8000>;
+            interrupts =3D <170>, /* Mailbox0 */
+                         <171>; /* Mailbox1 */
+            #mbox-cells =3D <1>;
+        };
+    };
+
+...
--=20
2.25.1


