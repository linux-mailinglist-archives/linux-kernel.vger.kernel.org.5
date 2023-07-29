Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB26767F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjG2NpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjG2NpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:45:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B403C0F;
        Sat, 29 Jul 2023 06:44:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so2249922b3a.0;
        Sat, 29 Jul 2023 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638248; x=1691243048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAMZeTLVAgGBjYw/Qy9oKOGHVaZa0ru6l71KEWlh754=;
        b=aGZ7+1O/Lm5fD/inkHAIhzdjMLy0nh6VW9eqVximCFmZafhA9X+VeREObj7125lyF7
         0bP9PuuM9kt640YRnxkNn+cmLvJBWsWEuU5pnxbLKAnxjzyRkvqT5MuTAmlyE9iPeIP+
         d8VKF5PYs4W+dzOHzQ3IqsgW+ymF/ITBT+2peWqB6v4ke+Hvdk7VWz9GS6WfXgqGvC+b
         o10OWPmIbgHvbtimSqfKBB+AcQdgRoRgMxWRBbGC/bPyGVZk82iYAYKqCD1vt8dtdaYW
         AAnd3VwKuvSqeheK7TgwULC/QmUUcMYd5tR4TPl9mCA947mM1qXV+Zz2GZhRGH6gGQuY
         5J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638248; x=1691243048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAMZeTLVAgGBjYw/Qy9oKOGHVaZa0ru6l71KEWlh754=;
        b=ZNJKZSeMd6KsXJWQN4HKl8OqWDIbpwDl9stc/ZWC1yiOr9tc0p0O79z423vJ5XTCbE
         Mvs57cyyL3Yo9HP1y1bPDZ5NejnUsRsDr+4F/oqpzb2lO2ix8reJCtDEN4IzdyEna6GA
         ImiOnvf2lxjTe9QbSTQ30DvPAbTcRxcB48IS5OkYudq2FausvjbhzdyBYQGCyvRV8Ghn
         O3tGh8e/aGmU51xHa+yRHAM/0DIfX3aG8NyyeEcCNHFbopjYLbw5IYLHTxS1MWFU7TZS
         eaxp0znntTcc3ADwpR9qj1wntAt/TAEV9pH3LUI/CgE5JfqUOIFPvETEPv7kJnY0f+B3
         d5EA==
X-Gm-Message-State: ABy/qLbDV0gpxT+gR3sPGcvi74//XoNdxzHlO+1fEYprznN51XEWT+/U
        whWWFcIYKAFMujxSFKcSMgpqPj5eHuyY1A==
X-Google-Smtp-Source: APBJJlFc1j3VZl5wVQuzPpI4DwjNKg2Py7dMiE9Bn5ejPj+FooTvvz+VP6zE5Yrj3OOn91NAtD99qQ==
X-Received: by 2002:a05:6a00:194f:b0:667:85e6:4e9 with SMTP id s15-20020a056a00194f00b0066785e604e9mr5965561pfk.24.1690638247871;
        Sat, 29 Jul 2023 06:44:07 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:44:07 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 10/17] MIPS: loongson32: Convert GPIO LED platform device to DT
Date:   Sat, 29 Jul 2023 21:43:11 +0800
Message-Id: <20230729134318.1694467-11-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO LED device nodes for Loongson-1 boards,
and drop the legacy platform devices and data accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   | 19 +++++++++++++++
 arch/mips/boot/dts/loongson/smartloong_1c.dts | 19 +++++++++++++++
 arch/mips/loongson32/ls1b/board.c             | 23 -------------------
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
index a43df21f2904..8ee76ecdafbb 100644
--- a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
+++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
@@ -5,6 +5,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "loongson1b.dtsi"
 
 / {
@@ -26,6 +28,23 @@ xtal: xtal {
 		clock-output-names = "xtal";
 		#clock-cells = <0>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led9 {
+			label = "led9";
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led6 {
+			label = "led6";
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "nand-disk";
+		};
+
+	};
 };
 
 &gmac0 {
diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/boot/dts/loongson/smartloong_1c.dts
index 2d8f304aa2c4..96387cc814ca 100644
--- a/arch/mips/boot/dts/loongson/smartloong_1c.dts
+++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
@@ -5,6 +5,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "loongson1c.dtsi"
 
 / {
@@ -26,6 +28,23 @@ xtal: xtal {
 		clock-output-names = "xtal";
 		#clock-cells = <0>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "led0";
+			gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "nand-disk";
+		};
+
+	};
 };
 
 &gmac0 {
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index baadc524cc88..4cad019d655f 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -12,27 +12,6 @@
 #include <nand.h>
 #include <platform.h>
 
-static const struct gpio_led ls1x_gpio_leds[] __initconst = {
-	{
-		.name			= "LED9",
-		.default_trigger	= "heartbeat",
-		.gpio			= 38,
-		.active_low		= 1,
-		.default_state		= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name			= "LED6",
-		.default_trigger	= "nand-disk",
-		.gpio			= 39,
-		.active_low		= 1,
-		.default_state		= LEDS_GPIO_DEFSTATE_OFF,
-	},
-};
-
-static const struct gpio_led_platform_data ls1x_led_pdata __initconst = {
-	.num_leds	= ARRAY_SIZE(ls1x_gpio_leds),
-	.leds		= ls1x_gpio_leds,
-};
-
 static struct platform_device *ls1b_platform_devices[] __initdata = {
 	&ls1x_ehci_pdev,
 	&ls1x_rtc_pdev,
@@ -41,8 +20,6 @@ static struct platform_device *ls1b_platform_devices[] __initdata = {
 
 static int __init ls1b_platform_init(void)
 {
-	gpio_led_register_device(-1, &ls1x_led_pdata);
-
 	return platform_add_devices(ls1b_platform_devices,
 				   ARRAY_SIZE(ls1b_platform_devices));
 }
-- 
2.39.2

