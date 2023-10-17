Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC187CC29D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbjJQMJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjJQMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EC126B2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so59008325e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544346; x=1698149146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fJ2QmhXWplWv9DEf43iP6RhPqRuukfw3F4hurk2iKc=;
        b=0md2dvRtqR2x5GkHHCg4ioGCoiPf3FwJgVndGKUXjO5Hxybp5BstnIK8HzFihYuUpn
         RWChBD5mUaftVlj9I98ajJlAU1SheBJ640pOAxdKeJtQG2R0k9ETd7Jan8BU9x6Jn6yy
         p60UCXSOrZ9TYN+xr3iIQlF0Df09oAoljm3B0Z118ae6dYXA57wPwtoY9PEa7Wu/H0jd
         ITLXG5T6es6S9tZWzyOiTwSrsu+/imM/lLoz8o+b1tjLTKmA2vwxqsFjFoV1cBo/paKu
         KePKM//OKFioXKgc3k/W9Yhy0JVX34d3tv8wN93GKRklfysGfapGlvWbLIaemW1Oj6x3
         Y4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544346; x=1698149146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fJ2QmhXWplWv9DEf43iP6RhPqRuukfw3F4hurk2iKc=;
        b=Oc11RQOfhmTE6K3iKGl7W+NbExOprWbhPUGarJg4AcGIlOr0k0d2g6wj+D6DVuRaps
         E/yaSQV46XhGs+H6cbPwmcKPeo+Gz64pASb6dHoawXh8naLiD34O/2k+/jGhhkPKsd9z
         o1ab2MFOzK32HGxZMoQmBGpUcQwMKHE/x+0nZaJSU0YNb8Fs5ANukz/HhlmY9ALcvqm6
         tLMz1mkHsnbxXAFC77o+Bn2OxmaXfrhEi//RRbUeD8cI7sAGAPjI75qXlkgbO6vxDyj6
         6a/pGsMLMA0byKJQYoDIsWDLu0kEq9ZD7f+UD8cFYW/pfoYYZr27JarL+JVXGMH/lG1G
         oZaw==
X-Gm-Message-State: AOJu0YwNfkHn49EvuHZekxvgrg8rJuJHqy4ZmJTIfB+8eN1AKdDIfaZ3
        ALlPiovpJYaOewp6zabuTn4Czw==
X-Google-Smtp-Source: AGHT+IFrm8m6PkO2MeoJBk8M+cQ5If/Je9u9hgzNaFX6Deg2XbQvzpcCpeRdkVruesr+LhmTiyHeDA==
X-Received: by 2002:a05:600c:46c3:b0:407:5adc:4497 with SMTP id q3-20020a05600c46c300b004075adc4497mr1544354wmo.9.1697544346333;
        Tue, 17 Oct 2023 05:05:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 60/73] pinctrl: vt8500: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Tue, 17 Oct 2023 14:04:18 +0200
Message-Id: <20231017120431.68847-61-brgl@bgdev.pl>
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
 drivers/pinctrl/vt8500/pinctrl-wmt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 639446bba373..fce92111a32e 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -526,11 +526,6 @@ static void wmt_gpio_set_value(struct gpio_chip *chip, unsigned offset,
 		wmt_clearbits(data, reg_data_out, BIT(bit));
 }
 
-static int wmt_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	return pinctrl_gpio_direction_input(chip, offset);
-}
-
 static int wmt_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 				     int value)
 {
@@ -544,7 +539,7 @@ static const struct gpio_chip wmt_gpio_chip = {
 	.request = gpiochip_generic_request,
 	.free = gpiochip_generic_free,
 	.get_direction = wmt_gpio_get_direction,
-	.direction_input = wmt_gpio_direction_input,
+	.direction_input = pinctrl_gpio_direction_input,
 	.direction_output = wmt_gpio_direction_output,
 	.get = wmt_gpio_get_value,
 	.set = wmt_gpio_set_value,
-- 
2.39.2

