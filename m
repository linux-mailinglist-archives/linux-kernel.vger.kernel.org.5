Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA56F7BBDD0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjJFRbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjJFRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:31:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD4DE;
        Fri,  6 Oct 2023 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696613491; x=1728149491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lbaG7NRajF8nHEz9svf8w2+E2KSzNWQz4W3JznGdv6w=;
  b=aFn+45By1JwJZX3eL4SdVokPPlE0Yh8+ZEZWkqv5nko5RIJnbdm/b+yk
   TueIBMniu4vppv18TbT88CChJ1Ejwf+BaaDuhhUzjJSS8J4Qs4GvadUI2
   kTdAxu62JW/22+udDR/WbsUr77UqalqGQJDLr30ZRalBlL+A/YtMY6BC+
   2i/hY9/hNDcwrrEos7S59eYTF0d6U2rWCDGgcEb9nFd8WTlNFa4tZ3zHf
   wWfFXzkt6NOyBoYJxs7MTj5j+NFiM6UosgcLwGj7Wvlj46Mnfxy4gHoiA
   qAFuzyO3fTi+mElpbCLZu0nURxSaSGXADgoWyVcm8lXy8ALnXG1XD2Ca5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387676845"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387676845"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745937598"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745937598"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:27 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 6/6] ACPI: NFIT: Remove redundant call to to_acpi_dev()
Date:   Fri,  6 Oct 2023 20:30:55 +0300
Message-ID: <20231006173055.2938160-7-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006173055.2938160-1-michal.wilczynski@intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index fb0bc16fa186..3d254b2cf2e7 100644
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

