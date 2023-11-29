Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2C7FDCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjK2QRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjK2QQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:16:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82AF1FF1;
        Wed, 29 Nov 2023 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701274550; x=1732810550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZTe3P1t1nP9zU91mwbbjJ6s//dd7HhfH9LawRMEcJGc=;
  b=NkzyZlgSwi8lGBs7QZOrk9dJKVEFS1d/YI89q8O4ETwdzKHmTKeLZ2Fz
   akxX6GiGZ1f+zEdLZblpDhwqptpsjVApOMkh7Z178SvVSa7ztyJfT6hpU
   QLYDmJT73p00gZNuOwTlaXFPIjQlfoAO25e1B7R+VUVmKkyUeiUzJzYeg
   BDH0Qw01rmT7gjRLsgo465fDZzP3dPcvtKjS8FPEO1Pv95H61/Yqa6LEm
   mfliqKoQ0/RL2mjW6UY8v8GnqzuxZcqgjPuEUQbeWgils48KvqYmvbBrF
   MOBY5Jk7ws7vpuVUk9vgkI726c2dyZw09344CqzebQpngcYFVIad1q2sJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373372937"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="373372937"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 08:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892498916"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="892498916"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2023 08:15:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7FADFCC8; Wed, 29 Nov 2023 18:15:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v4 22/23] pinctrl: core: Remove unused members from struct group_desc
Date:   Wed, 29 Nov 2023 18:06:45 +0200
Message-ID: <20231129161459.1002323-23-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
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

All drivers are converted to use embedded struct pingroup.
Remove unused members from struct group_desc.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c | 9 ---------
 drivers/pinctrl/core.h | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 744f03edbdb2..6688911c00db 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -557,9 +557,6 @@ const char *pinctrl_generic_get_group_name(struct pinctrl_dev *pctldev,
 	if (!group)
 		return NULL;
 
-	if (group->name)
-		return group->name;
-
 	return group->grp.name;
 }
 EXPORT_SYMBOL_GPL(pinctrl_generic_get_group_name);
@@ -586,12 +583,6 @@ int pinctrl_generic_get_group_pins(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 	}
 
-	if (group->pins) {
-		*pins = group->pins;
-		*num_pins = group->num_pins;
-		return 0;
-	}
-
 	*pins = group->grp.pins;
 	*num_pins = group->grp.npins;
 
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 60892950bbab..0c1803dd85e5 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -199,16 +199,10 @@ struct pinctrl_maps {
 /**
  * struct group_desc - generic pin group descriptor
  * @grp: generic data of the pin group (name and pins)
- * @name: name of the pin group
- * @pins: array of pins that belong to the group
- * @num_pins: number of pins in the group
  * @data: pin controller driver specific data
  */
 struct group_desc {
 	struct pingroup grp;
-	const char *name;
-	const unsigned int *pins;
-	int num_pins;
 	void *data;
 };
 
@@ -216,9 +210,6 @@ struct group_desc {
 #define PINCTRL_GROUP_DESC(_name, _pins, _num_pins, _data)	\
 (struct group_desc) {						\
 	.grp = PINCTRL_PINGROUP(_name, _pins, _num_pins),	\
-	.name = _name,						\
-	.pins = _pins,						\
-	.num_pins = _num_pins,					\
 	.data = _data,						\
 }
 
-- 
2.43.0.rc1.1.gbec44491f096

