Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B9F7FC4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345254AbjK1UER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbjK1UEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:04:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CE11BC1;
        Tue, 28 Nov 2023 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701201858; x=1732737858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JWDRh374Weqf1RM/wPs/cLPeGRfYhQLZdPEPrnsQ9gU=;
  b=dKG3eci0PdtkrudTqQLRCDTGLKeLV5tWEho1QLX0lO86cmWs8sQCQ4X5
   qMm1253GjFeEfKa1YUreIEt3vl3nWF1wSPLTexl6QVQZvs8WZ1l1ppqKX
   3UOnvGiJjIf4Xd1jT871OQ82yFtG5Zi3QmcXGCrK17j+HFJhl93Zos9+f
   zuLLByNkLe4yzwvZKGtH2e3LuX5l46tPI6BMTbnvIr3g3UCYLEU5ERteb
   Kau0V4Kuf6sqQRT5jdRvn/YaSJsPPiLsZ4wFmUt7SPTqkktitGnNk6HoX
   XS4kF8gYeYXRglY1pl6ua0H4EANOnLACGhf+1lFK+C7SwcKhv47QiNqID
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6217723"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6217723"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:02:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797687941"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797687941"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2023 12:02:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2835BA5F; Tue, 28 Nov 2023 22:01:58 +0200 (EET)
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
Subject: [PATCH v3 06/22] pinctrl: core: Make pins const in struct group_desc
Date:   Tue, 28 Nov 2023 21:56:55 +0200
Message-ID: <20231128200155.438722-7-andriy.shevchenko@linux.intel.com>
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

It's unclear why it's not a const from day 1. Make the pins member
const in struct group_desc. Update necessary APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c | 2 +-
 drivers/pinctrl/core.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index f2977eb65522..d20e3aad923e 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -642,7 +642,7 @@ static int pinctrl_generic_group_name_to_selector(struct pinctrl_dev *pctldev,
  * Note that the caller must take care of locking.
  */
 int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
-			      int *pins, int num_pins, void *data)
+			      const int *pins, int num_pins, void *data)
 {
 	struct group_desc *group;
 	int selector, error;
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 530370443c19..01ea1ce99fe8 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -203,7 +203,7 @@ struct pinctrl_maps {
  */
 struct group_desc {
 	const char *name;
-	int *pins;
+	const int *pins;
 	int num_pins;
 	void *data;
 };
@@ -222,7 +222,7 @@ struct group_desc *pinctrl_generic_get_group(struct pinctrl_dev *pctldev,
 					     unsigned int group_selector);
 
 int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
-			      int *gpins, int ngpins, void *data);
+			      const int *pins, int num_pins, void *data);
 
 int pinctrl_generic_remove_group(struct pinctrl_dev *pctldev,
 				 unsigned int group_selector);
-- 
2.43.0.rc1.1.gbec44491f096

