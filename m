Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8A27C5305
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbjJKMJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346435AbjJKMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB4C4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406650da82bso62485455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026152; x=1697630952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vai4SzqfuocTRSn5ctHCW9VKMc1EsxJBBmmicKiWbek=;
        b=TpHzBOHTymNcvYqnbCWsDabg+07Xf6uwN5F3O3XB7B632nBO3kCBwO0YsxCz4aEH7M
         HoVsx1UcQMEMhWkK7egemT8MADylGDTgDZax0TNd9hSCkN+Jkakeiym66NSnhGsQqLTN
         ZePibBVwzhSk0VqgWAxqqVI+SHbyTUHH9lkV9ttziUHGT822PA0eyIWTyvOjoySgFwU9
         2DZrHWGJg9KV3KPw0rcj1Pjz3bsLQ6TOoD/sSze8KoHi8FP3xy0q6tacbVUevPFdPvUw
         GZQJN0AJoZcG9fwSvn6ptzDDt0Og5LRL46Djl9ffz1r6HqSEmBsNnSk7DQnnY2VvPQBt
         hNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026152; x=1697630952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vai4SzqfuocTRSn5ctHCW9VKMc1EsxJBBmmicKiWbek=;
        b=SKlVK12V7mZnU5wrW8/mjUqvhn++qVlujc0ea/2qURzmun1ff1rPWbutX7i/8YdKom
         ya86Pn4bnoRzWXiWtQLwNtuttyDWwPrWPKSS7EBhBHsvLC5F0Qcwzm9eAEcvtDdUyyPq
         GKeRvbjAXvdS1vbFK/utXrmso3RM1n0Zd/Vch0cqNp9wxHLI3xhnw7VdpBfyUwulCZMU
         WPm0MN/6cv8n9Aa3M0x5Nhr4tC6PK7WM0z393tsL5ZMicS8qGRZ3ijko34tx3Xm8Z9ej
         icuw6gZxvSYKVe+a6wv+ESuHYiQciifaYAuPbIlVHERxNlHqzLrvQRZPng1egP3VY5mt
         ZqkQ==
X-Gm-Message-State: AOJu0YxuI++Bk0/52UnW73MXO9+6acUNHHUnFErALUq00XOyx3tkOgPM
        jcUfrf/5YWv6N/G236sonFUAJQ==
X-Google-Smtp-Source: AGHT+IG4secTPx2RYuqCpSfRRv6WpUeZcDQ8N8dt7eCfNidfkxiCHWBBwl0E2KRzdhm2tsIk7gaerQ==
X-Received: by 2002:a1c:ed02:0:b0:401:38dc:891c with SMTP id l2-20020a1ced02000000b0040138dc891cmr17830274wmh.5.1697026151804;
        Wed, 11 Oct 2023 05:09:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 05/62] gpio: rcar: use new pinctrl GPIO helpers
Date:   Wed, 11 Oct 2023 14:07:33 +0200
Message-Id: <20231011120830.49324-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpio-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index d8b1baae6357..47121e1a6d4e 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -275,7 +275,7 @@ static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
 		return error;
 	}
 
-	error = pinctrl_gpio_request(chip->base + offset);
+	error = pinctrl_gpio_request_new(chip, offset);
 	if (error)
 		pm_runtime_put(p->dev);
 
@@ -286,7 +286,7 @@ static void gpio_rcar_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 
-	pinctrl_gpio_free(chip->base + offset);
+	pinctrl_gpio_free_new(chip, offset);
 
 	/*
 	 * Set the GPIO as an input to ensure that the next GPIO request won't
-- 
2.39.2

