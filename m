Return-Path: <linux-kernel+bounces-57282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5041484D620
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067A42897FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D09A6BFA0;
	Wed,  7 Feb 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JhpI5kUc"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96017200DD;
	Wed,  7 Feb 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346539; cv=none; b=OiF083XYk5xRqTGP7A9S6kCYGwJBnrwmRA+H/xpGiUHHgM/HgXodTb6ZM6y0U+rlgNmyeZYUM7JlBv/rlyNr/SD1yUke5/wH5g8Hcy96b4arV/7OqDd42Q3+/O5Y1CqAjvmDMcKKbgFVEKR4gUV7M/hTVn4HZPDNxlJdZTlIsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346539; c=relaxed/simple;
	bh=MJ5J9CpP6IH5XXW/AJO77nSRKOSlNrlRVYvB/DEnt8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkRmfZLddf0P2hqsPzfKAL/OG64RptL24Xm1PbPhJhtmEGZm+Jus21rrHH92lunWwaNj/r6N4ksLCD3PozQspRLxZVXI51wnB/53ILw0nAQ6/N1ye1FJu/DVJqzlRsXxjNwnO6zbMUU+HULRaOeRxRXbL7goetwM8QFm23ClvAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JhpI5kUc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417MtRlI014826;
	Wed, 7 Feb 2024 16:55:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707346527;
	bh=rIa49ahif7c1unZuF0HuSknb6qV0OjBvb0g8Hav04BQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JhpI5kUcgCPpR9LDHns/4qZIKLhr0zn46Av9TL+DhL23hbFcXxYzE2ag4bXOBy/0i
	 9KjF9kFUFr3mV0c+HGPEOCkoC1G7kUov8xWw7DmFKr1TPVlfQqjfpdu6hSZIKeRgfL
	 XNejIeJHVrXh/z8kQgCNy+XJWzjyhjKIclxtOcaQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417MtRXk065582
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 16:55:27 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 16:55:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 16:55:27 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417MtQmZ014027;
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
Subject: [PATCH v1 6/9] arm64: dts: ti: k3-am6*: Remove DLL properties for soft PHYs
Date: Wed, 7 Feb 2024 16:55:23 -0600
Message-ID: <20240207225526.3953230-7-jm@ti.com>
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

Remove DLL properties which are not applicable for soft PHYs
since these PHYs do not have a DLL to enable.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 3 ---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 3 ---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 1 -
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 1 -
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 1 -
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 --
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 1 -
 arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 1 -
 arch/arm64/boot/dts/ti/k3-am642-sk.dts         | 1 -
 9 files changed, 14 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index fe0cc4a9a501..79ed5cbbbda1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -561,7 +561,6 @@ sdhci0: mmc@fa10000 {
 		assigned-clock-parents = <&k3_clks 57 8>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
-		ti,trm-icp = <0x2>;
 		bus-width = <8>;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
@@ -580,7 +579,6 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		ti,trm-icp = <0x2>;
 		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0x0>;
@@ -604,7 +602,6 @@ sdhci2: mmc@fa20000 {
 		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		ti,trm-icp = <0x2>;
 		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0x0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 3b4246ce49de..bb6a5837bcb3 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -819,7 +819,6 @@ &sdhci0 {
 	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	status = "okay";
 };
@@ -832,7 +831,6 @@ &sdhci1 {
 
 	vmmc-supply = <&vdd_3v3_sd>;
 	vqmmc-supply = <&vdd_sd_dv>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
 	cd-debounce-delay-ms = <100>;
@@ -849,7 +847,6 @@ &sdhci2 {
 	ti,fails-without-test-cd;
 	cap-power-off-card;
 	keep-power-in-suspend;
-	ti,driver-strength-ohm = <50>;
 	assigned-clocks = <&k3_clks 157 158>;
 	assigned-clock-parents = <&k3_clks 157 160>;
 	#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 6806288ec227..f283777d54b4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -561,7 +561,6 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		ti,trm-icp = <0x2>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index c99b2e90f76d..f241637a5642 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -582,7 +582,6 @@ &sdhci1 {
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 8c73587b0b62..5c9b73726ebd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -422,7 +422,6 @@ &sdhci1 {
 	vqmmc-supply = <&vddshv_sdio>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	bootph-all;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 6dd496cd459a..3c45782ab2b7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -411,7 +411,6 @@ &sdhci0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
@@ -421,7 +420,6 @@ &sdhci1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 9bfa0a969bfc..a29847735c6e 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -646,7 +646,6 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 3>, <&k3_clks 58 4>;
 		clock-names = "clk_ahb", "clk_xin";
-		ti,trm-icp = <0x2>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 5c546ae76d3e..f308076d608a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -508,7 +508,6 @@ &sdhci1 {
 	pinctrl-names = "default";
 	bus-width = <4>;
 	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index cce04e188ff6..b286eaa02ada 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -471,7 +471,6 @@ &sdhci1 {
 	pinctrl-names = "default";
 	bus-width = <4>;
 	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
-- 
2.43.0


