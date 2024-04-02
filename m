Return-Path: <linux-kernel+bounces-127509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087D894CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9444B22308
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46EE3BBC2;
	Tue,  2 Apr 2024 07:35:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D972BD1C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043343; cv=none; b=RJHDQsdsnR0gqM7CDLvTTLvQ24XwoPEBtbIbsA9DGH/YhbupbrS8aIg2tRUTVuZvqJ/HwpZt9HfgGXBy1kIWGCwwbPJ73cdwMXxB6nVgADGsWk9uGbgl3ExcVtX/LeDgTzI6hIApazNyuNeulrTdxdKOtO0BkZtQVucyQ2s6Rww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043343; c=relaxed/simple;
	bh=c77W4NtZGbO/mmksuHBSmPIGD/9bOAUrsvWJlCh/Zlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rDIYDCAxJz5nmqrct05GQR8Mzfz+jF79yd2+Hb1s2LVTy72mGH0xhExLgokldzfW9HIzvWgJu36BsbASjPqH9wMiVDSv71xJvrPBID+DZ9cADI2VgCF65Sc6yRe3oRtk3v+XXZwIoUnN+y6pI9KJTfADwXYiO92XkrZzhEsJ85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrYgA-00082Y-FS; Tue, 02 Apr 2024 09:35:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrYgA-009wCp-0x; Tue, 02 Apr 2024 09:35:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrYg9-00EoI0-37;
	Tue, 02 Apr 2024 09:35:33 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 02 Apr 2024 09:35:33 +0200
Subject: [PATCH] arch: arm: mxc: phyCARD-i.MX27: Add USB support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-pca100-v1-1-58df67c2c950@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAES1C2YC/x2MQQqAMAzAviI9O6jbUPEr4qHOqgWZsqEI4t8tH
 hNCHsichDN0xQOJL8myR4WqLCCsFBc2MimDRevR2dYcgSpEQzUiBe9azw1oPFJmMyaKYdU8ntu
 m8kg8y/3f++F9P0ONOldtAAAA
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=c77W4NtZGbO/mmksuHBSmPIGD/9bOAUrsvWJlCh/Zlg=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmC7VFuPpCUfj62coJX6rI+cIQLmIVSuuy8HtjE
 QOcZ7AH6SmJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZgu1RQAKCRC/aVhE+XH0
 q0cSD/4wQ24fgJBtREm521bh0yJpIxVHDu2sqLgZ2zzd7lHgEgP7diUTKxBp2WwaDh+eyTpm/ZL
 UPIGalYlZXS7vxSNI5rqMqLTGrWxn86T2w4x1mZA9nrNDRGimhU/nKlH4seZRmLJXpUmDVqwZm/
 yxFP3CAz/ruAAUpRjvihuMoR6kiRz7YYMC4MzKITjkuBQtRkq8kFVfNdhUTlhTwDUj1LJ0TOyb7
 kMDktkpEHhc3lrU1KIMoKN/rdx52POdrDhgE5Jfy8kw7KULDVn1bIRXbeqvJjOWvR61h875UMT3
 3qtWxJCuB6LsMNc2SXLmW8uun+EOkrLwNgLEArunh8pIDdoXSPHMhxS4ip4FKoOPKEVscix4A3f
 dpDGtsiIjiv43fTkgsrYMtnpLdqJTxcUrQ7m3aZB4EZhSTnhyIiHA+/pTB7KsVsEwjIQfJnhp1q
 LoDZM+pbOSGZw7iJLce47pP9B0Qw3RlJm+4gjhHmdIQJXPZn0eZa2VjrQPci+p7v/oLvNbzD19b
 EnsVJHPq5Q1qiKz9g4PUVV2lFgzGU/7IAV2PllbiTvnu4SoN2TcmZ564F3ARIYHLNFOc6/c2uRC
 2cWYuOFlj1XcaU2rZavfMZdliit+nIOTcwuKoGDh7T0b2kOp+A78t5pobVYJOfI/mYSz9ZAaFQb
 SSj0dDJNY2SbA5Q==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch adds the pinmux and nodes for usbotg and usbh2.

In v6 revision of the pca100 the usb phys were changed to usb3320 which
are connected by their reset pins. We add the phy configuration to the
description.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 .../dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi    | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi
index abc9233c5a1b1..31b3fc972abbf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi
@@ -15,6 +15,22 @@ memory@a0000000 {
 		device_type = "memory";
 		reg = <0xa0000000 0x08000000>; /* 128MB */
 	};
+
+	usbotgphy: usbotgphy {
+		compatible = "usb-nop-xceiv";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotgphy>;
+		reset-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
+		#phy-cells = <0>;
+	};
+
+	usbh2phy: usbh2phy {
+		compatible = "usb-nop-xceiv";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh2phy>;
+		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+		#phy-cells = <0>;
+	};
 };
 
 &cspi1 {
@@ -84,6 +100,52 @@ MX27_PAD_NFRE_B__NFRE_B 0x0
 				MX27_PAD_NFWE_B__NFWE_B 0x0
 			>;
 		};
+
+		pinctrl_usbotgphy: usbotgphygrp {
+			fsl,pins = <
+				MX27_PAD_USBH1_RCV__GPIO2_25		0x1 /* reset gpio */
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX27_PAD_USBOTG_CLK__USBOTG_CLK		0x0
+				MX27_PAD_USBOTG_DIR__USBOTG_DIR		0x0
+				MX27_PAD_USBOTG_NXT__USBOTG_NXT		0x0
+				MX27_PAD_USBOTG_STP__USBOTG_STP		0x0
+				MX27_PAD_USBOTG_DATA0__USBOTG_DATA0	0x0
+				MX27_PAD_USBOTG_DATA1__USBOTG_DATA1	0x0
+				MX27_PAD_USBOTG_DATA2__USBOTG_DATA2	0x0
+				MX27_PAD_USBOTG_DATA3__USBOTG_DATA3	0x0
+				MX27_PAD_USBOTG_DATA4__USBOTG_DATA4	0x0
+				MX27_PAD_USBOTG_DATA5__USBOTG_DATA5	0x0
+				MX27_PAD_USBOTG_DATA6__USBOTG_DATA6	0x0
+				MX27_PAD_USBOTG_DATA7__USBOTG_DATA7	0x0
+			>;
+		};
+
+		pinctrl_usbh2phy: usbh2phygrp {
+			fsl,pins = <
+				MX27_PAD_USBH1_SUSP__GPIO2_22		0x0 /* reset gpio */
+			>;
+		};
+
+		pinctrl_usbh2: usbh2grp {
+			fsl,pins = <
+				MX27_PAD_USBH2_CLK__USBH2_CLK		0x0
+				MX27_PAD_USBH2_DIR__USBH2_DIR		0x0
+				MX27_PAD_USBH2_NXT__USBH2_NXT		0x0
+				MX27_PAD_USBH2_STP__USBH2_STP		0x0
+				MX27_PAD_CSPI2_SCLK__USBH2_DATA0	0x0
+				MX27_PAD_CSPI2_MOSI__USBH2_DATA1	0x0
+				MX27_PAD_CSPI2_MISO__USBH2_DATA2	0x0
+				MX27_PAD_CSPI2_SS1__USBH2_DATA3		0x0
+				MX27_PAD_CSPI2_SS2__USBH2_DATA4		0x0
+				MX27_PAD_CSPI1_SS2__USBH2_DATA5		0x0
+				MX27_PAD_CSPI2_SS0__USBH2_DATA6		0x0
+				MX27_PAD_USBH2_DATA7__USBH2_DATA7	0x0
+			>;
+		};
 	};
 };
 
@@ -95,3 +157,19 @@ &nfc {
 	nand-on-flash-bbt;
 	status = "okay";
 };
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	phy_type = "ulpi";
+	phys = <&usbotgphy>;
+	status = "okay";
+};
+
+&usbh2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh2>;
+	phy_type = "ulpi";
+	phys = <&usbh2phy>;
+	status = "okay";
+};

---
base-commit: 5bab5dc780c9ed0c69fc2f828015532acf4a7848
change-id: 20240328-pca100-a600ac4384e7

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


