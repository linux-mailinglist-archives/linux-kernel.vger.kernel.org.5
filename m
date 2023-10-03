Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73557B6C20
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbjJCOvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbjJCOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:51:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DAAAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so10425265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344685; x=1696949485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhFi4LGhC2Y5nFrUut/uRJGJvyUMlfTO1AC2VY89hk8=;
        b=iuvyjCbZ78hdbjmZ0dri6ZMBHVwGLWdrU60z4En12fGtM4w10l3wqAWLJBP2mL6bak
         kDMkgLbKCdovizExDeH4YikokkSLdoxrmDkwnTWGNiouuy/WX3EBCtHSi3fPU+e40Ejj
         mZ7Za5VTFyUJpHhnr6YyE0RRXUQyOMgkg5ue5LxKZhVIvLYnrNsRChHSmMV3tt3B752g
         NwKnAsXAGLvmKqLmn5HeD1iugQHA8KOsrvAkLkUypFb9m/r+OW15a4pRcwwQgz+eN5u+
         HtAzzxMwBuD+oychOBL9Jpt/vhviSIHhPWkKhcYS89yu0VE2XV03dZPMpOmP7ZRlIb0X
         fURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344685; x=1696949485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhFi4LGhC2Y5nFrUut/uRJGJvyUMlfTO1AC2VY89hk8=;
        b=UBW7eQX/JaYqVIUf9EQXi4maH2cPjVa7aZZO0nTwnMrvJHJGTbKRyUahconFLBhDpr
         js03PDYzQBlfCcA+dXvd72jaivgRxRuUoNtP0/vhD8cOqbsFsMHmc7zrD8hb6w17OrnN
         D8Mm+auOiNbwksopZOjl11ysh7e0tO97KUCg3wRV2DVJIVSbpq1qRNqdJLEj1SLFIY1E
         HfMiu7mEejtsYcZrLIPKsDeQh71CYaqS9QGsY+bDC/G6GrAlsizeAjgRpsAhVGfcQOnE
         3xiBnXoHekwR+C7h3bIMGgQbb9z+A/i+mx1OGr2qaWPIZ7fMTHpaTtVTCAegLzBUSAML
         jBHg==
X-Gm-Message-State: AOJu0Yz2g8fB0SciNHSAM0Rvc1JBVkPm6IOG9tSm9wkQIFlYcfi6NPaL
        IFLRMdV+IcKgDx7IcU40zvgEkA==
X-Google-Smtp-Source: AGHT+IHVVhROTMLzaecR+DvOqv/ba9hFEK8QHFfIA8RToQZ6zwZgN+HwXCdWNlveOssebExeEvFh6Q==
X-Received: by 2002:a05:600c:3d98:b0:406:52e4:cd23 with SMTP id bi24-20020a05600c3d9800b0040652e4cd23mr12565592wmb.0.1696344685191;
        Tue, 03 Oct 2023 07:51:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 04/36] gpio: cdev: use pinctrl_gpio_can_use_line_new()
Date:   Tue,  3 Oct 2023 16:50:42 +0200
Message-Id: <20231003145114.21637-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
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

Use the improved variant of pinctrl_gpio_can_use_line() which takes a
pointer to the gpio_chip and a controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 31fc71a612c2..54ee075410db 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2287,8 +2287,7 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	 * FIXME: find a non-racy way to retrieve this information. Maybe a
 	 * lock common to both frameworks?
 	 */
-	ok_for_pinctrl =
-		pinctrl_gpio_can_use_line(gc->base + info->offset);
+	ok_for_pinctrl = pinctrl_gpio_can_use_line_new(gc, info->offset);
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
-- 
2.39.2

