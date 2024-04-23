Return-Path: <linux-kernel+bounces-155785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB78AF715
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2496D1F24995
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA0113FD79;
	Tue, 23 Apr 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c30lD9Mp"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86013DDB1;
	Tue, 23 Apr 2024 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899710; cv=none; b=DjPMVgDwnao8FhbOTAU1LcWxR+tstwMZMNpIev5eSIFDXpr2FOE0GL7WpEoa4cYqF+SSDm34RQWVJR1AIghkXGXp7jnvyBIsYkvhUqya7sXFpKRDRVwL7gMj4omz5Xtu1lSxo7wYvWNr31OUetMf2zhPMu4Jv8j4r7hGbaJ11nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899710; c=relaxed/simple;
	bh=R628G8zQMojH79aICvGqCZDzjRLX8Kqkqav9c0XP5PM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HP2YzMciKtrCYcHoZuz6YjNhF8cFmUPrQK9ObvP6bFUT3zgArC8PXkz153MX25bLKvbpFrTy2w8bU6lRiUPu6LglnqC1cutxpuF6gJK36bs49D2R11OqffcVmvhRjtObwRXaTtR2JZMEn1lkIY9IoJaVgP0eBG59hVImJnTZiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c30lD9Mp; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7C01BC0003DE;
	Tue, 23 Apr 2024 12:15:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7C01BC0003DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713899707;
	bh=R628G8zQMojH79aICvGqCZDzjRLX8Kqkqav9c0XP5PM=;
	h=From:To:Cc:Subject:Date:From;
	b=c30lD9MpeqzAc84Bwe+J6/nnPGRqbbkxMZ8xdDdxOJ1+njirzR++TZcvLEoCdigZL
	 yWQpguIszDZ1/0sH68BiUJ5HhElX2cTphMXY1vkliUocww0wuhPuP8Xp88NakMcQ7G
	 6Ukc464UouNEfxejxOBD5RZoMhr5JmfMNg37dpn8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 86D6B18041CAC4;
	Tue, 23 Apr 2024 12:15:05 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: andrew@lunn.ch,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Nick Hawkins <nick.hawkins@hpe.com>,
	Michal Simek <michal.simek@amd.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Paul Barker <paul.barker@sancloud.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] arm: dts: bcm2711: Describe Ethernet LEDs
Date: Tue, 23 Apr 2024 12:14:55 -0700
Message-Id: <20240423191500.1443636-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the Ethernet LEDs for the Raspberry Pi 4 model B board as well
as the Raspberry Pi 4 CM board. The Raspberry Pi 400 board does not
include RJ45 connector LEDs so the 'leds' node is deleted accordingly.

The Ethernet PHY LEDs are numbered in the PHY package/pin list from LED1
through LED4, however their address within the LED registers function
selector is 0-indexed.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v3:

- explain LED numbering and add comments
- rename individual LED DT nodes to led@<N>

Changes in v2:

- added function = LED_FUNCTION_LAN
- rebased against latest tree

 .../arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts | 22 +++++++++++++++++
 .../arm/boot/dts/broadcom/bcm2711-rpi-400.dts |  1 +
 .../boot/dts/broadcom/bcm2711-rpi-cm4-io.dts  | 24 +++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
index cfc8cb5e10ba..353bb50ce542 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
@@ -5,6 +5,7 @@
 #include "bcm283x-rpi-led-deprecated.dtsi"
 #include "bcm283x-rpi-usb-peripheral.dtsi"
 #include "bcm283x-rpi-wifi-bt.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
@@ -204,6 +205,27 @@ &genet_mdio {
 	phy1: ethernet-phy@1 {
 		/* No PHY interrupt */
 		reg = <0x1>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* LED1 */
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			/* LED2 */
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_AMBER>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts b/arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts
index 5a2869a18bd5..ca9be91b4f36 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts
+++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts
@@ -30,6 +30,7 @@ &expgpio {
 
 &genet_mdio {
 	clock-frequency = <1950000>;
+	/delete-node/ leds;
 };
 
 &led_pwr {
diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts b/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
index 7c6a5bdf48aa..6bc77dd48c0d 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
+++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
+#include <dt-bindings/leds/common.h>
 #include "bcm2711-rpi-cm4.dtsi"
 #include "bcm283x-rpi-led-deprecated.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
@@ -110,6 +111,29 @@ rtc@51 {
 	};
 };
 
+&phy1 {
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* LED2 */
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		/* LED3 */
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+	};
+};
+
 &led_act {
 	gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
 };
-- 
2.34.1


