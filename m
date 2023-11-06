Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2A7E1D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjKFJOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjKFJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:14:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A00DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:14:42 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32fb190bf9bso2107526f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 01:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1699262081; x=1699866881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OeBpccf5OKaSPrgVE5n9RhsWMJEVqr+iwYoW7Ges/Y4=;
        b=FOmFufWRLO3A+Navb10hGHsX5OG8KcMWnZZbrqL8dHfYX8qhjf8rBMV/1obZFUCZnk
         L7ZPQ10i+kSV1TjMqbxh/vFRJ0liuB2BD0hzoE6YObwJEAtld9U6YVD12Ybic88oRoab
         T5PQnilLgLAZGitbZv9oC+7cKi4koGKjQLOicopjjfw21/fpT9/q9TJgkeWsCNFXKWGr
         BQdlq6rGWMd2x8hHRHqJE9c7hbGNdYvcRYEkrhxrBbjqaMaylAt5hedJzW2DxWtHvOk7
         x5uKZtf9wxm6Cpu87XjKaD3dg++kwt73pTxuBGlrSIUKp1MKz4FVliotbuy0tpmwNRbC
         y1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699262081; x=1699866881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeBpccf5OKaSPrgVE5n9RhsWMJEVqr+iwYoW7Ges/Y4=;
        b=hzGeD+RDEjyshszw+SI8c+YNv07QolyG98EFdluchPvljP8bmOHbqPBSGPRzQxf9bk
         e87j+GYxvOVi1zm3HWtU2prPy0vAiC1Dg4uB1zqHPp0L6QFWpRQXHugJwYfE6vREwUa/
         LI/Rd+UZAsJ4OgmYKZ1IBY4ZB7J3iyikHgfOCDJKxlFWPq6J+K9ZAgEP0+sHV4FDuqCu
         OxU24vAkYmRAQD/kyl6kzXvMa4bJ9SjrlqpiuPGHPBZkMMYsbC5Rs/kfqt0eCwGXOVX4
         oMyDzy952NLiZL1FNlc7wG8eJkAjba1pA7BRD2rnsg3rUUZy5hSzWHfzy8vDTj0wWBbq
         oU+Q==
X-Gm-Message-State: AOJu0YzvnfNKI6Q7DdNA8mvRzjFeS9yehCGCGzoFNbK9tpY4ZB9ayqOK
        N5w2gIFbzJX+4fsuZNTNiTgO0A==
X-Google-Smtp-Source: AGHT+IHS39QthKDo4lFzz6Q6gPf0mBOtFYaEPcSwNIAjdVkEDVdpxgJSqCcsQlvIS3SvmdA9NLBNYg==
X-Received: by 2002:a5d:6d06:0:b0:32f:83cf:8326 with SMTP id e6-20020a5d6d06000000b0032f83cf8326mr10467952wrq.24.1699262080817;
        Mon, 06 Nov 2023 01:14:40 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:9bc8:dd09:d1b:9114])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4fc2000000b00323287186aasm8917459wrw.32.2023.11.06.01.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 01:14:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio/pinctrl: updates for v6.7-rc1
Date:   Mon,  6 Nov 2023 10:14:36 +0100
Message-Id: <20231106091436.10946-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here's my second and final PR for this release cycle. The bulk of it is
a rework of the glue layer between pinctrl and GPIO. We changed the
signature of GPIO helpers for pinctrl to taking the gpio_chip/offset pair
as arguments instead of using the deprecated global GPIO numberspace. The
last little bit is removing the gpiochip_find() function as it has no more
users in-tree.

The reason for sending it separately were the conflicts between pinctrl
and GPIO that were too complex to carry in next.

This code has been rebased on top of current master once pinctrl changes
got it but it had been exposed to autobuilders during the release cycle
in my devel branch and got built in next just fine as well. There are also
no functional changes.

Please pull,
Bartosz

The following changes since commit 90b0c2b2edd1adff742c621e246562fbefa11b70:

  Merge tag 'pinctrl-v6.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2023-11-03 19:15:19 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-pinctrl-updates-for-v6.7-rc1

for you to fetch changes up to 5be55473a06475cc1128ccd93831ff57a068a81e:

  pinctrl: tegra: drop the wrapper around pinctrl_gpio_request() (2023-11-04 10:23:23 +0100)

----------------------------------------------------------------
gpio/pinctrl updates for v6.7-rc1

- rework the GPIO-to-pinctrl glue code to stop using the deprecated global
  GPIO numberspace
- remove now unused wrappers around pinctrl GPIO helpers from drivers
- remove gpiochip_find() as it has no more users

----------------------------------------------------------------
Bartosz Golaszewski (70):
      gpiolib: remove gpiochip_find()
      pinctrl: remove unneeded extern specifiers from consumer.h
      pinctrl: provide new GPIO-to-pinctrl glue helpers
      gpiolib: generic: use new pinctrl GPIO helpers
      gpio: cdev: use pinctrl_gpio_can_use_line_new()
      gpio: rcar: use new pinctrl GPIO helpers
      gpio: tegra: use new pinctrl GPIO helpers
      gpio: em: use new pinctrl GPIO helpers
      gpio: aspeed: use new pinctrl GPIO helpers
      gpio: mvebu: use new pinctrl GPIO helpers
      gpio: pxa: use new pinctrl GPIO helpers
      gpio: rockchip: use new pinctrl GPIO helpers
      gpio: vf610: use new pinctrl GPIO helpers
      pinctrl: nuvoton: npcm7xx: use new pinctrl GPIO helpers
      pinctrl: nuvoton: npcm8xx: use new pinctrl GPIO helpers
      pinctrl: renesas: use new pinctrl GPIO helpers
      pinctrl: bcm: use new pinctrl GPIO helpers
      pinctrl: stm32: use new pinctrl GPIO helpers
      pinctrl: spear: use new pinctrl GPIO helpers
      pinctrl: starfive: jh7100: use new pinctrl GPIO helpers
      pinctrl: starfive: jh7110: use new pinctrl GPIO helpers
      pinctrl: ocelot: use new pinctrl GPIO helpers
      pinctrl: rk805: use new pinctrl GPIO helpers
      pinctrl: cirrus: use new pinctrl GPIO helpers
      pinctrl: mediatek: moore: use new pinctrl GPIO helpers
      pinctrl: mediatek: common: use new pinctrl GPIO helpers
      pinctrl: mediatek: paris: use new pinctrl GPIO helpers
      pinctrl: axp209: use new pinctrl GPIO helpers
      pinctrl: vt8500: use new pinctrl GPIO helpers
      pinctrl: cy8c95x0: use new pinctrl GPIO helpers
      pinctrl: as3722: use new pinctrl GPIO helpers
      pinctrl: ingenic: use new pinctrl GPIO helpers
      pinctrl: cherryview: use new pinctrl GPIO helpers
      pinctrl: intel: use new pinctrl GPIO helpers
      pinctrl: lynxpoint: use new pinctrl GPIO helpers
      pinctrl: st: use new pinctrl GPIO helpers
      pinctrl: remove pinctrl_gpio_can_use_line()
      pinctrl: remove pinctrl_gpio_request()
      pinctrl: remove pinctrl_gpio_free()
      pinctrl: remove pinctrl_gpio_direction_input()
      pinctrl: remove pinctrl_gpio_direction_output()
      pinctrl: remove pinctrl_gpio_set_config()
      treewide: rename pinctrl_gpio_can_use_line_new()
      treewide: rename pinctrl_gpio_request_new()
      treewide: rename pinctrl_gpio_free_new()
      treewide: rename pinctrl_gpio_direction_input_new()
      treewide: rename pinctrl_gpio_direction_output_new()
      treewide: rename pinctrl_gpio_set_config_new()
      pinctrl: change the signature of pinctrl_gpio_direction()
      pinctrl: change the signature of pinctrl_get_device_gpio_range()
      pinctrl: change the signature of pinctrl_match_gpio_range()
      pinctrl: change the signature of gpio_to_pin()
      pinctrl: change the signature of pinctrl_ready_for_gpio_range()
      pinctrl: st: drop the wrapper around pinctrl_gpio_direction_input()
      pinctrl: ingenic: drop the wrapper around pinctrl_gpio_direction_input()
      pinctrl: as3722: drop the wrapper around pinctrl_gpio_direction_input()
      pinctrl: vt8500: drop the wrapper around pinctrl_gpio_direction_input()
      pinctrl: axp209: drop the wrapper around pinctrl_gpio_direction_input()
      pinctrl: rk805: drop the wrapper around pinctrl_gpio_direction_input()
      pinctrl: mediatek: moore: drop the wrappers around pinctrl_gpio_direction_input()
      pinctrl: mediatek: common: drop the wrappers around pinctrl_gpio_direction_input()
      pinctrl: cirrus: drop the wrapper around pinctrl_gpio_direction_input()
      pinctrl: ocelot: drop the wrapper around pinctrl_gpio_direction_input()
      pinctrl: starfive: jh7100: drop wrappers around pinctrl_gpio_request/free()
      pinctrl: starfive: jh7110: drop wrappers around pinctrl_gpio_request/free()
      pinctrl: stm32: drop wrappers around pinctrl_gpio_free/input()
      pinctrl: nuvoton: npcm7xx: drop wrappers around pinctrl_gpio_request/free()
      pinctrl: nuvoton: npcm8xx: drop wrappers around pinctrl_gpio_request/free()
      pinctrl: em: drop the wrapper around pinctrl_gpio_request()
      pinctrl: tegra: drop the wrapper around pinctrl_gpio_request()

 drivers/gpio/gpio-aspeed.c                         |   6 +-
 drivers/gpio/gpio-em.c                             |   9 +-
 drivers/gpio/gpio-mvebu.c                          |   4 +-
 drivers/gpio/gpio-pxa.c                            |   4 +-
 drivers/gpio/gpio-rcar.c                           |   4 +-
 drivers/gpio/gpio-rockchip.c                       |   4 +-
 drivers/gpio/gpio-tegra.c                          |  13 +-
 drivers/gpio/gpio-vf610.c                          |   4 +-
 drivers/gpio/gpiolib-cdev.c                        |   3 +-
 drivers/gpio/gpiolib.c                             |  28 +----
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |   6 +-
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c           |   9 +-
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c         |   2 +-
 drivers/pinctrl/core.c                             | 133 +++++++++++----------
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   4 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   4 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c          |   4 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c           |   9 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  10 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c           |   4 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |  14 +--
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c          |  13 +-
 drivers/pinctrl/pinctrl-as3722.c                   |   9 +-
 drivers/pinctrl/pinctrl-axp209.c                   |   7 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |   4 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |  19 ++-
 drivers/pinctrl/pinctrl-ocelot.c                   |  10 +-
 drivers/pinctrl/pinctrl-rk805.c                    |  10 +-
 drivers/pinctrl/pinctrl-st.c                       |  13 +-
 drivers/pinctrl/renesas/gpio.c                     |   8 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |   4 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            |   4 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c             |   8 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c |  14 +--
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c |  14 +--
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  20 +---
 drivers/pinctrl/vt8500/pinctrl-wmt.c               |   9 +-
 include/linux/gpio/driver.h                        |   3 -
 include/linux/pinctrl/consumer.h                   |  57 +++++----
 39 files changed, 196 insertions(+), 308 deletions(-)
