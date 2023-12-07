Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7770808642
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjLGKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjLGKH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:07:56 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCB8193;
        Thu,  7 Dec 2023 02:08:02 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B7A7mB32077970, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B7A7mB32077970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 18:07:48 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 7 Dec 2023 18:07:48 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 7 Dec 2023 18:07:48 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Thu, 7 Dec 2023 18:07:48 +0800
From:   TY Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, TY Chang <tychang@realtek.com>
Subject: [PATCH v3 0/2] Add gpio driver support for Realtek DHC SoCs
Date:   Thu, 7 Dec 2023 18:07:21 +0800
Message-ID: <20231207100723.15015-1-tychang@realtek.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add the bindings and the gpio driver for Realtek
DHC(Digital Home Center) RTD SoCs, including RTD1295, RTD1395,
RTD1619, RTD1319, RTD1619B, RTD1319D and RTD1315E.

Change log:
v2->v3:
1. Remove generic compatible and use SoC-specific compatible instead.
2. Add the missing descriptions for the rtd_gpio_info structure members.
3. Assign gpio_chip fwnode.
v1->v2:
1. Add description for DHC RTD SoCs in the bindings.
2. Revise the compatible names in the bindings.
3. Transitioned from OF API to platform_device API.
4. Use u8 for the offset array within the rtd_gpio_info structure.
5. Record the size of each array within the rtd_gpio_info structure and
   implement checks to prevent out-of-bounds access.
6. Use GPIOLIB_IRQCHIP helpers to register interrupts.
7. Use dynamic allocation for GPIO base.

Tzuyi Chang (2):
  dt-bindings: gpio: realtek: Add realtek,rtd-gpio
  Add GPIO support for Realtek DHC(Digital Home Center) RTD SoCs.

 .../bindings/gpio/realtek,rtd-gpio.yaml       |  69 ++
 drivers/gpio/Kconfig                          |   9 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-rtd.c                       | 748 ++++++++++++++++++
 4 files changed, 827 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
 create mode 100644 drivers/gpio/gpio-rtd.c

-- 
2.43.0

