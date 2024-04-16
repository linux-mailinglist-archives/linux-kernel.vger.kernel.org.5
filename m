Return-Path: <linux-kernel+bounces-147678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235798A77A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80981F22D87
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E321512C469;
	Tue, 16 Apr 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kgs9wYei"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE56EB5B;
	Tue, 16 Apr 2024 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305828; cv=none; b=cQZ3gYyoHTk2Bglvr8D3TMXtXlri2kUxWci3F09/C4qeh/osWsh1DUq9kjD9ffHMKf8qo9wyhntVkhxO44gPMmxW4K3K34zVwvVXrEryqZ54wV2vu0Wz5ulAc/6nBeTFNjuwoKGNo/frWf7RI2F1865aH4CDocVpLRk0mKsHywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305828; c=relaxed/simple;
	bh=DGD73mn2N2lCaXOsKtUvBotQaRvUccA4LAcUveopgHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCOGzrxB8M3iMHm62z1GikyDvFlNZWe/lOmrUj42uu7WwsF+BR+MJVT4MR64p1oCYPtqYFNJylMpT/dzFqZ6mEBkgx1w+bd/ua9d6v3fTtTriu4RqU+RRLh+4ApcKaNV662UU3nFp2hSycu1pGpajCE58F6V0fpZ50EUzi3easQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kgs9wYei; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGnmp065471;
	Tue, 16 Apr 2024 17:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713305809;
	bh=4dy4eXbT4GnbhmbZtIbl8Wlb7GVAbbn4qM7f0vlJVOY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Kgs9wYei8gs8VGTZkCmwFNJlyWzIzL+5rBjmRKnsTZYL54l1++X0Kj4lTGHS0akJ8
	 O/2GQVRHct1UoSQOUx4ibJEOKmhiHDntAFySjRaRHAF8RGIC8Om7twNcdAf0FTQJrB
	 hBRHXxJFQMXV9hhZ47Wk30Vg2d3VKy0f7NsEw310=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43GMGnB9080065
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Apr 2024 17:16:49 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 17:16:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 17:16:48 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGmSn102285;
	Tue, 16 Apr 2024 17:16:48 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>
Subject: [PATCH v2 3/6] arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards
Date: Tue, 16 Apr 2024 17:16:45 -0500
Message-ID: <20240416221648.3522201-4-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240416221648.3522201-1-jm@ti.com>
References: <20240416221648.3522201-1-jm@ti.com>
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
Changes since v1:
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


