Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9296C7E676A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjKIKHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjKIKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:07:22 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F744358C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:07:13 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so711728b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699524433; x=1700129233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onLNc+Oko6/d4dZDi8m4Ahc5zglhx4oC8hmNsm3uUAA=;
        b=CdwuVzTcLaNuBWm+5+Eyq35jTiVIQezZYsIJ/TuYU3pt1Cm54umZ2eQZ/7u92dCADF
         mVmV/nvqCJrh9HIh3sURGPaARnApWRc39+IT95mTp/ryN3aV4BjyK0dTyGXe8OJcmshg
         BrYsnYxfDR5Y0Onaai+8FCNo5TTuyV1p7O9ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524433; x=1700129233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onLNc+Oko6/d4dZDi8m4Ahc5zglhx4oC8hmNsm3uUAA=;
        b=ZASseHrWJtujXdtzRqJLIi/BiddLHjgKQDqJkVWGahnR5OfJu0W0/pc56z8Hw5fjNQ
         3r8j0BddmFx9HwJsqeKy+uaWtvHm+Rccf0t6EF5o6hUyznn3pv8RXEq57FfplavmtzOl
         QNqzCn/CyxVj6a5ml+C3r5bnc3L71en+pyx17DyYnCSnBYI5A9T6+le5SCNKMOoyzC5T
         fi8rT7CoLJ/vWhmynoPPtXVqTl6Lt4C8gTIUPMzjnlQxV+TIlUCtUY2vjsZeY11iO55b
         YeccZVJvpCEahAZVqFJD5FKH2e7zVIQf2qga3zmKUGW/X4E++sWSqTw9Y2JtaAY6yUC2
         6L7Q==
X-Gm-Message-State: AOJu0YwQgj3nKPsWjW+LplRM+gL72b/+0cIVeGtyLIbMJED5hfVpDfXg
        T5qS9hsN/Y7PJRhdUO4trEJZJw==
X-Google-Smtp-Source: AGHT+IE47jHpK3aDbKhKoDgiHCyXY2l2uWAuEaUiNlv/nfVr6trsVMV2KYbXDfC5qwkSNTHKG8ky5g==
X-Received: by 2002:a05:6a21:19a:b0:181:10ee:20d5 with SMTP id le26-20020a056a21019a00b0018110ee20d5mr6079204pzb.12.1699524433438;
        Thu, 09 Nov 2023 02:07:13 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f57:d4c:468c:5daf])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001c60ba709b7sm3127511plg.125.2023.11.09.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:07:12 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH v2 7/7] arm64: dts: mediatek: mt8183-kukui: Merge Krane device trees
Date:   Thu,  9 Nov 2023 18:06:04 +0800
Message-ID: <20231109100606.1245545-8-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231109100606.1245545-1-wenst@chromium.org>
References: <20231109100606.1245545-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases where the same Chromebook model is manufactured with different
components (MIPI DSI panels, MIPI CSI camera sensors, or trackpad /
touchscreens with conflicting addresses), a different SKU ID is
allocated to each specific combination. This SKU ID is exported by the
bootloader into the device tree, and can be used to "discover" which
combination is present on the current machine.

Merge the separate Krane dtsi/dts files into one shared for all SKUs.
A new device node is added for the alternative panel. Both it and the
original panel are marked as "fail-needs-probe-panel" to let the
hardware prober handle it.

Also move the cros_ec node so that all node references are ordered
alphabetically.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  3 +-
 .../dts/mediatek/mt8183-kukui-krane-sku0.dts  | 24 ----------
 .../mediatek/mt8183-kukui-krane-sku176.dts    | 24 ----------
 ...ukui-krane.dtsi => mt8183-kukui-krane.dts} | 47 +++++++++++++++++--
 4 files changed, 44 insertions(+), 54 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
 rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-krane.dtsi => mt8183-kukui-krane.dts} (86%)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 7e365e9516ab..d4d97b315b2f 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -40,8 +40,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku288.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
deleted file mode 100644
index 4ac75806fa94..000000000000
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2019 Google LLC
- *
- * Device-tree for Krane sku0.
- *
- * SKU is a 8-bit value (0x00 == 0):
- *  - Bits 7..4: Panel ID: 0x0 (AUO)
- *  - Bits 3..0: SKU ID:   0x0 (default)
- */
-
-/dts-v1/;
-#include "mt8183-kukui-krane.dtsi"
-
-/ {
-	model = "MediaTek krane sku0 board";
-	chassis-type = "tablet";
-	compatible = "google,krane-sku0", "google,krane", "mediatek,mt8183";
-};
-
-&panel {
-	status = "okay";
-	compatible = "auo,kd101n80-45na";
-};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
deleted file mode 100644
index 095279e55d50..000000000000
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2019 Google LLC
- *
- * Device-tree for Krane sku176.
- *
- * SKU is a 8-bit value (0xb0 == 176):
- *  - Bits 7..4: Panel ID: 0xb (BOE)
- *  - Bits 3..0: SKU ID:   0x0 (default)
- */
-
-/dts-v1/;
-#include "mt8183-kukui-krane.dtsi"
-
-/ {
-	model = "MediaTek krane sku176 board";
-	chassis-type = "tablet";
-	compatible = "google,krane-sku176", "google,krane", "mediatek,mt8183";
-};
-
-&panel {
-        status = "okay";
-        compatible = "boe,tv101wum-nl6";
-};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dts
similarity index 86%
rename from arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
rename to arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dts
index d5f41c6c9881..75a734c0fbcc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dts
@@ -1,12 +1,24 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright 2019 Google LLC
+ *
+ * Device tree for Krane Chromebook family.
+ *
+ * SKU ID is a 8-bit value (0x00 == 0):
+ *  - Bits 7..4: Panel ID: 0x0 (AUO)
+ *                         0xb (BOE)
+ *  - Bits 3..0: SKU ID:   0x0 (default)
  */
 
+/dts-v1/;
 #include "mt8183-kukui.dtsi"
 #include "mt8183-kukui-audio-max98357a.dtsi"
 
 / {
+	model = "Google Krane Chromebook";
+	chassis-type = "tablet";
+	compatible = "google,krane", "mediatek,mt8183";
+
 	ppvarn_lcd: ppvarn-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "ppvarn_lcd";
@@ -45,6 +57,34 @@ &bluetooth {
 	firmware-name = "nvm_00440302_i2s_eu.bin";
 };
 
+&cros_ec {
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
+&dsi0 {
+	panel2@0 {
+		compatible = "boe,tv101wum-nl6";
+		reg = <0>;
+		enable-gpios = <&pio 45 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_pins_default>;
+		avdd-supply = <&ppvarn_lcd>;
+		avee-supply = <&ppvarp_lcd>;
+		pp1800-supply = <&pp1800_lcd>;
+		backlight = <&backlight_lcd0>;
+		rotation = <270>;
+		status = "fail-needs-probe-panel";
+
+		port {
+			endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -343,10 +383,9 @@ rst_pin {
 	};
 };
 
-&cros_ec {
-	keyboard-controller {
-		compatible = "google,cros-ec-keyb-switches";
-	};
+&panel {
+	compatible = "auo,kd101n80-45na";
+	status = "fail-needs-probe-panel";
 };
 
 &qca_wifi {
-- 
2.42.0.869.gea05f2083d-goog

