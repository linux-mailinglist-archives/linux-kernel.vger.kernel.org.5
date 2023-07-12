Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DFA750F07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjGLQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjGLQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:52:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9427512E;
        Wed, 12 Jul 2023 09:52:46 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-111.ewe-ip-backbone.de [91.248.191.111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E6B986606FD8;
        Wed, 12 Jul 2023 17:52:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689180765;
        bh=cgoCgj1TntBDxGd/KB0E4UgOCbq//hMHGvNN7KpnzYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrXV5DJk7x1cf+ii0QS2hMY78fRfdgaOthlP/gTTi4iaQt1ZWBMRkGarOtvPGifbi
         H6lJ6QDEjY+b4CONSzk49udJyi6qRjClZ9o36JbyEcqOWBTTPDsRBMUOptPsQPMFGf
         Jgc3UCEsULM7gWIKDJfGrYugUPPUgDmwkPypVEq0xVKPsk1AjLhNa7GdX1LC7XGrIf
         s3WhOxDsm6K0Hw6MfUaY82RxtbjhvwxyO3DpHistifSrpNpUaiaHvt8gz01k93mXH9
         OGURvNlA8nIK1+y3G3IEOu4J7krs2WK/ZhwJJ71J5PBtobq+w0biutmbAe/KSy5HQ5
         cmMEKgReElu2g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 18777480596; Wed, 12 Jul 2023 18:52:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 1/4] arm64: dts: rockchip: rk3588: add USB2 support
Date:   Wed, 12 Jul 2023 18:51:03 +0200
Message-Id: <20230712165106.65603-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712165106.65603-1-sebastian.reichel@collabora.com>
References: <20230712165106.65603-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds USB2 (EHCI & OHCI) ports including the related PHYs
and GRF modules to the rk3588(s) device tree.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 94 +++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 8243e52bce59..c9f9dd2472f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -399,6 +399,50 @@ scmi_shmem: sram@0 {
 		};
 	};
 
+	usb_host0_ehci: usb@fc800000 {
+		compatible = "rockchip,rk3588-ehci", "generic-ehci";
+		reg = <0x0 0xfc800000 0x0 0x40000>;
+		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST_ARB0>, <&cru ACLK_USB>, <&u2phy2>;
+		phys = <&u2phy2_host>;
+		phy-names = "usb";
+		power-domains = <&power RK3588_PD_USB>;
+		status = "disabled";
+	};
+
+	usb_host0_ohci: usb@fc840000 {
+		compatible = "rockchip,rk3588-ohci", "generic-ohci";
+		reg = <0x0 0xfc840000 0x0 0x40000>;
+		interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST_ARB0>, <&cru ACLK_USB>, <&u2phy2>;
+		phys = <&u2phy2_host>;
+		phy-names = "usb";
+		power-domains = <&power RK3588_PD_USB>;
+		status = "disabled";
+	};
+
+	usb_host1_ehci: usb@fc880000 {
+		compatible = "rockchip,rk3588-ehci", "generic-ehci";
+		reg = <0x0 0xfc880000 0x0 0x40000>;
+		interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST_ARB1>, <&cru ACLK_USB>, <&u2phy3>;
+		phys = <&u2phy3_host>;
+		phy-names = "usb";
+		power-domains = <&power RK3588_PD_USB>;
+		status = "disabled";
+	};
+
+	usb_host1_ohci: usb@fc8c0000 {
+		compatible = "rockchip,rk3588-ohci", "generic-ohci";
+		reg = <0x0 0xfc8c0000 0x0 0x40000>;
+		interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST_ARB1>, <&cru ACLK_USB>, <&u2phy3>;
+		phys = <&u2phy3_host>;
+		phy-names = "usb";
+		power-domains = <&power RK3588_PD_USB>;
+		status = "disabled";
+	};
+
 	sys_grf: syscon@fd58c000 {
 		compatible = "rockchip,rk3588-sys-grf", "syscon";
 		reg = <0x0 0xfd58c000 0x0 0x1000>;
@@ -419,6 +463,56 @@ pipe_phy2_grf: syscon@fd5c4000 {
 		reg = <0x0 0xfd5c4000 0x0 0x100>;
 	};
 
+	usb2phy2_grf: syscon@fd5d8000 {
+		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd5d8000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy2: usb2-phy@8000 {
+			compatible = "rockchip,rk3588-usb2phy";
+			reg = <0x8000 0x10>;
+			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
+			reset-names = "phy", "apb";
+			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy2";
+			#clock-cells = <0>;
+			status = "disabled";
+
+			u2phy2_host: host-port {
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
+	usb2phy3_grf: syscon@fd5dc000 {
+		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd5dc000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy3: usb2-phy@c000 {
+			compatible = "rockchip,rk3588-usb2phy";
+			reg = <0xc000 0x10>;
+			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
+			reset-names = "phy", "apb";
+			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy3";
+			#clock-cells = <0>;
+			status = "disabled";
+
+			u2phy3_host: host-port {
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	ioc: syscon@fd5f0000 {
 		compatible = "rockchip,rk3588-ioc", "syscon";
 		reg = <0x0 0xfd5f0000 0x0 0x10000>;
-- 
2.40.1

