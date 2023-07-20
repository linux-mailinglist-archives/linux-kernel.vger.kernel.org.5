Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DAD75AACB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGTJaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjGTJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:29:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EF93961F;
        Thu, 20 Jul 2023 02:16:08 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E3686607083;
        Thu, 20 Jul 2023 10:16:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689844567;
        bh=RS3D7qGMh5ZjtLMh7J5GSgr8hhXOOvN9RiKn2MLxZCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJPIhuBqC+hCROartfkj7tc548eLIs207EAB6dKzvEUNySYWuBdiSZ68gmqmlBMX5
         RhO9HB63iA8MShcPKAA1brEW2ECkavTaEbfzTxvwmvkmGDqrrwu79wDzPvkIrwWVcB
         DfXhGtW3MwQN9sz50J9dQ8lwR6VuIFQ+aeozAAOiIRzAczFXp+a1Txz382YJwrzBCH
         7yDdz1/uFD0RtzCbvb52XpBIhj8fMRBK/0Ub4VqqPAmt0ahaDpQcO90aQ7K/NeY0w2
         yUNbkveIdhJU4t25gJkKChDxBxRahvMrQBUfUZ2T62Q1s//iU+NmUOatPafBJVt577
         zw5gUV7wAobjg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/3] arm64: dts: mediatek: mt6795-xperia-m5: Add DSI Display and its vregs
Date:   Thu, 20 Jul 2023 11:15:59 +0200
Message-Id: <20230720091559.86406-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720091559.86406-1-angelogioacchino.delregno@collabora.com>
References: <20230720091559.86406-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the DSI display found on the Sony Xperia M5, including
the necessary regulators configuration for it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index ecdf00707a44..7364c7278276 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -66,6 +66,65 @@ bootloader-region@46000000 {
 			no-map;
 		};
 	};
+
+	vreg_disp_avdd: regulator-disp-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "disp_avdd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 138 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vreg_disp_avee: regulator-disp-avee {
+		compatible = "regulator-fixed";
+		regulator-name = "disp_avee";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 139 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vreg_disp_vddh: regulator-disp-vddh {
+		compatible = "regulator-fixed";
+		regulator-name = "disp_vddh";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&dsi0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel: panel@0 {
+		compatible = "sharp,ls060t1sx01";
+		reg = <0>;
+		avdd-supply = <&vreg_disp_avdd>;
+		avee-supply = <&vreg_disp_avee>;
+		vddi-supply = <&mt6331_vgp3_reg>;
+		vddh-supply = <&vreg_disp_vddh>;
+		reset-gpios = <&pio 106 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight_lcd0>;
+
+		pinctrl-0 = <&disp_rst_pins>;
+		pinctrl-names = "default";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+
+	port {
+		dsi0_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
 };
 
 &fhctl {
@@ -180,7 +239,17 @@ &mmc2 {
 	status = "okay";
 };
 
+&mt6331_vgp3_reg {
+	regulator-min-microvolt = <1800000>;
+};
+
 &pio {
+	disp_rst_pins: lcm-pins {
+		pins-rst {
+			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
+		};
+	};
+
 	mmc0_pins_default: emmc-sdr-pins {
 		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO154__FUNC_MSDC0_DAT0>,
-- 
2.40.1

