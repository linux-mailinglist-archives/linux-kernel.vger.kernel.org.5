Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06377AF3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjIZTJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjIZTI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:08:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F59619C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695755331; x=1727291331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CMTUrZR7eBDMX5WaZoCRwZyAKgtxTJw9+oHxgnQvwTc=;
  b=nuTDCbkJRvDmzZ4p1hm1bNueyynmaa3R85FmWecvA3ZEB5AhpDby9/86
   PQ9T+uZIOZWeU2zFZ9f6dXxj0RsFNlxSwqENvpAXssGYDkgNmlW1Z9aQH
   oTKXvNHH9pFbzSzKOGlGr53fYb7Vjs1phnKh6gw8GBWMyzmIISNLY6nts
   6SMAbVQ4A0NY7KtBVPir8/LytcoE6KW0W8sHSBFJfA9nhbFodhTddxUKu
   5rALaIozGhhA33Zj8YebPjpu/2FBJaj9MiuKYCFyzDS0Wi8xFGh4eEIIF
   V/WGItRzNIpHNYl/0LUphex1hWXwptEa8vbgthr+tR8QxT088jLG8DBye
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412562229"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="412562229"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784056117"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="784056117"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2023 12:08:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 069C311D; Tue, 26 Sep 2023 22:08:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/4] mfd: lpc_ich: Make struct lpc_ich_priv use enum for chipset member
Date:   Tue, 26 Sep 2023 22:08:31 +0300
Message-Id: <20230926190834.932233-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a specific enum for the supported chipsets.
Make struct lpc_ich_priv use better type for the chipset member.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/lpc_ich.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 7b1c597b6879..58da6c95c462 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -85,19 +85,6 @@
 #define wdt_mem_res(i) wdt_res(ICH_RES_MEM_OFF, i)
 #define wdt_res(b, i) (&wdt_ich_res[(b) + (i)])
 
-struct lpc_ich_priv {
-	int chipset;
-
-	int abase;		/* ACPI base */
-	int actrl_pbase;	/* ACPI control or PMC base */
-	int gbase;		/* GPIO base */
-	int gctrl;		/* GPIO control */
-
-	int abase_save;		/* Cached ACPI base value */
-	int actrl_pbase_save;		/* Cached ACPI control or PMC base value */
-	int gctrl_save;		/* Cached GPIO control value */
-};
-
 static struct resource wdt_ich_res[] = {
 	/* ACPI - TCO */
 	{
@@ -293,6 +280,19 @@ enum lpc_chipsets {
 	LPC_COUGARMOUNTAIN,/* Cougar Mountain SoC*/
 };
 
+struct lpc_ich_priv {
+	enum lpc_chipsets chipset;
+
+	int abase;		/* ACPI base */
+	int actrl_pbase;	/* ACPI control or PMC base */
+	int gbase;		/* GPIO base */
+	int gctrl;		/* GPIO control */
+
+	int abase_save;		/* Cached ACPI base value */
+	int actrl_pbase_save;		/* Cached ACPI control or PMC base value */
+	int gctrl_save;		/* Cached GPIO control value */
+};
+
 static struct lpc_ich_info lpc_chipset_info[] = {
 	[LPC_ICH] = {
 		.name = "ICH",
-- 
2.40.0.1.gaa8946217a0b

