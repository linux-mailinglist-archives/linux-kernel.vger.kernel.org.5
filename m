Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407EC802EAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjLDJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjLDJfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7347102
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3333fbbeab9so1274968f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682512; x=1702287312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bI9Av4U/SVdm3nbgC/vm7JEvEONt6G/9k0MCILqgaHw=;
        b=h83xtGQvBmHn3RyU8j9D/9/H+d1CQ9WEs3UAbKrLTFu5Ad5zc2pfD06kOjfKwNWEjs
         pVHdOvAo1u4NGyRoA8xY88aqF+Q+X5Unc8/+qxODmkVEk/VHMPIPB18RXdRMmlqcbUh4
         9L9UDL5y1eGb67DB3rFQzfGEF3LB6vGlqW2yuh33bPcRcpCfmakWTMWv0224AzqyXAzN
         SXWscdwIwT/KVxaXX6ySPuhWv3Gwf+YomYX94bNSyw9hr1sUto0qV3tdhNqxTN8Zl1Nc
         rpqxSRrCeA08RWQ6Z4/iatW1Bm4UnK22IgksDs9CYU2H6yGFlcP1Acxu4ifaT9EVyonl
         kBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682512; x=1702287312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bI9Av4U/SVdm3nbgC/vm7JEvEONt6G/9k0MCILqgaHw=;
        b=E5k89wUW9D/JAVG0aKtr7ZtL+UD5FRnqrrAqF+lbycXlGQu5n2HGOgo7BaGVSIO0cH
         GoUCgUW+NL4AVEmOiLbKVeLrdozIGjfNZE0PXWoPj9j08z6fB4TY9aZMMNYmXQbmkobr
         4CswLeUxGNqE6y8OBJ/yyvK3qZLh1Jxl9WauWGzFpbjzNht2uZWR1lJeeAdDY9It85W/
         EUtz1aAjbnfo66yhYoRm4ATBykZcoQKzaHwz+HQZre9pxlUBozCB3AR6g9saAtQ/7XR1
         57a7j4K01zxUd9mVd5kmyXAsFvlfCK+rdvb6GDCnpQbQ24oSOvaXigKmHDoD3rao7/UY
         dTSA==
X-Gm-Message-State: AOJu0YynwdnV0i2dWB2XH4nY04gjZpuZFDgqGaMeoW0NB9iDuZHSIzgv
        KywGyhcL4W3u3RcRoKnmnJxGmg==
X-Google-Smtp-Source: AGHT+IH6x9tPhUGJ5LtE+rCyQCa941oA93WQ38y3dg3gU8kA7Mer2Q8w53ySrKx6EYMT6c64/gTSDg==
X-Received: by 2002:a05:600c:1912:b0:40b:5e21:e263 with SMTP id j18-20020a05600c191200b0040b5e21e263mr2205541wmq.80.1701682512138;
        Mon, 04 Dec 2023 01:35:12 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:11 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 00/10] gpio/pinctrl: replace gpiochip_is_requested() with a safer interface
Date:   Mon,  4 Dec 2023 10:34:59 +0100
Message-Id: <20231204093509.19225-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

While reworking the locking in GPIOLIB I realized that locking the
descriptor with users still calling gpiochip_is_requested() will still
be buggy as it returns a pointer to a string that can be freed whenever
the descriptor is released. Let's provide a safer alternative in the
form of a function that returns a copy of the label.

Use it in all drivers and remove gpiochip_is_requested().

I plan to provide this series in an immutable branch for the pinctrl and
baytrail trees to pull.

v2 -> v3:
- rename a local variable cpy -> copy
- use unsigned int to loop over GPIO lines
- use an unscoped guard in patch 10/10 instead of the scoped variant

v1 -> v2:
- use DEFINE_CLASS() to register a destructor for making sure that the
  duplicated label doesn't leak out of the for_each loops even with
  break;

Bartosz Golaszewski (10):
  gpiolib: provide gpiochip_dup_line_label()
  gpio: wm831x: use gpiochip_dup_line_label()
  gpio: wm8994: use gpiochip_dup_line_label()
  gpio: stmpe: use gpiochip_dup_line_label()
  pinctrl: abx500: use gpiochip_dup_line_label()
  pinctrl: nomadik: use gpiochip_dup_line_label()
  pinctrl: baytrail: use gpiochip_dup_line_label()
  pinctrl: sppctl: use gpiochip_dup_line_label()
  gpiolib: use gpiochip_dup_line_label() in for_each helpers
  gpiolib: remove gpiochip_is_requested()

 drivers/gpio/gpio-stmpe.c                 |  6 +++-
 drivers/gpio/gpio-wm831x.c                | 14 +++++---
 drivers/gpio/gpio-wm8994.c                | 13 +++++---
 drivers/gpio/gpiolib.c                    | 35 ++++++++++++--------
 drivers/pinctrl/intel/pinctrl-baytrail.c  | 11 ++++---
 drivers/pinctrl/nomadik/pinctrl-abx500.c  |  9 ++++--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |  6 +++-
 drivers/pinctrl/sunplus/sppctl.c          | 10 +++---
 include/linux/gpio/driver.h               | 39 +++++++++++++++++------
 9 files changed, 96 insertions(+), 47 deletions(-)

-- 
2.40.1

