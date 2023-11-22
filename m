Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678DF7F4EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjKVRvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjKVRvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:51:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025E21AB;
        Wed, 22 Nov 2023 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700675458; x=1732211458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/qL736vnfHe+cuwyIG35u574xUK66chgtqXG6L/DWM=;
  b=EQCpoVnFZt+hoURu5o7bbZ1CQg9s8YQwydSC0rVpyl9Xx22gYdGQdKCg
   B+HKcJFQ5EeRcGMLrqn3YllaIkJIykDjineyf5CmbVsCslwO/Mx++pUbh
   4iSbBqCBWfTte5D8eiNChr20RQKZ0HsbMiTObwIYHj9ttgmookxRP+XD9
   MFM4t/ro8uq+OhIsy+iBT3IbY0c2rJlfwPCvv9A67/RK9orAM3u4pvpBi
   A4zL9FEMrdcGIid8NCh6X4Wke60tqHwGEsS1Ob7SOaImDGhqAuqPvljfF
   b0eqjwf0wyTvGd2dj0+aUkGn4fFD9ljkZ1s7wjDtCXFka4XZGrC4rNl64
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456431551"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="456431551"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 09:50:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="770707123"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="770707123"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Nov 2023 09:50:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0482C2A6; Wed, 22 Nov 2023 19:50:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 3/4] pinctrl: baytrail: Move default strength assignment to a switch-case
Date:   Wed, 22 Nov 2023 19:50:38 +0200
Message-ID: <20231122175039.2289945-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com>
References: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iWhen ->pin_config_set() is called from the GPIO library (assumed
GpioIo() ACPI resource), the argument can be 1, when, for example,
PullDefault is provided. In such case we supply sane default in
the driver. Move that default assingment to a switch-case, so
it will be consolidated in one place.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 291f0454257b..84f21a28fe7e 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -810,6 +810,7 @@ static int byt_set_pull_strength(u32 *reg, u16 strength)
 	*reg &= ~BYT_PULL_STR_MASK;
 
 	switch (strength) {
+	case 1: /* Set default strength value in case none is given */
 	case 2000:
 		*reg |= BYT_PULL_STR_2K;
 		break;
@@ -957,10 +958,6 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 			conf &= ~BYT_PULL_ASSIGN_MASK;
 			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			/* Set default strength value in case none is given */
-			if (arg == 1)
-				arg = 2000;
-
 			byt_gpio_force_input_mode(vg, offset);
 
 			conf &= ~BYT_PULL_ASSIGN_MASK;
@@ -969,10 +966,6 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
-			/* Set default strength value in case none is given */
-			if (arg == 1)
-				arg = 2000;
-
 			byt_gpio_force_input_mode(vg, offset);
 
 			conf &= ~BYT_PULL_ASSIGN_MASK;
-- 
2.43.0.rc1.1.gbec44491f096

