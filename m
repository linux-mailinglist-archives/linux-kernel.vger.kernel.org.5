Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACE757290
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjGRDty convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 23:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGRDts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:49:48 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E117C130;
        Mon, 17 Jul 2023 20:49:46 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id F30E824DDBE;
        Tue, 18 Jul 2023 11:49:39 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 11:49:39 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 11:49:39 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] riscv: dts: starfive: jh7110: Add temperature sensor node and thermal-zones
Date:   Tue, 18 Jul 2023 11:49:36 +0800
Message-ID: <20230718034937.92999-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230718034937.92999-1-hal.feng@starfivetech.com>
References: <20230718034937.92999-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add temperature sensor and thermal-zones support for
the StarFive JH7110 SoC. CPUFreq cooling is supported
in thermal-zones.

Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 53 ++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index ec2e70011a73..2315acd560a3 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -7,6 +7,7 @@
 /dts-v1/;
 #include <dt-bindings/clock/starfive,jh7110-crg.h>
 #include <dt-bindings/reset/starfive,jh7110-crg.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "starfive,jh7110";
@@ -56,6 +57,7 @@ U74_1: cpu@1 {
 			operating-points-v2 = <&cpu_opp>;
 			clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>;
 			clock-names = "cpu";
+			#cooling-cells = <2>;
 
 			cpu1_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -85,6 +87,7 @@ U74_2: cpu@2 {
 			operating-points-v2 = <&cpu_opp>;
 			clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>;
 			clock-names = "cpu";
+			#cooling-cells = <2>;
 
 			cpu2_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -114,6 +117,7 @@ U74_3: cpu@3 {
 			operating-points-v2 = <&cpu_opp>;
 			clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>;
 			clock-names = "cpu";
+			#cooling-cells = <2>;
 
 			cpu3_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -143,6 +147,7 @@ U74_4: cpu@4 {
 			operating-points-v2 = <&cpu_opp>;
 			clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>;
 			clock-names = "cpu";
+			#cooling-cells = <2>;
 
 			cpu4_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -197,6 +202,42 @@ opp-1500000000 {
 			};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <15000>;
+
+			thermal-sensors = <&sfctemp>;
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device =
+						<&U74_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&U74_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&U74_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&U74_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					/* milliCelsius */
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit {
+					/* milliCelsius */
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	gmac0_rgmii_rxin: gmac0-rgmii-rxin-clock {
 		compatible = "fixed-clock";
 		clock-output-names = "gmac0_rgmii_rxin";
@@ -473,6 +514,18 @@ i2c6: i2c@12060000 {
 			status = "disabled";
 		};
 
+		sfctemp: temperature-sensor@120e0000 {
+			compatible = "starfive,jh7110-temp";
+			reg = <0x0 0x120e0000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_TEMP_CORE>,
+				 <&syscrg JH7110_SYSCLK_TEMP_APB>;
+			clock-names = "sense", "bus";
+			resets = <&syscrg JH7110_SYSRST_TEMP_CORE>,
+				 <&syscrg JH7110_SYSRST_TEMP_APB>;
+			reset-names = "sense", "bus";
+			#thermal-sensor-cells = <0>;
+		};
+
 		syscrg: clock-controller@13020000 {
 			compatible = "starfive,jh7110-syscrg";
 			reg = <0x0 0x13020000 0x0 0x10000>;
-- 
2.38.1

