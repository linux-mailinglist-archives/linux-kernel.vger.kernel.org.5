Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD37DBCF8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjJ3PzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3PzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:55:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81280DA;
        Mon, 30 Oct 2023 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698681302; x=1730217302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vr9wC//U7mjFaon4HjCKM0j3IK8dVlIOCYgYttbl/8c=;
  b=mEot2FOj5zUXk66m79D1tEDYUJwWidkKa3+87oTlKyU5xg6ZdTJWkedn
   t9NMakp2bizRFyzA15B//4NMOFnFGlLUGHhUia9wRVGwWfozWaKTjtSzu
   W3CBGlkKjEV5jvTN0RkMDMkR+ATGAJZTkW9jH8il57aJxOeXKpXXpOjSe
   8k4o7GlGrPi1/zo/cEMZm4wh46hDunAs3dLAo/5ir2EqpZquGNGR1yOzr
   ITztN1bOxGwLMyI/M5turp+cvkxrtQ7FPiWkvWlWGRp+poF1woIkJluUn
   vMeO9MTss6K+8H/8RlwZcRN1gHsmUCE1Lvn6wyUX5iyeOmW5cHAWOQ5wt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367444829"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367444829"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 08:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760321886"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="760321886"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2023 08:54:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E37E32AB; Mon, 30 Oct 2023 17:54:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: baytrail: Move default strength assignment to a switch-case
Date:   Mon, 30 Oct 2023 17:54:27 +0200
Message-Id: <20231030155427.3468671-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 94c2438c4493..437315d32f18 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -799,6 +799,7 @@ static int byt_set_pull_strength(u32 *reg, u16 strength)
 	*reg &= ~BYT_PULL_STR_MASK;
 
 	switch (strength) {
+	case 1: /* Set default strength value in case none is given */
 	case 2000:
 		*reg |= BYT_PULL_STR_2K;
 		break;
@@ -945,10 +946,6 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 			conf &= ~BYT_PULL_ASSIGN_MASK;
 			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			/* Set default strength value in case none is given */
-			if (arg == 1)
-				arg = 2000;
-
 			byt_gpio_force_input_mode(vg, offset);
 
 			conf &= ~BYT_PULL_ASSIGN_MASK;
@@ -957,10 +954,6 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
-			/* Set default strength value in case none is given */
-			if (arg == 1)
-				arg = 2000;
-
 			byt_gpio_force_input_mode(vg, offset);
 
 			conf &= ~BYT_PULL_ASSIGN_MASK;
-- 
2.40.0.1.gaa8946217a0b

