Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9078FC56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349192AbjIALf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349188AbjIALf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:35:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA910D3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:35:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31ad9155414so1495030f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693568123; x=1694172923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t18hQG54uxNXt/UqPwS8SvH0lWIXtL7YjsP7g7CB7ZY=;
        b=LVYb2naVW5ChtuMMvV168AbEQQVfvTOCeEuZdaBs5oF6kyfM31eFXYDSuBbGxJ6jbq
         ypoqsYehK6ogcBTLiSo3+nyQ04i4LQUqqIaP91Vin4qmXVBYzpp9qgoEmtHo12oZzKhH
         BVU2PlXK7s2LsTtSt2Zph5vzfQkm/22TA0TbksYm1oXdw3ZOflghBiHwSe+bqP3FIplw
         tVJHAh/j+E6oSurQE0wXt3t6EgmFwAUJCs6rgAwtzr/BRG3iOSPJr6vPMVzYl1Guk1nu
         sww9quiAEwVACUfMRmxRkPz5b/4QaDaMZpkaGpkPgfF4KN4hI3QZXni98Beu12tJAvc/
         kTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568123; x=1694172923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t18hQG54uxNXt/UqPwS8SvH0lWIXtL7YjsP7g7CB7ZY=;
        b=M/8SEPEa/2MBmbOnUcRezwomlXqVqwp7fsQL7gn4zp++i4aGhYH2L4MBm2OPGzAa1F
         kLLRGUJVeLJFClR331ugKvo7tLdCejD9KCrJfE8xs4UDO09suYEmjwXWrLIhyt072CYP
         CSDX6vHVVeonl7ncOXeCF8NwLsp6zldRgQSXn5fbXFc6UvLCCzmtBgSOLAAoQcxonDX5
         VjgVhSxBHANFcV2TdL35upLKwd7iCMBRNBP/Ap+2zkRbpfY1wMDeywjGfW9Onf86HJcP
         ht8bgq6V9AubYF5pHg5ZeMsWuoeLSrQwTaflrNsMs/xt09GiSEXiv3ZKkUmlrliPhvqh
         O9wg==
X-Gm-Message-State: AOJu0YxLjgZdyevwMyZ+23psAGglUKj+qTYFLWm/WRutc8q/3/opAgBi
        c4lEYvoJQ2+HoZz6wZR1zJvqiw==
X-Google-Smtp-Source: AGHT+IGnLv8hI55wMvsH7Av2hSWd6AFLA/Vz8mb0KZSnXfPP2Uj4hMrjrSe5g+8Efc3jep+DUz5Zkg==
X-Received: by 2002:a5d:4408:0:b0:31a:d4a9:bdac with SMTP id z8-20020a5d4408000000b0031ad4a9bdacmr1815657wrq.11.1693568123087;
        Fri, 01 Sep 2023 04:35:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e94b:1054:6760:aa27])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe9d0000000b00317e77106dbsm4955439wrn.48.2023.09.01.04.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:35:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: remove stray newline in gpio/driver.h
Date:   Fri,  1 Sep 2023 13:35:20 +0200
Message-Id: <20230901113520.13352-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Fix a double newline in the GPIO provider header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index c312bf3e0369..8f0859ba7065 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -765,7 +765,6 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset);
 
-
 struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
 
 #else /* CONFIG_GPIOLIB */
-- 
2.39.2

