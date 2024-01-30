Return-Path: <linux-kernel+bounces-44375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E784211A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086691C2442F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F65664CC;
	Tue, 30 Jan 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O3Rtk56f"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248B6167F;
	Tue, 30 Jan 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610065; cv=none; b=ltBvYnSjpWl0qPGVGm4JZt/MwHzynIxJHL20U/zEHSScc1Gwyu7ymIdifbGvHqBLwX5Mabj111b52hDh79nDGTR7kDI84q6qPxW7MD36o/tdoN1dunm4AVOxkrDMLdlexyCPcuPsPZcVkbJFzQ1gcxObrVnB0Kg2C/lZ/xeF548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610065; c=relaxed/simple;
	bh=t4ihSeEiSJmjrjH2gowgqfEbP4xlLq5HsUJpdls5aKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZnBJZdH0+x5/U3uGb675IjDn0XqNrmE+S9Xjk/dKHTARxOWMftDAi/GzH5QOMMFLYrx1l1W57sox5gDKi9Ri/rSkd6zxIowOQvmf/Gtrykeouk4CzSoOwVMalbIPeEbSPsIWxBHPDCPwR9AdMG32lMtD08MlSKYcNISplH8sxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O3Rtk56f; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UAKlCf074007;
	Tue, 30 Jan 2024 04:20:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706610047;
	bh=LXQbUd5ai5wxnfNheSifAqcrBh8d9ymLIaXwvJnXXvo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=O3Rtk56f/amvPDs2FXgG87RSAADuU9kuFj9GiL7yD08pFRPygC5TEov/spMI1qtMP
	 GGdaVoffDF9eySIMg7YafYnpMU4LnugJfyJ2E2EnML8NlKRv/FqFfqfcKnN7zoS7wT
	 NIEjLpvdvyDme12H3f1CttbUkiwXVeqf6F0X+AQ0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UAKlD7102394
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 04:20:47 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 04:20:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 04:20:47 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UAKk6t027119;
	Tue, 30 Jan 2024 04:20:46 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j7200: Add support for CAN nodes
Date: Tue, 30 Jan 2024 15:50:42 +0530
Message-ID: <20240130102044.120483-2-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130102044.120483-1-b-kapoor@ti.com>
References: <20240130102044.120483-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for 18 CAN controllers in main domain and 2 CAN controllers
present in mcu domain. All the CAN controllers support classic CAN
messages as well as CAN_FD messages.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 270 ++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  30 ++
 2 files changed, 300 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index da67bf8fe703..58fd67be213f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -895,6 +895,276 @@ main_gpio6: gpio@630000 {
 		status = "disabled";
 	};
 
+	main_mcan0: can@2701000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02701000 0x00 0x200>,
+		      <0x00 0x02708000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 156 0>, <&k3_clks 156 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan1: can@2711000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02711000 0x00 0x200>,
+		      <0x00 0x02718000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 158 0>, <&k3_clks 158 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan2: can@2721000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02721000 0x00 0x200>,
+		      <0x00 0x02728000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 160 0>, <&k3_clks 160 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan3: can@2731000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02731000 0x00 0x200>,
+		      <0x00 0x02738000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 161 0>, <&k3_clks 161 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan4: can@2741000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02741000 0x00 0x200>,
+		      <0x00 0x02748000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 162 0>, <&k3_clks 162 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan5: can@2751000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02751000 0x00 0x200>,
+		      <0x00 0x02758000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 163 0>, <&k3_clks 163 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan6: can@2761000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02761000 0x00 0x200>,
+		      <0x00 0x02768000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 164 0>, <&k3_clks 164 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan7: can@2771000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02771000 0x00 0x200>,
+		      <0x00 0x02778000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 165 0>, <&k3_clks 165 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan8: can@2781000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02781000 0x00 0x200>,
+		      <0x00 0x02788000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 166 0>, <&k3_clks 166 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan9: can@2791000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02791000 0x00 0x200>,
+		      <0x00 0x02798000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 167 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 167 0>, <&k3_clks 167 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan10: can@27a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027a1000 0x00 0x200>,
+		      <0x00 0x027a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 168 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 168 0>, <&k3_clks 168 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan11: can@27b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027b1000 0x00 0x200>,
+		      <0x00 0x027b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 169 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 169 0>, <&k3_clks 169 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan12: can@27c1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027c1000 0x00 0x200>,
+		      <0x00 0x027c8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 170 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 170 0>, <&k3_clks 170 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan13: can@27d1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027d1000 0x00 0x200>,
+		      <0x00 0x027d8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 171 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 171 0>, <&k3_clks 171 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan14: can@2681000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02681000 0x00 0x200>,
+		      <0x00 0x02688000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 150 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 150 0>, <&k3_clks 150 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan15: can@2691000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02691000 0x00 0x200>,
+		      <0x00 0x02698000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 151 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 151 0>, <&k3_clks 151 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan16: can@26a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x026a1000 0x00 0x200>,
+		      <0x00 0x026a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 152 0>, <&k3_clks 152 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 784 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 785 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan17: can@26b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x026b1000 0x00 0x200>,
+		      <0x00 0x026b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 153 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 153 0>, <&k3_clks 153 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 787 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 788 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
 	main_spi0: spi@2100000 {
 		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
 		reg = <0x00 0x02100000 0x00 0x400>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 60b26374ae0c..11bda5c70655 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -655,4 +655,34 @@ mcu_esm: esm@40800000 {
 		ti,esm-pins = <95>;
 		bootph-pre-ram;
 	};
+
+	mcu_mcan0: can@40528000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40528000 0x00 0x200>,
+		      <0x00 0x40500000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 172 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 172 0>, <&k3_clks 172 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 832 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_mcan1: can@40568000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40568000 0x00 0x200>,
+		      <0x00 0x40540000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 173 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 173 0>, <&k3_clks 173 2>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
 };
-- 
2.34.1


