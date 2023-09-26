Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30827AF330
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjIZSpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbjIZSpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:45:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED5EB;
        Tue, 26 Sep 2023 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695753943; x=1727289943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LryE28J099aJFwLkOHr91UPQ19Da3H3VkYKesB9Y1vo=;
  b=XpPhiYMxUz2nJUcaeyDQ+/znyXVFw7Cu0vQXyPkQl1Ou5IG4CW1XU2RD
   OqdkkzPuWYK7Lsn2apQDeJJ20X7PyOl8QI/kDiZ6I00J4TP06Y4FSWSQ4
   UCtvz1LMnab8NJZYTtE0EhBzfMmnfFJyPsETqv4CkL4Kzvz71zfAaayu6
   63qMmvJSuCRuyZuxaqX5N+fTFf1DKhnTg0niME1lAbzDgtvH31XwJYJUA
   6QY/tcQ/8uK/qxSaw57yhIwt1p+JPm/j7ECNClokQ3z7hp31CUuTfIXrT
   XUuyBu9zotCHHCqDZXlCEU65O9d5/08oASMNS5oyHkp4sWVie/FcqRHtN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378920265"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378920265"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752279638"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752279638"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:31 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/2] ACPI: NFIT: Fix memory leak, and local use of devm_*()
Date:   Tue, 26 Sep 2023 21:45:19 +0300
Message-ID: <20230926184520.2239723-2-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926184520.2239723-1-michal.wilczynski@intel.com>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_*() family of functions purpose is managing memory attached to a
device. So in general it should only be used for allocations that should
last for the whole lifecycle of the device. This is not the case for
acpi_nfit_init_interleave_set(). There are two allocations that are only
used locally in this function. What's more - if the function exits on
error path memory is never freed. It's still attached to dev and would
be freed on device detach, so this leak could be called a 'local leak'.

Fix this by switching from devm_kcalloc() to kcalloc(), and adding
proper rollback.

Fixes: eaf961536e16 ("libnvdimm, nfit: add interleave-set state-tracking infrastructure")
Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f0e6738ae3c9..78f0f855c4de 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2262,6 +2262,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 	u16 nr = ndr_desc->num_mappings;
 	struct nfit_set_info2 *info2;
 	struct nfit_set_info *info;
+	int err = 0;
 	int i;
 
 	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
@@ -2269,13 +2270,15 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 		return -ENOMEM;
 	import_guid(&nd_set->type_guid, spa->range_guid);
 
-	info = devm_kcalloc(dev, nr, sizeof(*info), GFP_KERNEL);
+	info = kcalloc(nr, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	info2 = devm_kcalloc(dev, nr, sizeof(*info2), GFP_KERNEL);
-	if (!info2)
-		return -ENOMEM;
+	info2 = kcalloc(nr, sizeof(*info2), GFP_KERNEL);
+	if (!info2) {
+		err = -ENOMEM;
+		goto free_info;
+	}
 
 	for (i = 0; i < nr; i++) {
 		struct nd_mapping_desc *mapping = &ndr_desc->mapping[i];
@@ -2289,7 +2292,8 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 
 		if (!memdev || !nfit_mem->dcr) {
 			dev_err(dev, "%s: failed to find DCR\n", __func__);
-			return -ENODEV;
+			err = -ENODEV;
+			goto free_info2;
 		}
 
 		map->region_offset = memdev->region_offset;
@@ -2337,10 +2341,13 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 	}
 
 	ndr_desc->nd_set = nd_set;
-	devm_kfree(dev, info);
-	devm_kfree(dev, info2);
 
-	return 0;
+free_info2:
+	kfree(info2);
+free_info:
+	kfree(info);
+
+	return err;
 }
 
 static int ars_get_cap(struct acpi_nfit_desc *acpi_desc,
-- 
2.41.0

