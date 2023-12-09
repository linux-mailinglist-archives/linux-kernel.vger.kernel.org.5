Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AC080B61E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjLITdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 14:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLITdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 14:33:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE184C2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 11:33:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3360be874d4so1494798f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 11:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702150403; x=1702755203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ax+CPYD5K6wJgz6USaugtPEpPJWFUdkJAyYQN6dMMgM=;
        b=f8MhGJ799saqtLyJd5olrI9yl10hVHKqa69thfkv6M7pafTfHUnD/V9wNEMt8Gq1Ir
         X0BrPjWBUZ7Ga3eZaIhQSOZLTjG8++MrPU/5pq18WDEfdn/YlIzRy5xQZpA4ir2GabfL
         hz3S7GK2rP4tlRsDFfYKZ4S1JyVIrhWvlDw8PH1pmnd2Fg6cfgCg+2qgqjJchtumuKyN
         fJNR8KfOK+xbdl/9yxnaAesHdEmSwnndborAp/9rdS0xzk17XN3tOq16eSvSJIUHVKmr
         0UHap2bNFkSb7QAZcJHfH5NG1frpjfFKQKZad3Hd+XCPYGn9Uid1aSAyNJHvGimnj8GK
         4Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702150403; x=1702755203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ax+CPYD5K6wJgz6USaugtPEpPJWFUdkJAyYQN6dMMgM=;
        b=s9VlSiWkbIr964xI+u+T3IirKnUcc8nicxvNfukSOM5I0xzgQ46C8N/+ecjODYcwWA
         FsJxdk/T3iFyDlU3ZXuM0Nx3EGMUAM+KbeLCYAB4OMXdDBE28oEgKxxbtu2w7omWD1+C
         BMeQrCuVdPpN/dDqmmhKWYfio7WdiaPvC/t9wDDPF4WaAxsg9fLIQqxmXoWdZyQtNDJ8
         c0xAU8AhZKsk7VcBQgpoyzQ18RTJgX5xlCqDdaV+ZFLRL24CivFYfi+1aEy9C83vljWk
         +tXU9pB2RelAD0mKGQBe27YbNbKoZ4Dq6qsqFCNVwTVhLAUlRcfbyQpZwe/iC5eqi8WR
         +Dsw==
X-Gm-Message-State: AOJu0Yw1QQvq6Ylv7PdXs0oJKtsMcO5TnU+31AqJerSmbLVJA1BPiVyu
        P3EHA/lPoA9Z+VZgArKb4IUX+/mAV5rpHPPxUzk=
X-Google-Smtp-Source: AGHT+IFkfgyL7bQt7RSB1bDm6so44YpOdEBhAMoQy7baymUbWWbwUaoFuYE9l9kDKb8M742mNtnMEQ==
X-Received: by 2002:a05:6000:194d:b0:333:e8d:99d8 with SMTP id e13-20020a056000194d00b003330e8d99d8mr1008539wry.36.1702150403043;
        Sat, 09 Dec 2023 11:33:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e0c5:4b67:54c0:c971])
        by smtp.gmail.com with ESMTPSA id l16-20020adff490000000b0033343b1ec1asm4926726wro.26.2023.12.09.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 11:33:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.7-rc5
Date:   Sat,  9 Dec 2023 20:33:19 +0100
Message-Id: <20231209193319.6993-1-brgl@bgdev.pl>
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

Linus,

Please pull the following fix for the next RC from the GPIO subsystem.

Thanks,
Bartosz

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.7-rc5

for you to fetch changes up to 95dd1e34ff5bbee93a28ff3947eceaf6de811b1a:

  gpiolib: sysfs: Fix error handling on failed export (2023-12-01 10:44:48 +0100)

----------------------------------------------------------------
gpio fixes for v6.7-rc5

- fix an error path after a failed export in sysfs code

----------------------------------------------------------------
Boerge Struempfel (1):
      gpiolib: sysfs: Fix error handling on failed export

 drivers/gpio/gpiolib-sysfs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)
