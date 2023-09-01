Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2AD78FE69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349784AbjIANkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjIANkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F27E77;
        Fri,  1 Sep 2023 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575648; x=1725111648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YM6VolMq4j0Tz9WOWCpxMyapirzvCFmEiZiMxNSvb8Y=;
  b=a99cW9lCkd34/n/NX2Jh3ktZRaGxphuNTPNekCT3M4Oox5yKBDCABjkN
   ySPkbQgx52WqUdcCx50UhA/ic6P9LFOwEnLc6nZAvK60YXTzewqGbX6cX
   E3iGGrdeCLGeF+cj8tF/+gWCGmu+QotwW7EsbeTEnXW0GcIHZkpIMjNkF
   adqcKMj7DP1zpYoPcYlUUj1bPPA74GbxVzzQnXmT8eoFGPZ02Pk/5Oezf
   gvooAvcXYhLcNaWPav+GDEvohM/iMDcDRweOzQV4cnfeiUmr3V49f4und
   RpU9d0s54RKoXwuGsVE8p6UaOZ4n2qrkJh5VUqd6+iQTPmehuXE/Pazqg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366447070"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="366447070"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070754507"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="1070754507"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2023 06:40:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1B82E76A; Fri,  1 Sep 2023 16:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 03/10] gpio: pca953x: Utilise dev_err_probe() where it makes sense
Date:   Fri,  1 Sep 2023 16:40:34 +0300
Message-Id: <20230901134041.1165562-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least in pca953x_irq_setup() we may use dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 0dedb2265744..4249ec350ace 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -926,6 +926,7 @@ static irqreturn_t pca953x_irq_handler(int irq, void *devid)
 static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 {
 	struct i2c_client *client = chip->client;
+	struct device *dev = &client->dev;
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	DECLARE_BITMAP(irq_stat, MAX_LINE);
 	struct gpio_irq_chip *girq;
@@ -974,11 +975,8 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 					NULL, pca953x_irq_handler,
 					IRQF_ONESHOT | IRQF_SHARED,
 					dev_name(&client->dev), chip);
-	if (ret) {
-		dev_err(&client->dev, "failed to request irq %d\n",
-			client->irq);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, client->irq, "failed to request irq\n");
 
 	return 0;
 }
-- 
2.40.0.1.gaa8946217a0b

