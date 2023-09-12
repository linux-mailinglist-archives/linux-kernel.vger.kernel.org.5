Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8779D542
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjILPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:48:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7259D10DE;
        Tue, 12 Sep 2023 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694533702; x=1726069702;
  h=from:to:cc:subject:date:message-id;
  bh=nRniEhkGgaYLkB/Q3NYFbVXAScl42/siOCo/bp1+ckk=;
  b=T9MlFkRAw1+FlyhU6JvlvQ3xfUSlQqDjKOi9KQNsWcOD0vQbGrGKbDjE
   hbMwTaYaKzmxeOsTDu+RpsQ4VNSpt0/lx0Fc/3hwipmfveSHXJAZZ3mQu
   PsG4RJURl4AjoeHPHlXGoS0Xm2Nqh6RR3vTUsq+xpmKQ8hYk9sy1Sqsnv
   MEoQtwhUkU2zWQcQMn6Gwfm+WhN9STAX/06D9W41VvbqdbEm8X/xn70tH
   O4tCHUeQAO48obsvwsYGVUEhAE3vjst8tXjY4AlK6Z3iT3LuBbm53MVGn
   MhuDy5yWz9GgDKhtVKQD6kY49FLaISQyuXQT+dmdZbBs4sNtP1dw7JBCR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="375743992"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="375743992"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074592358"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="1074592358"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2023 08:48:19 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, dan.carpenter@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: baytrail: fix debounce disable case
Date:   Tue, 12 Sep 2023 21:18:15 +0530
Message-Id: <20230912154815.28975-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to update debounce pulse value in case debounce is to be
disabled. Break such a case where arg value is zero.

Fixes: 4cfff5b7af8b ("pinctrl: baytrail: consolidate common mask operation")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-gpio/d164d471-5432-4c3c-afdb-33dc8f53d043@moroto.mountain/
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 6b45b165604c..c522fd2283f9 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -983,11 +983,18 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 
 			break;
 		case PIN_CONFIG_INPUT_DEBOUNCE:
-			if (arg)
+			if (arg) {
 				conf |= BYT_DEBOUNCE_EN;
-			else
+			} else {
 				conf &= ~BYT_DEBOUNCE_EN;
 
+				/*
+				 * No need to update the pulse value.
+				 * Debounce is going to be disabled.
+				 */
+				break;
+			}
+
 			switch (arg) {
 			case 375:
 				db_pulse = BYT_DEBOUNCE_PULSE_375US;
-- 
2.17.1

