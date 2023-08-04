Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A590C770348
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjHDOjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHDOjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:39:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB24146B1;
        Fri,  4 Aug 2023 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691159951; x=1722695951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=treqQoCApe7X7F3bCvmb79fj9fFVPi/mHsyYWBfo0dA=;
  b=HCVkTWEbOlR/t7wlztoYRtqzjQCzRTatZsL988vf3E3bTQAkW4ZJ8+DS
   1EeQTzDB/KbjFdROgHxYZA1ZKz4sSfZO03QNtDzL5pO4JsrROFMKX+CDn
   MxzexTaiF2tsZZ9BafU/hTzPB4PvI3T1b0WFLAvbXWQqJYYKrwMBmx6Oi
   MEJY/Xu3mUvk2UqhEHrilQq9eX5T7tZO+tXvc8u8zlJ03neM1us44xqeG
   z6dmtNhgJ59Cb0VL1Ww6BSu1U0pzLr4Ll8desPLZkXlojnTfQvc/hoDYJ
   LgC2PNmxkohRbpzkPqFl8Bhwalf6T5CRT6q33fD00S7xp7OfFkP+xm1cS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="436487285"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="436487285"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="795444753"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="795444753"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2023 07:39:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8EC2BF12; Fri,  4 Aug 2023 17:39:14 +0300 (EEST)
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
Subject: [PATCH v2 3/4] clk: tegra: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date:   Fri,  4 Aug 2023 17:39:09 +0300
Message-Id: <20230804143910.15504-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230804143910.15504-1-andriy.shevchenko@linux.intel.com>
References: <20230804143910.15504-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded functionality of kstrdup_and_replace() with a call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/tegra/clk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 333a3ff0db98..19037346f522 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset-controller.h>
-#include <linux/string.h>
+#include <linux/string_helpers.h>
 
 #include <soc/tegra/fuse.h>
 
@@ -384,12 +384,10 @@ static struct device_node *tegra_clk_get_of_node(struct clk_hw *hw)
 	struct device_node *np;
 	char *node_name;
 
-	node_name = kstrdup(hw->init->name, GFP_KERNEL);
+	node_name = kstrdup_and_replace(hw->init->name, '_', '-', GFP_KERNEL);
 	if (!node_name)
 		return NULL;
 
-	strreplace(node_name, '_', '-');
-
 	for_each_child_of_node(tegra_car_np, np) {
 		if (!strcmp(np->name, node_name))
 			break;
-- 
2.40.0.1.gaa8946217a0b

