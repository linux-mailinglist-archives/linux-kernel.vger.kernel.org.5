Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B317FC4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345310AbjK1UMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjK1UMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:12:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37227F4;
        Tue, 28 Nov 2023 12:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701202338; x=1732738338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GcznTEzkYh7381dOAmLl/g2Ovk3HvI9vfBlGPtxsvN8=;
  b=idAQfDn5rcGLi5UKZJTiWQQpNxqcNUbpH//JM7yehplWrFKXdnLaDODv
   ywpY6FfXRKN9UWLaa6yf6UguA4xzMeValueJe6xIG3wu/J0vouYoeT4Oj
   RPcKGMUHv9/r7vXQz9hodeY4zU8reebrBjIPzm+24P1syopTNLClQ6Sfz
   we486zRpTWye3P5RFhfq7Uwan4sRG2W1WkixImtmprRweK6Zv9QK5M4B+
   yPAjue/QsaYppY75cSft0LMRLW+UgX3EqsyBz+Khvxx09VH92T0hviksQ
   mEnUj4MetGPFeANARvxSvWUvmV7CNeLmiEyds7Jh3V4H19Z2qrBv1SHPG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392767508"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="392767508"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:12:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834754923"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834754923"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Nov 2023 12:12:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 34A01A7D; Tue, 28 Nov 2023 22:01:58 +0200 (EET)
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
Subject: [PATCH v3 07/22] pinctrl: equilibrium: Convert to use struct pingroup
Date:   Tue, 28 Nov 2023 21:56:56 +0200
Message-ID: <20231128200155.438722-8-andriy.shevchenko@linux.intel.com>
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

The pin control header provides struct pingroup.
Utilize it instead of open coded variants in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-equilibrium.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index fd59cfdeefac..4ebae516d1b1 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -705,7 +705,7 @@ static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
 	struct device *dev = drvdata->dev;
 	struct device_node *node = dev->of_node;
 	unsigned int *pins, *pinmux, pin_id, pinmux_id;
-	struct group_desc group;
+	struct pingroup group, *grp = &group;
 	struct device_node *np;
 	struct property *prop;
 	int j, err;
@@ -721,49 +721,49 @@ static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
 			of_node_put(np);
 			return err;
 		}
-		group.num_pins = err;
-		group.name = prop->value;
-		pins = devm_kcalloc(dev, group.num_pins, sizeof(*pins), GFP_KERNEL);
+		grp->npins = err;
+		grp->name = prop->value;
+		pins = devm_kcalloc(dev, grp->npins, sizeof(*pins), GFP_KERNEL);
 		if (!pins) {
 			of_node_put(np);
 			return -ENOMEM;
 		}
-		group.pins = pins;
+		grp->pins = pins;
 
-		pinmux = devm_kcalloc(dev, group.num_pins, sizeof(*pinmux), GFP_KERNEL);
+		pinmux = devm_kcalloc(dev, grp->npins, sizeof(*pinmux), GFP_KERNEL);
 		if (!pinmux) {
 			of_node_put(np);
 			return -ENOMEM;
 		}
 
-		for (j = 0; j < group.num_pins; j++) {
+		for (j = 0; j < grp->npins; j++) {
 			if (of_property_read_u32_index(np, "pins", j, &pin_id)) {
 				dev_err(dev, "Group %s: Read intel pins id failed\n",
-					group.name);
+					grp->name);
 				of_node_put(np);
 				return -EINVAL;
 			}
 			if (pin_id >= drvdata->pctl_desc.npins) {
 				dev_err(dev, "Group %s: Invalid pin ID, idx: %d, pin %u\n",
-					group.name, j, pin_id);
+					grp->name, j, pin_id);
 				of_node_put(np);
 				return -EINVAL;
 			}
 			pins[j] = pin_id;
 			if (of_property_read_u32_index(np, "pinmux", j, &pinmux_id)) {
 				dev_err(dev, "Group %s: Read intel pinmux id failed\n",
-					group.name);
+					grp->name);
 				of_node_put(np);
 				return -EINVAL;
 			}
 			pinmux[j] = pinmux_id;
 		}
 
-		err = pinctrl_generic_add_group(drvdata->pctl_dev, group.name,
-						group.pins, group.num_pins,
+		err = pinctrl_generic_add_group(drvdata->pctl_dev,
+						grp->name, grp->pins, grp->npins,
 						pinmux);
 		if (err < 0) {
-			dev_err(dev, "Failed to register group %s\n", group.name);
+			dev_err(dev, "Failed to register group %s\n", grp->name);
 			of_node_put(np);
 			return err;
 		}
-- 
2.43.0.rc1.1.gbec44491f096

