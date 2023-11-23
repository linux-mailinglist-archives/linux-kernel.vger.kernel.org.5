Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E047F5735
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjKWEEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjKWEDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:03:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23BAD40;
        Wed, 22 Nov 2023 20:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700712239; x=1732248239;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Y00cT8FyfpCEyia3Pj/m0YcutdxXYCZQ06+T/bc3DDI=;
  b=aE19jpLIFVu94AW/qk2jecZvsikjWxqVZmKxJcYb00yERxefHAsbomZc
   PHZ/L6T4/J0K0HxHDdJ/WiQn4VDuBwMfaxBvuZMyt7lbrIGVZdZBR7Wwx
   IB52ut0qTqxMQSn11rtxQUbLihLmodbNqXalgCGYR6bC4gaqUmmy6zjJH
   CI9vh+uUcakx5e4QwVOYds5N/ElcGOJVdriiz/vJEnhvoDLeA6tV9EPqC
   16OPacvLZXAmbSNJ1BBpWFe3Dy9Wpm5+YwhDfQtK/qZVNpUNfJ8HdF39A
   WcFzVcChsVKPa8hO5K6/jWs5G6IR786vu38oaKMlA/ePKZJXjcuonOoHi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5334660"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="5334660"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837671150"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="837671150"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:56 -0800
Received: from debox1-desk4.lan (snpatel1-mobl.amr.corp.intel.com [10.209.89.91])
        by linux.intel.com (Postfix) with ESMTP id 528FC580D7B;
        Wed, 22 Nov 2023 20:03:56 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V5 08/20] platform/x86/intel/pmt: Add header to struct intel_pmt_entry
Date:   Wed, 22 Nov 2023 20:03:43 -0800
Message-Id: <20231123040355.82139-9-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123040355.82139-1-david.e.box@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMT header is passed to several functions. Instead, store the header in
struct intel_pmt_entry which is also passed to these functions and shorten
the argument list. This simplifies the calls in preparation for later
changes. While here also perform a newline cleanup.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V5 - Mention newline cleanup in changelog

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

