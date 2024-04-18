Return-Path: <linux-kernel+bounces-150093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5F38A9A50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6CE2842D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552AB15F411;
	Thu, 18 Apr 2024 12:45:07 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7C12FF75
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444306; cv=none; b=L/vMv7GvS/z5MJrK66bkP0RWw9KJX4rl3lnIQGfWPht9mpjhAkpEBagf0i3589FEE4+HxC00i2zEyqf8/a50AiaVXfzadNge0YV8IURo6Zk0NFax/aexw96UGMkN1QcsiIak+En5rPv5zgmz1wJiWtkPilaXom5i4i6eLD4k0bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444306; c=relaxed/simple;
	bh=BX//LDamhCsN5RO0/Ar3nYwJvwCqv29g1oqAqiuZ1x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=naOgrWkQQ1OWIyGoYlKS2OfAn1evPI5DmlD5IvlWK82h63C0GOJeIzSzS/1nurCh54528RL6pnskeaJW62yunLZp+fojzAQW3Jze62pWDZ2joc38/i/ZGWREA/9fqLqKHqEMAN+YGGiMPg3ENSg9dxdOwSuNVD9ePawTwyKiPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861917.versanet.de ([94.134.25.23] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxR8H-0006mk-Bn; Thu, 18 Apr 2024 14:44:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dsimic@manjaro.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2] arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
Date: Thu, 18 Apr 2024 14:44:45 +0200
Message-Id: <20240418124445.2360491-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The Jaguar SBC provides an M.2 slot connected to the pcie3 controller.
In contrast to a number of other boards the pcie-refclk is gpio-controlled,
so the necessary clock and is added to the list of pcie3 clocks.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
changes in v2:
- "an" M.2 slot (Dragan)
- pinctrl for refclk-en and reset pin (Quentin)
- don't repurpose the pcie30x4_pins pinctrl entry for only wake (Quentin)

 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 4076c92668ba..3407e777e97b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -72,6 +72,27 @@ led-1 {
 		};
 	};
 
+	/*
+	 * 100MHz reference clock for PCIe peripherals from PI6C557-05BLE
+	 * clock generator.
+	 * The clock output is gated via the OE pin on the clock generator.
+	 * This is modeled as a fixed-clock plus a gpio-gate-clock.
+	 */
+	pcie_refclk_gen: pcie-refclk-gen-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000000>;
+	};
+
+	pcie_refclk: pcie-refclk-clock {
+		compatible = "gpio-gate-clock";
+		clocks = <&pcie_refclk_gen>;
+		#clock-cells = <0>;
+		enable-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>; /* PCIE30X4_CLKREQN_M0 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie30x4_clkreqn_m0>;
+	};
+
 	pps {
 		compatible = "pps-gpio";
 		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
@@ -358,6 +379,30 @@ &pcie2x1l0 {
 	status = "okay";
 };
 
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	/*
+	 * The board has a gpio-controlled "pcie_refclk" generator,
+	 * so add it to the list of clocks.
+	 */
+	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
+		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
+		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
+		 <&pcie_refclk>;
+	clock-names = "aclk_mst", "aclk_slv",
+		      "aclk_dbi", "pclk",
+		      "aux", "pipe",
+		      "ref";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x4_waken_m0 &pcie30x4_perstn_m0>;
+	reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>; /* PCIE30X4_PERSTN_M0 */
+	vpcie3v3-supply = <&vcc3v3_mdot2>;
+	status = "okay";
+};
+
 &pinctrl {
 	emmc {
 		emmc_reset: emmc-reset {
@@ -376,6 +421,25 @@ led1_pin: led1-pin {
 			rockchip,pins = <1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	pcie30x4 {
+		pcie30x4_clkreqn_m0: pcie30x4-clkreqn-m0 {
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie30x4_perstn_m0: pcie30x4-perstn-m0 {
+			rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie30x4_waken_m0: pcie30x4-waken-m0 {
+			/*
+			 * pcie30x4_clkreqn_m0 is used by the refclk generator
+			 * pcie30x4_perstn_m0 is used as via the reset-gpio
+			 * So only pcie30x4_waken_m0 is used.
+			 */
+			rockchip,pins = <0 RK_PC7 12 &pcfg_pull_none>;
+		};
+	};
 };
 
 &saradc {
-- 
2.39.2


