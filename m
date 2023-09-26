Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A087AF55E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjIZUiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjIZUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:38:10 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5E1126;
        Tue, 26 Sep 2023 13:38:04 -0700 (PDT)
Received: from p200300ccff2a5b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2a:5b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qlEoY-004D5A-SA; Tue, 26 Sep 2023 22:37:50 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qlEoY-008tVV-0Z;
        Tue, 26 Sep 2023 22:37:50 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        jean-baptiste.maneyrol@tdk.com, andreas@kemnade.info,
        chenhuiz@axis.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: dts: omap: omap4-embt2ws: Add IMU at control unit
Date:   Tue, 26 Sep 2023 22:37:39 +0200
Message-Id: <20230926203739.2119963-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926203739.2119963-1-andreas@kemnade.info>
References: <20230926203739.2119963-1-andreas@kemnade.info>
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
index cd4f858d846ab..0cc66e158a8d5 100644
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
 
+	mpu9150_pins: pinmux_mpu9150-pins {
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

