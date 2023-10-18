Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1817CE67F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbjJRSaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjJRS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:29:57 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFEC114;
        Wed, 18 Oct 2023 11:29:54 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id E710710000E;
        Wed, 18 Oct 2023 21:29:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E710710000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697653791;
        bh=o4WjMF9cDpCBd7iO2oIOLQ4idpExpZY5J5HB7OOIaDE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=j22d9lnIZ7hzA/2LZExfyxPL7kxadfImoK1ffu0UOiv3sGTPM62bxk3UA7t0dlwIy
         AHjuHWD9f9ZMr6OKUX9EbE70zxMSy1DOWapE/o0Jq0k7N7g8Uy9Wi1nMw69iQu4Z3Y
         jIjQh4BYLPK6cvj09AebkMmjiWDuzxnr4P7Qq7yVe3p6MwcuQ7gEJsmbcge/JX9ulw
         rd4+rMquyMxIum84qWg57/O3l3VkTuBfOzlf3Yl831XCh2NCegd7Wfp4cprBjir0km
         4riozg8G2eHY7GMASy+vuBewQl18fuZr0uSXs5ttMStk2am+E7Y/AZxUvpMAkj/XfH
         zyxoZXJLQ/zMg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 18 Oct 2023 21:29:51 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 21:29:51 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 00/11] leds: aw200xx: several driver updates
Date:   Wed, 18 Oct 2023 21:29:32 +0300
Message-ID: <20231018182943.18700-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180713 [Oct 18 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 541 541 6f62a06a82e8ec968d29b8e7c7bba6aeceb34f57, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;doc.awinic.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/18 16:37:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/18 16:37:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/18 17:21:00 #22224798
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Dmitry Rokosov (3):
  leds: aw200xx: support HWEN hardware control
  dt-bindings: leds: aw200xx: introduce optional hwen-gpios property
  dt-bindings: leds: aw200xx: fix led pattern and add reg constraints

George Stark (7):
  leds: aw200xx: calculate dts property display_rows in driver
  dt-bindings: leds: aw200xx: remove property "awinic,display-rows"
  leds: aw200xx: add delay after software reset
  leds: aw200xx: enable disable_locking flag in regmap config
  leds: aw200xx: improve autodim calculation method
  leds: aw200xx: add support for aw20108 device
  dt-bindings: leds: awinic,aw200xx: add AW20108 device

Martin Kurbanov (1):
  leds: aw200xx: fix write to DIM parameter

 .../bindings/leds/awinic,aw200xx.yaml         | 49 ++++------
 drivers/leds/Kconfig                          |  8 +-
 drivers/leds/leds-aw200xx.c                   | 96 +++++++++++++++----
 3 files changed, 102 insertions(+), 51 deletions(-)

-- 
2.36.0

