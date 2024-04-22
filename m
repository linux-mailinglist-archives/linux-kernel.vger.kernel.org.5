Return-Path: <linux-kernel+bounces-153723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575738AD236
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCDD1F21AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC7154451;
	Mon, 22 Apr 2024 16:39:59 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59188153BF2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803999; cv=none; b=YTr5wIlQlbTUSpoeWlaVdAZxitM+3i+IwD7+X7OeDvl6bZEOezOt5teDcHq+eWqMn+IfYx1+oJbhlPhHgnnto6v5ynVe7zuJslidlcOoQQcMkxSpF8jC09Xhyn/jJ7F/wEKZ8qX37sQ3BBfCZy4mQSHNGlMn7ZvhvFGK00ZL4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803999; c=relaxed/simple;
	bh=kZNavWYYidN/BDo0KlYmAF2Oswc+CdDFe5fZnkY1NZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijBLcGDVYe7EF38SmfKpBbQ+Y4XhHavAMnfx6kLcTArZMoDr4K6kkc4rEBlOWVzsv7AQBB5ClS/Jisx2+3OE/cAABJmrsVC/ihawNE+JCjIr0qlFBQCnTNeKcCQ0xK/aQ/b/8kqhLBfuSRtwdybgjCR5yw3gjt3oqmg8bLSZDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d85.versanet.de ([94.134.29.133] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rywhu-0004gq-B1; Mon, 22 Apr 2024 18:39:54 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 2/3] arm64: dts: rockchip: add usb-id extcon on rk3588 tiger
Date: Mon, 22 Apr 2024 18:39:50 +0200
Message-Id: <20240422163951.2604273-3-heiko@sntech.de>
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

The Q7 standard specifies a usb-id pin on the connector to distiuish
between host and device mode. Model this via the usb-id extcon binding.

While the pin is part of the Q7 standard, so part of the module, the
extcon stays disabled in the som dtsi and will only be enabled in a
baseboard using it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 4984e36a8c2d..cafb40283882 100644
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


