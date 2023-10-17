Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87287CC26A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjJQMHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbjJQMG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:06:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB67170F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-406609df1a6so53621185e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544315; x=1698149115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdciYkeI9ojIVFf6NUkn/u7//A2Bey8sZm2LXyWrQBM=;
        b=OcLcF0XKyCGVyiccFqPnH9QSZRvSuYSlI+2LQhQZLu3QUZ3JnAIF/ZvgoJw3ZmWSzV
         GBsciGiqASk0rZgv8yQg1pKQCeMERZgc3gjtIhBoxi39ihGnm57ZXUVKmeWyq2Eu0d07
         6EMEVCLUk/6br29JIaUOOWmAs3r6alkXy2+XjTyF8Hw5xpOBZ5SMHoNFBHDWrZYfDu41
         dvA+bU35NAb57cwphgKduCmmUq9Lr55ce2yGzcpmfJ2CzY5Z88xaIgYTCuBHMbE3k+ML
         o9KKeexf/KzxsfJHF9e0XAbP9yC7P+t7uI6dMLuCkMtXi7mjJ6gh1VT+u0CNnabPcZQX
         QIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544315; x=1698149115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdciYkeI9ojIVFf6NUkn/u7//A2Bey8sZm2LXyWrQBM=;
        b=R3N8MN65xHjubSLisZ7WvXnlogb6aSysBt137dBu1sjKvlcojZ5qXOL3zudr48wIdO
         dsNXfEQmjmr4USOqbl5R5HgQrvtRR1czWJwrJsZ31xao/iMUl/gH0HBdo5e/J3WE2gEF
         w4tj3ano/PJV1Pzg/yLXuRbIuCdAlWvGtlrPehyet7QzN/hlm59f8j1qoARYzCDHQxZg
         13BNvIBmlECrtiRq2DS3tcs9sUc/u5amJodXoQ3IIvm95Tn0R8LzmurhOjWJJ7UluG2n
         3dogGcnF0LSthqcQHfje9CYDrND30FdDF3+XY/OtuIl/oAnL0PRUrb08pSpblEEQKkCJ
         +8AQ==
X-Gm-Message-State: AOJu0Yx5GisStGYIcVfrZHn9rA4z4/PgwY4POGaN7KDhy/pCEJf5Cyr+
        eC9crllATgaUz7QkC2eQe0nhVptIZ8vmIkBOGXU=
X-Google-Smtp-Source: AGHT+IFSVq5JoWAceD6FGW/0GO/cXkV8dwhzAtwN4BQDG2RryN6S73PsaBbeb7ILo9VDKOgp136/lg==
X-Received: by 2002:a05:600c:4f95:b0:402:f536:2d3e with SMTP id n21-20020a05600c4f9500b00402f5362d3emr1801117wmq.14.1697544315055;
        Tue, 17 Oct 2023 05:05:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 28/73] pinctrl: vt8500: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:46 +0200
Message-Id: <20231017120431.68847-29-brgl@bgdev.pl>
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
---
 drivers/pinctrl/vt8500/pinctrl-wmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 6fac30de1c6a..1a313295611e 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -528,14 +528,14 @@ static void wmt_gpio_set_value(struct gpio_chip *chip, unsigned offset,
 
 static int wmt_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input_new(chip, offset);
 }
 
 static int wmt_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 				     int value)
 {
 	wmt_gpio_set_value(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output_new(chip, offset);
 }
 
 static const struct gpio_chip wmt_gpio_chip = {
-- 
2.39.2

