Return-Path: <linux-kernel+bounces-149639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EBF8A93D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E372D2817C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0326A00B;
	Thu, 18 Apr 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sRO/iXJA"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49925622;
	Thu, 18 Apr 2024 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424609; cv=none; b=ZRVUOJ7ndUuq6j1VqXqkUZLqlCI+B8EXn6vieeN5BFTXUDocVRxj28C5ZwoqiPe+ifYAf6AMPPr0rfg6Dh/GB+zjJtgh/luxyrdYmhOCEFrQzGYprxTTulpypXOZo5FqlBQVscqcUlRlunVTllfic9FeqktYrUCwjbJ4n1yODp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424609; c=relaxed/simple;
	bh=j+8U3wWOQdhMe3diOOZSc77fg6RV3VpQKLIl/R+M8Xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F40TsYC6xvOo5CMpyjOTwBPzj0oSlVSjoNVobr8pgHPhWOZVADiTh4+nXKjS5FzjUk+TrAKY6cJEBdJ2JlbkCCOR1RWf08CzIJZ8ELiMZpIN6vbtTxOsvdR5lm3GeUDdAg/MawbYdUocHpyCX4iTyHdo2ec3ytVyUqLgl9vFptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sRO/iXJA; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43I7GdKu010890;
	Thu, 18 Apr 2024 02:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713424599;
	bh=eGVUM1RepNbLf7UAupyuAbZgeKEoTiBSOUv+HajWrg4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sRO/iXJAFaFm+n2j6m7xMFJDhxO/mbq2Knscx2+gTHf1FRiKns+NDxXmWQPBpUTQi
	 Ye1LcGA6Y/i6z1ffz2b2vble7ffVHQ1Y/3z3KCRuhbTG/apFDMscQ9iKHMFQzpoI3l
	 g3SFAgZ/ah1RmdUyV6a6tT/vtlOV42WltPxQPE0o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43I7GeqJ048077
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Apr 2024 02:16:40 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 02:16:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 02:16:39 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43I7GIS5027275;
	Thu, 18 Apr 2024 02:16:36 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <francesco@dolcini.it>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-j784s4-evm: Arranging pin mux in alphabetical order
Date: Thu, 18 Apr 2024 12:46:08 +0530
Message-ID: <20240418071610.358944-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418071610.358944-1-u-kumar1@ti.com>
References: <20240418071610.358944-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Arranging pin mux in order of main_pmx0/1, wkup_pmx0/1/2/3

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 108 +++++++++++------------
 1 file changed, 52 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index d511b25d62e3..97b0bffc38c5 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -338,6 +338,58 @@ J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
 	};
 };
 
+&wkup_pmx0 {
+	bootph-all;
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
+			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
+			J784S4_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B33) MCU_OSPI0_D0 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B32) MCU_OSPI0_D1 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (C33) MCU_OSPI0_D2 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (C35) MCU_OSPI0_D3 */
+			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D33) MCU_OSPI0_D4 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
+			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
+			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
+		>;
+	};
+};
+
+&wkup_pmx1 {
+	bootph-all;
+	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
+		>;
+	};
+
+	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
+			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
+			J784S4_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
+			J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
+		>;
+	};
+
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			/* (G33) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
+		>;
+	};
+};
+
 &wkup_pmx2 {
 	bootph-all;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
@@ -417,62 +469,6 @@ J784S4_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
 	};
 };
 
-&wkup_pmx1 {
-	status = "okay";
-
-	pmic_irq_pins_default: pmic-irq-default-pins {
-		pinctrl-single,pins = <
-			/* (G33) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
-			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
-		>;
-	};
-};
-
-&wkup_pmx0 {
-	bootph-all;
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
-			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
-			J784S4_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B33) MCU_OSPI0_D0 */
-			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B32) MCU_OSPI0_D1 */
-			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (C33) MCU_OSPI0_D2 */
-			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (C35) MCU_OSPI0_D3 */
-			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D33) MCU_OSPI0_D4 */
-			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
-			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
-			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
-			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
-		>;
-	};
-};
-
-&wkup_pmx1 {
-	bootph-all;
-	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
-			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
-		>;
-	};
-
-	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
-			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
-			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
-			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
-			J784S4_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
-			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
-			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
-			J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
-		>;
-	};
-};
-
 &wkup_uart0 {
 	/* Firmware usage */
 	status = "reserved";
-- 
2.34.1


