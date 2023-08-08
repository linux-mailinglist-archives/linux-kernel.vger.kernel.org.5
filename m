Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5511C774B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjHHUnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjHHUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:43:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03443208B;
        Tue,  8 Aug 2023 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512248; x=1723048248;
  h=from:to:cc:subject:date:message-id;
  bh=FHiTNDUCzaH3CxhFl0M+eCf/lVRDrPXo5yOGv54eeZQ=;
  b=YH6Zi0bGvGGNQyhYAnDp66gA22iieQyeNuwt1WxGB4kdYkpaeIbt25Hc
   Qmwn4ubKsKuIIfEkwTNe/RHElPVU9A0uxWzOUvRVLpoTQni4z7f1hxyaJ
   7VNqahDHPl0D/HZCiyD17sDp+cb4lhF2ZaJgUHtyynztM8AmGTsxyU8Ll
   7zuWErGjNKS+qsSsVPEfeBa/0udgRrQcnoPbOmeeI9dA82T8g8cKOs+t5
   /q+cVR2K9fas2Flif+qxiHhEsjjmwgV/eIWGxATcYHvBFd/bf7elKK3l3
   Z6OtLnp+ouLeOfT0jmXJTMppu2E0DXV+nUt7kQNqZ7fsdu9RyHPxBdLfF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401725840"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="401725840"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 01:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760827832"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="760827832"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2023 01:49:10 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: baytrail: consolidate common mask operation
Date:   Tue,  8 Aug 2023 14:19:01 +0530
Message-Id: <20230808084901.18927-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate common mask operation outside of switch cases and
limit IO operations to positive cases.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 34 +++++++++++-------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 27aef62fc7c0..02ab5fd7cbd5 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -995,8 +995,8 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 	void __iomem *conf_reg = byt_gpio_reg(vg, offset, BYT_CONF0_REG);
 	void __iomem *val_reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
 	void __iomem *db_reg = byt_gpio_reg(vg, offset, BYT_DEBOUNCE_REG);
+	u32 conf, val, db_pulse, debounce;
 	unsigned long flags;
-	u32 conf, val, debounce;
 	int i, ret = 0;
 
 	raw_spin_lock_irqsave(&byt_lock, flags);
@@ -1053,8 +1053,6 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 
 			break;
 		case PIN_CONFIG_INPUT_DEBOUNCE:
-			debounce = readl(db_reg);
-
 			if (arg)
 				conf |= BYT_DEBOUNCE_EN;
 			else
@@ -1062,32 +1060,25 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 
 			switch (arg) {
 			case 375:
-				debounce &= ~BYT_DEBOUNCE_PULSE_MASK;
-				debounce |= BYT_DEBOUNCE_PULSE_375US;
+				db_pulse = BYT_DEBOUNCE_PULSE_375US;
 				break;
 			case 750:
-				debounce &= ~BYT_DEBOUNCE_PULSE_MASK;
-				debounce |= BYT_DEBOUNCE_PULSE_750US;
+				db_pulse = BYT_DEBOUNCE_PULSE_750US;
 				break;
 			case 1500:
-				debounce &= ~BYT_DEBOUNCE_PULSE_MASK;
-				debounce |= BYT_DEBOUNCE_PULSE_1500US;
+				db_pulse = BYT_DEBOUNCE_PULSE_1500US;
 				break;
 			case 3000:
-				debounce &= ~BYT_DEBOUNCE_PULSE_MASK;
-				debounce |= BYT_DEBOUNCE_PULSE_3MS;
+				db_pulse = BYT_DEBOUNCE_PULSE_3MS;
 				break;
 			case 6000:
-				debounce &= ~BYT_DEBOUNCE_PULSE_MASK;
-				debounce |= BYT_DEBOUNCE_PULSE_6MS;
+				db_pulse = BYT_DEBOUNCE_PULSE_6MS;
 				break;
 			case 12000:
-				debounce &= ~BYT_DEBOUNCE_PULSE_MASK;
-				debounce |= BYT_DEBOUNCE_PULSE_12MS;
+				db_pulse = BYT_DEBOUNCE_PULSE_12MS;
 				break;
 			case 24000:
-				debounce &= ~BYT_DEBOUNCE_PULSE_MASK;
-				debounce |= BYT_DEBOUNCE_PULSE_24MS;
+				db_pulse = BYT_DEBOUNCE_PULSE_24MS;
 				break;
 			default:
 				if (arg)
@@ -1095,8 +1086,13 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 				break;
 			}
 
-			if (!ret)
-				writel(debounce, db_reg);
+			if (ret)
+				break;
+
+			debounce = readl(db_reg);
+			debounce = (debounce & ~BYT_DEBOUNCE_PULSE_MASK) | db_pulse;
+			writel(debounce, db_reg);
+
 			break;
 		default:
 			ret = -ENOTSUPP;
-- 
2.17.1

