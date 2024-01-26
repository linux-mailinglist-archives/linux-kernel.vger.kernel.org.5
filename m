Return-Path: <linux-kernel+bounces-39776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2734A83D5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927CD1F282E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F21272B3;
	Fri, 26 Jan 2024 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/petMEu"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851386AF6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258313; cv=none; b=YcJFnKd8VIx5Zcmus5cJHGhOGY4ssPtKoWCJLO52YW5MNJkrpVEEte7BUvBZ+s76Peo8h1jHeMhV4ibN2Gnlg31iHIA81sgmY+sbbwcefmtth1fwJFKGna03V5U/L51Z3E/5rd90Z07X3IUZnwR6aT6WB797peU+HDaSzs7zK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258313; c=relaxed/simple;
	bh=+LI4oWtLvOiHKm5X+vVlEVLFQ7obEdMM5jk9PQUM6Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZN9+ugOcXSO7ossqsp3kqQNKnfn5UQS2JldH4aAoDMaeXWbarVIiz8jElIBWmaMGLrpkPH2WfXNu6UThzgJdqavImCRNAsZWGs60VBOhJNGh4Cx6UW77C0UT8Zs68r8PhwXadb1mauxVkiNQyLDP/aODmfpcok090xwGUCLX3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W/petMEu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d89518d3b1so813025ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706258311; x=1706863111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXeMA3hDvC0XEKkFussXEcVEMZGiF+zljJ9aY5S+G7U=;
        b=W/petMEug5ro3WuQLyN3e1wIkviQTDFX6O0u2pFX8cz+Q95XNNgAwxlu958fCQdZql
         3XLLemzqj/XmwqnUzmVXoa84tpMaVG2Hzxwv6PcNjiIy1WLWBQGqNp7GufC+hSr5syOD
         ZPOfZROtNzh9qWpTrwWSI7Fe53QFEebuYoseI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258311; x=1706863111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXeMA3hDvC0XEKkFussXEcVEMZGiF+zljJ9aY5S+G7U=;
        b=YsbeeMg/QgaXL3ZNii0OFGtf9B1mcsihrqO0adQC4UPVNZti5nD3SsX0OIQD/LQjsG
         RE5JZycPUy/iBud37zve8lEAH3xvdVKce55+WF83piDV4Yduk2UCDMw7xKRKGsraiAZU
         gVtdiDiP+/apTscS14zq4kr4spUTCy/DJIBfJ5ZNY5yx+O2zsbPsdI1wA78JeZ8gCxte
         h3Lsi3txXTJMGgCH/E+YAOnrazIGZYPR2AK179sQwPTJnTmFEv6Eqoc4CVvFz9n29AVH
         NnOSGBDh0qfggpvdQYKZ6od656IlFEAEmlAO+mUFJnafWF8LyhFBmLq7ciLrOP4DZkjg
         eisA==
X-Gm-Message-State: AOJu0YznpVAmXXmcLBKOd/YYUUDjpXnmiTsFdkaCmRQ54yXGfluYx+Dn
	jllD0AcuCi96OzJXTIheKaT8ev1yOSvsxbQxDT4iXWP7ah0SQuRkyozW6KKDNg==
X-Google-Smtp-Source: AGHT+IEOmryHv1msIweq9XgtpB8zXh7lAAeRGj/w5zh4kGdRXYlX9/mEhFJaQHGaxuR7qnce8Z0bUw==
X-Received: by 2002:a17:902:8206:b0:1d7:7277:8adf with SMTP id x6-20020a170902820600b001d772778adfmr756136pln.22.1706258311130;
        Fri, 26 Jan 2024 00:38:31 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b001d6ff1795aesm589529plr.8.2024.01.26.00.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:38:30 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 7/9] arm64: dts: mediatek: Introduce MT8186 Steelix
Date: Fri, 26 Jan 2024 16:37:56 +0800
Message-ID: <20240126083802.2728610-8-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126083802.2728610-1-wenst@chromium.org>
References: <20240126083802.2728610-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8186 Steelix, also known as the Lenovo 300e Yoga Chromebook Gen 4,
is a convertible device based on a common design of the same name. The
device comes in different variants. Of them, whether a world facing
camera is integrated is the only differentiating factor between the
two device trees added. The different SKU IDs describe this alone.

The other device difference is the trackpad component used. This is
simply handled by having both possible components described in the
device tree, and letting the implementation figure out which one is
actually available. The system bootloader / firmware does not
differentiate this in that they share the same SKU IDs.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v4:
- Fix pinmux node names
- Split anx7625 reset and power-en pins into separate pinmux nodes
- Change "touchpad" to "trackpad" in commit log

Changes since v3:
none

Changes since v2:
- Picked up Conor's ack

Changes since v1:
- Removed trackpad_pins reference (moved to i2c2 in corsola dtsi)
- Fixed copyright year
- Renamed touchpad to trackpad
---
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mt8186-corsola-steelix-sku131072.dts      |  18 ++
 .../mt8186-corsola-steelix-sku131073.dts      |  18 ++
 .../dts/mediatek/mt8186-corsola-steelix.dtsi  | 199 ++++++++++++++++++
 4 files changed, 237 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131072.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131073.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 22812b175736..0daa1ad27c22 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -51,6 +51,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327683.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262144.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131072.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131072.dts
new file mode 100644
index 000000000000..eae17bca8585
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131072.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-steelix.dtsi"
+
+/ {
+	model = "Google Steelix board";
+	compatible = "google,steelix-sku131072", "google,steelix",
+		     "mediatek,mt8186";
+	chassis-type = "convertible";
+};
+
+&mt6366codec {
+	mediatek,dmic-mode = <0>; /* two-wire */
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131073.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131073.dts
new file mode 100644
index 000000000000..a55375b95d0d
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131073.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-steelix.dtsi"
+
+/ {
+	model = "Google Steelix board";
+	compatible = "google,steelix-sku131073", "google,steelix",
+		     "mediatek,mt8186";
+	chassis-type = "convertible";
+};
+
+&mt6366codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
new file mode 100644
index 000000000000..e74e886a00cb
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/{
+	pp1000_edpbrdg: regulator-pp1000-edpbrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1000_edpbrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&en_pp1000_edpbrdg>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 29 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_z2>;
+	};
+
+	pp1800_edpbrdg_dx: regulator-pp1800-edpbrdg-dx {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_edpbrdg_dx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&en_pp1800_edpbrdg>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 30 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&mt6366_vio18_reg>;
+	};
+
+	pp3300_edp_dx: regulator-pp3300-edp-dx {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_edp_dx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&en_pp3300_edpbrdg>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 31 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_z2>;
+	};
+};
+
+&dsi_out {
+	remote-endpoint = <&anx7625_in>;
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+
+	anx_bridge: anx7625@58 {
+		compatible = "analogix,anx7625";
+		reg = <0x58>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&anx7625_pins>;
+		enable-gpios = <&pio 96 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 98 GPIO_ACTIVE_HIGH>;
+		vdd10-supply = <&pp1000_edpbrdg>;
+		vdd18-supply = <&pp1800_edpbrdg_dx>;
+		vdd33-supply = <&pp3300_edp_dx>;
+		analogix,lane0-swing = /bits/ 8 <0x70 0x30>;
+		analogix,lane1-swing = /bits/ 8 <0x70 0x30>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				anx7625_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+					data-lanes = <0 1 2 3>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				anx7625_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+
+		aux-bus {
+			panel: panel {
+				compatible = "edp-panel";
+				power-supply = <&pp3300_disp_x>;
+				backlight = <&backlight_lcd0>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint = <&anx7625_out>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	touchscreen: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&pp3300_s3>;
+		goodix,no-reset-during-suspend;
+	};
+};
+
+&i2c2 {
+	i2c-scl-internal-delay-ns = <22000>;
+
+	/* second source component */
+	trackpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
+		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+	>;
+
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x01, 0x04, KEY_MICMUTE)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
+
+&pio {
+	anx7625_pins: anx7625-pins {
+		pins-int {
+			pinmux = <PINMUX_GPIO9__FUNC_GPIO9>;
+			input-enable;
+			bias-disable;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO98__FUNC_GPIO98>;
+			output-low;
+		};
+
+		pins-power-en {
+			pinmux = <PINMUX_GPIO96__FUNC_GPIO96>;
+			output-low;
+		};
+	};
+
+	en_pp1000_edpbrdg: pp1000-edpbrdg-en-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO29__FUNC_GPIO29>;
+			output-low;
+		};
+	};
+
+	en_pp1800_edpbrdg: pp1800-edpbrdg-en-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO30__FUNC_GPIO30>;
+			output-low;
+		};
+	};
+
+	en_pp3300_edpbrdg: pp3300-edpbrdg-en-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO31__FUNC_GPIO31>;
+			output-low;
+		};
+	};
+};
-- 
2.43.0.429.g432eaa2c6b-goog


