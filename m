Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E517F60F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbjKWOCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345636AbjKWOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:02:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D679F;
        Thu, 23 Nov 2023 06:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700748162; x=1732284162;
  h=from:to:cc:subject:date:message-id;
  bh=/aSaJpluUpfz8zIYINYmmKw/+Sgyp3i8cMgmajwYojc=;
  b=e7ZSSgH6pl9GeaEj0TsJmUvcrfwV1CIf4PBOH1B1fau3xU/enbQNuSy+
   fL/tuGxOfIRLew0OAdK/UTbu7ZiS9C8W0Nj2KkxxrFKg3xUjn2gTiJniJ
   PNAHPyo2qlGE7FBvtxKdfWz8anMcTi1i4XnEFaImScb6MZlU5I1kemmuv
   6hi9N6Iie6iXyV4+6vVFDT3BPnWrBnw0eLNsDt8S8IIe2aWsbSYOwz75j
   h+t+k+Piwz6sBVd8+cdtj8ksqUcupqwKIupBeh7dlYeNUz5kgErv8fcgg
   nngbnbAn35QdhWRhF2UlkE1I22Pjra6/YeaJbfwym/hlofAE3NsHq3bQV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423401635"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="423401635"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:02:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="771004938"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="771004938"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2023 06:02:26 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: tangier: simplify locking using cleanup helpers
Date:   Thu, 23 Nov 2023 19:32:12 +0530
Message-Id: <20231123140212.12135-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use lock guards from cleanup.h to simplify locking.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-tangier.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
index 26e34ec0a972..2cb0b4758269 100644
--- a/drivers/pinctrl/intel/pinctrl-tangier.c
+++ b/drivers/pinctrl/intel/pinctrl-tangier.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -220,7 +221,6 @@ static int tng_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	const struct intel_pingroup *grp = &tp->groups[group];
 	u32 bits = grp->mode << BUFCFG_PINMODE_SHIFT;
 	u32 mask = BUFCFG_PINMODE_MASK;
-	unsigned long flags;
 	unsigned int i;
 
 	/*
@@ -232,11 +232,11 @@ static int tng_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			return -EBUSY;
 	}
 
+	guard(raw_spinlock_irqsave)(&tp->lock);
+
 	/* Now enable the mux setting for each pin in the group */
-	raw_spin_lock_irqsave(&tp->lock, flags);
 	for (i = 0; i < grp->grp.npins; i++)
 		tng_update_bufcfg(tp, grp->grp.pins[i], bits, mask);
-	raw_spin_unlock_irqrestore(&tp->lock, flags);
 
 	return 0;
 }
@@ -248,14 +248,13 @@ static int tng_gpio_request_enable(struct pinctrl_dev *pctldev,
 	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
 	u32 bits = BUFCFG_PINMODE_GPIO << BUFCFG_PINMODE_SHIFT;
 	u32 mask = BUFCFG_PINMODE_MASK;
-	unsigned long flags;
 
 	if (!tng_buf_available(tp, pin))
 		return -EBUSY;
 
-	raw_spin_lock_irqsave(&tp->lock, flags);
+	guard(raw_spinlock_irqsave)(&tp->lock);
+
 	tng_update_bufcfg(tp, pin, bits, mask);
-	raw_spin_unlock_irqrestore(&tp->lock, flags);
 
 	return 0;
 }
@@ -360,7 +359,6 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
 	unsigned int param = pinconf_to_config_param(config);
 	unsigned int arg = pinconf_to_config_argument(config);
 	u32 mask, term, value = 0;
-	unsigned long flags;
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -432,9 +430,9 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
 		return -EINVAL;
 	}
 
-	raw_spin_lock_irqsave(&tp->lock, flags);
+	guard(raw_spinlock_irqsave)(&tp->lock);
+
 	tng_update_bufcfg(tp, pin, value, mask);
-	raw_spin_unlock_irqrestore(&tp->lock, flags);
 
 	return 0;
 }

base-commit: e58e519b80ba79cd73abb1d631d429b7322ac9cb
-- 
2.17.1

