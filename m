Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA07AF207
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjIZRyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjIZRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:54:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5779F;
        Tue, 26 Sep 2023 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695750846; x=1727286846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8ZpXMYZAgko950/Kdxjip8wxCTn7a5ku/VCBGbQqq6E=;
  b=cmhqCOaaI/RQF6Z+j+XnGvf020o6G68gFmZU29ZZtrn1P+I89RrJI6Ri
   Vn3FwkcjHIlPb48oGp+RDSC6Yr5a7Xf4wXemyArBj9ElVfrt35ZG368UB
   bOlpAQ0CTg5li67CZhPU4q/TRLGoa6ESks8UltBXopvul/g8FRyxN0fMD
   vY0aHUfPBAJjAzyGIi3glCHBDcObcPOhJlqjxjZ5WfKtZV9l+ivDjD6P/
   wYZGEXLSKxOumGEs4k3dIy0XoAQVAYlTX/Nx45ejknJ3o4s8wLxpXBT9E
   e3AAbSWhM2p0mULuC8KoKmYzuhdWvAhlx8I5a9mxQmwl1X1qY3NkoDIaZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366693051"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="366693051"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 10:53:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864486747"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="864486747"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2023 10:53:50 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/3] platform/x86: intel_speed_select_if: Remove hardcoded map size
Date:   Tue, 26 Sep 2023 10:53:49 -0700
Message-Id: <20230926175349.989618-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---
Changes:
As per Andy's comments pre calculate size

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

