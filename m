Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3C7B641F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjJCIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbjJCITX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:19:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A6E0;
        Tue,  3 Oct 2023 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696321122; x=1727857122;
  h=from:to:cc:subject:date:message-id;
  bh=8az2dN5wcSU6NLsmMuetGxrGcif+X6rFUoGelwM5vMQ=;
  b=F+DE8Lqdq/BM4c7rPm+BcXlXAwZxsy5VVfq44wSnMFpw7AhY/qCaiRn/
   nl28ze2iqum2qqbpWhyklQUByYeWsxZu+40VBku79JmOix3tkVT75lsCT
   S3noXDJOgmNp+T56aEc2tzpDrGjz0WHHMGJ8I4xFkTPPBR8B3BC5T+xpk
   phbZHF/B+/PpsPy5438ql1kM9ilcTKnknBeRcvkfUrOBFsVQDViXaTO69
   V4mg4yic72h7GtlCnuUV181HDg2IRmpYX4sLxHlCRT7rjF39bjWkm5mvQ
   vnk9q6au2U8HMtMfKFSqF+qhWD4au8WwVSpVENGnvQ/uZzp5FoD7m+3xu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="386696987"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="386696987"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841259303"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="841259303"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2023 01:18:39 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: intel: refine intel_config_set_pull() function
Date:   Tue,  3 Oct 2023 13:48:24 +0530
Message-Id: <20231003081824.28810-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve intel_config_set_pull() implementation in Intel pinctrl driver by:

- Reducing scope of spinlock by moving unneeded operations out of it.
- Utilizing temporary variables for common operations.
- Limiting IO operations to positive cases.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 41 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index f49d6e136018..f9155d94a830 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -674,16 +674,8 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 	unsigned int param = pinconf_to_config_param(config);
 	unsigned int arg = pinconf_to_config_argument(config);
 	const struct intel_community *community;
+	u32 term = 0, up = 0, value;
 	void __iomem *padcfg1;
-	u32 value;
-
-	community = intel_get_community(pctrl, pin);
-	padcfg1 = intel_get_padcfg(pctrl, pin, PADCFG1);
-
-	guard(raw_spinlock_irqsave)(&pctrl->lock);
-
-	value = readl(padcfg1);
-	value &= ~(PADCFG1_TERM_MASK | PADCFG1_TERM_UP);
 
 	/* Set default strength value in case none is given */
 	if (arg == 1)
@@ -696,47 +688,49 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 	case PIN_CONFIG_BIAS_PULL_UP:
 		switch (arg) {
 		case 20000:
-			value |= PADCFG1_TERM_20K << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_20K;
 			break;
 		case 5000:
-			value |= PADCFG1_TERM_5K << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_5K;
 			break;
 		case 4000:
-			value |= PADCFG1_TERM_4K << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_4K;
 			break;
 		case 1000:
-			value |= PADCFG1_TERM_1K << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_1K;
 			break;
 		case 833:
-			value |= PADCFG1_TERM_833 << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_833;
 			break;
 		default:
 			return -EINVAL;
 		}
 
-		value |= PADCFG1_TERM_UP;
+		up = PADCFG1_TERM_UP;
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_DOWN:
+		community = intel_get_community(pctrl, pin);
+
 		switch (arg) {
 		case 20000:
-			value |= PADCFG1_TERM_20K << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_20K;
 			break;
 		case 5000:
-			value |= PADCFG1_TERM_5K << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_5K;
 			break;
 		case 4000:
-			value |= PADCFG1_TERM_4K << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_4K;
 			break;
 		case 1000:
 			if (!(community->features & PINCTRL_FEATURE_1K_PD))
 				return -EINVAL;
-			value |= PADCFG1_TERM_1K << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_1K;
 			break;
 		case 833:
 			if (!(community->features & PINCTRL_FEATURE_1K_PD))
 				return -EINVAL;
-			value |= PADCFG1_TERM_833 << PADCFG1_TERM_SHIFT;
+			term = PADCFG1_TERM_833;
 			break;
 		default:
 			return -EINVAL;
@@ -748,6 +742,13 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 		return -EINVAL;
 	}
 
+	padcfg1 = intel_get_padcfg(pctrl, pin, PADCFG1);
+
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
+
+	value = readl(padcfg1);
+	value = (value & ~PADCFG1_TERM_MASK) | (term << PADCFG1_TERM_SHIFT);
+	value = (value & ~PADCFG1_TERM_UP) | up;
 	writel(value, padcfg1);
 
 	return 0;

base-commit: cec422ab8c1ef320cba23b7dbf9ea5364b9c8207
-- 
2.17.1

