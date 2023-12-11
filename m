Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6F80DA7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344564AbjLKTDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344446AbjLKTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:03:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE9CF;
        Mon, 11 Dec 2023 11:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321420; x=1733857420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jT5aMdLnWQi+FETkAhi9wCFmGc0jKKEFEHjIqYKnUWw=;
  b=Nn0voCmGPJDA6IHhoxweSVvkDnFsTplswe3WMvdYStBVtaxT7KK8PcRn
   hUsRNyK6icv2qm2rd4bVoxaYCX9KQa+edS4KbYQtoW9+17mONRe2yOxwV
   jKP7EBi0YpVYFYl+vK1mbYBFLuUxCSyL0oNJ+NxAbcM+S86ZxVVsO9aTp
   dkPBZrOC1oU8HgM0Gdg7TntCHYuSVDewBd5HBkh6t4d7Tssl0ba9l673I
   EpFaW9A6lhbOdIKaN3gmsln0D7aEWRHqJ1Kvw0CFvvxcFxW57fD8Mfiu0
   izVzqnt2UQOVkqkGU4/lJWFVNxLpD0klyLd7HpjUFtbFfW1S0ygoxJHmi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480893504"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="480893504"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766491687"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="766491687"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2023 11:03:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB59872F; Mon, 11 Dec 2023 21:03:23 +0200 (EET)
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
Subject: [PATCH v5 08/13] pinctrl: ingenic: Convert to use grp member
Date:   Mon, 11 Dec 2023 20:58:01 +0200
Message-ID: <20231211190321.307330-9-andriy.shevchenko@linux.intel.com>
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

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-ingenic.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index f5661dcdedf5..bc6358a686fc 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -84,17 +84,13 @@
 
 #define INGENIC_PIN_GROUP_FUNCS(_name_, id, funcs)					\
 	{										\
-		.name = _name_,								\
-		.pins = id##_pins,							\
-		.num_pins = ARRAY_SIZE(id##_pins),					\
+		.grp = PINCTRL_PINGROUP(_name_, id##_pins, ARRAY_SIZE(id##_pins)),	\
 		.data = funcs,								\
 	}
 
 #define INGENIC_PIN_GROUP(_name_, id, func)						\
 	{										\
-		.name = _name_,								\
-		.pins = id##_pins,							\
-		.num_pins = ARRAY_SIZE(id##_pins),					\
+		.grp = PINCTRL_PINGROUP(_name_, id##_pins, ARRAY_SIZE(id##_pins)),	\
 		.data = (void *)func,							\
 	}
 
@@ -3766,17 +3762,17 @@ static int ingenic_pinmux_set_mux(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	dev_dbg(pctldev->dev, "enable function %s group %s\n",
-		func->name, grp->name);
+		func->name, grp->grp.name);
 
 	mode = (uintptr_t)grp->data;
 	if (mode <= 3) {
-		for (i = 0; i < grp->num_pins; i++)
-			ingenic_pinmux_set_pin_fn(jzpc, grp->pins[i], mode);
+		for (i = 0; i < grp->grp.npins; i++)
+			ingenic_pinmux_set_pin_fn(jzpc, grp->grp.pins[i], mode);
 	} else {
 		pin_modes = grp->data;
 
-		for (i = 0; i < grp->num_pins; i++)
-			ingenic_pinmux_set_pin_fn(jzpc, grp->pins[i], pin_modes[i]);
+		for (i = 0; i < grp->grp.npins; i++)
+			ingenic_pinmux_set_pin_fn(jzpc, grp->grp.pins[i], pin_modes[i]);
 	}
 
 	return 0;
@@ -4303,12 +4299,12 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 
 	for (i = 0; i < chip_info->num_groups; i++) {
 		const struct group_desc *group = &chip_info->groups[i];
+		const struct pingroup *grp = &group->grp;
 
-		err = pinctrl_generic_add_group(jzpc->pctl, group->name,
-				group->pins, group->num_pins, group->data);
+		err = pinctrl_generic_add_group(jzpc->pctl, grp->name, grp->pins, grp->npins,
+						group->data);
 		if (err < 0) {
-			dev_err(dev, "Failed to register group %s\n",
-					group->name);
+			dev_err(dev, "Failed to register group %s\n", grp->name);
 			return err;
 		}
 	}
-- 
2.43.0.rc1.1.gbec44491f096

