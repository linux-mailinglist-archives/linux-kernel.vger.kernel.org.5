Return-Path: <linux-kernel+bounces-141681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C14898A21F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC6EB23BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49A8481CE;
	Thu, 11 Apr 2024 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tIi3l35Z"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797C4654F;
	Thu, 11 Apr 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875989; cv=none; b=F/n75zjW42ZZdIzO0dz1xKdUHXhmRgo4ZPsiG0eSlqzB3ZS/a/KnSctMwlX1kdo+4R7xqz1xtpAQZ2Jb4Z707q9dOR1lIsshYsud2JP0i171pJpu7lyIL78E9NRV1ZfSvM8LQzndV0dvgDTlxfjTRWFV+xtG8Yd5wBle3JZW0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875989; c=relaxed/simple;
	bh=9XajQHnPDVlBJohVjV7XSzj+yAPyEAB+bD1rVHvKDOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZxSlL8GtNvn4C53BFxib+z585TrfM4ZgywYJNgICxeCQEH+Pnwm18zpZhCta7Tyb1WT+SkFYQ9reKLwfoJudndLxK61ldQTOA6XcfKF92XCMJhr6dAED7G59O4Etnkj/8T4accIcdH46KwJEm27EMg/Y0mz88XaVmaVcXNEbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tIi3l35Z; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqvsv106815;
	Thu, 11 Apr 2024 17:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712875977;
	bh=CRGAFhSzK1bZybXsZ0DUegFnLk1bzCTrrCUpf+wQUx4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tIi3l35ZpAqKtqFCS2bLecUSbD30M3XqVWSXAbu4flTgAgneW7qKwg89a6jAT7yEU
	 a/2Wn4xUKe3Y8Lbmlvgvc00xeDLfJULBZig1COFhMd2oYOLfbeUrDh9Dht8iZDwp34
	 4m8CRBKQm3tC1C7zO/lTkg2B2/6rTnPs7s4xoOpM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43BMqv5K019690
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 17:52:57 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 17:52:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 17:52:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqv7Z002381;
	Thu, 11 Apr 2024 17:52:57 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 3/7] arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards
Date: Thu, 11 Apr 2024 17:52:53 -0500
Message-ID: <20240411225257.383889-4-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411225257.383889-1-jm@ti.com>
References: <20240411225257.383889-1-jm@ti.com>
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
index f241637a5642a..1af5d01c7b94c 100644
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
+	vddshv_sdio_pins_default: vddshv-sdio-pins-default {
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


