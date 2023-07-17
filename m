Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC82B75663F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjGQOWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGQOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:21:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32748C0;
        Mon, 17 Jul 2023 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689603712; x=1721139712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dlya23t5w/DWoWEhF+Gie3H8fOznZfDlCPsSfPRQCYI=;
  b=VIecBbYvKcYA3ZFodDfWmFoq9VBd/dTkguVOiQKDzSYN6iVg3PG7BtzG
   ZLcXtFJQhw+gGmPsNQB7D+T/3UaRpuPFuLTE/8kMgGHxgHGq7v4dqzN2a
   TjuCm8uiUM2Cl+gB9U58N3DtbMsw+PundVjtFp72EJOpbqWFupZpJ+B7w
   qKXYk7AYySmTnYrZfzIS+210R2ICYtGFwNDn8lY11XAHRFkcFX4gV1t6Q
   cXvRC3hTgFQ1MzDU4QJKSIVR/M8ziwCxyYSpdv9lH38VS/HbpYutxxw8X
   lDexDQd2RT6F6FtpGKPMQn53ZFo/Ncp846l0CF2qL2I6ZRzqz87VUi1ss
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432112889"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432112889"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="717257683"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="717257683"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2023 07:18:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D0C024F; Mon, 17 Jul 2023 17:18:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v2 2/3] gpio: bcm-kona: remove unneeded platform_set_drvdata() call
Date:   Mon, 17 Jul 2023 17:18:44 +0300
Message-Id: <20230717141845.41415-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717141845.41415-1-andriy.shevchenko@linux.intel.com>
References: <20230717141845.41415-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Coardos <aboutphysycs@gmail.com>

The platform_set_drvdata() call was never used, ever since the driver was
originally added.
It looks like this copy+paste left-over. Possibly the author copied from a
driver that had this line, but also had a remove hook.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/gpio/gpio-bcm-kona.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 0aa7d710509d..9af1549ee0df 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -591,7 +591,6 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	kona_gpio->pdev = pdev;
-	platform_set_drvdata(pdev, kona_gpio);
 	chip->parent = dev;
 	chip->ngpio = kona_gpio->num_bank * GPIO_PER_BANK;
 
-- 
2.40.0.1.gaa8946217a0b

