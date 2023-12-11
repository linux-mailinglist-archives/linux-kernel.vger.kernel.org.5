Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388080DA7E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbjLKTDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344455AbjLKTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:03:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D5C0;
        Mon, 11 Dec 2023 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321421; x=1733857421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6S0za2ArzaZgRtTIp/prxGbnlaukelwxoBpv7MAxWdo=;
  b=Nr4iFZJlcm4Qb3UFhaOmzd1gnUIQ3t+gQg2BC9de72+Fo4fy7NsmpJZl
   Uk1Mz3OoHm5Ik5tOtEsdtYhkK3KfI/YyQJbJ8am/DLfHzZOaIQ8E9fT3q
   l2nz9Xv+PGsFUb9QwQrgD3Nwf3/fhBiPuZcmgNccsc44BNNYMmXd6if2q
   0l3ryQRbQzI8uB1CD1C7LOM2o9H1PuBu9xKi6CUYc/74tYsKkfuxjEo4Y
   f2eSvDsoG/GzcFlDm7l0GKrFGgJXg0ajioi+jSm+lkhgQFEoWwB024CcQ
   sGMTIY8VBdLBgdmg7LsYx+1swwxF1OVhmdRf7ymFGck/By24DtuKgAVIX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480893544"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="480893544"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766491696"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="766491696"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2023 11:03:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D5A28892; Mon, 11 Dec 2023 21:03:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v5 10/13] pinctrl: mediatek: Convert to use grp member
Date:   Mon, 11 Dec 2023 20:58:03 +0200
Message-ID: <20231211190321.307330-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231211190321.307330-1-andriy.shevchenko@linux.intel.com>
References: <20231211190321.307330-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert drivers to use grp member embedded in struct group_desc,
because other members will be removed to avoid duplication and
desynchronisation of the generic pin group description.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c | 13 ++++++-------
 drivers/pinctrl/mediatek/pinctrl-moore.h |  4 +---
 drivers/pinctrl/mediatek/pinctrl-paris.h |  4 +---
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index c3d59eddd994..d972584c0519 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -56,12 +56,12 @@ static int mtk_pinmux_set_mux(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	dev_dbg(pctldev->dev, "enable function %s group %s\n",
-		func->name, grp->name);
+		func->name, grp->grp.name);
 
-	for (i = 0; i < grp->num_pins; i++) {
+	for (i = 0; i < grp->grp.npins; i++) {
 		const struct mtk_pin_desc *desc;
 		int *pin_modes = grp->data;
-		int pin = grp->pins[i];
+		int pin = grp->grp.pins[i];
 
 		desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 		if (!desc->name)
@@ -602,13 +602,12 @@ static int mtk_build_groups(struct mtk_pinctrl *hw)
 
 	for (i = 0; i < hw->soc->ngrps; i++) {
 		const struct group_desc *group = hw->soc->grps + i;
+		const struct pingroup *grp = &group->grp;
 
-		err = pinctrl_generic_add_group(hw->pctrl, group->name,
-						group->pins, group->num_pins,
+		err = pinctrl_generic_add_group(hw->pctrl, grp->name, grp->pins, grp->npins,
 						group->data);
 		if (err < 0) {
-			dev_err(hw->dev, "Failed to register group %s\n",
-				group->name);
+			dev_err(hw->dev, "Failed to register group %s\n", grp->name);
 			return err;
 		}
 	}
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.h b/drivers/pinctrl/mediatek/pinctrl-moore.h
index 36ee0021cf7e..e0313e7a1fe0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.h
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.h
@@ -39,9 +39,7 @@
 
 #define PINCTRL_PIN_GROUP(_name_, id)							\
 	{										\
-		.name = _name_,								\
-		.pins = id##_pins,							\
-		.num_pins = ARRAY_SIZE(id##_pins),					\
+		.grp = PINCTRL_PINGROUP(_name_, id##_pins, ARRAY_SIZE(id##_pins)),	\
 		.data = id##_funcs,							\
 	}
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.h b/drivers/pinctrl/mediatek/pinctrl-paris.h
index 5c4e5b74e43e..948ce126aa0c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.h
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.h
@@ -51,9 +51,7 @@
 
 #define PINCTRL_PIN_GROUP(_name_, id)							\
 	{										\
-		.name = _name_,								\
-		.pins = id##_pins,							\
-		.num_pins = ARRAY_SIZE(id##_pins),					\
+		.grp = PINCTRL_PINGROUP(_name_,id##_pins, ARRAY_SIZE(id##_pins)),	\
 		.data = id##_funcs,							\
 	}
 
-- 
2.43.0.rc1.1.gbec44491f096

