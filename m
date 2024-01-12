Return-Path: <linux-kernel+bounces-24661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5671C82BFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBAB286298
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB3759B5A;
	Fri, 12 Jan 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PXSANchQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9658ABB;
	Fri, 12 Jan 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705063506;
	bh=BqA8+Rgrymj3tzwnH+szzIpPEsXtqRKCif5sghqD8YY=;
	h=From:To:Cc:Subject:Date:From;
	b=PXSANchQAnRYJ+soGHaYWEz0yA5QlWceWAtSxCXwhU2YBG4OWkhI0Lj8tGE2E4QVm
	 BG1ceVYlP/w7DNm7gOUAG5i4hSx1BzF6mhK306TBcWbdHYdOh5vdYs3+Wu5R9hovhp
	 M1Tfhu4jK9FG2vCOpEIOgXNTTyslrHh2KOMS69GVOEM+dmU31ctJQ4iJjMjYHI6/03
	 xEzJ0KLPrWIor/0Ne+ndBeaU+5E4sBlzbEGlyOzjWfYmphb5XSLjw+zEjFWiaIDui1
	 rP6CSbsAAVncb4tSfAQ733dqaGC+DSPd4cDBpG22+R/oyBt68LhBk2K4Rv51D4JD9B
	 Z1Wfo6OmoCLoQ==
Received: from beast.luon.net (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC3F33782017;
	Fri, 12 Jan 2024 12:45:05 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 779DD9F084DB; Fri, 12 Jan 2024 13:45:05 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Roger Quadros <rogerq@kernel.org>,
	kernel@collabora.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Use the builtin mdio bus
Date: Fri, 12 Jan 2024 13:44:55 +0100
Message-ID: <20240112124505.2054212-1-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The beagleplay dts was using a bit-bang gpio mdio bus as a work-around
for errata i2329. However since commit d04807b80691 ("net: ethernet: ti:
davinci_mdio: Add workaround for errata i2329") the mdio driver itself
already takes care of this errata for effected silicon, which landed
well before the beagleplay dts. So i suspect the reason for the
workaround in upstream was simply due to copying the vendor dts.

Switch the dts to the ti,cpsw-mdio instead so it described the actual
hardware and is consistent with other AM625 based boards

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 42 +++++++------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index eadbdd9ffe37..49fb21ba62b0 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -29,7 +29,6 @@ aliases {
 		i2c3 = &main_i2c3;
 		i2c4 = &wkup_i2c0;
 		i2c5 = &mcu_i2c0;
-		mdio-gpio0 = &mdio0;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 		mmc2 = &sdhci2;
@@ -231,27 +230,6 @@ simple-audio-card,codec {
 		};
 	};
 
-	/* Workaround for errata i2329 - just use mdio bitbang */
-	mdio0: mdio {
-		compatible = "virtual,mdio-gpio";
-		pinctrl-names = "default";
-		pinctrl-0 = <&mdio0_pins_default>;
-		gpios = <&main_gpio0 86 GPIO_ACTIVE_HIGH>, /* MDC */
-			<&main_gpio0 85 GPIO_ACTIVE_HIGH>; /* MDIO */
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpsw3g_phy0: ethernet-phy@0 {
-			reg = <0>;
-		};
-
-		cpsw3g_phy1: ethernet-phy@1 {
-			reg = <1>;
-			reset-gpios = <&main_gpio1 5 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <25>;
-			reset-deassert-us = <60000>; /* T2 */
-		};
-	};
 };
 
 &main_pmx0 {
@@ -312,8 +290,8 @@ AM62X_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
 
 	mdio0_pins_default: mdio0-default-pins {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0160, PIN_OUTPUT, 7) /* (AD24) MDIO0_MDC.GPIO0_86 */
-			AM62X_IOPAD(0x015c, PIN_INPUT, 7) /* (AB22) MDIO0_MDIO.GPIO0_85 */
+			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
+			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
 		>;
 	};
 
@@ -611,8 +589,20 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
-	/* Workaround for errata i2329 - Use mdio bitbang */
-	status = "disabled";
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins_default>;
+
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+
+	cpsw3g_phy1: ethernet-phy@1 {
+		reg = <1>;
+		reset-gpios = <&main_gpio1 5 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <25>;
+		reset-deassert-us = <60000>; /* T2 */
+	};
 };
 
 &main_gpio0 {
-- 
2.43.0


