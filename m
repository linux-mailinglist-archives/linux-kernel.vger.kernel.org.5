Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE5376FDF7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjHDJ7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjHDJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:59:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D249E3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:58:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6878db91494so270516b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1691143134; x=1691747934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmw4MJaNpCbrB1+hKOu+EXDpll+aiGyzO96Ozc/I49M=;
        b=1ysjA76ZpbU3cP4o5qRyfncYLN8PUXlkMFioIMNgK7xXeJDroxoS6pRfLwUEMYTvtc
         0O8NwabDrQRyebqwGvhI40461dOiiIeuu9KaOXKuhP0R8UL2MZbMj4+a6GvUZYzSYOlc
         Ykg3You2Uw1K2b4qxwBdZXnjUkvwLJtK+2p9iq+il3GUcy6vOUe3nyiQgqKnoSwk22PO
         VE1irI3kVmhh/sxK33zGDcUlz8H6zxalc8/GbG9qT+aARSL2dOuSJy1oj8D1QfFM35vk
         67fFkbVwOndOU0ad2FVvGk+sVeZ5rTdfTcstRc79f9ND5nJbUdOGm7WiUW7bK7AB2wxM
         v5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143134; x=1691747934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmw4MJaNpCbrB1+hKOu+EXDpll+aiGyzO96Ozc/I49M=;
        b=kN+M4cZdT0c5lZjSA2OKLKYHj8HAf8An1q1TSyPbW0Aa7QqHOfqiaZTJjzn7+RiFFb
         ss8WeKVrpTBzM7m1UImGGuK0/eFTcTK4RFIfLTnlaCLP44gSpPHNPzwRIW9YXHyBDFNF
         5YRNAA4JbngW+KaxBzYiP4i5gl0xiwAJHHCxgAl+NOW7zJXpUqTDGNt5zaM2k+Vk5HI/
         Y/zccV8mlf3RuheUPSPiVJ/BMrcTGv3YCW3gWX5QKYx5gKgxeLLMqjql7pYkSibhuYgK
         ZJelqW2cztfwBeoTuvvxJfYyNEeffljKJQ3NE+5m2448dkeyTxyAnkR8IGyrNJE2jEWE
         IEEA==
X-Gm-Message-State: ABy/qLbHGOujdue1GOiEya+UeT9N5rv/s+KxDmqNKoMhQvJXId43ZoeZ
        KvS3sLKa0jIXiWzP5XGVavGhuj+MtStZqqQVdClqqw==
X-Google-Smtp-Source: APBJJlFJBEEK2SBsGoaeA7HpfyWVfMA9etQoCA6pqcKw++8r+6jKuLNH6s4t/cBu6s4FabbAKd8DMw==
X-Received: by 2002:a05:6a00:414e:b0:681:9fe0:b543 with SMTP id bv14-20020a056a00414e00b006819fe0b543mr19674839pfb.2.1691143133748;
        Fri, 04 Aug 2023 02:58:53 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id i2-20020aa787c2000000b0067b643b814csm1259949pfo.6.2023.08.04.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:58:53 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: sc7180: Add board id for lazor/limozeen
Date:   Fri,  4 Aug 2023 17:58:36 +0800
Message-Id: <20230804175734.v2.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add BRD_ID(0, Z, 0) = 10 for new board with ALC5682i-VS

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

Changes in v2:
- correct newly create dts files

 arch/arm64/boot/dts/qcom/Makefile             |  5 ++
 ...sc7180-trogdor-lazor-limozeen-nots-r10.dts | 40 +++++++++++++
 .../sc7180-trogdor-lazor-limozeen-nots-r9.dts |  4 +-
 .../sc7180-trogdor-lazor-limozeen-r10.dts     | 56 +++++++++++++++++++
 .../qcom/sc7180-trogdor-lazor-limozeen-r9.dts |  4 +-
 .../dts/qcom/sc7180-trogdor-lazor-r10-kb.dts  | 34 +++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10-lte.dts | 38 +++++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10.dts     | 30 ++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   |  4 +-
 .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  |  4 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts |  4 +-
 11 files changed, 213 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 337abc4ceb17..73e745fb1ff0 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -109,11 +109,16 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-kb.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-kb.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r9.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r10.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r9.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r10.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-parade.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-ti.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-parade.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
new file mode 100644
index 000000000000..fe634e2caf3b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor Limozeen board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Lazor Limozeen without Touchscreen (rev10+)";
+	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";
+};
+
+/delete-node/&ap_ts;
+
+&panel {
+	compatible = "edp-panel";
+};
+
+&sdhc_2 {
+	status = "okay";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
index cef57c15b70b..e3f1f30a7fc3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
@@ -13,8 +13,8 @@
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
-	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";
+	model = "Google Lazor Limozeen without Touchscreen (rev9)";
+	compatible = "google,lazor-rev9-sku6", "google,lazor-rev9-sku18", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
new file mode 100644
index 000000000000..7b97963cce6e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor Limozeen board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Lazor Limozeen (rev10+)";
+	compatible = "google,lazor-sku4", "google,lazor-sku15", "qcom,sc7180";
+};
+
+/delete-node/&ap_ts;
+
+&ap_ts_pen_1v8 {
+	ap_ts: touchscreen@10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc33-supply = <&pp3300_ts>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&panel {
+	compatible = "auo,b116xa01";
+};
+
+&sdhc_2 {
+	status = "okay";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
index 2038a82bc0e7..3b6053f3e62b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
@@ -13,8 +13,8 @@
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Lazor Limozeen (rev9+)";
-	compatible = "google,lazor-sku4", "google,lazor-sku15", "qcom,sc7180";
+	model = "Google Lazor Limozeen (rev9)";
+	compatible = "google,lazor-rev9-sku4", "google,lazor-rev9-sku15", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
new file mode 100644
index 000000000000..6f98f61ac567
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
+
+/ {
+	model = "Google Lazor (rev10+) with KB Backlight";
+	compatible = "google,lazor-sku2", "qcom,sc7180";
+};
+
+&keyboard_backlight {
+	status = "okay";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
new file mode 100644
index 000000000000..03d0d0af367c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Lazor (rev10+) with LTE";
+	compatible = "google,lazor-sku0", "google,lazor-sku10", "qcom,sc7180";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
+
+&keyboard_backlight {
+	status = "okay";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
new file mode 100644
index 000000000000..5a58e94c228e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
+
+/ {
+	model = "Google Lazor (rev10+)";
+	compatible = "google,lazor", "qcom,sc7180";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
index 960f7b7ce094..f74a1985cac6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
@@ -13,8 +13,8 @@
 #include "sc7180-lite.dtsi"
 
 / {
-	model = "Google Lazor (rev9+) with KB Backlight";
-	compatible = "google,lazor-sku2", "qcom,sc7180";
+	model = "Google Lazor (rev9) with KB Backlight";
+	compatible = "google,lazor-rev9-sku2", "qcom,sc7180";
 };
 
 &keyboard_backlight {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
index 438ab9cd3389..15dcf95da311 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
@@ -13,8 +13,8 @@
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Lazor (rev9+) with LTE";
-	compatible = "google,lazor-sku0", "google,lazor-sku10", "qcom,sc7180";
+	model = "Google Lazor (rev9) with LTE";
+	compatible = "google,lazor-rev9-sku0", "google,lazor-rev9-sku10", "qcom,sc7180";
 };
 
 &ap_sar_sensor_i2c {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
index 56dd222650d3..44f61bc56f81 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
@@ -13,6 +13,6 @@
 #include "sc7180-lite.dtsi"
 
 / {
-	model = "Google Lazor (rev9+)";
-	compatible = "google,lazor", "qcom,sc7180";
+	model = "Google Lazor (rev9)";
+	compatible = "google,lazor-rev9", "qcom,sc7180";
 };
-- 
2.34.1

