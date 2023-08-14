Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451BF77BDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjHNQM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjHNQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:12:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761AE106;
        Mon, 14 Aug 2023 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692029542; x=1723565542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gNgwqDPrxhz8wCl3Okr47BvVxVZ4M+5ATpm+bjH86Rc=;
  b=GmUc5Z995+4/0ESlidWBZVZ9mrduJ/xKSYtkx0p2gSWdzarbxKAU34Pf
   y8n17x4IcnBxgvpMTOv4Yd6D27G0T+I+Z1IlB8TS3RPP+cLfqJF/ZrEwD
   ldsNuaP/TOlcSDJTX3llEyMAXdYtpOnATSs+LOfOTq8qEyc9DogDf1qXH
   Y+JgO5RP3vcr5SRYYqM8fgJ8hsIVJdYl07lJnOsgKUJFpe91ZSqilid8y
   58HsaMvfGY/6ikBRfRoKlZHG/9sXQ3mPr0Hdc+mWemlFPYoosLpJvWTVY
   Gny4oaNIicXaAyxZmtXn+gjj79Xp/RCP6S8cis5mNY1/odSs6IivCUqe7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357033678"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357033678"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 09:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="857137237"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="857137237"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2023 09:06:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B12A733B; Mon, 14 Aug 2023 19:14:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 1/1] PCI: Update the devres documentation regarding to pcim_*()
Date:   Mon, 14 Aug 2023 19:14:01 +0300
Message-Id: <20230814161401.12007-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were many changes to PCI core in scope of managed resources APIs.
Update documentation to list the current state of affairs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/driver-model/devres.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 8be086b3f829..c5f99d834ec5 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -322,10 +322,8 @@ IOMAP
   devm_platform_ioremap_resource_byname()
   devm_platform_get_and_ioremap_resource()
   devm_iounmap()
-  pcim_iomap()
-  pcim_iomap_regions()	: do request_region() and iomap() on multiple BARs
-  pcim_iomap_table()	: array of mapped addresses indexed by BAR
-  pcim_iounmap()
+
+  Note: For the PCI devices the specific pcim_*() functions may be used, see below.
 
 IRQ
   devm_free_irq()
@@ -392,8 +390,16 @@ PCI
   devm_pci_alloc_host_bridge()  : managed PCI host bridge allocation
   devm_pci_remap_cfgspace()	: ioremap PCI configuration space
   devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
+
   pcim_enable_device()		: after success, all PCI ops become managed
+  pcim_iomap()			: do iomap() on a single BAR
+  pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
+  pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
+  pcim_iomap_table()		: array of mapped addresses indexed by BAR
+  pcim_iounmap()		: do iounmap() on a single BAR
+  pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
   pcim_pin_device()		: keep PCI device enabled after release
+  pcim_set_mwi()		: enable Memory-Write-Invalidate PCI transaction
 
 PHY
   devm_usb_get_phy()
-- 
2.40.0.1.gaa8946217a0b

