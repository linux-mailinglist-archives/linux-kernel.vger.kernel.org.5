Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941637CAE92
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjJPQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjJPQKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:10:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360C0F2;
        Mon, 16 Oct 2023 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697472631; x=1729008631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cvuQMHb9LmDrcSq69UbNf/WifWB3BY+q2NCKjOo91RU=;
  b=W6o2Y3WaRlIsFT6xoLxifGUMMYeyxfKpJa4G3qLa9mSLWzmIJKhliTLR
   DXjkkv2kCRGL3GVo27lNzxQ/DUdpzYV6T5kvqWMTcWX5/a+DKz68rbihZ
   CEMyUn0+AmWTe3kxlARJ17mnsQRyWVhayftDVYkkmKoYG7vobw9iFWRNZ
   Jli2hy/O/PVdADyPjR4kQf4axnm8Pet4CkwyCzrcLvllqTtqs1UqJRSUm
   HUgHGYvl1I7aZnhKxgI7qRwOcVd8yrCDX7YwMYoqCpMZ4nDjpb419aZZL
   DVfazt2N05Gw8OhlFpIBbWtrz/cUexMVsDCHBCKzmWV19s83hOH29WdVy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="7132785"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7132785"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785123038"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="785123038"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2023 09:10:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0A927385; Mon, 16 Oct 2023 19:10:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 2/6] leds: gpio: Utilise PTR_ERR_OR_ZERO()
Date:   Mon, 16 Oct 2023 19:10:01 +0300
Message-Id: <20231016161005.1471768-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
References: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a boilerplate code by using PTR_ERR_OR_ZERO() in create_gpio_led().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-gpio.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index debadb48ceda..4071cb9eefec 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -125,16 +125,13 @@ static int create_gpio_led(const struct gpio_led *template,
 		return ret;
 
 	pinctrl = devm_pinctrl_get_select_default(led_dat->cdev.dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		if (ret != -ENODEV) {
-			dev_warn(led_dat->cdev.dev,
-				 "Failed to select %pfw pinctrl: %d\n",
-				 fwnode, ret);
-		} else {
-			/* pinctrl-%d not present, not an error */
-			ret = 0;
-		}
+	ret = PTR_ERR_OR_ZERO(pinctrl);
+	/* pinctrl-%d not present, not an error */
+	if (ret == -ENODEV)
+		ret = 0;
+	if (ret) {
+		dev_warn(led_dat->cdev.dev, "Failed to select %pfw pinctrl: %d\n",
+			 fwnode, ret);
 	}
 
 	return ret;
-- 
2.40.0.1.gaa8946217a0b

