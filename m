Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD17F6077
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345501AbjKWNiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbjKWNiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:38:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F910C7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:38:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E51CC4339A;
        Thu, 23 Nov 2023 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700746695;
        bh=KAXGKMe2WBFft3tNq3FpiQGsTc/R5/rmU8Cl5gayixE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhN61ErzqtMja4ZFFmQQN/xzpcG0fK/ObB0YFgMn1t1PGix45506/KGgqWs9ohzmp
         teG1YFzyk9oQHh3zwqPYA0hlBtfBusl0Z6r345MOhJnm8rvM4KB48x0iaNk4nldz/u
         ZS9+xmE2mHJ2uXcQThWf2D8dspHlyDLqj7SjTHHtbjnWOocfW8x7aUWleDr2BtpDjB
         e5xvjFGDf3TbYpIGlY/vHoscApV9jwAZHzjyfe70iG1Z11sj2tcDmNKKqaVZtAr0qI
         GXIDyaX0p2WxIBxhNqyYA3+ZN7Nm5yJgt1gk1jWhI4PR5du6I3bNv6b+7Svp2m+9wn
         NxEvBWQHWjUjA==
From:   Michael Walle <mwalle@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, Michael Walle <mwalle@kernel.org>
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8195: add DSI and MIPI DPHY nodes
Date:   Thu, 23 Nov 2023 14:37:48 +0100
Message-Id: <20231123133749.2030661-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123133749.2030661-1-mwalle@kernel.org>
References: <20231123133749.2030661-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two DSI controller node and the associated DPHY nodes.
Individual boards have to enable them in the board device tree.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 54c674c45b49..0621bb461967 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1714,6 +1714,26 @@ u2port3: usb-phy@0 {
 			};
 		};
 
+		mipi_tx0: dsi-phy@11c80000 {
+			compatible = "mediatek,mt8195-mipi-tx", "mediatek,mt8183-mipi-tx";
+			reg = <0 0x11c80000 0 0x1000>;
+			clocks = <&clk26m>;
+			clock-output-names = "mipi_tx0_pll";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		mipi_tx1: dsi-phy@11c90000 {
+			compatible = "mediatek,mt8195-mipi-tx", "mediatek,mt8183-mipi-tx";
+			reg = <0 0x11c90000 0 0x1000>;
+			clocks = <&clk26m>;
+			clock-output-names = "mipi_tx1_pll";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		i2c5: i2c@11d00000 {
 			compatible = "mediatek,mt8195-i2c",
 				     "mediatek,mt8192-i2c";
@@ -2737,6 +2757,20 @@ dither0: dither@1c007000 {
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x7000 0x1000>;
 		};
 
+		dsi0: dsi@1c008000 {
+			compatible = "mediatek,mt8195-dsi", "mediatek,mt8183-dsi";
+			reg = <0 0x1c008000 0 0x1000>;
+			interrupts = <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			clocks = <&vdosys0 CLK_VDO0_DSI0>,
+				 <&vdosys0 CLK_VDO0_DSI0_DSI>,
+				 <&mipi_tx0>;
+			clock-names = "engine", "digital", "hs";
+			phys = <&mipi_tx0>;
+			phy-names = "dphy";
+			status = "disabled";
+		};
+
 		dsc0: dsc@1c009000 {
 			compatible = "mediatek,mt8195-disp-dsc";
 			reg = <0 0x1c009000 0 0x1000>;
@@ -2746,6 +2780,20 @@ dsc0: dsc@1c009000 {
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x9000 0x1000>;
 		};
 
+		dsi1: dsi@1c012000 {
+			compatible = "mediatek,mt8195-dsi", "mediatek,mt8183-dsi";
+			reg = <0 0x1c012000 0 0x1000>;
+			interrupts = <GIC_SPI 654 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			clocks = <&vdosys0 CLK_VDO0_DSI1>,
+				 <&vdosys0 CLK_VDO0_DSI1_DSI>,
+				 <&mipi_tx1>;
+			clock-names = "engine", "digital", "hs";
+			phys = <&mipi_tx1>;
+			phy-names = "dphy";
+			status = "disabled";
+		};
+
 		merge0: merge@1c014000 {
 			compatible = "mediatek,mt8195-disp-merge";
 			reg = <0 0x1c014000 0 0x1000>;
-- 
2.39.2

