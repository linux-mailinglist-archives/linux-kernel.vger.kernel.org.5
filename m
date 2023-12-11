Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5580DA82
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbjLKTEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbjLKTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:03:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B08100;
        Mon, 11 Dec 2023 11:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321422; x=1733857422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RimL0SIQXjPeHNJa1LOYK4/Xp//ezirAmpPsqYTrLlY=;
  b=PC5zrcIL14J9af/O+He5wSWMwSX56g61/jO6udTFieNglrZW+PH3rcvD
   qUy5Y66yfmdFTfTsyNSqpOVlKgh7RsSNFQnMx3eZJ6rxXUS8SUdLjGgk1
   xGKr0/w29/CL+QBve3kU1ZAAL2OHeLQ4ZoiReH4hbwbDq3k0Xgscw4dNM
   reGKdhHLZ8oIv38M/d1pWozXhyYD1sDBJmcPMsbiIyvYKeIOeiadob+NT
   KockyW9C78/hhgr0G2fIxtlPAcq+KIq6LTln07S2211G6ShhKEACDC001
   zeF2gqlEW8hzGn+3PUnHIpRG4+EMkUgRadmj15F53pJcDoEbAUTkPlj6z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480893550"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="480893550"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766491704"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="766491704"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2023 11:03:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F1D16A11; Mon, 11 Dec 2023 21:03:23 +0200 (EET)
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
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v5 12/13] pinctrl: starfive: Convert to use grp member
Date:   Mon, 11 Dec 2023 20:58:05 +0200
Message-ID: <20231211190321.307330-13-andriy.shevchenko@linux.intel.com>
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

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 8 ++++----
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
index b29b0ab9892b..6df7a310c7ed 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
@@ -654,7 +654,7 @@ static int starfive_set_mux(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	pinmux = group->data;
-	for (i = 0; i < group->num_pins; i++) {
+	for (i = 0; i < group->grp.npins; i++) {
 		u32 v = pinmux[i];
 		unsigned int gpio = starfive_pinmux_to_gpio(v);
 		u32 dout = starfive_pinmux_to_dout(v);
@@ -797,7 +797,7 @@ static int starfive_pinconf_group_get(struct pinctrl_dev *pctldev,
 	if (!group)
 		return -EINVAL;
 
-	return starfive_pinconf_get(pctldev, group->pins[0], config);
+	return starfive_pinconf_get(pctldev, group->grp.pins[0], config);
 }
 
 static int starfive_pinconf_group_set(struct pinctrl_dev *pctldev,
@@ -876,8 +876,8 @@ static int starfive_pinconf_group_set(struct pinctrl_dev *pctldev,
 		}
 	}
 
-	for (i = 0; i < group->num_pins; i++)
-		starfive_padctl_rmw(sfp, group->pins[i], mask, value);
+	for (i = 0; i < group->grp.npins; i++)
+		starfive_padctl_rmw(sfp, group->grp.pins[i], mask, value);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 6de11a405734..9609eb1ecc3d 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -307,7 +307,7 @@ static int jh7110_set_mux(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	pinmux = group->data;
-	for (i = 0; i < group->num_pins; i++) {
+	for (i = 0; i < group->grp.npins; i++) {
 		u32 v = pinmux[i];
 
 		if (info->jh7110_set_one_pin_mux)
@@ -437,7 +437,7 @@ static int jh7110_pinconf_group_get(struct pinctrl_dev *pctldev,
 	if (!group)
 		return -EINVAL;
 
-	return jh7110_pinconf_get(pctldev, group->pins[0], config);
+	return jh7110_pinconf_get(pctldev, group->grp.pins[0], config);
 }
 
 static int jh7110_pinconf_group_set(struct pinctrl_dev *pctldev,
@@ -508,8 +508,8 @@ static int jh7110_pinconf_group_set(struct pinctrl_dev *pctldev,
 		}
 	}
 
-	for (i = 0; i < group->num_pins; i++)
-		jh7110_padcfg_rmw(sfp, group->pins[i], mask, value);
+	for (i = 0; i < group->grp.npins; i++)
+		jh7110_padcfg_rmw(sfp, group->grp.pins[i], mask, value);
 
 	return 0;
 }
-- 
2.43.0.rc1.1.gbec44491f096

