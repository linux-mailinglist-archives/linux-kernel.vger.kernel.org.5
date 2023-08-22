Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05848784446
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjHVObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjHVObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:31:11 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6285CCA;
        Tue, 22 Aug 2023 07:31:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4108da3a9efso19771591cf.0;
        Tue, 22 Aug 2023 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692714669; x=1693319469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1y0ssjEfvJL8cH6v7C8R2TDxgKl3uHam44e68F6Nws=;
        b=iYFY4QyvlIde0zN55CBSvnBwK56ICgT/hvPvw4PlDQ9HgN0lGjs6J8gQjp6Vm3iPZB
         SS/bZYQzN+D9CNcOs4LbTP4/MMgck5hV7mWB095eJ2mNl0/BQdNq2+lRYyw3EoFd4PTc
         zV3Ve8DZHft1Crj6FL7hCCpgdb9P/Ez6JNK4KR07pRkCIuAWb3nAiLziEu49rTzal91l
         59vi6A6ixMLXxJ32oqIHjU55VNapXAfSuZPHLaCy9EIbXNhY9eEbpZs5SYc8X7qRX34V
         pHPlK+g8i2sxlj+gQ8Jd50yx+qseoIpuznwc2SUwRXIls8ZjMBMnuSpXeBHZ1u46Kqab
         pesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714669; x=1693319469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1y0ssjEfvJL8cH6v7C8R2TDxgKl3uHam44e68F6Nws=;
        b=OefQkAt2vlq11MhZfamRdVK8SutCLv0UYXESNs4Df2GU1QDt0O92/Hme5mVVDuK15R
         YbB5lP6WHqd4i7sbBIPHH1pkV46gJ2FC1hGqEhmNm42kfgKJyDMTCImZgkImMmA0E3/D
         gVZ3Bc3v9DR6JJ9je041kEtwwxRg0QKTp12ijQ44+9mHJ9QQy7WDlEPCRGvFjr4Yq4Dn
         qY+qaG8meyyk0yB9Wz88r0dd6VNn1b3h7dAmGd/K8M+e/7NzJ1ZQH9ncOvr4vnr774De
         I5AxznyKriSefnxzI0BUjYUmxk6tSq8U+wI9JdmwkQqxiRhIiQ5wAmEuD6AHPDHp2Etk
         WDeg==
X-Gm-Message-State: AOJu0YwgUQ+ne6aQiPbYusDucAs4LFRK/aK1Mw7kkgw7wVvyETIqK+R2
        z6n4t7yUf6Nm8+Ox7ukLFSbViMw730k=
X-Google-Smtp-Source: AGHT+IG5gfkKQlRt4vF/85xVOFuI+mEbQ2tCzjo7GsAhNErl14UR0XTSkZFe+qKxh56k5k0x6p9/0g==
X-Received: by 2002:ac8:5c42:0:b0:410:8b14:a324 with SMTP id j2-20020ac85c42000000b004108b14a324mr12735362qtj.10.1692714668883;
        Tue, 22 Aug 2023 07:31:08 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id e19-20020ac86713000000b00407ffb2c24dsm3055750qtp.63.2023.08.22.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:31:08 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     robertcnelson@gmail.com, drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v3 3/4] ARM: dts: am335x-pocketbeagle: enable pru
Date:   Tue, 22 Aug 2023 10:30:49 -0400
Message-ID: <20230822143051.7640-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230822143051.7640-1-twoerner@gmail.com>
References: <20230822143051.7640-1-twoerner@gmail.com>
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
index d4d1770657da..e35d84ca5706 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -121,7 +121,7 @@ &gpio1 {
 		"P2.24",
 		"P2.33",
 		"P2.22",
-		"P2.18",
+		"P2.18 [PRU0.15i]",
 		"NC",
 		"NC",
 		"P2.01 [PWM1A]",
@@ -271,15 +271,6 @@ AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE7)
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
@@ -405,6 +396,27 @@ AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)	/* (T17) gpmc
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
@@ -486,3 +498,17 @@ &usb0 {
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

