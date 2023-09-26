Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99A7AE8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjIZJGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjIZJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:06:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B39E5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:06:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb9cdso82334275e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695719192; x=1696323992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYPORNOx4NuRhf6WfJUJoSr5UgLUFNvcuKhQTL+JrnY=;
        b=bjix63Oiqxi1eSIKv9kBiX/Y0i0bcLq6Z5XapGVl3wP569BlLSVeq9yeTZmfjxGLGs
         g/NbbROM3rcc190ZeDit6F6ywrVhKSRXqjTfh0tUC5q/syS9+WbaiFIuABLko3wKT8cW
         h+bwnFDc5j0pbBgN1N6DSysuyCn5ncUxFEHkjxW0fel9lsxg1o1SSD6Rv0eMn/P6IjGv
         IgGVU1K/NAys2z9Y65lCYwsY3AXb3UTP2/w61tMmB/aY/BYGZaR0l/1qE9HgNO+va8a8
         8oq4ysr1nqvt/SAVIeHfp8uE8qUTy2Vhz9NREE8CoWOn+PB0V2Q0h1cpWq/5r1y/Whtg
         b4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695719192; x=1696323992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYPORNOx4NuRhf6WfJUJoSr5UgLUFNvcuKhQTL+JrnY=;
        b=ErRxr91xhoDVD0x+pTmi0LYz4kMCRsI4uC1O5jnJnrUp0acyHa9V2c5mlx02SNdsTY
         uKVsxHw/3Dugvg1dZu9n7W3rqlXPPPvpjisxw5bn1OONstVhFo+ZvkEWw5cI9QChtm9j
         PEyigy7qOrtxSghXjV6deWVPvWZJ+wZ1ugoqg3chboRFbKQm06s/vkUE9/hA9xcrBJv/
         sIkYNNRSodOUJC9EK8Uj9Zb7sdl0r7nMpEs3jB+iiAUFAOKHpOPZbXBUjMQUtFwQVtcL
         sk7Hea7ZFsbirFdB4AdsTjJ0LMPvgjvq9mFVz7/Ninig474yfXjrf1a3CqyNq6fgU9jH
         OZSQ==
X-Gm-Message-State: AOJu0Yxr8VHmwIcxoTNG63KeqP9Yyw+g/oIHMc/4cO5JT6AHr+s84uo0
        itHjInzoIEPXFFZzjI3JiazKBw==
X-Google-Smtp-Source: AGHT+IHECvSMOxEXPR/Wch2K8u8yhXgBh2SGThdb3d5Y/uoLHNyMF9X2ZGAX1MvecWbgmJnLQpviVw==
X-Received: by 2002:a05:600c:2050:b0:401:906b:7e9d with SMTP id p16-20020a05600c205000b00401906b7e9dmr8005516wmg.18.1695719191864;
        Tue, 26 Sep 2023 02:06:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:686:c497:30b1:d2b9])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c230e00b00402f7b50517sm14686841wmo.40.2023.09.26.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 02:06:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH] mtd: rawnand: ingenic: move the GPIO quirk to gpiolib-of.c
Date:   Tue, 26 Sep 2023 11:06:23 +0200
Message-Id: <20230926090623.35595-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have a special place for OF polarity quirks in gpiolib-of.c. Let's
move this over there so that it doesn't pollute the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
This is an alternative to the previous patch that instead of replacing
one active-low setter with another, just moves the quirk over to
gpiolib-of.c

 drivers/gpio/gpiolib-of.c                       |  9 +++++++++
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 12 ------------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 5515f32cf19b..58c0bbe9d569 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -192,6 +192,15 @@ static void of_gpio_try_fixup_polarity(const struct device_node *np,
 		 */
 		{ "himax,hx8357",	"gpios-reset",	false },
 		{ "himax,hx8369",	"gpios-reset",	false },
+		/*
+		 * The rb-gpios semantics was undocumented and qi,lb60 (along with
+		 * the ingenic driver) got it wrong. The active state encodes the
+		 * NAND ready state, which is high level. Since there's no signal
+		 * inverter on this board, it should be active-high. Let's fix that
+		 * here for older DTs so we can re-use the generic nand_gpio_waitrdy()
+		 * helper, and be consistent with what other drivers do.
+		 */
+		{ "qi,lb60",		"rb-gpios",	true },
 #endif
 	};
 	unsigned int i;
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
index 6748226b8bd1..c816dc137245 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
@@ -380,18 +380,6 @@ static int ingenic_nand_init_chip(struct platform_device *pdev,
 		return ret;
 	}
 
-	/*
-	 * The rb-gpios semantics was undocumented and qi,lb60 (along with
-	 * the ingenic driver) got it wrong. The active state encodes the
-	 * NAND ready state, which is high level. Since there's no signal
-	 * inverter on this board, it should be active-high. Let's fix that
-	 * here for older DTs so we can re-use the generic nand_gpio_waitrdy()
-	 * helper, and be consistent with what other drivers do.
-	 */
-	if (of_machine_is_compatible("qi,lb60") &&
-	    gpiod_is_active_low(nand->busy_gpio))
-		gpiod_toggle_active_low(nand->busy_gpio);
-
 	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
 
 	if (IS_ERR(nand->wp_gpio)) {
-- 
2.39.2

