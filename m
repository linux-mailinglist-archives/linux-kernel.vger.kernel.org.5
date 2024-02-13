Return-Path: <linux-kernel+bounces-64582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB0E854088
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51EBFB29653
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3E65E05;
	Tue, 13 Feb 2024 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cdf4lYD2"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032E65BD2;
	Tue, 13 Feb 2024 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868665; cv=none; b=alhj3ht6HP2HWTEaLsSKgrZiznki+cSHwoNGZp+cdV1NFkt01n8dhOZzDq72Kcxrt02KXAKuRQRXp4Vf0d0ItK/SttBTeA3LiqdKC5aid9AoslCeQ08LJsEpktpGQlQU93hCIlwqvVhTybLc+/04tOMEq22MJKtYGDec/TsAIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868665; c=relaxed/simple;
	bh=ZFA3IWG9B+mikyn3NjXSR/I5s24rz2/+G4e0DSrnMSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6KBTFqmeKQ83DGKUer6gg05Ii6RsVcmCVYuzhOyFxUPvOb/CoU6SwQnzNrKQphO4sw0tbE81xHQF2Ua4I1QeECiR0ix8J/PkTqrA53uX661ym6CdEEB8qYFTkrqEojgH+sc0wvFwvw8K7a6vjrHpp2tHr9hiQ+e4kjMGWRnQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cdf4lYD2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv2sg082886;
	Tue, 13 Feb 2024 17:57:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707868622;
	bh=MrgqCcJZWvplOTxl4Hx9yiiz3emCLg7ynf3Njgfv7rU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cdf4lYD2FggDjX/krUFUSxJTC/BM/XhtjrzQ1Olorx4m2lmQApOo3r6XJm5nEcFCo
	 eM2Ytkxo5yX0frYd9sWOHzlsvRCOl66n/Aa3An4H0KV1IRm92wtfqYK14x3x4FjhPV
	 7x3cBPVb80+Ev3Fg3usslCjBT+ujDrQOoju03eAc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41DNv2SJ050666
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 17:57:02 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 17:57:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 17:57:01 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv1RB091761;
	Tue, 13 Feb 2024 17:57:01 -0600
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
Subject: [PATCH v3 7/9] arm64: dts: ti: k3-am6*: Fix ti,clkbuf-sel property in MMC nodes
Date: Tue, 13 Feb 2024 17:56:59 -0600
Message-ID: <20240213235701.2438513-8-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213235701.2438513-1-jm@ti.com>
References: <20240213235701.2438513-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move ti,clkbuf-sel property above the OTAP/ITAP delay values.
While there is no error with where it is currently at, it is
easier to read the MMC node if ti,clkbuf-sel is located above
the OTAP/ITAP delay values consistently across MMC nodes.

Add missing ti,clkbuf-sel for MMC0 in k3-am64-main.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since V3:
- No change
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi  | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 79ed5cbbbda1..410b390ce5d5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -579,6 +579,7 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
+		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0x0>;
@@ -590,7 +591,6 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x1>;
 		ti,itap-del-sel-sdr12 = <0xa>;
 		ti,itap-del-sel-sdr25 = <0x1>;
-		ti,clkbuf-sel = <0x7>;
 		bus-width = <4>;
 		status = "disabled";
 	};
@@ -602,6 +602,7 @@ sdhci2: mmc@fa20000 {
 		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
 		clock-names = "clk_ahb", "clk_xin";
+		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0x0>;
@@ -613,7 +614,6 @@ sdhci2: mmc@fa20000 {
 		ti,itap-del-sel-sd-hs = <0xa>;
 		ti,itap-del-sel-sdr12 = <0xa>;
 		ti,itap-del-sel-sdr25 = <0x1>;
-		ti,clkbuf-sel = <0x7>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index f283777d54b4..ddb76cd66f88 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -561,6 +561,7 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
+		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
@@ -572,7 +573,6 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
-		ti,clkbuf-sel = <0x7>;
 		bus-width = <4>;
 		no-1-8-v;
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index a29847735c6e..bea05be7cb48 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -628,6 +628,7 @@ sdhci0: mmc@fa10000 {
 		clock-names = "clk_ahb", "clk_xin";
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
+		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x2>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
@@ -646,6 +647,7 @@ sdhci1: mmc@fa00000 {
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 3>, <&k3_clks 58 4>;
 		clock-names = "clk_ahb", "clk_xin";
+		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
@@ -657,7 +659,6 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
-		ti,clkbuf-sel = <0x7>;
 		status = "disabled";
 	};
 
-- 
2.43.0


