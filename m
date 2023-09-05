Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2A792DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbjIESzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjIESzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:55:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429E8E4E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:54:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-402c1407139so30000975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940012; x=1694544812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ESplXfwHuP68mF4bwcKzJlFkniMRPzx/b85/cMF6oE=;
        b=t6vnKqg+T54zB4Fkaa6Gy9AZAwhWlkIbFZZHoCfpms+RuRj6YJyXvIX1Wypx53fBqS
         ttS+voJEq+UucTCkf4/EU9pxZml9x38cspPMCu3FrX66N5Yg28F5N8FMEieVxRwRb+ZF
         E2NY8v6ju8+Y27OxjHyVsJzdrAMRomc2mT2SSXGTDokhY7gQgTbmaT6N8tXraLbt5NJp
         3jEmVCJiEdw8wth1e6Y+QlwteQHt2OAmZI7Tz+7qUAOeJnTSkeRVizE+H5JU9idv0ygH
         kq/U3oYVdaOinSqHyWCHvHr0DTlem8c5OxqzxwQTPK3ozuPMt2RKw9s2UQ0kjTKZmp1+
         1pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940012; x=1694544812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ESplXfwHuP68mF4bwcKzJlFkniMRPzx/b85/cMF6oE=;
        b=VUfDqNKeB/H7ocOEkNGcimkekuqd5+WUBsLZOB+aEEKN1e7gF/sJ4VAZkUG9I6URhQ
         Txd473a18K0pWVOmlvBKLIRqQCpwhCslwTtmzhCoHQCuDPI33cb/IAOUWkhNDsKSek/Z
         7Sekjwbl1Uknu+Ie+jM8DweREUddeSfWswH4gRycDiglVfVpyoa/PvZdgulMnCWLiWnX
         fzCCyLyQ1t++15HEBZMJ8oY3wwkjgtk7mK5auUEg5hR954gWnoiANr6GxgiNiB7yjwQX
         CjOSjpydVf1DDlgj1S1kWZkOIjVZWS04A5PL1ipTT5+5rxSoL94MngHwYtRAeFyYRsAP
         kP8w==
X-Gm-Message-State: AOJu0YxhfYwv0zW2o6YIJZI16WG0ojm2PIEJ4O9Uz2ZkFC3ohuG3I26Z
        2bsqZ1Z9TMqzeRxb1hIR7CDJmA==
X-Google-Smtp-Source: AGHT+IH/VUJWjUGeUiwbD9fUfZeGiUcxVuhg9dWO0f7MJ889A/l01WqAkHMkYlgWTOb/EzfuaH05Kg==
X-Received: by 2002:a7b:c411:0:b0:3fe:f45:772d with SMTP id k17-20020a7bc411000000b003fe0f45772dmr436878wmi.28.1693940012315;
        Tue, 05 Sep 2023 11:53:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 05/21] gpiolib: add support for scope-based management to gpio_device
Date:   Tue,  5 Sep 2023 20:52:53 +0200
Message-Id: <20230905185309.131295-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
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

As the few users that need to get the reference to the GPIO device often
release it right after inspecting its properties, let's add support for
the automatic reference release to struct gpio_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index a769baf3d731..b2572b26c8e3 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -614,6 +614,8 @@ struct gpio_device *gpio_device_find_by_label(const char *label);
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
+DEFINE_FREE(gpio_device_put, struct gpio_device *, if (_T) gpio_device_put(_T));
+
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2

