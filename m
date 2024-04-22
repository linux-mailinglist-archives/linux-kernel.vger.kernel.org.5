Return-Path: <linux-kernel+bounces-153724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A972B8AD238
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA6D1C20CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5E015381F;
	Mon, 22 Apr 2024 16:40:00 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913D15382E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804000; cv=none; b=ZbBLclkjomCQhni9NjjFpaQ3N4iRZ4Mwh5frSo71ym9cGen+L9vYQmsEQe10b+xNrfi9n2XfBXabpSIECxedJKCc26tq0WqNTjbelnWgzRkrPAC4w3NNsjbLrFc2W5/u8L9ilnGu50s5Y/yAR0lYwoJj4PDd4o29spi7npekhY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804000; c=relaxed/simple;
	bh=eTJzE4ddILeETJjvUuFFbdH2Scx/iVqDMflf2dR101M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cC8lCXL9CInc4YNSMmAm+2QaxJplv1BOj8UoWm52UNIIgv8jNenmeoLzHHkEuyNTnT/6zMqI38zAZXMg9YxFwSr6d3BDIQFwKVEN29QYCYm7IdonUfI5/a8Sn74vddCThR/ooYDimzFTM70yfagHEM8OkQqcrbB2qgAc1qGyIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d85.versanet.de ([94.134.29.133] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rywhu-0004gq-MA; Mon, 22 Apr 2024 18:39:54 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou
Date: Mon, 22 Apr 2024 18:39:51 +0200
Message-Id: <20240422163951.2604273-4-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422163951.2604273-1-heiko@sntech.de>
References: <20240422163951.2604273-1-heiko@sntech.de>
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

Add the necessary controllers, phys to the Tiger-Haikou board and enable
the usb-id extcon.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index 2aa43e7430e5..52695b6c113a 100644
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
@@ -236,6 +274,13 @@ &uart2 {
 
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
 
@@ -249,6 +294,19 @@ &usb_host0_ohci {
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
-- 
2.39.2


