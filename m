Return-Path: <linux-kernel+bounces-45524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB2984320B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3DB2853E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E415258;
	Wed, 31 Jan 2024 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N5dfAM8L"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF291103;
	Wed, 31 Jan 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661444; cv=none; b=PmKU/JpTOhZk4r88xoed0guMYB0npwEzgHnCdYyrsR6//SaY2NSiKoSpeHkrUey1ResFM1/U/ZuFybZIE3D+DL4Qg718KJA1AKXemNVgOaDYhmbuyvu3ibKI5bpBhJ5ONeQuWNP5Q1zjdgjEZCLrSK9LUojfHgbWb6fL3SNR0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661444; c=relaxed/simple;
	bh=bigE3EepV9sNoml2beOok0eVzDwugI7z/SxMEMH6kyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D10svgBjvPx5xQt1a/OhroSgApPKJl+6w8iNY7GiopB7PXm3c1tg79KjiXRIG71lZ4eqyUn31qlIx9YZ387vy9ewole/mndTePQ7aK0aogScC6+UmcKmaPr5jKgzWPRB2SlQwq4WrUwk7EcKQUb9h+8ROKPC0EA+2p2T+sCCywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N5dfAM8L; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bFI5038170;
	Tue, 30 Jan 2024 18:37:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706661435;
	bh=BkvyuZpDxRgCi61BEcqjXTvloaPaLWpET4daXVO+ju0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=N5dfAM8Lhx8x+LRogl4T5Iw8MHkf5QROXb1IwJA3dc3/uQXn39bjRWgGDxRrM4F4U
	 mX4oP8mTbuSXx3sbGRDBKjSg3clJQMwQrujb3Qw+t5MiROvieM1Gnayag8CJIOM7zk
	 wP5sETEOlSiqTFRaVGhZTHlrvhsURC1UIcjPz7Gw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V0bFCB071564
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 18:37:15 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 18:37:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 18:37:15 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bEwH026520;
	Tue, 30 Jan 2024 18:37:15 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, Randolph Sapp <rs@ti.com>
Subject: [RFC PATCH 10/13] arm64: dts: ti: k3-am62-main: Update ITAP/OTAP values for MMC
Date: Tue, 30 Jan 2024 18:37:11 -0600
Message-ID: <20240131003714.2779593-11-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131003714.2779593-1-jm@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update MMC0/MMC1 OTAP/ITAP values according to the datasheet
[0], refer to Table 7-79 for MMC0 and Table 7-97 for MMC1.

[0] https://www.ti.com/lit/ds/symlink/am625.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 49 +++++++++++-------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 464b7565d085..d10a02ede06c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -566,10 +566,7 @@ sdhci0: mmc@fa10000 {
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
-		ti,otap-del-sel-ddr52 = <0x5>;
-		ti,otap-del-sel-hs200 = <0x5>;
-		ti,itap-del-sel-legacy = <0xa>;
-		ti,itap-del-sel-mmc-hs = <0x1>;
+		ti,otap-del-sel-hs200 = <0x6>;
 		status = "disabled";
 	};
 
@@ -581,19 +578,19 @@ sdhci1: mmc@fa00000 {
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
 		ti,trm-icp = <0x2>;
-		ti,otap-del-sel-legacy = <0x8>;
-		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0x0>;
-		ti,otap-del-sel-sdr25 = <0x0>;
-		ti,otap-del-sel-sdr50 = <0x8>;
-		ti,otap-del-sel-sdr104 = <0x7>;
-		ti,otap-del-sel-ddr50 = <0x4>;
-		ti,itap-del-sel-legacy = <0xa>;
-		ti,itap-del-sel-sd-hs = <0x1>;
-		ti,itap-del-sel-sdr12 = <0xa>;
-		ti,itap-del-sel-sdr25 = <0x1>;
 		ti,clkbuf-sel = <0x7>;
 		bus-width = <4>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		status = "disabled";
 	};
 
@@ -605,18 +602,18 @@ sdhci2: mmc@fa20000 {
 		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
 		clock-names = "clk_ahb", "clk_xin";
 		ti,trm-icp = <0x2>;
-		ti,otap-del-sel-legacy = <0x8>;
-		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0x0>;
-		ti,otap-del-sel-sdr25 = <0x0>;
-		ti,otap-del-sel-sdr50 = <0x8>;
-		ti,otap-del-sel-sdr104 = <0x7>;
-		ti,otap-del-sel-ddr50 = <0x8>;
-		ti,itap-del-sel-legacy = <0xa>;
-		ti,itap-del-sel-sd-hs = <0xa>;
-		ti,itap-del-sel-sdr12 = <0xa>;
-		ti,itap-del-sel-sdr25 = <0x1>;
 		ti,clkbuf-sel = <0x7>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		status = "disabled";
 	};
 
-- 
2.34.1


