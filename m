Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A227CC228
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjJQMEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjJQMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:04:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E1FEA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4060b623e64so35178695e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544288; x=1698149088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJwedQ+qAsjmKg5SPvTQtBPoLzFdvUdEImTrV9A/jAw=;
        b=wujH57ifgJPUNZOzn1l5f1bWZXaT8+VH8g0az6J6KZAR7I/DG/Ms48F+wG30ebwM5D
         5Z7Yb9QGxXyITn8/dzWFyg7EhNfCiUSxNhz68YqumXcbfgWO1ATsXz3V/0EuqRRpPbSi
         /tL/T29h5gFMWrK6E3DReLSUeyQYueSlKXXvBCDz6vqrHtwqRbuTM4GRAFhXOfgNuw+H
         ZvVef3bOtoatTwrA+OsiVeLAaVv4dj1OzEJ5Qlw1QwssOcCEAD+GPTkZ94AkgCEZFCFX
         bdmX0mDERfjMz5CJdzYmXc30oImXoS8bqwXCuBn2tJBPn6N3WnOEFKpMRGyvi1TSqh9c
         Ln6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544288; x=1698149088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJwedQ+qAsjmKg5SPvTQtBPoLzFdvUdEImTrV9A/jAw=;
        b=sHYB/waPdFxFvRcSClOVyV60UdnxphsWrgsBFYnbkcg+1RHlQ7CYN3n4V2XOgHKWJL
         snShQcLOMdaxk68c9JV3vr+AKJxVXTQjN7cEwZlHFAIvF/I/wITEynCX+ALC1BXPz6bZ
         QkNsQTNQA1cSw357NIoIoC1MvSJ8xtkelN0aX1ZvbMwAja++GX+IzxEq+g5+pctV3G1V
         Yb57uawH+qwhPG3DCZD6O71vcC4JsLfyHUjLVUn6JpnVyMNbHi8GhgvVUhwQLf5bU70r
         bs4OPv5OjqK1ZKD9UvcB+34A93NLjm2c96RBXKNLDllVvqKi+gGCDNeU/qNHOvxNL0Gn
         N9UQ==
X-Gm-Message-State: AOJu0Yz9iP2PzTpLZbJbs+IKyBzYHEvuXQXQPXE/kBOmKVYGJ1Uf8wt2
        FmH05PYcKZs/EKDvjnP28M8pxA==
X-Google-Smtp-Source: AGHT+IHP8U33hTuHeLg9hqrARExJ43RdgajdLRmvsZ6ZHgj4HLtLLToUehjtzplTA/b6KWP4d8k8aQ==
X-Received: by 2002:a05:600c:1c1c:b0:408:36bb:5b0c with SMTP id j28-20020a05600c1c1c00b0040836bb5b0cmr834730wms.7.1697544288056;
        Tue, 17 Oct 2023 05:04:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:04:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 00/73] pinctrl: don't use GPIOLIB global numberspace in helpers
Date:   Tue, 17 Oct 2023 14:03:18 +0200
Message-Id: <20231017120431.68847-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We have a set of pinctrl helpers for GPIOLIB drivers that take a number
from the global GPIO numberspace as argument. We are trying to get rid
of this global numbering. Let's rework these helpers to use the
recommended gpio_chip + controller-relative offset instead.

This work is split into phases: first let's introduce the new variants
of the helpers. Next: let's convert all users one-by-one for easier
review. After that let's remove the old helpers and rename the new
variants to take the place of the old ones. Finally convert static
functions in pinctrl/core.c to using the same signature and to top it
off, let's remove now redundant wrappers around the pinctrl_helpers.

This series introduces no functional changes in drivers so I decided to
not spam every single driver maintainer anymore.

As this is a big series and there already are conflicts between it and
current pinctrl tree, I plan on sending it as a separate PR later in the
merge window once the bulk of GPIO and pinctrl changes are already
in master.

v2 -> v3:
- split patches modifying multiple drivers at once into separate
  changesets
- fix build errors reported by autobuilders

v1 -> v2:
- drop the conversion to using cleanup.h helpers as this is not the
  subject of this series
- split the patch renaming the new variants to the old names into
  several patches that perform the operation step by step for easier
  review
- collect review tags and acks
- add follow-up patches that drop the wrappers around pinctrl helpers
  where applicable (where all the wrappers do is call the helper)
- fix build error with PINCTRL disabled

Bartosz Golaszewski (73):
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
  pinctrl: intel: cherryview: use new pinctrl GPIO helpers
  pinctrl: intel: use new pinctrl GPIO helpers
  pinctrl: intel: lynxpoint: use new pinctrl GPIO helpers
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
  pinctrl: intel: lynxpoint: drop the wrappers around
    pinctrl_gpio_direction_input()
  pinctrl: intel: drop the wrappers around
    pinctrl_gpio_direction_input()
  pinctrl: intel: cherryview: drop the wrappers around
    pinctrl_gpio_direction_input()
  pinctrl: st: drop the wrapper around pinctrl_gpio_direction_input()
  pinctrl: ingenic: drop the wrapper around
    pinctrl_gpio_direction_input()
  pinctrl: as3722: drop the wrapper around
    pinctrl_gpio_direction_input()
  pinctrl: cy8c95x0: drop the wrapper around
    pinctrl_gpio_direction_input()
  pinctrl: vt8500: drop the wrapper around
    pinctrl_gpio_direction_input()
  pinctrl: axp209: drop the wrapper around
    pinctrl_gpio_direction_input()
  pinctrl: rk805: drop the wrapper around pinctrl_gpio_direction_input()
  pinctrl: mediatek: moore: drop the wrappers around
    pinctrl_gpio_direction_input()
  pinctrl: mediatek: common: drop the wrappers around
    pinctrl_gpio_direction_input()
  pinctrl: cirrus: drop the wrapper around
    pinctrl_gpio_direction_input()
  pinctrl: ocelot: drop the wrapper around
    pinctrl_gpio_direction_input()
  pinctrl: starfive: jh7100: drop wrappers around
    pinctrl_gpio_request/free()
  pinctrl: starfive: jh7110: drop wrappers around
    pinctrl_gpio_request/free()
  pinctrl: stm32: drop wrappers around pinctrl_gpio_free/input()
  pinctrl: nuvoton: npcm7xx: drop wrappers around
    pinctrl_gpio_request/free()
  pinctrl: nuvoton: npcm8xx: drop wrappers around
    pinctrl_gpio_request/free()
  pinctrl: em: drop the wrapper around pinctrl_gpio_request()
  pinctrl: tegra: drop the wrapper around pinctrl_gpio_request()

 drivers/gpio/gpio-aspeed.c                    |   6 +-
 drivers/gpio/gpio-em.c                        |   9 +-
 drivers/gpio/gpio-mvebu.c                     |   4 +-
 drivers/gpio/gpio-pxa.c                       |   4 +-
 drivers/gpio/gpio-rcar.c                      |   4 +-
 drivers/gpio/gpio-rockchip.c                  |   4 +-
 drivers/gpio/gpio-tegra.c                     |  13 +-
 drivers/gpio/gpio-vf610.c                     |   4 +-
 drivers/gpio/gpiolib-cdev.c                   |   3 +-
 drivers/gpio/gpiolib.c                        |   6 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c      |   6 +-
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c      |   9 +-
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c    |   2 +-
 drivers/pinctrl/core.c                        | 133 ++++++++++--------
 drivers/pinctrl/intel/pinctrl-cherryview.c    |   9 +-
 drivers/pinctrl/intel/pinctrl-intel.c         |   9 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c     |   9 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c      |   9 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  10 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c      |   4 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     |  14 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c     |  13 +-
 drivers/pinctrl/pinctrl-as3722.c              |   9 +-
 drivers/pinctrl/pinctrl-axp209.c              |   7 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c            |   9 +-
 drivers/pinctrl/pinctrl-ingenic.c             |  19 ++-
 drivers/pinctrl/pinctrl-ocelot.c              |  10 +-
 drivers/pinctrl/pinctrl-rk805.c               |  10 +-
 drivers/pinctrl/pinctrl-st.c                  |  13 +-
 drivers/pinctrl/renesas/gpio.c                |   8 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |   4 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |   4 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c        |   8 +-
 .../starfive/pinctrl-starfive-jh7100.c        |  14 +-
 .../starfive/pinctrl-starfive-jh7110.c        |  14 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c         |  20 +--
 drivers/pinctrl/vt8500/pinctrl-wmt.c          |   9 +-
 include/linux/pinctrl/consumer.h              |  57 +++++---
 38 files changed, 196 insertions(+), 303 deletions(-)

-- 
2.39.2

