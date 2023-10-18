Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C6E7CEBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjJRXRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJRXQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C8121;
        Wed, 18 Oct 2023 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670987; x=1729206987;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=p5ztckKHu6DHKZF6FlfrwxP7NWNq4pJFfIG0FrOJ2cE=;
  b=fhXUaD0qvsAcqmpSHZGKCV59S+lM6cQINT3xo27bz3uPf13w5YF0wPNc
   40J5nPKEhFIIGpih0ClJWw8O6yBfXTnQvJSCRjjiEIcXOBIYiSIrbJTOg
   X55yQBkFDZITHdfS851Kz8BiABoXz14xizwZ8pFPux8m+rxNPOJIDO+3c
   leq1oFiFW6zuEIxf7o6x029mdVyC9qyp7pKoY+UtoAsbrWk1pBj4X+SY/
   3I/fYB3xbNjZm5+KvsVFgS/FH752kCzZ7sudP7OMC+zLpoxAtFLUUYSp7
   +s942ueg35qQH14SOvBh0Nc+/jdm32dX/wx9260hLfGDD5myoSPzG1Vc2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452605957"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452605957"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756782172"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756782172"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:25 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id 50744580DD4;
        Wed, 18 Oct 2023 16:16:25 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V4 06/17] platform/x86/intel/pmt: Add header to struct intel_pmt_entry
Date:   Wed, 18 Oct 2023 16:16:13 -0700
Message-Id: <20231018231624.1044633-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018231624.1044633-1-david.e.box@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMT header is passed to several functions. Instead, store the header in
struct intel_pmt_entry which is also passed to these functions and shorten
the argument list. This simplifies the calls in preparation for later
changes.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V4 - No change

V3 - No change

V2 - No change

 drivers/platform/x86/intel/pmt/class.c     |  8 +++-----
 drivers/platform/x86/intel/pmt/class.h     | 16 ++++++++--------
 drivers/platform/x86/intel/pmt/crashlog.c  |  2 +-
 drivers/platform/x86/intel/pmt/telemetry.c |  2 +-
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 32608baaa56c..142a24e3727d 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -159,12 +159,12 @@ static struct class intel_pmt_class = {
 };
 
 static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
-				    struct intel_pmt_header *header,
 				    struct intel_vsec_device *ivdev,
 				    struct resource *disc_res)
 {
 	struct pci_dev *pci_dev = ivdev->pcidev;
 	struct device *dev = &ivdev->auxdev.dev;
+	struct intel_pmt_header *header = &entry->header;
 	u8 bir;
 
 	/*
@@ -313,7 +313,6 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
 			 struct intel_vsec_device *intel_vsec_dev, int idx)
 {
 	struct device *dev = &intel_vsec_dev->auxdev.dev;
-	struct intel_pmt_header header;
 	struct resource	*disc_res;
 	int ret;
 
@@ -323,16 +322,15 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
 	if (IS_ERR(entry->disc_table))
 		return PTR_ERR(entry->disc_table);
 
-	ret = ns->pmt_header_decode(entry, &header, dev);
+	ret = ns->pmt_header_decode(entry, dev);
 	if (ret)
 		return ret;
 
-	ret = intel_pmt_populate_entry(entry, &header, intel_vsec_dev, disc_res);
+	ret = intel_pmt_populate_entry(entry, intel_vsec_dev, disc_res);
 	if (ret)
 		return ret;
 
 	return intel_pmt_dev_register(entry, ns, dev);
-
 }
 EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_create, INTEL_PMT);
 
diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
index db11d58867ce..e477a19f6700 100644
--- a/drivers/platform/x86/intel/pmt/class.h
+++ b/drivers/platform/x86/intel/pmt/class.h
@@ -18,7 +18,15 @@
 #define GET_BIR(v)		((v) & GENMASK(2, 0))
 #define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
 
+struct intel_pmt_header {
+	u32	base_offset;
+	u32	size;
+	u32	guid;
+	u8	access_type;
+};
+
 struct intel_pmt_entry {
+	struct intel_pmt_header	header;
 	struct bin_attribute	pmt_bin_attr;
 	struct kobject		*kobj;
 	void __iomem		*disc_table;
@@ -29,19 +37,11 @@ struct intel_pmt_entry {
 	int			devid;
 };
 
-struct intel_pmt_header {
-	u32	base_offset;
-	u32	size;
-	u32	guid;
-	u8	access_type;
-};
-
 struct intel_pmt_namespace {
 	const char *name;
 	struct xarray *xa;
 	const struct attribute_group *attr_grp;
 	int (*pmt_header_decode)(struct intel_pmt_entry *entry,
-				 struct intel_pmt_header *header,
 				 struct device *dev);
 };
 
diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
index bbb3d61d09f4..4014c02cafdb 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -223,10 +223,10 @@ static const struct attribute_group pmt_crashlog_group = {
 };
 
 static int pmt_crashlog_header_decode(struct intel_pmt_entry *entry,
-				      struct intel_pmt_header *header,
 				      struct device *dev)
 {
 	void __iomem *disc_table = entry->disc_table;
+	struct intel_pmt_header *header = &entry->header;
 	struct crashlog_entry *crashlog;
 
 	if (!pmt_crashlog_supported(entry))
diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index 39cbc87cc28a..f86080e8bebd 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -58,10 +58,10 @@ static bool pmt_telem_region_overlaps(struct intel_pmt_entry *entry,
 }
 
 static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
-				   struct intel_pmt_header *header,
 				   struct device *dev)
 {
 	void __iomem *disc_table = entry->disc_table;
+	struct intel_pmt_header *header = &entry->header;
 
 	if (pmt_telem_region_overlaps(entry, dev))
 		return 1;
-- 
2.34.1

