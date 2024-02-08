Return-Path: <linux-kernel+bounces-57634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8323384DBA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC951F23D06
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C3E6BB4F;
	Thu,  8 Feb 2024 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jGlVQg1v"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244F6BB30;
	Thu,  8 Feb 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381815; cv=none; b=QZ+Wx0rTGG+/+XPvZxEUd5IeVtRuHF5e4vCw9OUY+MLwfLvwTeNHvw/GmxArjneikTpT3nO/y+iuJ6dcnaQ/TdpbIAGQKNdBaTTAEsUZU+7MI7LQ/MjWgpsW+2pg1JTBWvAj2zY2+kymy00DK3an1B/AmOZ4bjLNbNkx//cGlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381815; c=relaxed/simple;
	bh=088r6S7/R9BOBDXxhqCmLynpzfajZ/iQ4e9x2jKogY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1J8OklLvdxfkeICqdOAPWaNGYo0l4EKpUrKOuATCz2EViJUKWVLyNdCNR2+aXYZDCgLvR+NAeKkzp0sNltbfddpY4NPy6phua8pEyzJnkdlt/HavmS4J5xVmKOPESFYzp1T/V9BRo1qd0rXDDge+y8SZKDdwgZor/cI11maNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jGlVQg1v; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4188hGTr016775;
	Thu, 8 Feb 2024 02:43:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707381796;
	bh=XYSJWaZbQUZ4rWgrWFja9l/jgfj6GB45OK068onqk5E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jGlVQg1v3bKJk1qbcc5Dcj13G7fDavgueyx4KFdUym+zWL5jfRLPd4Al8AEqBg58G
	 vfMqgYsVramSSZidlZGoN7RiQRbsfTjrKKaOydEuU1XicvS7TVxkMkzvBEBmcug7tA
	 6p/99iGr/PAhKQYm4upt5CII4kowiSCxZeKUi9UI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4188hGBj043561
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 02:43:16 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 02:43:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 02:43:16 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4188gshO097884;
	Thu, 8 Feb 2024 02:43:12 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v2 4/9] arm64: dts: ti: k3-am69-sk: Enable camera peripherals
Date: Thu, 8 Feb 2024 14:12:49 +0530
Message-ID: <20240208084254.295289-5-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208084254.295289-1-vaishnav.a@ti.com>
References: <20240208084254.295289-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

CSI cameras are controlled using I2C. On AM69 Starter Kit, this is routed
to I2C-1, so enable the instance, TCA9543 I2C switch and the TCA6408
GPIO expander on the bus. AM69 SK has the CSI2RX routed to a MIPI CSI
connector and to 22-pin RPi camera connector through an analog mux with
GPIO control, model that so that an overlay can control the mux state
according to connected cameras.

AM69 SK schematics: https://www.ti.com/lit/zip/sprr466

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2: Update commit message with schematics.

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 5f0a43a69333..46cf90bb3eb8 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -322,6 +322,14 @@ tfp410_out: endpoint {
 			};
 		};
 	};
+
+	csi_mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp2 1 GPIO_ACTIVE_HIGH>;
+		idle-state = <0>;
+	};
+
 };
 
 &main_pmx0 {
@@ -341,6 +349,13 @@ J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
 		>;
 	};
 
+	main_i2c1_pins_default: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0ac, PIN_INPUT_PULLUP, 13) /* (AE34) MCASP0_AXR15.I2C1_SCL */
+			J784S4_IOPAD(0x0b0, PIN_INPUT_PULLUP, 13) /* (AL33) MCASP1_AXR3.I2C1_SDA */
+		>;
+	};
+
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -775,6 +790,42 @@ exp1: gpio@21 {
 	};
 };
 
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exp2: gpio@21 {
+		compatible = "ti,tca6408";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "CSI_VIO_SEL", "CSI_MUX_SEL_2", "CSI2_RSTz",
+				  "IO_EXP_CAM0_GPIO1", "IO_EXP_CAM1_GPIO1";
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		cam0_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		cam1_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+	};
+};
+
 &main_sdhci0 {
 	bootph-all;
 	/* eMMC */
-- 
2.34.1


