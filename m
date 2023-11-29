Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467B57FDC64
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjK2QPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjK2QPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:15:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C7DD6C;
        Wed, 29 Nov 2023 08:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701274515; x=1732810515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uSEXFAfigJrZCoXVJ4ZtMtwaJ+4f5OEieqGUBtBbV0=;
  b=EUur5zgdw0sHryb1EIcaXGIhv7lpKJbDN7o0UI7pUQHeLa/tXN+km1dm
   g/nKztSx1Une4uuEKGQ3XTZdbhMjhiTKL2g6mUVSXkHVM1ju6C8zKixkf
   nmVG1mAQ+B2kRpCR6lTW8wJ4mosJyPLcn5NvVo7PSMgWC9e5wtIfv03z3
   HqdHwyjErXfDMn4klYAQyPkY78GHsEp7tumdhMeRZXcs+Bd/OrtoNH9JE
   fUDJmmAxZzbl1AIaQ7zbz4xJFem5UBN0Zc1EbvvQTJ3Qbs/dYD0W+c/jt
   myHumjktzAyxKU5ARO/Hl7dNfaB9bIvCGOPvoQMcYaLBVlD9fVLUT5UMi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373372556"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="373372556"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 08:15:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892498853"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="892498853"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2023 08:15:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E6C2968; Wed, 29 Nov 2023 18:15:01 +0200 (EET)
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
Subject: [PATCH v4 03/23] pinctrl: equilibrium: Unshadow error code of of_property_count_u32_elems()
Date:   Wed, 29 Nov 2023 18:06:26 +0200
Message-ID: <20231129161459.1002323-4-andriy.shevchenko@linux.intel.com>
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

of_property_count_u32_elems() might return an error code in some cases.
It's naturally better to assign what it's returned to the err variable
and supply the real code to the upper layer(s). Besides that, it's a
common practice to avoid assignments for the data in cases when we know
that the error condition happened. Refactor the code accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-equilibrium.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index 5b5ddf7e5d0e..54755b583d3f 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -715,12 +715,13 @@ static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
 		if (!prop)
 			continue;
 
-		group.num_pins = of_property_count_u32_elems(np, "pins");
-		if (group.num_pins < 0) {
+		err = of_property_count_u32_elems(np, "pins");
+		if (err < 0) {
 			dev_err(dev, "No pins in the group: %s\n", prop->name);
 			of_node_put(np);
-			return -EINVAL;
+			return err;
 		}
+		group.num_pins = err;
 		group.name = prop->value;
 		group.pins = devm_kcalloc(dev, group.num_pins,
 					  sizeof(*(group.pins)), GFP_KERNEL);
-- 
2.43.0.rc1.1.gbec44491f096

