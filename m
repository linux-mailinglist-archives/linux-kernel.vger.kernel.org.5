Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9F80DA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344399AbjLKTDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344351AbjLKTD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:03:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F60EC0;
        Mon, 11 Dec 2023 11:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321413; x=1733857413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b7CPcX9ouwRk1xx4HWTOwic7NJnDx4rISU5WcRjGp/M=;
  b=DWNyxQE4oaZRpxZDGY0tyETWojJG1jRg64OkIG/vxPxHxfCBtmixEejL
   +WfCPuZ2f1BnZcZaqyP5T8IKZKZ7T/4kAe7P32XQBd/DYe52fm96Ui3HS
   /IINvWs9s/loB9BhibQmxRB1LA4X2ZUCpZg00otkVQUHE4Ggko389H3zl
   A1v6N+KGTGJ3GF5gZTzPuUd3MIxYfRqMZLp99/y+V3cyELlTH7Rk/o4ng
   aBba2A0UtF8XVPYbgfSX2S84LSSutLAVyIwPqvRVFRhz6d0AjyUZ0jdn9
   5NpgBfKHllYmbMe0dOV8spNidlXQKuHMSbg1xlZBGgx0xBCBHTBuZh14D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="379692506"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="379692506"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:03:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946445050"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946445050"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2023 11:03:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 82B943D2; Mon, 11 Dec 2023 21:03:23 +0200 (EET)
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
Subject: [PATCH v5 04/13] pinctrl: core: Embed struct pingroup into struct group_desc
Date:   Mon, 11 Dec 2023 20:57:57 +0200
Message-ID: <20231211190321.307330-5-andriy.shevchenko@linux.intel.com>
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

struct group_desc is a particular version of the struct pingroup
with associated opaque data. Start switching pin control core and
drivers to use it explicitly.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c | 15 ++++++++++++---
 drivers/pinctrl/core.h |  5 +++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 75f2689c3bad..48cc5571dea6 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -557,7 +557,10 @@ const char *pinctrl_generic_get_group_name(struct pinctrl_dev *pctldev,
 	if (!group)
 		return NULL;
 
-	return group->name;
+	if (group->name)
+		return group->name;
+
+	return group->grp.name;
 }
 EXPORT_SYMBOL_GPL(pinctrl_generic_get_group_name);
 
@@ -583,8 +586,14 @@ int pinctrl_generic_get_group_pins(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 	}
 
-	*pins = group->pins;
-	*num_pins = group->num_pins;
+	if (group->pins) {
+		*pins = group->pins;
+		*num_pins = group->num_pins;
+		return 0;
+	}
+
+	*pins = group->grp.pins;
+	*num_pins = group->grp.npins;
 
 	return 0;
 }
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index bf971e6a7846..a3b75ec7b54b 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -194,14 +194,18 @@ struct pinctrl_maps {
 
 #ifdef CONFIG_GENERIC_PINCTRL_GROUPS
 
+#include <linux/pinctrl/pinctrl.h>
+
 /**
  * struct group_desc - generic pin group descriptor
+ * @grp: generic data of the pin group (name and pins)
  * @name: name of the pin group
  * @pins: array of pins that belong to the group
  * @num_pins: number of pins in the group
  * @data: pin controller driver specific data
  */
 struct group_desc {
+	struct pingroup grp;
 	const char *name;
 	const unsigned int *pins;
 	int num_pins;
@@ -211,6 +215,7 @@ struct group_desc {
 /* Convenience macro to define a generic pin group descriptor */
 #define PINCTRL_GROUP_DESC(_name, _pins, _num_pins, _data)	\
 (struct group_desc) {						\
+	.grp = PINCTRL_PINGROUP(_name, _pins, _num_pins),	\
 	.name = _name,						\
 	.pins = _pins,						\
 	.num_pins = _num_pins,					\
-- 
2.43.0.rc1.1.gbec44491f096

