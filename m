Return-Path: <linux-kernel+bounces-68673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BCF857E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61928283763
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58A12C542;
	Fri, 16 Feb 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qmqBO/9D"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8712BF1B;
	Fri, 16 Feb 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091752; cv=none; b=Rd6sIgVPxTGlDKcvb2tUJpORhZiZbca8EtDX3p12VWR+nT2Yhv8l2Jb0DLdcosMzbbsJCo4rBkF5VNumnz75yCAIPwWezCdGZeecOCxNfoTpkgdj10l7WumNh6juXuEW6kKfn90NO9fnCNIKvunUucOOiArOs1MjQbyinJJZ9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091752; c=relaxed/simple;
	bh=XYz1rPCO/pl409zYn8/NwIiH1CytMgN61xqsw1SrGmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp+JE4GTquAcpGaiHMEGklrUJvDeP+IUYP7VsjGduGUJ2ZgD5qdZSQ7fgQbk0lFAHQgeDRUZQyl+76AL8GHHvjJq8cFpDs4VQD4CsRt42LeeQTt5CeCtLmXwh5GW3qF0aUS4XeOS5RqBAn+1JPKqGD7+8YcVgkVEi416+lxLLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qmqBO/9D; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41GDtiCo095624;
	Fri, 16 Feb 2024 07:55:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708091744;
	bh=uTW/xCM8noa5bGfg4NZmPFvevjj/sJrMm1kJ3d4d4/E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qmqBO/9DrTdAMBEuzBcZLozxuzRKb8h9U52eekScjjtvfLR4FZ/sxGlB2yChMJPra
	 XjWBLAUEKlMyRrLk2GbqU9KO2WSmUyXNR/Cl3bQN6ilh6p8tqglMai0Ov4tsI6za7U
	 i/HssslPdXics8GXB4H1SzqzLbMRHNnfrpgyh6sQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41GDtiOU015343
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 07:55:44 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 07:55:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 07:55:44 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41GDtXrU127060;
	Fri, 16 Feb 2024 07:55:41 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support
Date: Fri, 16 Feb 2024 19:25:33 +0530
Message-ID: <20240216135533.904130-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216135533.904130-1-vaishnav.a@ti.com>
References: <20240216135533.904130-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J722S EVM has S28HS512T 64 MiB Octal SPI NOR flash connected
to the OSPI interface, add support for the flash and describe
the partition information as per bootloader.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 79 +++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 9e12a6e9111f..b1c6499c0c9d 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -169,6 +169,23 @@ J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
 		>;
 	};
 
+	ospi0_pins_default: ospi0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0000, PIN_OUTPUT, 0) /* (P23) OSPI0_CLK */
+			J722S_IOPAD(0x002c, PIN_OUTPUT, 0) /* (M25) OSPI0_CSn0 */
+			J722S_IOPAD(0x000c, PIN_INPUT, 0) /* (L25) OSPI0_D0 */
+			J722S_IOPAD(0x0010, PIN_INPUT, 0) /* (N24) OSPI0_D1 */
+			J722S_IOPAD(0x0014, PIN_INPUT, 0) /* (N25) OSPI0_D2 */
+			J722S_IOPAD(0x0018, PIN_INPUT, 0) /* (M24) OSPI0_D3 */
+			J722S_IOPAD(0x001c, PIN_INPUT, 0) /* (N21) OSPI0_D4 */
+			J722S_IOPAD(0x0020, PIN_INPUT, 0) /* (N22) OSPI0_D5 */
+			J722S_IOPAD(0x0024, PIN_INPUT, 0) /* (P21) OSPI0_D6 */
+			J722S_IOPAD(0x0028, PIN_INPUT, 0) /* (N20) OSPI0_D7 */
+			J722S_IOPAD(0x0008, PIN_INPUT, 0) /* (P22) OSPI0_DQS */
+		>;
+		bootph-all;
+	};
+
 	rgmii1_pins_default: rgmii1-default-pins {
 		pinctrl-single,pins = <
 			J722S_IOPAD(0x014c, PIN_INPUT, 0) /* (AC25) RGMII1_RD0 */
@@ -290,6 +307,68 @@ exp1: gpio@23 {
 	};
 };
 
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+		bootph-all;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x00 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+	};
+
+};
+
 &sdhci1 {
 	/* SD/MMC */
 	vmmc-supply = <&vdd_mmc1>;
-- 
2.34.1


