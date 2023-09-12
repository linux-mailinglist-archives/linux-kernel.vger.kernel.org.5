Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50D79C5E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjILE45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjILE4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:56:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7897F2D50
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso6792482a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494404; x=1695099204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKyYCY5Eawqt55a4Xl0O7T3NyqsE5dk2eEFtaGmMqxE=;
        b=jskZMDuumAdc4s/wKnwuviZ6RoCKGWCNmmUDPJoMVKrpOj0fSOtznA2CQTQIOXD6oN
         AOZjCfovHoI3uNs2YYiUgdWUptoE1q7EzR2yM1pEtexz80FEOV1QOK4DloNVTpzdQ5C5
         9eueBgTeaneUjmKTZr23SXNuKqBgGXWjJkBgd1Hn3RjQ80gFqMrog4SNO4bcT/1h5Jw8
         g9D0WWvNgMOdTNUZn6nCvcio81KbZDwsJwvvMjx+aCeWU2OUlhP1ZwV4rlL3Xv926kPu
         9eLWYTyZJQN0vN/XCDkKn3Pwag45gqJAfp4Nlm0kDxTgybKJs8yX1Z3Wh5VEC//wLEh3
         P9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494404; x=1695099204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKyYCY5Eawqt55a4Xl0O7T3NyqsE5dk2eEFtaGmMqxE=;
        b=eYs9MwoOhWrGyxARCKJhstF3xdCOntT20fXHhHov/eRFz0oMa7YyT9OHeGTY6DTr4D
         Lamqn1Q91g7ZkBDCXJqWU62ddiR6bREZQPpT9P3rGdnBvQWZpt1yLl1J2UrOAIKbR3g5
         IZ60iCD0SwVfWBwkSFhoFXatuCZS32p8RQy7CYhQO/qeg7fEdQT9fw2nDS89s3IbkI2H
         o+sMak8Ioxv7Cy3HovcFdMw89/+iVzA5S0VavWE+WPSgTLsWFglEoggOtjQUpY+2PxKC
         LzMqseNydlocmo7mfwrMAuF2NxfIY21oXNDb8+3ulzX1kHCuKcUGvslAlTvHRQYBLFAD
         LSBw==
X-Gm-Message-State: AOJu0Ywc8eenAzRVLq4F0m8uB+80LFT1gmntrFxoi0wVNknPR0hUc18w
        cI9ULdw5VXMaaDb+9EbCkzpgTw==
X-Google-Smtp-Source: AGHT+IG/66tUEndbVz1eoqV+N7JI0z1KvlhGtZm3CpGGgpR/XGPkb9QxGMHU5+zWq9ZYq5YA3iChmA==
X-Received: by 2002:aa7:ce0d:0:b0:525:528d:836f with SMTP id d13-20020aa7ce0d000000b00525528d836fmr9879149edv.18.1694494404043;
        Mon, 11 Sep 2023 21:53:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:23 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 33/37] arm64: dts: renesas: rzg3l-smarc-som: add initial support for RZ/G3S SMARC Carrier-II SoM
Date:   Tue, 12 Sep 2023 07:51:53 +0300
Message-Id: <20230912045157.177966-34-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add initial support for RZ/G3S SMARC Carrier-II SoM. SoM contains the following
devices:
- RZ/G3S microcontroller: Renesas R9A08G045S33GBG
- 9-channel PMIC: Renesas RAA215300
- Clock Generator: Renesas 5L35023B
- 128M QSPI Flash: Renesas AT25QL128A
- 8G LPDDR4 SDRAM: Micron MT53D512M16D1DS-046
- 64GB eMMC Flash: Micron MTFC64GBCAQTC
- 2x Gigabit Ethernet Transceiver: Microchip KSZ9131RNX
- 5x Current Monitors: Renesas ISL28025FR12Z

The following interfaces are available on SoM board:
- 2 uSD interfaces
- 12-pin, 1.0mm pitch connector to the RZ/G3S ADC IO
- 4-pin, 1.0mm pitch connector to the RZ/G3S I3C IO
- JTAG connector

At the moment the 24MHz output of 5L35023B, memory SD ch0 (with all its
bits) were described in device tree.

SD channel 0 of RZ/G3S is connected to an uSD card interface
and an eMMC. The selection b/w them is done though a hardware switch.
The DT will select b/w uSD and eMMC though SW_SD0_DEV_SEL build flag.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
new file mode 100644
index 000000000000..ea53b9ff7b6f
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R9A08G045S33 SMARC Carrier-II's SoM board.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+/*
+ * Signals of SW_CONFIG switches:
+ * @SW_SD0_DEV_SEL:
+ *	0 - SD0 is connected to eMMC
+ *	1 - SD0 is connected to uSD0 card
+ */
+#define SW_SD0_DEV_SEL	1
+
+/ {
+	aliases {
+		mmc0 = &sdhi0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@48000000 {
+		device-type = "memory";
+		/* First 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
+	};
+
+	reg_3p3v: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+#if SW_SD0_DEV_SEL
+	vccq_sdhi0: regulator1 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(2, 2) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>, <1800000 0>;
+	};
+#else
+	reg_1p8v: regulator1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+#endif
+};
+
+&extal_clk {
+	clock-frequency = <24000000>;
+};
+
+#if SW_SD0_DEV_SEL
+/* SD0 slot */
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-1 = <&sdhi0_uhs_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	max-frequency = <125000000>;
+	status = "okay";
+};
+#else
+/* eMMC */
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_emmc_pins>;
+	pinctrl-1 = <&sdhi0_emmc_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	fixed-emmc-driver-type = <1>;
+	max-frequency = <125000000>;
+	status = "okay";
+};
+#endif
+
+&pinctrl {
+	sd0-pwr-en-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(2, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "sd0_pwr_en";
+	};
+
+	sdhi0_pins: sd0 {
+		data {
+			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
+			power-source = <3300>;
+		};
+
+		ctrl {
+			pins = "SD0_CLK", "SD0_CMD";
+			power-source = <3300>;
+		};
+
+		cd {
+			pinmux = <RZG2L_PORT_PINMUX(0, 0, 1)>; /* SD0_CD */
+		};
+	};
+
+	sdhi0_uhs_pins: sd0-uhs {
+		data {
+			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
+			power-source = <1800>;
+		};
+
+		ctrl {
+			pins = "SD0_CLK", "SD0_CMD";
+			power-source = <1800>;
+		};
+
+		cd {
+			pinmux = <RZG2L_PORT_PINMUX(0, 0, 1)>; /* SD0_CD */
+		};
+	};
+
+	sdhi0_emmc_pins: sd0-emmc {
+		pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3",
+		       "SD0_DATA4", "SD0_DATA5", "SD0_DATA6", "SD0_DATA7",
+		       "SD0_CLK", "SD0_CMD", "SD0_RST#";
+		power-source = <1800>;
+	};
+};
-- 
2.39.2

