Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A747D439F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjJXAHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjJXAHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:07:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EA8D7F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cace3e142eso22359055ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698106055; x=1698710855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FubqupHpLqb2pDn4ndeupK3XOZHp/EqiYPXj4OW7V58=;
        b=jrA2qsFIJ1ayHBAUbxN5OQPJoqdfKaBUB0dHr/1GuUG+KcwjCE7T/3zMgutpjmzxq5
         dZ4Fs/qjpduXs03MyOL2gL5Dd5Fh0zupud9BcWcnnIokxYB6qdf90pKvueW4XQdkbW/T
         +YzXg7Cka/udlro6KZEwm9iVLtBDUgNtBPxyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106055; x=1698710855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FubqupHpLqb2pDn4ndeupK3XOZHp/EqiYPXj4OW7V58=;
        b=TWUcEp4e+rI5cY58HvFK6tPL1yDlyX7oIkqM4ygihKqwBREedd/4NqW5I7H6Z+CVt/
         0eg2a2p4zzHMQA0IKXPDJ9iwBVzIXzmfPCwC18KXGIAW8uuuilNrI0K/c5yIfNHmS39o
         rm5UtkwCpGK5XQ3VcLcO5JcP8pwQQm5R3wyzwEnRibtjnOdlpdP8wlzqXcRmCweMAZPm
         MHxWibirXqRRfUhaN35JGf9OpCqFiu4EqQGX4sUth6rpHuPPfauKmX3VtbfHAUxRepWi
         ner676iyqyt4UpwEAEeztGBfJvvBnc5iKRPCQowBboCAVtGDqh0Goj9TJQ17keHwTXFq
         FcUw==
X-Gm-Message-State: AOJu0YyewgE3epxZZkqaH6QTduv9tHIUK9ZdvuCYmzEbeVW+Wn3uCr88
        FXnHabxd7xzX+vOdf3TfLQ7kkA==
X-Google-Smtp-Source: AGHT+IFSs+WghIauk4oRi2TEuZcbAqZ7IAK+F7XXY/BHNLidhvYR8UasV3y1B7a5WTf9vjbnqjtQbg==
X-Received: by 2002:a17:902:e402:b0:1c9:ca02:645c with SMTP id m2-20020a170902e40200b001c9ca02645cmr6318758ple.36.1698106054711;
        Mon, 23 Oct 2023 17:07:34 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001c5dea67c26sm6505510plh.233.2023.10.23.17.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:07:34 -0700 (PDT)
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
Subject: [PATCH 4/6] arm64: dts: mt8183: Add jacuzzi makomo board
Date:   Mon, 23 Oct 2023 17:02:27 -0700
Message-ID: <20231024000724.57714-5-hsinyi@chromium.org>
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

makomo is also known as Lenovo 100e Chromebook 2nd Gen MTK 2.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      | 25 +++++++++++++++++++
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      | 25 +++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
new file mode 100644
index 000000000000..b80be5dbcd7b
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
+
+/ {
+	model = "Google makomo sku0 board";
+	chassis-type = "laptop";
+	compatible = "google,makomo-rev4-sku0", "google,makomo-rev5-sku0",
+		     "google,makomo", "mediatek,mt8183";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL14";
+};
+
+&mmc1_pins_uhs {
+	pins_clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
new file mode 100644
index 000000000000..46da8c50aaa9
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-rt1015p.dtsi"
+
+/ {
+	model = "Google makomo sku1 board";
+	chassis-type = "laptop";
+	compatible = "google,makomo-rev4-sku1", "google,makomo-rev5-sku1",
+		     "google,makomo", "mediatek,mt8183";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL14";
+};
+
+&mmc1_pins_uhs {
+	pins_clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
-- 
2.42.0.758.gaed0368e0e-goog

