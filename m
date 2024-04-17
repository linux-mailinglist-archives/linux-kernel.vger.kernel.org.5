Return-Path: <linux-kernel+bounces-148664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499838A85C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04208282000
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E421411E4;
	Wed, 17 Apr 2024 14:16:52 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D1140397
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363411; cv=none; b=WWA/X8M6wV2V+j7XccPLR7VGi92zDi0WpJPul+i+YeUxOA2Lg/acqxrxr4FPvB/wTUn7r7mAP7OJVKD8joNnKdt8EB9OK6WUdF328ghv9Naq6axh1JkMOVW8WlD0iaz0Cq4m/f1XTuUKQyPiiY3lO32EYQlnRCFmsVTy9knvvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363411; c=relaxed/simple;
	bh=osq/0yl1rbJ03d+zBaWyiwuurKQIcrxcS59wyj56nQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sL/kWrTSN7SPJJ8lUiQ9dW2TVSwTJzVKwBR+QYgrRIUIR9YdXtmTNtkLX9iV+TLW3B49Tsda+8x1yOCGPspaRtcYC8wK3DmmXtf/Tf+qBsn+7iL8eTt+eZlmRV75eybRmE+EMCDvg3cI8meEy+sQfO1LTxYB/9xsVzqP0qLE5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c3.versanet.de ([94.134.22.195] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rx65c-0003sM-KV; Wed, 17 Apr 2024 16:16:44 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
Date: Wed, 17 Apr 2024 16:16:42 +0200
Message-Id: <20240417141642.2243193-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The Jaguar SBC provides a M.2 slot connected to the pcie3 controller.
In contrast to a number of other boards the pcie-refclk is gpio-controlled,
so the necessary clock is added to the list of pcie3 clocks.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 5002105dc78e..908fbabd8b00 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -72,6 +72,25 @@ led-1 {
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
+	};
+
 	pps {
 		compatible = "pps-gpio";
 		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
@@ -466,6 +485,40 @@ &pcie2x1l0 {
 	status = "okay";
 };
 
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie30x4m0_pins {
+	/*
+	 * pcie30x4_clkreqn_m0 is used by the refclk generator
+	 * pcie30x4_perstn_m0 is used as via the reset-gpio
+	 */
+	rockchip,pins =
+		/* pcie30x4_waken_m0 */
+		<0 RK_PC7 12 &pcfg_pull_none>;
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
+	pinctrl-0 = <&pcie30x4m0_pins>;
+	reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>; /* PCIE30X4_PERSTN_M0 */
+	vpcie3v3-supply = <&vcc3v3_mdot2>;
+	status = "okay";
+};
+
 &pinctrl {
 	emmc {
 		emmc_reset: emmc-reset {
-- 
2.39.2


