Return-Path: <linux-kernel+bounces-119723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A597E88CC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BC01C61432
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE313CC6B;
	Tue, 26 Mar 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jc5qp60h"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C713C67E;
	Tue, 26 Mar 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479301; cv=none; b=By6cd63zleMW3biEX0G1Xx5tRdYTLZtOcP0BrqwaTAhEcAnPkN/95Z6ZymS4kfAcVj8GLel6KGNIxbQxOKUKclUqNQkJu9B0TGaPrnC38G1PiEZeDsi4yyQ5S6xRNX83EeiVfRFhYb4cY8GjnocSvV10bNK/21C1ysK3QEFFMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479301; c=relaxed/simple;
	bh=xDl37rorqnxK1Avj9GZ38VGhAI34BQ8XfsyGrh2l1i4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiDq6iGsmdOpLKSj6f26uk+/DLu8kDQf4IQr/ZVHa+fPumrLHDKwqywZvARbKfQiv/YfuumrHIJQtCNKVECXiDLt+pyGrj3GjVbzrT6cHTzA1wFUiJoEIKy83aZ0Owa2VUG5DeB4o7xmCkI4ExxcGMmQ4b6zmA2Wo0aSpIEsznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jc5qp60h; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QIsitW040742;
	Tue, 26 Mar 2024 13:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711479284;
	bh=+uiAjSxp5Jxk/pDxNJLjRgc4hBbmKLRD7p9qia1iAjA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Jc5qp60hC8SayStWT4bdU2U9O+eVRDVskDfvqpVbKWI9lYTch3zsFPUG3tjdrxBY9
	 qRi2SLleSNVn4Zm68tGpX947kqN8ey6ddWMgPSyA63RkNNKMm7dGK5g7O1EHQAflzx
	 U3sazmZx7JRjzIxjJHwBFpNPgCK+pKvDXK2v13vc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QIsi9r100420
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 13:54:44 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 13:54:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 13:54:43 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QIsfIn091446;
	Tue, 26 Mar 2024 13:54:43 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 5/6] arm64: dts: ti: k3-j721s2: Remove UART baud rate selection
Date: Tue, 26 Mar 2024 13:54:40 -0500
Message-ID: <20240326185441.29656-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326185441.29656-1-afd@ti.com>
References: <20240326185441.29656-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

As described in the binding document for the "current-speed" property:

"This should only be present in case a driver has no chance to know the
baud rate of the slave device."

This is not the case for the UART used in K3 devices, the current
baud-rate can be calculated from the registers. Having this property
has the effect of actually skipping the baud-rate setup in some drivers
as it assumes it will already be set to this rate, which may not always
be the case.

It seems this property's purpose was mistaken as selecting the desired
baud-rate, which it does not. It would have been wrong to select that
here anyway as DT is not the place for configuration, especially when
there are already more standard ways to set serial baud-rates.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       | 10 ----------
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi |  2 --
 2 files changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index b70c8615e3c15..3cb06a7e4117f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -459,7 +459,6 @@ main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x200>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 146 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
@@ -470,7 +469,6 @@ main_uart1: serial@2810000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02810000 0x00 0x200>;
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 350 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
@@ -481,7 +479,6 @@ main_uart2: serial@2820000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02820000 0x00 0x200>;
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 351 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
@@ -492,7 +489,6 @@ main_uart3: serial@2830000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02830000 0x00 0x200>;
 		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 352 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
@@ -503,7 +499,6 @@ main_uart4: serial@2840000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02840000 0x00 0x200>;
 		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 353 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
@@ -514,7 +509,6 @@ main_uart5: serial@2850000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02850000 0x00 0x200>;
 		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 354 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
@@ -525,7 +519,6 @@ main_uart6: serial@2860000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02860000 0x00 0x200>;
 		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 355 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
@@ -536,7 +529,6 @@ main_uart7: serial@2870000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02870000 0x00 0x200>;
 		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 356 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
@@ -547,7 +539,6 @@ main_uart8: serial@2880000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02880000 0x00 0x200>;
 		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 357 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
@@ -558,7 +549,6 @@ main_uart9: serial@2890000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02890000 0x00 0x200>;
 		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 358 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index eaf7f709440e6..5ccb04c7c4624 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -298,7 +298,6 @@ wkup_uart0: serial@42300000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x42300000 0x00 0x200>;
 		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 359 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
@@ -309,7 +308,6 @@ mcu_uart0: serial@40a00000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x40a00000 0x00 0x200>;
 		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 149 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
-- 
2.39.2


