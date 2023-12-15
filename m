Return-Path: <linux-kernel+bounces-651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81291814406
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A671F1C22893
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B991D19BD2;
	Fri, 15 Dec 2023 08:57:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE718E14
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BF8ut02028363;
	Fri, 15 Dec 2023 16:56:55 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Ss2xP5Gp9z2PfFhY;
	Fri, 15 Dec 2023 16:50:49 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 15 Dec
 2023 16:56:52 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan
 Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] arm64: dts: sprd: Add support for Unisoc's UMS9620
Date: Fri, 15 Dec 2023 16:56:30 +0800
Message-ID: <20231215085630.984892-5-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231215085630.984892-1-chunyan.zhang@unisoc.com>
References: <20231215085630.984892-1-chunyan.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3BF8ut02028363

Add basic support for Unisoc's UMS9620, with this patch,
the board ums9620-2h10 can run into console.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/Makefile         |   3 +-
 arch/arm64/boot/dts/sprd/ums9620-2h10.dts |  38 ++++
 arch/arm64/boot/dts/sprd/ums9620.dtsi     | 247 ++++++++++++++++++++++
 3 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/sprd/ums9620-2h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/ums9620.dtsi

diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sprd/Makefile
index 97522fb0bf66..3ce81ad7116f 100644
--- a/arch/arm64/boot/dts/sprd/Makefile
+++ b/arch/arm64/boot/dts/sprd/Makefile
@@ -2,4 +2,5 @@
 dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb \
 			sp9860g-1h10.dtb	\
 			sp9863a-1h10.dtb	\
-			ums512-1h10.dtb
+			ums512-1h10.dtb		\
+			ums9620-2h10.dtb
diff --git a/arch/arm64/boot/dts/sprd/ums9620-2h10.dts b/arch/arm64/boot/dts/sprd/ums9620-2h10.dts
new file mode 100644
index 000000000000..b35671192a72
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/ums9620-2h10.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Unisoc UMS9620-2h10 board DTS file
+ *
+ * Copyright (C) 2023, Unisoc Inc.
+ */
+
+/dts-v1/;
+
+#include "ums9620.dtsi"
+
+/ {
+	model = "Unisoc UMS9620-2H10 Board";
+
+	compatible = "sprd,ums9620-2h10", "sprd,ums9620";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x2 0x00000000>;
+	};
+
+	chosen {
+		stdout-path = "serial1:921600n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/sprd/ums9620.dtsi b/arch/arm64/boot/dts/sprd/ums9620.dtsi
new file mode 100644
index 000000000000..c63019b2fe51
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/ums9620.dtsi
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Unisoc UMS9620 DTS file
+ *
+ * Copyright (C) 2023, Unisoc Inc.
+ */
+
+#include <dt-bindings/clock/sprd,ums9620-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+				core2 {
+					cpu = <&CPU2>;
+				};
+				core3 {
+					cpu = <&CPU3>;
+				};
+				core4 {
+					cpu = <&CPU4>;
+				};
+				core5 {
+					cpu = <&CPU5>;
+				};
+				core6 {
+					cpu = <&CPU6>;
+				};
+				core7 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&LIT_CORE_PD>;
+		};
+
+		CPU1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&LIT_CORE_PD>;
+		};
+
+		CPU2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			cpu-idle-states = <&LIT_CORE_PD>;
+		};
+
+		CPU3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			cpu-idle-states = <&LIT_CORE_PD>;
+		};
+
+		CPU4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x0 0x400>;
+			enable-method = "psci";
+			cpu-idle-states = <&BIG_CORE_PD>;
+		};
+
+		CPU5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x0 0x500>;
+			enable-method = "psci";
+			cpu-idle-states = <&BIG_CORE_PD>;
+		};
+
+		CPU6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x0 0x600>;
+			enable-method = "psci";
+			cpu-idle-states = <&BIG_CORE_PD>;
+		};
+
+		CPU7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x0 0x700>;
+			enable-method = "psci";
+			cpu-idle-states = <&BIG_CORE_PD>;
+		};
+	};
+
+	idle-states {
+		entry-method = "psci";
+		LIT_CORE_PD: cpu-pd-lit {
+			compatible = "arm,idle-state";
+			entry-latency-us = <1000>;
+			exit-latency-us = <500>;
+			min-residency-us = <2500>;
+			local-timer-stop;
+			arm,psci-suspend-param = <0x00010000>;
+		};
+
+		BIG_CORE_PD: cpu-pd-big {
+			compatible = "arm,idle-state";
+			entry-latency-us = <4000>;
+			exit-latency-us = <4000>;
+			min-residency-us = <10000>;
+			local-timer-stop;
+			arm,psci-suspend-param = <0x00010000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physical Secure PPI */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physical Non-Secure PPI */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual PPI */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervisor PPI */
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@12000000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x12000000 0 0x20000>,	/* GICD */
+			      <0x0 0x12040000 0 0x100000>;	/* GICR */
+			#interrupt-cells = <3>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			redistributor-stride = <0x0 0x20000>;	/* 128KB stride */
+			#redistributor-regions = <1>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		apb@20200000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x20200000 0x100000>;
+
+			uart0: serial@0 {
+				compatible = "sprd,ums9620-uart",
+					     "sprd,sc9836-uart";
+				reg = <0 0x100>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart1: serial@10000 {
+				compatible = "sprd,ums9620-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x10000 0x100>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+		};
+	};
+
+	ext_26m: clk-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "ext-26m";
+	};
+
+	ext_4m: clk-4m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <4000000>;
+		clock-output-names = "ext-4m";
+	};
+
+	ext_32k: clk-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ext-32k";
+	};
+
+	rco_100m: clk-100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "rco-100m";
+	};
+
+	dphy_312m5: dphy-312m5 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <312500000>;
+		clock-output-names = "dphy-312m5";
+	};
+
+	dphy_416m7: dphy-416m7 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <416700000>;
+		clock-output-names = "dphy-416m7";
+	};
+};
-- 
2.41.0


