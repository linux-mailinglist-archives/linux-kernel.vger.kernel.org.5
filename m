Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE07D1EF7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjJUSjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJUSjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:39:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AFD114
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:39:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4084de32db5so16290895e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697913572; x=1698518372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfGwds8BsJ5PS79wIoZ/UmBsuPKrEgJUS23OzoLXe80=;
        b=D9Up9mqAi5emQb9WfQ2bjyYKukvPNQf35kYkZQrlIF606oNTJsZlHYr9ucAoTLllY/
         7+ukNJKMTMNyZZsDZztoKjpjMjyVQVSHKLxhgrHe+nfTlj9NwBDDwe46osDHFVaynZHr
         3hcvaB10AcATLvOvVdfuTPppn6oOWw5V220dmYCmKVTLwpBAa1dbYiQLVmjAskegFUzs
         vhL3u7tCLfQUHQ2+pwiIMduiAZNvwwdJ3VxN09QNCsrD8Jqh7CURvXgi6jHDC8u6lPgQ
         h9YvO0Uf/gbkRsJ122TTYZLhWRPYfu58g1aDJHObLWV6XWUHwMKQ0SLYcb7YiA4GkjnG
         fXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697913572; x=1698518372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfGwds8BsJ5PS79wIoZ/UmBsuPKrEgJUS23OzoLXe80=;
        b=O5d1XZr9Z/N+6r+rjwZ98j5aath3101J/C2zCbjWV6gFZWzWpZ5DCSwEBcewUjmFym
         mlpfmgRlcwY+EARSXqzkQ4WRD3qaFYCBp3iHJUgWVgcr2XSl2aEJkMgKKNvZuJNEgRBi
         RQhd36r+sBfUOBmmvSOyasXbNpLLVxrTUAn8PGPkhJPUKOYoHltU+ct3cJ8HmNNgoFer
         AeVKj0DbA8s91To8MsZVmzDgQTLVZ/BxicZPAURqBRiYu+G5ZInNpPaD7cHZX5/DnbGd
         fdniBQdRjD6cWeEcljatxLAR3ALodxf37xBpjfuj4bpzS8ZA9WOyIcKyuIpNPbIL/lf+
         Y1Iw==
X-Gm-Message-State: AOJu0YxNDDkppQ2RZ4DsIu8mBQmSWRdyKXqoSjwpwsE6gAIjauQmokZP
        KnRK2gB48+c/SqLPdx/Fr42JGg==
X-Google-Smtp-Source: AGHT+IEjtdIzNkB/XQ5MDi3/Kzobl1YTvyUkztdro7kWjlQ437ArdxwEWadc99lGzJSV/IMw9IZ9Hw==
X-Received: by 2002:a05:600c:3582:b0:408:3804:2a20 with SMTP id p2-20020a05600c358200b0040838042a20mr3912263wmq.22.1697913571848;
        Sat, 21 Oct 2023 11:39:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:9c03:2672:ef7a:46a5])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bca50000000b00405d9a950a2sm9764601wml.28.2023.10.21.11.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 11:39:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.6-rc7
Date:   Sat, 21 Oct 2023 20:39:25 +0200
Message-Id: <20231021183925.22831-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

Linus,

Please pull another round of fixes from the GPIO subsystem for the next
RC. There are two fixes for one of the drivers and a one-liner for ACPI
handling. Details are in the signed tag.

Bartosz

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.6-rc7

for you to fetch changes up to 479ac419206b5fe4ce4e40de61ac3210a36711aa:

  gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data() (2023-10-20 11:24:16 +0200)

----------------------------------------------------------------
gpio fixes for v6.6-rc7

- fix interrupt handling in suspend and wakeup in gpio-vf610
- fix a bug on setting direction to output in gpio-vf610
- add a missing memset() in gpio ACPI code

----------------------------------------------------------------
Andy Shevchenko (1):
      gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()

Haibo Chen (2):
      gpio: vf610: mask the gpio irq in system suspend and support wakeup
      gpio: vf610: set value before the direction to avoid a glitch

 drivers/gpio/gpio-vf610.c   | 15 ++++++++-------
 drivers/gpio/gpiolib-acpi.c |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)
