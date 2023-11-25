Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E57F8E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjKYUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKYUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:05:25 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A746127;
        Sat, 25 Nov 2023 12:05:30 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7ED3212000E;
        Sat, 25 Nov 2023 23:05:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7ED3212000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700942727;
        bh=1tkFCVxrpuSx/KtKj+sM5p4E0PBX09OKY9Yjr94V+/I=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=cF5nkyk+9kmo1JDYUKprRbDsuuoVDCvjqQhotffFLwYp9KADidMBjmdZKqF3+XPrR
         Vk8VkE7EcuRuquDQ6k3tV9E3a8m2sFg5Pr2Q2aSXCp7ZGU6J0FIFrjOK4Ut640ssPd
         U0Q+Xdn8gTjYlLxyR7lKgTB8VjDFIO6MXoMfqvaNEsriQ3rz3XV+LwBybl5wkJzTaz
         QuRkXjgzD4vDACglR2Sz2cV7KIotmfuXJ4zRlsrsxDg9qSMftVL07saIlmOCdHxn/b
         DR4MJlUg4cM/mj89k9CG3TAnW1Fx505TupQA6aU/R5IfFcz9nCJmP68tQjij2j/5Uh
         MBnoBVpCp6VsA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat, 25 Nov 2023 23:05:26 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 25 Nov 2023 23:05:26 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v5 00/11] leds: aw200xx: several driver updates
Date:   Sat, 25 Nov 2023 23:05:08 +0300
Message-ID: <20231125200519.1750-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181593 [Nov 25 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2;doc.awinic.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/25 18:50:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/25 18:50:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/25 18:32:00 #22537065
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch series includes several updates for the AW200XX LED
driver:
    - some small fixes and optimizations to the driver implementation:
      delays, autodimming calculation, disable_locking regmap flag,
      display_rows calculation in runtime;
    - fix LED device tree node pattern to accept LED names counting not
      only from 0 to f;
    - add missing reg constraints;
    - support HWEN hardware control, which allows enabling or disabling
      AW200XX RTL logic from the main SoC using a GPIO pin;
    - introduce the new AW20108 LED controller, the datasheet for this
      controller can be found at [1].

Changes v5 since v4 at [5]:
    - make several lowercase->uppercase renaming suggested by Lee Jones
    - change aw200xx_probe_get_display_rows() return value type from
      boolean to integer and propagate error return values to the
      dev_err_probe()
    - fix some grammar problems

Changes v4 since v3 at [4]:
    - properly handle max_source = 0 situations
    - fix Rob's dt_binding_check alerts

Changes v3 since v2 at [3]:
    - handle all cases during hwen gpio get routine execution
    - rename 'hwen-gpios' to standard 'enable-gpios'
    - properly handle aw200xx_probe_get_display_rows() ret values
    - fix timestamp format in the comments and commit messages
    - expand LEDS_AW200XX config and dt-bindings description
    - describe reg constraints for all compatible variants
    - add Conor's Acked-by tag

Changes v2 since v1 at [2]:
    - rebase on the latest aw200xx changes from lee/leds git repo
    - some commit messages rewording
    - replace legacy gpio_* API with gpiod_* and devm_gpiod_* API
    - rename dt property awinic,hwen-gpio to hwen-gpios according to
      gpiod API
    - use fsleep() instead of usleep_range() per Andy's suggestion
    - add max_brightness parameter to led cdev to restrict
      set_brightness() overflow
    - provide reg constraints as Rob suggested
    - move hwen-gpios to proper dt node in the bindings example

Links:
    [1] https://doc.awinic.com/doc/20230609wm/8a9a9ac8-1d8f-4e75-bf7a-67a04465c153.pdf
    [2] https://lore.kernel.org/all/20231006160437.15627-1-ddrokosov@salutedevices.com/
    [3] https://lore.kernel.org/all/20231018182943.18700-1-ddrokosov@salutedevices.com/
    [4] https://lore.kernel.org/all/20231101142445.8753-1-ddrokosov@salutedevices.com/
    [5] https://lore.kernel.org/all/20231121202835.28152-1-ddrokosov@salutedevices.com/

Dmitry Rokosov (3):
  leds: aw200xx: support HWEN hardware control
  dt-bindings: leds: aw200xx: introduce optional enable-gpios property
  dt-bindings: leds: aw200xx: fix led pattern and add reg constraints

George Stark (7):
  leds: aw200xx: calculate dts property display_rows in the driver
  dt-bindings: leds: aw200xx: remove property "awinic,display-rows"
  leds: aw200xx: add delay after software reset
  leds: aw200xx: enable disable_locking flag in regmap config
  leds: aw200xx: improve autodim calculation method
  leds: aw200xx: add support for aw20108 device
  dt-bindings: leds: awinic,aw200xx: add AW20108 device

Martin Kurbanov (1):
  leds: aw200xx: fix write to DIM parameter

 .../bindings/leds/awinic,aw200xx.yaml         | 95 +++++++++++++-----
 drivers/leds/Kconfig                          | 14 ++-
 drivers/leds/leds-aw200xx.c                   | 98 ++++++++++++++++---
 3 files changed, 163 insertions(+), 44 deletions(-)

-- 
2.36.0

