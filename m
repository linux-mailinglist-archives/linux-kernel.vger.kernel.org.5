Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3388177D70A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbjHPAXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbjHPAXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:23:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086B2100;
        Tue, 15 Aug 2023 17:23:16 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a6f3ef3155so4759033b6e.1;
        Tue, 15 Aug 2023 17:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692145395; x=1692750195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmdkJVdFz/V7Zt8mJfhJXtTYea+Vk2ji53hyZ/nqh5o=;
        b=oz631v2Sc2jnjywDJAuGZ4VgEpivt3aUYpieXf++7r3REV0ERwCY07rxBabH6mGgy+
         u5GBtH5+gD5xLjBHv1gDgyL9XjjsFjsfi3ujhohHwA/g1dpIOv7yBGMLsyZnPXhoiGrD
         NCekMsziWlEXJfqrptg21o+ddhHVZObvxKYwXIdQEOuO4eaHuPGbtc4+9xQRmoW1/g/Q
         /SDVlzgWnvfbDsvVGVuh8vD1+oMyrl0dtQiWSFK0cZCWfs5yBEu3DZKtwkErpoKJpIXg
         WGHQrZTuIuZaEi3eda1UBD1tNxjgT4kXtqqATArtZeD8XHl2jh9C5aoogtdcIaa7FnMF
         qtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692145395; x=1692750195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmdkJVdFz/V7Zt8mJfhJXtTYea+Vk2ji53hyZ/nqh5o=;
        b=gaMJ4FENBV5WK2R0SjzZDrcFhndIWCfMhPpDsHraRgkfB1iEVnPH+Ps5JZ73lpMmK2
         4DPvbg3JPwtGwGBWjW0MAppwAMv+ESRCA//IAqTKNg2exgFO1Yp3UAZ9AVV+IppZKZmI
         0neWfhLySzRmaPQe4PsS72xUJ3K4lyumQkYBwgagHEpQ7Iw0s9MeU20o5mdtf5asKNlH
         gWHiDWSRMiyznaBkzehsPBB+t5+64XLmDUDmLACT/PtspwcJz66mX/SBrDGKWKZSzuYk
         PUeZBF2ZqTRVikLt5oJsS0M9SvHw3uqUz1WPtPj0BTTtyjFV84rFvE8OwhQYC8PizBaQ
         i89w==
X-Gm-Message-State: AOJu0YzChC9bcVuDP3rHdPArGAdE6mr1VLy3koKRhAE/Ns7ZVa5QLcar
        ddqKzsWPzABk+bMiJV76esDfTwJuofo=
X-Google-Smtp-Source: AGHT+IEOIHLFSZYxB/VgZ5IKyAw6W89fduHPK83Y2Mk1nJBihRAhBRzgj2dkTrH94Xlc0dKbmwRUjw==
X-Received: by 2002:a05:6808:18a3:b0:3a7:2524:6d3b with SMTP id bi35-20020a05680818a300b003a725246d3bmr410590oib.12.1692145395439;
        Tue, 15 Aug 2023 17:23:15 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id r11-20020a0ccc0b000000b0063d5c9de720sm4452436qvk.80.2023.08.15.17.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 17:23:14 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: am335x-pocketbeagle: update LED information
Date:   Tue, 15 Aug 2023 20:23:04 -0400
Message-ID: <20230816002308.36800-2-twoerner@gmail.com>
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

The "label" property is deprecated. Replace the "label" property with
"color" and "description" properties.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
index 5dfe4d4bab93..1c11245f6864 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -8,6 +8,7 @@
 
 #include "am33xx.dtsi"
 #include "am335x-osd335x-common.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "TI AM335x PocketBeagle";
@@ -24,28 +25,32 @@ leds {
 		compatible = "gpio-leds";
 
 		led-usr0 {
-			label = "beaglebone:green:usr0";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_HEARTBEAT;
 			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
 		led-usr1 {
-			label = "beaglebone:green:usr1";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_DISK_ACTIVITY;
 			gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		led-usr2 {
-			label = "beaglebone:green:usr2";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_CPU;
 			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "cpu0";
 			default-state = "off";
 		};
 
 		led-usr3 {
-			label = "beaglebone:green:usr3";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_INDICATOR;
 			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-- 
2.41.0.327.gaa9166bcc0ba

