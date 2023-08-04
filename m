Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9574770354
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjHDOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHDOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:39:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CEB46B2;
        Fri,  4 Aug 2023 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691159956; x=1722695956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BdfhnFCNUuI8DazLAkJD8/rcKyTlng09fRJwpWeZK0U=;
  b=ishrlyCbFLEzgm8NDTSW2RxcLMh7r2PXe7+mF0jAcTLdzmF0VCbkzUuK
   8V4ZQfWF7I5ba9VJ43+C2AJnSTEN5CR/VbncC/DwJTXfjhQ91SivIjLdG
   YtbVR+x9+tgCkPKFM8P4ZoqbEsscmcKsSSsb1z0/ewzU6wY+Nn2PvE6DS
   e9j0vbT3RaZtu7RVzElgRnfVb420CqtFJHXVHLKLFi8RupwgylFLO1XNl
   eevTCUxJUOZo/GUf6lO4JzRzdxy89QDfmXUdt8f2zCfe+/V1IAFthyq9o
   nBIp5AJJxPrV3OBUnvTd3TuyZTDPySWugP08pg/Wi9g5KIMEDmFhoihSE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373816836"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="373816836"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="723678947"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="723678947"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Aug 2023 07:39:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9D1C5F4D; Fri,  4 Aug 2023 17:39:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 4/4] clk: ti: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date:   Fri,  4 Aug 2023 17:39:10 +0300
Message-Id: <20230804143910.15504-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230804143910.15504-1-andriy.shevchenko@linux.intel.com>
References: <20230804143910.15504-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded functionality of kstrdup_and_replace() with a call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/ti/clk.c     | 4 ++--
 drivers/clk/ti/clkctrl.c | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 3d636938a739..1862958ab412 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/list.h>
 #include <linux/regmap.h>
+#include <linux/string_helpers.h>
 #include <linux/memblock.h>
 #include <linux/device.h>
 
@@ -123,10 +124,9 @@ static struct device_node *ti_find_clock_provider(struct device_node *from,
 	const char *n;
 	char *tmp;
 
-	tmp = kstrdup(name, GFP_KERNEL);
+	tmp = kstrdup_and_replace(name, '-', '_', GFP_KERNEL);
 	if (!tmp)
 		return NULL;
-	strreplace(tmp, '-', '_');
 
 	/* Node named "clock" with "clock-output-names" */
 	for_each_of_allnodes_from(from, np) {
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 8c40f10280b7..607e34d8e289 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -13,6 +13,7 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 #include <linux/delay.h>
+#include <linux/string_helpers.h>
 #include <linux/timekeeping.h>
 #include "clock.h"
 
@@ -473,11 +474,11 @@ static const char * __init clkctrl_get_name(struct device_node *np)
 	const int prefix_len = 11;
 	const char *compat;
 	const char *output;
+	const char *end;
 	char *name;
 
 	if (!of_property_read_string_index(np, "clock-output-names", 0,
 					   &output)) {
-		const char *end;
 		int len;
 
 		len = strlen(output);
@@ -491,13 +492,13 @@ static const char * __init clkctrl_get_name(struct device_node *np)
 
 	of_property_for_each_string(np, "compatible", prop, compat) {
 		if (!strncmp("ti,clkctrl-", compat, prefix_len)) {
+			end = compat + prefix_len;
 			/* Two letter minimum name length for l3, l4 etc */
-			if (strnlen(compat + prefix_len, 16) < 2)
+			if (strnlen(end, 16) < 2)
 				continue;
-			name = kasprintf(GFP_KERNEL, "%s", compat + prefix_len);
+			name = kstrdup_and_replace(end, '-', '_', GFP_KERNEL);
 			if (!name)
 				continue;
-			strreplace(name, '-', '_');
 
 			return name;
 		}
-- 
2.40.0.1.gaa8946217a0b

