Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40BC7D43A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjJXAH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJXAHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:07:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A999510CB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-577e62e2adfso2367461a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698106058; x=1698710858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uljJOYp9SPwgii6z9nBGZ6O6OKzfH06bDcWI3pU4ax8=;
        b=akuoci4LJ8/ZKa7wum+smOtHhQfw4TdFZlo+tkJ5u7OTLsnUafZWOpQ4VMb6Lqr719
         hbbwSRIQ1TDkAfND9Ai6PMV+T7CxC561iokWeIZkOXw3P+OrnGn7lsraivptpCDeD/+0
         lYkK0E4ORnbgfxpqB0AW9M9W9bktde+bUTIbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106058; x=1698710858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uljJOYp9SPwgii6z9nBGZ6O6OKzfH06bDcWI3pU4ax8=;
        b=TiAB0p5oZUgQRyOfsW5wCgvHG7dK+SLPE8DilSCpfAnNO0zCEcciVYz2y6E0zBqi61
         xwHgRawMm45T3K0H9CypVI6Gcg7at6zU2TUvJt7nEBtbf2K6QJ1QARIrmusU9yzt0w7K
         ZDvf5m0KFtracThZrCyrF40cMjz0UIB95BL347U312rRD+qLsZr7e08NibSekZSQbM2f
         ZsVtV1uyjijYqaK9XT9Zuvkxj9Ch0JVN0mWP2fdAcviWrcg+vcSyD1K2b24GdR1RISo2
         DNdTy/X6tLoREsRIq8jl6BPn+0BKv1vQH/PwXhlfpWuejsJlgDfa21P5mwSFPAhs/iwU
         8u4g==
X-Gm-Message-State: AOJu0YxMnjM0rJ+WnknmEAqhMQvHKbnGxGrArdbdmIQXNq9zzzOK+2TS
        g/GQ1uQcJxolvLHS8gIyXIvz4A==
X-Google-Smtp-Source: AGHT+IFfpVT1CfSbELIj6YsfEI/agaom4NFI7V9kAEtNTMGnwUcyunjQnXhKJwynE8IwMQ+Ptg6hJg==
X-Received: by 2002:a17:902:ab52:b0:1c9:d61a:f4a4 with SMTP id ij18-20020a170902ab5200b001c9d61af4a4mr7173987plb.60.1698106058055;
        Mon, 23 Oct 2023 17:07:38 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001c5dea67c26sm6505510plh.233.2023.10.23.17.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:07:36 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 6/6] arm64: dts: mt8183: Add jacuzzi pico/pico6 board
Date:   Mon, 23 Oct 2023 17:02:29 -0700
Message-ID: <20231024000724.57714-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024000724.57714-1-hsinyi@chromium.org>
References: <20231024000724.57714-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pico is also known as Acer Chromebook Spin 311.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../mediatek/mt8183-kukui-jacuzzi-pico.dts    |  36 ++++++
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   | 110 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
new file mode 100644
index 000000000000..e230323b3a54
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
+
+/ {
+	model = "Google pico board";
+	chassis-type = "convertible";
+	compatible = "google,pico-sku1", "google,pico", "mediatek,mt8183";
+};
+
+&i2c_tunnel {
+	google,remote-bus = <0>;
+};
+
+&i2c2 {
+	i2c-scl-internal-delay-ns = <25000>;
+
+	trackpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+
+		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
+
+		wakeup-source;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
new file mode 100644
index 000000000000..3e4bc451039e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
+
+/ {
+	model = "Google pico6 board";
+	chassis-type = "convertible";
+	compatible = "google,pico-sku2", "google,pico", "mediatek,mt8183";
+
+	bt_wakeup: bt-wakeup {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pins_wakeup>;
+
+		wobt {
+			label = "Wake on BT";
+			gpios = <&pio 42 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+};
+
+&i2c_tunnel {
+	google,remote-bus = <0>;
+};
+
+&i2c2 {
+	i2c-scl-internal-delay-ns = <25000>;
+
+	trackpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+
+		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
+
+		wakeup-source;
+	};
+};
+
+&wifi_wakeup {
+	wowlan {
+		gpios = <&pio 113 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&wifi_pwrseq {
+	post-power-on-delay-ms = <50>;
+
+	/* Toggle WIFI_ENABLE to reset the chip. */
+	reset-gpios = <&pio 8 1>;
+};
+
+&wifi_pins_pwrseq {
+	pins_wifi_enable {
+		pinmux = <PINMUX_GPIO8__FUNC_GPIO8>;
+	};
+};
+
+&mmc1_pins_default {
+	pins_cmd_dat {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+	pins_clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
+
+&mmc1_pins_uhs {
+	pins_clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
+
+&mmc1 {
+	bt_reset: bt-reset {
+		compatible = "mediatek,mt7921s-bluetooth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pins_reset>;
+		reset-gpios = <&pio 120 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pio {
+	bt_pins_wakeup: bt-pins-wakeup {
+		pins_bt_wakeup {
+			pinmux = <PINMUX_GPIO42__FUNC_GPIO42>;
+			input-enable;
+		};
+	};
+
+	bt_pins_reset: bt-pins-reset {
+		pins_bt_reset {
+			pinmux = <PINMUX_GPIO120__FUNC_GPIO120>;
+			output-high;
+		};
+	};
+};
+
+/delete-node/ &bluetooth;
+/delete-node/ &bt_pins;
-- 
2.42.0.758.gaed0368e0e-goog

