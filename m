Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0806803965
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbjLDQCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjLDQCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:02:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA783;
        Mon,  4 Dec 2023 08:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701705747; x=1733241747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=369hT2RdaeQdkkRIYwcHHDkywQmjX9HmaXJZaM+vdg4=;
  b=bkMbRs1UH2vRg8FNuswtjS7nggOZIIhSmU88yvQb1FJWVKqmdl6MbtWx
   1wLgXNTELjyJFfouBmEybAmRfjYi3BbvyZkkLYdJx/NVSqbSB1HuNrVAl
   CI0QsCfr7zwhK9V1rwFlR3KQ3NwQHkxZfpfUAYuhYe2Xci5iEHVHpFiAQ
   Bk1YibZWI2zRvv3bvwtM3vvuncwyjDuUUgFtm5QAmgIAC+OTnhHPbR98s
   weWRjGeE7ETn3M4LPbCkcJLMhtKdszEzivYV9zdFCwXOwLvXeqGqzX3xL
   lYLpJbufsZL0F/C5wNVVv5sK9pPO8JyDnXMpzbtiO/1s8xrFCWXXtiiUW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="807859"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="807859"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 08:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="774297197"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="774297197"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 Dec 2023 08:00:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 02DB6315; Mon,  4 Dec 2023 18:00:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org
Cc:     Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Subject: [PATCH v1 1/5] pinctrl: renesas: Mark local variable with const in ->set_mux()
Date:   Mon,  4 Dec 2023 17:56:32 +0200
Message-ID: <20231204160033.1872569-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231204160033.1872569-1-andriy.shevchenko@linux.intel.com>
References: <20231204160033.1872569-1-andriy.shevchenko@linux.intel.com>
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

We are not going to change pins in the ->set_mux() callback. Mark
the local variable with a const qualifier. While at it, make it
also unsigned.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index aed59c53207c..68fcc2a4efbc 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -273,7 +273,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
-	int *pins;
+	const unsigned int *pins;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 21d7d5ac8c4a..eb304fab1796 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -165,7 +165,7 @@ static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
-	int *pins;
+	const unsigned int *pins;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
-- 
2.43.0.rc1.1.gbec44491f096

