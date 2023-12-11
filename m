Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B6180DA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344651AbjLKTD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344456AbjLKTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:03:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A099FE;
        Mon, 11 Dec 2023 11:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321422; x=1733857422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0WWCPRg7bqetBK8gitn1hlA0oD/JGzynriYGlfQpHWc=;
  b=j8KHTGVMrwNeJnqgjoUsE1BJwKOjRznVAZRKM+LVtTOJZcyo2I6K9+bf
   VZGS/CwxlG4WzcD7NZI8MiL4SbPorrF9pTJMP/w6mOtEY4mL35BskY8F3
   wstYMStnzy67X6hIaCqzZN28qTfQuD8DT48n0jihnXUPzckALX29cQ56Z
   raVAaXyuUw4ysIZOC2i4EVj1eKee0G4UW7F+g2qiZRpBWiqSGLgdo4wq7
   9n72lapf50iHee3LlvpzhfmAKs/9E6qK7IKq1OfnBiDmiZ2DmvlG1HrXy
   CPYvFxMxBELDLwFy+8/Xe0AssgRZ6NJhJ37q1qDncjU/JtdNBwSsJaa8q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="379692559"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="379692559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946445105"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946445105"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2023 11:03:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 91C7765E; Mon, 11 Dec 2023 21:03:23 +0200 (EET)
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
        Hal Feng <hal.feng@starfivetech.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v5 05/13] pinctrl: bcm: Convert to use grp member
Date:   Mon, 11 Dec 2023 20:57:58 +0200
Message-ID: <20231211190321.307330-6-andriy.shevchenko@linux.intel.com>
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

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/bcm/pinctrl-ns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-ns.c b/drivers/pinctrl/bcm/pinctrl-ns.c
index d099a7f25f64..6bb2b461950b 100644
--- a/drivers/pinctrl/bcm/pinctrl-ns.c
+++ b/drivers/pinctrl/bcm/pinctrl-ns.c
@@ -171,8 +171,8 @@ static int ns_pinctrl_set_mux(struct pinctrl_dev *pctrl_dev,
 	if (!group)
 		return -EINVAL;
 
-	for (i = 0; i < group->num_pins; i++)
-		unset |= BIT(group->pins[i]);
+	for (i = 0; i < group->grp.npins; i++)
+		unset |= BIT(group->grp.pins[i]);
 
 	tmp = readl(ns_pinctrl->base);
 	tmp &= ~unset;
-- 
2.43.0.rc1.1.gbec44491f096

