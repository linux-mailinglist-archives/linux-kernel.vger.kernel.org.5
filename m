Return-Path: <linux-kernel+bounces-62756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A366A85254B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594DA284B14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E931350CA;
	Tue, 13 Feb 2024 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cGv78IQd"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F2130E4B;
	Tue, 13 Feb 2024 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783876; cv=none; b=TA15udiiJFjh1yVD2ThJq6tI9b49YRpfNkKiWRJZX5wVkNiIz8cubilBMRCHZaNKyHTwHo0nOEv7aqM2vTJZlFaCStscl4GylWFyu1z5jWKURtH6kcDl1eS0PvyGuFi5woJpjRJey1eVolI/q2npRfQio1QkTsv5fJZtUOPDz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783876; c=relaxed/simple;
	bh=nDXzUoWI6HydVGvZzvT5I/307J/pqVcb15PihDGPVyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBXU3a9Gt97rCJ+SmSBy8IOB3rVvvAcitT5ktjhgdJpM0TyG3FE/i+cxtxIZv2/pBHxE1TFYvnUD/GUqehbdxCEPx+GOTmc+YksHp/JBsHtpGJc0Kgl2+8K4VbYnFe1QscCIQleqmp3pnF2ZVNqum09qrxmokAtSx7I6esZp+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cGv78IQd; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D0OHQi003295;
	Mon, 12 Feb 2024 18:24:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707783857;
	bh=Kr1g0FGgAoLlJ+ly9sKHSOXo5U921rwPOiok8ffJqXM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cGv78IQd3oMm6656cg4SRnHIqCpFwVmYkSt9kV5QkNTTeCuUOKFyFxPWTKvWgfb7Q
	 bUBdwAkOknCNxnlnLFV+byFZOYVQsww2Z2omQ7ntNoCw8OIj8OSjzf6Iq36xrKLQC5
	 Mj/bSjS6/ukKOMrpR6CJB30wtHFljCk9+epvbdoI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D0OHbM031108
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 18:24:17 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 18:24:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 18:24:17 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D0OGXm119810;
	Mon, 12 Feb 2024 18:24:17 -0600
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wadim Egorov
	<w.egorov@phytec.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 8/9] arm64: dts: ti: k3-am6*: Fix bus-width property in MMC nodes
Date: Mon, 12 Feb 2024 18:24:15 -0600
Message-ID: <20240213002416.1560357-9-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002416.1560357-1-jm@ti.com>
References: <20240213002416.1560357-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move bus-width property to *main.dtsi, above the OTAP/ITAP
delay values. While there is no error with where it is
currently at, it is easier to read the MMC node if the
bus-width property is located above the OTAP/ITAP delay
values consistently across MMC nodes.

Add missing bus-width for MMC2 in k3-am62-main.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 5 +++--
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 1 -
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 2 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 2 --
 arch/arm64/boot/dts/ti/k3-am642-sk.dts         | 1 -
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 410b390ce5d5..55420eb1c620 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -559,9 +559,9 @@ sdhci0: mmc@fa10000 {
 		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 57 6>;
 		assigned-clock-parents = <&k3_clks 57 8>;
+		bus-width = <8>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
-		bus-width = <8>;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
@@ -579,6 +579,7 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
+		bus-width = <4>;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
@@ -591,7 +592,6 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x1>;
 		ti,itap-del-sel-sdr12 = <0xa>;
 		ti,itap-del-sel-sdr25 = <0x1>;
-		bus-width = <4>;
 		status = "disabled";
 	};
 
@@ -602,6 +602,7 @@ sdhci2: mmc@fa20000 {
 		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
 		clock-names = "clk_ahb", "clk_xin";
+		bus-width = <4>;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index bb6a5837bcb3..a34e0df2ab86 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -842,7 +842,6 @@ &sdhci2 {
 	vmmc-supply = <&wlan_en>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_pins_default>, <&wifi_32k_clk>;
-	bus-width = <4>;
 	non-removable;
 	ti,fails-without-test-cd;
 	cap-power-off-card;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index ddb76cd66f88..253c1857eedf 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -561,6 +561,7 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
+		bus-width = <4>;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
@@ -573,7 +574,6 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
-		bus-width = <4>;
 		no-1-8-v;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index bea05be7cb48..bc9c9ff993e6 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -626,6 +626,7 @@ sdhci0: mmc@fa10000 {
 		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 57 0>, <&k3_clks 57 1>;
 		clock-names = "clk_ahb", "clk_xin";
+		bus-width = <8>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
 		ti,clkbuf-sel = <0x7>;
@@ -647,6 +648,7 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 3>, <&k3_clks 58 4>;
 		clock-names = "clk_ahb", "clk_xin";
+		bus-width = <4>;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index f308076d608a..83f2b00726b5 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -494,7 +494,6 @@ eeprom@0 {
 /* eMMC */
 &sdhci0 {
 	status = "okay";
-	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
@@ -506,7 +505,6 @@ &sdhci1 {
 	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
-	bus-width = <4>;
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	disable-wp;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index b286eaa02ada..67cd41bf806e 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -469,7 +469,6 @@ &sdhci1 {
 	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
-	bus-width = <4>;
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	disable-wp;
 };
-- 
2.43.0


