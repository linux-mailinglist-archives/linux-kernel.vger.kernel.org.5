Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D187B6C54
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbjJCOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240349AbjJCOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:52:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00081CE1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so9994795e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344704; x=1696949504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt4PWI36LT1R2nI/NQBkxbO8D5dykJYeFhT6i3lm7MU=;
        b=ynl+T5WrpM+1eMKQ5X6c7e6XsTUTRL+fWMeXwaGeoHjJkKOZpo6t0dgE0yH/w9gHAE
         jYb81WPRhTkENuRjIgGe/tz9HFsO1deG+ZGYUy54bbaW3Zht1iEui1iWjylvgOER6SOm
         Cw1+xsJ/wSnzNYPcpCbGpdc7OY6A66rgP8FFv8d5zITL5auOVoJh8ih/pl7PmbYv+RUV
         HXEiVLReTXloBEyiGgwPLfrIlAIdspBcgX9nBXhn9XzNjLTrsZYq5Eiv0wtv8JrVhHrF
         2Yf1/bjbZaTfS91xVL9N1OUMUWXL1ajP5WIdqbS7b7cqOV4JVtnU4bxZAWjPkUdTSz8p
         cRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344704; x=1696949504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rt4PWI36LT1R2nI/NQBkxbO8D5dykJYeFhT6i3lm7MU=;
        b=fyd6J7UVUnj6KyunNVgTROKdD8NioVVjjODb485ffwhxGaLXduFJ0TN/0h/DE/zUis
         hQbPyVhzFwGOb72po8QD9fpQPRnZ82H96p2jF0wsPrCGF1x0wRaPJJQeF72H0pEirlqV
         LDae7Y99pgfDXGovVdw3ChMw8I4u5qxFYmQc0do4dtjhfvmdrMtFzDrWtkRWaG6NJUlf
         nZgVhG70yAl6jL3zil5hPWeCdG4EXAEryznaIggbhhVcEhC7syjlhqgRoaweTphUsS8X
         d+V1Dr4o8B8m7sLvHPCJzTAMg/oWlgkTITQvqvoskUTBGK7X9x+X/ZBwPNRZmf+4ou1Z
         OFHw==
X-Gm-Message-State: AOJu0Yy3hEfD1WUgpmI4+XpjnbwH7GbkWbREcRcVIISF1gH4NgmLLxCX
        e/pIJSLWdMo8w7RCfejGD4//tjNeaiEUzxRI+tc=
X-Google-Smtp-Source: AGHT+IFInMnzhhc0PnuVNWFcT/tzseIYWOpII4E9CQXObsPqitPM9XJqdafTjCmMLhxmA/bzYwRLTA==
X-Received: by 2002:a7b:c858:0:b0:405:40c6:2ba4 with SMTP id c24-20020a7bc858000000b0040540c62ba4mr12415097wml.5.1696344704147;
        Tue, 03 Oct 2023 07:51:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 26/36] pinctrl: as3722: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:51:04 +0200
Message-Id: <20231003145114.21637-27-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
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

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-as3722.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index f0e5d87ac50b..3d3adf9793fb 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -502,14 +502,14 @@ static void as3722_gpio_set(struct gpio_chip *chip, unsigned offset,
 
 static int as3722_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input_new(chip, offset);
 }
 
 static int as3722_gpio_direction_output(struct gpio_chip *chip,
 		unsigned offset, int value)
 {
 	as3722_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output_new(chip, offset);
 }
 
 static int as3722_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
-- 
2.39.2

