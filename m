Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB23D7FF0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbjK3NrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345683AbjK3Nqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:40 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46C1709
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-333229dcebdso431198f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701352005; x=1701956805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ4oN2yBzcOb1+JXtPZKrl0tpOl2eK1zlq9JfJmTld4=;
        b=O52R2/k6OkskTQsBSvj/PTMwCFu3+2ETaBaUKYlr+AhO7mU950wIaLOvdbkqLYXtwC
         FNvvbW3vJwBDY3GGVBdFrWqhhyEMcch0+u6A0q15Y75qGntWN18Get/3ZWiFhENlIhN3
         H6ysmJdqT/OpBJ5JJjZblDE+8kvFtNZ3qMR9shrQaLnzaHJikcNbrlONwhY/QZikoMLR
         oS4NFXrfd1MrbaOdTfeqUcbccWPDpjJfX4vDpwz6l2bvYS5/Pb6VkTfM4GUYZ4g2TH/B
         wd75FZh9asf6VPD+U+0j/OPy3pBgKPkkV5zFUqcThO16qjsTshRWrDgTuvbmfP8MDeB2
         MNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352005; x=1701956805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ4oN2yBzcOb1+JXtPZKrl0tpOl2eK1zlq9JfJmTld4=;
        b=L+nU+A3c5syINU2m1XWt54wktwVdiNbJBUvXKz4DF2coLYlymp7ppgsTN2hCShWHPl
         y6bSMy5DOcCE0yk/g2qrz8QfiX9hZp27NyLywjk3MmQct0dOy9B3sKlfI6cp6b8Qs2PM
         J8pagZcp081TLel+z7jiRR7Ju3Yn4DbkLwpc/+XT3DaMvcS2Brnz29IUl1ApGw0ouW+x
         FgZuJQwMGbd9BDB1X4QkgsOY1irindg6Ig/ldHFdR2yLHcyqNXQ3thGVzWd50fIc0Wx2
         zwcRmCoL5a9A9lF0kYUiXo5MT35sfgYZKkxn9dNh9jY8ej5UXZ9rQPQS3FkgacCkIHdV
         qk8A==
X-Gm-Message-State: AOJu0YwKuownJM1DBlT7xluazitQNjCWCcNKTfvbuYlGyXzynhTaBoJe
        ykK0lJ8Tr2X6zyOhD5qffjY/Vw==
X-Google-Smtp-Source: AGHT+IGPtG+1uFAas3OVjot2zm3XVUDLgeyXhw2GAlVFtUSUYqhhRLnAvXvRp9OLXomSy5i1jZKXyA==
X-Received: by 2002:a05:6000:114d:b0:333:2736:1e55 with SMTP id d13-20020a056000114d00b0033327361e55mr640974wrx.38.1701352005511;
        Thu, 30 Nov 2023 05:46:45 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:44 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 08/10] pinctrl: sppctl: use gpiochip_dup_line_label()
Date:   Thu, 30 Nov 2023 14:46:28 +0100
Message-Id: <20231130134630.18198-9-brgl@bgdev.pl>
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
 drivers/pinctrl/sunplus/sppctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index bb5ef391dbe4..ae156f779a16 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -4,6 +4,7 @@
  * Copyright (C) Sunplus Tech / Tibbo Tech.
  */
 
+#include <linux/cleanup.h>
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -500,16 +501,15 @@ static int sppctl_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 
 static void sppctl_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
-	const char *label;
 	int i;
 
 	for (i = 0; i < chip->ngpio; i++) {
-		label = gpiochip_is_requested(chip, i);
-		if (!label)
-			label = "";
+		char *label __free(kfree) = gpiochip_dup_line_label(chip, i);
+		if (IS_ERR(label))
+			continue;
 
 		seq_printf(s, " gpio-%03d (%-16.16s | %-16.16s)", i + chip->base,
-			   chip->names[i], label);
+			   chip->names[i], label ?: "");
 		seq_printf(s, " %c", sppctl_gpio_get_direction(chip, i) ? 'I' : 'O');
 		seq_printf(s, ":%d", sppctl_gpio_get(chip, i));
 		seq_printf(s, " %s", sppctl_first_get(chip, i) ? "gpi" : "mux");
-- 
2.40.1

