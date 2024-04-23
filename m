Return-Path: <linux-kernel+bounces-155450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5828AEABD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FB828B3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0623713C81E;
	Tue, 23 Apr 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kcbifMMN"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5C5820E;
	Tue, 23 Apr 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885464; cv=none; b=nnUR2nvrk2zqMVuwCP35eTIMxdykrCZEwfv720doC2SgK6r7XbIlUO1OIBGgTukVNeji/gsi4Wel+nmW1fFFR4lTnso9eBFSucRshLK4lMhDkyimmJTT3KbSQ06Xb/xrUuOxy4Kb42MSWsn8zvDF4SXGZ0MBOtIenlGNcLeDH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885464; c=relaxed/simple;
	bh=11X1XUAxVaW4b16EfFWhWg9RCuLlRPTWcapG2V7xXTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4fIsXAJtxEi2qf02x6rpQyudaBo8DlPhlVmhBKDoBEy1bBg4EI2OvILPLpHp00rwsWimQ9B2XVLFIpg7947y0Ke7eAXVKxaYMPChhCML6rTsbJTMz7SSQhpS4dBZoJoJZFbKSlZTKURsNEclHYykZ1PVlicQ8TmCrsuxVKaKMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kcbifMMN; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWKF060829;
	Tue, 23 Apr 2024 10:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713885452;
	bh=h22C2hujtGXlxvbATtGe/0Gh3kVEv7O7ltevjWhcaB0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kcbifMMNCst26oyhQIIGZNdbOTeeL1ct7iNR4WU5Q/+0RijalhgWTY1Z6CsTx7CJA
	 XUdsc+NbZrk5/8g1MEMlMAqF7/mHEnw1Gvi7o668PWzzbCrN+DE6Z3+vWk9KUVPFjz
	 TZMO1jTLxZaKEmALhsxpa7uJVTsKoZvl5qPO+EUk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NFHWNA098205
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 10:17:32 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 10:17:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 10:17:32 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWYH080176;
	Tue, 23 Apr 2024 10:17:32 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>, Dasnavis
 Sabiya <sabiya.d@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 1/5] arm64: dts: ti: k3-am65-main: Fix sdhci node properties
Date: Tue, 23 Apr 2024 10:17:28 -0500
Message-ID: <20240423151732.3541894-2-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423151732.3541894-1-jm@ti.com>
References: <20240423151732.3541894-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update otap-del-sel properties as per datasheet [0].

Add missing clkbuf-sel and itap-del-sel values also as per
datasheet [0].

Move clkbuf-sel and ti,trm-icp above the otap-del-sel properties
so the sdhci nodes could be more uniform across platforms.

[0] https://www.ti.com/lit/ds/symlink/am6548.pdf

Fixes: eac99d38f861 ("arm64: dts: ti: k3-am654-main: Update otap-del-sel values")
Fixes: d7600d070fb0 ("arm64: dts: ti: k3-am65-main: Add support for sdhci1")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- no change
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 670557c89f756..0803a8b9bfe84 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -435,6 +435,8 @@ sdhci0: mmc@4f80000 {
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
@@ -445,8 +447,7 @@ sdhci0: mmc@4f80000 {
 		ti,otap-del-sel-ddr50 = <0x5>;
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x5>;
-		ti,otap-del-sel-hs400 = <0x0>;
-		ti,trm-icp = <0x8>;
+		ti,itap-del-sel-ddr52 = <0x0>;
 		dma-coherent;
 		status = "disabled";
 	};
@@ -458,18 +459,22 @@ sdhci1: mmc@4fa0000 {
 		clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
 		clock-names = "clk_ahb", "clk_xin";
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0x0>;
-		ti,otap-del-sel-sdr25 = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0x8>;
 		ti,otap-del-sel-sdr104 = <0x7>;
 		ti,otap-del-sel-ddr50 = <0x4>;
 		ti,otap-del-sel-ddr52 = <0x4>;
 		ti,otap-del-sel-hs200 = <0x7>;
-		ti,clkbuf-sel = <0x7>;
-		ti,trm-icp = <0x8>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-sd-hs = <0x1>;
+		ti,itap-del-sel-sdr12 = <0xa>;
+		ti,itap-del-sel-sdr25 = <0x1>;
 		dma-coherent;
 		status = "disabled";
 	};
-- 
2.43.2


