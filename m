Return-Path: <linux-kernel+bounces-141685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2B08A21FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6892B24019
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFDF4EB38;
	Thu, 11 Apr 2024 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VGP6d1eA"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE24D11B;
	Thu, 11 Apr 2024 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876000; cv=none; b=CHYpu1u34d9cKbIqAp+pRHc8zX0Vzah2795HUok5gwKMKa5zjeuJG9FNV3AP8oi6ZTO2c/uTG9VrhtW4tSNGKz5eQupU8tuhA6De9m2ruSy4lXkyp96DS0y/dApbZElYYBeFUOKcO/JlOkGmPZMIMmBAnB0JwcQpV3HDnvq0N4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876000; c=relaxed/simple;
	bh=fnwZwdTZHz7xYfHZkK8HW17q7uRXp9xrFm416v6m5KA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mt1F5eNtw6qPlpjY1uFWGp5dFLDllE5yEH9WBxeONPOkJMK5FgTsKUgANNTao4jj+7AXUjmX4XodFYi4bVLniO8JwUZdZkfdjopQRzfvhSwCoFf40u0Bsu7OW+BLTCt6xCMkkUoGF6BNSna4mHe4lOJFtq7CeMD9sznfZf74c+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VGP6d1eA; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqvCJ033916;
	Thu, 11 Apr 2024 17:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712875978;
	bh=izg+oGQCuUwOQiPJW6J8T+O9QAeRgI3fYhFwd8fM1Pc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VGP6d1eA94Cfxc1xdiVJgOZ7h5NL+n3Q0EnvCMjDZyixWBRZB5jkhJiDVmfH4SkSs
	 SnnH6Kh5yd7jwpm89wjk7Utu+Nkb9cd14VpDAnghL/APxl2LJDfbVeVH+4Z1zmg0BL
	 J3L0OkPqc2qvRPa4FRYj4LKh8vYK78w3k5pJjuuk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43BMqv7R083766
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 17:52:57 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 17:52:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 17:52:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqv7X002381;
	Thu, 11 Apr 2024 17:52:57 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 1/7] arm64: dts: ti: k3-am65-main: Update sdhci properties
Date: Thu, 11 Apr 2024 17:52:51 -0500
Message-ID: <20240411225257.383889-2-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411225257.383889-1-jm@ti.com>
References: <20240411225257.383889-1-jm@ti.com>
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


