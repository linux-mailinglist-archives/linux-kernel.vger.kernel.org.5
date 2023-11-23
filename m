Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06AB7F572C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjKWEEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjKWEDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:03:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF0DD;
        Wed, 22 Nov 2023 20:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700712237; x=1732248237;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qja7F9e+neaOik7E6g6cxNaFAISNh0pntEcq/tEl9bY=;
  b=aJiYTtEiPxl03cYJPvkwKue7bdgQGtdpklEHOtkG64w6fxgPbgmjvodX
   mw9/WTy+L6HLw95iBIHPlhVI4vn8tO+Yb/SH9A9GQTn1/k6CayGMtZHz1
   u9yKkoT9z+Oc2O1n2zzFpvDQn/7CjHeA4Cpumin0boslyD9rD6xp/aPAw
   Z07x/2PAhD7MMhkw6AGmbiRao4PgjfYUE4I5p4oRHg6UVM6y8pTn6zJU5
   TVAo3v6ICJc7ZGPX+SvAUGpzj/DaLVu32z8rrTIb8Bf0clct650uE2ga3
   q8GPdj2ywFepLQbTrsp6z+I4g0TuOTSJiCe2JuOI+zdnnm0S5P2b5Y9FC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389347941"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="389347941"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="801925645"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="801925645"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:55 -0800
Received: from debox1-desk4.lan (snpatel1-mobl.amr.corp.intel.com [10.209.89.91])
        by linux.intel.com (Postfix) with ESMTP id 80271580CA6;
        Wed, 22 Nov 2023 20:03:55 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V5 01/20] platform/x86/intel/vsec: Fix xa_alloc memory leak
Date:   Wed, 22 Nov 2023 20:03:36 -0800
Message-Id: <20231123040355.82139-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123040355.82139-1-david.e.box@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes memory leak, caught be kmemleak, due to failure to erase auxiliary
device entries from an xarray on removal.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V5 - New patch

 drivers/platform/x86/intel/vsec.c | 24 ++++++++++++++++--------
 drivers/platform/x86/intel/vsec.h |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index c1f9e4471b28..ae811bb65910 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -120,6 +120,8 @@ static void intel_vsec_dev_release(struct device *dev)
 {
 	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(dev);
 
+	xa_erase(&auxdev_array, intel_vsec_dev->id);
+
 	mutex_lock(&vsec_ida_lock);
 	ida_free(intel_vsec_dev->ida, intel_vsec_dev->auxdev.id);
 	mutex_unlock(&vsec_ida_lock);
@@ -136,9 +138,21 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 	int ret, id;
 
 	mutex_lock(&vsec_ida_lock);
-	ret = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
+	id = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
 	mutex_unlock(&vsec_ida_lock);
+	if (id < 0) {
+		kfree(intel_vsec_dev->resource);
+		kfree(intel_vsec_dev);
+		return ret;
+	}
+
+	ret = xa_alloc(&auxdev_array, &intel_vsec_dev->id, intel_vsec_dev,
+		       PMT_XA_LIMIT, GFP_KERNEL);
 	if (ret < 0) {
+		mutex_lock(&vsec_ida_lock);
+		ida_free(intel_vsec_dev->ida, id);
+		mutex_unlock(&vsec_ida_lock);
+
 		kfree(intel_vsec_dev->resource);
 		kfree(intel_vsec_dev);
 		return ret;
@@ -147,7 +161,7 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 	if (!parent)
 		parent = &pdev->dev;
 
-	auxdev->id = ret;
+	auxdev->id = id;
 	auxdev->name = name;
 	auxdev->dev.parent = parent;
 	auxdev->dev.release = intel_vsec_dev_release;
@@ -169,12 +183,6 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 	if (ret < 0)
 		return ret;
 
-	/* Add auxdev to list */
-	ret = xa_alloc(&auxdev_array, &id, intel_vsec_dev, PMT_XA_LIMIT,
-		       GFP_KERNEL);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index 0fd042c171ba..0a6201b4a0e9 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -45,6 +45,7 @@ struct intel_vsec_device {
 	struct ida *ida;
 	struct intel_vsec_platform_info *info;
 	int num_resources;
+	int id; /* xa */
 	void *priv_data;
 	size_t priv_data_size;
 };
-- 
2.34.1

