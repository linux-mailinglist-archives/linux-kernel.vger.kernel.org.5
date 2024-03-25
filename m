Return-Path: <linux-kernel+bounces-117226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D331988A8D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F88E360F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14E14EC7C;
	Mon, 25 Mar 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EaydNV2I"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82C13CC45;
	Mon, 25 Mar 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376224; cv=none; b=flp9utAIrnbZ+NxPa/Evfp5XAP4gaOQNxxVLQZHrXtXsVZup4lMP+0Fy3nrJhIN1ZOKtrMzQpinKdWbzqXOVCJtsgKtBjJ2lg32Yg4JHsUG5ycftLOpZhA/mPVVel1x3QR8UYWbMWq03SR32sT8qrMfPPyVEf9Y7G3vFaoUBBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376224; c=relaxed/simple;
	bh=0b5Xjr8qmx+hZ2U332Ut5L/omJDb/gvvp2wRUy2p8wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVb6h9LJ73b71hLpy9KkxxyzaCnRR01g7eoBZTeIcEAIifo8qQlmh2rNxeUNeKD0EnOcEeui2F3ipi/jUuEO7oq5XDbRAlaicv+rHIlrdhifoJXhCW8q6HirXH9MrXvrtHPQwUz6H32/4uZIZO2vaO1dZhDksAbJMkY2qIE2Yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EaydNV2I; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711376217;
	bh=0b5Xjr8qmx+hZ2U332Ut5L/omJDb/gvvp2wRUy2p8wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaydNV2Ioo3w7JjgvNzngEXViiK8U4H3RC5eIF/XUnr89PD73WlNhFO1/fT1IMUsR
	 +OyD8JUQ6wlF4nZPKkBnPDckrRHwo3OrzKXgiGj+HV62NCqzuuFHASvEy5Pp/jOCq7
	 oK5AYzF61l4l3tpwC862wCoX+pMvTX58l5F0h8zao9ETNHa1gq9X9cVHsdQmt0yCFr
	 1++dfadlvrKK4R40ItfmQ8FDx2qLkYeGe51F3ubdLrH64Qmz9D26QOR6xrKa+UcY/w
	 d7AdkQrSzTi+gWJK1YRno0lgiH9isuXkigiSN5Sj++kGcS0+XlUBtJJZkDo2rQB2vq
	 ginxVlmdz/LnQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 95B9837820E1;
	Mon, 25 Mar 2024 14:16:57 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9C7374800D3; Mon, 25 Mar 2024 15:16:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v4 06/10] arm64: dts: rockchip: add USBDP phys on rk3588
Date: Mon, 25 Mar 2024 15:15:36 +0100
Message-ID: <20240325141653.84910-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325141653.84910-1-sebastian.reichel@collabora.com>
References: <20240325141653.84910-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add both USB3-DisplayPort PHYs to RK3588 SoC DT.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi  | 52 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 63 +++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index 5519c1430cb7..4fdd047c9eb9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -17,6 +17,36 @@ pipe_phy1_grf: syscon@fd5c0000 {
 		reg = <0x0 0xfd5c0000 0x0 0x100>;
 	};
 
+	usbdpphy1_grf: syscon@fd5cc000 {
+		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
+		reg = <0x0 0xfd5cc000 0x0 0x4000>;
+	};
+
+	usb2phy1_grf: syscon@fd5d4000 {
+		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd5d4000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy1: usb2phy@4000 {
+			compatible = "rockchip,rk3588-usb2phy";
+			reg = <0x4000 0x10>;
+			#clock-cells = <0>;
+			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy1";
+			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U3_1>, <&cru SRST_P_USB2PHY_U3_1_GRF0>;
+			reset-names = "phy", "apb";
+			status = "disabled";
+
+			u2phy1_otg: otg-port {
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	i2s8_8ch: i2s@fddc8000 {
 		compatible = "rockchip,rk3588-i2s-tdm";
 		reg = <0x0 0xfddc8000 0x0 0x1000>;
@@ -310,6 +340,28 @@ sata-port@0 {
 		};
 	};
 
+	usbdp_phy1: phy@fed90000 {
+		compatible = "rockchip,rk3588-usbdp-phy";
+		reg = <0x0 0xfed90000 0x0 0x10000>;
+		#phy-cells = <1>;
+		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
+			 <&cru CLK_USBDP_PHY1_IMMORTAL>,
+			 <&cru PCLK_USBDPPHY1>,
+			 <&u2phy1>;
+		clock-names = "refclk", "immortal", "pclk", "utmi";
+		resets = <&cru SRST_USBDP_COMBO_PHY1_INIT>,
+			 <&cru SRST_USBDP_COMBO_PHY1_CMN>,
+			 <&cru SRST_USBDP_COMBO_PHY1_LANE>,
+			 <&cru SRST_USBDP_COMBO_PHY1_PCS>,
+			 <&cru SRST_P_USBDPPHY1>;
+		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
+		rockchip,u2phy-grf = <&usb2phy1_grf>;
+		rockchip,usb-grf = <&usb_grf>;
+		rockchip,usbdpphy-grf = <&usbdpphy1_grf>;
+		rockchip,vo-grf = <&vo0_grf>;
+		status = "disabled";
+	};
+
 	combphy1_ps: phy@fee10000 {
 		compatible = "rockchip,rk3588-naneng-combphy";
 		reg = <0x0 0xfee10000 0x0 0x100>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 36e0f198f6bd..3a4f433cef5c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -516,12 +516,23 @@ vop_grf: syscon@fd5a4000 {
 		reg = <0x0 0xfd5a4000 0x0 0x2000>;
 	};
 
+	vo0_grf: syscon@fd5a6000 {
+		compatible = "rockchip,rk3588-vo-grf", "syscon";
+		reg = <0x0 0xfd5a6000 0x0 0x2000>;
+		clocks = <&cru PCLK_VO0GRF>;
+	};
+
 	vo1_grf: syscon@fd5a8000 {
 		compatible = "rockchip,rk3588-vo-grf", "syscon";
 		reg = <0x0 0xfd5a8000 0x0 0x100>;
 		clocks = <&cru PCLK_VO1GRF>;
 	};
 
+	usb_grf: syscon@fd5ac000 {
+		compatible = "rockchip,rk3588-usb-grf", "syscon";
+		reg = <0x0 0xfd5ac000 0x0 0x4000>;
+	};
+
 	php_grf: syscon@fd5b0000 {
 		compatible = "rockchip,rk3588-php-grf", "syscon";
 		reg = <0x0 0xfd5b0000 0x0 0x1000>;
@@ -537,6 +548,36 @@ pipe_phy2_grf: syscon@fd5c4000 {
 		reg = <0x0 0xfd5c4000 0x0 0x100>;
 	};
 
+	usbdpphy0_grf: syscon@fd5c8000 {
+		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
+		reg = <0x0 0xfd5c8000 0x0 0x4000>;
+	};
+
+	usb2phy0_grf: syscon@fd5d0000 {
+		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd5d0000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy0: usb2phy@0 {
+			compatible = "rockchip,rk3588-usb2phy";
+			reg = <0x0 0x10>;
+			#clock-cells = <0>;
+			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy0";
+			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U3_0>, <&cru SRST_P_USB2PHY_U3_0_GRF0>;
+			reset-names = "phy", "apb";
+			status = "disabled";
+
+			u2phy0_otg: otg-port {
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	usb2phy2_grf: syscon@fd5d8000 {
 		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xfd5d8000 0x0 0x4000>;
@@ -2380,6 +2421,28 @@ hdptxphy_hdmi0: phy@fed60000 {
 		status = "disabled";
 	};
 
+	usbdp_phy0: phy@fed80000 {
+		compatible = "rockchip,rk3588-usbdp-phy";
+		reg = <0x0 0xfed80000 0x0 0x10000>;
+		#phy-cells = <1>;
+		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
+			 <&cru CLK_USBDP_PHY0_IMMORTAL>,
+			 <&cru PCLK_USBDPPHY0>,
+			 <&u2phy0>;
+		clock-names = "refclk", "immortal", "pclk", "utmi";
+		resets = <&cru SRST_USBDP_COMBO_PHY0_INIT>,
+			 <&cru SRST_USBDP_COMBO_PHY0_CMN>,
+			 <&cru SRST_USBDP_COMBO_PHY0_LANE>,
+			 <&cru SRST_USBDP_COMBO_PHY0_PCS>,
+			 <&cru SRST_P_USBDPPHY0>;
+		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
+		rockchip,u2phy-grf = <&usb2phy0_grf>;
+		rockchip,usb-grf = <&usb_grf>;
+		rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
+		rockchip,vo-grf = <&vo0_grf>;
+		status = "disabled";
+	};
+
 	combphy0_ps: phy@fee00000 {
 		compatible = "rockchip,rk3588-naneng-combphy";
 		reg = <0x0 0xfee00000 0x0 0x100>;
-- 
2.43.0


