Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23D7B6C49
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbjJCOw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbjJCOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:52:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9430122
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40566f8a093so9831055e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344700; x=1696949500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbI1RQ5tA31jmForDpjaNDHFXNvHWaIh5Ez7RFreokA=;
        b=oqv2IvZ4CQ9vHBFzSk9S5dW8Oki2hOfCoANXrYJ8TZA5QHBj6AgHwR7bsfZNP+7uE0
         aTzPAxASJTt7CiYVTdeJSu5j56KRZOZ7e3u2XqQ3VLO5ZifQt3n2DAPzmEJ5GEZGHsgZ
         50Njv2IA/5JqEJ5yJHzVzebnLdA6+JRvTPjjCc+0449sh5c0rrVwZQ9GBIs0hguW58eJ
         ppEmajG11u/lJiCOZtuzxe/K9P5CsU0OGs6xGtk4X77+drlr7K2xXzH+BQo5eAudGutd
         dc0Yx7ZNqBg8q2HoOA3t8qiMocDlGHpi00sNTCfbD+NMn24HeqzGTkDCE+C+zCDeCvGt
         PFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344700; x=1696949500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbI1RQ5tA31jmForDpjaNDHFXNvHWaIh5Ez7RFreokA=;
        b=S9yf3juDAJQ8X/EEzAp5/ZCoq+T2lxKZZlgha1CLsZxyyHa4VD26DrM9u6zUcTtZ5/
         JEyKMkHDUMjXzOX/wNHL6AQfs6cuNoSpzU54bY5SwMJ3onKEIKktEj6tadTw474ozNl3
         AUUJ5TV4KSUEZch8JnJrp4b+CS45dDhhdgxZkfTRto0C/M2Gn8gt6e6aYbPAhN6mCf7d
         /wUkeUGcXqmCyX0uIg694Y1pXo2Hk8pMqCrPK5kGyuSVB9b8V5hspge37gYMyBdNShUk
         4i1lc8ckTYiFwRROjhCVeSM306WmwBJ6OYgSh0GAvmDwnmDNE/uuMgZd5DxCHSpQ1pZv
         nc7w==
X-Gm-Message-State: AOJu0YwpT0bEkG2bvdv4zWfTaJMPuQDPzwinO68Cx9HifOTjDwH4my5i
        dbL3DNmAdoz7C86pNzaQZp4YfQ==
X-Google-Smtp-Source: AGHT+IGDe8qyl3H7tHp7/i95Dcbrmv2tEdTDIgA+Gz7COGg95rm2oNQU9BoqqS4J9fllDu6b//glNA==
X-Received: by 2002:a1c:f709:0:b0:3fe:1cac:37d5 with SMTP id v9-20020a1cf709000000b003fe1cac37d5mr13510551wmh.4.1696344699849;
        Tue, 03 Oct 2023 07:51:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Subject: [PATCH 21/36] pinctrl: cirrus: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:50:59 +0200
Message-Id: <20231003145114.21637-22-brgl@bgdev.pl>
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
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c   | 4 ++--
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
index c09646318419..097e4dcdda36 100644
--- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
+++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
@@ -508,7 +508,7 @@ static void cs42l43_gpio_set(struct gpio_chip *chip, unsigned int offset, int va
 
 static int cs42l43_gpio_direction_in(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input_new(chip, offset);
 }
 
 static int cs42l43_gpio_direction_out(struct gpio_chip *chip,
@@ -516,7 +516,7 @@ static int cs42l43_gpio_direction_out(struct gpio_chip *chip,
 {
 	cs42l43_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output_new(chip, offset);
 }
 
 static int cs42l43_gpio_add_pin_ranges(struct gpio_chip *chip)
diff --git a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
index 0b78cf611afe..f3c8a8c14e14 100644
--- a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
+++ b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
@@ -1098,7 +1098,7 @@ static int lochnagar_gpio_direction_out(struct gpio_chip *chip,
 {
 	lochnagar_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output_new(chip, offset);
 }
 
 static int lochnagar_fill_func_groups(struct lochnagar_pin_priv *priv)
-- 
2.39.2

