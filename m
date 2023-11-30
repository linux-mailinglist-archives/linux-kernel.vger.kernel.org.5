Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615C17FF09C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345773AbjK3Nqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345798AbjK3Nqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC1010F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so7713355e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701352000; x=1701956800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7P6Y0m2hGBRRFmWFTt/dmCRHf+pQxLzAw7kKW52hRs=;
        b=VIRvQo3RT4aiG5EG4mKWHcQyV7GPvY5DBdbAPcDXbhbaKucRHdzGN4jts4uum9Yp+h
         MXxwwlcBEY3tAjPfQqiPovgDFo0WhertxXzvHgTixfkA0XUejUFeScHRjNg/EJChvwTM
         C2L/0X88tdGU7Bz7WOl/KsiMq0mPmLWbjBsSOo63tmZleFRRZuHITTFIOHtPv6NUfEOr
         xV/VbgrHCmiPRQqcPOyIcV9hAANERBqVAVPSzCN8CrMcD2YKh2c8GeNfTGzqwPTXG/Ea
         fxBMjec+osOQDklpJDk29qj42/3FkypLIViummhPNnLTqjmr2S0QSN3+hEK/Nzz0Srcy
         dCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352000; x=1701956800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7P6Y0m2hGBRRFmWFTt/dmCRHf+pQxLzAw7kKW52hRs=;
        b=Ylhn6DqHZOtREWuZXabPe7bAPyyXI4hIMySwVQhxVeJINsveoNQjt66dN3Mr5NNUn1
         L+PSRlfy1TTMYrjyYkO3EZbffGzTHKQzp2Yw4w3sh6x0wU47yqeQ61TJsiunshD7yr2j
         HDUUpb59scLCGTms5njs0osXAnSpvxqfny7LUOX4FZ/uobQM0fTGL7zUhvAl2nChy46b
         y/zAGKCq23LtlG+vUhgQyq1JLm8GuJlh8OFqbZ5GkgpnhNmYLxgEMyOjBAdoLr6O3eD6
         B+zHn8fzeoTzKEiliheLwdM2vkEXtERwLeGXu+0D7csPZgSz+MwGHUUB0IxWXAnenU/G
         TsUg==
X-Gm-Message-State: AOJu0Ywi5h4iS9SzEjH/ezIxZMPuNxBj8rlrpnslFexSOyJ1kGqoclqd
        l0YqmGf5feGpX6MBVUMLIz552w==
X-Google-Smtp-Source: AGHT+IGWQ3w4OgWs+eiKlT4hgKInIw5/57JyahFF8EAqF3mDoy9KOsBP9slLYl+6MDnBdXrI1X7t4g==
X-Received: by 2002:a05:600c:46ce:b0:405:37bb:d942 with SMTP id q14-20020a05600c46ce00b0040537bbd942mr16123768wmo.4.1701352000315;
        Thu, 30 Nov 2023 05:46:40 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 04/10] gpio: stmpe: use gpiochip_dup_line_label()
Date:   Thu, 30 Nov 2023 14:46:24 +0100
Message-Id: <20231130134630.18198-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130134630.18198-1-brgl@bgdev.pl>
References: <20231130134630.18198-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the new gpiochip_dup_line_label() helper to safely retrieve the
descriptor label.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-stmpe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 27cc4da53565..6c5ee81d71b3 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -5,6 +5,7 @@
  * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
  */
 
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -255,7 +256,6 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 {
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(gc);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
-	const char *label = gpiochip_is_requested(gc, offset);
 	bool val = !!stmpe_gpio_get(gc, offset);
 	u8 bank = offset / 8;
 	u8 dir_reg = stmpe->regs[STMPE_IDX_GPDR_LSB + bank];
@@ -263,6 +263,10 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 	int ret;
 	u8 dir;
 
+	char *label __free(kfree) = gpiochip_dup_line_label(gc, offset);
+	if (IS_ERR(label))
+		return;
+
 	ret = stmpe_reg_read(stmpe, dir_reg);
 	if (ret < 0)
 		return;
-- 
2.40.1

