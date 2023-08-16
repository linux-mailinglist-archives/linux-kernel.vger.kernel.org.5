Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAC77D70B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbjHPAXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbjHPAXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:23:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D962110;
        Tue, 15 Aug 2023 17:23:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76d072daea2so396028885a.1;
        Tue, 15 Aug 2023 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692145397; x=1692750197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5K+gUGCsAol5AOSj18zMfCSNxRbg5FuBq7GV8eAAR8=;
        b=DnOvWmbOOWvIOptsMgo8Sx+uN3YXulsCHUGAquiE8sfDjtPSaiGze+Pjwnsx/2mRlT
         LpOl6YbtoEFpZOgwS0Y0kVF5WPl6js4pDyaVhzzqdYs9Gp9PAcGg+q7SCjWJ+KyRgD4S
         Pf6pGNgNGJpdw9kFslfY+c7unVYqTblrL4DwnKRGqNR/fu4uPyEVxeo0vB57B9vcaRP7
         wG+yC6vUthUZqiGa1HPS825zimuKo9OlbqYESTI7c6DbjIE81gZq9fLff82OQLNYGZMY
         UOHwTwWLGUVRSANcG9eRUxTTvnNx/445o9EtTuVT52WS1VMz1oXY/roixrrj/C1o4UVX
         +CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692145397; x=1692750197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5K+gUGCsAol5AOSj18zMfCSNxRbg5FuBq7GV8eAAR8=;
        b=LZStvuDU09DpQnaP3OdQxcM4div7fGaATdlTWpO6I59Xs8lDzhoWGyrDleIM2l4Asu
         jzFivWWQb35k65+Dwz/es3y3mMxRncDlNKdjW2An6fLYeywk14g5kPmbhl4bHT0wetnC
         vX0zB9y2bKAljgIWahSBwC0hV/fVYiqTNXyRut0EbRMce56U9idwrGcfXslg8KtK6HVO
         nYYFdc8Em3rG9hXO8rAw8n68BcK5Ax9a3m04mQnHrg2yzLKF+T0I43r5SQ7I5Wc+nz6B
         pH4OZlMUOjRAi971rn+sJNNd1j1WCrmcOwTEA597m3S3hNzPE+/UsIF0i7xwKt3q9St0
         1Piw==
X-Gm-Message-State: AOJu0Yw0xsm5buxzXgISnGgL09Kexwgo4z6OqhbgSY3e9ii7DBoFOCWi
        pRyRAVsiAuZYgxx8i//XlVp8eoPa2Ec=
X-Google-Smtp-Source: AGHT+IGv5izfsdTvq3Xw2+BTG+QTJe44VVAhetc8jF7LhciTqdRbuyi0eVW9PKK3pmUtHYaW+INPgA==
X-Received: by 2002:a05:620a:40cb:b0:763:9f31:1588 with SMTP id g11-20020a05620a40cb00b007639f311588mr527264qko.70.1692145397545;
        Tue, 15 Aug 2023 17:23:17 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id r11-20020a0ccc0b000000b0063d5c9de720sm4452436qvk.80.2023.08.15.17.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 17:23:16 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: am335x-pocketbeagle: enable pru
Date:   Tue, 15 Aug 2023 20:23:05 -0400
Message-ID: <20230816002308.36800-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230816002308.36800-1-twoerner@gmail.com>
References: <20230816002308.36800-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the PRU code is upstream and can be loaded via remoteproc, adjust
the device tree to enable it and adjust the pin muxing so that the default
setting of the pins matches what's is given on the silkscreen and/or
pocketbeagle wiring.

Caveat: In most cases, the silkscreen will indicate, for example, "PRU0.7",
        but it doesn't indicate whether that pin should be enabled for input
        or output. On the PRU a different MODE is used for input versus
        output. So it is unclear which mode to enable (MODE5 = output, MODE6
        = input). In cases where there is a choice (PRU1.11, PRU0.7, PRU0.4,
        PRU0.1, PRU1.10, PRU0.6, PRU0.3, PRU0.2, and PRU0.5) output is assumed
        (MODE5).

        The remaining PRU silkscreen pins do not have a choice and are set as
        follows:
                PRU0.16  MODE5 input
                PRU0.15i MODE6 input

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../boot/dts/ti/omap/am335x-pocketbeagle.dts  | 48 ++++++++++++++-----
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
index 1c11245f6864..6d875cf13e09 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -117,7 +117,7 @@ &gpio1 {
 		"P2.24",
 		"P2.33",
 		"P2.22",
-		"P2.18",
+		"P2.18 [PRU0.15i]",
 		"NC",
 		"NC",
 		"P2.01 [PWM1A]",
@@ -214,7 +214,7 @@ &am33xx_pinmux {
 	pinctrl-names = "default";
 
 	pinctrl-0 =   < &P2_03_gpio &P1_34_gpio &P2_19_gpio &P2_24_gpio
-			&P2_33_gpio &P2_22_gpio &P2_18_gpio &P2_10_gpio
+			&P2_33_gpio &P2_22_gpio             &P2_10_gpio
 			&P2_06_gpio &P2_04_gpio &P2_02_gpio &P2_08_gpio
 			&P2_17_gpio >;
 
@@ -272,15 +272,6 @@ AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE7)
 		pinctrl-single,bias-pulldown   = < 0x10  0x00  0x10  0x18>;
 	};
 
-	/* P2_18 (ZCZ ball U13) gpio1_15 0x83c PIN 15 */
-	P2_18_gpio: P2-18-gpio-pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE7)
-		>;
-		pinctrl-single,bias-pullup   =   < 0x10  0x10  0x00  0x18>;
-		pinctrl-single,bias-pulldown   = < 0x10  0x00  0x10  0x18>;
-	};
-
 	/* P2_10 (ZCZ ball R14) gpio1_20 0x850 PIN 20 */
 	P2_10_gpio: P2-10-gpio-pins {
 		pinctrl-single,pins = <
@@ -406,6 +397,27 @@ AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)	/* (T17) gpmc
 			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_OUTPUT_PULLDOWN, MUX_MODE6)	/* (U17) gpmc_wpn.uart4_txd */
 		>;
 	};
+
+	pru0_pins: pinmux-pru0-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_INPUT_PULLUP, MUX_MODE5)/* (D14) xdma_event_intr1.pr1_pru0_pru_r31_16 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE5)/* (A14) mcasp0_ahclkx.pr1_pru0_pru_r30_7 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKR, PIN_OUTPUT_PULLDOWN, MUX_MODE5)	/* (B12) mcasp0_acklr.pr1_pru0_pru_r30_4 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSX, PIN_OUTPUT_PULLDOWN, MUX_MODE5)	/* (B13) mcasp0_fsx.pr1_pru0_pru_r30_1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE6)	/* (U13) gpmc_ad15.pr1_pru0_pru_r31_15 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR1, PIN_OUTPUT_PULLDOWN, MUX_MODE5)	/* (D13) mcasp0_axr1.pr1_pru0_pru_r30_6 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKR, PIN_OUTPUT_PULLDOWN, MUX_MODE5)/* (C12) mcasp0_ahclkr.pr1_pru0_pru_r30_3 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_OUTPUT_PULLDOWN, MUX_MODE5)	/* (D12) mcasp0_axr0.pr1_pru0_pru_r30_2 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSR, PIN_OUTPUT_PULLDOWN, MUX_MODE5)	/* (C13) mcasp0_fsr.pr1_pru0_pru_r30_5 */
+		>;
+	};
+
+	pru1_pins: pinmux-pru1-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE5)/*(R6) lcd_ac_bias_en.pr1_pru1_pru_r30_11 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE5)	/* (V5) lcd_pclk.pr1_pru1_pru_r30_10 */
+		>;
+	};
 };
 
 &epwmss0 {
@@ -487,3 +499,17 @@ &usb0 {
 &usb1 {
 	dr_mode = "host";
 };
+
+&pruss_tm {
+	status = "okay";
+};
+
+&pru0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pru0_pins>;
+};
+
+&pru1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pru1_pins>;
+};
-- 
2.41.0.327.gaa9166bcc0ba

