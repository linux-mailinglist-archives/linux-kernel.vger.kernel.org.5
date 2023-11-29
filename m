Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AFD7FDC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjK2QPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjK2QPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:15:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9A810C9;
        Wed, 29 Nov 2023 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701274525; x=1732810525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RBBNaq8JkBXX/xi1T1i+nuBSrA2JxDqwa2kK1y8NL3Y=;
  b=m7s7+BC6rbaeopvaY+99UK6CFILTj5DPwfvQqJpyXDBJfdi5sHn5ZYZo
   ylmOODXHxH4abVwekCSVHfR6Qk0lb45jg28azj3ckC2USkVo1EI56vKhq
   +cZHOdC7ukOX0b+NlioI01wPmAgU5M7qr4Qile8GRN9eYpBOhSEpgqkNZ
   eTD6ldxduM25Ffrm0E4OaQ1aY6MgQonW6b7eCSUiX1t996oylhPb37ckK
   QdKOJ3J8b0gUMro1s5+mxRLMSADb74ZZs59DaqamzsfTi9/sV8I3Zel2f
   eKznf+zKImvizpWOQo1vxn73KHYOW4Ndzdi1Io1guemeFIu23YMvH3QNj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373372683"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="373372683"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 08:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892498876"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="892498876"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2023 08:15:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A94BA7D; Wed, 29 Nov 2023 18:15:01 +0200 (EET)
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
Subject: [PATCH v4 06/23] pinctrl: core: Make pins const unsigned int pointer in struct group_desc
Date:   Wed, 29 Nov 2023 18:06:29 +0200
Message-ID: <20231129161459.1002323-7-andriy.shevchenko@linux.intel.com>
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

It's unclear why it's not a const unsigned int pointer from day 1.
Make the pins member const unsigned int pointer in struct group_desc.
Update necessary APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c | 2 +-
 drivers/pinctrl/core.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 9fa17c498a11..7040d8cea0c3 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -640,7 +640,7 @@ static int pinctrl_generic_group_name_to_selector(struct pinctrl_dev *pctldev,
  * Note that the caller must take care of locking.
  */
 int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
-			      int *pins, int num_pins, void *data)
+			      const unsigned int *pins, int num_pins, void *data)
 {
 	struct group_desc *group;
 	int selector, error;
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 530370443c19..75797c0b4fde 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -203,7 +203,7 @@ struct pinctrl_maps {
  */
 struct group_desc {
 	const char *name;
-	int *pins;
+	const unsigned int *pins;
 	int num_pins;
 	void *data;
 };
@@ -222,7 +222,7 @@ struct group_desc *pinctrl_generic_get_group(struct pinctrl_dev *pctldev,
 					     unsigned int group_selector);
 
 int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
-			      int *gpins, int ngpins, void *data);
+			      const unsigned int *pins, int num_pins, void *data);
 
 int pinctrl_generic_remove_group(struct pinctrl_dev *pctldev,
 				 unsigned int group_selector);
-- 
2.43.0.rc1.1.gbec44491f096

