Return-Path: <linux-kernel+bounces-73578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624DC85C471
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2904D1C2099D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48468146907;
	Tue, 20 Feb 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jyMyg2n8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0B76C9C;
	Tue, 20 Feb 2024 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456496; cv=none; b=gpteFEbQoLFdsded106BGu7X8fKe4kyUhQy1r+4JkaSXZH56QWwwZ00ukweQN0H5OWanG0pdZ4tFV1HH03VZ0nPPKpzEeHERePvqFTtzjkkQGQNP5cTbyfoP0xv2/OpghP3gQRB/WTD1AFuIXN2qutUoUvgGG2TQ0bhtXcDsEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456496; c=relaxed/simple;
	bh=j0O1mXMrb5m/CXz+6ehaJEQqhd0fu8HGYpIsoW19MIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mt+Ru89KPNxdrJPOYN8qpkHNd6+XbnxjbnEubIX/sdO0bI50UrDWmWefd/j3Vxd863ETeTaMgzcIQz2DJnY/htp/G4VBmD/EUL55zeW6jsmjp8oOSULtqohX5nv8O+0WgyXlA590MQr10jT87PD4fDx2yhEjq8CUf8CIN49aT8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jyMyg2n8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KJEZcH000621;
	Tue, 20 Feb 2024 13:14:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708456475;
	bh=F8FlhrAZEpAEKjHRSghkEmlUPIVrut9OSRFeuhGNSDI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jyMyg2n8KHLhMpT3FDQ3ewAKujZLCEkipy4Qn/2Ttjdb5z8XWxi7Al2rUMuwR3oO8
	 4WNMaF0OhfPEXqG4G3AhiyBRW3DKYmUSAWbK+1qbXn2FyD+JMyeZBnEgylIN8pKxK8
	 YefLt9Ic8PoWhJ4WJaD3mu6tGb8y4cBDJ0+CrD8w=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KJEZ37075422
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 13:14:35 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 13:14:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 13:14:35 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KJEKoO051513;
	Tue, 20 Feb 2024 13:14:35 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>
CC: Andrew Davis <afd@ti.com>, Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v5 1/4] arm64: dts: ti: k3-j784s4: Add Wave5 Video Encoder/Decoder Node
Date: Tue, 20 Feb 2024 13:14:10 -0600
Message-ID: <20240220191413.3355007-2-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220191413.3355007-1-b-brnich@ti.com>
References: <20240220191413.3355007-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch adds support for the Wave521cl on the J784S4-evm.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 16 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi      |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index f2b720ed1e4f..40dd2e8a9f98 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -662,6 +662,22 @@ main_i2c6: i2c@2060000 {
 		status = "disabled";
 	};
 
+	vpu0: video-codec@4210000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x4210000 0x00 0x10000>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 241 2>;
+		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	vpu1: video-codec@4220000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x4220000 0x00 0x10000>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 242 2>;
+		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+	};
+
 	main_sdhci0: mmc@4f80000 {
 		compatible = "ti,j721e-sdhci-8bit";
 		reg = <0x00 0x04f80000 0x00 0x1000>,
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 4398c3a463e1..2f633721a0c6 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -235,6 +235,8 @@ cbass_main: bus@100000 {
 		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
+			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
+			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
 			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
 			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
-- 
2.34.1


