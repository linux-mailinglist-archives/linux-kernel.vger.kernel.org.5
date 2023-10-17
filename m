Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D50E7CC30A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJQMXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjJQMXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:23:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B1A1988
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so52217381fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544318; x=1698149118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwciMDEJmwkjhMDgP1JPMADTRBiS8hEPWAh7DlNBT2c=;
        b=KJ6TxornkPx4ML8GSGSmxf6o4mZYPwV+vEtSFYpOPuaycfqCm5CI2ExoIV5MYzeBCb
         Ig80DTGZcqgLjKsYJ/12/UejLdQtw5zzUNabg4CYbc74qzr3G8iBIQOH+SgwlFTWYDGE
         jxEH50Npl6ZYkQVP3e25uXrUqq1K9tw/rcCo4W53WTSqtgDm5mKdZmRU3+0iqaVAleCa
         bWxWScKEPvqrU3fr8WSgbLejdRkzjg48APEkDrFZ/2NIexHJVHQvRnbvEACiYomo6u5P
         KUsEQDLTi+ZvBQnSL3t0wVPDQGeZu9EsAJRSIjDHBBtEwQcHE4obYjpSGvmjrVQAKMqK
         WJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544318; x=1698149118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwciMDEJmwkjhMDgP1JPMADTRBiS8hEPWAh7DlNBT2c=;
        b=MvMka2nFck+ssYZkeMfbx9dFnBh+ioOgOygMLG9evC8Uqs0ohoI1w7m0s6BcYGJXsZ
         KR9fiV3F2/vICuurQxSXt6TqGjGTSJuGj7jJ0D4FIjhT8P/5nwz2b6Rqn5MXTTfJlG5g
         6+54kOmB7rbNnm8R8UbcsSOfNXiRsE2wLnIn07t3gLKEClUziDHOV2VJAAgA2P5afGNz
         ReFZuFXHhVbdLtkKEHaRuv4KmIGxu5zO/ktoIv3i4PHn/T8qNsDBxJA+6LRi5YRi7Ngz
         ZksZ3S3WgIeUaRNF/Enycm28rMhnOII2zBFaFyyGFHXhd3mmUQluM1kCNuDt3uGsFqGa
         s8iQ==
X-Gm-Message-State: AOJu0YwaBcb28YLxKp0tSpnwvXK8komfDWS9WGYX6krfg5f246ZfuMxB
        /EvIE7uR8+lGCDoSKi5LZZC6yA==
X-Google-Smtp-Source: AGHT+IHhzZONAYHNx3gqc4pIA0lEbPEqPBfq0qcFjG7SYfmr12HY78Q6mpZGLRdrOVOx+JChdGnpZw==
X-Received: by 2002:a2e:9902:0:b0:2b9:e6a0:5c3a with SMTP id v2-20020a2e9902000000b002b9e6a05c3amr1655865lji.48.1697544318317;
        Tue, 17 Oct 2023 05:05:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 31/73] pinctrl: ingenic: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:49 +0200
Message-Id: <20231017120431.68847-32-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/pinctrl/pinctrl-ingenic.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 2f220a47b749..5072fb907193 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -133,6 +133,8 @@ struct ingenic_pinctrl {
 	struct pinctrl_pin_desc *pdesc;
 
 	const struct ingenic_chip_info *info;
+
+	struct gpio_chip *gc;
 };
 
 struct ingenic_gpio_chip {
@@ -3561,14 +3563,14 @@ static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
 static int ingenic_gpio_direction_input(struct gpio_chip *gc,
 		unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(gc->base + offset);
+	return pinctrl_gpio_direction_input_new(gc, offset);
 }
 
 static int ingenic_gpio_direction_output(struct gpio_chip *gc,
 		unsigned int offset, int value)
 {
 	ingenic_gpio_set(gc, offset, value);
-	return pinctrl_gpio_direction_output(gc->base + offset);
+	return pinctrl_gpio_direction_output_new(gc, offset);
 }
 
 static inline void ingenic_config_pin(struct ingenic_pinctrl *jzpc,
@@ -4052,7 +4054,8 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_OUTPUT:
-			ret = pinctrl_gpio_direction_output(pin);
+			ret = pinctrl_gpio_direction_output_new(jzpc->gc,
+							pin - jzpc->gc->base);
 			if (ret)
 				return ret;
 
@@ -4172,6 +4175,8 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
 	if (!jzgc)
 		return -ENOMEM;
 
+	jzpc->gc = &jzgc->gc;
+
 	jzgc->jzpc = jzpc;
 	jzgc->reg_base = bank * jzpc->info->reg_offset;
 
-- 
2.39.2

