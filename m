Return-Path: <linux-kernel+bounces-58086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313484E11C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EAB1F2A2EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8AF7E789;
	Thu,  8 Feb 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GmnIh2Sx"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7037E56E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396258; cv=none; b=FvZGHkD58qdIdZtzvdBZSnIP5t5VpWBTIeqh3dNvSMLEW1SVE0NWKJ1r/BWV4BNNgwg2HbaqAWmWPaN66sM2pHFC6addY0BVx0yT64lrp7T8fMJN8Nr7h9P/uAO04Vui15IOj74Ggj6Zdw2ktrWiA675STLVv1FRZn9KimqrICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396258; c=relaxed/simple;
	bh=6kRKQLioG6pCW21DjA1cjPhIw6mveabny2PHjMxWz+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TvKSaqS4KSaTnRWv1mwDifiAZ1EOLrecSlpWL4fNYM1RiPHtx87ql4TEwU/qKTRpUWreogzD5RIvC28dXDmIiHtkwXi6fe/1JcLRXYCb9JJz8QjOagU9ixJwUXHEcSdKXcJ0Aq45WlPU6pwadF8ULwTGog5LWs5VtWrZESxmvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GmnIh2Sx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410489e1a63so2214975e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707396255; x=1708001055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q05WYI4OL+ukrmA7Gg9x6hfcXcT/QN33PCIAMcnws4=;
        b=GmnIh2SxGtms6ucABlwFkxl9HxA1q1/Sp2ktlVzzpSSFEWUurG9TDKUAroKHqSjMeq
         Cg/t37FoQeqcvDV7HcN+NhHu87yOHWQcTnrlRhniAexOGw2amFiiyOXbTWKj5wmMR1rv
         tuea+YmfKKy+bCXXrF66p66a+yAhQp2SlISE8ZXAz6bN/It5ijwb7MV4oMZDYkt4gX4N
         O9iLoh0b2dkObDKl2DfocnmahmdWJPr/SZlMeGz7hf1Kai5+9AXkJyGM+A7bDCR8s3Vl
         EHuPCWQ0cA0MHDO+lxdqxzLDAUGjhdgMp9i7cgMvOs4DWvNHE3zcwkgEeWTljS7EFDVz
         I5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396255; x=1708001055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2q05WYI4OL+ukrmA7Gg9x6hfcXcT/QN33PCIAMcnws4=;
        b=tQpb6GamtdY1zNA5Iw5zAQ5mzquOTdveyeUDL7CMMdptEKs0sB/ZNmahkTTguPLLW9
         CGB0cx7DdroJyJH78ml2JLG+jD+6hqor8yFvS4R2lm43+crwVuQ9uJGT/QGOA+xZAxsF
         hQccw5dPbQw6eIaxu/pF8mk9y8CQhz1RlWphVHlp0ObHOm877o/piZ3joCqlDQ/R3usI
         Spar5RMoRhT0W6sgwE6060Ajx9GcgEAstyXYXtGV1jmcWmqjoHBMuVae67SVPRaw9DWM
         GO7K/4DslibvtYjrt97ZVYB9ST9LhkXrO1xsXLLdIFifeRvXwQGmXlcyzyVqOWpHaeox
         uAKQ==
X-Gm-Message-State: AOJu0Yzq5j245ZRoQE/kkFDJWH/3LbC4XFeeQjfGVFQ3v2oyXY4Hzguq
	oOJPGInRjha8xthuKkua3qDNU+ATA4z2nxmzs4BMEhYL8+OqNH+zFAc6iKw1btQ=
X-Google-Smtp-Source: AGHT+IG5EcP/61vXjAblcOalkQazT+acBguefB9TDBTYP7+ez8UQRFfPBdgeOLz7m32ZQVXuV8jdRg==
X-Received: by 2002:a05:600c:1c21:b0:40d:3fee:97f6 with SMTP id j33-20020a05600c1c2100b0040d3fee97f6mr6528520wms.34.1707396254854;
        Thu, 08 Feb 2024 04:44:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV02lG8nozcROyUGNAXy1XL9cR9Hey9exiMwlHIJ+8jlWEpLAqe+9kNay6GNVkjMXXPsmitjGa7JfIT8A8z6JTeK4sZctmey/6r07CrJszFHIo+lme2iws0xeGZnymXkqLSghA/6MOlV+Pr90pbWipjOrB97BUFFh6d0VuCf3aQpbMa7IVRG+/rsipzDh/P8sLKTdhwXeYpFaDiawIeEYiRuUm9DNZOMSjOTj+/m6TGRLeRpuAjKnebJPKh6lyvM6p8RtLUiuRCaE1oaG7Fz3LOHwnrXIB7+l4SaeKpEg8+N2ijVzwVf1qAL3929naoYWnd4soOc0o8E0K7bIoJmvynE5Jo8Kq09HAjk+FLPLFSZ5kl7TxFu2lZzpLzMUGN+3+BeqZ32blnFd2xuM9gW1734R4+iyh1ahFqmTV7oz5lI7yKyFWhkTZRuoMkvrjqchUAut4jFOlDTs32LDp1OlwE5GhMLe1L5ipeTG5kvOGcbCyBF1+eQ12eBnRYrxFvSFJE398BymdNY7fWyUo9iXZtpkyVzIenldNylZgtbnen6c/JVq2pAYUMPmc/49zxOcg=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0041047382b76sm790244wmq.37.2024.02.08.04.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:44:14 -0800 (PST)
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
Subject: [PATCH 14/17] arm64: dts: renesas: r9a07g044: Update #power-domain-cells = <1>
Date: Thu,  8 Feb 2024 14:42:57 +0200
Message-Id: <20240208124300.2740313-15-claudiu.beznea.uj@bp.renesas.com>
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
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 100 ++++++++++-----------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 66f68fc2b241..c6aa62351b89 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -238,7 +238,7 @@ mtu3: timer@10001200 {
 					  "tgia8", "tgib8", "tgic8", "tgid8",
 					  "tciv8", "tciu8";
 			clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
 			#pwm-cells = <2>;
 			status = "disabled";
@@ -259,7 +259,7 @@ ssi0: ssi@10049c00 {
 			resets = <&cpg R9A07G044_SSI0_RST_M2_REG>;
 			dmas = <&dmac 0x2655>, <&dmac 0x2656>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -279,7 +279,7 @@ ssi1: ssi@1004a000 {
 			resets = <&cpg R9A07G044_SSI1_RST_M2_REG>;
 			dmas = <&dmac 0x2659>, <&dmac 0x265a>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -298,7 +298,7 @@ ssi2: ssi@1004a400 {
 			resets = <&cpg R9A07G044_SSI2_RST_M2_REG>;
 			dmas = <&dmac 0x265f>;
 			dma-names = "rt";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -318,7 +318,7 @@ ssi3: ssi@1004a800 {
 			resets = <&cpg R9A07G044_SSI3_RST_M2_REG>;
 			dmas = <&dmac 0x2661>, <&dmac 0x2662>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -334,7 +334,7 @@ spi0: spi@1004ac00 {
 			resets = <&cpg R9A07G044_RSPI0_RST>;
 			dmas = <&dmac 0x2e95>, <&dmac 0x2e96>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -352,7 +352,7 @@ spi1: spi@1004b000 {
 			resets = <&cpg R9A07G044_RSPI1_RST>;
 			dmas = <&dmac 0x2e99>, <&dmac 0x2e9a>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -370,7 +370,7 @@ spi2: spi@1004b400 {
 			resets = <&cpg R9A07G044_RSPI2_RST>;
 			dmas = <&dmac 0x2e9d>, <&dmac 0x2e9e>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -390,7 +390,7 @@ scif0: serial@1004b800 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G044_SCIF0_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_SCIF0_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -408,7 +408,7 @@ scif1: serial@1004bc00 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G044_SCIF1_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_SCIF1_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -426,7 +426,7 @@ scif2: serial@1004c000 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G044_SCIF2_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_SCIF2_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -444,7 +444,7 @@ scif3: serial@1004c400 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G044_SCIF3_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_SCIF3_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -462,7 +462,7 @@ scif4: serial@1004c800 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G044_SCIF4_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_SCIF4_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -477,7 +477,7 @@ sci0: serial@1004d000 {
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G044_SCI0_CLKP>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_SCI0_RST>;
 			status = "disabled";
 		};
@@ -492,7 +492,7 @@ sci1: serial@1004d400 {
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G044_SCI1_CLKP>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_SCI1_RST>;
 			status = "disabled";
 		};
@@ -520,7 +520,7 @@ canfd: can@10050000 {
 			resets = <&cpg R9A07G044_CANFD_RSTP_N>,
 				 <&cpg R9A07G044_CANFD_RSTC_N>;
 			reset-names = "rstp_n", "rstc_n";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			channel0 {
@@ -549,7 +549,7 @@ i2c0: i2c@10058000 {
 			clocks = <&cpg CPG_MOD R9A07G044_I2C0_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G044_I2C0_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -571,7 +571,7 @@ i2c1: i2c@10058400 {
 			clocks = <&cpg CPG_MOD R9A07G044_I2C1_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G044_I2C1_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -593,7 +593,7 @@ i2c2: i2c@10058800 {
 			clocks = <&cpg CPG_MOD R9A07G044_I2C2_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G044_I2C2_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -615,7 +615,7 @@ i2c3: i2c@10058c00 {
 			clocks = <&cpg CPG_MOD R9A07G044_I2C3_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G044_I2C3_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -629,7 +629,7 @@ adc: adc@10059000 {
 			resets = <&cpg R9A07G044_ADC_PRESETN>,
 				 <&cpg R9A07G044_ADC_ADRST_N>;
 			reset-names = "presetn", "adrst-n";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			#address-cells = <1>;
@@ -667,7 +667,7 @@ tsu: thermal@10059400 {
 			reg = <0 0x10059400 0 0x400>;
 			clocks = <&cpg CPG_MOD R9A07G044_TSU_PCLK>;
 			resets = <&cpg R9A07G044_TSU_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -682,7 +682,7 @@ sbc: spi@10060000 {
 			clocks = <&cpg CPG_MOD R9A07G044_SPI_CLK2>,
 				 <&cpg CPG_MOD R9A07G044_SPI_CLK>;
 			resets = <&cpg R9A07G044_SPI_RST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -702,7 +702,7 @@ cru: video@10830000 {
 			resets = <&cpg R9A07G044_CRU_PRESETN>,
 				 <&cpg R9A07G044_CRU_ARESETN>;
 			reset-names = "presetn", "aresetn";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			ports {
@@ -743,7 +743,7 @@ csi2: csi2@10830400 {
 			resets = <&cpg R9A07G044_CRU_PRESETN>,
 				 <&cpg R9A07G044_CRU_CMN_RSTB>;
 			reset-names = "presetn", "cmn-rstb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			ports {
@@ -791,7 +791,7 @@ dsi: dsi@10850000 {
 				 <&cpg R9A07G044_MIPI_DSI_ARESET_N>,
 				 <&cpg R9A07G044_MIPI_DSI_PRESET_N>;
 			reset-names = "rst", "arst", "prst";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -803,7 +803,7 @@ vspd: vsp@10870000 {
 				 <&cpg CPG_MOD R9A07G044_LCDC_CLK_P>,
 				 <&cpg CPG_MOD R9A07G044_LCDC_CLK_D>;
 			clock-names = "aclk", "pclk", "vclk";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_LCDC_RESET_N>;
 			renesas,fcp = <&fcpvd>;
 		};
@@ -816,7 +816,7 @@ fcpvd: fcp@10880000 {
 				 <&cpg CPG_MOD R9A07G044_LCDC_CLK_P>,
 				 <&cpg CPG_MOD R9A07G044_LCDC_CLK_D>;
 			clock-names = "aclk", "pclk", "vclk";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_LCDC_RESET_N>;
 		};
 
@@ -827,7 +827,7 @@ cpg: clock-controller@11010000 {
 			clock-names = "extal";
 			#clock-cells = <2>;
 			#reset-cells = <1>;
-			#power-domain-cells = <0>;
+			#power-domain-cells = <1>;
 		};
 
 		sysc: system-controller@11020000 {
@@ -852,7 +852,7 @@ pinctrl: pinctrl@11030000 {
 			interrupt-controller;
 			gpio-ranges = <&pinctrl 0 0 392>;
 			clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_GPIO_RSTN>,
 				 <&cpg R9A07G044_GPIO_PORT_RESETN>,
 				 <&cpg R9A07G044_GPIO_SPARE_RESETN>;
@@ -909,7 +909,7 @@ irqc: interrupt-controller@110a0000 {
 			clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_IA55_RESETN>;
 		};
 
@@ -943,7 +943,7 @@ dmac: dma-controller@11820000 {
 			clocks = <&cpg CPG_MOD R9A07G044_DMAC_ACLK>,
 				 <&cpg CPG_MOD R9A07G044_DMAC_PCLK>;
 			clock-names = "main", "register";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_DMAC_ARESETN>,
 				 <&cpg R9A07G044_DMAC_RST_ASYNC>;
 			reset-names = "arst", "rst_async";
@@ -964,7 +964,7 @@ gpu: gpu@11840000 {
 				 <&cpg CPG_MOD R9A07G044_GPU_AXI_CLK>,
 				 <&cpg CPG_MOD R9A07G044_GPU_ACE_CLK>;
 			clock-names = "gpu", "bus", "bus_ace";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G044_GPU_RESETN>,
 				 <&cpg R9A07G044_GPU_AXI_RESETN>,
 				 <&cpg R9A07G044_GPU_ACE_RESETN>;
@@ -994,7 +994,7 @@ sdhi0: mmc@11c00000 {
 				 <&cpg CPG_MOD R9A07G044_SDHI0_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A07G044_SDHI0_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1010,7 +1010,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A07G044_SDHI1_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A07G044_SDHI1_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1028,7 +1028,7 @@ eth0: ethernet@11c20000 {
 				 <&cpg CPG_CORE R9A07G044_CLK_HP>;
 			clock-names = "axi", "chi", "refclk";
 			resets = <&cpg R9A07G044_ETH0_RST_HW_N>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1048,7 +1048,7 @@ eth1: ethernet@11c30000 {
 				 <&cpg CPG_CORE R9A07G044_CLK_HP>;
 			clock-names = "axi", "chi", "refclk";
 			resets = <&cpg R9A07G044_ETH1_RST_HW_N>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1060,7 +1060,7 @@ phyrst: usbphy-ctrl@11c40000 {
 			reg = <0 0x11c40000 0 0x10000>;
 			clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>;
 			resets = <&cpg R9A07G044_USB_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			#reset-cells = <1>;
 			status = "disabled";
 		};
@@ -1075,7 +1075,7 @@ ohci0: usb@11c50000 {
 				 <&cpg R9A07G044_USB_U2H0_HRESETN>;
 			phys = <&usb2_phy0 1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1089,7 +1089,7 @@ ohci1: usb@11c70000 {
 				 <&cpg R9A07G044_USB_U2H1_HRESETN>;
 			phys = <&usb2_phy1 1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1104,7 +1104,7 @@ ehci0: usb@11c50100 {
 			phys = <&usb2_phy0 2>;
 			phy-names = "usb";
 			companion = <&ohci0>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1119,7 +1119,7 @@ ehci1: usb@11c70100 {
 			phys = <&usb2_phy1 2>;
 			phy-names = "usb";
 			companion = <&ohci1>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1132,7 +1132,7 @@ usb2_phy0: usb-phy@11c50200 {
 				 <&cpg CPG_MOD R9A07G044_USB_U2H0_HCLK>;
 			resets = <&phyrst 0>;
 			#phy-cells = <1>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1145,7 +1145,7 @@ usb2_phy1: usb-phy@11c70200 {
 				 <&cpg CPG_MOD R9A07G044_USB_U2H1_HCLK>;
 			resets = <&phyrst 1>;
 			#phy-cells = <1>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1164,7 +1164,7 @@ hsusb: usb@11c60000 {
 			renesas,buswait = <7>;
 			phys = <&usb2_phy0 3>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1179,7 +1179,7 @@ wdt0: watchdog@12800800 {
 				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "wdt", "perrout";
 			resets = <&cpg R9A07G044_WDT0_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1194,7 +1194,7 @@ wdt1: watchdog@12800c00 {
 				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "wdt", "perrout";
 			resets = <&cpg R9A07G044_WDT1_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1205,7 +1205,7 @@ ostm0: timer@12801000 {
 			interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&cpg CPG_MOD R9A07G044_OSTM0_PCLK>;
 			resets = <&cpg R9A07G044_OSTM0_PRESETZ>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1216,7 +1216,7 @@ ostm1: timer@12801400 {
 			interrupts = <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&cpg CPG_MOD R9A07G044_OSTM1_PCLK>;
 			resets = <&cpg R9A07G044_OSTM1_PRESETZ>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1227,7 +1227,7 @@ ostm2: timer@12801800 {
 			interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&cpg CPG_MOD R9A07G044_OSTM2_PCLK>;
 			resets = <&cpg R9A07G044_OSTM2_PRESETZ>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G044_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 	};
-- 
2.39.2


