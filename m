Return-Path: <linux-kernel+bounces-64576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D1085407B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99B51F2512C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3372B6350C;
	Tue, 13 Feb 2024 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="daLHFAR+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5236633E8;
	Tue, 13 Feb 2024 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868638; cv=none; b=UJDgNtcwOL/06Y/qYBf1psbhMl8cgcAJEr3AWVzwIKvy32slClPtG0UCG8FXGpGMeQLg+iE/rnp5ItIkEqVlvylkgGh3WO1yXsgqCCPNdScAP4OveDa2uJm/GZGya0PVdykPmrPDPamOUU/m6Itjrpqgj9iO65chVjRx8Mm6QOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868638; c=relaxed/simple;
	bh=N1IauI3oM29GlU12hAw/5542YiAGL/LBAoUjegN/HoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElVgjZoAgP+kCUsuWSLQ6X2v5sAlKpMT/KTS3a3G2/qRwGH7iv2dh6E53z+g4F/u6fMOdH2icVGkxW+S1pWl6D2b5YE1Sy6YInsCp83fAwdnYS5j42G88zT7V/G6gJDBcwmH+w67ZX95qi/GoycONUFdspEyh9a9TCIM78kXTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=daLHFAR+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv1rA123603;
	Tue, 13 Feb 2024 17:57:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707868621;
	bh=P4lhyh35hABOfmAh4D9EHxcxfzu4ps9/iaRlPnFOKMc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=daLHFAR+eFzdDbrt564bewgsSaJPUMzvdTN+QEncSMIuauABYcfg3nEl2CHaJ66Wb
	 wKu4sBeiCvQlcUHCEPsbL65nbgTFcabNIvO+RR4bsGWpslACGET6gW1jJZW3dIVeuX
	 dwCi91PlVuCSjhktkzhDS2wlmIus3SrQau8viU7U=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41DNv1Pe074646
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 17:57:01 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 17:57:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 17:57:01 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv1R6091761;
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
Subject: [PATCH v3 2/9] arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
Date: Tue, 13 Feb 2024 17:56:54 -0600
Message-ID: <20240213235701.2438513-3-jm@ti.com>
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

Add sdhci2 DT node in k3-am62a-main for mmc2. Add otap/itap
values according to the datasheet[0], Refer to Table 7-97.

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since V3:
- No change
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index ce5f278235a4..6806288ec227 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -579,6 +579,30 @@ sdhci1: mmc@fa00000 {
 		status = "disabled";
 	};
 
+	sdhci2: mmc@fa20000 {
+		compatible = "ti,am62-sdhci";
+		reg = <0x00 0xfa20000 0x00 0x260>, <0x00 0xfa28000 0x00 0x134>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
+		clock-names = "clk_ahb", "clk_xin";
+		bus-width = <4>;
+		ti,clkbuf-sel = <0x7>;
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
+		no-1-8-v;
+		status = "disabled";
+	};
+
 	usbss0: dwc3-usb@f900000 {
 		compatible = "ti,am62-usb";
 		reg = <0x00 0x0f900000 0x00 0x800>;
-- 
2.43.0


