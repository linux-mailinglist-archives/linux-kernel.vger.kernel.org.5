Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49BD780EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378017AbjHRPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378005AbjHRPKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:10:53 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94443E5F;
        Fri, 18 Aug 2023 08:10:51 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76d7fcb2c62so47143485a.1;
        Fri, 18 Aug 2023 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371450; x=1692976250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewif9NKARrISeGXS+V8nJkH4mEQcEW7vbK6BMHgIf44=;
        b=lSGH84z8Q1n0DduUUjkXYKz8+MtOzCXyRp/8tUHOeA06yvaMdVZbdl6Um0h6qwUdtj
         MdwdGv5quXcmLRYao8J0OroBeadRewsfI54ZnqgFvAXRca0OYAci6184znaWMSnVpTqs
         02PuVjt8Ry8Y66z2D+Xug5Nj3AvVHCC+i9m09zxbZWM4l9k47NXd6g8Povpiq7r2VP2a
         GwnZRYFJMaysENDrB5zocO/owk26DTcR3m1h4JcKIRKS574e0FJz9DqB3dKaAIfdXNus
         ++JUXUXs6eo3b99iae+XJ1/glbDpi4uJ0bBEypVUoaJx2jG0a6SSrtVXr4ZdvuzxZjWw
         tH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371450; x=1692976250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewif9NKARrISeGXS+V8nJkH4mEQcEW7vbK6BMHgIf44=;
        b=I/8dplOb+koQHnVNjmv6/YpqKCljppUJEsbzZqibLV5zAMYMstFXzFBoFzib3X3VhG
         wzOHyyzCSSyhteQfnEqPabLnZmO2romfaEcVvPfRDow2U13LR2Y8TnpsSwkkoHb77Ooe
         MdIpCKWhTFloZh2M8Re+W9cvSaCE6foU5NJfdC/vw3Xl/xHMYwHk7oJGZaF9T30lAVxX
         i6ZIWnQjuSVnw+o5yIuNJCohD4FaxrU7VHwQSLgJARB/pR0OqAJNEskA1/SUo56/+Ga4
         WMXXLyCO/LgtAB27VtmU36Zmid5b/PZNk8RsVrzXivGBmvlKM7diffU842Rdr3NZNhXj
         1HtQ==
X-Gm-Message-State: AOJu0Yxq9MxWkDEKcwfjnll0aC4uCfrVrNC13PlHp+iIwIQxdXiKmmLx
        oRY2AwbK4vry6h1Cd9oV1/A=
X-Google-Smtp-Source: AGHT+IFPXm9FNDV9ZKrnKikn83KeFQrgrazsD2PjKfJ7007vutUeKNJmaGXySsG9wv5RPpbIMrWvhg==
X-Received: by 2002:a05:620a:bcc:b0:76c:d2be:b7d with SMTP id s12-20020a05620a0bcc00b0076cd2be0b7dmr2911585qki.14.1692371450665;
        Fri, 18 Aug 2023 08:10:50 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a148300b0076cbcf8ad3bsm576239qkj.55.2023.08.18.08.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:10:49 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: am335x-pocketbeagle: enable pru
Date:   Fri, 18 Aug 2023 11:10:36 -0400
Message-ID: <20230818151039.40566-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230818151039.40566-1-twoerner@gmail.com>
References: <20230818151039.40566-1-twoerner@gmail.com>
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
 .../boot/dts/ti/omap/am335x-pocketbeagle.dts  | 46 +++++++++++++++----
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
index 1e72b8382597..fe4a1dbd8d88 100644
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
@@ -267,15 +267,6 @@ AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE7)
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
@@ -401,6 +392,27 @@ AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)	/* (T17) gpmc
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
@@ -482,3 +494,17 @@ &usb0 {
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

