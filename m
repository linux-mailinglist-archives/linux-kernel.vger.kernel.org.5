Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BD17FC3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbjK1S4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjK1S43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:56:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6BC131;
        Tue, 28 Nov 2023 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701197795; x=1732733795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bdi2sZDxRkvTBazv5rHTQmA65z9oE6nNf4G+LkhInvo=;
  b=e3lCvlbR+QoEwqtaHJBl50gKwMhyLFuLa2xjlBNEhwONpzywLgOsTF8/
   NcWSl1RUVTEtU04HBHdlfFkEe5Kq6aZ5YKvO9hZqmu88FMTHfes48Dzst
   EF8WAXMEnfaWPnRshu6o1Ysp5bkbgHFFDcbpGMtwe5dk0+C6knyrDFeae
   FRYM0Mzfg37SClIZgp3F+abMs4xdpdHshTCw/i9eGVcgPV9a7mLyZsyQS
   VsvIgizxzdu1FZeC//R0ya8agld8al9n8LhM0WhZ4IJOBjDZyNKHHp8c8
   V9N5VJ1j+WSlcOBi2zVC2FJZ3pamyihO3j63aqBwosVGYTsfu299EBNZg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372366950"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372366950"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892165780"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892165780"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2023 10:56:10 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/6] platform/x86/intel/tpmi: Add additional TPMI header fields
Date:   Tue, 28 Nov 2023 10:56:00 -0800
Message-Id: <20231128185605.3027653-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
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

TPMI information header added additional fields in version 2. Some of the
reserved fields in version 1 are used to define new fields.
Parse new fields and export as part of platform data. These fields include:
- PCI segment ID
- Partition ID of the package, useful when more than one Intel VSEC PCI
device per package
- cdie_mask: Mask of all compute dies in this partition

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 11 ++++++++++-
 include/linux/intel_tpmi.h        |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 311abcac894a..c89aa4d14bea 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -128,6 +128,9 @@ struct intel_tpmi_info {
  * @dev:	PCI device number
  * @bus:	PCI bus number
  * @pkg:	CPU Package id
+ * @segment: PCI segment id
+ * @partition: Package Partition id
+ * @cdie_mask: Bitmap of compute dies in the current partition
  * @reserved:	Reserved for future use
  * @lock:	When set to 1 the register is locked and becomes read-only
  *		until next reset. Not for use by the OS driver.
@@ -139,7 +142,10 @@ struct tpmi_info_header {
 	u64 dev:5;
 	u64 bus:8;
 	u64 pkg:8;
-	u64 reserved:39;
+	u64 segment:8;
+	u64 partition:2;
+	u64 cdie_mask:16;
+	u64 reserved:13;
 	u64 lock:1;
 } __packed;
 
@@ -684,6 +690,9 @@ static int tpmi_process_info(struct intel_tpmi_info *tpmi_info,
 	tpmi_info->plat_info.bus_number = header.bus;
 	tpmi_info->plat_info.device_number = header.dev;
 	tpmi_info->plat_info.function_number = header.fn;
+	tpmi_info->plat_info.cdie_mask = header.cdie_mask;
+	tpmi_info->plat_info.partition = header.partition;
+	tpmi_info->plat_info.segment = header.segment;
 
 	iounmap(info_mem);
 
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index ee07393445f9..939663bb095f 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -14,7 +14,10 @@
 
 /**
  * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
+ * @cdie_mask:	Mask of all compute dies in the partition
  * @package_id:	CPU Package id
+ * @partition:  Package partition id when multiple VSEC PCI devices per package
+ * @segment: PCI segment ID
  * @bus_number:	PCI bus number
  * @device_number: PCI device number
  * @function_number: PCI function number
@@ -23,7 +26,10 @@
  * struct is used to return data via tpmi_get_platform_data().
  */
 struct intel_tpmi_plat_info {
+	u16 cdie_mask;
 	u8 package_id;
+	u8 partition;
+	u8 segment;
 	u8 bus_number;
 	u8 device_number;
 	u8 function_number;
-- 
2.41.0

