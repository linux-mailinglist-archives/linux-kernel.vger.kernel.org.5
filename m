Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF257C54A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjJKNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJKNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:02:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6010A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:02:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3231df054c4so6123727f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697029328; x=1697634128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63QGBdQugmbIeYioEFVwwnNIFK60s4bwdnFfbGlBXP0=;
        b=dVNaN7btylMSdzoZNKW45zXrvGW1bR/V+L+eNDccV4BQSz9zMpnfWbcC4i37es0dtC
         VOVXz9fIKdjQTLjNr7bN/2Zkgx2c7nyPdAzTJaUEPvWtMuKISVKybs2WXIwyUxgY80Hq
         z3E+F1Qhzf5CcHWAi6tNwGSHTPrUEd6YeN50DukuGhcNr97kpofnt5l3uoNhAICkPTxh
         n51EH+bpROB+74X+GQkv3UPrJdBDmEkedy9un4DBxv/NezpoyhM0jCQhpNFKy/C/XPcK
         nNSZrvOEFN0YhbcXLbyLR/+oeseQKOdK39eI+KyQ137FnHRgopjJFtmco+3ugKpFvyOZ
         /wqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029328; x=1697634128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63QGBdQugmbIeYioEFVwwnNIFK60s4bwdnFfbGlBXP0=;
        b=IWHoWz812DtoEfXKXc2fepJ1zoV9OFuTsl35Bvt8kQjuF2l53vT2cy6tkmhKTmNa5v
         RXYJyfCQ4MunDSVwB9JDf/c4ebBivWpTKul29PYW1WcGiDWV2reUJZXfT5HeFKhDV78S
         64nuV4WTRjdn9/lCC4/E87SSCipkyC3X4UZWhRcVgtcGIAMTN2+iyaXs1VXhU3TPU3Tz
         v/YzThF8QKXIadzRSoONodrjFMToTc9FKtXuOEjLRZydtq9rPknm1zcIYyQizb0bHJCK
         u+I+7y3jYK2gIoU0aOoCdS2WjbvfKiXvdvAYdr1+hzCx/GIAr7hQiKO0ejD2fKn2/QX5
         N9cw==
X-Gm-Message-State: AOJu0Yz2G9Wq5OkC1E419fGTTbdlhZFrt4cI8GL0GBF9l0dWTMvcC0mM
        Am/0z8uP4KruAyZE/jEJ7rIZ6Q==
X-Google-Smtp-Source: AGHT+IEHvgJ5iDJHRcGsv5VgNS5LfCN1JqKWPOmgUXFyggsQCs9ifJAjW9be6gKPlRqoj2E9if3BIg==
X-Received: by 2002:a05:6000:68d:b0:32d:88fd:5c65 with SMTP id bo13-20020a056000068d00b0032d88fd5c65mr1290432wrb.1.1697029327724;
        Wed, 11 Oct 2023 06:02:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id s13-20020adfeccd000000b003198a9d758dsm15455375wro.78.2023.10.11.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:02:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/3] i2c: mux: don't access GPIOLIB internal structures
Date:   Wed, 11 Oct 2023 15:02:01 +0200
Message-Id: <20231011130204.52265-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

The backstory for this short series is that we are identyfing and
removing all unauthorized uses of GPIOLIB structures across the kernel.

For example: there are many users that access struct gpio_chip when the
only user allowed to safely do this is the provider of that chip.

We are very close to removing gpiochip_find(). Another function that
poses a similar problem is gpiod_to_chip() which also returns the
address of the underlying gpio_chip without assuring that it will not go
away e.g. due to a hot-unplug event or a device unbind.

We'll need to replace it with gpiod_to_gpio_device() across the entire
tree. Let's start by actually providing it and adding the first user:
the i2c-mux-gpio driver which dereferences the otherwise opaque struct
gpio_desc.

Let's also add a helper that allows to retrieve the address of the
struct device backing the GPIO device as this is another valid use-case.

Finally, let's un-include the GPIO private header and fix the code to
access the device in a safe way.

As the change is pretty minor, it would be best if patch 3/3 could be
acked by the I2C mux maintainers and went through the GPIO tree.
Otherwise, I can apply patches 1 and 2 and provide an immutable branch.

Bartosz Golaszewski (3):
  gpiolib: provide gpio_device_to_device()
  gpiolib: provide gpiod_to_gpio_device()
  i2c: mux: gpio: don't fiddle with GPIOLIB internals

 drivers/gpio/gpiolib.c           | 38 ++++++++++++++++++++++++++++++++
 drivers/i2c/muxes/i2c-mux-gpio.c | 12 +++++-----
 include/linux/gpio/driver.h      |  3 +++
 3 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.39.2

