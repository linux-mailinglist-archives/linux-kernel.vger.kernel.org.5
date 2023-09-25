Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472727ADFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjIYTqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIYTqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:46:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FD107;
        Mon, 25 Sep 2023 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695671161; x=1727207161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkBJDf+0BQFmsyRXGKlYUaDaxkBFGdrAtdv4n6cgZco=;
  b=fUEFhIltdQjKnioggIOvKZDODNd6GPKvkDDdtN9eYqcIh60mIPI90e01
   +rAs6SwHYOnu8MK461fYDNf8+eNAlPgWtUYd2ucKlynyoOcNCTuxCIt4W
   M5wBgHdaEO9itPBnpQ07t5wv+XhEAsUaB1wxDHJ5VO6ziPg5x06zpPv4L
   Wf9u0SqjFXYRzDlbvR5Uw4BdEPUjVC0wS6LnvbkMjUdNYrW/86nCrOsOo
   01W66ALid+DbtSZH8rzQtWz2kZhzToSjSgEp8vJC4FSl9ljDBTadl3UGw
   DjbzH+d8BJYG514wPm8ENGYe/ss/UQNXtLRDOzARxqTVhnWVCzJrnuqsx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380233040"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="380233040"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 12:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814114298"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="814114298"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2023 12:45:57 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] platform/x86: intel_speed_select_if: Remove hardcoded map size
Date:   Mon, 25 Sep 2023 12:45:55 -0700
Message-Id: <20230925194555.966743-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925194555.966743-1-srinivas.pandruvada@linux.intel.com>
References: <20230925194555.966743-1-srinivas.pandruvada@linux.intel.com>
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

The driver is using 256 as the size while calling devm_ioremap(). The
maximum offset is already part of struct isst_mmio_range. Use the
maximum offset (end field of the struct) plus 4 as the map size to remove
hardcoded value of 256.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
index ff49025ec085..be709e0c0c00 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
@@ -114,13 +114,16 @@ static int isst_if_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pcu_base &= GENMASK(10, 0);
 	base_addr = (u64)mmio_base << 23 | (u64) pcu_base << 12;
-	punit_dev->punit_mmio = devm_ioremap(&pdev->dev, base_addr, 256);
+
+	punit_dev->mmio_range = (struct isst_mmio_range *) ent->driver_data;
+
+	punit_dev->punit_mmio = devm_ioremap(&pdev->dev, base_addr,
+					     punit_dev->mmio_range[1].end + sizeof(u32));
 	if (!punit_dev->punit_mmio)
 		return -ENOMEM;
 
 	mutex_init(&punit_dev->mutex);
 	pci_set_drvdata(pdev, punit_dev);
-	punit_dev->mmio_range = (struct isst_mmio_range *) ent->driver_data;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.cmd_size = sizeof(struct isst_if_io_reg);
-- 
2.41.0

