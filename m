Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194867684FC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjG3LPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjG3LPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:15:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D91BF3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:15:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9a828c920so54836331fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690715744; x=1691320544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rI8PZ46CRm5rPlprnsD+h3GA3M1guin49VXQfC/Qzsc=;
        b=gibJm5ppqm4ax8BfuMdCqXN9mpAG7VxJnpOby1ce/dffOebRVZOtt7yQcFe+FkFXjU
         sxCCqG3e4CszNwF4QTCgaJScyo3IbmeFWs1/h+NNXvTylb+Vor08wGvJoB2dEXjppXSh
         dUPuFaHl10DZijg2cklP2150ySxqYvCHafuIBOlFhDlufhn/9ECue4sbPnt28UHfR8u3
         DGs82RyHTmOVrGhgfmjYyadwX2lb9XEKF/Qt6xrTCiTko0ZVvwGFEwMHXhNiZ2dNs+CK
         QsOpnEvPnuylA97Q2EEVxIwoc2TQZr1tE09kHcM+ZYgt6HTPRCA6PWWxv1eRfDrMPwEV
         /1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690715744; x=1691320544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rI8PZ46CRm5rPlprnsD+h3GA3M1guin49VXQfC/Qzsc=;
        b=Em3kYwUDOSnOKTD5GXwQ8enGidPz51fyGK8fPLKJB/vc6cyz5enV1eWfFouwRKlKBy
         WTUZ61vuNMViNSrYz7gwzAVb3ofrdxWQJXn83ju593nk842wJlz7njeJsAnS4hO6c39O
         HgjYlUg63Mq+Yo1Zab9HQNUx0gJnAwX/Y5Y/M1zzyyWp0iFX4v8WAnXQURiorK8halJ5
         M54Eh9lK3XKkZBXQ1279CTKJR5HuStm/3ZcCTCGJrcT9TMqO5lCt9pSnXiV1pJPF+qJg
         c2PAeVEWMFE1wM2odtTkkgv0o1oG0D/K3RGMqUCri06n4t1VlE8M+MDQ/BsW8pnCU5MA
         j19g==
X-Gm-Message-State: ABy/qLa8qbg8yIqW1jeO9KVAhnS1itYthiPegkKk5j1bGYsuuS9pvhJv
        F8DkPDKbfUhi7Y5YHuBA3Nvzkw==
X-Google-Smtp-Source: APBJJlETLxtPgdHDxR2ZmU6WGc7SOPYH5KwjsWNAWugCASiRjbLdKI2Kkb2Ji14bYZYGRjI/34tg3Q==
X-Received: by 2002:ac2:5f9c:0:b0:4f9:5d2a:e0f6 with SMTP id r28-20020ac25f9c000000b004f95d2ae0f6mr3897035lfe.14.1690715744420;
        Sun, 30 Jul 2023 04:15:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id h2-20020aa7c602000000b00522536c2e6esm4045756edq.38.2023.07.30.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 04:15:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: microchip: split interrupts per cells
Date:   Sun, 30 Jul 2023 13:15:41 +0200
Message-Id: <20230730111542.98238-1-krzysztof.kozlowski@linaro.org>
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

Each interrupt should be in its own cell.  This is much more readable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/microchip/at91rm9200.dtsi  | 12 +++---
 arch/arm/boot/dts/microchip/at91sam9260.dtsi | 12 +++---
 arch/arm/boot/dts/microchip/sama5d2.dtsi     |  6 +--
 arch/arm/boot/dts/microchip/sama7g5.dtsi     | 40 ++++++++++----------
 4 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91rm9200.dtsi b/arch/arm/boot/dts/microchip/at91rm9200.dtsi
index 37b500f6f395..16c675e3a890 100644
--- a/arch/arm/boot/dts/microchip/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/microchip/at91rm9200.dtsi
@@ -135,9 +135,9 @@ tcb0: timer@fffa0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xfffa0000 0x100>;
-				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
-					      18 IRQ_TYPE_LEVEL_HIGH 0
-					      19 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <18 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <19 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&pmc PMC_TYPE_PERIPHERAL 18>, <&pmc PMC_TYPE_PERIPHERAL 19>, <&slow_xtal>;
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
@@ -147,9 +147,9 @@ tcb1: timer@fffa4000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xfffa4000 0x100>;
-				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0
-					      21 IRQ_TYPE_LEVEL_HIGH 0
-					      22 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <21 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <22 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 20>, <&pmc PMC_TYPE_PERIPHERAL 21>, <&pmc PMC_TYPE_PERIPHERAL 22>, <&slow_xtal>;
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
diff --git a/arch/arm/boot/dts/microchip/at91sam9260.dtsi b/arch/arm/boot/dts/microchip/at91sam9260.dtsi
index 27b4a21f13c1..e56d5546554c 100644
--- a/arch/arm/boot/dts/microchip/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9260.dtsi
@@ -148,9 +148,9 @@ tcb0: timer@fffa0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xfffa0000 0x100>;
-				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
-					      18 IRQ_TYPE_LEVEL_HIGH 0
-					      19 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <18 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <19 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&pmc PMC_TYPE_PERIPHERAL 18>, <&pmc PMC_TYPE_PERIPHERAL 19>, <&pmc PMC_TYPE_CORE PMC_SLOW>;
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
@@ -160,9 +160,9 @@ tcb1: timer@fffdc000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xfffdc000 0x100>;
-				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0
-					      27 IRQ_TYPE_LEVEL_HIGH 0
-					      28 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <27 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <28 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 26>, <&pmc PMC_TYPE_PERIPHERAL 27>, <&pmc PMC_TYPE_PERIPHERAL 28>, <&pmc PMC_TYPE_CORE PMC_SLOW>;
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
diff --git a/arch/arm/boot/dts/microchip/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
index daeeb24e5f4d..5f8e297e19ed 100644
--- a/arch/arm/boot/dts/microchip/sama5d2.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d2.dtsi
@@ -382,9 +382,9 @@ AT91_XDMAC_DT_PERID(21))>,
 			macb0: ethernet@f8008000 {
 				compatible = "atmel,sama5d2-gem";
 				reg = <0xf8008000 0x1000>;
-				interrupts = <5  IRQ_TYPE_LEVEL_HIGH 3		/* Queue 0 */
-					      66 IRQ_TYPE_LEVEL_HIGH 3          /* Queue 1 */
-					      67 IRQ_TYPE_LEVEL_HIGH 3>;        /* Queue 2 */
+				interrupts = <5  IRQ_TYPE_LEVEL_HIGH 3>,	/* Queue 0 */
+					     <66 IRQ_TYPE_LEVEL_HIGH 3>,	/* Queue 1 */
+					     <67 IRQ_TYPE_LEVEL_HIGH 3>;        /* Queue 2 */
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>, <&pmc PMC_TYPE_PERIPHERAL 5>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 9642a42d84e6..269e0a3ca269 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -366,8 +366,8 @@ can0: can@e0828000 {
 			compatible = "bosch,m_can";
 			reg = <0xe0828000 0x100>, <0x100000 0x7800>;
 			reg-names = "m_can", "message_ram";
-			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 61>, <&pmc PMC_TYPE_GCK 61>;
 			clock-names = "hclk", "cclk";
@@ -382,8 +382,8 @@ can1: can@e082c000 {
 			compatible = "bosch,m_can";
 			reg = <0xe082c000 0x100>, <0x100000 0xbc00>;
 			reg-names = "m_can", "message_ram";
-			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 62>, <&pmc PMC_TYPE_GCK 62>;
 			clock-names = "hclk", "cclk";
@@ -398,8 +398,8 @@ can2: can@e0830000 {
 			compatible = "bosch,m_can";
 			reg = <0xe0830000 0x100>, <0x100000 0x10000>;
 			reg-names = "m_can", "message_ram";
-			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 63>, <&pmc PMC_TYPE_GCK 63>;
 			clock-names = "hclk", "cclk";
@@ -414,8 +414,8 @@ can3: can@e0834000 {
 			compatible = "bosch,m_can";
 			reg = <0xe0834000 0x100>, <0x110000 0x4400>;
 			reg-names = "m_can", "message_ram";
-			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 64>, <&pmc PMC_TYPE_GCK 64>;
 			clock-names = "hclk", "cclk";
@@ -430,8 +430,8 @@ can4: can@e0838000 {
 			compatible = "bosch,m_can";
 			reg = <0xe0838000 0x100>, <0x110000 0x8800>;
 			reg-names = "m_can", "message_ram";
-			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 65>, <&pmc PMC_TYPE_GCK 65>;
 			clock-names = "hclk", "cclk";
@@ -446,8 +446,8 @@ can5: can@e083c000 {
 			compatible = "bosch,m_can";
 			reg = <0xe083c000 0x100>, <0x110000 0xcc00>;
 			reg-names = "m_can", "message_ram";
-			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 66>, <&pmc PMC_TYPE_GCK 66>;
 			clock-names = "hclk", "cclk";
@@ -845,12 +845,12 @@ uart7: serial@200 {
 		gmac0: ethernet@e2800000 {
 			compatible = "microchip,sama7g5-gem";
 			reg = <0xe2800000 0x1000>;
-			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 51>, <&pmc PMC_TYPE_PERIPHERAL 51>, <&pmc PMC_TYPE_GCK 51>, <&pmc PMC_TYPE_GCK 53>;
 			clock-names = "pclk", "hclk", "tx_clk", "tsu_clk";
 			assigned-clocks = <&pmc PMC_TYPE_GCK 51>;
@@ -861,8 +861,8 @@ GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH
 		gmac1: ethernet@e2804000 {
 			compatible = "microchip,sama7g5-emac";
 			reg = <0xe2804000 0x1000>;
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 52>, <&pmc PMC_TYPE_PERIPHERAL 52>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
-- 
2.34.1

