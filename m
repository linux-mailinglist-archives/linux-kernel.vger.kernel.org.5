Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12017B2BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjI2Fme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjI2Flv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:41:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26302CE9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:40:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso10005543a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695966008; x=1696570808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeIjOWwpF3mLVbOtS0GY5PnyLTp7BpM7n9Y7kEfqwMM=;
        b=qkOZ6DLs5l6YplPpCM5dDwWykRT3eqRT7qTLWvmw4cD4vk2qL3G0cU0S5h5DKcJMTk
         lZ6LfUCdhHiApJLvWHwJJ8HQr2bpCJYOqbyBczpIcicc1gcPGu+593BZuHeL3CoM5uw3
         3RH3/wQvt+xSJwIbHUCXLdViqYPNKza6nUwvdxgNSkM5HuvRzFQ3E2f6wdPZ4OwaQeQK
         ZkYTGf75hIZMLaRx4f7nE7kC/nzErVq6iFiaNBLcjXwQtfP/1ijN03n5Vh5sVNYXMaWS
         YJLmOSYMdQmhqQtCnTvo1Rpxrms6NuLY8tuoBK6ToMv4nJJ6smh9XTzFaFJcTWkZ3kHS
         sGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695966008; x=1696570808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeIjOWwpF3mLVbOtS0GY5PnyLTp7BpM7n9Y7kEfqwMM=;
        b=nn/y2Nz9jAG29D3Q1oVY0qebwnqu/tGutTFAyK9uuJVBstQJV0FKUsfsDmGME+DOKO
         5S+82nnNwiCAnSgp359FKljRc8Tbmf7g+lWshQaCAUOBDRd5Ls05wwoeoCWQwgExwwv8
         dFWggKZpoS346wyiZ22UMLiSvtQXjWXgnx16vkU1rEeaVaVm9WN+ApnaFc+g1wNMc7Zl
         tYPcRKP9skD/YxcoRPtdpXtTO5yL2B8uGfp0JACy3CvrrhBP+2lmZNT+VL8XyJMGfgKJ
         G3KfFD7mAcExSFv/woAqtYpSKEm3VLZW55+6YCDK4B0SQtYg7TYlg+yj/Un9VOVSpzBf
         d1Mg==
X-Gm-Message-State: AOJu0YybQ44jq5CZo/nMYqyIRTWjsMMpg0fo4ay51eDeKgWYYLTVmln6
        Mnsn4BSx9WfluqanXXcA5PMrHg==
X-Google-Smtp-Source: AGHT+IH0d/iDy/DE2eHeibDxa9BpWtIUIqOG+PtTOUVaRvLFLxE9QsvP/SW5YD+T22QbKm2UChNtWA==
X-Received: by 2002:a17:906:519d:b0:9a1:e293:9882 with SMTP id y29-20020a170906519d00b009a1e2939882mr3267983ejk.63.1695966008458;
        Thu, 28 Sep 2023 22:40:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:40:07 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 24/28] arm64: dts: renesas: rzg3l-smarc-som: add initial support for RZ/G3S SMARC SoM
Date:   Fri, 29 Sep 2023 08:39:11 +0300
Message-Id: <20230929053915.1530607-25-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add initial support for RZ/G3S SMARC SoM. The following devices available
on SoM were added to this initial device tree:

- RZ/G3S SoC: Renesas R9A08G045S33GBG
- Clock Generator (only 24MHz output): Renesas 5L35023B
- 1GiB LPDDR4 SDRAM: Micron MT53D512M16D1DS-046
- 64GB eMMC Flash (though SD ch0): Micron MTFC64GBCAQTC

SD channel 0 of RZ/G3S is connected to an uSD card interface
and an eMMC. The selection b/w them is done though a hardware switch.
The DT will select b/w uSD and eMMC though SW_SD0_DEV_SEL build flag.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- s/Carrier-II SoM/SoM in patch title
- listed in commit description only devices addressed by this initial dtsi
- s/8G LPDDR4/1GiB LPDDR4 in commit description
- removed sd0-pwr-en-hog node and use specific GPIO in vcc_sdhi0 regulator
- added SoM compatible:
  compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";

 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
new file mode 100644
index 000000000000..185ca8289a35
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -0,0 +1,142 @@
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
+	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
+
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
+	vcc_sdhi0: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(2, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
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
+	vmmc-supply = <&vcc_sdhi0>;
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
+	vmmc-supply = <&vcc_sdhi0>;
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

