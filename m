Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96EA772E93
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjHGTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjHGTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:20:42 -0400
Received: from out-84.mta1.migadu.com (out-84.mta1.migadu.com [IPv6:2001:41d0:203:375::54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7707F10F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:20:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691436036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3MO64bm8DFoP+FtMNEmWQlPXqTMO4IBSAv4wntQ0uL4=;
        b=vDj1LhgzTqUvdYIJ+GyYNE/S8OovxIjbJAVnxEAJfbetB2Bs8LgZrUgjIh5e9wb2/CSec/
        T6ClYlSomL585prfZpsCyjU1Yf/RigIoIk+BSNJa2xVEEKj2i7zjsCd5wgKlFmVeLFL16c
        Pv6WpVr/YpPZFiTE4Am8W7lEnPOghWTv1sxC+jaamcOwz9wwpAdnRvdIvEPjV2woQ7R6y5
        aJfWJlt+sUyrZhv1yYqMACRb618Kmg5tbsYnLkserZbGzBHulv4rkNDXMUvmX90psWhoEe
        ViGgRiWSf+46Dgz+GRls+3yOA/18n9rNoU36Av4tPtBbttJEViMFeW1B/VphVA==
From:   John Watts <contact@jookia.org>
To:     linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        John Watts <contact@jookia.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] riscv: dts: allwinner: d1: Add CAN controller nodes
Date:   Tue,  8 Aug 2023 05:19:52 +1000
Message-ID: <20230807191952.2019208-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner D1, T113 provide two CAN controllers that are variants
of the R40 controller.

I have tested support for these controllers on two boards:

- A Lichee Panel RV 86 Panel running a D1 chip
- A Mango Pi MQ Dual running a T113-s3 chip

Both of these fully support both CAN controllers.

Signed-off-by: John Watts <contact@jookia.org>
---
Changes in v3:
- Set default pinctrl for can controller
- Moved can nodes to proper location
- Moved can pins to proper location

 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index d59b4acf183a..24f2e70d5886 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -52,6 +52,18 @@ pio: pinctrl@2000000 {
 			#gpio-cells = <3>;
 			#interrupt-cells = <3>;
 
+			/omit-if-no-ref/
+			can0_pins: can0-pins {
+				pins = "PB2", "PB3";
+				function = "can0";
+			};
+
+			/omit-if-no-ref/
+			can1_pins: can1-pins {
+				pins = "PB4", "PB5";
+				function = "can1";
+			};
+
 			/omit-if-no-ref/
 			clk_pg11_pin: clk-pg11-pin {
 				pins = "PG11";
@@ -356,6 +368,28 @@ i2c3: i2c@2502c00 {
 			#size-cells = <0>;
 		};
 
+		can0: can@2504000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&can0_pins>;
+			compatible = "allwinner,sun20i-d1-can";
+			reg = <0x02504000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(21) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CAN0>;
+			resets = <&ccu RST_BUS_CAN0>;
+			status = "disabled";
+		};
+
+		can1: can@2504400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&can1_pins>;
+			compatible = "allwinner,sun20i-d1-can";
+			reg = <0x02504400 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(22) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CAN1>;
+			resets = <&ccu RST_BUS_CAN1>;
+			status = "disabled";
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun20i-d1-system-control";
 			reg = <0x3000000 0x1000>;
-- 
2.41.0

