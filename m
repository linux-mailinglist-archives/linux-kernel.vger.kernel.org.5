Return-Path: <linux-kernel+bounces-155451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA388AEAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC881F221DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F64413CF9F;
	Tue, 23 Apr 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P1zN20ho"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1C13C67E;
	Tue, 23 Apr 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885465; cv=none; b=eTaSrX8t3CJUKlHHwhUXb1lKZq53X8oSdTtL6Q24AA3pPNd06QNGbRdNcuiO3pBKJidEXMIh1yVkOqsKhwW4sgDob6y5/Dwc/E4eC5L109OWqf9/b3tNCoVTw/lojkyzwWeFze2iwUDMICiG0wAtNcq0QqdS8+j7hEyMRhJlxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885465; c=relaxed/simple;
	bh=/xpOcyzqCQWNRfH0RnVlkE0SBC9mcDOmUGvMctQEjXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYqmQ1fmQj1uAIsLDS+pjn6PTe2L50XztQhUnHnf7zjDVu9QeXwTE6QsddGmRmTPFO+shqYGBTQ/1nsVq4DnbATC3JG++WAcZX4ZBLN+sJ5ZTlZ2/4J135GYt4zh9w3aciTldzNdJ05ftaxpKaKD4RCqECUHTbZ6U6XDyGmmjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P1zN20ho; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWOi060833;
	Tue, 23 Apr 2024 10:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713885452;
	bh=1jNIxtbiIWqcAzK8N+/83KqJ+Twayu/7lkQuN1c6AiE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=P1zN20hoy/P3QKQy78lXemvkvH3ztBaiSMBTOnD8wBdB+N1WQmhe7DFXu9JzNgBAg
	 RAcGYYlY40LPeqoHmXy1ZlzUpr5BD1AqGUW6FarWMWdIOmRcDbqdbxYW3/PTInBMtx
	 MRL1bVb8j1Cg0iKV4xjz0cJsvxrIbpzYSDyZaSBU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NFHWwf098208
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 10:17:32 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 10:17:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 10:17:32 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWYJ080176;
	Tue, 23 Apr 2024 10:17:32 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>, Dasnavis
 Sabiya <sabiya.d@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 3/5] arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards
Date: Tue, 23 Apr 2024 10:17:30 -0500
Message-ID: <20240423151732.3541894-4-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423151732.3541894-1-jm@ti.com>
References: <20240423151732.3541894-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Vignesh Raghavendra <vigneshr@ti.com>

Hook up required IO voltage regulators and drop no-1-8-v to support UHS
modes on SD cards.

Fixes: 5fc6b1b62639 ("arm64: dts: ti: Introduce AM62A7 family of SoCs")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[Judith: Remove no-1-8-v for sdhci2, keep otap-del-sel-legacy=0,
add fixes tag, reword commit]
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- no change
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi |  2 --
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index aa1e057082f08..6652701d3e3b8 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -573,7 +573,6 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
-		no-1-8-v;
 		status = "disabled";
 	};
 
@@ -597,7 +596,6 @@ sdhci2: mmc@fa20000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
-		no-1-8-v;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index f241637a5642a..fa43cd0b631e6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -113,6 +113,20 @@ vcc_3v3_sys: regulator-4 {
 		regulator-boot-on;
 	};
 
+	vddshv_sdio: regulator-5 {
+		compatible = "regulator-gpio";
+		regulator-name = "vddshv_sdio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vddshv_sdio_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&ldo1>;
+		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -342,6 +356,12 @@ main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
 			AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
 		>;
 	};
+
+	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
+		>;
+	};
 };
 
 &mcu_pmx0 {
@@ -580,6 +600,7 @@ &sdhci1 {
 	/* SD/MMC */
 	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vddshv_sdio>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	disable-wp;
-- 
2.43.2


