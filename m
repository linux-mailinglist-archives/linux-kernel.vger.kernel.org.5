Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49178558E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjHWKkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjHWKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:40:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C49111F;
        Wed, 23 Aug 2023 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692787233; x=1724323233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BT70sNujtMKgc6xs08Sbs3FPM36lphKrmvSphUxZujk=;
  b=ZDEb0/UWELjbRBz/FPYGER6bQ5wAd2D888wd+36FEpkUNLiIJC8JOABV
   8FbxF2GLedVk9j9R3vwyA/bsrVuNcIQzGJE0cFqngqBVNQxHAVibiCea7
   pnuPX+e3jSxL+nOBoVXlzEVVW3vfuDnEsxQNeWiIbQ5/ToH2tPVZwnxXj
   y71ZFAdrmkda8EIyKRNO6w5Su4U5pXYpN6H+rhua5On2vkY4G0zrP78fg
   l34W6fJvBrSJKk5FAZ0+oWOw/4StULFmJSm8TAMpyCeOMhKrIjl5aeioW
   AnSeg3q9SmCAprBIKUqAnvEbnAWnk8x5kZrHcPzcQlTLoVyJyWrTgwCRY
   g==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="869464"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2023 03:40:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 23 Aug 2023 03:40:33 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 23 Aug 2023 03:40:27 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <linus.walleij@linaro.org>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <hari.prasathge@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v5 0/3] mmc: atmel-mci: Convert to gpio descriptors
Date:   Wed, 23 Aug 2023 16:10:07 +0530
Message-ID: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace legacy gpio apis with gpio descriptors. Handle card detection gpio
polarity in gpiolib

v5:
- Rebase to latest next branch of
  https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
- Move handling active_high inversion logic to gpiolib instead of reading
  the raw value of gpio and inverting it manually.
- Use PTR_ERR_OR_ZERO instead of IS_ERR. To avoid ignoring valid errors as
  suggested by Dmitry Torokhov
- Use gpiod_get_value_cansleep() instead of gpiod_get_value()

v4:
- Rebase on top of next branch
  https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git 

v3:
- [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
  Convert devm_gpiod_get_from_of_node() into devm_fwnode_gpiod_get()

v2:
- [PATCH 1/2] mmc: atmel-mci: Convert to gpio descriptors
  Remove "#include <linux/gpio.h>" as it is not necessary
- [PATCH 2/2] mmc: atmel-mci: move atmel MCI header file
  Move linux/atmel-mci.h into drivers/mmc/host/atmel-mci.c as it is
  used only by one file


Balamanikandan Gunasundar (3):
  mmc: atmel-mci: Convert to gpio descriptors
  mmc: atmel-mci: move atmel MCI header file
  mmc: atmel-mci: Move card detect gpio polarity quirk to gpiolib

 drivers/gpio/gpiolib-of.c    |   7 ++
 drivers/mmc/host/atmel-mci.c | 133 +++++++++++++++++++++--------------
 include/linux/atmel-mci.h    |  46 ------------
 3 files changed, 89 insertions(+), 97 deletions(-)
 delete mode 100644 include/linux/atmel-mci.h

-- 
2.25.1

