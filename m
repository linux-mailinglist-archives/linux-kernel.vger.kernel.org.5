Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718E47E44BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbjKGP4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343759AbjKGP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:56:19 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3DB4EEC;
        Tue,  7 Nov 2023 07:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=r0TYUpnREGJ0KanYJfwzlHomepGsTlvaq5o9zs4sWSs=; b=vdwCz6yQyVDp/gzLzzMkGyqrBP
        FXNkjbLi1mhe3jlBKl24nPernItP1XoDYFZIIwicL1eL5IBUF/nkDS2YFX9OxzFnHa5HO5Q8m/Mf7
        j8Wdf9LV24O7zAtE0zWgNCPsoUZWfjCXfsQdSE5v3TzCRql+QZHtUTFoMhcvEaqBmJMs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41044 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r0OLi-0007bH-VP; Tue, 07 Nov 2023 10:50:43 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue,  7 Nov 2023 10:50:40 -0500
Message-Id: <20231107155040.1644169-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2] arm64: dts: imx8mn-var-som-symphony: add vcc supply for PCA9534
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The following warning is shown when probing device:

    pca953x 1-0020: supply vcc not found, using dummy regulator

Define a new fixed 3.3v regulator for carrier board peripherals,
enabled by mosfet switch Q2 after the SOM_3V3 supply rises (no software
control).

Add this new regulator as vcc supply to the PCA9534 to silence the warning.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Changes for V2:
- add peripherals regulator and update commit message for Q2 mosfet.

 .../boot/dts/freescale/imx8mn-var-som-symphony.dts     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
index a7a57442cb81..a6b94d1957c9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
@@ -57,6 +57,15 @@ led {
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	/* Peripherals supply, enabled by Q2 after SOM_3V3 rises. */
+	reg_per_3v3: regulator-peripheral-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "per_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &ethphy {
@@ -79,6 +88,7 @@ pca9534: gpio@20 {
 		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 		#gpio-cells = <2>;
 		wakeup-source;
+		vcc-supply = <&reg_per_3v3>;
 
 		/* USB 3.0 OTG (usbotg1) / SATA port switch, set to USB 3.0 */
 		usb3-sata-sel-hog {

base-commit: be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
-- 
2.39.2

