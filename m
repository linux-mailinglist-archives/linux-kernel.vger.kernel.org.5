Return-Path: <linux-kernel+bounces-105498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83087DF41
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F280CB20C72
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E221D53C;
	Sun, 17 Mar 2024 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dS9zfvxl"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C71DFFD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700904; cv=none; b=hT1CtKgaBfMjSOw+7mxOJvhhnGqm2BDJpVhquNRsvt5NjHB2xrFuczYrgtGq56b9RvOqMcjB3K/gHCG+tMpGNLA1lTkHszrnawpCG8Zg1KoGJRBhbFlP/V26jkRJQ/MuWA+H0cPojcc305y/52KGECXrnlgIctXsFHpaVDtKX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700904; c=relaxed/simple;
	bh=v6WYm/saTl0QmEBYwVWfc36nTepZl7CnVki8v7LSdaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=libFW4DVlsCohJgijbjpjhLnv94y5x8l0iO1uAWOEJsw7VvRDwwlEb3QvV0xZ0Xp9wAsz+LHa2iR+3PwvuRnKQgYjCj/M9mzqmg8Kp+4zZpqvmHPOj9OAC9VEJtJQIo9+7yvjz2vh/inTudJESjcmZc3lhIJBm94Bm4W6mdvNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dS9zfvxl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso4188889a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710700900; x=1711305700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThEJWMmhXmURh5Sp7tdn++vnDz7PkK1r1QZd5VEjgVs=;
        b=dS9zfvxlrF/J81DvPJ217hlnACjfaXZ6IhYGGjaV8aSl0XiNc2vsggSthQ01Vejnpe
         t7N44c708P25jgx+AKbkXPTSLnG9o0qJecAFLhd7PRhUA+FtZwP1GpR5p3mR3mojGwv8
         dBId8QGy3pbGv3SBwvUAFBuRJoGYZ0Tqk3S+K0IGx3Vmk/ZYjKaM1KghSzigtpR65K9/
         MSIdzm8n+XLvqszv1QYBbU9oZdYf7pJDYfiFCdyEx/BiuxB66tIHsgur/Gzbc4bog7FC
         Y+7l2hwi4ubuCm3mv+ohl1Xqk25loTk1iueONkyzf1w7HLMlig4UAnJZQhqIQGil7PgF
         F8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700900; x=1711305700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThEJWMmhXmURh5Sp7tdn++vnDz7PkK1r1QZd5VEjgVs=;
        b=Bh7TnZDiHjEUbQ+G0hRSJef7QPWgRsLaQRVzP5Q4l90aaWvsLZDDUfW5t1eZLCR4J6
         nAYEAoxxwxXMemRUOReqxL71N9Iu0ZE5AbOq0u+4/BG3d3W96Peh/5z7/rEkvD/BI+pi
         60M+osnmonjOCkz2EqFq1vSt3OJKLBXFBFwRJDPwNBB4tAD33FGhAiQ6W1/4jrMDOLup
         ptLX9fmaKVGnR6v3LiUewoO+D0jNp6jkDolAcPUyBIftxTIVaUgRtGY3Aozejtgis8iX
         t5eioS2Ti1UTw8TuYAP/3FfFtJGXZ9PkmsUaujfkLYKDXjaidDwScqQt7Lf2pAysuoJ7
         AQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9QdmhrLbMEvu+tnuryVXhQOSmJnuGWORIuDzzSq/9tOX3NKzLr3RqUKmUFgkQr5AYqkDSu5LfIY2JxXM/qq2NNvJRtB7QnTxlCgYQ
X-Gm-Message-State: AOJu0YxKWH4PXuZz1FRWB6VyTMEkINJtJFkhUj3zIQQHklHm77mHtF+q
	6RzmZ+t87yTws6uCaNeouW78GV2cE14jZ098thfUPf5ryhyFe+YyTibkF7dEHMw=
X-Google-Smtp-Source: AGHT+IGDplvbzPmksXNzAH+rA3cv9vWNUQ9URHbvNEB3+ILFTzin9fQfu44KdVQo39DKA5u6UNhSig==
X-Received: by 2002:a05:6402:4348:b0:567:9fef:f7ee with SMTP id n8-20020a056402434800b005679feff7eemr6203008edc.16.1710700899597;
        Sun, 17 Mar 2024 11:41:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0056a2b87787dsm242877edq.37.2024.03.17.11.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:41:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Corentin Labbe <clabbe@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] arm: dts: allwinner: drop underscore in node names
Date: Sun, 17 Mar 2024 19:41:30 +0100
Message-Id: <20240317184130.157695-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
References: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Underscores should not be used in node names (dtc with W=2 warns about
them), so replace them with hyphens.  Use also generic name for pwrseq
node, because generic naming is favored by Devicetree spec.  All the
clocks affected by this change use clock-output-names, so resulting
clock name should not change.  Functional impact checked with comparing
before/after DTBs with dtx_diff and fdtdump.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware.
---
 arch/arm/boot/dts/allwinner/sun5i-a13.dtsi       |  4 ++--
 .../boot/dts/allwinner/sun5i-gr8-chip-pro.dts    |  2 +-
 arch/arm/boot/dts/allwinner/sun5i-r8-chip.dts    |  2 +-
 .../boot/dts/allwinner/sun6i-a31-hummingbird.dts |  4 ++--
 arch/arm/boot/dts/allwinner/sun6i-a31.dtsi       | 16 ++++++++--------
 .../dts/allwinner/sun6i-a31s-sinovoip-bpi-m2.dts |  2 +-
 .../dts/allwinner/sun7i-a20-bananapi-m1-plus.dts |  2 +-
 .../boot/dts/allwinner/sun7i-a20-cubietruck.dts  |  2 +-
 .../boot/dts/allwinner/sun7i-a20-hummingbird.dts |  4 ++--
 .../allwinner/sun7i-a20-olimex-som-evb-emmc.dts  |  2 +-
 .../sun7i-a20-olimex-som204-evb-emmc.dts         |  2 +-
 .../allwinner/sun7i-a20-olimex-som204-evb.dts    |  4 ++--
 .../dts/allwinner/sun7i-a20-olinuxino-lime2.dts  |  2 +-
 .../dts/allwinner/sun7i-a20-wits-pro-a20-dkt.dts |  2 +-
 arch/arm/boot/dts/allwinner/sun7i-a20.dtsi       |  4 ++--
 arch/arm/boot/dts/allwinner/sun8i-a23-a33.dtsi   | 14 +++++++-------
 .../sun8i-a23-polaroid-mid2407pxe03.dts          |  4 ++--
 .../sun8i-a23-polaroid-mid2809pxe04.dts          |  4 ++--
 .../boot/dts/allwinner/sun8i-a33-ga10h-v1.1.dts  |  2 +-
 .../dts/allwinner/sun8i-a33-inet-d978-rev2.dts   |  2 +-
 arch/arm/boot/dts/allwinner/sun8i-a33.dtsi       | 10 +++++-----
 .../dts/allwinner/sun8i-a83t-bananapi-m3.dts     |  2 +-
 .../dts/allwinner/sun8i-a83t-cubietruck-plus.dts |  2 +-
 .../boot/dts/allwinner/sun8i-a83t-tbs-a711.dts   |  2 +-
 arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi      |  8 ++++----
 .../allwinner/sun8i-h2-plus-bananapi-m2-zero.dts |  2 +-
 .../dts/allwinner/sun8i-h2-plus-orangepi-r1.dts  |  2 +-
 .../allwinner/sun8i-h2-plus-orangepi-zero.dts    |  6 +++---
 .../boot/dts/allwinner/sun8i-h3-beelink-x2.dts   |  4 ++--
 .../boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts  |  4 ++--
 .../dts/allwinner/sun8i-h3-nanopi-m1-plus.dts    |  4 ++--
 .../dts/allwinner/sun8i-h3-nanopi-neo-air.dts    |  2 +-
 .../boot/dts/allwinner/sun8i-h3-nanopi-r1.dts    |  2 +-
 .../boot/dts/allwinner/sun8i-h3-orangepi-2.dts   |  4 ++--
 .../dts/allwinner/sun8i-h3-orangepi-lite.dts     |  2 +-
 .../dts/allwinner/sun8i-h3-orangepi-pc-plus.dts  |  2 +-
 .../allwinner/sun8i-h3-orangepi-zero-plus2.dts   |  2 +-
 arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi |  4 ++--
 .../dts/allwinner/sun8i-r16-bananapi-m2m.dts     |  2 +-
 arch/arm/boot/dts/allwinner/sun8i-r16-parrot.dts |  2 +-
 .../allwinner/sun8i-r40-bananapi-m2-ultra.dts    |  2 +-
 .../boot/dts/allwinner/sun8i-r40-oka40i-c.dts    |  2 +-
 .../arm/boot/dts/allwinner/sun8i-s3-pinecube.dts |  2 +-
 arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi       |  4 ++--
 .../allwinner/sun8i-v40-bananapi-m2-berry.dts    |  2 +-
 arch/arm/boot/dts/allwinner/sun9i-a80.dtsi       |  4 ++--
 .../dts/allwinner/sunxi-bananapi-m2-plus.dtsi    |  2 +-
 .../dts/allwinner/sunxi-h3-h5-emlid-neutis.dtsi  |  2 +-
 arch/arm/boot/dts/allwinner/sunxi-h3-h5.dtsi     |  4 ++--
 49 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/arch/arm/boot/dts/allwinner/sun5i-a13.dtsi b/arch/arm/boot/dts/allwinner/sun5i-a13.dtsi
index 3325ab07094a..2c9152b151be 100644
--- a/arch/arm/boot/dts/allwinner/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun5i-a13.dtsi
@@ -62,14 +62,14 @@ map0 {
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <100000>;
 					hysteresis = <2000>;
diff --git a/arch/arm/boot/dts/allwinner/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/allwinner/sun5i-gr8-chip-pro.dts
index 5c3562b85a5b..ffbd99c176db 100644
--- a/arch/arm/boot/dts/allwinner/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/allwinner/sun5i-gr8-chip-pro.dts
@@ -77,7 +77,7 @@ led-0 {
 		};
 	};
 
-	mmc0_pwrseq: mmc0_pwrseq {
+	mmc0_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; /* PB10 */
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun5i-r8-chip.dts b/arch/arm/boot/dts/allwinner/sun5i-r8-chip.dts
index 4192c23848c3..8c784a2c086e 100644
--- a/arch/arm/boot/dts/allwinner/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/allwinner/sun5i-r8-chip.dts
@@ -77,7 +77,7 @@ led-0 {
 		};
 	};
 
-	mmc0_pwrseq: mmc0_pwrseq {
+	mmc0_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 2 19 GPIO_ACTIVE_LOW>; /* PC19 */
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/allwinner/sun6i-a31-hummingbird.dts
index 236ebfc06192..5bce7a32651e 100644
--- a/arch/arm/boot/dts/allwinner/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/allwinner/sun6i-a31-hummingbird.dts
@@ -109,7 +109,7 @@ vga_dac_out: endpoint {
 		};
 	};
 
-	reg_vga_3v3: vga_3v3_regulator {
+	reg_vga_3v3: vga-3v3-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vga-3v3";
 		regulator-min-microvolt = <3300000>;
@@ -119,7 +119,7 @@ reg_vga_3v3: vga_3v3_regulator {
 		gpio = <&pio 7 25 GPIO_ACTIVE_HIGH>; /* PH25 */
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun6i-a31.dtsi b/arch/arm/boot/dts/allwinner/sun6i-a31.dtsi
index 5cce4918f84c..f0145d6b9c53 100644
--- a/arch/arm/boot/dts/allwinner/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun6i-a31.dtsi
@@ -179,14 +179,14 @@ map0 {
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <70000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1318,7 +1318,7 @@ prcm@1f01400 {
 			compatible = "allwinner,sun6i-a31-prcm";
 			reg = <0x01f01400 0x200>;
 
-			ar100: ar100_clk {
+			ar100: ar100-clk {
 				compatible = "allwinner,sun6i-a31-ar100-clk";
 				#clock-cells = <0>;
 				clocks = <&rtc CLK_OSC32K>, <&osc24M>,
@@ -1327,7 +1327,7 @@ ar100: ar100_clk {
 				clock-output-names = "ar100";
 			};
 
-			ahb0: ahb0_clk {
+			ahb0: ahb0-clk {
 				compatible = "fixed-factor-clock";
 				#clock-cells = <0>;
 				clock-div = <1>;
@@ -1336,14 +1336,14 @@ ahb0: ahb0_clk {
 				clock-output-names = "ahb0";
 			};
 
-			apb0: apb0_clk {
+			apb0: apb0-clk {
 				compatible = "allwinner,sun6i-a31-apb0-clk";
 				#clock-cells = <0>;
 				clocks = <&ahb0>;
 				clock-output-names = "apb0";
 			};
 
-			apb0_gates: apb0_gates_clk {
+			apb0_gates: apb0-gates-clk {
 				compatible = "allwinner,sun6i-a31-apb0-gates-clk";
 				#clock-cells = <1>;
 				clocks = <&apb0>;
@@ -1353,14 +1353,14 @@ apb0_gates: apb0_gates_clk {
 						"apb0_i2c";
 			};
 
-			ir_clk: ir_clk {
+			ir_clk: ir-clk {
 				#clock-cells = <0>;
 				compatible = "allwinner,sun4i-a10-mod0-clk";
 				clocks = <&rtc CLK_OSC32K>, <&osc24M>;
 				clock-output-names = "ir";
 			};
 
-			apb0_rst: apb0_rst {
+			apb0_rst: apb0-rst {
 				compatible = "allwinner,sun6i-a31-clock-reset";
 				#reset-cells = <1>;
 			};
diff --git a/arch/arm/boot/dts/allwinner/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/allwinner/sun6i-a31s-sinovoip-bpi-m2.dts
index 96554ab4f6d3..f63d67ec9887 100644
--- a/arch/arm/boot/dts/allwinner/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/allwinner/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -75,7 +75,7 @@ led-2 {
 		};
 	};
 
-	mmc2_pwrseq: mmc2_pwrseq {
+	mmc2_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 WIFI_EN */
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi-m1-plus.dts
index caa935ca4f19..f2d7fab9978d 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi-m1-plus.dts
@@ -86,7 +86,7 @@ led-1 {
 		};
 	};
 
-	mmc3_pwrseq: mmc3_pwrseq {
+	mmc3_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 WL-PMU-EN */
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-cubietruck.dts
index 52160e368304..be9b31d0f4b5 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-cubietruck.dts
@@ -96,7 +96,7 @@ led-3 {
 		};
 	};
 
-	mmc3_pwrseq: mmc3_pwrseq {
+	mmc3_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
 		clocks = <&ccu CLK_OUT_A>;
diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-hummingbird.dts
index 3def2a330598..f1e26b75cd90 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-hummingbird.dts
@@ -65,7 +65,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	reg_mmc3_vdd: mmc3_vdd {
+	reg_mmc3_vdd: regulator-mmc3-vdd {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc3_vdd";
 		regulator-min-microvolt = <3000000>;
@@ -74,7 +74,7 @@ reg_mmc3_vdd: mmc3_vdd {
 		gpio = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	};
 
-	reg_gmac_vdd: gmac_vdd {
+	reg_gmac_vdd: regulator-gmac-vdd {
 		compatible = "regulator-fixed";
 		regulator-name = "gmac_vdd";
 		regulator-min-microvolt = <3000000>;
diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som-evb-emmc.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som-evb-emmc.dts
index 20bf09b2226c..fb835730bbc4 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som-evb-emmc.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som-evb-emmc.dts
@@ -14,7 +14,7 @@ / {
 	model = "Olimex A20-Olimex-SOM-EVB-eMMC";
 	compatible = "olimex,a20-olimex-som-evb-emmc", "allwinner,sun7i-a20";
 
-	mmc2_pwrseq: mmc2_pwrseq {
+	mmc2_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&pio 2 18 GPIO_ACTIVE_LOW>;
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb-emmc.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb-emmc.dts
index a59755a2e7a9..e8977c2fe798 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb-emmc.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb-emmc.dts
@@ -13,7 +13,7 @@ / {
 	model = "Olimex A20-SOM204-EVB-eMMC";
 	compatible = "olimex,a20-olimex-som204-evb-emmc", "allwinner,sun7i-a20";
 
-	mmc2_pwrseq: mmc2_pwrseq {
+	mmc2_pwrseq: pwrseq-1 {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&pio 2 16 GPIO_ACTIVE_LOW>;
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb.dts
index 54af6c18075b..a55406657449 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb.dts
@@ -65,7 +65,7 @@ led-2 {
 		};
 	};
 
-	rtl_pwrseq: rtl_pwrseq {
+	rtl_pwrseq: pwrseq-0 {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 9 GPIO_ACTIVE_LOW>;
 	};
@@ -177,7 +177,7 @@ &mmc3 {
 	non-removable;
 	status = "okay";
 
-	rtl8723bs: sdio_wifi@1 {
+	rtl8723bs: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime2.dts
index ecb91fb899ff..435a189332e8 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime2.dts
@@ -82,7 +82,7 @@ led {
 		};
 	};
 
-	reg_axp_ipsout: axp_ipsout {
+	reg_axp_ipsout: regulator-axp-ipsout {
 		compatible = "regulator-fixed";
 		regulator-name = "axp-ipsout";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-wits-pro-a20-dkt.dts
index 3bfae98f3cc3..29199b6a3b4a 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-wits-pro-a20-dkt.dts
@@ -60,7 +60,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	mmc3_pwrseq: mmc3_pwrseq {
+	mmc3_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20.dtsi b/arch/arm/boot/dts/allwinner/sun7i-a20.dtsi
index 5574299685ab..5f44f09c5545 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20.dtsi
@@ -153,14 +153,14 @@ map0 {
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <100000>;
 					hysteresis = <2000>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/allwinner/sun8i-a23-a33.dtsi
index cd4bf60dbb3c..2af8382ccdf5 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-a23-a33.dtsi
@@ -108,7 +108,7 @@ clocks {
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: osc24M_clk {
+		osc24M: osc24M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -116,7 +116,7 @@ osc24M: osc24M_clk {
 			clock-output-names = "osc24M";
 		};
 
-		ext_osc32k: ext_osc32k_clk {
+		ext_osc32k: ext-osc32k-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
@@ -733,7 +733,7 @@ prcm@1f01400 {
 			compatible = "allwinner,sun8i-a23-prcm";
 			reg = <0x01f01400 0x200>;
 
-			ar100: ar100_clk {
+			ar100: ar100-clk {
 				compatible = "fixed-factor-clock";
 				#clock-cells = <0>;
 				clock-div = <1>;
@@ -742,7 +742,7 @@ ar100: ar100_clk {
 				clock-output-names = "ar100";
 			};
 
-			ahb0: ahb0_clk {
+			ahb0: ahb0-clk {
 				compatible = "fixed-factor-clock";
 				#clock-cells = <0>;
 				clock-div = <1>;
@@ -751,14 +751,14 @@ ahb0: ahb0_clk {
 				clock-output-names = "ahb0";
 			};
 
-			apb0: apb0_clk {
+			apb0: apb0-clk {
 				compatible = "allwinner,sun8i-a23-apb0-clk";
 				#clock-cells = <0>;
 				clocks = <&ahb0>;
 				clock-output-names = "apb0";
 			};
 
-			apb0_gates: apb0_gates_clk {
+			apb0_gates: apb0-gates-clk {
 				compatible = "allwinner,sun8i-a23-apb0-gates-clk";
 				#clock-cells = <1>;
 				clocks = <&apb0>;
@@ -767,7 +767,7 @@ apb0_gates: apb0_gates_clk {
 						"apb0_i2c";
 			};
 
-			apb0_rst: apb0_rst {
+			apb0_rst: apb0-rst {
 				compatible = "allwinner,sun6i-a31-clock-reset";
 				#reset-cells = <1>;
 			};
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2407pxe03.dts
index d5f6aebd7216..0c585a6d990d 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2407pxe03.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2407pxe03.dts
@@ -52,7 +52,7 @@ aliases {
 		ethernet0 = &esp8089;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
 		/* The esp8089 needs 200 ms after driving wifi-en high */
@@ -76,7 +76,7 @@ &mmc1 {
 	non-removable;
 	status = "okay";
 
-	esp8089: sdio_wifi@1 {
+	esp8089: wifi@1 {
 		compatible = "esp,esp8089";
 		reg = <1>;
 		esp,crystal-26M-en = <2>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2809pxe04.dts
index 9f9232a2fefb..63cb4e194a03 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2809pxe04.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2809pxe04.dts
@@ -52,7 +52,7 @@ aliases {
 		ethernet0 = &esp8089;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
 		/* The esp8089 needs 200 ms after driving wifi-en high */
@@ -69,7 +69,7 @@ &mmc1 {
 	non-removable;
 	status = "okay";
 
-	esp8089: sdio_wifi@1 {
+	esp8089: wifi@1 {
 		compatible = "esp,esp8089";
 		reg = <1>;
 		esp,crystal-26M-en = <2>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-ga10h-v1.1.dts
index 2dfdd0a3151e..f00ce03ffc84 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-a33-ga10h-v1.1.dts
@@ -85,7 +85,7 @@ &mmc1 {
 	non-removable;
 	status = "okay";
 
-	rtl8703as: sdio_wifi@1 {
+	rtl8703as: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-inet-d978-rev2.dts
index 065cb620aa99..162ba93f7484 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a33-inet-d978-rev2.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-a33-inet-d978-rev2.dts
@@ -78,7 +78,7 @@ &mmc1 {
 	non-removable;
 	status = "okay";
 
-	rtl8723bs: sdio_wifi@1 {
+	rtl8723bs: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a33.dtsi b/arch/arm/boot/dts/allwinner/sun8i-a33.dtsi
index 30fdd2703b1f..36b2d78cdab9 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-a33.dtsi
@@ -323,35 +323,35 @@ map3 {
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				gpu_alert0: gpu_alert0 {
+				gpu_alert0: gpu-alert0 {
 					/* milliCelsius */
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_alert1: cpu_alert1 {
+				cpu_alert1: cpu-alert1 {
 					/* milliCelsius */
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
 				};
 
-				gpu_alert1: gpu_alert1 {
+				gpu_alert1: gpu-alert1 {
 					/* milliCelsius */
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "hot";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <110000>;
 					hysteresis = <2000>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3.dts
index 8d56b103f063..32e811fa23e2 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3.dts
@@ -95,7 +95,7 @@ reg_usb1_vbus: reg-usb1-vbus {
 		gpio = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
 		clock-names = "ext_clock";
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/allwinner/sun8i-a83t-cubietruck-plus.dts
index 870993393fc2..d5e6ddaffbce 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-a83t-cubietruck-plus.dts
@@ -144,7 +144,7 @@ spdif_out: spdif-out {
 		compatible = "linux,spdif-dit";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
 		clock-names = "ext_clock";
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/allwinner/sun8i-a83t-tbs-a711.dts
index a7d4ca308990..43982b106a4d 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-a83t-tbs-a711.dts
@@ -123,7 +123,7 @@ reg_vmain: reg-vmain {
 		vin-supply = <&reg_vbat>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 WL-PMU-EN */
 
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi b/arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi
index 94eb3bfc989e..addf0cb0f465 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi
@@ -164,7 +164,7 @@ clocks {
 		ranges;
 
 		/* TODO: PRCM block has a mux for this. */
-		osc24M: osc24M_clk {
+		osc24M: osc24M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -177,14 +177,14 @@ osc24M: osc24M_clk {
 		 * It is an internal RC-based oscillator.
 		 * TODO: Its controls are in the PRCM block.
 		 */
-		osc16M: osc16M_clk {
+		osc16M: osc16M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <16000000>;
 			clock-output-names = "osc16M";
 		};
 
-		osc16Md512: osc16Md512_clk {
+		osc16Md512: osc16Md512-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <512>;
@@ -1127,7 +1127,7 @@ r_ccu: clock@1f01400 {
 			#reset-cells = <1>;
 		};
 
-		r_cpucfg@1f01c00 {
+		cpucfg@1f01c00 {
 			compatible = "allwinner,sun8i-a83t-r-cpucfg";
 			reg = <0x1f01c00 0x400>;
 		};
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-bananapi-m2-zero.dts
index d729b7c705db..d3a7c9fa23e4 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -103,7 +103,7 @@ poweroff {
 		cpu-supply = <&reg_vcc1v2>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts
index 067a2ecbc0a4..79b03b31c5eb 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts
@@ -90,7 +90,7 @@ &mmc1 {
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 
-	rtl8189etv: sdio_wifi@1 {
+	rtl8189etv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
index 3706216ffb40..1b001f2ad0ef 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
@@ -80,7 +80,7 @@ status_led {
 		};
 	};
 
-	reg_vcc_wifi: reg_vcc_wifi {
+	reg_vcc_wifi: reg-vcc-wifi {
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -105,7 +105,7 @@ reg_vdd_cpux: vdd-cpux-regulator {
 		states = <1100000 0>, <1300000 1>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>;
 		post-power-on-delay-ms = <200>;
@@ -149,7 +149,7 @@ &mmc1 {
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	xr819: sdio_wifi@1 {
+	xr819: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-beelink-x2.dts
index a6d38ecee141..5b77300307de 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-beelink-x2.dts
@@ -122,7 +122,7 @@ spdif_out: spdif-out {
 		compatible = "linux,spdif-dit";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
@@ -185,7 +185,7 @@ &mmc1 {
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	sdiowifi: sdio_wifi@1 {
+	sdiowifi: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts
index 343b02b97155..2b0566d4b386 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts
@@ -87,7 +87,7 @@ reg_vdd_sys: vdd-sys {
 		vin-supply = <&reg_vcc5v0>;
         };
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
@@ -119,7 +119,7 @@ &mmc1 {
 	non-removable;
 	status = "okay";
 
-	sdio_wifi: sdio_wifi@1 {
+	sdio_wifi: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-m1-plus.dts
index 4ba533b0340f..59bd0746acf8 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-m1-plus.dts
@@ -62,7 +62,7 @@ reg_gmac_3v3: gmac-3v3 {
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
@@ -132,7 +132,7 @@ &mmc1 {
 	non-removable;
 	status = "okay";
 
-	sdio_wifi: sdio_wifi@1 {
+	sdio_wifi: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-neo-air.dts
index 9e1a33f94cad..6d85370e04f1 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-neo-air.dts
@@ -73,7 +73,7 @@ led-1 {
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-r1.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-r1.dts
index 42cd1131adf3..870649760f70 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-r1.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-r1.dts
@@ -43,7 +43,7 @@ reg_vdd_cpux: gpio-regulator {
 			 <1300000 0x1>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-2.dts
index f1f9dbead32a..d2ae47b074bf 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-2.dts
@@ -105,7 +105,7 @@ switch-4 {
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 WIFI_EN */
 	};
@@ -169,7 +169,7 @@ &mmc1 {
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	rtl8189: sdio_wifi@1 {
+	rtl8189: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-lite.dts
index 305b34a321f5..6a4316a52469 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-lite.dts
@@ -143,7 +143,7 @@ &mmc1 {
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	rtl8189ftv: sdio_wifi@1 {
+	rtl8189ftv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-pc-plus.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-pc-plus.dts
index babf4cf1b2f6..8a49b3376dfc 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-pc-plus.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-pc-plus.dts
@@ -63,7 +63,7 @@ &mmc1 {
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	rtl8189ftv: sdio_wifi@1 {
+	rtl8189ftv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
index 561ea1d2f861..7a6444a10e25 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
@@ -92,7 +92,7 @@ reg_vcc3v3: vcc3v3 {
 		regulator-max-microvolt = <3300000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi b/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
index 3d9a1524e17e..272584881bb2 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
@@ -62,7 +62,7 @@ panel_input: endpoint {
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		/*
 		 * Q8 boards use various PL# pins as wifi-en. On other boards
@@ -94,7 +94,7 @@ &mmc1 {
 	non-removable;
 	status = "okay";
 
-	sdio_wifi: sdio_wifi@1 {
+	sdio_wifi: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/allwinner/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/allwinner/sun8i-r16-bananapi-m2m.dts
index bc394686fedb..f4bf46b35bec 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-r16-bananapi-m2m.dts
@@ -88,7 +88,7 @@ reg_vcc5v0: vcc5v0 {
 		regulator-max-microvolt = <5000000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL06 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-r16-parrot.dts b/arch/arm/boot/dts/allwinner/sun8i-r16-parrot.dts
index 95543a9c2118..75067522ff59 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-r16-parrot.dts
@@ -75,7 +75,7 @@ led-2 {
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL06 */
 	};
diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
index 28197bbcb1d5..cd2351acc32f 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
@@ -100,7 +100,7 @@ reg_vcc5v0: vcc5v0 {
 		enable-active-high;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
 		clocks = <&ccu CLK_OUTA>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-oka40i-c.dts b/arch/arm/boot/dts/allwinner/sun8i-r40-oka40i-c.dts
index 0bd1336206b8..15b0b4de626a 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-r40-oka40i-c.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-r40-oka40i-c.dts
@@ -62,7 +62,7 @@ reg_vcc5v0: vcc5v0 {
 		regulator-max-microvolt = <5000000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; // PB10 WIFI_EN
 		clocks = <&ccu CLK_OUTA>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-s3-pinecube.dts b/arch/arm/boot/dts/allwinner/sun8i-s3-pinecube.dts
index 20966e954eda..e0d4404b5957 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-s3-pinecube.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-s3-pinecube.dts
@@ -51,7 +51,7 @@ reg_vcc_wifi: vcc-wifi {
 		startup-delay-us = <200000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 WIFI-RST */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi b/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
index e8a04476b776..9e13c2aa8911 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
@@ -98,7 +98,7 @@ clocks {
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: osc24M_clk {
+		osc24M: osc24M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -106,7 +106,7 @@ osc24M: osc24M_clk {
 			clock-output-names = "osc24M";
 		};
 
-		osc32k: osc32k_clk {
+		osc32k: osc32k-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
diff --git a/arch/arm/boot/dts/allwinner/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/allwinner/sun8i-v40-bananapi-m2-berry.dts
index 434871040aca..6575ef274453 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-v40-bananapi-m2-berry.dts
@@ -94,7 +94,7 @@ reg_vcc5v0: vcc5v0 {
 		enable-active-high;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
 		clocks = <&ccu CLK_OUTA>;
diff --git a/arch/arm/boot/dts/allwinner/sun9i-a80.dtsi b/arch/arm/boot/dts/allwinner/sun9i-a80.dtsi
index 7d3f3300f431..a1ae0929cec9 100644
--- a/arch/arm/boot/dts/allwinner/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun9i-a80.dtsi
@@ -196,14 +196,14 @@ osc32k: clk-32k {
 		 * The actual TX clock rate is not controlled by the
 		 * gmac_tx clock.
 		 */
-		mii_phy_tx_clk: mii_phy_tx_clk {
+		mii_phy_tx_clk: mii-phy-tx-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <25000000>;
 			clock-output-names = "mii_phy_tx";
 		};
 
-		gmac_int_tx_clk: gmac_int_tx_clk {
+		gmac_int_tx_clk: gmac-int-tx-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <125000000>;
diff --git a/arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus.dtsi
index 1d1d127cf38f..873817ddb4ea 100644
--- a/arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus.dtsi
@@ -98,7 +98,7 @@ reg_gmac_3v3: gmac-3v3 {
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/boot/dts/allwinner/sunxi-h3-h5-emlid-neutis.dtsi b/arch/arm/boot/dts/allwinner/sunxi-h3-h5-emlid-neutis.dtsi
index 60804b0e6c56..be5f5528a118 100644
--- a/arch/arm/boot/dts/allwinner/sunxi-h3-h5-emlid-neutis.dtsi
+++ b/arch/arm/boot/dts/allwinner/sunxi-h3-h5-emlid-neutis.dtsi
@@ -18,7 +18,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 2 7 GPIO_ACTIVE_LOW>; /* PC7 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/boot/dts/allwinner/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/allwinner/sunxi-h3-h5.dtsi
index ade1cd50e445..7df60515a903 100644
--- a/arch/arm/boot/dts/allwinner/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/allwinner/sunxi-h3-h5.dtsi
@@ -83,7 +83,7 @@ clocks {
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: osc24M_clk {
+		osc24M: osc24M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -91,7 +91,7 @@ osc24M: osc24M_clk {
 			clock-output-names = "osc24M";
 		};
 
-		osc32k: osc32k_clk {
+		osc32k: osc32k-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
-- 
2.34.1


