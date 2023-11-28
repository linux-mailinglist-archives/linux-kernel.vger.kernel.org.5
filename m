Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC767FC4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjK1UEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345042AbjK1UEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:04:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D919B6;
        Tue, 28 Nov 2023 12:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701201853; x=1732737853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=walg+bhqrPK3cQwsRjpjz8OXsd0uvMsmlUbhNg5FKAY=;
  b=Wuo+/33UnWEhlerXV1qYiUWWzZCdV2n0ZkXZq0YWTASSWZ0vXKvaMJZp
   KvgqDbhqxOpInloPGII/CxyoocE5SRfPXJV8Kws/Pnt0658IHf5acSW6p
   BFL79KWRNFfrFrR8PIXDYt0FTVji7o4Vmz8mwyiuGzovUpUnS74Yus1IG
   HZ/xPj4wcmHsKfyzl35jBEaBX3PH3A628FtM0hqSbOT0KpMyc1MH6K9ZN
   m8gsM8CfoBiqbbsLVhB2LpGtCei1Tv47ggxMBbXXO8nys3P7fxUkHxwby
   W5YjcXRh/ZCebSWvKTbpR1bVLdVEDaF644vgjE7sfsF4JFFfIicPMHjPE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457345649"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457345649"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:02:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="772420469"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="772420469"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2023 12:02:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ED247BFC; Tue, 28 Nov 2023 22:01:58 +0200 (EET)
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
Subject: [PATCH v3 20/22] pinctrl: renesas: Convert to use grp member
Date:   Tue, 28 Nov 2023 21:57:09 +0200
Message-ID: <20231128200155.438722-21-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231128200155.438722-1-andriy.shevchenko@linux.intel.com>
References: <20231128200155.438722-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert drivers to use grp member embedded in struct group_desc.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/renesas/pinctrl-rza1.c  |  2 +-
 drivers/pinctrl/renesas/pinctrl-rza2.c  | 10 +++++-----
 drivers/pinctrl/renesas/pinctrl-rzg2l.c |  6 +++---
 drivers/pinctrl/renesas/pinctrl-rzv2m.c |  6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index ab334de89b69..b03f22c54ca8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -1131,7 +1131,7 @@ static int rza1_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
 		return -EINVAL;
 
 	mux_confs = (struct rza1_mux_conf *)func->data;
-	for (i = 0; i < grp->num_pins; ++i) {
+	for (i = 0; i < grp->grp.npins; ++i) {
 		int ret;
 
 		ret = rza1_pin_mux_single(rza1_pctl, &mux_confs[i]);
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index 990b96d45967..af689d7c117f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -447,15 +447,15 @@ static int rza2_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
 
 	psel_val = func->data;
 
-	for (i = 0; i < grp->num_pins; ++i) {
+	for (i = 0; i < grp->grp.npins; ++i) {
 		dev_dbg(priv->dev, "Setting P%c_%d to PSEL=%d\n",
-			port_names[RZA2_PIN_ID_TO_PORT(grp->pins[i])],
-			RZA2_PIN_ID_TO_PIN(grp->pins[i]),
+			port_names[RZA2_PIN_ID_TO_PORT(grp->grp.pins[i])],
+			RZA2_PIN_ID_TO_PIN(grp->grp.pins[i]),
 			psel_val[i]);
 		rza2_set_pin_function(
 			priv->base,
-			RZA2_PIN_ID_TO_PORT(grp->pins[i]),
-			RZA2_PIN_ID_TO_PIN(grp->pins[i]),
+			RZA2_PIN_ID_TO_PORT(grp->grp.pins[i]),
+			RZA2_PIN_ID_TO_PIN(grp->grp.pins[i]),
 			psel_val[i]);
 	}
 
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index aed59c53207c..3cfe4558eb92 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -273,7 +273,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
-	int *pins;
+	const int *pins;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
@@ -283,9 +283,9 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	psel_val = func->data;
-	pins = group->pins;
+	pins = group->grp.pins;
 
-	for (i = 0; i < group->num_pins; i++) {
+	for (i = 0; i < group->grp.npins; i++) {
 		unsigned int *pin_data = pctrl->desc.pins[pins[i]].drv_data;
 		u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 		u32 pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 21d7d5ac8c4a..eb66e306b8c8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -165,7 +165,7 @@ static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
-	int *pins;
+	const int *pins;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
@@ -175,9 +175,9 @@ static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	psel_val = func->data;
-	pins = group->pins;
+	pins = group->grp.pins;
 
-	for (i = 0; i < group->num_pins; i++) {
+	for (i = 0; i < group->grp.npins; i++) {
 		dev_dbg(pctrl->dev, "port:%u pin: %u PSEL:%u\n",
 			RZV2M_PIN_ID_TO_PORT(pins[i]), RZV2M_PIN_ID_TO_PIN(pins[i]),
 			psel_val[i]);
-- 
2.43.0.rc1.1.gbec44491f096

