Return-Path: <linux-kernel+bounces-45529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27262843218
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A728DB21D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3484E576;
	Wed, 31 Jan 2024 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zTUWQw30"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED917139E;
	Wed, 31 Jan 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661445; cv=none; b=O0oPZjx7L7iY/k5QAJlmTKDJCrRRL90z04rbHXKLZTxp0/RXdi2SkqS6Q9+rq02FDRbewA/PVkWEqkZW4JprmFHbXaEB5BMJI8ezrV2DA855gxDonD4f/BNLQsTOuqulR9in8sgHorJ5Us7A5KBq58qakncmdhG8PrL1ze4KO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661445; c=relaxed/simple;
	bh=VoaHMnbiB4InY0n1diaV3Seie5O8+ODnxvi4wD3A9AY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmhBSrZci6nDa/383EdP4PvrPy29tqulABTW9/r+Rw7OcbcJggYAo9wJz25DiBbs0RwOEkGnpZ3m/a823fYy5VrftsDXfAWl7F9nGXPhk5FMC6p69FgN7fb4NOWX83cvqh3/sEc/bRoZYaN6fQX56vadOz+mlGRvJokGjj7x4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zTUWQw30; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bF8j031408;
	Tue, 30 Jan 2024 18:37:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706661435;
	bh=u/6Pxik58VJUCHSPJKRuRr57oOiGRkcoH1Dp3zB/20s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=zTUWQw304cPdc6IpAYO/VoL0qHN8LsP/25j/oORRNbC4BCBJ0v8s3zAu0uZo6JgtY
	 c080UhCcFJ0zlg57Z1rkOY/VqAENp3C09ms9UqYUOq7YwvwpPw2Kx8niRWbvDKB3Zj
	 8ALBTWreCzcS5LkwmfOQb5cnFmhn7DdCQO0jv3PU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V0bFip045574
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 18:37:15 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 18:37:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 18:37:15 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bEwF026520;
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
Subject: [RFC PATCH 08/13] arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
Date: Tue, 30 Jan 2024 18:37:09 -0600
Message-ID: <20240131003714.2779593-9-jm@ti.com>
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

Add sdhci2 DT node in k3-am62a-main for mmc2. Add otap/itap
values according to the datasheet[0], Refer to Table 7-97.

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 523dee78123a..227e7fb3e5bb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -579,6 +579,30 @@ sdhci1: mmc@fa00000 {
 		status = "disabled";
 	};
 
+	sdhci2: mmc@fa00000 {
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
2.34.1


