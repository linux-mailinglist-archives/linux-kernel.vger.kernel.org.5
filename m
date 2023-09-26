Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E517AF210
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjIZR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjIZR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:58:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7247D10A;
        Tue, 26 Sep 2023 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695751122; x=1727287122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=26y7z/vbZIKVw5+YYxWkM5USLbriHvP1vPxT1gn10c8=;
  b=Ck9dlXijCI1I3/1zSnHYRoEI0w6bWajsZxXvnCz9pmGjA4vsmiLBJyg/
   0Eh4NxmxaQO9+idyXRW2WSWIFIB9FaRIiG8B6tQ5R2i6tg6xJ97pJVBRe
   lTmnXfCmLsF6FXwKEb3ecUf4IosVJs+3+ho7VFRNahiEBQw3Xthp+KiIj
   w8wicPrF/WIdbBq/T68cmUHD01+0cPgxBpKP8NoqhxczeZhTGn7sePeBj
   hCpr0aALfm3t1sFkM9bSfHPV0M7kAHSGdDxURtsGviUwFe62YazODY0vC
   7HcUX0GyixvodZLBNv4OUQU2mCQhhpd5kKS94ndoVpBb8KwrSj42E6ZxD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="371966207"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="371966207"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 10:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892288055"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="892288055"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga001.fm.intel.com with ESMTP; 26 Sep 2023 10:57:35 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: intel_speed_select_if: Use devm_ioremap_resource
Date:   Tue, 26 Sep 2023 10:58:40 -0700
Message-Id: <20230926175840.989732-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace devm_ioremap() with devm_ioremap_resource() by defining a
resource.

No functional impact is expected.

Suggested-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
This patch requires merge of series "Minor SST optimizations",
particularly
platform/x86: intel_speed_select_if: Remove hardcoded map size
Can be differed to 6.8 cycle.
If I repost the series after reviews, I will include as part of the
series.

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

