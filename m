Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A507BBC55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjJFQFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJFQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:05:01 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4009E;
        Fri,  6 Oct 2023 09:04:58 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 3C5F1120005;
        Fri,  6 Oct 2023 19:04:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3C5F1120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696608296;
        bh=DfYcgCrfsYVwE9QpzwJ60jTTS1sE6fpm4zxzMmEGexQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=CQgboBreTfYt6HRdIs5d/vVXZzekSHtnE3I/0+cFXIC2jQXeYT8SfRdinIiwmJXwX
         MMgXY95pwo/QxELSyO8yPbdRw+so5W06/zgku4XdOdgzrB9r1ARzfAIzmGcsqql0c3
         36T7XU+F3UuncDJTWMcO/jbnltFOCLJ+T8QSI0vZx/hdTRr4z4bUvpE6RMMrTdshGB
         rbMPI/xjvAF7nFhgOQv5nXlGiqKNtSgLygjELc7aG8WtA43ryjMoLzZb7VLixfloma
         1/wLu2wTSH0RGRXgmXUcN7XYTZdr3JDdQcXNQbxYKApLwQYlRT78gGVLGAxSeHd5m7
         BgcOQCNunT4+A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 19:04:55 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 19:04:55 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 00/11] leds: aw200xx: several driver updates
Date:   Fri, 6 Oct 2023 19:04:26 +0300
Message-ID: <20231006160437.15627-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180439 [Oct 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;doc.awinic.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/06 12:39:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/06 14:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/06 13:25:00 #22070343
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
    - support HWEN hardware control, which allows enabling or disabling
      AW200XX RTL logic from the main SoC using a GPIO pin;
    - introduce the new AW20108 LED controller, the datasheet for this
      controller can be found at [1].

Links:
    [1] https://doc.awinic.com/doc/20230609wm/8a9a9ac8-1d8f-4e75-bf7a-67a04465c153.pdf

Dmitry Rokosov (3):
  dt-bindings: leds: aw200xx: fix led dt node pattern
  leds: aw200xx: support HWEN hardware control
  dt-bindings: leds: aw200xx: introduce optional hwen-gpio property

George Stark (7):
  leds: aw200xx: calculate dts property display_rows in driver
  dt-bindings: leds: aw200xx: remove property "awinic,display-rows"
  leds: aw200xx: add delay after software reset
  leds: aw200xx: enable disable_locking flag in regmap config
  leds: aw200xx: improve autodim calculation method
  leds: aw200xx: add support for aw20108 device
  dt-bindings: leds: Add binding for AW20108 led driver

Martin Kurbanov (1):
  leds: aw200xx: fix write to DIM parameter

 .../bindings/leds/awinic,aw200xx.yaml         |  42 +++----
 drivers/leds/Kconfig                          |   8 +-
 drivers/leds/leds-aw200xx.c                   | 112 +++++++++++++++---
 3 files changed, 114 insertions(+), 48 deletions(-)

-- 
2.36.0

