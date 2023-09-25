Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7C7ADFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjIYTn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjIYTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:43:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4642103;
        Mon, 25 Sep 2023 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695671029; x=1727207029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lRTLuTl4WdS58LnOlekBfjmptPkvpaho5X1jf3CRbHo=;
  b=Ofr8zJR/tVc85BxdtsGgVPgG6iZh1kMmH0/5jRimVvY8z6z072013k0u
   B4t75GcLpPAXSRSGiW+W3fKtpyh7X7rizqjfkuu5L7QSXdLq7GeAw5jkq
   LCJ8AhWHW0YwM6qAJN2Z/A7jZXACFjql/ZkbTA/cxd4JAcM5FoR2Bdqjc
   1cpeTj5b5nBA69Xa56vvNJ+nUjB/pT1mzOw/UIzCxnDfkOEJTJ6HsAlUw
   EF2ohYt8mTg/u8kgX/s5wfiToUlErsOSSRWDL4365gMuXu+fJq+StMxRo
   N2PcS8VIjKAaGFuriwSfQxKrt2XCr5LjlnER7lI6AiiekOS0szjH6AA4o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360743062"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="360743062"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 12:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="872194749"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="872194749"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga004.jf.intel.com with ESMTP; 25 Sep 2023 12:43:39 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] platform/x86/intel/tpmi: Add defines to get version information
Date:   Mon, 25 Sep 2023 12:43:36 -0700
Message-Id: <20230925194338.966639-2-srinivas.pandruvada@linux.intel.com>
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

Add defines to get major and minor version from a TPMI version field
value. This will avoid code duplication to convert in every feature
driver. Also add define for invalid version field.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 include/linux/intel_tpmi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index 04d937ad4dc4..ee07393445f9 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -6,6 +6,12 @@
 #ifndef _INTEL_TPMI_H_
 #define _INTEL_TPMI_H_
 
+#include <linux/bitfield.h>
+
+#define TPMI_VERSION_INVALID	0xff
+#define TPMI_MINOR_VERSION(val)	FIELD_GET(GENMASK(4, 0), val)
+#define TPMI_MAJOR_VERSION(val)	FIELD_GET(GENMASK(7, 5), val)
+
 /**
  * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
  * @package_id:	CPU Package id
-- 
2.41.0

