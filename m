Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C811D759769
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGSNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjGSNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:53:00 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAB212C;
        Wed, 19 Jul 2023 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=0twBvll8BbpMn27wcaLT/e5BA6uXX2lFysVkum50hag=; b=D
        XLdQY+7WOtLBKPbPUq2vb7JeHNex8Je8BWXYXzJz/YifO4f4tSZxNK75HhZ3KOCr3hia36vSLrgry
        Jsg0EOJ8LlG48VhnZJQU7eWFhhekV+EkbcRzk86UxYnGZ8unk9l6IAKIFcjNMqc6QDjTkK89dLQrB
        pkVI88XuK4du6Lbo=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:60540 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qM7bc-0003ut-LY; Wed, 19 Jul 2023 09:52:41 -0400
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
Date:   Wed, 19 Jul 2023 09:52:37 -0400
Message-Id: <20230719135237.2986984-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3] arm64: dts: imx8mn-var-som-symphony: update USB OTG for new board versions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

USB OTG is currently not working for new versions of the Variscite
Symphony EVK and imx8mn nano SOM (versions >= 1.4a).

The PTN5150 circuitry on newer versions of the Symphony EVK board has
a non-standard configuration in which the PTN5150 IRQ pin is left
unconnected, and the PTN5150 ID pin is connected to GPIO1_IO11. This
requires changes to the ptn5150 driver to support this new mode.
Variscite have indicated their intention to submit those changes
upstream.

In the meantime, import device tree changes from linux-5.15 branch of
varigit repos to at least make the USB OTG port operate correctly in
host mode.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../dts/freescale/imx8mn-var-som-symphony.dts | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
index 406a711486da..a7a57442cb81 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
+ * Supports Symphony evaluation board versions >= 1.4a.
+ *
  * Copyright 2019-2020 Variscite Ltd.
  * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
  */
 
 /dts-v1/;
 
+#include <dt-bindings/usb/pd.h>
 #include "imx8mn-var-som.dtsi"
 
 / {
@@ -100,14 +103,26 @@ enet-sel-hog {
 		};
 	};
 
+	/*
+	 * For Symphony board version <= 1.4, the PTN5150 IRQ pin is connected
+	 * to GPIO1_IO11 on the SoM (R106 present, R132 absent). From Symphony
+	 * board version >= 1.4a, the PTN5150 ID pin is connected to GPIO1_IO11
+	 * on the SoM (R106 absent, R132 present).
+	 */
 	extcon_usbotg1: typec@3d {
 		compatible = "nxp,ptn5150";
 		reg = <0x3d>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ptn5150>;
 		status = "okay";
+
+		port {
+			typec1_dr_sw: endpoint {
+				remote-endpoint = <&usb1_drd_sw>;
+			};
+		};
 	};
 };
 
@@ -148,8 +163,21 @@ &uart3 {
 };
 
 &usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
 	disable-over-current;
-	extcon = <&extcon_usbotg1>, <&extcon_usbotg1>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
 };
 
 &iomuxc {

base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
prerequisite-patch-id: 45559b1f2aca74c1c733cc2d61db7b48b1b9594a
-- 
2.30.2

