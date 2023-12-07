Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F337880818C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377984AbjLGHIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377989AbjLGHIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:08:37 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AF110E4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:08:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bfd3a5b54so356649e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 23:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701932910; x=1702537710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeSFEu7OukF0Tuu74YIE2VRnBvTHvA9bdAjWp6LMSbU=;
        b=O/9Uni0vZdw0ycdIqGqxwvSsUpKFUqMMwQgStYOhDs6i73kT3RP8IFCoyzxYEHTwVV
         ij9//XnQ6xftxkQT6E9DV15UjgMP4sOGKalo+/F5IkcLZ9aTh+uWECCqCtbjUQYRZK7+
         ZWc9/85NOObX/HMgs6iok3hLeAu/nVXf1s39OKoM2QvgKG5LmiEolghPG3SYx9ojlt/h
         xA6Z31j0p3QB/ABzYfx/vXY5Q0iKLi7alSDwLORBeyErbANR0vBEqUebJ/Kt5SSdbBgV
         Yatqrqn5OAqtGd4bwcXdrFBiSmK9udz+UnorAtb4BNeM1qjox6Fm4DhXQ8NjADo7a6r1
         vdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701932910; x=1702537710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeSFEu7OukF0Tuu74YIE2VRnBvTHvA9bdAjWp6LMSbU=;
        b=Gq4JPacGFgEdpy418mTffZWUOybtyHZIEwGe5mKPQGbbv6R3Id6KC9DmPiAg2mTaWd
         IZ1RaUvtcSHSKJXZKD3M4A6R8abMHJWwFrCreQcZ9yjYXOgQsMtXt5QPtX9pO+2WIKDF
         59s8hRmJ5FT3lvow+1Sbihh27E1ZbAq7Go1BDzk3ke0lL25Aj9i+GMrcug0oSTPjBi9z
         po6erxliJBG4oRBNi16CvBoaJoeM7aBDAhmaR9uU2eo9GwFNfri3Vu9UxApWlFqB3sO3
         YDjoSg69hu+qnHgxW6SQT8DqFISLgfWcUBc9n7d35Vb9u7kPaHBLteJuPK7t15kHJW8E
         P9vQ==
X-Gm-Message-State: AOJu0YzUn1FBM6FjSVQcvRk6JcrQecsfzn2CSqHQIXdXZUC7sRjg3pgI
        CcltMy/uh1dcWcdFJBm8AXhJzQ==
X-Google-Smtp-Source: AGHT+IHwFM1deCGaB8hL4AjkVZKdcxII4qcU+r4kO/s02JIjcDLdN1i2kMafFqDp+LcjJNvru3CAlQ==
X-Received: by 2002:a05:6512:3b97:b0:50b:effb:c63f with SMTP id g23-20020a0565123b9700b0050beffbc63fmr1725491lfv.6.1701932909933;
        Wed, 06 Dec 2023 23:08:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id b41-20020a509f2c000000b0054cb88a353dsm420818edf.14.2023.12.06.23.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 23:08:29 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 11/11] arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces
Date:   Thu,  7 Dec 2023 09:07:00 +0200
Message-Id: <20231207070700.4156557-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The RZ/G3S Smarc Module has Ethernet PHYs (KSZ9131) connected to each
Ethernet IP. For this, add proper DT bindings to enable the Ethernet
communication through these PHYs.

The interface b/w PHYs and MACs is RGMII. The skew settings were set to
zero as based on phy-mode (rgmii-id) the KSZ9131 driver enables internal
DLL, which adds a 2ns delay b/w clocks (TX/RX) and data signals.

Different pin settings were applied to TXC and TX_CTL compared with the
rest of the RGMII pins to comply with requirements for these pins imposed
by HW manual of RZ/G3S (see chapters "Ether Ch0 Voltage Mode Control
Register (ETH0_POC)", "Ether Ch1 Voltage Mode Control Register (ETH1_POC)",
for power source selection, "Ether MII/RGMII Mode Control Register
(ETH_MODE)" for output-enable and "Input Enable Control Register (IEN_m)"
for input-enable configurations).

Commit also enables the Ethernet interfaces by selecting
SW_CONFIG3 = SW_ON.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- removed #address-cells, #size-cells
- adapted patch description to reflect the usage of SW_CONFIG

 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 141 +++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index f59094701a4a..f062d4ad78b7 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -26,7 +26,7 @@
  *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
  */
 #define SW_CONFIG2	SW_ON
-#define SW_CONFIG3	SW_OFF
+#define SW_CONFIG3	SW_ON
 
 / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
@@ -35,6 +35,9 @@ aliases {
 		mmc0 = &sdhi0;
 #if SW_CONFIG3 == SW_OFF
 		mmc2 = &sdhi2;
+#else
+		eth0 = &eth0;
+		eth1 = &eth1;
 #endif
 	};
 
@@ -89,6 +92,60 @@ vcc_sdhi2: regulator2 {
 	};
 };
 
+#if SW_CONFIG3 == SW_ON
+&eth0 {
+	pinctrl-0 = <&eth0_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	phy0: ethernet-phy@7 {
+		reg = <7>;
+		interrupt-parent = <&pinctrl>;
+		interrupts = <RZG2L_GPIO(12, 0) IRQ_TYPE_EDGE_FALLING>;
+		rxc-skew-psec = <0>;
+		txc-skew-psec = <0>;
+		rxdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
+
+&eth1 {
+	pinctrl-0 = <&eth1_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	phy1: ethernet-phy@7 {
+		reg = <7>;
+		interrupt-parent = <&pinctrl>;
+		interrupts = <RZG2L_GPIO(12, 1) IRQ_TYPE_EDGE_FALLING>;
+		rxc-skew-psec = <0>;
+		txc-skew-psec = <0>;
+		rxdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
+#endif
+
 &extal_clk {
 	clock-frequency = <24000000>;
 };
@@ -136,6 +193,88 @@ &sdhi2 {
 #endif
 
 &pinctrl {
+	eth0-phy-irq-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(12, 0) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "eth0-phy-irq";
+	};
+
+	eth0_pins: eth0 {
+		txc {
+			pinmux = <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* ET0_TXC */
+			power-source = <1800>;
+			output-enable;
+			input-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		tx_ctl {
+			pinmux = <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* ET0_TX_CTL */
+			power-source = <1800>;
+			output-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		mux {
+			pinmux = <RZG2L_PORT_PINMUX(1, 2, 1)>,	/* ET0_TXD0 */
+				 <RZG2L_PORT_PINMUX(1, 3, 1)>,	/* ET0_TXD1 */
+				 <RZG2L_PORT_PINMUX(1, 4, 1)>,	/* ET0_TXD2 */
+				 <RZG2L_PORT_PINMUX(2, 0, 1)>,	/* ET0_TXD3 */
+				 <RZG2L_PORT_PINMUX(3, 0, 1)>,	/* ET0_RXC */
+				 <RZG2L_PORT_PINMUX(3, 1, 1)>,	/* ET0_RX_CTL */
+				 <RZG2L_PORT_PINMUX(3, 2, 1)>,	/* ET0_RXD0 */
+				 <RZG2L_PORT_PINMUX(3, 3, 1)>,	/* ET0_RXD1 */
+				 <RZG2L_PORT_PINMUX(4, 0, 1)>,	/* ET0_RXD2 */
+				 <RZG2L_PORT_PINMUX(4, 1, 1)>,	/* ET0_RXD3 */
+				 <RZG2L_PORT_PINMUX(4, 3, 1)>,	/* ET0_MDC */
+				 <RZG2L_PORT_PINMUX(4, 4, 1)>,	/* ET0_MDIO */
+				 <RZG2L_PORT_PINMUX(4, 5, 1)>;	/* ET0_LINKSTA */
+			power-source = <1800>;
+		};
+	};
+
+	eth1-phy-irq-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(12, 1) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "eth1-phy-irq";
+	};
+
+	eth1_pins: eth1 {
+		txc {
+			pinmux = <RZG2L_PORT_PINMUX(7, 0, 1)>;	/* ET1_TXC */
+			power-source = <1800>;
+			output-enable;
+			input-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		tx_ctl {
+			pinmux = <RZG2L_PORT_PINMUX(7, 1, 1)>;	/* ET1_TX_CTL */
+			power-source = <1800>;
+			output-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		mux {
+			pinmux = <RZG2L_PORT_PINMUX(7, 2, 1)>,	/* ET1_TXD0 */
+				 <RZG2L_PORT_PINMUX(7, 3, 1)>,	/* ET1_TXD1 */
+				 <RZG2L_PORT_PINMUX(7, 4, 1)>,	/* ET1_TXD2 */
+				 <RZG2L_PORT_PINMUX(8, 0, 1)>,	/* ET1_TXD3 */
+				 <RZG2L_PORT_PINMUX(8, 4, 1)>,	/* ET1_RXC */
+				 <RZG2L_PORT_PINMUX(9, 0, 1)>,	/* ET1_RX_CTL */
+				 <RZG2L_PORT_PINMUX(9, 1, 1)>,	/* ET1_RXD0 */
+				 <RZG2L_PORT_PINMUX(9, 2, 1)>,	/* ET1_RXD1 */
+				 <RZG2L_PORT_PINMUX(9, 3, 1)>,	/* ET1_RXD2 */
+				 <RZG2L_PORT_PINMUX(10, 0, 1)>,	/* ET1_RXD3 */
+				 <RZG2L_PORT_PINMUX(10, 2, 1)>,	/* ET1_MDC */
+				 <RZG2L_PORT_PINMUX(10, 3, 1)>,	/* ET1_MDIO */
+				 <RZG2L_PORT_PINMUX(10, 4, 1)>;	/* ET1_LINKSTA */
+			power-source = <1800>;
+		};
+	};
+
 	sdhi0_pins: sd0 {
 		data {
 			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
-- 
2.39.2

