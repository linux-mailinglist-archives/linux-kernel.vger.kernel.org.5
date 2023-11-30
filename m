Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC877FF09A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbjK3Nq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbjK3Nqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:37 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA4A10F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3331974c2d2so684020f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701352002; x=1701956802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cffjJvUFWsxdgp9qJiLVkij+XoF+TZsz38c1WQZlyho=;
        b=gdSOQtaof93nM5ia61UhuHXlJsyRqcru/G05JG7W8V1FssY7r+DAfHzJne1PEcTXsF
         YM5G9ExjsMk8Rr5qeYZ13DnVH3LBZCQMj91lpzi1sq1n066WUmZfO8ebjceDWiYMUv63
         lR+I6OhQSHuJ7HdTb24IX7LNdfcigyIVh0OtdsIfxfxVerKJuoblT1VITrUSZAyDf3n8
         S9l6zab1Q+hY+sewGCicanmYoVopw2XSSY026wmft/15dYC9N6tFojxW75jjA6olC7I8
         tkKVCiKU5496/SECyJMIPJAZc/ae9xT5PaCCWzEqo4elcsHb04oLQPIm7dmojCrOQrKQ
         Y0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352002; x=1701956802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cffjJvUFWsxdgp9qJiLVkij+XoF+TZsz38c1WQZlyho=;
        b=YIfhfUEUJ8NIoHM5RyIAoQS7O5093KTytYoDiwe0qPku0K+KAKSQfbEf6iuMWAiSOg
         GywWYoyaIKtbNDhiZp6oGZBY1ACOUSTyFR5uOdHdIyqkSiiHXMM2/a2KZ4+kYcdCo5Ch
         41FrGd/ZFCLlDgqyOHINhrNuHgOyXP1l8V2/2/Zm9RyFm2+32zlV5q1ZD9Nj4FfPDtGX
         g8mqBp/WDkhn8DIwhGNFIMzD9fS57F+X3gC9wEGwPQBMJWgVFSAIC72xEW3HMG27Xpf0
         TaVPOiDQAIs+ND2WI/gf7qcx10NeOaZ3rh5hsqluE9/rwpqYQC67nmcdFwPlxJEHpGW9
         SJtA==
X-Gm-Message-State: AOJu0YyXJlqyYKKegpt7oNEZ6T8p74m92Jw2VygibLjrVJMkdjy+cY6G
        n2XLZdJ5VXKCTzAIJD+ZHOG6XA==
X-Google-Smtp-Source: AGHT+IFqmZA1KQhwkSPcUaNoBMtUmaEHugbvUiR1Onas5XzwXX7zZR0pNya8Ie3NAxw5LM70WUUmrA==
X-Received: by 2002:a05:6000:36c:b0:333:18b9:27a6 with SMTP id f12-20020a056000036c00b0033318b927a6mr3490982wrf.30.1701352002295;
        Thu, 30 Nov 2023 05:46:42 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 05/10] pinctrl: abx500: use gpiochip_dup_line_label()
Date:   Thu, 30 Nov 2023 14:46:25 +0100
Message-Id: <20231130134630.18198-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130134630.18198-1-brgl@bgdev.pl>
References: <20231130134630.18198-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index d3c32d809bac..80e3ac333136 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -6,7 +6,9 @@
  *
  * Driver allows to use AxB5xx unused pins to be used as GPIO
  */
+
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
@@ -453,12 +455,11 @@ static void abx500_gpio_dbg_show_one(struct seq_file *s,
 				     unsigned offset, unsigned gpio)
 {
 	struct abx500_pinctrl *pct = pinctrl_dev_get_drvdata(pctldev);
-	const char *label = gpiochip_is_requested(chip, offset - 1);
 	u8 gpio_offset = offset - 1;
 	int mode = -1;
 	bool is_out;
 	bool pd;
-	int ret;
+	int ret = -ENOMEM;
 
 	const char *modes[] = {
 		[ABX500_DEFAULT]	= "default",
@@ -474,6 +475,10 @@ static void abx500_gpio_dbg_show_one(struct seq_file *s,
 		[ABX500_GPIO_PULL_UP]		= "pull up",
 	};
 
+	char *label __free(kfree) = gpiochip_dup_line_label(chip, offset - 1);
+	if (IS_ERR(label))
+		goto out;
+
 	ret = abx500_gpio_get_bit(chip, AB8500_GPIO_DIR1_REG,
 			gpio_offset, &is_out);
 	if (ret < 0)
-- 
2.40.1

