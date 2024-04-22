Return-Path: <linux-kernel+bounces-153460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786DD8ACE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B302813F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5507814F9D9;
	Mon, 22 Apr 2024 13:35:19 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FD746E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792918; cv=none; b=CqfAZiR8mfH01WIVYR9ZjUmoYR1hZ33n+VC8qahZF4hZVzkAxO7hrgD0ZFEWrB1hWUdtt2Ufcqafb0HLVyK27MNT26vkrbz9CLOfGUVFNQ9uiXjpKXIkI5hsLXEXq+P3V3VpIezF0RBFRpL95IkeIqcDJaEDEfeDMtIzRpiFlkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792918; c=relaxed/simple;
	bh=/y9qW4hIix5cjXrfGbOv7+ow7SQkwW7cRxbCcjFGvxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ShsXMByOFyY8w2Ti+++tJfauzsP8dDWVYhVPi2Iak1LmiOiAmvzZ7MVcX4IY92y71r2zKs+5V1ZqDPHovLhrDkMF8EDFV3sWKvTh5GGjlfrxt7jMDg0r2dNN5JZ187DGd2ipsVGMwPkW872Aokh3Nf4yz6UCstCXsJfXjbwpGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d85.versanet.de ([94.134.29.133] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rytp3-0003PX-SH; Mon, 22 Apr 2024 15:35:05 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3] arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
Date: Mon, 22 Apr 2024 15:35:02 +0200
Message-Id: <20240422133502.2592975-1-heiko@sntech.de>
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
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
changes in v3:
- drop unnecessary pinctrl comment (Quentin)
- add Quentin's review

changes in v2:
- "an" M.2 slot (Dragan)
- pinctrl for refclk-en and reset pin (Quentin)
- don't repurpose the pcie30x4_pins pinctrl entry for only wake (Quentin)

 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 4076c92668ba..0ad53d7768a3 100644
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
@@ -376,6 +421,20 @@ led1_pin: led1-pin {
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
+			rockchip,pins = <0 RK_PC7 12 &pcfg_pull_none>;
+		};
+	};
 };
 
 &saradc {
-- 
2.39.2


