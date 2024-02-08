Return-Path: <linux-kernel+bounces-58085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70AE84E118
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8DD1F29BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65C7D40E;
	Thu,  8 Feb 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GSCR1V+2"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2577D405
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396256; cv=none; b=aYXJ1WZame37PseYhHc40UVtVsRxDvA+q1xbU+wVC2IrC55s/LIluxHjOJtHr951HLUvB1OtlVClcvyUbcjbAbImTwNvdEMe6fwhMFwrFRszSRlQEMyKJ41YMfZgzlFsymx6EHDwCAjrpS4wKv4wg9V0nSiRcxhUkWc8NCuSmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396256; c=relaxed/simple;
	bh=iwuGUChOPncL9tXnA90KUoncCTsZfzgO0kLEDg7hSbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GsjUccHN6IKv8RinPkZlZKtU+VMelNlYBwAYv8E8qkHkERGSEp/mdoDO1qgiluP5AAmrNUEQyNeQq6hrADVo8OI/v5bRQdTRe8reixsVq8nXf3Qg23TxSGDP9JEb0MEus3cC/2tjuN8wnvoQM2/JQKQMO2WpxeQNx0SzTAQJkd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GSCR1V+2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51147d0abd1so2096513e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707396252; x=1708001052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1OEC2TGCoY61eo3wIHDOREKTL6pfLj41IN2rZ/kx+k=;
        b=GSCR1V+24vnD0elY9qmyDqv7tOxxQkfKnUrqWX2e38V/SHuW3pUUiYGZVfGLo0f1WK
         KqcA0izA1kCX9jY+Qv/IWyD4BcAXR8sRikwK3a7DY9UYQSp5wNMvVlHUA0lVX1uADU4w
         2Uwwk/YYr6UKMHY/ti36mCEAmJTI1cCYtTYhxvKY0fhC+COOqhPB2LSDq7noZL8i7hW1
         4olBckcaHo6cOxIizgPT6wOUfufTP1edfUQ7c3SZp5eTGjac1ECx4euNUQpUFPRkB7MG
         iyM40c4RDdAsoSQoWmk2kkrVzs+VonfhIvmM5IkaSxLOuXWSOhDqpA7SXp3OHhdMfdAm
         f1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396252; x=1708001052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1OEC2TGCoY61eo3wIHDOREKTL6pfLj41IN2rZ/kx+k=;
        b=vva6s02jR4Ls810j8QchOsjNpzoUBek/iSGqdkSWcNbRh1yi2F7kVBJHloNYocatQb
         XlLtS9bAPQTC/NxGdKnts6z+Nuy6PwcaeYKtneYyq+Jvx/ztpFQfxaKxPHRbgx6+E6C3
         pS3VJVF/sWwPvvCzdQfKj6A9H/+o1urcXMV4N2tBl1GGy9qTj/6uZgZSbnkaMMeIskWh
         vG/FRHZ0m4Wu8QzzxAzgG423i2jvIsDqG4G/6qTt+qq1tTA5PruN3gaUbjTf0SbbROKi
         x7yLYHc2FLQy4wf7Cdd4BQ2jOXhwT87JhMzUMVAylwllfFmfW0Dyht0Iel0maKBx5IhO
         aXWA==
X-Gm-Message-State: AOJu0Ywpnu2MnIrQMHm/HSCPncplcGq9MfenuFFpIFWMVi3y/1bhE4j1
	3SuDCkkoPJlgEoocIhe2xoYMAh1BDldAL9TbwGCrCHUf8Bs+DnqKSj/BftWrDvs=
X-Google-Smtp-Source: AGHT+IFuY8aJN8uAbwsfcvyYL2SSxdbplBVBbG1hcv48UfkKaNutTJ7x4FhnQPP25P1zzLOULgHIFA==
X-Received: by 2002:ac2:51b9:0:b0:511:552e:6ee3 with SMTP id f25-20020ac251b9000000b00511552e6ee3mr5708379lfk.39.1707396252359;
        Thu, 08 Feb 2024 04:44:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjpYGt1NJEfb6j/M95q9qoJUByI0mWDph51t57B6nJclQ4TZTsbk/7rtb2zpzqxYplrNcFELwfgJOBgmdMX8jSxHyFN20zXgZMO2s/FeNUMO5mCmcNGaAtZPtcMcLtIXj6ewiVc8R3mx8C1jn5ZmqZ/vjUZEWF/XIAYByb+A/59AVZWuPaqUROjEmOH1rObLvH8xiXlABoyztj4sl9kEX96ezV214lXsNCJb7CLmMIvRA6hlXjmM3mD0hyisAdCJa49moxdVhatpLBLPMlL0PO3tZdGYPF2tV5/4H0eGzUu0w9PMIkSxYCeEcNir4wC8iCdvgsAr2ZbT4ndmkVLigPYMs7XJ3vMhYWttfcABT0luynyK7u3xMeAlFhiJOFckPdnrytjuX5M0zRZXZ2BHP7itUWh2yYjXuHZvAvmrsQt3mOx/92Bro2nOQENJbcsEzmQ/nEAwFajz/cWrcdqwEZUbnHDN1DMEatjvC61VH7/o/mNFSVAzPsft8B/p0/r4MVrSz7fdqV3EzM9Iwqq++T9ARF67ye6K0PbknzRP2ARsoN3Yu1TcRXx55WwrIgN14=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0041047382b76sm790244wmq.37.2024.02.08.04.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:44:12 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 13/17] arm64: dts: renesas: r9a07g043: Update #power-domain-cells = <1>
Date: Thu,  8 Feb 2024 14:42:56 +0200
Message-Id: <20240208124300.2740313-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Update CPG #power-domain-cells = <1> and move all the IPs to be part of the
always on power domain as the driver has been modified to support multiple
power domains.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 84 ++++++++++-----------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi |  6 +-
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |  2 +-
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 8721f4c9fa0f..3e12f9dd3c6a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -138,7 +138,7 @@ mtu3: timer@10001200 {
 					  "tgia8", "tgib8", "tgic8", "tgid8",
 					  "tciv8", "tciu8";
 			clocks = <&cpg CPG_MOD R9A07G043_MTU_X_MCK_MTU3>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_MTU_X_PRESET_MTU3>;
 			#pwm-cells = <2>;
 			status = "disabled";
@@ -159,7 +159,7 @@ ssi0: ssi@10049c00 {
 			resets = <&cpg R9A07G043_SSI0_RST_M2_REG>;
 			dmas = <&dmac 0x2655>, <&dmac 0x2656>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -179,7 +179,7 @@ ssi1: ssi@1004a000 {
 			resets = <&cpg R9A07G043_SSI1_RST_M2_REG>;
 			dmas = <&dmac 0x2659>, <&dmac 0x265a>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -198,7 +198,7 @@ ssi2: ssi@1004a400 {
 			resets = <&cpg R9A07G043_SSI2_RST_M2_REG>;
 			dmas = <&dmac 0x265f>;
 			dma-names = "rt";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -218,7 +218,7 @@ ssi3: ssi@1004a800 {
 			resets = <&cpg R9A07G043_SSI3_RST_M2_REG>;
 			dmas = <&dmac 0x2661>, <&dmac 0x2662>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -234,7 +234,7 @@ spi0: spi@1004ac00 {
 			resets = <&cpg R9A07G043_RSPI0_RST>;
 			dmas = <&dmac 0x2e95>, <&dmac 0x2e96>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -252,7 +252,7 @@ spi1: spi@1004b000 {
 			resets = <&cpg R9A07G043_RSPI1_RST>;
 			dmas = <&dmac 0x2e99>, <&dmac 0x2e9a>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -270,7 +270,7 @@ spi2: spi@1004b400 {
 			resets = <&cpg R9A07G043_RSPI2_RST>;
 			dmas = <&dmac 0x2e9d>, <&dmac 0x2e9e>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -291,7 +291,7 @@ scif0: serial@1004b800 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF0_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_SCIF0_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -310,7 +310,7 @@ scif1: serial@1004bc00 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF1_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_SCIF1_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -329,7 +329,7 @@ scif2: serial@1004c000 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF2_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_SCIF2_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -348,7 +348,7 @@ scif3: serial@1004c400 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF3_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_SCIF3_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -367,7 +367,7 @@ scif4: serial@1004c800 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF4_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_SCIF4_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -382,7 +382,7 @@ sci0: serial@1004d000 {
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCI0_CLKP>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_SCI0_RST>;
 			status = "disabled";
 		};
@@ -397,7 +397,7 @@ sci1: serial@1004d400 {
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCI1_CLKP>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_SCI1_RST>;
 			status = "disabled";
 		};
@@ -425,7 +425,7 @@ canfd: can@10050000 {
 			resets = <&cpg R9A07G043_CANFD_RSTP_N>,
 				 <&cpg R9A07G043_CANFD_RSTC_N>;
 			reset-names = "rstp_n", "rstc_n";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			channel0 {
@@ -454,7 +454,7 @@ i2c0: i2c@10058000 {
 			clocks = <&cpg CPG_MOD R9A07G043_I2C0_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G043_I2C0_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -476,7 +476,7 @@ i2c1: i2c@10058400 {
 			clocks = <&cpg CPG_MOD R9A07G043_I2C1_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G043_I2C1_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -498,7 +498,7 @@ i2c2: i2c@10058800 {
 			clocks = <&cpg CPG_MOD R9A07G043_I2C2_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G043_I2C2_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -520,7 +520,7 @@ i2c3: i2c@10058c00 {
 			clocks = <&cpg CPG_MOD R9A07G043_I2C3_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G043_I2C3_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -534,7 +534,7 @@ adc: adc@10059000 {
 			resets = <&cpg R9A07G043_ADC_PRESETN>,
 				 <&cpg R9A07G043_ADC_ADRST_N>;
 			reset-names = "presetn", "adrst-n";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			#address-cells = <1>;
@@ -554,7 +554,7 @@ tsu: thermal@10059400 {
 			reg = <0 0x10059400 0 0x400>;
 			clocks = <&cpg CPG_MOD R9A07G043_TSU_PCLK>;
 			resets = <&cpg R9A07G043_TSU_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -568,7 +568,7 @@ sbc: spi@10060000 {
 			clocks = <&cpg CPG_MOD R9A07G043_SPI_CLK2>,
 				 <&cpg CPG_MOD R9A07G043_SPI_CLK>;
 			resets = <&cpg R9A07G043_SPI_RST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -581,7 +581,7 @@ cpg: clock-controller@11010000 {
 			clock-names = "extal";
 			#clock-cells = <2>;
 			#reset-cells = <1>;
-			#power-domain-cells = <0>;
+			#power-domain-cells = <1>;
 		};
 
 		sysc: system-controller@11020000 {
@@ -599,7 +599,7 @@ pinctrl: pinctrl@11030000 {
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_GPIO_RSTN>,
 				 <&cpg R9A07G043_GPIO_PORT_RESETN>,
 				 <&cpg R9A07G043_GPIO_SPARE_RESETN>;
@@ -635,7 +635,7 @@ dmac: dma-controller@11820000 {
 			clocks = <&cpg CPG_MOD R9A07G043_DMAC_ACLK>,
 				 <&cpg CPG_MOD R9A07G043_DMAC_PCLK>;
 			clock-names = "main", "register";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G043_DMAC_ARESETN>,
 				 <&cpg R9A07G043_DMAC_RST_ASYNC>;
 			reset-names = "arst", "rst_async";
@@ -655,7 +655,7 @@ sdhi0: mmc@11c00000 {
 				 <&cpg CPG_MOD R9A07G043_SDHI0_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A07G043_SDHI0_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -671,7 +671,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A07G043_SDHI1_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A07G043_SDHI1_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -689,7 +689,7 @@ eth0: ethernet@11c20000 {
 				 <&cpg CPG_CORE R9A07G043_CLK_HP>;
 			clock-names = "axi", "chi", "refclk";
 			resets = <&cpg R9A07G043_ETH0_RST_HW_N>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -709,7 +709,7 @@ eth1: ethernet@11c30000 {
 				 <&cpg CPG_CORE R9A07G043_CLK_HP>;
 			clock-names = "axi", "chi", "refclk";
 			resets = <&cpg R9A07G043_ETH1_RST_HW_N>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -721,7 +721,7 @@ phyrst: usbphy-ctrl@11c40000 {
 			reg = <0 0x11c40000 0 0x10000>;
 			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>;
 			resets = <&cpg R9A07G043_USB_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			#reset-cells = <1>;
 			status = "disabled";
 		};
@@ -736,7 +736,7 @@ ohci0: usb@11c50000 {
 				 <&cpg R9A07G043_USB_U2H0_HRESETN>;
 			phys = <&usb2_phy0 1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -750,7 +750,7 @@ ohci1: usb@11c70000 {
 				 <&cpg R9A07G043_USB_U2H1_HRESETN>;
 			phys = <&usb2_phy1 1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -765,7 +765,7 @@ ehci0: usb@11c50100 {
 			phys = <&usb2_phy0 2>;
 			phy-names = "usb";
 			companion = <&ohci0>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -780,7 +780,7 @@ ehci1: usb@11c70100 {
 			phys = <&usb2_phy1 2>;
 			phy-names = "usb";
 			companion = <&ohci1>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -793,7 +793,7 @@ usb2_phy0: usb-phy@11c50200 {
 				 <&cpg CPG_MOD R9A07G043_USB_U2H0_HCLK>;
 			resets = <&phyrst 0>;
 			#phy-cells = <1>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -806,7 +806,7 @@ usb2_phy1: usb-phy@11c70200 {
 				 <&cpg CPG_MOD R9A07G043_USB_U2H1_HCLK>;
 			resets = <&phyrst 1>;
 			#phy-cells = <1>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -825,7 +825,7 @@ hsusb: usb@11c60000 {
 			renesas,buswait = <7>;
 			phys = <&usb2_phy0 3>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -840,7 +840,7 @@ wdt0: watchdog@12800800 {
 				     <SOC_PERIPHERAL_IRQ(50) IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "wdt", "perrout";
 			resets = <&cpg R9A07G043_WDT0_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -851,7 +851,7 @@ ostm0: timer@12801000 {
 			interrupts = <SOC_PERIPHERAL_IRQ(46) IRQ_TYPE_EDGE_RISING>;
 			clocks = <&cpg CPG_MOD R9A07G043_OSTM0_PCLK>;
 			resets = <&cpg R9A07G043_OSTM0_PRESETZ>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -862,7 +862,7 @@ ostm1: timer@12801400 {
 			interrupts = <SOC_PERIPHERAL_IRQ(47) IRQ_TYPE_EDGE_RISING>;
 			clocks = <&cpg CPG_MOD R9A07G043_OSTM1_PCLK>;
 			resets = <&cpg R9A07G043_OSTM1_PRESETZ>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -873,7 +873,7 @@ ostm2: timer@12801800 {
 			interrupts = <SOC_PERIPHERAL_IRQ(48) IRQ_TYPE_EDGE_RISING>;
 			clocks = <&cpg CPG_MOD R9A07G043_OSTM2_PCLK>;
 			resets = <&cpg R9A07G043_OSTM2_PRESETZ>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 01d08ebb4a78..1ac71b9cbbb6 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -75,7 +75,7 @@ cru: video@10830000 {
 		resets = <&cpg R9A07G043_CRU_PRESETN>,
 			 <&cpg R9A07G043_CRU_ARESETN>;
 		reset-names = "presetn", "aresetn";
-		power-domains = <&cpg>;
+		power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		ports {
@@ -106,7 +106,7 @@ csi2: csi2@10830400 {
 		resets = <&cpg R9A07G043_CRU_PRESETN>,
 			 <&cpg R9A07G043_CRU_CMN_RSTB>;
 		reset-names = "presetn", "cmn-rstb";
-		power-domains = <&cpg>;
+		power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		ports {
@@ -194,7 +194,7 @@ irqc: interrupt-controller@110a0000 {
 		clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
 			<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
 		clock-names = "clk", "pclk";
-		power-domains = <&cpg>;
+		power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 		resets = <&cpg R9A07G043_IA55_RESETN>;
 	};
 
diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index 09ef10b39f46..925203746b28 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -62,7 +62,7 @@ plic: interrupt-controller@12c00000 {
 		interrupt-controller;
 		reg = <0x0 0x12c00000 0 0x400000>;
 		clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
-		power-domains = <&cpg>;
+		power-domains = <&cpg R9A07G043_PD_ALWAYS_ON>;
 		resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
 		interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
 	};
-- 
2.39.2


