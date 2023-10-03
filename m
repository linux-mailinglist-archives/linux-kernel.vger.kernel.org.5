Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9E97B6E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbjJCQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbjJCQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:32:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D24C6;
        Tue,  3 Oct 2023 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696350759; x=1727886759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=naeM4Hr3CRD+DTUV5/XFL2W5c7Jq+1AMKWCZV/jYYy8=;
  b=aVbvvf6N/U1jlCgIuWZFIls13psdXA2G6Mxs5MARakSRGnvLdA9jUqDN
   Vp6/pAxRA6faBlwXkUe4fHSxr0Mnh7IcAndln+NMFZHW/MpAZ2IS+DhSx
   ACxeVlUjRh75zDvK/AA+DRGHjvqW0X1N1fBxLNKwxE4zpJdFttWQfpktZ
   0BlESStDbI5HHUJOAt4nrs1RgIuc3OpCBEoB3PyddXBiVJLnOBgj0Z8tI
   6iBt8U2XE1Txcse7D2CcLQjgmrN6TdN/Kz3z08lr+XHXAF8BeUw72eDYD
   UexDHrqD+sUdp8q8zlbQ7stK7uj0J5FJnfFWcc1jk1HCYmp3j8pFrB9eE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381799131"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381799131"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082069924"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1082069924"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2023 09:32:38 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 4/4] platform/x86: intel_speed_select_if: Use devm_ioremap_resource
Date:   Tue,  3 Oct 2023 09:32:34 -0700
Message-Id: <20231003163234.1856669-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231003163234.1856669-1-srinivas.pandruvada@linux.intel.com>
References: <20231003163234.1856669-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace devm_ioremap() with devm_ioremap_resource() by defining a
resource.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2
New patch in the series. Moved from indepedent patch to the SST series.
Updated commit log and added Reviewed-by.

 .../platform/x86/intel/speed_select_if/isst_if_mmio.c    | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
index 13e068c77d50..3f4343147dad 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
@@ -94,6 +94,7 @@ static int isst_if_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct isst_if_device *punit_dev;
 	struct isst_if_cmd_cb cb;
 	u32 mmio_base, pcu_base;
+	struct resource r;
 	u64 base_addr;
 	int ret;
 
@@ -118,10 +119,10 @@ static int isst_if_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	punit_dev->mmio_range = (struct isst_mmio_range *) ent->driver_data;
 
-	punit_dev->punit_mmio = devm_ioremap(&pdev->dev, base_addr,
-					     punit_dev->mmio_range[1].size);
-	if (!punit_dev->punit_mmio)
-		return -ENOMEM;
+	r = DEFINE_RES_MEM(base_addr, punit_dev->mmio_range[1].size);
+	punit_dev->punit_mmio = devm_ioremap_resource(&pdev->dev, &r);
+	if (IS_ERR(punit_dev->punit_mmio))
+		return PTR_ERR(punit_dev->punit_mmio);
 
 	mutex_init(&punit_dev->mutex);
 	pci_set_drvdata(pdev, punit_dev);
-- 
2.41.0

