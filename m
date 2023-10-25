Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693747D6711
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjJYJis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjJYJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:38:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE7A1;
        Wed, 25 Oct 2023 02:38:35 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 675BA660734A;
        Wed, 25 Oct 2023 10:38:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698226714;
        bh=efDJQrKjAe7kgKeNlCXYP3DvHJae+s5csugVhpTz98s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkh6ZynZVWdd84IVwPJs+fMMRyRQyTYRbNddFux4rCSuSeV6Uc6v8sFqxzheYP9E7
         vvzUXW/bVY2VojPei5A1c7bE23uUjtR1UYdLBA6023hRBGhuiE2n4beyZVHwm9mV4T
         nBUkuMj0hXoVmK8WyVU/da4pST3uQywH8zyeDARkG0M20L/kV/kdfyX08N8cl5fC8z
         gKyI2+0xvQ7xxgQBGC+un30XJrP0rk/4XTLbRuwi2f6cnqe7kcl5Rdg41Yadk/mynm
         eVoAs/3mojMsmSjx1//Hi/dBma8E0RBNgMYp139TbxeMd+7zPnjwjyjwhz95Yxb4UJ
         eb/kyu2XasOvQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     hsinyi@chromium.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, erin.lo@mediatek.com,
        eddie.huang@mediatek.com, pihsun@chromium.org,
        fparent@baylibre.com, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, michael.kao@mediatek.com,
        mka@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 4/8] arm64: dts: mediatek: Move MT6358 PMIC interrupts to MT8183 boards
Date:   Wed, 25 Oct 2023 11:38:12 +0200
Message-ID: <20231025093816.44327-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025093816.44327-1-angelogioacchino.delregno@collabora.com>
References: <20231025093816.44327-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT6358 is a PMIC that is typically used on MT8183 boards, and it has
its own dtsi file, declaring interrupts-extended on its node.

The interrupt pin of that PMIC is connected to a SoC GPIO and that
is therefore not only SoC-specific, but board-specific: this means
that the interrupt-extended property does not belong to the PMIC
dtsi file, but to board files using that PMIC.

For correctness, transfer the interrupts-extended property from the
PMIC-specific mt6358.dtsi to board files.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi        | 1 -
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts     | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi  | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 4 ++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index 6f01ddf1acc7..61a655356663 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -8,7 +8,6 @@ &pwrap {
 	pmic: pmic {
 		compatible = "mediatek,mt6358";
 		interrupt-controller;
-		interrupts-extended = <&pio 182 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 
 		mt6358codec: mt6358codec {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index ce336a48c897..f8c1f8df85d0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -381,6 +381,10 @@ pins_pwm {
 	};
 };
 
+&pmic {
+	interrupts-extended = <&pio 182 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &mfg {
 	domain-supply = <&mt6358_vgpu_reg>;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index adadfc653f39..c81407e44eca 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -846,6 +846,10 @@ pins_wifi_wakeup {
 	};
 };
 
+&pmic {
+	interrupts-extended = <&pio 182 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &pwm0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index b5784a60c315..76449b4cf236 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -370,6 +370,10 @@ pins_clk {
 	};
 };
 
+&pmic {
+	interrupts-extended = <&pio 182 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &mfg {
 	domain-supply = <&mt6358_vgpu_reg>;
 };
-- 
2.42.0

