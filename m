Return-Path: <linux-kernel+bounces-52768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247D849C78
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD504B27AB3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A922EF0;
	Mon,  5 Feb 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/AEeLFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26DC2C6BD;
	Mon,  5 Feb 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141564; cv=none; b=H5ATyzKmr5vDhhaI73LkMmZStLXdRd7PAic73fWTZcP5lczJHV/APJO5te+iA+YOCerP0HIJPmxtyWs2ZtxDFpsZ+6hp3bXG+emenYkowJ0Iwe5AzddJtZcUk1l/+6wnRmW5f6HouFqCAqJ7goY/95CnJyztA6nTZO06kkGHRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141564; c=relaxed/simple;
	bh=JEgggokwb2If7xWTrfi//S5h0c1XCgpyqpnsTwc0H+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ujWKqAyjmXg6kQa2Mi2y10y558DgPmBHW4XFW09K+ushS6P+5z4KleeH+PPjdH9QkK0s8i8+JAgaO826ePSCSm1MKjz4uiOHzKF3Loe76OUa0n+BGuJi+NuZzS8PuAMuaTN3//dsLo1jK2Wi6QclTA19lzV7gjG5ljv3iPVeHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/AEeLFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BFCC433A6;
	Mon,  5 Feb 2024 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707141563;
	bh=JEgggokwb2If7xWTrfi//S5h0c1XCgpyqpnsTwc0H+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/AEeLFdsAOPNQ5S008YB+iLG93daK3+Jel3DGrHt1ans5fmRg3OTzoMXar0S+tOH
	 aQ5rxBAH5dLstze1krk0rVs25dF2l2lAIZve8jQ0Ndcmhr9RT1Vh6cbM7OcybzYqMn
	 ezFGtH++UVwARaoOEE9JNeTvFQA5ArMessvDuH+P8KfxSmNn1YN1VnXFHnwJIdHXrI
	 TyhllWg3KUwJ7JhuPiKi278x705YJv7mU1MCALlAh813l4sRElglceMa1a5rBmBvVc
	 b/XrvdGZSidAX5LcqHz0ShwbMo/oe2xSo2GQN1hVsJR6xpvgbWKvcR0ZvpC77qIXbT
	 zMw3UKPSkURgQ==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 2/3] arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
Date: Mon,  5 Feb 2024 15:59:07 +0200
Message-Id: <20240205135908.54656-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205135908.54656-1-rogerq@kernel.org>
References: <20240205135908.54656-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exposing the entire CTRL_MMR space to syscon is not a good idea.
Add sub-nodes for USB0_PHY_CTRL and USB1_PHY_CTRL and use them
in the USB0/USB1 nodes.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Andrew Davis <afd@ti.com>
---

Notes:
    Changelog:
    
    v4 - no change. Added Andrew's Reviewed-by
    
    v3 - no change
    https://lore.kernel.org/all/20240201120332.4811-3-rogerq@kernel.org/
    
    v2:
    - moved am62p changes to next patch
    - use new compatible for USB PHY CTRL node

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi    |  4 ++--
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   |  4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 10 ++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 464b7565d085..9432ed344d52 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -625,7 +625,7 @@ usbss0: dwc3-usb@f900000 {
 		reg = <0x00 0x0f900000 0x00 0x800>;
 		clocks = <&k3_clks 161 3>;
 		clock-names = "ref";
-		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
+		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
@@ -648,7 +648,7 @@ usbss1: dwc3-usb@f910000 {
 		reg = <0x00 0x0f910000 0x00 0x800>;
 		clocks = <&k3_clks 162 3>;
 		clock-names = "ref";
-		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
+		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index fef76f52a52e..817700b2eacf 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -19,6 +19,16 @@ chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
 		};
+
+		usb0_phy_ctrl: syscon@4008 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4008 0x4>;
+		};
+
+		usb1_phy_ctrl: syscon@4018 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4018 0x4>;
+		};
 	};
 
 	wkup_uart0: serial@2b300000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index f0b8c9ab1459..8311c7c44cd3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -566,7 +566,7 @@ usbss0: dwc3-usb@f900000 {
 		reg = <0x00 0x0f900000 0x00 0x800>;
 		clocks = <&k3_clks 161 3>;
 		clock-names = "ref";
-		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
+		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
@@ -589,7 +589,7 @@ usbss1: dwc3-usb@f910000 {
 		reg = <0x00 0x0f910000 0x00 0x800>;
 		clocks = <&k3_clks 162 3>;
 		clock-names = "ref";
-		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
+		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 4e8279fa01e1..4a375f5e0c19 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -17,6 +17,16 @@ chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
 		};
+
+		usb0_phy_ctrl: syscon@4008 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4008 0x4>;
+		};
+
+		usb1_phy_ctrl: syscon@4018 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4018 0x4>;
+		};
 	};
 
 	wkup_uart0: serial@2b300000 {
-- 
2.34.1


