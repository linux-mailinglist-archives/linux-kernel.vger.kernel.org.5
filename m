Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8267AF333
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjIZSpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjIZSpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:45:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B911F;
        Tue, 26 Sep 2023 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695753943; x=1727289943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UsIV3Q3gcUAc21rNqcq+g99sj4f1HzfeIQJnfu00KFE=;
  b=aCdntd0tivFkxDS9b5DH2iVc0G0cRPyBa8PhfEFalxHJkRknJ5s0gvjx
   img5RTQhfHysyg8Y+wmEj9UyN6iHsiW0XpyfuSuoOvjBBp9mTdtcFzeb0
   Ko182z3tkAMKVCsQsGYA5zFJBq/0Gv/VK/AHQzlU9d4mU2a71n+wV8Xcw
   I0cTdD8iQhtzR93tDdCbUqch1Nh61YXlgM+WclLFInaelnpXOwzWzvGbP
   HCYGD4OPy3zPOZlsnKnOwUpV9VkFpWHNfhMZEaji1MVAe6fyPLpNYs/B/
   1Xfzg0rsGxZJTO/PbU0AT78JBSqLfhXC67hu4qgXw+qiKj0RhtKauTabR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378920271"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378920271"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752279646"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752279646"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:34 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 2/2] ACPI: NFIT: Use modern scope based rollback
Date:   Tue, 26 Sep 2023 21:45:20 +0300
Message-ID: <20230926184520.2239723-3-michal.wilczynski@intel.com>
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

Change rollback in acpi_nfit_init_interleave_set() to use modern scope
based attribute __free(). This is similar to C++ RAII and is a preferred
way for handling local memory allocations.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 78f0f855c4de..079bd663495f 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2257,29 +2257,23 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 		struct nd_region_desc *ndr_desc,
 		struct acpi_nfit_system_address *spa)
 {
+	u16 nr = ndr_desc->num_mappings;
+	struct nfit_set_info2 *info2 __free(kfree) =
+		kcalloc(nr, sizeof(*info2), GFP_KERNEL);
+	struct nfit_set_info *info __free(kfree) =
+		kcalloc(nr, sizeof(*info), GFP_KERNEL);
 	struct device *dev = acpi_desc->dev;
 	struct nd_interleave_set *nd_set;
-	u16 nr = ndr_desc->num_mappings;
-	struct nfit_set_info2 *info2;
-	struct nfit_set_info *info;
-	int err = 0;
 	int i;
 
+	if (!info || !info2)
+		return -ENOMEM;
+
 	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
 	if (!nd_set)
 		return -ENOMEM;
 	import_guid(&nd_set->type_guid, spa->range_guid);
 
-	info = kcalloc(nr, sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	info2 = kcalloc(nr, sizeof(*info2), GFP_KERNEL);
-	if (!info2) {
-		err = -ENOMEM;
-		goto free_info;
-	}
-
 	for (i = 0; i < nr; i++) {
 		struct nd_mapping_desc *mapping = &ndr_desc->mapping[i];
 		struct nvdimm *nvdimm = mapping->nvdimm;
@@ -2292,8 +2286,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 
 		if (!memdev || !nfit_mem->dcr) {
 			dev_err(dev, "%s: failed to find DCR\n", __func__);
-			err = -ENODEV;
-			goto free_info2;
+			return -ENODEV;
 		}
 
 		map->region_offset = memdev->region_offset;
@@ -2342,12 +2335,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 
 	ndr_desc->nd_set = nd_set;
 
-free_info2:
-	kfree(info2);
-free_info:
-	kfree(info);
-
-	return err;
+	return 0;
 }
 
 static int ars_get_cap(struct acpi_nfit_desc *acpi_desc,
-- 
2.41.0

