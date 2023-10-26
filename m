Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE697D88CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbjJZTOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJZTNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:13:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CB51A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b856d73a12so1062162a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698347633; x=1698952433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymcTSMtDLHHq71nFPpNk2uBvq4G7e2/sBgD9CU8KCYw=;
        b=UbpXlCtoKGrpDsr+8z1AwLhAA0y/ipE4uSCQI7i5FdqMSB/ETDceXLfsr1mz+8PxcJ
         hZEy2M3N6P/GUApqrLL5UVJtFTdqATDVIfHrmDwtiAOdU/ubkmFCZ3ouqKnJVN12xyvv
         L96xPsT2EIreK8iVVFjLpKTiTviKLZqerzdzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698347633; x=1698952433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymcTSMtDLHHq71nFPpNk2uBvq4G7e2/sBgD9CU8KCYw=;
        b=sfW6Fr10wDyO+0nfUGi8oIU1OHiqonJFK4PCTsqapXMIvjsti1cF9ZOGboQXjlBAwo
         RMGal6Oq+pol35LUsOmb5IpJSS4bFqgVrwcy1RfHv+1QU3oCvQo8JWLHoObjwVHDM60m
         EJ3TPZ+E7NiNwP7LUPhLuZS8ZrZ7xvaaWOsKvWAd5ae5ZFUopniMySdGxp2qWNSHvm6i
         sFc12A+yctbW/9BhM2rsN1z8ce1OayTxcpmt9r8kOYt4gJ2GkiMoUZfsUdDouA4ImocQ
         iJpA1RdIAxryCuM/5c1GhaVYy8fE3ykNw9kqek60Ectff07G/0xvw+stUdVB5KwZkGqr
         keGw==
X-Gm-Message-State: AOJu0Ywc9IITrEc/SIatFkEvMriGsoXba2Kl3YEiXZIRX99j3Jt77vgK
        G4sHFwmhwv+WFEdv6taZib0DpQ==
X-Google-Smtp-Source: AGHT+IHgWafWGCPc4fytC4Sbz3TS+J9+az9DjgeXUARPGps1DNFwHFfZHrZIwyi3DJOvEqNBHlCllw==
X-Received: by 2002:a17:90b:3901:b0:27d:b811:2fe4 with SMTP id ob1-20020a17090b390100b0027db8112fe4mr496194pjb.26.1698347633233;
        Thu, 26 Oct 2023 12:13:53 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a031600b0027476c68cc3sm2183639pje.22.2023.10.26.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:13:52 -0700 (PDT)
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
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 5/7] arm64: dts: mt8183: Add jacuzzi makomo board
Date:   Thu, 26 Oct 2023 12:09:14 -0700
Message-ID: <20231026191343.3345279-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231026191343.3345279-1-hsinyi@chromium.org>
References: <20231026191343.3345279-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

makomo is also known as Lenovo 100e Chromebook 2nd Gen MTK 2.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      | 24 +++++++++++++++++++
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      | 24 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a13419e67e8e..1b85a8c12850 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -32,6 +32,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel14-sku2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kenzo.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-makomo-sku0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-makomo-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
new file mode 100644
index 000000000000..4eb2a0d571af
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
@@ -0,0 +1,24 @@
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
+	compatible = "google,makomo-sku0", "google,makomo", "mediatek,mt8183";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL14";
+};
+
+&mmc1_pins_uhs {
+	pins-clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
new file mode 100644
index 000000000000..6a733361e8ae
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
@@ -0,0 +1,24 @@
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
+	compatible = "google,makomo-sku1", "google,makomo", "mediatek,mt8183";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL14";
+};
+
+&mmc1_pins_uhs {
+	pins-clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
-- 
2.42.0.820.g83a721a137-goog

