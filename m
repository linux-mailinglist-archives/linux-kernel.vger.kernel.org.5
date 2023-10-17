Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD307CBD63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjJQI32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQI30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:29:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF99FB;
        Tue, 17 Oct 2023 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697531364; x=1729067364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LKGg+L3VZMtPvAZYL+/LvBsBcIOUQgV+HkNPICkLuCI=;
  b=Vu0rtT49dDjpfU6jOkqqPqU1LX5HnyAeIf8tF4g8vXAm8gVyA1j8VChN
   LKtjBOuLmA+jr2AmDD9/pZCCRWoXTki46DLznJUSWifGLtMw6mmmaSlMr
   mQhszK5VtMDFcVO30VUWWKeDXiqG+IurF0a1aY5no4/FlnJl2LoIJsAYi
   jl8VANDvuUXd0EXAOiRi2/GbCIiYx1zujBtpea66wFVW8TrVIH80cVjUE
   uQU1DK+trv4aAfVNj9uUnExxc3T2PjBof3q4b7InSoN0k/Bi76N+pSWKH
   LHP6PPmB61U6y69AsmHqR1XYjLHcaziPl9855jizNOCUrtIOL6z8ISom6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365989665"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="365989665"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="846733946"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="846733946"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:29:21 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     rafael@kernel.org, vishal.l.verma@intel.com, lenb@kernel.org,
        dave.jiang@intel.com, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] ACPI: NFIT: Use cleanup.h helpers instead of devm_*()
Date:   Tue, 17 Oct 2023 11:29:05 +0300
Message-ID: <20231017082905.1673316-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
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

The new cleanup.h facilities that arrived in v6.5-rc1 can replace the
the usage of devm semantics in acpi_nfit_init_interleave_set(). That
routine appears to only be using devm to avoid goto statements. The
new __free() annotation at variable declaration time can achieve the same
effect more efficiently.

There is no end user visible side effects of this patch, I was
motivated to send this cleanup to practice using the new helpers.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---

Dan, would you like me to give you credit for the changelog changes
with Co-developed-by tag ?

v3:
 - changed changelog
v2:
 - removed first commit from the patchset, as the commit couldn't
   be marked as a fix
 - squashed those commits together, since the second one were
   mostly overwriting the previous one

 drivers/acpi/nfit/core.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 3826f49d481b..67a844a705c4 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2257,26 +2257,23 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
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
 	int i;
 
+	if (!info || !info2)
+		return -ENOMEM;
+
 	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
 	if (!nd_set)
 		return -ENOMEM;
 	import_guid(&nd_set->type_guid, spa->range_guid);
 
-	info = devm_kcalloc(dev, nr, sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	info2 = devm_kcalloc(dev, nr, sizeof(*info2), GFP_KERNEL);
-	if (!info2)
-		return -ENOMEM;
-
 	for (i = 0; i < nr; i++) {
 		struct nd_mapping_desc *mapping = &ndr_desc->mapping[i];
 		struct nvdimm *nvdimm = mapping->nvdimm;
@@ -2337,8 +2334,6 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 	}
 
 	ndr_desc->nd_set = nd_set;
-	devm_kfree(dev, info);
-	devm_kfree(dev, info2);
 
 	return 0;
 }
-- 
2.41.0

