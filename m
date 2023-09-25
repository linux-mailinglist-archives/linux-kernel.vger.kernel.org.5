Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074B17ADFC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjIYTn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjIYTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:43:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284EC101;
        Mon, 25 Sep 2023 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695671029; x=1727207029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qc58uCA2qyiU/pC/xc6SIaVgCU5JFHqYtmabPIVw1Kw=;
  b=DR7rfQY77zqh4ix3iOI29fThoKIpQtkCKqcPjfd7ZfJGZOZef/LBqhYc
   Hdv26A1EJ1XzkV0CXqjZn3RMuM8w8+GEL0jfqksePUOEi6WgyyRWQIhRh
   iaAWad+wgZowrzPrx/14EH0qDKRvY06k4+8ncqPFXNalpSZBcBCiva2r4
   1uRHjkZZHvzQ3NUSKkawMxwGzFR0UWaTV9Yia8MUNtNeQ6bD+EVTl5YyL
   f3devJweahoNx8UTods8np6A+LNTCITD0wsSiv71IB6skQMBQNsi9Gv7P
   iXkvex6UVUDOs0NPGbWuak0uZaK2qlhkMm6xbBBBtfc/QAnTAZa9eVMfK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360743071"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="360743071"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 12:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="872194750"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="872194750"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga004.jf.intel.com with ESMTP; 25 Sep 2023 12:43:39 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] platform/x86: ISST : Check major minor version
Date:   Mon, 25 Sep 2023 12:43:37 -0700
Message-Id: <20230925194338.966639-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>
References: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>
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

Parse major and minor version number from the version field. If there
is a mismatch for major version, exit from further processing for that
domain.

If there is mismatch in minor version, driver continue to process with
an error message. Minor version change doesn't change offsets and bit
structures of TPMI fields.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel/speed_select_if/isst_tpmi_core.c   | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 63faa2ea8327..37f17e229419 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -30,7 +30,8 @@
 #include "isst_if_common.h"
 
 /* Supported SST hardware version by this driver */
-#define ISST_HEADER_VERSION		1
+#define ISST_MAJOR_VERSION	0
+#define ISST_MINOR_VERSION	1
 
 /*
  * Used to indicate if value read from MMIO needs to get multiplied
@@ -352,12 +353,19 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 	pd_info->sst_header.cp_offset *= 8;
 	pd_info->sst_header.pp_offset *= 8;
 
-	if (pd_info->sst_header.interface_version != ISST_HEADER_VERSION) {
-		dev_err(&auxdev->dev, "SST: Unsupported version:%x\n",
-			pd_info->sst_header.interface_version);
+	if (pd_info->sst_header.interface_version == TPMI_VERSION_INVALID)
+		return -ENODEV;
+
+	if (TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version) != ISST_MAJOR_VERSION) {
+		dev_err(&auxdev->dev, "SST: Unsupported major version:%lx\n",
+			TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version));
 		return -ENODEV;
 	}
 
+	if (TPMI_MINOR_VERSION(pd_info->sst_header.interface_version) != ISST_MINOR_VERSION)
+		dev_err(&auxdev->dev, "SST: Ignore: Unsupported minor version:%lx\n",
+			TPMI_MINOR_VERSION(pd_info->sst_header.interface_version));
+
 	/* Read SST CP Header */
 	*((u64 *)&pd_info->cp_header) = readq(pd_info->sst_base + pd_info->sst_header.cp_offset);
 
-- 
2.41.0

