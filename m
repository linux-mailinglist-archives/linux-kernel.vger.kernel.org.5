Return-Path: <linux-kernel+bounces-11369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE87B81E53A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963BC2815E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217204E60C;
	Tue, 26 Dec 2023 05:40:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817E4E60B;
	Tue, 26 Dec 2023 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id D7B6224E03E;
	Tue, 26 Dec 2023 13:40:28 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:40:28 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:40:22 +0800
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
Subject: [RFC 13/16] dt-bindings: clock: Add StarFive JH8100 Always-On clock and reset generator
Date: Tue, 26 Dec 2023 13:38:45 +0800
Message-ID: <20231226053848.25089-14-jeeheng.sia@starfivetech.com>
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

Add bindings for the Always-On clock and reset generator (AONCRG) on
JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 .../clock/starfive,jh8100-aoncrg.yaml         | 74 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 67 +++++++++++++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   | 16 ++++
 3 files changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh81=
00-aoncrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-aonc=
rg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-aoncrg.=
yaml
new file mode 100644
index 000000000000..4ae1ef827fc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-aoncrg.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-aoncrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 Always-On Clock and Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-aoncrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: GMAC0 RMII func
+      - description: GMAC0 RGMII func
+      - description: AON 125MHz clock
+      - description: AON 2000MHz clock
+      - description: AON 200MHz clock
+      - description: AON 667MHz clock
+      - description: RTC clock
+
+  clock-names:
+    items:
+      - const: osc
+      - const: gmac0-rmii-func
+      - const: gmac0-rgmii-func
+      - const: aon125
+      - const: aon2000
+      - const: aon200
+      - const: aon667
+      - const: rtc
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
+    clock-controller@1f310000 {
+        compatible =3D "starfive,jh8100-aoncrg";
+        reg =3D <0x1f310000 0x10000>;
+        clocks =3D <&osc>, <&gmac0_rmii_func>, <&gmac0_rgmii_func>, <&ao=
n125>,
+                 <&aon2000>, <&aon200>, <&aon667>, <&rtc>;
+        clock-names =3D "osc", "gmac0-rmii-func", "gmac0-rgmii-func", "a=
on125",
+                      "aon2000", "aon200", "aon667", "rtc";
+        #clock-cells =3D <1>;
+        #reset-cells =3D <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt=
-bindings/clock/starfive,jh8100-crg.h
index 7b337c1495be..8207d5a2f4b3 100644
--- a/include/dt-bindings/clock/starfive,jh8100-crg.h
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -351,4 +351,71 @@
 #define JH8100_SWCLK_JPEG_ICG_EN					8
 #define JH8100_SWCLK_VDEC_ICG_EN					9
=20
+/* AONCRG clocks */
+#define JH8100_AONCLK_GMAC0_RMII_REFIN					0
+#define JH8100_AONCLK_GMAC0_RGMII_RXIN					1
+#define JH8100_AONCLK_GMAC0_GTXCLK					2
+#define JH8100_AONCLK_AON_1000						3
+#define JH8100_AONCLK_AON_400						4
+#define JH8100_AONCLK_AON_400_POSTOSC					5
+#define JH8100_AONCLK_AON_500						6
+#define JH8100_AONCLK_AON_500_POSTOSC					7
+#define JH8100_AONCLK_XSPI_PHY						8
+#define JH8100_AONCLK_AON_100						9
+#define JH8100_AONCLK_AON_100_POSTOSC					10
+#define JH8100_AONCLK_AON_50_POSTOSC					11
+#define JH8100_AONCLK_DDR50_POSTOCC_ICG					12
+#define JH8100_AONCLK_DDR100_POSTOCC_ICG				13
+#define JH8100_AONCLK_PUFRT_APB						14
+#define JH8100_AONCLK_RTC_HMS_APB					15
+#define JH8100_AONCLK_RTC_INTERNAL					16
+#define JH8100_AONCLK_RTC_HMS_OSC32K					17
+#define JH8100_AONCLK_RTC_HMS_CAL					18
+#define JH8100_AONCLK_GMAC0_AXI128_AHB					19
+#define JH8100_AONCLK_GMAC0_AXI128_MSTRCLK				20
+#define JH8100_AONCLK_GMAC0_AXI128_AXI					21
+#define JH8100_AONCLK_GMAC0_RMII_RTX					22
+#define JH8100_AONCLK_GMAC0_AXI128_TX					23
+#define JH8100_AONCLK_GMAC0_AXI128_TX_INV				24
+#define JH8100_AONCLK_GMAC0_AXI128_RX					25
+#define JH8100_AONCLK_GMAC0_AXI128_RX_INV				26
+#define JH8100_AONCLK_GMAC0_GTXC					27
+#define JH8100_AONCLK_XSPI_AXI						28
+#define JH8100_AONCLK_XSPI_APB						29
+#define JH8100_AONCLK_XSPI_XSPI_PHY					30
+#define JH8100_AONCLK_TVSENSOR_PCLK					31
+#define JH8100_AONCLK_TVSENSOR_TSADC					32
+#define JH8100_AONCLK_TVSENSOR_BG					33
+#define JH8100_AONCLK_MEU_PCLK_AP					34
+#define JH8100_AONCLK_MEU_PCLK_SCP					35
+#define JH8100_AONCLK_MEU_MEM_AXI					36
+#define JH8100_AONCLK_AXIMEM_128B_ACLK					37
+#define JH8100_AONCLK_APB2BISR_APB					38
+#define JH8100_AONCLK_APB2BISR_BISR					39
+#define JH8100_AONCLK_EMMC_S_PCLK					40
+#define JH8100_AONCLK_EMMC_MSTRCLK					41
+#define JH8100_AONCLK_EMMC						42
+#define JH8100_AONCLK_EMMC_SDMCLK					43
+#define JH8100_AONCLK_EMMC_SDPHY_PCLK					44
+#define JH8100_AONCLK_SDIO0_PCLK					45
+#define JH8100_AONCLK_SDIO0_MSTRCLK					46
+#define JH8100_AONCLK_SDIO0						47
+#define JH8100_AONCLK_SDIO0_SDMCLK					48
+#define JH8100_AONCLK_SDIO0_SDPHY_PCLK					49
+#define JH8100_AONCLK_HCLK						50
+#define JH8100_AONCLK_ACLK						51
+#define JH8100_AONCLK_PERF_MSTRCLK					52
+#define JH8100_AONCLK_PERF_SLVCLK					53
+#define JH8100_AONCLK_GCLK0						54
+#define JH8100_AONCLK_GCLK_OSC						55
+#define JH8100_AONCLK_RTC_ICG_EN					56
+#define JH8100_AONCLK_GMAC0_ICG_EN					57
+#define JH8100_AONCLK_XSPI_ICG_EN					58
+#define JH8100_AONCLK_TVSENSOR0_ICG_EN					59
+#define JH8100_AONCLK_MEU_ICG_EN					60
+#define JH8100_AONCLK_APB2BISR_ICG_EN					61
+#define JH8100_AONCLK_EMMC_ICG_EN					62
+#define JH8100_AONCLK_SDIO0_ICG_EN					63
+#define JH8100_AONCLK_TOP_ICG_EN					64
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt=
-bindings/reset/starfive,jh8100-crg.h
index de4f25dc301d..23f15d4be22f 100644
--- a/include/dt-bindings/reset/starfive,jh8100-crg.h
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -99,4 +99,20 @@
 #define JH8100_SWRST_VC9000D					2
 #define JH8100_SWRST_DDR_TVSENSOR				3
=20
+/*
+ * AONCRG resets: assert0
+ */
+#define JH8100_AONRST_AON_IOMUX_PRESETN				0
+#define JH8100_AONRST_RTC					1
+#define JH8100_AONRST_GMAC0					2
+#define JH8100_AONRST_XSPI					3
+#define JH8100_AONRST_TVSENSOR					4
+#define JH8100_AONRST_MEU					5
+#define JH8100_AONRST_AXIMEM_128B_ARESET			6
+#define JH8100_AONRST_DFT_APB2BISR_APB				7
+#define JH8100_AONRST_SDIO0					8
+#define JH8100_AONRST_EMMC					9
+#define JH8100_AONRST_TOP					10
+#define JH8100_AONRST_IRQ_CTRL					11
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
--=20
2.34.1


