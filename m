Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B177819C6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjHSNn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHSNn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:43:56 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E80AA8;
        Sat, 19 Aug 2023 06:42:07 -0700 (PDT)
Received: from p200300ccff2bce001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2b:ce00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qXMDG-002nxv-Jd; Sat, 19 Aug 2023 15:41:58 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qXMDG-001ueM-0y;
        Sat, 19 Aug 2023 15:41:58 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, andreas@kemnade.info,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: omap4-embt2ws: enable 32K clock on WLAN
Date:   Sat, 19 Aug 2023 15:41:47 +0200
Message-Id: <20230819134147.456060-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819134147.456060-1-andreas@kemnade.info>
References: <20230819134147.456060-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLAN did only work if clock was left enabled by the original system,
so make it fully enable the needed resources itself.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
index ee86981b2e448..9ca540ef86265 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
@@ -69,6 +69,12 @@ unknown_supply: unknown-supply {
 		regulator-name = "unknown";
 	};
 
+	wl12xx_pwrseq: wl12xx-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&clk32kaudio>;
+		clock-names = "ext_clock";
+	};
+
        /* regulator for wl12xx on sdio2 */
 	wl12xx_vmmc: wl12xx-vmmc {
 		pinctrl-names = "default";
@@ -97,6 +103,11 @@ twl: pmic@48 {
 		interrupt-controller;
 		#interrupt-cells = <1>;
 
+		clk32kaudio: clk-32kaudio {
+			compatible = "ti,twl6032-clk32kaudio";
+			#clock-cells = <0>;
+		};
+
 		rtc {
 			compatible = "ti,twl4030-rtc";
 			interrupts = <11>;
@@ -316,6 +327,7 @@ &mmc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wl12xx_pins>;
 	vmmc-supply = <&wl12xx_vmmc>;
+	mmc-pwrseq = <&wl12xx_pwrseq>;
 	interrupts-extended = <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0x12e>;
 	non-removable;
-- 
2.39.2

