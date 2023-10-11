Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED387C5358
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjJKMOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346809AbjJKMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:13:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F621BC5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4060b623e64so5628895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026191; x=1697630991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e36s7GGdluC5QXynxByie2ZOB2vhF56/mrPwGpCKJMc=;
        b=DywQE1gyVx47sFwd2d/Iuml2zEp0tVCWZz5ZkG3lcZNwjQC3FJBCNrfiEsQ3TbWDjH
         742aYDguhBdOEPorCmCNgyC7HdZkER92HCMP+WjaV0ZJFqxwtUSL14F1ljrFF2uUmFzf
         4fL3tn1hP2zP3R3aMbgBXgMalHbzhDi057oNGf8kUW8ymGuKwfjjSNxfOF9Atz2LWMUn
         4uz52YRxNNMt67XBL5lzXUlLN0p8G3cPpAgJ798lK2rnVhE3+BYmlTAU7lSSNFd7H+ha
         06hnNsT/nQTlZO0V+YGuMNyASN3LrW35Bw7Y4t4LUSYGswiNNztBueLNWrXOy1T1lNzT
         wllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026191; x=1697630991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e36s7GGdluC5QXynxByie2ZOB2vhF56/mrPwGpCKJMc=;
        b=MC7qGmqdh3bdrcduHk/lVn9fpd3dmCbSciFbWLlgbtnFrEWOTj6g60ofZtTqLdXdHj
         JDWKVWQu+DyOXbpTumtHi49v0Cr7tNAyh9qdLKgKqsAQmepnkXIa8ZKaADgaXeyQ3XLk
         Ajcp6SGUi/6WJ/lO4Dmw+pKCh296P8gFgBF5VVIQ+nhtul3LR8yc/oschiM8dMszEmhm
         JlBJ/atEAsY9ON89jsEmETYCdJNGx6+FGRAv8WUkQVNfHzeApYWmkG9Bakd/t9BNK4ou
         dpxQG8goQbzuysv9sQ5FSGO5rKUBuTYVG7B9czDJXay2yOQjaJzMwBF+T2a13odd01Kh
         uJIA==
X-Gm-Message-State: AOJu0Yy1UT87hQ2pepwMn0yKGc4UZ4tRta5ZmI1ONDwpOVXIIKNWR6VB
        WRFRmq1ZyT62SGrAoDQmQLc7Ww==
X-Google-Smtp-Source: AGHT+IFSAwuCWBTL7lezmJLtCyMvDb/zGXh4Rj3UdDilTVGeSvBu9wBWn9fhQSJSYAyBp8blm3Zxhw==
X-Received: by 2002:a05:600c:4f02:b0:401:609f:7f9a with SMTP id l2-20020a05600c4f0200b00401609f7f9amr15768612wmq.8.1697026191637;
        Wed, 11 Oct 2023 05:09:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 48/62] pinctrl: st: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Wed, 11 Oct 2023 14:08:16 +0200
Message-Id: <20231011120830.49324-49-brgl@bgdev.pl>
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

pinctrl_gpio_direction_input() now has the same signature as the
wrapper around it so we can drop it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-st.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index db511dbd50e5..a30b426d1e74 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -717,13 +717,6 @@ static void st_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	__st_gpio_set(bank, offset, value);
 }
 
-static int st_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	pinctrl_gpio_direction_input(chip, offset);
-
-	return 0;
-}
-
 static int st_gpio_direction_output(struct gpio_chip *chip,
 	unsigned offset, int value)
 {
@@ -1488,7 +1481,7 @@ static const struct gpio_chip st_gpio_template = {
 	.free			= gpiochip_generic_free,
 	.get			= st_gpio_get,
 	.set			= st_gpio_set,
-	.direction_input	= st_gpio_direction_input,
+	.direction_input	= pinctrl_gpio_direction_input,
 	.direction_output	= st_gpio_direction_output,
 	.get_direction		= st_gpio_get_direction,
 	.ngpio			= ST_GPIO_PINS_PER_BANK,
-- 
2.39.2

