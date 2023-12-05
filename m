Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E12805B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346284AbjLEPdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjLEPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:33:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED53FB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:33:22 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso3498576e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701790401; x=1702395201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ujxeChxul4+pl20V58bA+GosHdEzOC9Mwy1kr2oAVA=;
        b=Gd1kmM3fx/R3ymYZgKE4jqgL+K7szshQX3Tt7juvcm/l/tqle5u/sIR1KMaXhd3908
         TaOAKxeI+6pSObbI4kVkPbJbAsu2r8qEO/YR3x6t95C4C683Oc7lQVOpIwW9I4AR7GPr
         7KULzeZ6Ql0iLBNnr7SNQz3avfvsOLeXght7XhA2LI72WyWctRi3NTHSse9AX39yQajF
         Ai3YR2L/deZBMPgc+DkdJ3splNiaejzBZ7uL0XRALgFiQgXd3He8lV7wjYJhIF0aNOR3
         bI93BzM/ASpRznVKayraZpkjVh3pV+ALyih0MXkHp9lM+C3nxLI52A/fT0qlSV85aYXb
         wM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790401; x=1702395201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ujxeChxul4+pl20V58bA+GosHdEzOC9Mwy1kr2oAVA=;
        b=k8d1AbSz86ustagXCXXjBV5PWYBIX21cZAnlyVIeP442rRUJ9gWdSfaI/jAFj73gnu
         RLLcvrOtAUaXlQ/xOroG12ifBYFZqnzF3KZs52x6WJEoy4zM4g1gBGLz3u8t/QDuwvWG
         dyJW6CL4cnU2S8a4OylTsAUmYcjyzV/W8r73tIDyly+jGmyAYHAEg6eeb+ATuNaof4P7
         G0ZzQce4mvFIPd5LZiFeEt8ISDykQGB1SEpiWKWHyxZAHSBOJnGfVqB1C2W38T6k9Q6Y
         zRDZsO5gda7AU+eFQJegK48R+QEw+8rBopVVJcTmEo3JbiFYIdR2CThAvpMRV/DeTZnY
         Ldaw==
X-Gm-Message-State: AOJu0YxSd2uVRbRda7JAOha6F4XTmWzYLWTvEYbJlEWv/4csOoFJTose
        UqYsuIpbBqtpGMUJaiL/367RUA==
X-Google-Smtp-Source: AGHT+IF7UC/f6D8WCZCJtlrtP3z1cgy3aOIY6Uf48q25EW58SgPSRfQyCL2ziQXnW5WdxKccL2/G4g==
X-Received: by 2002:ac2:560a:0:b0:50b:f025:2544 with SMTP id v10-20020ac2560a000000b0050bf0252544mr2136188lfd.121.1701790400900;
        Tue, 05 Dec 2023 07:33:20 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ca11-20020a170906a3cb00b00a0369e232bfsm6785159ejb.75.2023.12.05.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:33:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ARM: dts: qcom: use defines for interrupts
Date:   Tue,  5 Dec 2023 16:33:17 +0100
Message-Id: <20231205153317.346109-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hard-coded interrupt parts (GIC, flags) with standard defines
for readability.  No changes in resulting DTBs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Convert few more values to defines (GIC_PPI) - the tedious part which
   Konrad wanted.
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 38 ++++++++++++------------
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi |  8 ++---
 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi | 14 ++++-----
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 18 +++++------
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi   | 18 +++++------
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi   | 26 ++++++++--------
 6 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 95ac25e1a3b4..4a0be9b45712 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -190,7 +190,7 @@ cpu_crit3: trip1 {
 
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
-		interrupts = <1 10 0x304>;
+		interrupts = <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	clocks {
@@ -244,7 +244,7 @@ apps_smsm: apps@0 {
 
 		modem_smsm: modem@1 {
 			reg = <1>;
-			interrupts = <0 38 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -252,7 +252,7 @@ modem_smsm: modem@1 {
 
 		q6_smsm: q6@2 {
 			reg = <2>;
-			interrupts = <0 89 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -260,7 +260,7 @@ q6_smsm: q6@2 {
 
 		wcnss_smsm: wcnss@3 {
 			reg = <3>;
-			interrupts = <0 204 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 204 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -268,7 +268,7 @@ wcnss_smsm: wcnss@3 {
 
 		dsps_smsm: dsps@4 {
 			reg = <4>;
-			interrupts = <0 137 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -299,7 +299,7 @@ tlmm_pinmux: pinctrl@800000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			interrupts = <0 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&ps_hold>;
@@ -321,9 +321,9 @@ intc: interrupt-controller@2000000 {
 		timer@200a000 {
 			compatible = "qcom,kpss-wdt-apq8064", "qcom,kpss-timer",
 				     "qcom,msm-timer";
-			interrupts = <1 1 0x301>,
-				     <1 2 0x301>,
-				     <1 3 0x301>;
+			interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+				     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 			reg = <0x0200a000 0x100>;
 			clock-frequency = <27000000>;
 			cpu-offset = <0x80000>;
@@ -411,7 +411,7 @@ gsbi1_serial: serial@12450000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x12450000 0x100>,
 				      <0x12400000 0x03>;
-				interrupts = <0 193 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI1_UART_CLK>, <&gcc GSBI1_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -423,7 +423,7 @@ gsbi1_i2c: i2c@12460000 {
 				pinctrl-1 = <&i2c1_pins_sleep>;
 				pinctrl-names = "default", "sleep";
 				reg = <0x12460000 0x1000>;
-				interrupts = <0 194 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -452,7 +452,7 @@ gsbi2_i2c: i2c@124a0000 {
 				pinctrl-0 = <&i2c2_pins>;
 				pinctrl-1 = <&i2c2_pins_sleep>;
 				pinctrl-names = "default", "sleep";
-				interrupts = <0 196 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -539,7 +539,7 @@ gsbi5_serial: serial@1a240000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x1a240000 0x100>,
 				      <0x1a200000 0x03>;
-				interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -548,7 +548,7 @@ gsbi5_serial: serial@1a240000 {
 			gsbi5_spi: spi@1a280000 {
 				compatible = "qcom,spi-qup-v1.1.1";
 				reg = <0x1a280000 0x1000>;
-				interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-0 = <&spi5_default>;
 				pinctrl-1 = <&spi5_sleep>;
 				pinctrl-names = "default", "sleep";
@@ -575,7 +575,7 @@ gsbi6_serial: serial@16540000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16540000 0x100>,
 				      <0x16500000 0x03>;
-				interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI6_UART_CLK>, <&gcc GSBI6_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -611,7 +611,7 @@ gsbi7_serial: serial@16640000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16640000 0x1000>,
 				      <0x16600000 0x1000>;
-				interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI7_UART_CLK>, <&gcc GSBI7_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -908,7 +908,7 @@ sdcc3: mmc@12180000 {
 		sdcc3bam: dma-controller@12182000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
-			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc SDC3_H_CLK>;
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
@@ -936,7 +936,7 @@ sdcc4: mmc@121c0000 {
 		sdcc4bam: dma-controller@121c2000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x121c2000 0x8000>;
-			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc SDC4_H_CLK>;
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
@@ -965,7 +965,7 @@ sdcc1: mmc@12400000 {
 		sdcc1bam: dma-controller@12402000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12402000 0x8000>;
-			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc SDC1_H_CLK>;
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index b9c8517e15e7..114c92b4d8d4 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -162,10 +162,10 @@ scm {
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 2 0xf08>,
-			     <1 3 0xf08>,
-			     <1 4 0xf08>,
-			     <1 1 0xf08>;
+		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		clock-frequency = <48000000>;
 		always-on;
 	};
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
index a7c245b9c8f9..17188fe54617 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
@@ -47,7 +47,7 @@ memory {
 
 	cpu-pmu {
 		compatible = "qcom,scorpion-mp-pmu";
-		interrupts = <1 9 0x304>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	clocks {
@@ -89,9 +89,9 @@ intc: interrupt-controller@2080000 {
 
 		timer@2000000 {
 			compatible = "qcom,scss-timer", "qcom,msm-timer";
-			interrupts = <1 0 0x301>,
-				     <1 1 0x301>,
-				     <1 2 0x301>;
+			interrupts = <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+				     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+				     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 			reg = <0x02000000 0x100>;
 			clock-frequency = <27000000>,
 					  <32768>;
@@ -105,7 +105,7 @@ tlmm: pinctrl@800000 {
 			gpio-controller;
 			gpio-ranges = <&tlmm 0 0 173>;
 			#gpio-cells = <2>;
-			interrupts = <0 16 0x4>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
@@ -283,7 +283,7 @@ gsbi12_serial: serial@19c40000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x19c40000 0x1000>,
 				      <0x19c00000 0x1000>;
-				interrupts = <0 195 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI12_UART_CLK>, <&gcc GSBI12_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -292,7 +292,7 @@ gsbi12_serial: serial@19c40000 {
 			gsbi12_i2c: i2c@19c80000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x19c80000 0x1000>;
-				interrupts = <0 196 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI12_QUP_CLK>, <&gcc GSBI12_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index ee202f3f161e..c15c4e6e7754 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -31,7 +31,7 @@ sleep_clk: sleep_clk {
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		interrupts = <GIC_PPI 9 0xf04>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 
 		CPU0: cpu@0 {
 			compatible = "qcom,krait";
@@ -110,7 +110,7 @@ memory {
 
 	pmu {
 		compatible = "qcom,krait-pmu";
-		interrupts = <GIC_PPI 7 0xf04>;
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	rpm: remoteproc {
@@ -538,7 +538,7 @@ blsp1_i2c1: i2c@f9923000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9923000 0x1000>;
-			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			pinctrl-names = "default", "sleep";
@@ -566,7 +566,7 @@ blsp1_i2c3: i2c@f9925000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9925000 0x1000>;
-			interrupts = <0 97 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			pinctrl-names = "default", "sleep";
@@ -666,7 +666,7 @@ blsp2_i2c6: i2c@f9968000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9968000 0x1000>;
-			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			pinctrl-names = "default", "sleep";
@@ -2410,10 +2410,10 @@ gpu2_alert0: trip-point0 {
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 2 0xf08>,
-			     <GIC_PPI 3 0xf08>,
-			     <GIC_PPI 4 0xf08>,
-			     <GIC_PPI 1 0xf08>;
+		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		clock-frequency = <19200000>;
 	};
 };
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 49d9bfeb0c7f..dcb0179996a2 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -728,57 +728,57 @@ timer@17820000 {
 
 			frame@17821000 {
 				frame-number = <0>;
-				interrupts = <GIC_SPI 7 0x4>,
-					     <GIC_SPI 6 0x4>;
+				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17821000 0x1000>,
 				      <0x17822000 0x1000>;
 			};
 
 			frame@17823000 {
 				frame-number = <1>;
-				interrupts = <GIC_SPI 8 0x4>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17823000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17824000 {
 				frame-number = <2>;
-				interrupts = <GIC_SPI 9 0x4>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17824000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17825000 {
 				frame-number = <3>;
-				interrupts = <GIC_SPI 10 0x4>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17825000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17826000 {
 				frame-number = <4>;
-				interrupts = <GIC_SPI 11 0x4>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17826000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17827000 {
 				frame-number = <5>;
-				interrupts = <GIC_SPI 12 0x4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17827000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17828000 {
 				frame-number = <6>;
-				interrupts = <GIC_SPI 13 0x4>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17828000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17829000 {
 				frame-number = <7>;
-				interrupts = <GIC_SPI 14 0x4>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17829000 0x1000>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index bad47174b66c..9ab3e7166b37 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -671,57 +671,57 @@ timer@17820000 {
 
 			frame@17821000 {
 				frame-number = <0>;
-				interrupts = <GIC_SPI 7 0x4>,
-					     <GIC_SPI 6 0x4>;
+				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17821000 0x1000>,
 				      <0x17822000 0x1000>;
 			};
 
 			frame@17823000 {
 				frame-number = <1>;
-				interrupts = <GIC_SPI 8 0x4>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17823000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17824000 {
 				frame-number = <2>;
-				interrupts = <GIC_SPI 9 0x4>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17824000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17825000 {
 				frame-number = <3>;
-				interrupts = <GIC_SPI 10 0x4>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17825000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17826000 {
 				frame-number = <4>;
-				interrupts = <GIC_SPI 11 0x4>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17826000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17827000 {
 				frame-number = <5>;
-				interrupts = <GIC_SPI 12 0x4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17827000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17828000 {
 				frame-number = <6>;
-				interrupts = <GIC_SPI 13 0x4>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17828000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17829000 {
 				frame-number = <7>;
-				interrupts = <GIC_SPI 14 0x4>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17829000 0x1000>;
 				status = "disabled";
 			};
@@ -808,10 +808,10 @@ apps_bcm_voter: bcm-voter {
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 13 0xf08>,
-			<1 12 0xf08>,
-			<1 10 0xf08>,
-			<1 11 0xf08>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		clock-frequency = <19200000>;
 	};
 };
-- 
2.34.1

