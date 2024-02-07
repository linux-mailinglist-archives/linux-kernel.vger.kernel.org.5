Return-Path: <linux-kernel+bounces-57279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21C84D619
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AB31C226CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF80535D9;
	Wed,  7 Feb 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="caF7eea0"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2801DFEB;
	Wed,  7 Feb 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346538; cv=none; b=eUZxEuLxA1ERw0SYrIOXfzLLHCuaxxYscJOFGnmzr+Yy7qXhQH0aC8hlrB71111cLm6vy6raEcEMlxCk57BCLALMzq7wkpC+q5q7Q2P34EDU7LuiSV7iSuD2Ce5bs1aa+1ONXVYSrfy7/MqN+P8YciOZEsV/WfE+ZzeMfrSkMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346538; c=relaxed/simple;
	bh=nDXzUoWI6HydVGvZzvT5I/307J/pqVcb15PihDGPVyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJkNYv0gr04tn5BT9l3fgWC/CwxUPZ4oMoC/waqF4CsjFF5VmG8hlcIFBf9c2DX3bcrliTihqRx5x97rfowjONmXrfxDc22ottXNp0gLAq0uV+AFBAzd+ke2OVA0gxhZ/z6SJpkf/FCXWQ04Mkw9Wk26Ig0yUQd5EVYGaPJVHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=caF7eea0; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417MtRZu052074;
	Wed, 7 Feb 2024 16:55:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707346527;
	bh=Kr1g0FGgAoLlJ+ly9sKHSOXo5U921rwPOiok8ffJqXM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=caF7eea0oSkYy9btttm9AAUGYfRDaBK6CJ8CxmdVYmU23ZfdF9euuaXUMNJkYZSdM
	 /mqumHLmExHO4MdH+3dH2HWm4VlQffNsWAS1N77S55mLrFum1cYFvzgUWaTzKbNssQ
	 KGQVQufOLoxplvGJl7lZsJQwxx3Sa6eq56rdvH/c=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417MtRs4071890
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 16:55:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 16:55:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 16:55:27 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417MtQmb014027;
	Wed, 7 Feb 2024 16:55:27 -0600
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 8/9] arm64: dts: ti: k3-am6*: Fix bus-width property in MMC nodes
Date: Wed, 7 Feb 2024 16:55:25 -0600
Message-ID: <20240207225526.3953230-9-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207225526.3953230-1-jm@ti.com>
References: <20240207225526.3953230-1-jm@ti.com>
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


