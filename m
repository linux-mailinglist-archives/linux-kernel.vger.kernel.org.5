Return-Path: <linux-kernel+bounces-64579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D59854080
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59AB285081
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212ED657B2;
	Tue, 13 Feb 2024 23:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UcuK6sEF"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DE65198;
	Tue, 13 Feb 2024 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868643; cv=none; b=a7VNauGQWphwG+52UL5DODvWtz8Wg9NkT4TJbOd8k0LaLsWPoSA05+AmbBsFV4PffmYoWLLSq19pFo0POyx1HHCqdb3z0d7H+sWhMT+nls5VOxn4l/3uYNVdIw0o+5L4zYMEWOFfdO3uJkCCpGT+aDO0kxBkCjJ0N2GKnEHJkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868643; c=relaxed/simple;
	bh=DC9oMmbd7UFDMnsBgZP8ZlZhS3wWKOj0n0KJpssTlnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpkMSfk112SQpra7YRbZ2X805Vqd93ggy8hPcdc9qxF2IlUbbeqCFZvCd7rDMTBK2AseNa+/2o61sKjPOvEUEMVHZ6XDICoITC1X+kQjhVUkIwPxUW37SETjSPUPw5o3Y9/ZpDEqgPZqd+jBj5wS/4apY4i5LbA7VolwqwqZDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UcuK6sEF; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv2Ck082882;
	Tue, 13 Feb 2024 17:57:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707868622;
	bh=aL+gNiBwbVuENrnugNe19duI8fO9uL7bvEw/nOCWuDY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UcuK6sEFuwxrf37QTpu8n630BdjHXFDiEvDujBoCnXj8wXAgHT2bohSEelU+2rLdk
	 vw086FwlUbTL4qVjswehdaT1r7Sk2cLKZsSwGTGQEAsNqBN2pkkGVKKEcNoERuYx1m
	 Uv41L9eh1fWaR/T+ZOfRz1QSDHOGhu+07aE/kYUc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41DNv2XO074653
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 17:57:02 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 17:57:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 17:57:01 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv1R9091761;
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
Subject: [PATCH v3 5/9] arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC
Date: Tue, 13 Feb 2024 17:56:57 -0600
Message-ID: <20240213235701.2438513-6-jm@ti.com>
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

Add OTAP/ITAP values to enable HS400 timing for MMC0 and
SDR104 timing for MMC1/MMC2. Remove no-1-8-v property to
enable the highest speed mode possible.

Update MMC OTAP/ITAP values according to the datasheet
[0], refer to Table 7-79 for MMC0 and Table 7-97 for MMC1/MMC2.

[0] https://www.ti.com/lit/ds/symlink/am62p.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since V3:
- No change
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


