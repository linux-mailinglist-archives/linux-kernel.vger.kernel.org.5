Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929668039AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjLDQH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjLDQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:07:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA26A9;
        Mon,  4 Dec 2023 08:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701706082; x=1733242082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CyMweha2ZvuLisSoPmNJvwBvM8UVF+24ES7V+e13w7A=;
  b=nJ/puh3YkMMr4ow4roTP8fCrGxx42pg87in85xDgYJvB1y7Fo6YvlfMY
   OcV83eHYNa08727X6W0hqakN8VMXMRtLmXdt2nI7LeCrUW6QAb8AUTgWY
   dUMxRDPuRiRtWvAK0sPRpEfT1lB8bTbeKjiAZCTzm+mXPjhgzcZsoFPEw
   acwteRsmb+IjskBk9M3z5VWGUb/x9BdNELRpdug3hCRR3sX+kvNuI+SQ5
   p3cFXC/9gXbmKcKn+T7sNrO2TlCrBKmFYBdZ++VZorXumfPjcLe/3P5hW
   Sf0X/iMaMIUqE8K+ys4ZQwcTJ6ThA7DLG3r3XjtWseqVaK1KhswL2LkD3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="632533"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="632533"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 08:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861422786"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="861422786"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 08:07:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C299A7D; Mon,  4 Dec 2023 18:00:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org
Cc:     Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Subject: [PATCH v1 5/5] pinctrl: nuvoton: Convert to use struct pingroup and PINCTRL_PINGROUP()
Date:   Mon,  4 Dec 2023 17:56:36 +0200
Message-ID: <20231204160033.1872569-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231204160033.1872569-1-andriy.shevchenko@linux.intel.com>
References: <20231204160033.1872569-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin control header provides struct pingroup and PINCTRL_PINGROUP() macro.
Utilize them instead of open coded variants in the driver.

Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
index 0cff44b07b29..4589900244c7 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -474,9 +474,8 @@ enum {
 #undef WPCM450_GRP
 };
 
-static struct group_desc wpcm450_groups[] = {
-#define WPCM450_GRP(x) { .name = #x, .pins = x ## _pins, \
-			.num_pins = ARRAY_SIZE(x ## _pins) }
+static struct pingroup wpcm450_groups[] = {
+#define WPCM450_GRP(x) PINCTRL_PINGROUP(#x, x ## _pins, ARRAY_SIZE(x ## _pins))
 	WPCM450_GRPS
 #undef WPCM450_GRP
 };
@@ -852,7 +851,7 @@ static int wpcm450_get_group_pins(struct pinctrl_dev *pctldev,
 				  const unsigned int **pins,
 				  unsigned int *npins)
 {
-	*npins = wpcm450_groups[selector].num_pins;
+	*npins = wpcm450_groups[selector].npins;
 	*pins  = wpcm450_groups[selector].pins;
 
 	return 0;
@@ -901,7 +900,7 @@ static int wpcm450_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	struct wpcm450_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
 	wpcm450_setfunc(pctrl->gcr_regmap, wpcm450_groups[group].pins,
-			wpcm450_groups[group].num_pins, function);
+			wpcm450_groups[group].npins, function);
 
 	return 0;
 }
-- 
2.43.0.rc1.1.gbec44491f096

