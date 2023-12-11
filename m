Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A3980DA83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjLKTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbjLKTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:03:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7D10B;
        Mon, 11 Dec 2023 11:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321423; x=1733857423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dl5meZK/9OQqeSluMo8zI6v5kxMv/grswCooUcDxnbw=;
  b=B8MzZACmW9ENGnghUSffSx/RWhP2voYL1wo5+hKymxDztamcXxp0ub+l
   mzz5CcP0PUivuap6fHey9k3zIu+DDOdioHu6/0ImnxHdKYr+sXRaI9hmp
   OT/m5QD5/iOpya/lZDA7UIWIPB+qxUyQOolD2tU7GDBVEdQxT9d6Owxto
   D6RDNKGF1sOqP2vxCBoHwsltxm9tZFLcqLBGrJPCWs+Vjy0oAo3FUmIkD
   IDu6b1B/dtBdfSXDd5uo9O3RrEpQMjJpfKoAFVUzsGq9Ef45cGq/ExW8e
   PVyYHnlXXc4tOcRGb316KSTawnDkAGeo/fFNe+rsWupoMSb21jWPAplzq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="379692588"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="379692588"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946445109"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946445109"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2023 11:03:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF69A30D; Mon, 11 Dec 2023 21:03:23 +0200 (EET)
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
Subject: [PATCH v5 11/13] pinctrl: renesas: Convert to use grp member
Date:   Mon, 11 Dec 2023 20:58:04 +0200
Message-ID: <20231211190321.307330-12-andriy.shevchenko@linux.intel.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/renesas/pinctrl-rza1.c  |  2 +-
 drivers/pinctrl/renesas/pinctrl-rza2.c  | 10 +++++-----
 drivers/pinctrl/renesas/pinctrl-rzg2l.c |  4 ++--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

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
index 68fcc2a4efbc..f01aa51b00c4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
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
index eb304fab1796..0767a5ac23e0 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
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

