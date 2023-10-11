Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE887C4D48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjJKIee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjJKIeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:34:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054AC9D;
        Wed, 11 Oct 2023 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697013257; x=1728549257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+gMT7Bs4QZ3pqRHjQbkVcqijwQt7TCCPLlHrN6GVa+4=;
  b=Xmf/ZlVGQmk/0RggXtdoEM1uiX5NxnDCSlkRMYVJ+WI61+LOhXsClzhG
   HkTpC80Fh695AENSiozl4qtnm/bW6ZX64Sx/T+LxjXk3FR+GhgUf+52Dk
   mBFb++xxnpGTi1leg8aqttGPA8FR8Lopl6b30g9wyQj8tkLMaAaEpVN1Y
   Q9KFyYq1BHjWRoFy0mkvYbCGoyuWzZStC1OHkMIwiiURrJB4NllBHwTQn
   8qMGC4NKN8imVwy+oafCGaR65IQQsqqDZopQXWBYzDckrS57hfUgzh38v
   LJAncZva8mRufNpNgMHSGJhGlPne5tNRxvsWwRnynP0TGTL11VLvHq/9C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388480280"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388480280"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897548228"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897548228"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:32:29 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 6/6] ACPI: NFIT: Remove redundant call to to_acpi_dev()
Date:   Wed, 11 Oct 2023 11:33:34 +0300
Message-ID: <20231011083334.3987477-7-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011083334.3987477-1-michal.wilczynski@intel.com>
References: <20231011083334.3987477-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acpi_nfit_ctl() ACPI handle is extracted using to_acpi_dev()
function and accessing handle field in ACPI device. After transformation
from ACPI driver to platform driver this is not optimal anymore. To get
a handle it's enough to just use ACPI_HANDLE() macro to extract the
handle.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 6b9d10cae92c..402bb56d4163 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -475,8 +475,6 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		guid = to_nfit_uuid(nfit_mem->family);
 		handle = adev->handle;
 	} else {
-		struct acpi_device *adev = to_acpi_dev(acpi_desc);
-
 		cmd_name = nvdimm_bus_cmd_name(cmd);
 		cmd_mask = nd_desc->cmd_mask;
 		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
@@ -493,7 +491,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 			guid = to_nfit_uuid(NFIT_DEV_BUS);
 		}
 		desc = nd_cmd_bus_desc(cmd);
-		handle = adev->handle;
+		handle = ACPI_HANDLE(dev);
 		dimm_name = "bus";
 	}
 
-- 
2.41.0

