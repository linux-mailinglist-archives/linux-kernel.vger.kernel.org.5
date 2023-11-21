Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF667F2D92
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjKUMvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKUMu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:50:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B9D40;
        Tue, 21 Nov 2023 04:50:53 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 71F976607319;
        Tue, 21 Nov 2023 12:50:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571052;
        bh=sMWHddCvw/Ujx/UtO/I5fhryZnx4605LdfFnzpLxwHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czu1IDXkmfGQoXXAY2Ow6FUdSqnS8A6KSLHq2XIAtyYRq99vMp8hN4BBJQwJloPGU
         YRFADA3lT5OI/VXHS/TqZJDuGYzC3Gc44c2JupQkz/U8NIa+7aOs6Nb3fbPWFMjTIt
         uIxxdNLJXuIu+tScgpWR0XLVufgCxzg4n/IrAMBnfMDUkyP8tvdF8IFZp6cbMycZgp
         +PrXThhHX8MzgDTNasu3VM0HZtvCBl6owq9byofRwQKU3gC5P2eNPNTNSBOTVmfMIh
         XNONNivfhxcRDBTU5Kqs/4dvVLDnaXcnNQLeBp23U00xLzh8eBUCLUAJyT7HdXQgN8
         VxpwdUmg8j37A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 01/20] arm64: dts: mediatek: mt8183: Change iospaces for thermal and svs
Date:   Tue, 21 Nov 2023 13:50:25 +0100
Message-ID: <20231121125044.78642-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
References: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SVS iospace starts at 0x1100bc00 and not at 0x1100b000 as the
latter is the thermal sensor iospace instead.

Change the iospaces for both as following:
 - Thermal: 0x1100b000, length 0xc00
 - SVS: 0x1100bc00, length 0x400

Please note that while this would be a breaking change for SVS (but
not for thermal sensors), it doesn't matter because the svs driver
never worked anyway because of the missing trips in tzts2, causing
that thermal zone to never actually register, hence the SVS driver
to fail probing anyway.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 26 ++++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5169779d01df..13c3104bc67b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1183,22 +1183,10 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
-		svs: svs@1100b000 {
-			compatible = "mediatek,mt8183-svs";
-			reg = <0 0x1100b000 0 0x1000>;
-			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&infracfg CLK_INFRA_THERM>;
-			clock-names = "main";
-			nvmem-cells = <&svs_calibration>,
-				      <&thermal_calibration>;
-			nvmem-cell-names = "svs-calibration-data",
-					   "t-calibration-data";
-		};
-
 		thermal: thermal@1100b000 {
 			#thermal-sensor-cells = <1>;
 			compatible = "mediatek,mt8183-thermal";
-			reg = <0 0x1100b000 0 0x1000>;
+			reg = <0 0x1100b000 0 0xc00>;
 			clocks = <&infracfg CLK_INFRA_THERM>,
 				 <&infracfg CLK_INFRA_AUXADC>;
 			clock-names = "therm", "auxadc";
@@ -1210,6 +1198,18 @@ thermal: thermal@1100b000 {
 			nvmem-cell-names = "calibration-data";
 		};
 
+		svs: svs@1100bc00 {
+			compatible = "mediatek,mt8183-svs";
+			reg = <0 0x1100bc00 0 0x400>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			clock-names = "main";
+			nvmem-cells = <&svs_calibration>,
+				      <&thermal_calibration>;
+			nvmem-cell-names = "svs-calibration-data",
+					   "t-calibration-data";
+		};
+
 		thermal_zones: thermal-zones {
 			cpu_thermal: cpu-thermal {
 				polling-delay-passive = <100>;
-- 
2.42.0

