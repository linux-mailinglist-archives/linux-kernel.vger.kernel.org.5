Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D705A7FD947
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjK2OYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjK2OYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD012E1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:29 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4079ed65582so50471645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267868; x=1701872668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NPguL+egm1B/3hLyNOqRomxlJRtvAY3YVXSaylJwM0=;
        b=zmQJ4Ys49CuOfhXncDZdxnjlU0VLCAlLpshYRS+4NlZtnoC2PqhvVwi12XBV+5E/fs
         /YZA9Qp/Ul69d90eO5E/O+jw9TO1B/5GId7K3nfbtE2uSiKUhiWmldQRw/nSynxooLGj
         NASpy9sbNwUzTMlu4IAdolN2xvpA/1foW5hqbLEDYbjgDhUc+j5rHuSKxxOPy8UIWtUc
         s/T6T4aPXSNpWhRsr6FlAyVFqwwgJq1ZevPf00uzIL2QAXRYlcsQT2eJ3ObiG8pBmOgJ
         E3yqMES9ukpwMza18wvFtQg3O92NHp3iMOBHlGFZAcAX9ZGEo9PpVmHwcSyYZtD+xCna
         jKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267868; x=1701872668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NPguL+egm1B/3hLyNOqRomxlJRtvAY3YVXSaylJwM0=;
        b=RRM4+CGREFe4Bj9lL/Hf10Cy5/dIu0oFsrKVOXroGu4/5QIVG50TeI99JaVBrihbH2
         Mu/18tNhf9cYD6fp6TCUATHGmbtJ+41u/slguOb3BJljTwaT7goe3CeHtQXiguZpxRB5
         CbiamdCAIqhKNMRQNsZ487wvuq7hrnixvoSL0QJ0yWFtcAIh4BwJt1BJEVuWba1Meo5F
         oLQIy6JXmliRFo1zyrhIQJqHcg5tVDhtUocmq74yHPARkm5YXj89ZcBTn469ETGWw+7P
         S6nbGcEj6qWSFLkKVcWAGN+0EOvZYVMeSijWW2QpuraGTnL2TLoO0wE//SgiCTRV/EAt
         tlNA==
X-Gm-Message-State: AOJu0YzsinODbZLm/YvsyjeEQLhG8Qs7VJMGgyXxPztlQQ7teRmUk8K5
        gq7pdLz2ejbf3psn18nT4PRZp4FqjLOnivTe3WQ=
X-Google-Smtp-Source: AGHT+IEIUIxZE0FFWq33NVEE0m0n6KKNo0xXx+LcPgG8+tEi5gE5dQ6JB2ZNU3b7fWCs507DrqnJhQ==
X-Received: by 2002:a05:600c:4f15:b0:405:3ae6:2413 with SMTP id l21-20020a05600c4f1500b004053ae62413mr10800607wmq.25.1701267868115;
        Wed, 29 Nov 2023 06:24:28 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 06/10] pinctrl: nomadik: use gpiochip_dup_line_label()
Date:   Wed, 29 Nov 2023 15:24:07 +0100
Message-Id: <20231129142411.76863-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129142411.76863-1-brgl@bgdev.pl>
References: <20231129142411.76863-1-brgl@bgdev.pl>
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
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 863732287b1e..7911353ac97d 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2011-2013 Linus Walleij <linus.walleij@linaro.org>
  */
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -917,7 +918,6 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 	struct pinctrl_dev *pctldev, struct gpio_chip *chip,
 	unsigned offset, unsigned gpio)
 {
-	const char *label = gpiochip_is_requested(chip, offset);
 	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(chip);
 	int mode;
 	bool is_out;
@@ -934,6 +934,10 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 		[NMK_GPIO_ALT_C+4]	= "altC4",
 	};
 
+	char *label = gpiochip_dup_line_label(chip, offset);
+	if (IS_ERR(label))
+		return;
+
 	clk_enable(nmk_chip->clk);
 	is_out = !!(readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset));
 	pull = !(readl(nmk_chip->addr + NMK_GPIO_PDIS) & BIT(offset));
-- 
2.40.1

