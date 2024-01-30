Return-Path: <linux-kernel+bounces-44859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DEC842837
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E59285050
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955082D80;
	Tue, 30 Jan 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoCg2+3g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BC5C8B;
	Tue, 30 Jan 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629259; cv=none; b=VyOq3tbDJ7/lAox0ulm73NcMKGUpXwKA0uN0jRoT2RSXySxBn0Y1ydFwFo6QGP8ZnRWvZdHHV9nec1mYZW89/pa0kFZxQit9OMqqdrsxgkdqBBbBzu5L4mxENufIqtKBpUzOy4xRpWLymqRTIsGhTEAXdNwTUsUEwto3Zwy3ybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629259; c=relaxed/simple;
	bh=jJoErVTod0oDPtMH97i6PpdukCzZcgldhkvPcTE3rBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+qsONwgll9ck/Kvfq2HMjUYxX3Msbrlxt7TxaTr7A0wNDJhu7zvYA260jE1xrndlyHq2dqAMmxYM/NbXGdYWxcR7B3zeKaOX38e/htvloATi1yfVUWy7UBcXwDfOfHw/1JPg+XQLLxG2uv7T/qR9FwzWFGtKKu12el3+eKJ7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoCg2+3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CABC433B1;
	Tue, 30 Jan 2024 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629258;
	bh=jJoErVTod0oDPtMH97i6PpdukCzZcgldhkvPcTE3rBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PoCg2+3gYUlABMbdNb6WvzHB7R2YHI0ZIUigshxO/SU8PB3/JRL/+Ud+wN8R5oIiN
	 eocLML5HZKCaKQ9nqNKQe7NL0HS6d4Jw5btkxnTapVFpxR4FIp7rmvnmfKYuGrhiKs
	 dU1+uZ1lSI52Ak49AJjfgZLayEZaXUuJS6WWlyUbKzPeKyeoMvZXX1aPSfwfpmxGab
	 mMGobeauvCmiu+DXhlei0FaTvVFu4JfF38s8YKsn3UUdEdCeAQ3dn2e8uAv2l0/m/F
	 +tqyw0LLiwGILSHOIpAdvZ2ZWIJUbDYVRCh6KyxegGdrpa+5FXDcjYvi6P+YCB9tb0
	 BzIyCTkr2AHug==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com,
	lee@kernel.org
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
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
Date: Tue, 30 Jan 2024 17:40:34 +0200
Message-Id: <20240130154035.6901-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130154035.6901-1-rogerq@kernel.org>
References: <20240130154035.6901-1-rogerq@kernel.org>
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

Notes:
    Changelog:
    
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


