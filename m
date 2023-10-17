Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6961B7CC26D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjJQMHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343569AbjJQMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:06:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9329F1733
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4060b623e64so35182615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544316; x=1698149116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTV/yldDdNeFa7KR560LkbzuRdncwWStAsZOIrIjz5U=;
        b=va1M7kmCWEvSEgK4tGclH4CB57MDbCIwjECHGPYA+7WGBS+zk+tl1XNx3B5iAbSO/z
         /Yikn4MP6VO+qU7miBO0zbOMOxWLAMAiOO0elMa0BrpAxwAcAThfpIp9HUIPNBPZhPrA
         Wb+KhAjh4ItYM0AaCC4D/DrnnhKAWHcSL6+Pg148wnet2B+HyaWBFeakCFYO+jXop0mv
         lGplCLqRb51/Mu6G4tfpi6kmW18M0V+tbgVDcMhK3SXOWAxf7BRDSEz1BdtRX0d2oSgV
         2x9wL9OnxJK+gkV+URilXCRFZj7fFAJWdKiUEhj2kfQq/fFheDnfYBnDvcpgWKxcTlT0
         MtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544316; x=1698149116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTV/yldDdNeFa7KR560LkbzuRdncwWStAsZOIrIjz5U=;
        b=GFCahWvGGHiQgz/0MEmvaKbtNfRA7wkW2TtBy1UXYTx0bQ4L2a7y8wuYATSA09VI5i
         2+ewD/QJZBrlfPSSoRUqhRvMzHLuhfTJ2hjjCjwc4mRiYRbWB5jggkjcH5XFv429977S
         RbSwePzrhQxwVB0+vBmhJBnfWMTCw6H8uZ1uqtviF1eGlE64Ze1xjcAQrUN0wGq7aKjp
         MobU+2eyBWTX6/fOYRNG63vu2GnL8GOv+nRJuqKIdzlPSJcJ77D6zrpH3UQxZoqIYh3g
         ArHg+9EcQ+2pwkKh3gq4XsKJRS3oYl7d4Q964KkxFPnXiyYjyWxZecCwOfCjCTgUjGnA
         Bs5w==
X-Gm-Message-State: AOJu0YwYIeJMExxuF8oeTR1YnRmt8nqsxrcSgkR8ZJRnPw7Jcff1e/F9
        uMHaxCEVO+ILWfsNmWtBU88Gi2jsrsXEOjyynfs=
X-Google-Smtp-Source: AGHT+IFQLVUXIThEYFlcpVZui9z0ZEhY3hev5QDVIobWDexRbxXUzXAcmLC/qIsZmEiGqYPetepnxw==
X-Received: by 2002:a05:600c:4e09:b0:401:b425:2414 with SMTP id b9-20020a05600c4e0900b00401b4252414mr1645323wmq.18.1697544315935;
        Tue, 17 Oct 2023 05:05:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 29/73] pinctrl: cy8c95x0: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:47 +0200
Message-Id: <20231017120431.68847-30-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index fae80b52a6fc..8c6006353515 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -554,7 +554,7 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 
 static int cy8c95x0_gpio_direction_input(struct gpio_chip *gc, unsigned int off)
 {
-	return pinctrl_gpio_direction_input(gc->base + off);
+	return pinctrl_gpio_direction_input_new(gc, off);
 }
 
 static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
@@ -571,7 +571,7 @@ static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
 	if (ret)
 		return ret;
 
-	return pinctrl_gpio_direction_output(gc->base + off);
+	return pinctrl_gpio_direction_output_new(gc, off);
 }
 
 static int cy8c95x0_gpio_get_value(struct gpio_chip *gc, unsigned int off)
-- 
2.39.2

