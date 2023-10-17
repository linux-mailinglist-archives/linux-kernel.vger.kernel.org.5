Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC37CC2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjJQMVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjJQMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:21:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243B272A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so70235391fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544351; x=1698149151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hYD07DORFpnS7uYBoHZE2h5e1OIf1dxiUrdwCdcwh8=;
        b=YIu5VoLUyDZdc4GzzY4yeQngmFMEqNxsOge6vYW5iH6Z1pTmdpXiQBZF2X7ZsyWg8U
         WK1l3RrgIux+ccszK1RyYVF64sdX8L0BwbjX9LxCSBqZqt+1n0uv5AEK1oz1kDRsMHRI
         KPbMILCveEPNjjSZWQ3VC7GZzgjP1zbiBnRJfeHOZmeAOrNnkWFKcl+GImw0dahe8qeC
         ZNCLDrzKoXGUUJiw/jZrx8qzqIRan86FjkUbQZdIhc+02ku+R4TtUljU6WYTnm7sOkO8
         VivntbruAkQMGVJ0/x68mf3/LRJxO/1ebgcTNeSSejzjJOqHh4g/ZICj4MvProGVn4hs
         X2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544351; x=1698149151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hYD07DORFpnS7uYBoHZE2h5e1OIf1dxiUrdwCdcwh8=;
        b=YKMqfwEhzimoyWqJtQ3HTk9pB2aAlp2gUO1ts8B1d8YQfI/GuEYKNx8Mw+KHsRHF/0
         8OSfAQOFv+zaw3RuEKFCmgQ2pty4RIo7qhfwn3lxbLD5UCzLPqiU10T1ZR+ZYhZqL4KB
         /9Z0BhUTDLaUGi/lPEF0MPcOeY5DgoV1TbCScRnApE0OBVXaZnFGPmgMhnMKVaKjR/7/
         Mf5q4ik3q7IGGhUwuDXAO6cQCkkhwt1s3n4IIu0k0jGvj/hDOeUTtgQdQa/ykCXONFvF
         ymkmNsF5ZBLWTT4V9qtkN37mnY9PaISJUgGslhOaEv0E91liyTBJnXsodmIHE4Oqagt5
         ADKA==
X-Gm-Message-State: AOJu0YxttN6+xe/3ROIHA+/MGcmwcYFaSvL/3F4s1gwB++xReMp1Lv2N
        N7Cc5E1m37gpi2+3wGGcrFkIOzWsDNnVXphEYSA=
X-Google-Smtp-Source: AGHT+IGHA0KTHjACmMppnOrbLys7zmg8kwaZANk8Z3VE+lQNYP7/N7ei5QDPueZ3kNClunLrIiSSvw==
X-Received: by 2002:a2e:b893:0:b0:2c5:924:e8b1 with SMTP id r19-20020a2eb893000000b002c50924e8b1mr1638200ljp.19.1697544351561;
        Tue, 17 Oct 2023 05:05:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 66/73] pinctrl: ocelot: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Tue, 17 Oct 2023 14:04:24 +0200
Message-Id: <20231017120431.68847-67-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
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

