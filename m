Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E2B7ACC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjIXW0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIXW01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:26:27 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40AD83;
        Sun, 24 Sep 2023 15:26:19 -0700 (PDT)
Received: from p200300ccff1ebc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff1e:bc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qkXYB-00492H-83; Mon, 25 Sep 2023 00:26:02 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qkXYA-008YN6-1b;
        Mon, 25 Sep 2023 00:26:02 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        jean-baptiste.maneyrol@tdk.com, chenhuiz@axis.com,
        andreas@kemnade.info, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: omap: omap4-embt2ws: Add IMU at control unit
Date:   Mon, 25 Sep 2023 00:25:59 +0200
Message-Id: <20230924222559.2038721-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230924222559.2038721-1-andreas@kemnade.info>
References: <20230924222559.2038721-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add also the level-shifter flag to avoid probe failure in magnetometer
probe.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../boot/dts/ti/omap/omap4-epson-embt2ws.dts    | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
index cd4f858d846ab..0e6b050d588ac 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
@@ -391,7 +391,16 @@ tlv320aic3x: codec@18 {
 		reset-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
 	};
 
-	/* TODO: mpu9150 at control unit, seems to require quirks */
+	mpu9150: imu@68 {
+		compatible = "invensense,mpu9150";
+		reg = <0x68>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&mpu9150_pins>;
+		interrupt-parent = <&gpio2>;
+		interrupt = <7 IRQ_TYPE_LEVEL_HIGH>;
+		invensense,level-shifter;
+	};
 };
 
 &keypad {
@@ -530,6 +539,12 @@ OMAP4_IOPAD(0x0fc, PIN_INPUT | MUX_MODE0)       /* abe_mcbsp2_fsx */
 		>;
 	};
 
+	mpu9150_pins: pinmux_mpu9150_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x5e, PIN_INPUT_PULLUP | MUX_MODE3)
+		>;
+	};
+
 	mpu9150h_pins: pinmux-mpu9150h-pins {
 		pinctrl-single,pins = <
 			OMAP4_IOPAD(0x76, PIN_INPUT_PULLUP | MUX_MODE3)
-- 
2.39.2

