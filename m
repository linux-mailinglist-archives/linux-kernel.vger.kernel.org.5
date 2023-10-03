Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A773C7B6C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbjJCOvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbjJCOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:51:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC9EA1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406589e5765so10043045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344682; x=1696949482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/W8eJ+0Pcb//fcKPN1AN7H3u5QuqVTPS8j+U5FCs0E=;
        b=xTgdsRPKiUj1fZecW5rG+L9OGQjI0oZMeV+jiKBC3Wz0ncQXoEJ6E3bFtOTWkawFxi
         hdfSZTBcDqfbc/tmNsMN/eqnOZ+TlvjBAwB4GlZ3GnGQlHdsHiqip5V8QgQ8GRpTcaEB
         QyLFO7e11Q0K3yQ2j3jaxcxGGOex4uHtbCme4d/67wrid4e1yaZgr3s7qY6k317a/MsT
         IpptLibe76ZjD3jsnZmS8PGIJ0Mfwml2Dkz8+sunvYkp9Bwq8fMjlRX5wkyTb+f+oLbC
         ijqpT00400SwtBrSrA5+Q9cGhEdxDjrE9zO0Zhh9enrRgBtL3B6mMAVFey6z/OVOTYpj
         XZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344682; x=1696949482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/W8eJ+0Pcb//fcKPN1AN7H3u5QuqVTPS8j+U5FCs0E=;
        b=ShRaHfd7LopPcKNCu1vw2ig6N9yf7HZS7tfJQrg5LWQGgXTi4zKEU6nPntcVVNoFKS
         6fcE1ECQfCWap7KGYRX+o/HgorPUp5ExoOjbHB6rSRiAHzEEEr6sk04C7xNjunzAkALT
         l0I23W1A0xN0Bftzv0Ujtv4ovaaLbC9NXH0JZ7Z+4E1d3KOFkYwJfXq09SqGMGgYpBxy
         YL8rIEHzDGih5whQHH8r7W35rJPmPmg8nPRO4Mo0sDEFVmKYJQq9EN/27tr/q89x8V8u
         zkukg5I0HHIN0tPLw/4i/bpMt+E8WEyPv8dSTSKgFoRayUCK9iPLYrKi2qdYa8LmNg1+
         WUzQ==
X-Gm-Message-State: AOJu0YzsdfBn2ezdRdbwWltL1/d12iWdOOiT8g87bXnU7hqIlbKcAv75
        1xYjr+isNL2Xoo9DGedEMHPG2w==
X-Google-Smtp-Source: AGHT+IFy2Vv4LFP1Wf6d2Z1prL3WxLofH2xAoHM5lnZKRi17zCgvjazkNIxOqlAXivnRdYWkep5XCQ==
X-Received: by 2002:a05:600c:28f:b0:402:bcac:5773 with SMTP id 15-20020a05600c028f00b00402bcac5773mr13873968wmk.38.1696344681738;
        Tue, 03 Oct 2023 07:51:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 00/36] pinctrl: don't use GPIOLIB global numberspace in helpers
Date:   Tue,  3 Oct 2023 16:50:38 +0200
Message-Id: <20231003145114.21637-1-brgl@bgdev.pl>
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

We have a set of pinctrl helpers for GPIOLIB drivers that take a number
from the global GPIO numberspace as argument. We are trying to get rid
of this global numbering. Let's rework these helpers to use the
recommended gpio_chip + controller-relative offset instead.

This work is split into phases: first let's introduce the new variants
of the helpers. Next: let's convert all users one-by-one for easier
review. Finally let's remove the old helpers and rename the new variants
to take the place of the old ones.

Bartosz Golaszewski (36):
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
  pinctrl: remove old GPIO helpers
  treewide: rename pinctrl_gpio_can_use_line_new()
  treewide: rename pinctrl_gpio_request_new()
  treewide: rename pinctrl_gpio_free_new()
  treewide: rename pinctrl_gpio_direction_input_new()
  treewide: rename pinctrl_gpio_direction_output_new()
  treewide: rename pinctrl_gpio_set_config_new()

 drivers/gpio/gpio-aspeed.c                    |   6 +-
 drivers/gpio/gpio-em.c                        |   4 +-
 drivers/gpio/gpio-mvebu.c                     |   4 +-
 drivers/gpio/gpio-pxa.c                       |   4 +-
 drivers/gpio/gpio-rcar.c                      |   4 +-
 drivers/gpio/gpio-rockchip.c                  |   4 +-
 drivers/gpio/gpio-tegra.c                     |   8 +-
 drivers/gpio/gpio-vf610.c                     |   4 +-
 drivers/gpio/gpiolib-cdev.c                   |   3 +-
 drivers/gpio/gpiolib.c                        |   6 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c      |   6 +-
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c      |   4 +-
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c    |   2 +-
 drivers/pinctrl/core.c                        | 182 +++++++++---------
 drivers/pinctrl/intel/pinctrl-cherryview.c    |   4 +-
 drivers/pinctrl/intel/pinctrl-intel.c         |   4 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c     |   4 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c      |   4 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   4 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c      |   4 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     |   8 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c     |   8 +-
 drivers/pinctrl/pinctrl-as3722.c              |   4 +-
 drivers/pinctrl/pinctrl-axp209.c              |   2 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c            |   4 +-
 drivers/pinctrl/pinctrl-ingenic.c             |  11 +-
 drivers/pinctrl/pinctrl-ocelot.c              |   4 +-
 drivers/pinctrl/pinctrl-rk805.c               |   4 +-
 drivers/pinctrl/pinctrl-st.c                  |   4 +-
 drivers/pinctrl/renesas/gpio.c                |   8 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |   4 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |   4 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c        |   8 +-
 .../starfive/pinctrl-starfive-jh7100.c        |   4 +-
 .../starfive/pinctrl-starfive-jh7110.c        |   4 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c         |   8 +-
 drivers/pinctrl/vt8500/pinctrl-wmt.c          |   4 +-
 include/linux/pinctrl/consumer.h              |  57 +++---
 38 files changed, 210 insertions(+), 205 deletions(-)

-- 
2.39.2

