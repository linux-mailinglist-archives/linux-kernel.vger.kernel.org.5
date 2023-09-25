Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24327ADA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjIYOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjIYOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:49:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D52101;
        Mon, 25 Sep 2023 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695653381; x=1727189381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jbGtAhlIOf5ZMHSV2QC6o312WQ2sCWdKpbJB2MYMJ8Q=;
  b=beq2tsCw0FGjtofiWfAKbPEGGyPBjX3mQimvD2+vUyNlzA0kDouDnKaY
   DFLRCtSlBSOifTEU4YlQWQxCHQLnDST5OEhr+P1PcMqeBIS78ywFyLDMI
   H01trsy+TudV5qifkiWJZWFTPMEb/Oxk4xFWxhTatgpYV3fbaInHjNPlY
   RZQIfxpr1FnY2x2z3AhMOP8DO80/2mdRgJc2IoZWX/MwQWpihrWqpHb1y
   NfbN2wfzy1To3+6yWiCDR8mLDR5papHgTEo0tgoWNAPZgUvi3WOIXmbSO
   l+LGsp/KbjcbLM4AaiVxz5LniQiiu/BgMsgCtZJQgd/kDb5oGoMVGd8So
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378548098"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="378548098"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995409547"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995409547"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:37 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, rui.zhang@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 8/9] ACPI: NFIT: Remove redundant call to to_acpi_dev()
Date:   Mon, 25 Sep 2023 17:48:41 +0300
Message-ID: <20230925144842.586829-9-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925144842.586829-1-michal.wilczynski@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
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
index 2e50b1334a69..f09530d2520a 100644
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

