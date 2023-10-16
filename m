Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326B37CA614
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjJPKyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjJPKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:54:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3226EB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:54:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98377c5d53eso668813866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1697453638; x=1698058438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+MJaAV/gwtH2nOns6YwndFAXtL/h0w6eYvJcO7ucAs=;
        b=GDbdecguN2TW1xsnb++hpsQgldP19bMQVt3sa9qnAfBtUxQ8TXuJuCguS4Cx/Mtl+1
         NY8/rsCLaocthtfgeTf+gvg8P6GS0TlBGqeTQh6slJaT3/+8tlO8gbxzhFi5EXcXgO0b
         Q5PZ2sS8ATcUVANlgf9LAHQAG+eVJrM+0MAziTHBN+OJC14jCbpGMZuPSYWIggLsiEbB
         Od1OWQOwdE59EBwLL6dlwKv89DeWTnb7Dv4RaB0RisfsQDlkZCg4xSRitiHyWhw45mlN
         5RrcTeaMKD5ZHIC7aqOthT61/Ie0pMEEM2Goxk+UYtvb+PR6s/y7CVEq7WpKXWidKmfD
         BkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697453638; x=1698058438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+MJaAV/gwtH2nOns6YwndFAXtL/h0w6eYvJcO7ucAs=;
        b=VxQCRFoLuj9iuYH+FEzbc7og3ZkXkbQQZtp+KQM2IOp8yLucn9fsE4naaGltTybRm6
         OUbyg6MELirwl4XjD9W3FdvpsXLtjJzRVuOsnVnB2KIfKZLLBDLH4gvJi0Cg0bUWV7Ju
         LxP9iQH8k3HdcyEmZXSmkcQP/4g80J8EWU6LJQgw7eYt4frRCmVWT1moLpoFmJnXQo9F
         3hPAd9l7lbFi1kZT4n+BzDH8B8O/NPAqnvkLq1xi7wWc3mlov0gfU6gPL35KMChD7ljO
         tscuEtbVO04u80/T48n6pny5tEGRf1xhLlIf+PhEE/BvVXLVM5PiBd2LlIyy0m1U4I+E
         pTbw==
X-Gm-Message-State: AOJu0YwbfXEF+/bg2YyueawmvaTcR3cbLKLE12qI9eBjr2NxZZR8ofVN
        vh9JbDGaCK7HJSBd3J0uTozZaw==
X-Google-Smtp-Source: AGHT+IG/M+sOmZoqyWo8LSLRIrJctdwi0GeDZl7HCHvP81bWrj6rK4oi5DexO1+wGbnMhcPwlKhZLw==
X-Received: by 2002:a17:907:9486:b0:9be:f6c0:7d73 with SMTP id dm6-20020a170907948600b009bef6c07d73mr4528867ejc.74.1697453638630;
        Mon, 16 Oct 2023 03:53:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090651c200b009a5f7fb51dcsm3818126ejk.42.2023.10.16.03.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:53:57 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, claudiu.beznea@tuxon.dev,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 1/2] arm64: dts: renesas: rzg3s-smarc-som: Enable SDHI2
Date:   Mon, 16 Oct 2023 13:53:43 +0300
Message-Id: <20231016105344.294096-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016105344.294096-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231016105344.294096-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add SDHI2 to RZ/G3S Smarc SoM. SDHI2 pins are multiplexed with SCIF1, SSI0,
IRQ0, IRQ1. The selection b/w SDHI2 and SCIF1, SSI3, IRQ0, IRQ1 is done
with a switch button. To be able to select b/w these a compilation flag has
been added (SW_SD2_EN) at the moment being instantiated to select SDHI2.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- remove pinctrl-1 and vqmmc regulator as UHS is not supported by SDHI2
- fixed typos in commit message and code

 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index a199de8f8b02..01a4a9da7afc 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -13,14 +13,21 @@
  * @SW_SD0_DEV_SEL:
  *	0 - SD0 is connected to eMMC
  *	1 - SD0 is connected to uSD0 card
+ * @SW_SD2_EN:
+ *	0 - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
+ *	1 - SD2 is connected to SoC
  */
 #define SW_SD0_DEV_SEL	1
+#define SW_SD2_EN	1
 
 / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
 
 	aliases {
 		mmc0 = &sdhi0;
+#if SW_SD2_EN
+		mmc2 = &sdhi2;
+#endif
 	};
 
 	chosen {
@@ -63,6 +70,15 @@ reg_1p8v: regulator1 {
 		regulator-always-on;
 	};
 #endif
+
+	vcc_sdhi2: regulator2 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHI2 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(8, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &extal_clk {
@@ -100,6 +116,17 @@ &sdhi0 {
 };
 #endif
 
+#if SW_SD2_EN
+&sdhi2 {
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&vcc_sdhi2>;
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	status = "okay";
+};
+#endif
+
 &pinctrl {
 	sdhi0_pins: sd0 {
 		data {
@@ -139,4 +166,26 @@ sdhi0_emmc_pins: sd0-emmc {
 		       "SD0_CLK", "SD0_CMD", "SD0_RST#";
 		power-source = <1800>;
 	};
+
+	sdhi2_pins: sd2 {
+		data {
+			pins = "P11_2", "P11_3", "P12_0", "P12_1";
+			input-enable;
+		};
+
+		ctrl {
+			pins = "P11_1";
+			input-enable;
+		};
+
+		mux {
+			pinmux = <RZG2L_PORT_PINMUX(11, 0, 8)>, /* SD2_CLK */
+				 <RZG2L_PORT_PINMUX(11, 1, 8)>, /* SD2_CMD */
+				 <RZG2L_PORT_PINMUX(11, 2, 8)>, /* SD2_DATA0 */
+				 <RZG2L_PORT_PINMUX(11, 3, 8)>, /* SD2_DATA1 */
+				 <RZG2L_PORT_PINMUX(12, 0, 8)>, /* SD2_DATA2 */
+				 <RZG2L_PORT_PINMUX(12, 1, 8)>, /* SD2_DATA3 */
+				 <RZG2L_PORT_PINMUX(14, 1, 7)>; /* SD2_CD# */
+		};
+	};
 };
-- 
2.39.2

