Return-Path: <linux-kernel+bounces-150789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20CC8AA496
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680941F21762
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8F3199E99;
	Thu, 18 Apr 2024 21:03:43 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7148194C9F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474222; cv=none; b=j5dS8fEvw+EEJTjQ6ESYtR/vikiI+ZlZyQGI4GvWgl+zBmQ+Jso/3f3oDMFF7wymVEAXJ42oUcqwP1vQmb50S3HIaaxlURHPI9MKlB2ME7IU8EBgZUucNuj/EkYUv0epkx8gyi0Y7RKK1eqUiDj/AKTwDkiIJFJt5CVBlbbbfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474222; c=relaxed/simple;
	bh=j1uZdwcZI6uNJtnE/ulhKwd0QZR8d3M1igG4/se5Now=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohSvkMwoS5zXmjj8bOMHo1udywl+mVbG7R+c5WQEpl6O5y7R07u/FSdF/AI/6SFKfXPzjiYSLYWRGVh+M01PIf7FzyRFpjbH6O9efiGYBWTSLv6XeezO0GLW2QosBWZt8Eik6WmgMUNiM7ejNIzGwU1cwvELmWWzn4H2WeUTyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861917.versanet.de ([94.134.25.23] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxYut-0002jJ-6o; Thu, 18 Apr 2024 23:03:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/2] arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou
Date: Thu, 18 Apr 2024 23:03:32 +0200
Message-Id: <20240418210332.2394871-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240418210332.2394871-1-heiko@sntech.de>
References: <20240418210332.2394871-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Apart from the host-only usb3 controller (host2) the rk3588 also provides
two dual-role controllers. On the Tiger-Haikou combination these are
connected to the lower usb3-host port in host-only mode and the micro-usb3
port for dual-role operation.

Add the necessary controllers, phys and usb-id extcon to the Tiger-Haikou
board. The Q7 standard defines the pin as usb-id, but it will only ever
get used if the baseboard actually provides an OTG port. So the extcon
stays disabled in the dtsi and only gets enabled in the haikou dts.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 58 +++++++++++++++++++
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 15 +++++
 2 files changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index 214f8258af68..d6e30d5697bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -113,6 +113,16 @@ vcc5v0_baseboard: vcc5v0-baseboard-regulator {
 		vin-supply = <&dc_12v>;
 	};
 
+	vcc5v0_otg: vcc5v0-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		regulator-name = "vcc5v0_otg";
+		regulator-always-on;
+	};
+
 	vcc5v0_usb: vcc5v0-usb-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
@@ -137,6 +147,10 @@ &combphy2_psu {
 	status = "okay";
 };
 
+&extcon_usb3 {
+	status = "okay";
+};
+
 &gmac0 {
 	status = "okay";
 };
@@ -199,6 +213,13 @@ haikou_keys_pin: haikou-keys-pin {
 				<3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	usb2 {
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins =
+			  <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &sdmmc {
@@ -214,6 +235,23 @@ &sdmmc {
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	phy-supply = <&vcc5v0_otg>;
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -237,6 +275,13 @@ &uart2 {
 
 &uart5 {
 	rts-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
+
+&usbdp_phy1 {
 	status = "okay";
 };
 
@@ -250,6 +295,19 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+/* host0_xhci on Q7_USB_P1, usb3-otg port */
+&usb_host0_xhci {
+	dr_mode = "otg";
+	extcon = <&extcon_usb3>;
+	status = "okay";
+};
+
+/* host1_xhci on Q7_USB_P0, lower usb3 port */
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
 /* host1 on Q7_USB_P3, usb2 port */
 &usb_host1_ehci {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 72fe696b0034..95b7d7784a37 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -23,6 +23,14 @@ emmc_pwrseq: emmc-pwrseq {
 		reset-gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
 	};
 
+	extcon_usb3: extcon-usb3 {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_id>;
+		status = "disabled";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -327,6 +335,13 @@ module_led_pin: module-led-pin {
 			rockchip,pins = <1 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb3 {
+		usb3_id: usb3-id {
+			rockchip,pins =
+			  <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &saradc {
-- 
2.39.2


