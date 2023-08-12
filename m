Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E715A77A1B9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHLS03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHLS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:26:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C8F1709
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:26:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3fe5c0e57d2so26752305e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691864789; x=1692469589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXZytH4ol5RAef6ByZ3UNwYY/9mipLfGMfHZAOyBiw8=;
        b=Sb3/tnFwBCUbh3WduxYWjWup2rxO7QbWzYXeDZ0XSMQdLwlLXS3VaK+GeXpC0/gS0L
         T+TGmW8JYU6VuhCRFytCal2ObnSYi0bXR2sQh2xlD0uHkn3g2BeK0f0muV3PSY5JezXF
         ff1eoZNcaR4WVNW7RrfbHdfZsSiC4MCZat0OFf2IdhawNCBmNC0uR/VaN8/AnnuXN7jg
         r9uJ5c6nZUs7xxY3PJghGhNVkJYunFWS/JtM8xRbAeSVc4CGgbNe7k67L4PpzE24WMVW
         TteyXcNszmgR9r54aM8sH43GTwwYz7cIkWOTB8OMF2ZbG34cSj/InwGwud0QxHV3E9kt
         Md2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691864789; x=1692469589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXZytH4ol5RAef6ByZ3UNwYY/9mipLfGMfHZAOyBiw8=;
        b=VZnKbVd0nEDWTVcVJ6s7QsQY1nhcS+aqk5+rDVE++UQX/kQQU7FggFpxDerAAwTTIY
         GaHQSe3KZDErKwBUwNEePG7Slwrym3WxJ34vwjXHmPUuiDW/OgZG+V7STKCGPYyDDe8z
         d+5CHaGncC5fBhOLpp8K7CWMJSPRrlwMJq/+3oYAlvqQLDagfuXeoFtGlmVtWpq+6pE1
         sYRp7P+SjYvjNHwbWynZQuQrPRL3YPKTvN4w0I/nhagB9cEmzkNozB0tzGM/o/UUz0Lt
         zqmVAkD/rmXzjYFuGJGGQ/gEWBY/NKnmaQhnnPwtMAVnKEnxaqoDZHw0ufKM6FsMsb+o
         6cxA==
X-Gm-Message-State: AOJu0YxFNJni1YHuVDS0DWmYxLAvcmWREBG5N6S4XVJvS8x+rSXlOboY
        +u2PaqYyMIk4DjII3YvOKw3mbw==
X-Google-Smtp-Source: AGHT+IFuKFLIEncDYK/lodzPUslM6BImxVjlsoJmjdNK8rUw72L5cVHy0BZFrSVoarCqRgdBcnlaxA==
X-Received: by 2002:a05:600c:218:b0:3fe:212c:f790 with SMTP id 24-20020a05600c021800b003fe212cf790mr3840391wmi.36.1691864789448;
        Sat, 12 Aug 2023 11:26:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74c0:22ae:ddb5:1bed])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d6b09000000b0031759e6b43fsm9261083wrw.39.2023.08.12.11.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 11:26:29 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.5-rc6
Date:   Sat, 12 Aug 2023 20:26:25 +0200
Message-Id: <20230812182625.5059-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

Linus,

Please pull the following two one-liners from the GPIO subsystem for the
next RC.

Bartosz

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5-rc6

for you to fetch changes up to 33f83d13ded164cd49ce2a3bd2770115abc64e6f:

  gpio: ws16c48: Fix off-by-one error in WS16C48 resource region extent (2023-08-11 21:31:59 +0200)

----------------------------------------------------------------
gpio fixes for v6.5-rc6

- mark virtual chips exposed by gpio-sim as ones that can sleep (callbacks
  must not be called from interrupt context)
- fix an off-by-one error in gpio-ws16c48

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: sim: mark the GPIO chip as a one that can sleep

William Breathitt Gray (1):
      gpio: ws16c48: Fix off-by-one error in WS16C48 resource region extent

 drivers/gpio/gpio-sim.c     | 1 +
 drivers/gpio/gpio-ws16c48.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
