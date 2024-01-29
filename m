Return-Path: <linux-kernel+bounces-42632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA0840418
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB566B2338B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9C5FDB4;
	Mon, 29 Jan 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hnzPDKIu"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090E5EE62;
	Mon, 29 Jan 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528893; cv=none; b=MTse1GDXXX9NaVPjvd4heE/F+QN//bPkF5ywYmYFO9qvxEwUy85yNA1D1Co/UoFAOICn4JMLhe9qNIRVbeCFxOM8B9nEi+sNgknKtyjU5r+IhkEKJetc98CFhnwf1XylNgmj1bEhHrxp+CykhQEmrG9XHJtIXaHBaGntE5q4gY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528893; c=relaxed/simple;
	bh=pfP0xNI/7JKSykPldZzBvyXtN2bPgZXJcpiC/Ax6Wuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDLMDC5hiN2QLlB1kKzHvclYXLAyndNg/SA7xSERAdYcc7GIEr2+wSyGdgasua9qyfXoVHBXY+QzidEB3ncdU5l4tYU2iy2LQTRSH1d/ZtcWyRu8G3hGLT3v2Jj8NWU7e+slFHvQhS+zioWNyLlwKVRY6cJ7qTmxGK/7l51fb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hnzPDKIu; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TBlvLd066383;
	Mon, 29 Jan 2024 05:47:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706528877;
	bh=0sWxiHlpivfW1+Li6RxXbv6yZcR0IpqqJdMeSoHquzI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hnzPDKIuJWn2cr9MYeCLov1yNdG+oByZk25JZYEmfvdqNjJF7Zmtjtlwu9ipoc156
	 GlH++lmpUyaQFZu22EeCOVtwV8MyUUAvx8B3kbMzNm746e/Iz6xT5CST2WHdx5w2aM
	 L/3qhxzKFp8r0fm88k+sEkJyUURQAtSjYPqNHnrw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TBlv7x125655
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 05:47:57 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 05:47:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 05:47:57 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TBloqQ029678;
	Mon, 29 Jan 2024 05:47:54 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
Date: Mon, 29 Jan 2024 17:17:47 +0530
Message-ID: <20240129114749.1197579-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129114749.1197579-1-s-vadapalli@ti.com>
References: <20240129114749.1197579-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI's J784S4 has two instances of Gen3 x4 Lane PCIe Controllers namely
PCIE0 and PCIE1. Add support for the Root Complex Mode of operation of
these PCIe instances.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 56c8eaad6324..55ab2ba04960 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -721,6 +721,90 @@ main_sdhci1: mmc@4fb0000 {
 		status = "disabled";
 	};
 
+	pcie0_rc: pcie@2900000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02900000 0x00 0x1000>,
+		      <0x00 0x02907000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x10000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 332 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 332 0>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+				<0 0 0 2 &pcie0_intc 0>,
+				<0 0 0 3 &pcie0_intc 0>,
+				<0 0 0 4 &pcie0_intc 0>;
+		status = "disabled";
+
+		pcie0_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 312 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	pcie1_rc: pcie@2910000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 333 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 333 0>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x10000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
+			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+				<0 0 0 2 &pcie1_intc 0>,
+				<0 0 0 3 &pcie1_intc 0>,
+				<0 0 0 4 &pcie1_intc 0>;
+		status = "disabled";
+
+		pcie1_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
 	serdes_wiz0: wiz@5060000 {
 		compatible = "ti,j784s4-wiz-10g";
 		#address-cells = <1>;
-- 
2.34.1


