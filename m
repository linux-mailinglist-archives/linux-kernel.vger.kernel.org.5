Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E297F48AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjKVOPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjKVOOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:14:54 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92E497;
        Wed, 22 Nov 2023 06:14:50 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC234E0007;
        Wed, 22 Nov 2023 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700662489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkdHkQjq3zn+cr3h8O6hniqwb4wqvOUf1cWWpN7DY+s=;
        b=eMuKTIP+3smNdNoRBrZEeMbsJjG0CWGQ6wjhR+xyz4LO5SxAm7+b5yxQUdS4igDJG7Obr+
        2NAwGIeKs3kv/ZY0/2Pdt1q4pt1CLSd9LC7vT79bPx+cKN3wYO/r2k9UT+TyHxbl/FR+a+
        3mRk4Jq20XyzteKkuKtwW01wqj2PBbx/7R7z1Kl6dpEqto5LNLlePHRT4X72pQgSYPmfF+
        hmGgnMMXWWDURMHrx+N6d4At2kFO4iZ8xZil4o0hVCvPYKMvrUQIl9Um8ks+yMMfoNhc7+
        2F+GtkLXKV2t7s+nQLScgQq5VFksionhGslwoB6qzTE+mTxipnS3pXxw8cAePA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v7 4/7] ARM: dts: sun8i: v3s: Add support for the ISP
Date:   Wed, 22 Nov 2023 15:14:22 +0100
Message-ID: <20231122141426.329694-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122141426.329694-1-paul.kocialkowski@bootlin.com>
References: <20231122141426.329694-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V3s (and related platforms) come with an instance of the A31 ISP.
Even though it is very close to the A31 ISP, it is not exactly
register-compatible and a dedicated compatible only is used as a
result.

Just like most other blocks of the camera pipeline, the ISP uses
the common CSI bus, module and ram clock as well as reset.

A port connection to the ISP is added to CSI0 for convenience since
CSI0 serves for MIPI CSI-2 interface support, which is likely to
receive raw data that will need to be processed by the ISP to produce
a final image.

The interconnects property is used to inherit the proper DMA offset.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi b/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
index d57612023aa4..1a1dcd36cba4 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
@@ -645,6 +645,14 @@ csi0_in_mipi_csi2: endpoint {
 						remote-endpoint = <&mipi_csi2_out_csi0>;
 					};
 				};
+
+				port@2 {
+					reg = <2>;
+
+					csi0_out_isp: endpoint {
+						remote-endpoint = <&isp_in_csi0>;
+					};
+				};
 			};
 		};
 
@@ -703,5 +711,32 @@ csi1: camera@1cb4000 {
 			resets = <&ccu RST_BUS_CSI>;
 			status = "disabled";
 		};
+
+		isp: isp@1cb8000 {
+			compatible = "allwinner,sun8i-v3s-isp";
+			reg = <0x01cb8000 0x1000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI1_SCLK>,
+				 <&ccu CLK_DRAM_CSI>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CSI>;
+			interconnects = <&mbus 5>;
+			interconnect-names = "dma-mem";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					isp_in_csi0: endpoint {
+						remote-endpoint = <&csi0_out_isp>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
2.42.1

