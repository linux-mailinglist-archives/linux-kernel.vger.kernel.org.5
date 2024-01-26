Return-Path: <linux-kernel+bounces-40112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628AE83DA70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E583293505
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD96B1B81F;
	Fri, 26 Jan 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KugkZavx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CE1B7E8;
	Fri, 26 Jan 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274005; cv=none; b=rrdkDutJPAQsbo5NcNJH4PPZSDTVohuBEzf7kq1/1lmAP2rVZ/xxaTuj79bnYG9+J/w+rweXLZfCQOCXtrLakDmsb9xOgA6sFg6CjK/ewKAamZ7DmkwfSyYjGt8J0UWmodEllJ9L7pO/0LsDabBJSNNf2eZYJJl06l/WffGbc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274005; c=relaxed/simple;
	bh=tadW/B1Jf4kenc47EyR6zHxkmDu+fltrsntNV6/oFAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzAkP7sANa9LcgG8/3pSdR51D91CVC/cFmSW8Y6aGrajt33dTjsvq7a5lZ/WBS3zKZ3JDCfttiueICytgW70aMM84JCZfFRCxcM+XxTMN/IPebF5sEVSZfPXZlzDh7tZkBI6mCVMdTI7lTfjVBHp1+v7m5xqKlMtPaGrY28WRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KugkZavx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0279C43390;
	Fri, 26 Jan 2024 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706274004;
	bh=tadW/B1Jf4kenc47EyR6zHxkmDu+fltrsntNV6/oFAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KugkZavx1HvChtd85MbaF4IjcPdHjjuz2NnYibOAT3swXxxgmfcKYoBWhjp2Zv9aK
	 177IrhvwePjLKJAa58G0sDTCcQaA7KCNHq5kN7LaVv2Iknc3GYSGyjs7L267MUGbn4
	 nOHG8qGKkpiaepZfkFBjfuyhWpZbj7Q36lwbFLa1RXKJuZnwVJKeLgMP7QlnXjY6pz
	 jq8Or+yCFyEvssnqjsJ8gDbqv8sRxbh/rkIfWT/CMs8W3RHDIuzaMYKGnPRtJTwEFX
	 Zj0+TezhhdhJnZKwIZsjPQeh6U/41OGGp+Z8EivP8i6W4zWJ4swHySQQy4gXkN4nf8
	 XH62tisfr3ztg==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62/a/p: use sub-node for USB_PHY_CTRL registers
Date: Fri, 26 Jan 2024 14:59:50 +0200
Message-Id: <20240126125951.18585-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126125951.18585-1-rogerq@kernel.org>
References: <20240126125951.18585-1-rogerq@kernel.org>
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
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi    |  4 ++--
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   |  4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 10 ++++++++++
 5 files changed, 34 insertions(+), 4 deletions(-)

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
index fef76f52a52e..bd09662a3c29 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -19,6 +19,16 @@ chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
 		};
+
+		usb0_phy_ctrl: syscon@4008 {
+			compatible = "syscon";
+			reg = <0x4008 0x4>;
+		};
+
+		usb1_phy_ctrl: syscon@4018 {
+			compatible = "syscon";
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
index 4e8279fa01e1..26e9fd9da78f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -17,6 +17,16 @@ chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
 		};
+
+		usb0_phy_ctrl: syscon@4008 {
+			compatible = "syscon";
+			reg = <0x4008 0x4>;
+		};
+
+		usb1_phy_ctrl: syscon@4018 {
+			compatible = "syscon";
+			reg = <0x4018 0x4>;
+		};
 	};
 
 	wkup_uart0: serial@2b300000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
index 19f42b39394e..0893e63c399a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
@@ -18,6 +18,16 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 			bootph-all;
 		};
+
+		usb0_phy_ctrl: syscon@4008 {
+			compatible = "syscon";
+			reg = <0x4008 0x4>;
+		};
+
+		usb1_phy_ctrl: syscon@4018 {
+			compatible = "syscon";
+			reg = <0x4018 0x4>;
+		};
 	};
 
 	wkup_uart0: serial@2b300000 {
-- 
2.34.1


