Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051F67CC29C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbjJQMJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjJQMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151C270E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50305abe5f0so7345230e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544347; x=1698149147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnHBRfmIODSTWCjwzxjk920VZIB9kQcoosTVsaf2qL0=;
        b=DPTny//8JkPTV/yeGyGgKFrQ90kOmCAjy6nNMQFWIAIm9t7EY8tMfrO9bPMN6SPiTb
         sLtT6enM6yntjK3S4lcKIq8bi0ku8fX/c4UEBMLwZr0zHLvjDNLyQDDNYM11sOKdb3MT
         DtoiKcjXY9wIqlqFw/7hB49aUetvIk7pYzrInLwMm3pBHjx5g8N2ZjYOkccc+94N3pS0
         CIs1eSMVfAo9VPtj1IvPMgHpmqMoQENCNoSaDUW5jObvHwsEWCXvRUVF0icFD/aYMywi
         X1BlJV+DQs3PG4R+TEBeMpfbejKFdTiYUOOqm83K09YsopPHJ5DvvCZFyD7IKksgr+Qa
         029w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544347; x=1698149147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnHBRfmIODSTWCjwzxjk920VZIB9kQcoosTVsaf2qL0=;
        b=tVg4bpO6GqwZ/DlN8fXH/qpYYjnpbbbJqUsbxiRJCKbpLqPKOBEFIZt8KEYjS4lgNp
         ywh5eKSifmO6Qt0vL660S2Q7uGNwjDNfR7cfdqWLFstLsFO9IyOTwNX/x2WC5FDDJQMw
         1IvTXak5aXbPe+vZpDAx2231HGzCmHv+yD3OvLQBpIdJhdIcnWZX8yD43FztCLow4pob
         BrklJ14MvpDlttlzZR8ZhTHnvEQRfd5ZoyxF3GCtOU8G4Hqfz/zv+ntpbl/4av6lTDQ5
         FsG0NCNrWpJrykSXmHbdQoPlZ7pE7zjxqMnW/2jMPxtREfKhcITrMQ/NyO0n54BsjTaF
         G6/A==
X-Gm-Message-State: AOJu0YzM9u7BkbURIQHCil+khcdw8OMa16L+C2a2Qy0zYS/AJ8oJOrZg
        W9St/z15cK83GJjUC7rrTpiIcg==
X-Google-Smtp-Source: AGHT+IFI+8jFW5dfO7T9dgcHWZhR+S/KmvgCIN5BPI5Kwog50KV7w/GfkWP1rUvx1hp4i/9emVH/8A==
X-Received: by 2002:a05:6512:3b14:b0:507:9fcf:42ce with SMTP id f20-20020a0565123b1400b005079fcf42cemr2026931lfv.57.1697544347127;
        Tue, 17 Oct 2023 05:05:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 61/73] pinctrl: axp209: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Tue, 17 Oct 2023 14:04:19 +0200
Message-Id: <20231017120431.68847-62-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
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
 drivers/pinctrl/pinctrl-axp209.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index a6eb3b866a23..2b4805e74eed 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -124,11 +124,6 @@ static int axp20x_gpio_get_reg(unsigned int offset)
 	return -EINVAL;
 }
 
-static int axp20x_gpio_input(struct gpio_chip *chip, unsigned int offset)
-{
-	return pinctrl_gpio_direction_input(chip, offset);
-}
-
 static int axp20x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct axp20x_pctl *pctl = gpiochip_get_data(chip);
@@ -474,7 +469,7 @@ static int axp20x_pctl_probe(struct platform_device *pdev)
 	pctl->chip.get			= axp20x_gpio_get;
 	pctl->chip.get_direction	= axp20x_gpio_get_direction;
 	pctl->chip.set			= axp20x_gpio_set;
-	pctl->chip.direction_input	= axp20x_gpio_input;
+	pctl->chip.direction_input	= pinctrl_gpio_direction_input;
 	pctl->chip.direction_output	= axp20x_gpio_output;
 
 	pctl->desc = of_device_get_match_data(dev);
-- 
2.39.2

