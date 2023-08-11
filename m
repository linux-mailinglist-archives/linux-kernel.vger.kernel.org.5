Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A00778E98
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjHKMCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHKMCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:02:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535AE273E;
        Fri, 11 Aug 2023 05:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691755354; x=1723291354;
  h=from:to:cc:subject:date:message-id;
  bh=B0O4hi7hQYoBUUzuAn//fKEUpIesDWRIrAPu2Jc+J+w=;
  b=QgmhZyq/G2Ew4KsGooG5O+DvswBWYvdrzE3fmWDSOP4iyxYNNSRHjKVp
   RayLQmumS7xa3vuSoq+Q0fa+gNn/0Y24sM/XXLnItZXqReD38pJf2kPGI
   n3D5/rjxSoDg22GT0b2rDqA0vXiui8u/zLd4nSmVVtK68C2PW9cK2EaTE
   K4TGhPnkuk4d+mMDNUcjWaogpm+gxHwStaCCPZCnd644l/8v4sb7RW4qK
   VEGvC+c3RWznKCWGBMmTXySURWfNTlSbgfjP0fyVeliKL+CrIaArGlgmH
   K2nHHrv6s5Ds+cwAVxSBNTBkXEzIF60i88cH4gaJdDz4QPZ/UXBdyX8e9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="438000649"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="438000649"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 05:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906420504"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="906420504"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2023 05:02:30 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load
Date:   Fri, 11 Aug 2023 17:32:20 +0530
Message-Id: <20230811120220.31578-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When built with CONFIG_INTEL_MID_WATCHDOG=m, currently the driver
needs to be loaded manually, for the lack of module alias.
This causes unintended resets in cases where watchdog timer is
set-up by bootloader and the driver is not explicitly loaded.
Add MODULE_ALIAS() to load the driver automatically at boot and
avoid this issue.

Fixes: 87a1ef8058d9 ("watchdog: add Intel MID watchdog driver support")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 9b2173f765c8..fb7fae750181 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -203,3 +203,4 @@ module_platform_driver(mid_wdt_driver);
 MODULE_AUTHOR("David Cohen <david.a.cohen@linux.intel.com>");
 MODULE_DESCRIPTION("Watchdog Driver for Intel MID platform");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:intel_mid_wdt");
-- 
2.17.1

