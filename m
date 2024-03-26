Return-Path: <linux-kernel+bounces-119725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AFF88CC71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BBF1F6835C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E513D266;
	Tue, 26 Mar 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y6ckrf1Z"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205413D246;
	Tue, 26 Mar 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479307; cv=none; b=JKZr611G0x+7Wjs0bR+Qybrs1W2al27lWlklK4a9nHUd3XY3V8t/zDYjt7jKgSsMGUIQDSyx67gtjkZxSbu1zA8t7n8lMnv1JP8uRJNj8aa9yTHY4qwqN1QGLl7hiDz8EgSwJz96qU4qJGaFDyBSKJ/ojTbUewZ/ibwM2/hBD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479307; c=relaxed/simple;
	bh=vifJid4QP5qu+Ze145AQyrCHImE3LdpNdcm4JKsVFQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S47WMYFk4JSBCll338UA1iCZnh+WLh/rnDPON0rtiNkoqSY7skZq8bkAHtVdKyLMOcZnk2VZTIJuFv6L6Og9ghwkGrNi3h6Pk2p44fowFphAGg9L/D+kATiOpFsZzdZCaP0SjKQ0kNWb3M0ywoaUW9DENQUfd72aOPaQIq6Nztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y6ckrf1Z; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QIshQg064686;
	Tue, 26 Mar 2024 13:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711479283;
	bh=XhGMipz2RJEepgM1inPEbiVZpQtvwi2BB5eqncZug+k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Y6ckrf1Z33cJ6oNeE2PFFaxivkl50uMsXhJK20Sq8XaL2lVqW2lYsZKMvy/sqlzgO
	 KUbJyiX+oQ1d1B6TSgOXa7UPl1GEjK9BeC0VrJVULUtzG0g0lVoAWMEecxuYhuTV+/
	 FS6nRoERHTo0Uru8UP/kHrTWD+WHC55B6QMme5U8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QIsh53100412
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 13:54:43 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 13:54:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 13:54:43 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QIsfIl091446;
	Tue, 26 Mar 2024 13:54:42 -0500
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
Subject: [PATCH 3/6] arm64: dts: ti: k3-j7200: Remove UART baud rate selection
Date: Tue, 26 Mar 2024 13:54:38 -0500
Message-ID: <20240326185441.29656-3-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 10 ----------
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  2 --
 2 files changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 657f9cc9f4ea0..9386bf3ef9f68 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -440,7 +440,6 @@ main_uart0: serial@2800000 {
 		reg = <0x00 0x02800000 0x00 0x100>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 2>;
 		clock-names = "fclk";
@@ -452,7 +451,6 @@ main_uart1: serial@2810000 {
 		reg = <0x00 0x02810000 0x00 0x100>;
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 278 2>;
 		clock-names = "fclk";
@@ -464,7 +462,6 @@ main_uart2: serial@2820000 {
 		reg = <0x00 0x02820000 0x00 0x100>;
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 279 2>;
 		clock-names = "fclk";
@@ -476,7 +473,6 @@ main_uart3: serial@2830000 {
 		reg = <0x00 0x02830000 0x00 0x100>;
 		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 280 2>;
 		clock-names = "fclk";
@@ -488,7 +484,6 @@ main_uart4: serial@2840000 {
 		reg = <0x00 0x02840000 0x00 0x100>;
 		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 281 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 281 2>;
 		clock-names = "fclk";
@@ -500,7 +495,6 @@ main_uart5: serial@2850000 {
 		reg = <0x00 0x02850000 0x00 0x100>;
 		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 282 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 282 2>;
 		clock-names = "fclk";
@@ -512,7 +506,6 @@ main_uart6: serial@2860000 {
 		reg = <0x00 0x02860000 0x00 0x100>;
 		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 283 2>;
 		clock-names = "fclk";
@@ -524,7 +517,6 @@ main_uart7: serial@2870000 {
 		reg = <0x00 0x02870000 0x00 0x100>;
 		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 284 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 284 2>;
 		clock-names = "fclk";
@@ -536,7 +528,6 @@ main_uart8: serial@2880000 {
 		reg = <0x00 0x02880000 0x00 0x100>;
 		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 285 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 285 2>;
 		clock-names = "fclk";
@@ -548,7 +539,6 @@ main_uart9: serial@2890000 {
 		reg = <0x00 0x02890000 0x00 0x100>;
 		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 286 2>;
 		clock-names = "fclk";
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 7cf21c99956e0..c547bc8fb6082 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -259,7 +259,6 @@ wkup_uart0: serial@42300000 {
 		reg = <0x00 0x42300000 0x00 0x100>;
 		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 287 2>;
 		clock-names = "fclk";
@@ -271,7 +270,6 @@ mcu_uart0: serial@40a00000 {
 		reg = <0x00 0x40a00000 0x00 0x100>;
 		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <96000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 2>;
 		clock-names = "fclk";
-- 
2.39.2


