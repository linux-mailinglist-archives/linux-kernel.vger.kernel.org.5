Return-Path: <linux-kernel+bounces-42798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C008406E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232F61F21F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A1657AF;
	Mon, 29 Jan 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P7/MxCDP"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691D63410;
	Mon, 29 Jan 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534890; cv=none; b=TmRxbtVbDXR1Jd1QnM3Z4CDAR3ULnYxT3n8BMIL7mywdlNPI+3J7AxXm3fgt/GYfMoz/LJgxWjOH0cjCk4olUQvBwGGryqkG7gDVq5j9ES40SBx85Y5K5UHLg3qvBd5NU1NMZvbtMQ+2VUrwEbEcZd7e4rT3ee/yU8w3C1kjbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534890; c=relaxed/simple;
	bh=Fu7SQPmR3+qGX9DDeEqzN1ZIg8UuYtnpgYXtxuZVNog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qozjPDvAX9qRs7Apw8bxSla9+A89hlRNdtvN/6PRHinftWiY0KqkmTnNVzdOt8mbCwllwPhIfniiOGymRWL364oJbnxWjKf6Wth/TM5bRNhDb+sQufzOTGDxJU7ZpjypXZyAyttUoEEA1j7+CWINuxOCMzJC4bg4UM8cRjiZUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P7/MxCDP; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRxP4099377;
	Mon, 29 Jan 2024 07:27:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706534879;
	bh=E0A1ZAoUQEzf7vjZixkWSqinQZzFQTLnICjtG2nspQU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=P7/MxCDPs1XNrDJe+iWa2PHiEZyeC2C/mUxFhwM7rYTwaG2VsnOMNmj7QeuCG7qv5
	 SAb1RchZvidOqk3tUYLD6x1Hgmna/gDofZSMNRx9K0Q2JqS1eIrXAKuRtqKIR48jak
	 0CNi1dDSx4kiInnQmPD7Co697cATgxL098asqPqY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TDRwgQ093114
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 07:27:59 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 07:27:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 07:27:58 -0600
Received: from uda0490681.dhcp.ti.com ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRg9D036720;
	Mon, 29 Jan 2024 07:27:55 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>
Subject: [PATCH 3/9] arm64: dts: ti: k3-am68-sk-base-board: Enable camera peripherals
Date: Mon, 29 Jan 2024 18:57:36 +0530
Message-ID: <20240129132742.1189783-4-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129132742.1189783-1-vaishnav.a@ti.com>
References: <20240129132742.1189783-1-vaishnav.a@ti.com>
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

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index d0cfdeac21fb..f0152f0c4f45 100644
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


