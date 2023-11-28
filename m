Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7837FC4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbjK1UF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjK1UFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:05:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42112C;
        Tue, 28 Nov 2023 12:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701201952; x=1732737952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oWROro8zaz/FXYo/HWfHQvzRYrdVT7osWgNgoAMuX7s=;
  b=LPaUdKeWQUS1dtdJnpRwCTMqV4MCTd0CqO0mq8fuZ7o5PUyrOb3D3bT9
   51N+shOx+Ra7yzFWvI1LI8l0BxtJfaMMnac7930khBMan+ypaY/3+PRc1
   8xsP0px3iWlJRnJzZKr9Zn3EM3Nk/Pk5gh8rrWyfk//2/+s/IZmPcnHdF
   ZaLIMTe3OrH/ewVP2ESmn97Een4Pmg89+IZra52Bax68NW5NmrzQPptbm
   lrR4CsrzdH4d9i8Ma0wsw5fvq6yGCqT98VIreECDJurs1xJp/xJkmYXoF
   cVSX6bXp5vw3FXyD7tIPeyjYQiEE6CXFao7WpT96+yjUZ3VhNkgklQ9Qo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6218327"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6218327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:02:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797687987"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797687987"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2023 12:02:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 82EF7F7; Tue, 28 Nov 2023 22:01:58 +0200 (EET)
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
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v3 13/22] pinctrl: core: Embed struct pingroup into struct group_desc
Date:   Tue, 28 Nov 2023 21:57:02 +0200
Message-ID: <20231128200155.438722-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231128200155.438722-1-andriy.shevchenko@linux.intel.com>
References: <20231128200155.438722-1-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c | 15 ++++++++++++---
 drivers/pinctrl/core.h |  5 +++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 3f1fd50fbb10..e08d4b3b0a56 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -559,7 +559,10 @@ const char *pinctrl_generic_get_group_name(struct pinctrl_dev *pctldev,
 	if (!group)
 		return NULL;
 
-	return group->name;
+	if (group->name)
+		return group->name;
+
+	return group->grp.name;
 }
 EXPORT_SYMBOL_GPL(pinctrl_generic_get_group_name);
 
@@ -585,8 +588,14 @@ int pinctrl_generic_get_group_pins(struct pinctrl_dev *pctldev,
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
index 276a631fd49c..863b4956a41e 100644
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
 	const int *pins;
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

