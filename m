Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8017C5344
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjJKMMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjJKMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:12:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F44D1BFF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40537481094so63321825e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026199; x=1697630999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hYD07DORFpnS7uYBoHZE2h5e1OIf1dxiUrdwCdcwh8=;
        b=nFV1NNCXTRV1zYzxZI/tjJNRUIfP2G6CoqyzO+tNyfDp3lkJxE1NtvufjXEPSrgi6Z
         1CSKXj7TZgxPILIT9GQTqIwRdB8atiA/3XrGtIxMASySOGz9vxhCRnv0934TlUQMQry9
         YSyJ3oDaqoeo6BBybDdaUvQdSdJ4YAwkgIBw/Lfp2wjXHUsIuksxMvGJZXjDOX8T0HWA
         1+DU+9QZ0p9JD9lW0S8oMqmAN6JNwVyVIkjyezroPzjfU0q4k4QcRenIeiNno3O4Ujns
         iECRqSORBwYx5lOrNuX6J4zghcHRd/xYZuPXUTExVMa6kXaYTfarSJqSkRjuZK9u0nyM
         qpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026199; x=1697630999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hYD07DORFpnS7uYBoHZE2h5e1OIf1dxiUrdwCdcwh8=;
        b=pBm0LVpcRxWbNS+p755buzZDeSR2zbRq73Qim5wAgPmiQirP1TVYCNK75vPSpSx0y1
         xEMUJO248ceRCOYQxmxZKLpTEIB/FWwUj+PyZXwlQVwfO0qywUfOZ2zz8IxOp7rCBJwt
         iNYWrbeegbZ33cnTqnQlhFs3VCn2Lx87WcZg9dlxfxgRf3u+XQpMpud9KAQWeLvc+ORD
         mzKulprvBZlVjSqNhpKVecUlKRW0Bd8lX9oy7XfjLSkS2VvVIBQZiCoSCouMilIcii0j
         a2RQPf8n/iWIWl98vnMW56mpJaoCuEDxBI9Sx3BdmgvXJBh7AX5KDXChZAF1YlH6oZlG
         0Yug==
X-Gm-Message-State: AOJu0Ywmzrle+GMXaJIr2SSvAb8ZNCn9i/ql0E3NxQAIFmpZoz5Vqwmt
        l4C6aSUWebM5jTe/qLh6lc1yYA==
X-Google-Smtp-Source: AGHT+IFJJqC8+fuQJ2pNf275wGTpeHg9YSMcla/JCmhWhH9yvD7At417hN56M5hiOFvFmI5HaDsByg==
X-Received: by 2002:a05:600c:210b:b0:406:548e:bd51 with SMTP id u11-20020a05600c210b00b00406548ebd51mr17375258wml.26.1697026199541;
        Wed, 11 Oct 2023 05:09:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:59 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 57/62] pinctrl: ocelot: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Wed, 11 Oct 2023 14:08:25 +0200
Message-Id: <20231011120830.49324-58-brgl@bgdev.pl>
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
 drivers/pinctrl/pinctrl-ocelot.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 96b4e9fceb78..52aadd6d72a8 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1776,12 +1776,6 @@ static int ocelot_gpio_get_direction(struct gpio_chip *chip,
 	return GPIO_LINE_DIRECTION_IN;
 }
 
-static int ocelot_gpio_direction_input(struct gpio_chip *chip,
-				       unsigned int offset)
-{
-	return pinctrl_gpio_direction_input(chip, offset);
-}
-
 static int ocelot_gpio_direction_output(struct gpio_chip *chip,
 					unsigned int offset, int value)
 {
@@ -1804,7 +1798,7 @@ static const struct gpio_chip ocelot_gpiolib_chip = {
 	.set = ocelot_gpio_set,
 	.get = ocelot_gpio_get,
 	.get_direction = ocelot_gpio_get_direction,
-	.direction_input = ocelot_gpio_direction_input,
+	.direction_input = pinctrl_gpio_direction_input,
 	.direction_output = ocelot_gpio_direction_output,
 	.owner = THIS_MODULE,
 };
-- 
2.39.2

