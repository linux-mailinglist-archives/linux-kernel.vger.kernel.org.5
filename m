Return-Path: <linux-kernel+bounces-119722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8288CC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565F21F67804
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5117513CC57;
	Tue, 26 Mar 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I2wM1wHn"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743113C3D8;
	Tue, 26 Mar 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479301; cv=none; b=nkmTs+I1Uz2RkPhk1/YaXAwKda7p4p+PI7bvSUVuIBCipJWwzNk69JN9qMlipHfNpeGUTSJsjSPk9515MpDZ9EmIPJZTbuJWUXbIoA80VajjLA6oUe6cVWtzlLItyMNMC1eTPvDgnpGO/y3CPa7EDCr9PYDMGm0gnLhg24a6F9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479301; c=relaxed/simple;
	bh=xG/WbUnzcMPfdhsJCmCt9eB6xLBOue+EAmZCnyg0X3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVIwfvYeaR1r7j5ao207kVhSb0+unLUuBXJN+G827otbnkvhAYb3WNXycCkkM6RJizZvyFp1msYydFeF6hXwiDM0bnwI9hJk21V9j/Ogn1y84w4E8kc/GJsn2ibQy2B3ozDu6mPPwNpC+3W8cNEHyec+sGf/FqtiE07Xz3fbskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I2wM1wHn; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QIshau062540;
	Tue, 26 Mar 2024 13:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711479283;
	bh=xK/JV7sq7ykmOnZufg5+rLTOfjmClJd6clfSfUVThRU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=I2wM1wHnni1nDiJBr06ZjyRRHv+AX8LLNbEKet4aiFCOPwa3FbHqyJkg+fawxbwOa
	 xxMkPtk+TuS2iDzjiVdWoxCiLTrnZ32lhjoNhwVDUnEp4uO5LRq+P1ZJPmb/m7UR7u
	 WBYBpwE0oFr9V9iL643RQ33hfw3HnZsuC0Rr6aEU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QIshR5027804
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 13:54:43 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 13:54:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 13:54:43 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QIsfIm091446;
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
Subject: [PATCH 4/6] arm64: dts: ti: k3-j721e: Remove UART baud rate selection
Date: Tue, 26 Mar 2024 13:54:39 -0500
Message-ID: <20240326185441.29656-4-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 10 ----------
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  2 --
 2 files changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c7eafbc862f96..0da785be80ff4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1337,7 +1337,6 @@ main_uart0: serial@2800000 {
 		reg = <0x00 0x02800000 0x00 0x100>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 0>;
 		clock-names = "fclk";
@@ -1349,7 +1348,6 @@ main_uart1: serial@2810000 {
 		reg = <0x00 0x02810000 0x00 0x100>;
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 278 0>;
 		clock-names = "fclk";
@@ -1361,7 +1359,6 @@ main_uart2: serial@2820000 {
 		reg = <0x00 0x02820000 0x00 0x100>;
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 279 0>;
 		clock-names = "fclk";
@@ -1373,7 +1370,6 @@ main_uart3: serial@2830000 {
 		reg = <0x00 0x02830000 0x00 0x100>;
 		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 280 0>;
 		clock-names = "fclk";
@@ -1385,7 +1381,6 @@ main_uart4: serial@2840000 {
 		reg = <0x00 0x02840000 0x00 0x100>;
 		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 281 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 281 0>;
 		clock-names = "fclk";
@@ -1397,7 +1392,6 @@ main_uart5: serial@2850000 {
 		reg = <0x00 0x02850000 0x00 0x100>;
 		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 282 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 282 0>;
 		clock-names = "fclk";
@@ -1409,7 +1403,6 @@ main_uart6: serial@2860000 {
 		reg = <0x00 0x02860000 0x00 0x100>;
 		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 283 0>;
 		clock-names = "fclk";
@@ -1421,7 +1414,6 @@ main_uart7: serial@2870000 {
 		reg = <0x00 0x02870000 0x00 0x100>;
 		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 284 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 284 0>;
 		clock-names = "fclk";
@@ -1433,7 +1425,6 @@ main_uart8: serial@2880000 {
 		reg = <0x00 0x02880000 0x00 0x100>;
 		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 285 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 285 0>;
 		clock-names = "fclk";
@@ -1445,7 +1436,6 @@ main_uart9: serial@2890000 {
 		reg = <0x00 0x02890000 0x00 0x100>;
 		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 286 0>;
 		clock-names = "fclk";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 4618b697fbc47..8fc768d84b759 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -243,7 +243,6 @@ wkup_uart0: serial@42300000 {
 		reg = <0x00 0x42300000 0x00 0x100>;
 		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 287 0>;
 		clock-names = "fclk";
@@ -255,7 +254,6 @@ mcu_uart0: serial@40a00000 {
 		reg = <0x00 0x40a00000 0x00 0x100>;
 		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <96000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 0>;
 		clock-names = "fclk";
-- 
2.39.2


