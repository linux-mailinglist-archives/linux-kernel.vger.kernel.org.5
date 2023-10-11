Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE2F7C535C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346913AbjJKMOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346953AbjJKMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:13:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B67119
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50336768615so8873636e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026194; x=1697630994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZqsH4ukWg8dp7mZFhLrP2ADJHJW7V1bq0dpTxn7+d4=;
        b=jDN+8VhqyHXhzlnpklZZO6feBFgL6OpJluLHRWfrD8Q7Oxzm2sXfIrcVrJZXfbij7E
         0qIsYx9/K8QV2jYXYv2XnQMXf5UaLGyTufL5SSucLL4oybZci5MPkFO49q9I10gU0SDW
         If8E0pvuNIAwQyTqXPTXoLXnzLWg2rmT+JHhhWLa16pxvRRfFCtJs9V6G2bIpQ6isBMa
         2xb9wC3N338vpbtbXPDnPCu3Fc7EK7OSiJ9QEp/TTT6CSazZ4DV0Oifn6MxmfhrNr6lo
         tbX0zLqTzfDfKXR/U2Rh+lBWPpFyqTFuYCHrYsFW+kUNnx9whG1bEi+cN0FXgst5PjdL
         yW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026194; x=1697630994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZqsH4ukWg8dp7mZFhLrP2ADJHJW7V1bq0dpTxn7+d4=;
        b=w+QnBzw6GQa2IJYNUb0do/OSJxVd/2Qvw9EKc9ToIdjH0mhH6OG5yhDTcDSZh/Srzf
         D5V62PJU1iqi4B9zGSNhJLkymiCAkD2Ejt8at1I4Id422QIbj1vWWuVuxhxYQNkJ+jGW
         yevEeCD4rQpYkRvV1ZBW2dGwMWPrWK3Wk9iMXzn9dydos0bpZKQ4ADpubvEBCH8czV9y
         UbPZCOgtiy5838af9jRc9q8xcsnoMKYKHbF4TL4j+wbvTA7nUc+pqyNOObEd+TlWlyAG
         h3oJSnlHhwDZzaMsZKY9MmbPbTSPMaNYOK0dPdFqoO7vJtK6CrWHS+KpS+kfUMKirXiC
         iIiw==
X-Gm-Message-State: AOJu0Ywt0LRd5IEticYtjWyAJZtnvNhSZH3Cifrzyk1+QZ9Ox5wJ6eXK
        7V3j6xGv+Ylk6J6sQbfTjlYVfg==
X-Google-Smtp-Source: AGHT+IG3KFLgStVlObc2CV0eMCmybYAlZC4l462r1+w4xC55d7bDJvQdEq22/PMM+bC/ZCGW6q0JQg==
X-Received: by 2002:a05:6512:308e:b0:503:2642:435e with SMTP id z14-20020a056512308e00b005032642435emr19858949lfd.66.1697026194235;
        Wed, 11 Oct 2023 05:09:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 51/62] pinctrl: cy8c95x0: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Wed, 11 Oct 2023 14:08:19 +0200
Message-Id: <20231011120830.49324-52-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
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

pinctrl_gpio_direction_input() now has the same signature as the
wrapper around it so we can drop them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 04285c930e94..adecb7d85da1 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -552,11 +552,6 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 	return ret;
 }
 
-static int cy8c95x0_gpio_direction_input(struct gpio_chip *gc, unsigned int off)
-{
-	return pinctrl_gpio_direction_input(gc, off);
-}
-
 static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
 					  unsigned int off, int val)
 {
@@ -814,7 +809,7 @@ static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip)
 
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
-	gc->direction_input  = cy8c95x0_gpio_direction_input;
+	gc->direction_input = pinctrl_gpio_direction_input;
 	gc->direction_output = cy8c95x0_gpio_direction_output;
 	gc->get = cy8c95x0_gpio_get_value;
 	gc->set = cy8c95x0_gpio_set_value;
-- 
2.39.2

