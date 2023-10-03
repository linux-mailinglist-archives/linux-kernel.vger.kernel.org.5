Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4336F7B714E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbjJCSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjJCStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:49:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109FAAB;
        Tue,  3 Oct 2023 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696358962; x=1727894962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DehzMPWOQhRRRY3Bff94fnYSIwTrRyTbhg10vaC1+Ro=;
  b=KIW/CSQ8lREhQeFWGAcrJLKIFIOHmAFLbz6R5BgCn0Mgk8WYIGoydAbX
   XyyQHEiP99/eKA2q/wtnNhNkWTQEt+APoOQ81UZIzYeIygpFUSl4tMk5L
   usWNUzA68lMX1qyM6r1Wj6aXn4C77AQGSjd3UKz5lhwqw6MzQ6dubo5WY
   u1jkLRpnBQk4//a3z89PouK6gPmMCUfMdXPEokJJxRmQ+PPmg4a9mkrL9
   IDkqbVH+4VlsXs7vYwyYudc1T+SRGunUUj/j0NZePjSV/D1jo3x0f4Afy
   M/hrkPZdilQodosAPot41I4YpNcZlvvLwOzPDeUhrWQHfnIZ+fO1BSJcj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="363221958"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="363221958"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700814542"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="700814542"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga003.jf.intel.com with ESMTP; 03 Oct 2023 11:49:20 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/3] platform/x86: ISST: Ignore minor version change
Date:   Tue,  3 Oct 2023 11:49:15 -0700
Message-Id: <20231003184916.1860084-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
References: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
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

The hardware definition of every TPMI feature contains a major and minor
version. When there is a change in the MMIO offset or change in the
definition of a field, hardware will change major version. For addition
of new fields without modifying existing MMIO offsets or fields, only the
minor version is changed.

Driver is developed to support SST functionality for a major and minor
version. If the hardware changes major version, since offsets and
definitions are changed, driver cannot continue to provide SST interface
to users. Driver can still function with a minor version change as it will
just miss the new functionality added by the hardware. The current
implementation doesn't ignore any version change.

If there is mismatch with the minor version, continue with an information
log message. If there is mismatch with the major version, log error and
exit.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
- Commit description and header change as suggested by llpo
- Change log level for minor version mismatch

 .../x86/intel/speed_select_if/isst_tpmi_core.c   | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index ac5c6a812592..0b6d2c864437 100644
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
+		dev_info(&auxdev->dev, "SST: Ignore: Unsupported minor version:%lx\n",
+			 TPMI_MINOR_VERSION(pd_info->sst_header.interface_version));
+
 	/* Read SST CP Header */
 	*((u64 *)&pd_info->cp_header) = readq(pd_info->sst_base + pd_info->sst_header.cp_offset);
 
-- 
2.41.0

