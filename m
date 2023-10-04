Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15AE7B767E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbjJDCC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbjJDCC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:02:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E88AB;
        Tue,  3 Oct 2023 19:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696384944; x=1727920944;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=oNAtKvQWvA46KMHMDJuy+Zf5ymmMJr0mCAXpFzt/M/s=;
  b=CuHeVqICLNuhv+AAF/arKoPV+zpTvnFoUo8TkMeGLM7wA1rlB9MxUdFg
   CAXqf5+lxMl02I4v26rK2xHFu9rA5R/JVX5mFkpwpGtISP33SPA0ddH+u
   pS0Ym6ENp9i1lX1meVoyhQW09KxpywbO2kVd9uT5a4IxUBCGEkpFZ4z6B
   j0obxrtJImUV0P9yuCFDbzIxt2UeWttFJ5BIdzDrJPR0LLz392QuBWD8n
   1tdN+Pr96nGA/EWlHLnFlsJu3XoiS3YAQ2lZraNL1u1OpYS9AhHGs4wpf
   RSE2U18tWNG9XzY/+b2nwWIT9u5TlbnrJP9h5BR1742MhBrAUMoC/m7pw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="413947548"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="413947548"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841596674"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="841596674"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:23 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.24.172])
        by linux.intel.com (Postfix) with ESMTP id E5BE3580D99;
        Tue,  3 Oct 2023 19:02:22 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V2 05/13] platform/x86/intel/pmt: Add header to struct intel_pmt_entry
Date:   Tue,  3 Oct 2023 19:02:14 -0700
Message-Id: <20231004020222.193445-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004020222.193445-1-david.e.box@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
V2 - no change

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

