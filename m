Return-Path: <linux-kernel+bounces-154182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE078AD8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BB91F21D66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56A0156962;
	Mon, 22 Apr 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="k/4+hvht"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52415533B;
	Mon, 22 Apr 2024 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713827301; cv=none; b=bO0ptuI/vGfemo3K30tPc8M6kEtIL3pWHZjLob2VNlAy8VyhPJqvsrtEl8MTsS0n2nlKleiaxDDvLxaGew5ypby1YDMTNouWI5vzlgUNGmw/TeR3AYRHK8qQqeSEEbt9hn8Rvd9zrVEw3P9eRHEUpnSBAOzGNCAsBONIqZyEmes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713827301; c=relaxed/simple;
	bh=N8sF8ZSqduWbSraukBwpGmeZkj5I/W00h30uXF76edU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=srS4o8Z6pFyjpfxJhKvOegtb2EZjxNYeuco07N/enXYyYHQPVXbKH9+g0unOVAhTXn/hWsGi2mmW03exdKAwEw7QfHsxNfNtTTQdefVYvQKDorPXd7VgCQtRZQBAhWIltIlMAZepG7n0fy/jUlhTt8WUE+um8pH1ewWd1d6Xk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=k/4+hvht; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 36B9CC003AA2;
	Mon, 22 Apr 2024 16:08:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 36B9CC003AA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713827293;
	bh=N8sF8ZSqduWbSraukBwpGmeZkj5I/W00h30uXF76edU=;
	h=From:To:Cc:Subject:Date:From;
	b=k/4+hvht5ST07Nx8BRhRmYsApq2rtYStYenV2Xr5DguA8UU+nfeqHk+S0oepokLKm
	 BX1p1fjCZEmi8MkcyW7CuY6/5XUu4E3uKgzoJuD3of2ZjXi45Fqe9d5gW2KmqoT9sA
	 rHzj4APGvbBOCoRl/C1fbnvreZp4WS1mRg/PN0pE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 3C80C18041CAC4;
	Mon, 22 Apr 2024 16:08:11 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: andrew@lunn.ch,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Baruch Siach <baruch@tkos.co.il>,
	Shawn Guo <shawnguo@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Paul Barker <paul.barker@sancloud.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] arm: dts: bcm2711: Describe Ethernet LEDs
Date: Mon, 22 Apr 2024 16:08:09 -0700
Message-Id: <20240422230811.1284092-1-florian.fainelli@broadcom.com>
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

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- added "function = LED_FUNCTION_LAN"

 .../arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts | 20 +++++++++++++++++
 .../arm/boot/dts/broadcom/bcm2711-rpi-400.dts |  1 +
 .../boot/dts/broadcom/bcm2711-rpi-cm4-io.dts  | 22 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
index cfc8cb5e10ba..7a0f495ff726 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
@@ -5,6 +5,7 @@
 #include "bcm283x-rpi-led-deprecated.dtsi"
 #include "bcm283x-rpi-usb-peripheral.dtsi"
 #include "bcm283x-rpi-wifi-bt.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
@@ -204,6 +205,25 @@ &genet_mdio {
 	phy1: ethernet-phy@1 {
 		/* No PHY interrupt */
 		reg = <0x1>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			leds@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			leds@1 {
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
index 7c6a5bdf48aa..76cb20373095 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
+++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
+#include <dt-bindings/leds/common.h>
 #include "bcm2711-rpi-cm4.dtsi"
 #include "bcm283x-rpi-led-deprecated.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
@@ -110,6 +111,27 @@ rtc@51 {
 	};
 };
 
+&phy1 {
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		leds@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		leds@2 {
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


