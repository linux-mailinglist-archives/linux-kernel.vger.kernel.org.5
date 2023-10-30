Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB037DBB90
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjJ3OQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3OQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:16:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB8FB7;
        Mon, 30 Oct 2023 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698675375; x=1730211375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ffm9srgbP1OW6UWdTpPWG/6RiH1iNQAyodapticHZEM=;
  b=QbQZ4yS25QgnJ9NkPMQ4q6HvvPuSYqJknFuFoJ8eQyF6xdSC/EX9YcM7
   hyNazSGH2vI2ZvEtSJEQLZDicqF8iF1ZQFUChbeB4Asgn3OpRNjdTjoHL
   4uCeYvhwDJEHzvGwN6Mw7lQWLg1UrggbJtz65XVM27qVloSAJ/+O/it4A
   9QUG2wWziCtLktmEGF9mjz4ABtab/nvPHH4NZJCfd1oVwuKcreM9f6sDy
   58l0mWCa5Gu8gHhzkmRn7oeNdAUTdqocg5W1f3Lr9pdAUJsbxGKh2YgWZ
   2mSO6uvyrdC+UTMbQnNAZwerTwowPuQiNtgp13YUD+l2Ag/afEU1IPVhS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="9611452"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="9611452"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 07:16:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="710105556"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710105556"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2023 07:16:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7E3822BF; Mon, 30 Oct 2023 16:10:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/3] pinctrl: intel: Revert "Unexport intel_pinctrl_probe()"
Date:   Mon, 30 Oct 2023 16:10:32 +0200
Message-Id: <20231030141034.3241674-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
References: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for a new coming driver export the original
intel_pinctrl_probe() again.

This reverts commit 0dd519e3784b13befa1cdfeff847a0885b06650f.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 5 +++--
 drivers/pinctrl/intel/pinctrl-intel.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index f1d8f7e0d9b7..f04781915631 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1506,8 +1506,8 @@ static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
 	return PTR_ERR_OR_ZERO(pwm);
 }
 
-static int intel_pinctrl_probe(struct platform_device *pdev,
-			       const struct intel_pinctrl_soc_data *soc_data)
+int intel_pinctrl_probe(struct platform_device *pdev,
+			const struct intel_pinctrl_soc_data *soc_data)
 {
 	struct device *dev = &pdev->dev;
 	struct intel_pinctrl *pctrl;
@@ -1625,6 +1625,7 @@ static int intel_pinctrl_probe(struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_pinctrl_probe, PINCTRL_INTEL);
 
 int intel_pinctrl_probe_by_hid(struct platform_device *pdev)
 {
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index e7d911a65584..fde65e18cd14 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -252,6 +252,9 @@ struct intel_pinctrl {
 	int irq;
 };
 
+int intel_pinctrl_probe(struct platform_device *pdev,
+			const struct intel_pinctrl_soc_data *soc_data);
+
 int intel_pinctrl_probe_by_hid(struct platform_device *pdev);
 int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
 
-- 
2.40.0.1.gaa8946217a0b

