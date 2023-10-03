Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7607B6E87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbjJCQct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbjJCQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:32:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D36BD;
        Tue,  3 Oct 2023 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696350759; x=1727886759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIOmsETpjPNDSE37tvKoqMLlpEG4W2dQUly3WREZunk=;
  b=BgzaHYPd86VG2Y0nZIBS+n9PGx16Dy/EidhSam/aiX9XTQtBa2mcJPWl
   /WlH/pZJ1JVKnqlu1j5ACZMnxWOcj2XrMc9QVgfUdR9zePS3wpFrPvGKd
   41LfMpsfJw7V/WYiLeAYG04b/4c0zkqWsmzLy7kuLBAk332gHHP5TwxVj
   Tlt5VWN9aqiMiK1bieVkHYPF6HKHWaCVvZfL73aVePC8KAu5PlRxfnPIh
   SLmxwRaD8w7lahOvkAycC/oI/U3ZV71nesPzz9VnA9Nkk3GCPtFrYjxf0
   hdys+6IJNkpyD1bcbdxIymDHty/+TkoImWcnO1Z45Eo+oHjo94K8MHCZo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381799126"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381799126"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082069913"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1082069913"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2023 09:32:37 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/4] platform/x86: intel_speed_select_if: Remove hardcoded map size
Date:   Tue,  3 Oct 2023 09:32:33 -0700
Message-Id: <20231003163234.1856669-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231003163234.1856669-1-srinivas.pandruvada@linux.intel.com>
References: <20231003163234.1856669-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is using 256 as the size while calling devm_ioremap(). The
maximum offset can be obtained from isst_mmio_range. Add a field "size"
to the isst_mmio_range and use it instead of hardcoding.

No functional impact is expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v2
No change except additional Reviewed-by

 .../x86/intel/speed_select_if/isst_if_mmio.c     | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
index ff49025ec085..13e068c77d50 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
@@ -18,16 +18,17 @@
 struct isst_mmio_range {
 	int beg;
 	int end;
+	int size;
 };
 
 static struct isst_mmio_range mmio_range_devid_0[] = {
-	{0x04, 0x14},
-	{0x20, 0xD0},
+	{0x04, 0x14, 0x18},
+	{0x20, 0xD0, 0xD4},
 };
 
 static struct isst_mmio_range mmio_range_devid_1[] = {
-	{0x04, 0x14},
-	{0x20, 0x11C},
+	{0x04, 0x14, 0x18},
+	{0x20, 0x11C, 0x120},
 };
 
 struct isst_if_device {
@@ -114,13 +115,16 @@ static int isst_if_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pcu_base &= GENMASK(10, 0);
 	base_addr = (u64)mmio_base << 23 | (u64) pcu_base << 12;
-	punit_dev->punit_mmio = devm_ioremap(&pdev->dev, base_addr, 256);
+
+	punit_dev->mmio_range = (struct isst_mmio_range *) ent->driver_data;
+
+	punit_dev->punit_mmio = devm_ioremap(&pdev->dev, base_addr,
+					     punit_dev->mmio_range[1].size);
 	if (!punit_dev->punit_mmio)
 		return -ENOMEM;
 
 	mutex_init(&punit_dev->mutex);
 	pci_set_drvdata(pdev, punit_dev);
-	punit_dev->mmio_range = (struct isst_mmio_range *) ent->driver_data;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.cmd_size = sizeof(struct isst_if_io_reg);
-- 
2.41.0

