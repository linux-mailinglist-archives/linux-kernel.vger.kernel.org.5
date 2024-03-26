Return-Path: <linux-kernel+bounces-119721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B9888CC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3CF1F68278
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C9C13CC52;
	Tue, 26 Mar 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xGL6i4J6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73E8129E88;
	Tue, 26 Mar 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479301; cv=none; b=RWUHtDpWZpyI4/yebq6QPh9oVbVruYqgPv50chiVFZ4KNUkSG627wb0DDRl7x+DxjoGS7N3ThNpIryT4V7ILnx9aQjvH3YWdPLJMypJUlW2fghVL8iqZ+W6JnwEaLJ0R8hWNqn+7YGpGXzaOLE3qpK5AJy2Lfm42e7q26BPEdoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479301; c=relaxed/simple;
	bh=kZ78PtjvmyUZuECbikY5Q6c2dEWnsP5+9yZeGkjRtCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqQd/EE2DUwOHLOs2eTvwv6R8H4AJrSzExe0hYDuezamVDJX2ImVoKB+vG7OgZnbrqfjG8umCgS1wPvIV6n8MJYaS6ujMvsq3gWH4ZkwSeqO+7BIW04FVYuBw3yTuECR6tyHbKWwXHwCdOi7YFQEcmP8elYCyiwOMzXqzHb6AHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xGL6i4J6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QIsi8w062545;
	Tue, 26 Mar 2024 13:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711479284;
	bh=T8630GWUrbj0zfexpMDHqXLTw8tlD7FeoVbNwa/kyLU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xGL6i4J64HBPNmeJUw23aTR8yYLbSsE9CZuzd6a+xq+VNGHOiyxqNlV4U8gL8XvB7
	 Yo2ZcbgGtLaDaxoprk7PEJSh1ZfAahl443g0QCkT72zaZfsNClmeRv5kwwatJWq5yO
	 hDTMG45nDUpCVc6BnTSwamWRM+v+p0v6G9D2jlbo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QIsi79120809
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 13:54:44 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 13:54:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 13:54:44 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QIsfIo091446;
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
Subject: [PATCH 6/6] arm64: dts: ti: k3-j784s4: Remove UART baud rate selection
Date: Tue, 26 Mar 2024 13:54:41 -0500
Message-ID: <20240326185441.29656-6-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       | 10 ----------
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi |  2 --
 2 files changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index b67c37460a73d..d42f25cacf23d 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -404,7 +404,6 @@ main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x200>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 146 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
@@ -415,7 +414,6 @@ main_uart1: serial@2810000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02810000 0x00 0x200>;
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 388 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 388 TI_SCI_PD_EXCLUSIVE>;
@@ -426,7 +424,6 @@ main_uart2: serial@2820000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02820000 0x00 0x200>;
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 389 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 389 TI_SCI_PD_EXCLUSIVE>;
@@ -437,7 +434,6 @@ main_uart3: serial@2830000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02830000 0x00 0x200>;
 		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 390 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 390 TI_SCI_PD_EXCLUSIVE>;
@@ -448,7 +444,6 @@ main_uart4: serial@2840000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02840000 0x00 0x200>;
 		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 391 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 391 TI_SCI_PD_EXCLUSIVE>;
@@ -459,7 +454,6 @@ main_uart5: serial@2850000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02850000 0x00 0x200>;
 		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 392 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 392 TI_SCI_PD_EXCLUSIVE>;
@@ -470,7 +464,6 @@ main_uart6: serial@2860000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02860000 0x00 0x200>;
 		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 393 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 393 TI_SCI_PD_EXCLUSIVE>;
@@ -481,7 +474,6 @@ main_uart7: serial@2870000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02870000 0x00 0x200>;
 		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 394 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 394 TI_SCI_PD_EXCLUSIVE>;
@@ -492,7 +484,6 @@ main_uart8: serial@2880000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02880000 0x00 0x200>;
 		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 395 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 395 TI_SCI_PD_EXCLUSIVE>;
@@ -503,7 +494,6 @@ main_uart9: serial@2890000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02890000 0x00 0x200>;
 		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 396 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 396 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 77a8d99139ec1..b47338e0f4812 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -304,7 +304,6 @@ wkup_uart0: serial@42300000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x42300000 0x00 0x200>;
 		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 397 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 397 TI_SCI_PD_EXCLUSIVE>;
@@ -315,7 +314,6 @@ mcu_uart0: serial@40a00000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x40a00000 0x00 0x200>;
 		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		clocks = <&k3_clks 149 0>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
-- 
2.39.2


