Return-Path: <linux-kernel+bounces-70993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF185859F20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9EB283676
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32695224D4;
	Mon, 19 Feb 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FZW+i+br"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC122F0F;
	Mon, 19 Feb 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333494; cv=none; b=KHRzUAnt+/vrZIgZSaSCkbkYWUmH+PZBvlQcF3AA7bXlfouIJSCS4a0kOewTuQffcgYZuQqlydkIuYqSxQU3UiO5Lnq2Owm+tBhHyrcNJuG+QKQweYRpu3heraWvYv/qo0R/07ZNhUf1nyzSz8XN228SciCwGipmMK1wIIWYZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333494; c=relaxed/simple;
	bh=4nHzmmScnB6u8alRBLQ2zpIryKuEIYDSKVWCionSE18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPQp4YbnlqW/cwX7aFzKBXdHEAz0teCyOW0G021sWJBsmw4Ifcc0OLHC8VgUYZ5cpEwKtMUmMXYdHkHy9cmU9ZvBepsNEcHxsXlvDQVeWLd9Qk8CzfEqbrMkFJGjCaYrhvtnkUbX0k+BsZ1gOz9iJcyQ7rrXIBIoWWfcAlomdnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FZW+i+br; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41J94kLh078768;
	Mon, 19 Feb 2024 03:04:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708333486;
	bh=UX+R3vrf/vh6sGWWi37SEiGJ2+BZgfectRVJ4DobpLE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FZW+i+brcKi+FeZ/Qxh0CqyXXtS4K8tMncYuwxisXooe5sHgPGbDNK9PRQAldG6/d
	 LXM525mgcrLjO3q780WgLVtZFkFWe1Ru9bx/nrOOBateUQKKc9eJ2n6xaWcsf5yVuj
	 MK8tyiErfpNPqMst6KHPn3Sb2tEGOnqGq0Wffie4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41J94kEF116027
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 03:04:46 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 03:04:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 03:04:46 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41J94ZnW011977;
	Mon, 19 Feb 2024 03:04:43 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support
Date: Mon, 19 Feb 2024 14:34:35 +0530
Message-ID: <20240219090435.934383-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219090435.934383-1-vaishnav.a@ti.com>
References: <20240219090435.934383-1-vaishnav.a@ti.com>
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

V1->V2:
  * Update comments indicating PAD numbers. 

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 79 +++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 9e12a6e9111f..cee3a8661d5e 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -169,6 +169,23 @@ J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
 		>;
 	};
 
+	ospi0_pins_default: ospi0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0000, PIN_OUTPUT, 0) /* (L24) OSPI0_CLK */
+			J722S_IOPAD(0x002c, PIN_OUTPUT, 0) /* (K26) OSPI0_CSn0 */
+			J722S_IOPAD(0x000c, PIN_INPUT, 0) /* (K27) OSPI0_D0 */
+			J722S_IOPAD(0x0010, PIN_INPUT, 0) /* (L27) OSPI0_D1 */
+			J722S_IOPAD(0x0014, PIN_INPUT, 0) /* (L26) OSPI0_D2 */
+			J722S_IOPAD(0x0018, PIN_INPUT, 0) /* (L25) OSPI0_D3 */
+			J722S_IOPAD(0x001c, PIN_INPUT, 0) /* (L21) OSPI0_D4 */
+			J722S_IOPAD(0x0020, PIN_INPUT, 0) /* (M26) OSPI0_D5 */
+			J722S_IOPAD(0x0024, PIN_INPUT, 0) /* (N27) OSPI0_D6 */
+			J722S_IOPAD(0x0028, PIN_INPUT, 0) /* (M27) OSPI0_D7 */
+			J722S_IOPAD(0x0008, PIN_INPUT, 0) /* (L22) OSPI0_DQS */
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


