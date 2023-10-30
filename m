Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30247DBCFB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjJ3PzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjJ3PzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:55:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E492CDB;
        Mon, 30 Oct 2023 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698681306; x=1730217306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cui525UNipVa8oEMgTPsnR567PdLaN5sF8CXFM/W4Zk=;
  b=QNwulWTauECbxSl0bMpmcrTtnlsW6BqNKdBWi4EyRT2Tjd6yP2c3kcs0
   7lSN4DkD59iI/PvcstmM4bitav/DPWEqIsXxOrHJLRxymSPlwcLSdmX5I
   8liN4y44AwQd7AAgYY1QvkBY4esFgRrE+9zQBidGpcZTRMBoTP1nEw/8X
   nx11/Q0RDeuw0/OgaZg3TX1laH+TH+R6KiuAS+ieMpiRMt6dKN8428YfJ
   xoVVjjtPdYUDw5bZi0PFuCrKvAtLi7EMTDWvNKZCLADXE9pzAze5kND2c
   SuulFjGGYUJ8h1LGXZSaUYHDIRZonOIDTLLaFmgQRYMvFDo5ZIHgLVtUa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367444898"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367444898"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 08:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760322099"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="760322099"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2023 08:54:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4A4FC2AB; Mon, 30 Oct 2023 17:54:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: intel: Move default strength assignment to a switch-case
Date:   Mon, 30 Oct 2023 17:54:32 +0200
Message-Id: <20231030155432.3468704-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-intel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index fb3e0e1e0a0e..3e8010607d32 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -677,10 +677,6 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 	u32 term = 0, up = 0, value;
 	void __iomem *padcfg1;
 
-	/* Set default strength value in case none is given */
-	if (arg == 1)
-		arg = 5000;
-
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
 		break;
@@ -690,6 +686,7 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 		case 20000:
 			term = PADCFG1_TERM_20K;
 			break;
+		case 1: /* Set default strength value in case none is given */
 		case 5000:
 			term = PADCFG1_TERM_5K;
 			break;
@@ -716,6 +713,7 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 		case 20000:
 			term = PADCFG1_TERM_20K;
 			break;
+		case 1: /* Set default strength value in case none is given */
 		case 5000:
 			term = PADCFG1_TERM_5K;
 			break;
-- 
2.40.0.1.gaa8946217a0b

