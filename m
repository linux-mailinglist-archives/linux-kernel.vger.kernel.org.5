Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72547C538F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjJKMUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjJKMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:20:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF24183
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4066241289bso63793015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026195; x=1697630995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fJ2QmhXWplWv9DEf43iP6RhPqRuukfw3F4hurk2iKc=;
        b=YJc1gOBPYnF1YmAADxLd64DHA/EwbJ0R0qLlyJMDzjjt+X8c93rGfeo2XwHRKsi7EZ
         o+VZ2cmKz1n4ArJbiAFh+IcnN0Ae7zMpO+6qbjzOp/ym10cHC2gRqzWxyQhFl6Odfoer
         cC+sUihlNHeYQA9aeP4CcsukaLFaCxQClKT33YBi/6PcKn72rF9W6MU89bfH2uD6iIcI
         DrsoS9+wjkd7Diql6so9OWyYpJX7hwc26fba7nxIl0LECo4ygnLUKbGBz+0fiSIiSwR0
         iuohcpFEFS9NGzo72ynNmTRCqFr2qfh5Jgu5z3A8bXnB+KQsrHF9qTOm8887YATlXySe
         paMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026195; x=1697630995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fJ2QmhXWplWv9DEf43iP6RhPqRuukfw3F4hurk2iKc=;
        b=Qkw8Lzz0dAnHewBtL5NFP0dVoAYphtZHMRfp0KcvM96qyAIqFt/l9CWIug8O8r9jO0
         dVND+zQt0D8H5cJLRee0r2d8KcFVWXmEKAR2HqEWFihmJd114dUxSYaS74vKLRsf4Uau
         ORmWP8lWjvnYWgLMP+I+jTXT1fxXXkmYfFfYSpnlskEMDmsP9B+RlKN//6zD7TFAwTyG
         2PogNZQTe22to327ngp5/+1fmpf19KPtBVGHwMfiP+TtGh7hFDW34lVB6wT2AU/PXbT3
         ihcDaNLsqNw3d42Rwhc8f7d1JsAv7GiLGlwq2+kAJ7VmchzYYlI+kY/AlM8UQ8GLauqU
         O1cQ==
X-Gm-Message-State: AOJu0YyKiMED1LGjb6UJLgUeKaoqFsGLIWHc3ezutr9VJgeVc7A0qKRF
        TyGSI55f4p70IDy+BbMgkFsa0g==
X-Google-Smtp-Source: AGHT+IHezi/Ra4dzqQwKFnBx1xG/zTlvOuMCpECzOYPprKTJYnjFWFcuv+is8+FT22ih9eOHYCRGtA==
X-Received: by 2002:a05:600c:4686:b0:405:95ae:4a94 with SMTP id p6-20020a05600c468600b0040595ae4a94mr17714386wmo.5.1697026195043;
        Wed, 11 Oct 2023 05:09:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 52/62] pinctrl: vt8500: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Wed, 11 Oct 2023 14:08:20 +0200
Message-Id: <20231011120830.49324-53-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

