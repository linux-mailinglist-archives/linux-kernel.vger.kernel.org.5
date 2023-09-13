Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0375F79E736
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbjIMLu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbjIMLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:50:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E8F19B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:50:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so5277975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694605820; x=1695210620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfIOoxhDAqFwndjqT4NZlTiK/Oyr/4kFj6yAfQvO5X0=;
        b=Kt6Dg9PAdyJu64rbRPiB/YQgnFDw/OTAazlhmKFCcQR0Ugv08vQcaaQRM7oBHf1byY
         47lb+nXanFWkiCncaBrTTF8VjZi41cJk1geT4sZvi0kq3u0PYDxTtTc+ciiSEDfnIx8h
         MNorN4K13cYToGQvg1ybvkl7Q2ATPTjM0D4VsuLG0fGGQfexm7kfL5yV4l/mbEPLDGAz
         0pZwtXHiZ3QIl36ugfVsMeFPgFcuD85S8XMxDM/JJrWTBwNWIdnIcNGM9bua0y/ge7eu
         vVmV6fkE4S3cAoP66fpvhNrc2+Z6Y5hAGD8PIoUqu49BuEjjxpn3rzFQFzLsbVnGtnH3
         qVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694605820; x=1695210620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfIOoxhDAqFwndjqT4NZlTiK/Oyr/4kFj6yAfQvO5X0=;
        b=cUuerw+Zv5MYQaUssIaQlaPVeJWrCGS1NHWSz73wTcuNbUJjROzmV6/hqaNN5PCNK7
         cq/Y/HkSnvBl27EImUwYy6h1TkDdTbeOyHIw7eSFADmVJb1ToNdIZm9Ak+1QIrR+kx4L
         NLbm3X0B8MBH/OSXooqcErDjrp0sKX3+OwBJF1TNRJhzsxC4x4NBMGRPWqEkQg+HASwv
         e3GTMS1tUWwPyq9lZA35zxA3q9fwXKw7Bzo/BTKI2IEd21tTpnZbSI1VYRGNBlpABIgU
         +v9IoX6D60/cm5ta4MqncRJ1u51qImPyqeL1n8Q3y9jz3xE5Dthw7M7Cc9ZvqSdabxsX
         gUfQ==
X-Gm-Message-State: AOJu0YwJHDyZmRYpI5BIudlQ9QDw4nj+qhRT3o39IvytLLOBS0P+z0oA
        pBashHBzP/YicGzGrC8BgP/j8Q==
X-Google-Smtp-Source: AGHT+IG+tXi5eOBKUfSbBaQCtatc0omt4sm58mllw94JLePpeq53xP2hYKGlGG+xCKfpc+HJfdMuUQ==
X-Received: by 2002:a5d:5b18:0:b0:31f:cc46:3db9 with SMTP id bx24-20020a5d5b18000000b0031fcc463db9mr1114110wrb.26.1694605820092;
        Wed, 13 Sep 2023 04:50:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3b50:bca5:a754:7463])
        by smtp.gmail.com with ESMTPSA id j14-20020adfd20e000000b0031fc4c31d77sm1932689wrh.88.2023.09.13.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:50:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/5] mtd: rawnand: ingenic: use gpiod_set_active_high()
Date:   Wed, 13 Sep 2023 13:49:58 +0200
Message-Id: <20230913115001.23183-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913115001.23183-1-brgl@bgdev.pl>
References: <20230913115001.23183-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the new, less cumbersome interface for setting the GPIO as
active-high that doesn't require first checking the current state.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
index 6748226b8bd1..c055133c45fe 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
@@ -388,9 +388,8 @@ static int ingenic_nand_init_chip(struct platform_device *pdev,
 	 * here for older DTs so we can re-use the generic nand_gpio_waitrdy()
 	 * helper, and be consistent with what other drivers do.
 	 */
-	if (of_machine_is_compatible("qi,lb60") &&
-	    gpiod_is_active_low(nand->busy_gpio))
-		gpiod_toggle_active_low(nand->busy_gpio);
+	if (of_machine_is_compatible("qi,lb60"))
+		gpiod_set_active_high(nand->busy_gpio);
 
 	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
 
-- 
2.39.2

