Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DB57FD935
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjK2OYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjK2OYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C65E1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b27b498c3so54860755e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267862; x=1701872662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl/Yt40SJcnA5LWZls34vPbbDSVAM5mPdOt7hL6FpRI=;
        b=HCSsw1pEypV0Hu2l4QCZqQAta1w2V1vy47SO7s+08955+Oz1OmNTzj275Ntln/437j
         ShosRgFQqbfYYC5MOf4ka5HcJuVLMPT1tCBZ3HykvZG7f62zZVg1zjC7Yzlzb7vGEoZG
         MSB5352k4Tbvf5YRPjEjYNzBrV3i1ecyakGWjIc/b/VHeQ/DIPJPLqXJGCYcuAwawcwO
         DzmPhk4Zv281btsZfsqig3nTPTW5d8okJVpfn6WYlPc/g0ScwHSbjzrXvWLpNN+taaql
         2HMw6kLjezUGJCEubPw9oV6gP+U8hA+Xa6U+7eysYBl8InXp9TF8zk74HJZM5xHW0qps
         K7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267862; x=1701872662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl/Yt40SJcnA5LWZls34vPbbDSVAM5mPdOt7hL6FpRI=;
        b=L5tZ/SKJVlYgtD6xMEcaFdxtWi548XueVDs3FH6WKJdQxIIv81YXcsYr+9LFqKXA/L
         7pqUV7tYa4w6uY4mP8r77/mnSVt/jHOSTDwJqA05GiuN94k9MBnJHXPH++uFLalkJ+MI
         vVmsF1ZiMjBxtVQMzHj4lK1kFxp/MrC7j/IB1ibjF+ctlbPdw+YOeJwFfo9sQhiUgn/Q
         qCD1uwdgDaE3XAZ2ur54GXe3ssAqsr/PWVbSKLCtqIKeCT88tmCAcs38FeyK3FHS6Vga
         fs+vwCb3bcReBv7tLa5yENenVX+g014NwVWnIFXY+DfDqYu1rmroOOyw0iiNhmIVpVZt
         cxNw==
X-Gm-Message-State: AOJu0Yx9pmtUP/lH6xjQVrIG75KwRB+LbOa/P2W57SXju6vzu7tc3FGM
        EkhorZsOYT/cOJHzLoCSkYX0oA==
X-Google-Smtp-Source: AGHT+IG35WsLjeaZLdy7JZyPLZGHiE6KYTksm1nO/QmSfxKHydUEVLI3pIvA6iYQXeqVDIuRIRSKZw==
X-Received: by 2002:a05:600c:3b85:b0:40b:3e7e:af4d with SMTP id n5-20020a05600c3b8500b0040b3e7eaf4dmr9959596wms.19.1701267861770;
        Wed, 29 Nov 2023 06:24:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 00/10] gpio/pinctrl: replace gpiochip_is_requested() with a safer interface
Date:   Wed, 29 Nov 2023 15:24:01 +0100
Message-Id: <20231129142411.76863-1-brgl@bgdev.pl>
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
 drivers/gpio/gpio-wm831x.c                | 14 ++++++---
 drivers/gpio/gpio-wm8994.c                | 13 +++++---
 drivers/gpio/gpiolib.c                    | 37 ++++++++++++++---------
 drivers/pinctrl/intel/pinctrl-baytrail.c  | 11 ++++---
 drivers/pinctrl/nomadik/pinctrl-abx500.c  |  9 ++++--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |  6 +++-
 drivers/pinctrl/sunplus/sppctl.c          | 10 +++---
 include/linux/gpio/driver.h               |  8 +++--
 9 files changed, 72 insertions(+), 42 deletions(-)

-- 
2.40.1

