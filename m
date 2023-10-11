Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE167C52EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbjJKMJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjJKMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:09 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3E91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:06 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50307acd445so8601137e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026144; x=1697630944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7hklBZsNUaG4w8NR6EldB110zRSHG31vQIP+c27WSA=;
        b=v2Whm0Nq6Nfo+xKLDly8l+wvAeolEN/Dg6S33FmSW+QX6HAhMsUxDYQ5htWl5avXTO
         v2w12Q4CUC3kBm8WNWOIzS8wfTkBJKgE8/fuP17TKf+Qy2GLUOnuCmA+tfA+ENDB8iW+
         uYIt7+N1im1wSl2Umb2BjXrPKMHYfOwagI6LtC5wLyVZ+LmbHsBNj6wUuKu6UebP4JyV
         aD+tHSm+vWqZG2PjkN1TNfgVr48gAygYtrIWAWC40cBA9MXKHYuDHOHUQ60liQsIY052
         CasrA+vd1jNESm14pChh9coKvd/SNk3z6Bjq+COhsip6kBY4EIqOcS0/ao07zqEdJX3A
         IHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026144; x=1697630944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7hklBZsNUaG4w8NR6EldB110zRSHG31vQIP+c27WSA=;
        b=LNBWQ52eU1UxgFkjScURWJsJhHXGFyMhtkJ/bkosvzE2YSaSesAOuHGwgxV6lzCSEi
         754hIe6GStymJg0iCPAUtOJq6d6lIDYOu+jaspysSEZmMk2wWIl/3lPo/8kcNvZ4/lfG
         oReY0nnNlh8SDRhr1EX2zap/7gxa2BbHrR/vJDdu9hJUh0NoA/DmPJpk8cV8Sjquk+CA
         KaPTd58U5JYvRyXzHbI9Pk5hfmds258pdUN/xiGiutXgJa5eFiWsF4y8Q8suLDbE/1Ff
         DfeT4mz+2dje0cUs3bMzpBWVNOOdIszPhZCh4irsVYnWEdw46eqqh8ybH8BjxnyFfpDY
         J+pw==
X-Gm-Message-State: AOJu0YyuIlkZI6KsHEAJoCYBNRAdkCzv9l0kYN96RLpe/MU6445Qm1A3
        jP2/nooZ1tT9780uc7VwPVx8wg==
X-Google-Smtp-Source: AGHT+IE55mnDCRBWjAc+waFgWdvFtUrCBIF1JvrD2azH+1LOTtl1ams0eV2x0EFKmmu1hFjnsjeAyQ==
X-Received: by 2002:a05:6512:3711:b0:503:522:9ca5 with SMTP id z17-20020a056512371100b0050305229ca5mr15991991lfr.27.1697026144482;
        Wed, 11 Oct 2023 05:09:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 00/62] pinctrl: don't use GPIOLIB global numberspace in helpers
Date:   Wed, 11 Oct 2023 14:07:28 +0200
Message-Id: <20231011120830.49324-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Bartosz Golaszewski (62):
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
  pinctrl: nuvoton: use new pinctrl GPIO helpers
  pinctrl: renesas: use new pinctrl GPIO helpers
  pinctrl: bcm: use new pinctrl GPIO helpers
  pinctrl: stm32: use new pinctrl GPIO helpers
  pinctrl: spear: use new pinctrl GPIO helpers
  pinctrl: starfive: use new pinctrl GPIO helpers
  pinctrl: ocelot: use new pinctrl GPIO helpers
  pinctrl: rk805: use new pinctrl GPIO helpers
  pinctrl: cirrus: use new pinctrl GPIO helpers
  pinctrl: mediatek: use new pinctrl GPIO helpers
  pinctrl: axp209: use new pinctrl GPIO helpers
  pinctrl: vt8500: use new pinctrl GPIO helpers
  pinctrl: cy8c95x0: use new pinctrl GPIO helpers
  pinctrl: as3722: use new pinctrl GPIO helpers
  pinctrl: ingenic: use new pinctrl GPIO helpers
  pinctrl: intel: use new pinctrl GPIO helpers
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
  pinctrl: intel: drop the wrappers around
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
  pinctrl: mediatek: drop the wrappers around
    pinctrl_gpio_direction_input()
  pinctrl: cirrus: drop the wrapper around
    pinctrl_gpio_direction_input()
  pinctrl: ocelot: drop the wrapper around
    pinctrl_gpio_direction_input()
  pinctrl: starfive: drop wrappers around pinctrl_gpio_request/free()
  pinctrl: stm32: drop wrappers around pinctrl_gpio_free/input()
  pinctrl: nuvoton: drop wrappers around pinctrl_gpio_request/free()
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
 drivers/pinctrl/pinctrl-st.c                  |  11 +-
 drivers/pinctrl/renesas/gpio.c                |   8 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |   4 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |   4 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c        |   8 +-
 .../starfive/pinctrl-starfive-jh7100.c        |  14 +-
 .../starfive/pinctrl-starfive-jh7110.c        |  14 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c         |  20 +--
 drivers/pinctrl/vt8500/pinctrl-wmt.c          |   9 +-
 include/linux/pinctrl/consumer.h              |  74 +++++++---
 38 files changed, 218 insertions(+), 296 deletions(-)

-- 
2.39.2

