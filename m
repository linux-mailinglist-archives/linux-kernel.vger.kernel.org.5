Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EA07BB469
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjJFJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjJFJko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:40:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4205D9F;
        Fri,  6 Oct 2023 02:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696585241; x=1728121241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DBh81qjzYPJxlX4/+EjBm0h8lY3RyxT+qZS+GrWwc2I=;
  b=WI24N4DDSa7zCjIKhhjunaw8dIWImFXD45tbut2z8phPprSHN5GytB5b
   8EYjXCubSY6B3E8H7jZjKKlGzdP+xY2+ht2xJZGKSFbgT93A/sHDJ2oGu
   BbSajsoFnkFE1h3Clj8mCzduqUobRWw6VaxdJb8z64ms9p7uA5c2rfNEZ
   sJ8BMDGguXRHcE80T29EVOnnH4dbsxrYaKdXV+425dNvr8K7/MEsGDunq
   EiKsfM4TG1QAR9GInXowJSZdsTbMSSw5M0aRxGR75GqMsEqRe9DmEhvvM
   ATfti2IYBzFH85swExlM0UEjd+HW7P+gNpoBA5wgeE4bzG8l6+KWSCGgL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="381000761"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="381000761"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 02:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999273973"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999273973"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 06 Oct 2023 02:40:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A982E574; Fri,  6 Oct 2023 12:40:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/2] pinctrl: cherryview: Avoid duplicated I/O
Date:   Fri,  6 Oct 2023 12:40:32 +0300
Message-Id: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

In some cases we already read the value from the register followed
by a reading of it again for other purposes, but the both reads
are under the lock and bits we are insterested in are not going
to change (they are not volatile from HW perspective). Hence, no
need to read the same registeer twice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index f047f7bf4afb..9b9f18f50c1d 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -612,9 +612,14 @@ static void chv_writel(struct intel_pinctrl *pctrl, unsigned int pin, unsigned i
 }
 
 /* When Pad Cfg is locked, driver can only change GPIOTXState or GPIORXState */
+static bool chv_pad_is_locked(u32 ctrl1)
+{
+	return ctrl1 & CHV_PADCTRL1_CFGLOCK;
+}
+
 static bool chv_pad_locked(struct intel_pinctrl *pctrl, unsigned int offset)
 {
-	return chv_readl(pctrl, offset, CHV_PADCTRL1) & CHV_PADCTRL1_CFGLOCK;
+	return chv_pad_is_locked(chv_readl(pctrl, offset, CHV_PADCTRL1));
 }
 
 static void chv_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
@@ -623,13 +628,11 @@ static void chv_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	unsigned long flags;
 	u32 ctrl0, ctrl1;
-	bool locked;
 
 	raw_spin_lock_irqsave(&chv_lock, flags);
 
 	ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
 	ctrl1 = chv_readl(pctrl, offset, CHV_PADCTRL1);
-	locked = chv_pad_locked(pctrl, offset);
 
 	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
@@ -646,7 +649,7 @@ static void chv_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 
 	seq_printf(s, "0x%08x 0x%08x", ctrl0, ctrl1);
 
-	if (locked)
+	if (chv_pad_is_locked(ctrl1))
 		seq_puts(s, " [LOCKED]");
 }
 
-- 
2.40.0.1.gaa8946217a0b

