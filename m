Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A521A76F93D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHDFB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjHDFAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:00:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7242B44A4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 22:00:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c4923195dso225812866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 22:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1691125219; x=1691730019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IX2gVzlYc0IbH9Z7O7YhUyubEeByOYaVbMRDVDTozoA=;
        b=KnSGNk6Z82yrDmK03jM+I9bXhjU13Pk9eDIzJDCs/BYwlVxGdZc+Rwm7Sdb9+6mtg7
         SMGGFUfGkD/ErYSUGSRIlRW+k9eyJGFvRBadQsI08T5TuzUhdmCkp8pLs4AE0T9qG557
         JzuuDOWdmK9LIGsSLDQhFe0B9OlZ/oefx2a4kMPKyHNsEovwjJoVAPN667dygI2ol8xp
         ZLnXFV7N16b4o0+p1cv+tiV8Z2m94grJLvPlyxwC4+2T8rNAXlNyAbnyMAUzArqTVCeH
         dRBQcIOj5jAhJ56o3GkCVFRDpBM67zYrQMRiAWleEHR7x/dWNTPLHP5IB2xMbPGHKsyq
         HofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691125219; x=1691730019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IX2gVzlYc0IbH9Z7O7YhUyubEeByOYaVbMRDVDTozoA=;
        b=NPSh8WcpK74NE8nuPoUJLjFPCwu11Y4KPLAXznyet0MJJB9sMcxoJv/0VZuGntgrVl
         PxtuOM4vJH+URnUbRu83n5H99Npwr+Gz1p/p04ONyo0VRWBk01dHn899uSduakXfqrEp
         QetQ+jaBWoPMcoqGFGbDU8mLat7ZLwPp10TcIQPRU8iExvMNDlFOR4g/Htsd8N24k5aW
         ZQ9FqNhEW3/VgTJmX6OLWrvV+kmsdf11KGHXBgdkg/GV3Xc7hRYdbQjX+PZYJZxNydWS
         IK/BwM6uz3EcDwCUw/hvRdRUr2Su99fLAQhTZ6Xuj0pA4MTKmgba4n1leUtKIwlXv/1r
         umCQ==
X-Gm-Message-State: AOJu0Yya49t3nApYwXk5BkoeVsj46SvbhvLoJ+W8TugEcUaWPI4AsW1H
        RqXBSpSLHIf0hxxTTemhlmduQg==
X-Google-Smtp-Source: AGHT+IFCUZU9a4TKGl8P9srlXXK67nKOj0/XpD0wzNap0FS0y6wrAkbSOoO8HEMn1dV4NkwEfAHfpQ==
X-Received: by 2002:a17:906:290:b0:99b:c7dc:b02 with SMTP id 16-20020a170906029000b0099bc7dc0b02mr609013ejf.57.1691125218978;
        Thu, 03 Aug 2023 22:00:18 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id x14-20020a1709064bce00b0098f33157e7dsm739999ejv.82.2023.08.03.22.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 22:00:18 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, maz@kernel.org,
        srinivas.kandagatla@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, sre@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Date:   Fri,  4 Aug 2023 08:00:07 +0300
Message-Id: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS entries with a valid email address as the Microchip
one is no longer valid.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---

Changes in v2:
- collected tags
- extended the recipients list to include individual subsystem
  maintainers and lists instead using only linux-kernel@vger.kernel.org
  as suggested initially by get_maintainers.pl

 MAINTAINERS | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 128fd295f86f..d48d8e857f57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2351,7 +2351,7 @@ F:	drivers/phy/mediatek/
 ARM/MICROCHIP (ARM64) SoC support
 M:	Conor Dooley <conor@kernel.org>
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
@@ -2360,7 +2360,7 @@ F:	arch/arm64/boot/dts/microchip/
 ARM/Microchip (AT91) SoC support
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 W:	http://www.linux4sam.org
@@ -3265,7 +3265,7 @@ F:	include/uapi/linux/atm*
 
 ATMEL MACB ETHERNET DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 S:	Supported
 F:	drivers/net/ethernet/cadence/
 
@@ -13880,7 +13880,7 @@ F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
 F:	drivers/spi/spi-at91-usart.c
 
 MICROCHIP AUDIO ASOC DRIVERS
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/sound/atmel*
@@ -13903,7 +13903,7 @@ S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
 
 MICROCHIP EIC DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/microchip,sama7g5-eic.yaml
@@ -13976,7 +13976,7 @@ F:	drivers/video/fbdev/atmel_lcdfb.c
 F:	include/video/atmel_lcdc.h
 
 MICROCHIP MCP16502 PMIC DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
@@ -14003,7 +14003,7 @@ F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 F:	drivers/mtd/nand/raw/atmel/*
 
 MICROCHIP OTPC DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -14042,7 +14042,7 @@ F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 F:	drivers/fpga/microchip-spi.c
 
 MICROCHIP PWM DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-pwm@vger.kernel.org
 S:	Supported
@@ -14058,7 +14058,7 @@ F:	drivers/iio/adc/at91-sama5d2_adc.c
 F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
 
 MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
@@ -14075,7 +14075,7 @@ S:	Supported
 F:	drivers/spi/spi-atmel.*
 
 MICROCHIP SSC DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -14104,7 +14104,7 @@ F:	drivers/usb/gadget/udc/atmel_usba_udc.*
 
 MICROCHIP WILC1000 WIFI DRIVER
 M:	Ajay Singh <ajay.kathat@microchip.com>
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/microchip/wilc1000/
-- 
2.39.2

