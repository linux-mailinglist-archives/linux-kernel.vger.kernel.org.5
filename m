Return-Path: <linux-kernel+bounces-62750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BAB85253B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF651F24A85
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9012FF68;
	Tue, 13 Feb 2024 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wp6Nzt2N"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD312F5AF;
	Tue, 13 Feb 2024 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783872; cv=none; b=jER/rSGH8uULX1NiZUVugBK2E7ks2lo35BkW/QEmWyrqI8gy4x83ZmCdpLH0OWS4xuIzgec+fZEQCZNURjMNBZ1s12z/IAXxfCRyeUoVdZBmXkPsnoeaEG2QhdNvsHZm3+wSOz7Op9fmnWjVb2CPIAihyPdsiSsVhngiTfkgev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783872; c=relaxed/simple;
	bh=7sC8GUSLvBfWyxWtk6oRxf0moa7Awi8o9E3ijj+GgZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9w5WisPOf6T60PD0Cz1sx2yWA/CY6MSNTrEP2brjIPBwSh+EIp+wtH7rStabTuhEk+2sUsEwCffvBv8XLm3YXaQ7pserq2e7t7HdlCO4wWEWkroCxtmlU0QapLtLRTVkexC+sprd+lGO8yUvA5ZhmSBICt+/f7e1Z7SOFtbZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wp6Nzt2N; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D0OHSV088680;
	Mon, 12 Feb 2024 18:24:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707783857;
	bh=SsPXo9SU5AZfR9W25lHGx7P3x7huSy5Ek3nDYu+grKw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wp6Nzt2NRsCPdrrUBljeNQl6QZaclftsqvh0BFxiT2TGCoJCrlmpk8DR3U4oee8Vk
	 QMommIMdnt1Gx3ar3ThnP0OfxObiDz5eCwgAl+SUgZH8cRz/DrtAJiVGUsASvLBBUs
	 VrC/bDbog9gJR42V927G8ob+YBNnnCohTYCfvldc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D0OHh4031103
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 18:24:17 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 18:24:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 18:24:16 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D0OGXj119810;
	Mon, 12 Feb 2024 18:24:16 -0600
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
Subject: [PATCH v2 5/9] arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC
Date: Mon, 12 Feb 2024 18:24:12 -0600
Message-ID: <20240213002416.1560357-6-jm@ti.com>
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

Add OTAP/ITAP values to enable HS400 timing for MMC0 and
SDR104 timing for MMC1/MMC2. Remove no-1-8-v property to
enable the highest speed mode possible.

Update MMC OTAP/ITAP values according to the datasheet
[0], refer to Table 7-79 for MMC0 and Table 7-97 for MMC1/MMC2.

[0] https://www.ti.com/lit/ds/symlink/am62p.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 44 +++++++++++++++++++++--
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts   |  1 -
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index ef1c982a90d8..e43530beb79f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -534,7 +534,21 @@ sdhci0: mmc@fa10000 {
 		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 57 2>;
 		assigned-clock-parents = <&k3_clks 57 4>;
-		ti,otap-del-sel-legacy = <0x0>;
+		bus-width = <8>;
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		mmc-hs400-1_8v;
+		ti,clkbuf-sel = <0x7>;
+		ti,strobe-sel = <0x77>;
+		ti,trm-icp = <0x8>;
+		ti,otap-del-sel-legacy = <0x1>;
+		ti,otap-del-sel-mmc-hs = <0x1>;
+		ti,otap-del-sel-ddr52 = <0x6>;
+		ti,otap-del-sel-hs200 = <0x8>;
+		ti,otap-del-sel-hs400 = <0x5>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,itap-del-sel-ddr52 = <0x3>;
 		status = "disabled";
 	};
 
@@ -545,7 +559,19 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		ti,otap-del-sel-legacy = <0x8>;
+		bus-width = <4>;
+		ti,clkbuf-sel = <0x7>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		status = "disabled";
 	};
 
@@ -556,7 +582,19 @@ sdhci2: mmc@fa20000 {
 		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		ti,otap-del-sel-legacy = <0x8>;
+		bus-width = <4>;
+		ti,clkbuf-sel = <0x7>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 95a0146279b1..8c73587b0b62 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -424,7 +424,6 @@ &sdhci1 {
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
-	no-1-8-v;
 	bootph-all;
 };
 
-- 
2.43.0


