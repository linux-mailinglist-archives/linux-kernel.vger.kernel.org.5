Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30217788416
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbjHYJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbjHYJxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:53:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717A2106;
        Fri, 25 Aug 2023 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692957183; x=1724493183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TPQF3Wxbk/74CzPmTQm+rUHXfMqpNqNTCji2x+nMYHk=;
  b=ed9oTmEfvDagYPCOcFwxQhGBY422bKLOmvR+PrRnI+ejD9i5XOvbwPei
   ipqZEEZglpVvqPq2WGeEzFfyoqOMPE3kwrxv2MyEEdtF+SaqPPna6WAef
   szRQR8b6v5O2iCg+2/JXfTIsrg+yE/mTx6rsFMPAinh8ZkJ3qcNrmySYm
   pxh1IdmTB0lDlPynHMXj9YldTzz3yIExcmr/QfHAMzWDTzBHD6s/ZgeX6
   8RDC1x+7jC9eQN9h84xc+Ezam+hPSDrpHaDcQh4/tiJndfL4EMXyXl3sS
   zJq12qi1kkB0SEoU1NeSwgNOOrGCtEeNkTtcCCfqhukS21hZMujLVEd1B
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1291908"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2023 02:53:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 25 Aug 2023 02:52:29 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 25 Aug 2023 02:52:24 -0700
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
Subject: [PATCH v6 0/3] mmc: atmel-mci: Convert to gpio descriptors
Date:   Fri, 25 Aug 2023 15:21:54 +0530
Message-ID: <20230825095157.76073-1-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6:
- 0001-mmc-atmel-mci-Convert-to-gpio-descriptors.patch
  Remove code duplication while checking if the device is compatible with
  atmel,hsmci
- Add Suggested-by tag

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

 drivers/gpio/gpiolib-of.c    |  20 +++++-
 drivers/mmc/host/atmel-mci.c | 133 +++++++++++++++++++++--------------
 include/linux/atmel-mci.h    |  46 ------------
 3 files changed, 100 insertions(+), 99 deletions(-)
 delete mode 100644 include/linux/atmel-mci.h

-- 
2.25.1

