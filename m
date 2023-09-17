Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C4B7A34DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjIQJNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 05:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbjIQJMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 05:12:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02418D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 02:12:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31ffe67b5daso1093650f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694941957; x=1695546757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLx97nqlGktbTFj4ow2g38C1r2nkF/YD/yvv8rbu4tY=;
        b=LRE82rMUJdPy0ijzGNRZj1Gaoo6bq4kK+iDNvkNtR+TSi9UcdgMqwJnk+CRUiVAVuO
         EQqVGvERfyqQowlT1O+fSStDtJ6o9oqRViG5MRAp6/PscyXT1qEsD1LYPS/8NS8d5Mnd
         MO5FohwNg71lEOw9vdrNS6biBAAh3lPSfG28oQbL6WndPopkuJuvqwKi86zq5SSap9LC
         X4Ge+FerXgtF/RkBN0F5YvjFeEJqsDQXxAX5lPafyzq9Upyu3MFukLLmG0c8WRoR+xby
         bxeZ/7y8EK4Y+ExShRVQvkfn8gYQ1Vv8Q4IvGV23RUWMyXRrMB5EBhXeDsLMB7IwGhAP
         spYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694941957; x=1695546757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLx97nqlGktbTFj4ow2g38C1r2nkF/YD/yvv8rbu4tY=;
        b=XNpaDfVcjk7F7ThL8o88jahKUMW/ngahRX2psGRlRXMBf2sZdhu2naC2XdV558P3ZY
         VMjBxBhyKJvp0pNrb2BTphl8nsl/l4/MSQklBdYU6/JTke4fAaUKA9LmzLT1qCIDe34S
         1syhqL2EBgpL5hgJrdTa7RFwIUGEDL7lMkLzQYjdRUUNQr3+OguTU21ne/z4bGyCg08N
         iXIcCG88VoE50VxlfNrp2+V4oNTm4Eu+MAmSjNn87t/d15sXL7Jh7NJXaV9p/Nuji5jV
         6YvyEMj19w21W9qcoBz8d/0CBi/1CIVzWkKAwuhSPjeVz/sD+EF0eEwZBTClI6Dh1P3U
         55BA==
X-Gm-Message-State: AOJu0YwKHqsHNCnSugj5rNO3nBLod4/0lBM5GDaxdohQxS3TkVcEAI5Z
        Khwu1B0nIzFLcu9gpjkaslHT1w==
X-Google-Smtp-Source: AGHT+IEBw/0JPKwfYHT0DVsICKOv/CjSf5PNbw8y6XlhvCOWTHBEHUQcDCyjdxPLYTEfiXM1zhqxfA==
X-Received: by 2002:adf:fb52:0:b0:313:fe1b:f441 with SMTP id c18-20020adffb52000000b00313fe1bf441mr5017807wrs.29.1694941957144;
        Sun, 17 Sep 2023 02:12:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4ea0:9945:6800:8739])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b0031ad2f9269dsm9099688wrt.40.2023.09.17.02.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 02:12:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 2/2] gpio: sim: initialize a managed pointer when declaring it
Date:   Sun, 17 Sep 2023 11:12:25 +0200
Message-Id: <20230917091225.6350-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230917091225.6350-1-brgl@bgdev.pl>
References: <20230917091225.6350-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Variables managed with __free() should typically be initialized where
they are declared so that the __free() callback is paired with its
counterpart resource allocator. Fix the second instance of using
__free() in gpio-sim to follow this pattern.

Fixes: 3faf89f27aab ("gpio: sim: simplify code with cleanup helpers")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 7d52f7caa1c7..1a8a332a803b 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -1481,10 +1481,10 @@ static const struct config_item_type gpio_sim_device_config_group_type = {
 static struct config_group *
 gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 {
-	struct gpio_sim_device *dev __free(kfree) = NULL;
 	int id;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	struct gpio_sim_device *dev __free(kfree) = kzalloc(sizeof(*dev),
+							    GFP_KERNEL);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.39.2

