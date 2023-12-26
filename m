Return-Path: <linux-kernel+bounces-11367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BFC81E534
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E853282D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23C4D5B5;
	Tue, 26 Dec 2023 05:40:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A354E1B8;
	Tue, 26 Dec 2023 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id C7AC4807C;
	Tue, 26 Dec 2023 13:40:15 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:40:15 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:40:09 +0800
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<emil.renner.berthing@canonical.com>, <hal.feng@starfivetech.com>,
	<xingyu.wu@starfivetech.com>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [RFC 11/16] dt-bindings: clock: Add StarFive JH8100 South-West clock and reset generator
Date: Tue, 26 Dec 2023 13:38:43 +0800
Message-ID: <20231226053848.25089-12-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
References: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add bindings for the South-West clock and reset generator (SWCRG) on
JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 .../bindings/clock/starfive,jh8100-swcrg.yaml | 64 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 12 ++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   |  8 +++
 3 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh81=
00-swcrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-swcr=
g.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-swcrg.ya=
ml
new file mode 100644
index 000000000000..287dff7e91e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-swcrg.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-swcrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 South-West Clock And Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-swcrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB_BUS clock from SYSCRG
+      - description: VDEC_ROOT clock from SYSCRG
+      - description: FLEXNOC1 clock from SYSCRG
+
+  clock-names:
+    items:
+      - const: apb_bus
+      - const: vdec_root
+      - const: flexnoc1
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jh8100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+    clock-controller@12720000 {
+        compatible =3D "starfive,jh8100-swcrg";
+        reg =3D <0x12720000 0x10000>;
+        clocks =3D <&syscrg JH8100_SYSCLK_APB_BUS>,
+                 <&syscrg JH8100_SYSCLK_VDEC_ROOT>,
+                 <&syscrg JH8100_SYSCLK_FLEXNOC1>;
+        clock-names =3D "apb_bus", "vdec_root", "flexnoc1";
+        #clock-cells =3D <1>;
+        #reset-cells =3D <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt=
-bindings/clock/starfive,jh8100-crg.h
index c37b42f3eacd..7b337c1495be 100644
--- a/include/dt-bindings/clock/starfive,jh8100-crg.h
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -339,4 +339,16 @@
 #define JH8100_NECLK_CAN1_ICG_EN					173
 #define JH8100_NECLK_SMBUS0_ICG_EN					174
=20
+/* SWCRG clocks */
+#define JH8100_SWCLK_JPEG_AXI						0
+#define JH8100_SWCLK_VC9000DJ_AXI					1
+#define JH8100_SWCLK_VC9000DJ_VDEC					2
+#define JH8100_SWCLK_VC9000DJ_APB					3
+#define JH8100_SWCLK_VDEC_AXI						4
+#define JH8100_SWCLK_VC9000D_AXI					5
+#define JH8100_SWCLK_VC9000D_VDEC					6
+#define JH8100_SWCLK_VC9000D_APB					7
+#define JH8100_SWCLK_JPEG_ICG_EN					8
+#define JH8100_SWCLK_VDEC_ICG_EN					9
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt=
-bindings/reset/starfive,jh8100-crg.h
index 30a99c78341a..de4f25dc301d 100644
--- a/include/dt-bindings/reset/starfive,jh8100-crg.h
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -91,4 +91,12 @@
 #define JH8100_NERST_SYS_IOMUX_E				48
 #define JH8100_NERST_DUBHE_TVSENSOR				49
=20
+/*
+ * SWCRG resets: assert0
+ */
+#define JH8100_SWRST_PRESETN					0
+#define JH8100_SWRST_VC9000DJ					1
+#define JH8100_SWRST_VC9000D					2
+#define JH8100_SWRST_DDR_TVSENSOR				3
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
--=20
2.34.1


