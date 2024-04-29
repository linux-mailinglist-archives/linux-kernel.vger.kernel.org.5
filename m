Return-Path: <linux-kernel+bounces-162209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F39F8B579A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF421287AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3BB80023;
	Mon, 29 Apr 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CMrZAJwF"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB154776;
	Mon, 29 Apr 2024 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392597; cv=none; b=I/8+aZ/KU7Ge/dYA44ArIHp2maJQ6aGZrJiL16/JE14Byo7JaLa9SiyyYCgnVpPmrk+FI5O4bZXIRvUPLTvJpfynmk7WAj22nr82XCdIPxy9il3YFRMoiS8aK064bw4lOujutdsobJwPI6zggyplxR56ryeIs2Vs/Fp34/0ZrT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392597; c=relaxed/simple;
	bh=bTxT5GIgyUPyK7XMOczdXJRs0phSdhb8odkt8UPK54Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQx/pPJ1ZdaeWaV4Ra5BCXz8YE+pqqU85jReWZre1O5Je4HEmUzzNPyAnE1+6Gquvwaf5MFxa+8rd86HJ4+cG4A137FP9pTNHcHx8GhmMT8S0uMF0wJqZ3opaPcd2MVI1zlhPufCqEB1bMB0+N5fXV6Tkkd8BkirsBvj8SIydcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CMrZAJwF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TC9mZS023707;
	Mon, 29 Apr 2024 07:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714392588;
	bh=kvlYtiFfajGhjm1PAn/iAEOIOgzSiP0fRjaw+iHQiQ4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CMrZAJwFtd1KQ/j1F4e6boQFIefczLrHZ1rtJuIIw1jq+h1lNKUVQfhs9tJ6sFBqJ
	 Ek8ZGUGEO7L9L4YDZi4Lmpiz44j+ZKqppjvxUQGMwX9Z56qM2Spjr3LlmP3roqaYBm
	 POkKpxAE6YZestqqAAVE/yQ594jtxoh88Sezx3BI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TC9mgf006084
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 07:09:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 07:09:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 07:09:47 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TC9XrH012367;
	Mon, 29 Apr 2024 07:09:44 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1 configuration for EVM
Date: Mon, 29 Apr 2024 17:39:32 +0530
Message-ID: <20240429120932.11456-4-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240429120932.11456-1-r-gunasekaran@ti.com>
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The GPIO expander on the EVM allows the USB selection for Type-C
port to either USB0 or USB1 via USB hub. By default, let the Type-C
port select USB0 via the GPIO expander port P05.

Enable super-speed on USB1 by updating SerDes0 lane configuration.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 58 +++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-serdes.h      |  7 +++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index bf3c246d13d1..ddb4f1f0d92d 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -9,7 +9,9 @@
 /dts-v1/;
 
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy.h>
 #include "k3-j722s.dtsi"
+#include "k3-serdes.h"
 
 / {
 	compatible = "ti,j722s-evm", "ti,j722s";
@@ -20,6 +22,8 @@
 		serial2 = &main_uart0;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
+		usb0 = &usb0;
+		usb1 = &usb1;
 	};
 
 	chosen {
@@ -202,6 +206,12 @@
 			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
 		>;
 	};
+
+	main_usb1_pins_default: main-usb1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0258, PIN_INPUT, 0) /* (B27) USB1_DRVVBUS */
+		>;
+	};
 };
 
 &cpsw3g {
@@ -301,6 +311,14 @@
 				  "PCIe0_1L_RC_RSTz", "PCIe0_1L_PRSNT#",
 				  "ENET1_EXP_SPARE2", "ENET1_EXP_PWRDN",
 				  "PD_I2ENET1_I2CMUX_SELC_IRQ", "ENET1_EXP_RESETZ";
+
+		p05-hog {
+			/* P05 - USB2.0_MUX_SEL */
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "USB2.0_MUX_SEL";
+		};
 	};
 };
 
@@ -384,3 +402,43 @@
 	status = "okay";
 	bootph-all;
 };
+
+&serdes0_ln_ctrl {
+	idle-states = <J722S_SERDES0_LANE0_USB>,
+		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
+};
+
+&serdes0 {
+	status = "okay";
+	serdes0_usb_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&usbss0 {
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usbss1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "host";
+	maximum-speed = "super-speed";
+	phys = <&serdes0_usb_link>;
+	phy-names = "cdns3,usb3-phy";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
index a011ad893b44..9082abeddcb1 100644
--- a/arch/arm64/boot/dts/ti/k3-serdes.h
+++ b/arch/arm64/boot/dts/ti/k3-serdes.h
@@ -201,4 +201,11 @@
 #define J784S4_SERDES4_LANE3_USB		0x2
 #define J784S4_SERDES4_LANE3_IP4_UNUSED		0x3
 
+/* J722S */
+#define J722S_SERDES0_LANE0_USB			0x0
+#define J722S_SERDES0_LANE0_QSGMII_LANE2	0x1
+
+#define J722S_SERDES1_LANE0_PCIE0_LANE0		0x0
+#define J722S_SERDES1_LANE0_QSGMII_LANE1	0x1
+
 #endif /* DTS_ARM64_TI_K3_SERDES_H */
-- 
2.17.1


