Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B2D802EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbjLDJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjLDJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B1BE6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c08af319cso13311695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682517; x=1702287317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7P6Y0m2hGBRRFmWFTt/dmCRHf+pQxLzAw7kKW52hRs=;
        b=JRRbyB69kiCLpu/4ZG4DzhiF/GZvns/kelMSC/ykVyX1XYkXMpRtb7VCDhqMZAKy+0
         KJONePiulejgrDDvoe93uT4kd65FXJ0y70pjYxy353zUCKS/DuupHHtehJEqXnu2P7g7
         p7Nz5i6aucvfuzR73L3HOgYHOfnVqiSPvWYm05h9hLOFMKAcM5cgB554Mv2AgeFsEM2W
         L+lHxtGoMTkH33cSqvVc/E7Yc/+WcImUEX/MyugubJ0u1SbkoO8cLbhLynpCK+mSQKqz
         Rz2QpBAoJ7o77LSAtFPDRKkvcudACDr/CP3OJ29I/7JXatavob0yJLuhkRix8i6GxX1E
         P2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682517; x=1702287317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7P6Y0m2hGBRRFmWFTt/dmCRHf+pQxLzAw7kKW52hRs=;
        b=L+f7m82c5HA3PWcZ0bzrwUt0LbHLHxLpRC2kzFpcRZzFWDdkaL01BsStQF0VQiWR6e
         vJDv4SmownF2F97BPnDg9lMv1A8oe4OWBW++0YqlwfBb6pUWmuBxMQdT+B4bHglNzkbd
         21xCOwCveVm0rBlLOdpaBU26pvD4ksMlTMhzwhI3iHWYoMj62F7KGVondx+5DY4CNlm8
         2DmyTwnKXCK6743juLB5WWHbJiS5CzHKoygXnNLLVhdB14TDbgeEBtGlh7e9M6udOrjn
         9oCvu3lpuswWGeJ/QF7hQsyIDgoPcUQC168jVEcUwrzt5q9d2bT4A5h/gtrBjhnt8TR8
         M0Qw==
X-Gm-Message-State: AOJu0Yyvy6/McAHvcLEfqqLoo/2sT+KVJzkSW0Qn/nJiGdo6+pQ9Y7E6
        h6ut1+feITw5PvarAaSVxVqWvA==
X-Google-Smtp-Source: AGHT+IGdNMxWu9CAp1B8+hOKkvU9FEsYEEb9kAiU357IxEvD2zDpahJNZN4dV+3wpjhH/7lMeBVJ7A==
X-Received: by 2002:a05:600c:524f:b0:40b:5e21:ec2a with SMTP id fc15-20020a05600c524f00b0040b5e21ec2amr2044570wmb.92.1701682517494;
        Mon, 04 Dec 2023 01:35:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 04/10] gpio: stmpe: use gpiochip_dup_line_label()
Date:   Mon,  4 Dec 2023 10:35:03 +0100
Message-Id: <20231204093509.19225-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204093509.19225-1-brgl@bgdev.pl>
References: <20231204093509.19225-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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

