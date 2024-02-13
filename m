Return-Path: <linux-kernel+bounces-62755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8504585254A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1520FB2615E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35988134CEA;
	Tue, 13 Feb 2024 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yxAJqRPl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71458130E2A;
	Tue, 13 Feb 2024 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783876; cv=none; b=by1pwuLoXQUcN8dfhSUedlyMmG+ErfzDzivrKFVoszr7vbuCOrkSyqfCZBqo9dg9D5cgrwQwy0J1Rvt0RdhxNVeKpc6Q1EeaSClf4QaCXnStP2MIgLmZ3rSJGVxtOuggu3KqVbvBX/VFbRmvYMmY2EB5NQScOfpT1jdXP03pZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783876; c=relaxed/simple;
	bh=YOXmGuD6/jcIrqtJeIXapHB8zHPclkc7DkY1LKzLUgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltNGMQeujwwDYLGXFLg3WhD6XwALaEf11d04oPmqPnyW54sTLyJ/k7zClF913bIAtNGG7NzEeEdxG8o6EvxqUeYpn4rnGMEacIGE8Qpb1AC8/uXFsMQdMTQ32/lY5BBS2ANnb5gozWxivzNISgUAQbl6TjrRnPL+LXrq2rO+XU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yxAJqRPl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D0OHDI065795;
	Mon, 12 Feb 2024 18:24:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707783857;
	bh=f0ObBW14vGk6xzmyWDC9VW/YrN60QbE+TGAdLw92viY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yxAJqRPlV2h3/XVjyVve3fIVXk5k0aZWYppVunXaldLxfecQjfqrJ5w9pKeue37ie
	 U3arfD/FAcgLeVR2+vTkfELHi3X3TjLp5vTUFaY2IBbQ4SOnuWuojkTBtbrsbcZ4ly
	 5V0SDV42lhr2NDIHB57MK0yFZoQTJ2K0A5EJ6JjU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D0OHh3031103
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 18:24:17 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 18:24:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 18:24:16 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D0OGXf119810;
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
Subject: [PATCH v2 1/9] arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
Date: Mon, 12 Feb 2024 18:24:08 -0600
Message-ID: <20240213002416.1560357-2-jm@ti.com>
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

From: Nitin Yadav <n-yadav@ti.com>

Add sdhci0 DT node in k3-am62a-main for eMMC support. Add otap/itap
values according to the datasheet[0], refer to Table 7-79.

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 972971159a62..ce5f278235a4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -536,6 +536,24 @@ main_gpio1: gpio@601000 {
 		status = "disabled";
 	};
 
+	sdhci0: mmc@fa10000 {
+		compatible = "ti,am62-sdhci";
+		reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
+		clock-names = "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 57 6>;
+		assigned-clock-parents = <&k3_clks 57 8>;
+		bus-width = <8>;
+		mmc-hs200-1_8v;
+		ti,clkbuf-sel = <0x7>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-hs200 = <0x6>;
+		status = "disabled";
+	};
+
 	sdhci1: mmc@fa00000 {
 		compatible = "ti,am62-sdhci";
 		reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
-- 
2.43.0


