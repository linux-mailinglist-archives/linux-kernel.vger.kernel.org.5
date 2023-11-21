Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83587F2DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKUMwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjKUMv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:51:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0D31A2;
        Tue, 21 Nov 2023 04:51:12 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33FE86607323;
        Tue, 21 Nov 2023 12:51:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571071;
        bh=7Is9gmN9hkuGxy+sJrNkxtzwuNgilsJCxJ9IKhqUks4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U28OlFbjZWTNhHg7n02D3GbangEkkeyjxK6DU74A/EClsB8By4WT4sVVfgxWsgp3u
         K3PtCRCEyErdirpchxpVdaWmOgv0zH+J0EmCwQuYpLgJcBrke4Mw+D9uhcXDecYtpY
         mlMLS5/O4qI3dags8d5kyl5Z0epQKWQWukwIUm64L13KO1/KqDGEIXS1VRy6izcmV0
         oNIkmKGEf3NXQ93+nrzm1qNF9qjKBQFhVvK50btDkoae3Oukd9GwDRNA5DI00Cznj8
         lACrjJWfQl4wwVAw9ShgaRj+TGGekYNij6Xf72WugNXe4u+0U4vGhjzhVD5VVjVveB
         raH7B/hYytneQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 19/20] arm64: dts: mediatek: mt8192: Add Smart Voltage Scaling node
Date:   Tue, 21 Nov 2023 13:50:43 +0100
Message-ID: <20231121125044.78642-20-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
References: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
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

Add the MediaTek SVS node: this will lower the voltage of various
components of the SoC based on chip quality (read from fuses) in
order to save power and generate less heat.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 238f6eb25832..6dd32dbfb832 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -809,6 +809,18 @@ lvts_ap: thermal-sensor@1100b000 {
 			#thermal-sensor-cells = <1>;
 		};
 
+		svs: svs@1100bc00 {
+			compatible = "mediatek,mt8192-svs";
+			reg = <0 0x1100bc00 0 0x400>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			clock-names = "main";
+			nvmem-cells = <&svs_calibration>, <&lvts_e_data1>;
+			nvmem-cell-names = "svs-calibration-data", "t-calibration-data";
+			resets = <&infracfg MT8192_INFRA_RST3_THERM_CTRL_PTP_SWRST>;
+			reset-names = "svs_rst";
+		};
+
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
-- 
2.42.0

