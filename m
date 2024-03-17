Return-Path: <linux-kernel+bounces-105497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F071C87DF3F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5451F20CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74661EB56;
	Sun, 17 Mar 2024 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DabB5GUz"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B581CF9A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700901; cv=none; b=cz2zz5SwAxKgWbFTReyBqhs0FYNdzMamb3TNT7VZFBbMySRCu04jROdTHf6S+Z79+IgQd0j8kdLwyfEsmGb1SuP7UNZ6MP4rSlQxpEoJA/6UByyMYvpqMixBhHYBTFfruVrRdFWAQMVolRnKHNyiBX8K3gAEZvp60Ba2CexEU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700901; c=relaxed/simple;
	bh=uijCbkb+1dpR+4weqt/k5FYLsh4Fu/4uVmg9GFfQR6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/yPjGYVN3oKmcreDi1tioxNmuSomXwvm1bwmcHzpZICxS1v3BO/6VBSkA0FQVoxYKryNy3lNmnuR3s858ZxKbWZ1absRQ3NUUztpJLu8huNHswT392TLvZ8J7qLFk9gIRyw+Hgfpjp4pLhqLAA5L61UytuSEx4Axp1jXnHxvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DabB5GUz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso59532481fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710700896; x=1711305696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kSx2fHGqVJ6vhRhHxI+7NFVscGTaFtDJuqcfzw/hSI=;
        b=DabB5GUzIUfsM2hjyVQNa2Y+ru8zEVELKlzoM8DD1zQhlolOb4m51G4uQZNP/vUcv4
         k+kRscPwkHbsjQw2a+FXhAhUXRpzW32PMfRMmPe6d6esSGBJu7CclihNihHHeiozRyXr
         FmZy3zDc5mCn6hsWdruMab4cJtqItutlfZNQd8royB2kfFx66KdgUMNb2pm9ASNpfc61
         VpPeo8dcqVcxW113NB3Z/o3ITI2Xq1kBYpPdCYifMgenMMtMxjoW1rpXs/pCWMZAcNug
         BBExqrdouvTOhCjmRq8IRElqwT3La+DpejtAcheB+whD12M7ZVv3ujAJdCUmTMGTnSRU
         KhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700896; x=1711305696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kSx2fHGqVJ6vhRhHxI+7NFVscGTaFtDJuqcfzw/hSI=;
        b=U5AR4gwnrddSmWoIIJ6hNLW3vexTARTIZU3DgzmT5ICbad8t5Q5mHRzl/Xf/xEddeG
         PI3MjvduBsD6h+PbCFAJ5osQeWsjvQwwCIkCgGr63E6qOfpciKG7Pt5i7kkpTDjqXniZ
         hFPEvP1FU8Qj3Cz2XH/vgVvfvvt94OLXTIVG9tzH6XK5+uH6zWH4Ez/dgUOEOnPrtrWS
         UjgJ2Ct3hSf9w8B8RphBh8pStFO/rlRmpYLIeE9ZFZ7pZ3uABrhg28FC1ROPwW1DjRtO
         d+FfGeS+846+cTFaCPmGOlYsv5KeiUXY9c+0HegKVsEbFEJc+Ra7KVnZneb/5p/kuqo+
         ifjA==
X-Forwarded-Encrypted: i=1; AJvYcCV5vWWFk+FRIYiJ9e8SKUZ9wDtI+RNJKVGqmqXKxkexebKwNkisNx17SHdn9PQp9WIPz4uB6E10t4iZUO+5SgXjBE35frG0k/f/HRBr
X-Gm-Message-State: AOJu0YyL9qpbLWuEvo3RTq6uOHnVSXxjfblPS5R0aB1AJwOIcAVPFZqg
	mPqqq66PLPh539Ax+xHbb03ZK0aEoVjPJuRy2F5EUi08dXzHgc21Ddebxzgh3js=
X-Google-Smtp-Source: AGHT+IFNqPSvWdiZKpHQc7+rdmpKPim0F4Hsstpr6ypdLBl37cIBwdLxcGTew4kPk14C8fsOi6sEuw==
X-Received: by 2002:a2e:8913:0:b0:2d2:f394:fc19 with SMTP id d19-20020a2e8913000000b002d2f394fc19mr5631126lji.27.1710700896055;
        Sun, 17 Mar 2024 11:41:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0056a2b87787dsm242877edq.37.2024.03.17.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:41:35 -0700 (PDT)
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
Subject: [PATCH 2/4] arm64: dts: allwinner: drop underscore in node names
Date: Sun, 17 Mar 2024 19:41:28 +0100
Message-Id: <20240317184130.157695-2-krzysztof.kozlowski@linaro.org>
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
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     |  2 +-
 .../arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts |  2 +-
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts     |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts  |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts   |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts   |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi          | 10 +++++-----
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts  |  2 +-
 .../boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts     |  4 ++--
 .../boot/dts/allwinner/sun50i-h5-orangepi-prime.dts    |  2 +-
 .../dts/allwinner/sun50i-h5-orangepi-zero-plus.dts     |  2 +-
 .../dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts    |  2 +-
 .../arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts |  2 +-
 .../boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts    |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi  |  2 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts  |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts   |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi           |  2 +-
 .../dts/allwinner/sun50i-h618-transpeed-8k618-t.dts    |  2 +-
 .../boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts    |  2 +-
 22 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index e6d5bc0f7a61..d1f415acd7b5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -53,7 +53,7 @@ led-2 {
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 0af6dcdf7515..dec9960a7440 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -41,7 +41,7 @@ led {
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index bfb806cf6d7a..fd3794678c33 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -52,7 +52,7 @@ reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 4f8529d5ac00..c8303a66438d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -68,7 +68,7 @@ reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 50ed2e9f10ed..6c65d5bc16ba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -79,7 +79,7 @@ reg_vcc5v0: vcc5v0 {
 		enable-active-high;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index 0a5607f73049..c6007df99938 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -98,7 +98,7 @@ vdd_bl: regulator {
 		enable-active-high;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 1128030e4c25..b407e1dd08a7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -74,7 +74,7 @@ reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 57ac18738c99..7b01f68cf7f0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -120,14 +120,14 @@ opp-432000000 {
 		};
 	};
 
-	osc24M: osc24M_clk {
+	osc24M: osc24M-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
 		clock-output-names = "osc24M";
 	};
 
-	osc32k: osc32k_clk {
+	osc32k: osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
@@ -216,21 +216,21 @@ map1 {
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <75000>;
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
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <110000>;
 					hysteresis = <2000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 4c3921ac236c..b69032c44557 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -68,7 +68,7 @@ vdd_cpux: gpio-regulator {
 		states = <1100000 0>, <1300000 1>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
index a3e040da38a0..3a7ee44708a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
@@ -103,7 +103,7 @@ vdd_cpux: gpio-regulator {
 		states = <1100000 0x0>, <1300000 0x1>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		post-power-on-delay-ms = <200>;
@@ -170,7 +170,7 @@ &mmc1 {
 	non-removable;
 	status = "okay";
 
-	rtl8189etv: sdio_wifi@1 {
+	rtl8189etv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index d7f8bad6bb98..b699bb900e13 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -85,7 +85,7 @@ reg_usb0_vbus: usb0-vbus {
 		status = "okay";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 2 14 GPIO_ACTIVE_LOW>; /* PC14 */
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
index 7ec5ac850a0d..ae85131aac9c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -97,7 +97,7 @@ &mmc1 {
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	rtl8189ftv: sdio_wifi@1 {
+	rtl8189ftv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index 22530ace12d5..734481e998b8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -52,7 +52,7 @@ reg_vcc3v3: vcc3v3 {
 		regulator-max-microvolt = <3300000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 381d58cea092..3be1e8c2fdb9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -34,7 +34,7 @@ hdmi_con_in: endpoint {
 		};
 	};
 
-	ext_osc32k: ext_osc32k_clk {
+	ext_osc32k: ext-osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 6fc65e8db220..6c3bfe3d09d9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -33,7 +33,7 @@ hdmi_con_in: endpoint {
 		};
 	};
 
-	ext_osc32k: ext_osc32k_clk {
+	ext_osc32k: ext-osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
index fb31dcb1cb6d..a3f65a45bd26 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -11,7 +11,7 @@ aliases {
 		serial1 = &uart1; /* BT-UART */
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 92745128fcfe..13b07141c334 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -32,7 +32,7 @@ hdmi_con_in: endpoint {
 		};
 	};
 
-	ext_osc32k: ext_osc32k_clk {
+	ext_osc32k: ext-osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
index 1b6e5595ac6e..66fe03910d5e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -11,7 +11,7 @@ / {
 	model = "Pine H64 model B";
 	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 1ffd68f43f87..3910393be1f9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -22,7 +22,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	ext_osc32k: ext_osc32k_clk {
+	ext_osc32k: ext-osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d11e5041bae9..8a8591c4e7dd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -68,7 +68,7 @@ de: display-engine {
 		status = "disabled";
 	};
 
-	osc24M: osc24M_clk {
+	osc24M: osc24M-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
index ac0a2b7ea6f3..a1d0cac4d244 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
@@ -41,7 +41,7 @@ reg_vcc3v3: vcc3v3 {
 		regulator-always-on;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
index b6e3c169797f..c204dd43c726 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
@@ -42,7 +42,7 @@ reg_vcc5v: regulator-5v {
 		regulator-always-on;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 		post-power-on-delay-ms = <200>;
-- 
2.34.1


