Return-Path: <linux-kernel+bounces-57641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F35CD84DBB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3284C1C21D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CF96EB43;
	Thu,  8 Feb 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vz7PWxx5"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89036E2A4;
	Thu,  8 Feb 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381828; cv=none; b=fsQ17ekV7fIC7oc5cP2XInPuNzfPNjCQMSrf3t3dmOS98c9GilqvmB8BOoKR07m8BtoGeP8/OJCZedsJ9nonmoR+koogX3PaMMpFCw22G8002G7o1E8AEFLf8r/OumYYPT4aFFDYU5mT3ItocnUysdnFdkh4VsnPil1mkWU5HBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381828; c=relaxed/simple;
	bh=4/7LooQWnhdKVtfbE7HqNZ6kk0Pd7g2CQiJtb6HGBoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtGUV72/j8keNbvOBE/X58Ybguh6NvljsDgcm48jnI4rEpsrDc9mbY2aXT2TVaRLk/HtOX6J2GlJDYNmbz5F0VCmfqRzheTft/4VOLahBqVawTe8mE7Yx7xuTI5HHnQemzokf6qJCmxsnBwyde6Jsm3Cf5jmrxWcvO6eP4FEcBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vz7PWxx5; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4188hCcC050138;
	Thu, 8 Feb 2024 02:43:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707381792;
	bh=4A4Z/qpcZA8AC33ULipWc2n/UZEdk4NC/YctUo/j1+g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Vz7PWxx5vUoA9RiXWXMxTxYpqtbIhciTtJxK3Vad21cpOsOriearAlhANuQ5vFvZn
	 5Cls+0lkNq++L7TmANlLycHsDZLBmto8k1n+w6NgWi8GErbAc4/m8pxnUcqaLPOUIB
	 OrWxMMEZpSWARiZTIj9IyIzZLAOQVI5DVqLNKZGc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4188hCPR025665
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 02:43:12 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 02:43:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 02:43:12 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4188gshN097884;
	Thu, 8 Feb 2024 02:43:08 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v2 3/9] arm64: dts: ti: k3-am68-sk-base-board: Enable camera peripherals
Date: Thu, 8 Feb 2024 14:12:48 +0530
Message-ID: <20240208084254.295289-4-vaishnav.a@ti.com>
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

CSI cameras are controlled using I2C. On AM68 Starter Kit, this is routed
to I2C-1, so enable the instance and the TCA9543 I2C switch on the bus.

AM68 SK schematics: https://www.ti.com/lit/zip/sprr463

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2: Update commit message with schematics.

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index f48155dd16a3..d743f023cdd9 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -169,6 +169,13 @@ tfp410_out: endpoint {
 			};
 		};
 	};
+
+	csi_mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp3 1 GPIO_ACTIVE_HIGH>;
+		idle-state = <0>;
+	};
 };
 
 &main_pmx0 {
@@ -186,6 +193,13 @@ J721S2_IOPAD(0x0e4, PIN_INPUT, 0) /* (AE24) I2C0_SDA */
 		>;
 	};
 
+	main_i2c1_pins_default: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0ac, PIN_INPUT, 13) /* (AC25) MCASP0_AXR15.I2C1_SCL */
+			J721S2_IOPAD(0x0b0, PIN_INPUT, 13) /* (AD26) MCASP1_AXR3.I2C1_SDA */
+		>;
+	};
+
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
@@ -431,6 +445,42 @@ exp1: gpio@21 {
 	};
 };
 
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	status = "okay";
+
+	exp3: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "CSI_VIO_SEL", "CSI_SEL_FPC_EXPn",
+				  "IO_EXP_CSI2_EXP_RSTz","CSI0_B_GPIO1",
+				  "CSI1_B_GPIO1";
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
 &main_i2c4 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1


