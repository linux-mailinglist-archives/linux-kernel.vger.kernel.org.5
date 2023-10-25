Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16A27D721B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjJYRI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJYRIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:08:51 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F02138
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:08:47 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id 242FE1025DC;
        Wed, 25 Oct 2023 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1698253726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8yuV5J53FWoKCjRSM/WVoKUuB+P+j+Xkv2dcfbiTgzw=;
        b=Y2gPZwpMZXzI2K1k7RPrz6So7WgjlgUJmQOOGgsoxMKAVOxV8q1LMu//igS7RGYSu4hAl6
        HhQjEJGGQ/QT9V7eOC+WfBoPGSWK0vjChDKJ+317t0aGsvaOzFHWoCqMiALzwrXlfdmd7Y
        qvJMXqt5+FlrSSnkO7XQnfTgjvnYEeM=
Received: from frank-G5.. (fttx-pool-217.61.159.50.bambit.de [217.61.159.50])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 77D8A3608ED;
        Wed, 25 Oct 2023 17:08:45 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 5/5] arm64: dts: mt7986: add overlay for SATA power socket on BPI-R3
Date:   Wed, 25 Oct 2023 19:08:32 +0200
Message-Id: <20231025170832.78727-6-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025170832.78727-1-linux@fw-web.de>
References: <20231025170832.78727-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 274a7bdb-48f4-4d28-940a-144c3d90acaf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Bananapi R3 has a Power socket entended for using external SATA drives.
This Socket is off by default but can be switched with gpio 8.

Add an overlay to activate it.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- rebase on the patch "add dtbs with applied overlays for bpi-r3"
- add sata-overlay to the full dtbs
---
 arch/arm64/boot/dts/mediatek/Makefile         | 13 +++++--
 .../mt7986a-bananapi-bpi-r3-sata.dtso         | 39 +++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 24eeba0703ce..c3b236a47513 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -13,26 +13,31 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
 mt7986a-bananapi-bpi-r3-emmc-nand-dtbs := \
 	mt7986a-bananapi-bpi-r3.dtb \
 	mt7986a-bananapi-bpi-r3-emmc.dtbo \
-	mt7986a-bananapi-bpi-r3-nand.dtbo
+	mt7986a-bananapi-bpi-r3-nand.dtbo \
+	mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nand.dtb
 mt7986a-bananapi-bpi-r3-emmc-nor-dtbs := \
 	mt7986a-bananapi-bpi-r3.dtb \
 	mt7986a-bananapi-bpi-r3-emmc.dtbo \
-	mt7986a-bananapi-bpi-r3-nor.dtbo
+	mt7986a-bananapi-bpi-r3-nor.dtbo \
+	mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nor.dtb
 mt7986a-bananapi-bpi-r3-sd-nand-dtbs := \
 	mt7986a-bananapi-bpi-r3.dtb \
 	mt7986a-bananapi-bpi-r3-sd.dtbo \
-	mt7986a-bananapi-bpi-r3-nand.dtbo
+	mt7986a-bananapi-bpi-r3-nand.dtbo \
+	mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nand.dtb
 mt7986a-bananapi-bpi-r3-sd-nor-dtbs := \
 	mt7986a-bananapi-bpi-r3.dtb \
 	mt7986a-bananapi-bpi-r3-sd.dtbo \
-	mt7986a-bananapi-bpi-r3-nor.dtbo
+	mt7986a-bananapi-bpi-r3-nor.dtbo \
+	mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nor.dtb
 
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso
new file mode 100644
index 000000000000..6ab06813412a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Author: Frank Wunderlich <frank-w@public-files.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
+
+	fragment@0 {
+		target-path = "/";
+		__overlay__ {
+			reg_sata12v: regulator-sata12v {
+				compatible = "regulator-fixed";
+				regulator-name = "sata12v";
+				regulator-min-microvolt = <12000000>;
+				regulator-max-microvolt = <12000000>;
+				gpio = <&pio 8 GPIO_ACTIVE_HIGH>;
+				enable-active-high;
+				regulator-always-on;
+			};
+
+			reg_sata5v: regulator-sata5v {
+				compatible = "regulator-fixed";
+				regulator-name = "sata5v";
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-always-on;
+				vin-supply = <&reg_sata12v>;
+			};
+		};
+	};
+};
+
-- 
2.34.1

