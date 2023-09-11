Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E5079C3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbjILDQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242458AbjILDQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:16:00 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56F017A9DF;
        Mon, 11 Sep 2023 18:56:24 -0700 (PDT)
Received: from p200300ccff36fa001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff36:fa00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qfpAE-003cro-KU; Tue, 12 Sep 2023 00:13:50 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qfpAE-006ECz-0p;
        Tue, 12 Sep 2023 00:13:50 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lee@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        mturquette@baylibre.com, sboyd@kernel.org, andreas@kemnade.info,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 5/5] ARM: dts: omap4-embt2ws: enable 32K clock on WLAN
Date:   Tue, 12 Sep 2023 00:13:46 +0200
Message-Id: <20230911221346.1484543-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911221346.1484543-1-andreas@kemnade.info>
References: <20230911221346.1484543-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLAN did only work if clock was left enabled by the original system,
so make it fully enable the needed resources itself.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
index ee86981b2e448..9d2f2d8639496 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
@@ -69,6 +69,12 @@ unknown_supply: unknown-supply {
 		regulator-name = "unknown";
 	};
 
+	wl12xx_pwrseq: wl12xx-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&twl 1>;
+		clock-names = "ext_clock";
+	};
+
        /* regulator for wl12xx on sdio2 */
 	wl12xx_vmmc: wl12xx-vmmc {
 		pinctrl-names = "default";
@@ -92,6 +98,7 @@ &i2c1 {
 	twl: pmic@48 {
 		compatible = "ti,twl6032";
 		reg = <0x48>;
+		#clock-cells = <1>;
 		/* IRQ# = 7 */
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
 		interrupt-controller;
@@ -316,6 +323,7 @@ &mmc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wl12xx_pins>;
 	vmmc-supply = <&wl12xx_vmmc>;
+	mmc-pwrseq = <&wl12xx_pwrseq>;
 	interrupts-extended = <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0x12e>;
 	non-removable;
-- 
2.39.2

