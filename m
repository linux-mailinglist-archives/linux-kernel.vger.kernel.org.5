Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC37DB98A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjJ3MHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjJ3MHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38252DA;
        Mon, 30 Oct 2023 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667661; x=1730203661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GcOoEJ3Jn7yP9ifSoXn9/N56Gs1jsU1LSJfT/anOq+g=;
  b=I9aSlgEL8BSMzh/zCJfSN/qk+FQsN2II8dpbenzXFKoqf5PvWAqMevjS
   5qVB6yt9wvS3onmSMw006VJhKarsLl/RZ547CqrQpeiaRYnPcP90pPtHc
   5evLopUZHvOueR3AsClS2tqRTMnDDeL9NMgqMygFllONstQAo5NRXx2Xa
   gRiSkAz3QyUKUQ+RiSab/8Kih3oph3fmca7Pom6nN7cwNFX6E3zL2qbDV
   YeQZ0bh9zXE6cNYmvcKU5QWDPYs8sW7Ox3u0EeLE7eMHqiajQxcpJkDDm
   LIEHwfb3g6EbVXvglg8CagAtfkFfATBEI3P6dAN7dwOGlD8qmayrWztom
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373107335"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373107335"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="753771400"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="753771400"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2023 05:07:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D94A02BF; Mon, 30 Oct 2023 14:07:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 01/17] pinctrl: intel: Provide Intel pin control wide PM ops structure
Date:   Mon, 30 Oct 2023 14:07:18 +0200
Message-Id: <20231030120734.2831419-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
References: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
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

With the help of EXPORT_NS_GPL_DEV_PM_OPS() and
NOIRQ_SYSTEM_SLEEP_PM_OPS() we may convert PM ops functions to become
static. This also takes into account the PM configuration options such
as CONFIG_PM and CONFIG_PM_SLEEP. Hence the first step is to provide
a generic PM ops structure that can be used by drivers directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 8 +++++---
 drivers/pinctrl/intel/pinctrl-intel.h | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index b19527a8728e..9fbdc7bfa65c 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -899,7 +899,7 @@ static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned int offset,
  *
  * Return: a GPIO offset, or negative error code if translation can't be done.
  */
-static __maybe_unused int intel_pin_to_gpio(struct intel_pinctrl *pctrl, int pin)
+static int intel_pin_to_gpio(struct intel_pinctrl *pctrl, int pin)
 {
 	const struct intel_community *community;
 	const struct intel_padgroup *padgrp;
@@ -1682,7 +1682,6 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 }
 EXPORT_SYMBOL_NS_GPL(intel_pinctrl_get_soc_data, PINCTRL_INTEL);
 
-#ifdef CONFIG_PM_SLEEP
 static bool __intel_gpio_is_direct_irq(u32 value)
 {
 	return (value & PADCFG0_GPIROUTIOXAPIC) && (value & PADCFG0_GPIOTXDIS) &&
@@ -1883,7 +1882,10 @@ int intel_pinctrl_resume_noirq(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(intel_pinctrl_resume_noirq);
-#endif
+
+EXPORT_NS_GPL_DEV_PM_OPS(intel_pinctrl_pm_ops, PINCTRL_INTEL) = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq, intel_pinctrl_resume_noirq)
+};
 
 MODULE_AUTHOR("Mathias Nyman <mathias.nyman@linux.intel.com>");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 2bb553598e8b..d3f511f97ed9 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -255,10 +255,8 @@ struct intel_pinctrl {
 int intel_pinctrl_probe_by_hid(struct platform_device *pdev);
 int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
 
-#ifdef CONFIG_PM_SLEEP
 int intel_pinctrl_suspend_noirq(struct device *dev);
 int intel_pinctrl_resume_noirq(struct device *dev);
-#endif
 
 #define INTEL_PINCTRL_PM_OPS(_name)					\
 const struct dev_pm_ops _name = {					\
@@ -266,6 +264,8 @@ const struct dev_pm_ops _name = {					\
 				      intel_pinctrl_resume_noirq)	\
 }
 
+extern const struct dev_pm_ops intel_pinctrl_pm_ops;
+
 struct intel_community *intel_get_community(struct intel_pinctrl *pctrl, unsigned int pin);
 
 int intel_get_groups_count(struct pinctrl_dev *pctldev);
-- 
2.40.0.1.gaa8946217a0b

