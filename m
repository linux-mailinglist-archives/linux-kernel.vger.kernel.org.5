Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CAE792DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbjIESzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbjIESzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:55:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42638E73
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:54:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so28802895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940032; x=1694544832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrAFFOP3UXm+2vTLeazN1us+BKa1tnA/xN1dYjhLvHM=;
        b=MQWbDF4rE965sDGpw+Z8xVUKRHWw3YwzcUYhTRpv6IjQmey/WoA0wHY8VDz3R0Gs38
         ONt/xesxsRZkGk1oQAbVZ3/Xb76GeT7pfbvfb4yr9zqV/VjJ5K2WB6AlPVPvoo50v0VM
         k8osQxqM9YtwOMW+1OwNpMmpWUQOpl+gVSuTgLVkExdc/SXvLBOJbw1sLo5ay63Ho/fb
         YddhACrq0zNDPR8OLrpkxFlpuOCulETe0g8uTQKCP3PPXZZ52MdDVgn9LSEANBfDGdLV
         nm2HV2DtdgVJ9nmvVVDfsHadpACFPjc9utovdDApP0UYgxae8AB0ZTtfWUDNP5Wf+vfS
         eyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940032; x=1694544832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrAFFOP3UXm+2vTLeazN1us+BKa1tnA/xN1dYjhLvHM=;
        b=VvISyc8JhruNptx/p90XIp/O11fOWOVSzJiUfo0/xmNpRwHijkYw+iE7+0AduLaQ9g
         UCgpW9ICNFBKce211bW37atcDeGL6NqZl72DGrN3GYxsVK1dJ3w2XZMWS2oZip8m/LOu
         yLigFHIe9gKJNTaBzXr6sMtRhY24LQni6ZkfZ4xBuqKoZH7pKsKPTxfJQ/Tb2CfG47OA
         mvQqlRywA8Pl/iJ2ZB8Ad2+oL7u54A7/8OFEZ7cYOUB4zM2+7hxZ4PN/ZEKQ2TbdohYM
         GfLevT89GNLGwZvNUuoL/iKkgf3fLzHFD4Mr1Ws/fLY/lK68qYIHCOMUJpRjO++1wQxA
         PTtw==
X-Gm-Message-State: AOJu0YxL+YIe0um2jex18YCIBV7NCk94XzObS7dJMXVCDnDsLtl07T8B
        TzrGJEw84BRclnWxLHowqTJQ4Q==
X-Google-Smtp-Source: AGHT+IG5rvnvzkhR7zSqbm37o4SyQS5DF2Q3QExpMFHirbdRnNeCry1xvOOt3d5Fk7gOho9h35WBqA==
X-Received: by 2002:a05:600c:11ce:b0:3fe:2011:a7ce with SMTP id b14-20020a05600c11ce00b003fe2011a7cemr453840wmi.6.1693940031710;
        Tue, 05 Sep 2023 11:53:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:51 -0700 (PDT)
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
Subject: [PATCH 21/21] gpiolib: remove gpiochip_find()
Date:   Tue,  5 Sep 2023 20:53:09 +0200
Message-Id: <20230905185309.131295-22-brgl@bgdev.pl>
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

With all users of gpiochip_find() converted to using gpio_device_find(),
we can now remove this function from the kernel.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 22 ----------------------
 include/linux/gpio/driver.h |  3 ---
 2 files changed, 25 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 90e8c3d8b6f6..bd700fb4871e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1081,28 +1081,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
 
-/*
- * FIXME: This will be removed soon.
- *
- * This function is depracated, don't use.
- */
-struct gpio_chip *gpiochip_find(void *data,
-				int (*match)(struct gpio_chip *gc,
-					     void *data))
-{
-	struct gpio_device *gdev;
-	struct gpio_chip *gc = NULL;
-
-	gdev = gpio_device_find(data, match);
-	if (gdev) {
-		gc = gdev->chip;
-		gpio_device_put(gdev);
-	}
-
-	return gc;
-}
-EXPORT_SYMBOL_GPL(gpiochip_find);
-
 /**
  * gpio_device_find() - find a specific GPIO device
  * @data: data to pass to match function
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index bb9ec741bfda..7d2bf464478a 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -603,9 +603,6 @@ int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc,
 				    void *data, struct lock_class_key *lock_key,
 				    struct lock_class_key *request_key);
 
-struct gpio_chip *gpiochip_find(void *data,
-				int (*match)(struct gpio_chip *gc, void *data));
-
 struct gpio_device *gpio_device_find(void *data,
 				     int (*match)(struct gpio_chip *gc,
 						  void *data));
-- 
2.39.2

