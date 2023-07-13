Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECD2752036
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjGMLjp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjGMLjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:39:13 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572EE5C;
        Thu, 13 Jul 2023 04:39:11 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D089124E266;
        Thu, 13 Jul 2023 19:39:04 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Jul
 2023 19:39:04 +0800
Received: from localhost.localdomain (183.27.98.46) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Jul
 2023 19:39:03 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v8 1/9] dt-bindings: clock: Add StarFive JH7110 System-Top-Group clock and reset generator
Date:   Thu, 13 Jul 2023 19:38:54 +0800
Message-ID: <20230713113902.56519-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713113902.56519-1-xingyu.wu@starfivetech.com>
References: <20230713113902.56519-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.46]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the System-Top-Group clock and reset generator (STGCRG)
on the JH7110 RISC-V SoC by StarFive Ltd.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../clock/starfive,jh7110-stgcrg.yaml         | 82 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 34 ++++++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 28 +++++++
 3 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
new file mode 100644
index 000000000000..b64ccd84200a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7110-stgcrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 System-Top-Group Clock and Reset Generator
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-stgcrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: HIFI4 core
+      - description: STG AXI/AHB
+      - description: USB (125 MHz)
+      - description: CPU Bus
+      - description: HIFI4 Axi
+      - description: NOC STG Bus
+      - description: APB Bus
+
+  clock-names:
+    items:
+      - const: osc
+      - const: hifi4_core
+      - const: stg_axiahb
+      - const: usb_125m
+      - const: cpu_bus
+      - const: hifi4_axi
+      - const: nocstg_bus
+      - const: apb_bus
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jh7110-crg.h> for valid indices.
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
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+
+    stgcrg: clock-controller@10230000 {
+        compatible = "starfive,jh7110-stgcrg";
+        reg = <0x10230000 0x10000>;
+        clocks = <&osc>,
+                 <&syscrg JH7110_SYSCLK_HIFI4_CORE>,
+                 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
+                 <&syscrg JH7110_SYSCLK_USB_125M>,
+                 <&syscrg JH7110_SYSCLK_CPU_BUS>,
+                 <&syscrg JH7110_SYSCLK_HIFI4_AXI>,
+                 <&syscrg JH7110_SYSCLK_NOCSTG_BUS>,
+                 <&syscrg JH7110_SYSCLK_APB_BUS>;
+        clock-names = "osc", "hifi4_core",
+                      "stg_axiahb", "usb_125m",
+                      "cpu_bus", "hifi4_axi",
+                      "nocstg_bus", "apb_bus";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
index 06257bfd9ac1..6c8e8b4cf1f6 100644
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
  * Copyright 2022 Emil Renner Berthing <kernel@esmil.dk>
+ * Copyright 2022 StarFive Technology Co., Ltd.
  */
 
 #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
@@ -218,4 +219,37 @@
 
 #define JH7110_AONCLK_END			14
 
+/* STGCRG clocks */
+#define JH7110_STGCLK_HIFI4_CLK_CORE		0
+#define JH7110_STGCLK_USB0_APB			1
+#define JH7110_STGCLK_USB0_UTMI_APB		2
+#define JH7110_STGCLK_USB0_AXI			3
+#define JH7110_STGCLK_USB0_LPM			4
+#define JH7110_STGCLK_USB0_STB			5
+#define JH7110_STGCLK_USB0_APP_125		6
+#define JH7110_STGCLK_USB0_REFCLK		7
+#define JH7110_STGCLK_PCIE0_AXI_MST0		8
+#define JH7110_STGCLK_PCIE0_APB			9
+#define JH7110_STGCLK_PCIE0_TL			10
+#define JH7110_STGCLK_PCIE1_AXI_MST0		11
+#define JH7110_STGCLK_PCIE1_APB			12
+#define JH7110_STGCLK_PCIE1_TL			13
+#define JH7110_STGCLK_PCIE_SLV_MAIN		14
+#define JH7110_STGCLK_SEC_AHB			15
+#define JH7110_STGCLK_SEC_MISC_AHB		16
+#define JH7110_STGCLK_GRP0_MAIN			17
+#define JH7110_STGCLK_GRP0_BUS			18
+#define JH7110_STGCLK_GRP0_STG			19
+#define JH7110_STGCLK_GRP1_MAIN			20
+#define JH7110_STGCLK_GRP1_BUS			21
+#define JH7110_STGCLK_GRP1_STG			22
+#define JH7110_STGCLK_GRP1_HIFI			23
+#define JH7110_STGCLK_E2_RTC			24
+#define JH7110_STGCLK_E2_CORE			25
+#define JH7110_STGCLK_E2_DBG			26
+#define JH7110_STGCLK_DMA1P_AXI			27
+#define JH7110_STGCLK_DMA1P_AHB			28
+
+#define JH7110_STGCLK_END			29
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
index d78e38690ceb..4e96ab81dd8e 100644
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
  * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
  */
 
 #ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__
@@ -151,4 +152,31 @@
 
 #define JH7110_AONRST_END			8
 
+/* STGCRG resets */
+#define JH7110_STGRST_SYSCON			0
+#define JH7110_STGRST_HIFI4_CORE		1
+#define JH7110_STGRST_HIFI4_AXI			2
+#define JH7110_STGRST_SEC_AHB			3
+#define JH7110_STGRST_E24_CORE			4
+#define JH7110_STGRST_DMA1P_AXI			5
+#define JH7110_STGRST_DMA1P_AHB			6
+#define JH7110_STGRST_USB0_AXI			7
+#define JH7110_STGRST_USB0_APB			8
+#define JH7110_STGRST_USB0_UTMI_APB		9
+#define JH7110_STGRST_USB0_PWRUP		10
+#define JH7110_STGRST_PCIE0_AXI_MST0		11
+#define JH7110_STGRST_PCIE0_AXI_SLV0		12
+#define JH7110_STGRST_PCIE0_AXI_SLV		13
+#define JH7110_STGRST_PCIE0_BRG			14
+#define JH7110_STGRST_PCIE0_CORE		15
+#define JH7110_STGRST_PCIE0_APB			16
+#define JH7110_STGRST_PCIE1_AXI_MST0		17
+#define JH7110_STGRST_PCIE1_AXI_SLV0		18
+#define JH7110_STGRST_PCIE1_AXI_SLV		19
+#define JH7110_STGRST_PCIE1_BRG			20
+#define JH7110_STGRST_PCIE1_CORE		21
+#define JH7110_STGRST_PCIE1_APB			22
+
+#define JH7110_STGRST_END			23
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__ */
-- 
2.25.1

