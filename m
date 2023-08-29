Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF0778BDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjH2FY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbjH2FYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A292919B;
        Mon, 28 Aug 2023 22:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286643; x=1724822643;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Y0/EaGIn6d0ULD53C6mJq4temH7MOkMbjaWJKl/qwig=;
  b=VkquTTYFZv2cFNHAeD0BXMn5oqtpSdGtFiWXTUu88aNUgUyVGznZ+iWR
   elWz6jWz2U0KkUBrC3euJPCwybAMazdt4sgujpPQANxkxmp37DdBWYICP
   mMxgxjmeztt0lNs82MJGtF0kk5B8CW1qq+72Cwy2YoIK95Ywn9kJwJet3
   aSCJT4t82vz1Pe9N8T+rMVD3WAfsQYPqPlCpyU8xYoBHyEmlem1ctqFe9
   zOn4hFbZ+oLsdSTTQGFD0KwrOhsSsZwCZ2y+stKPzPyZV/fNtG1SDOSD1
   H9aEMaRAaUrum2ojuA59avx1HOPvZe8pj8WVf2Svl9tcd/2bSnZvemj++
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625181"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625181"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556324"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556324"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 28 Aug 2023 22:20:55 -0700
Subject: [PATCH RFC v2 04/18] cxl/region: Add Dynamic Capacity decoder and
 region modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-4-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=3161;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Y0/EaGIn6d0ULD53C6mJq4temH7MOkMbjaWJKl/qwig=;
 b=Om6AGvdMAJ+k9JGIwvY9O6aGs6vTH9eiO4OHZen4LtCGk/pgN8XRKj/gaPOEc3KGXsebGT7Cz
 FnApvjgwkrcBwj8p70VDFDvUgMKgZrWpiJUd144rKfeoQOqzhGTFqBl
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both regions and decoders will need a new mode to reflect the new type
of partition they are targeting on a device.  Regions reflect a dynamic
capacity type which may point to different Dynamic Capacity (DC)
Regions.  Decoder mode reflects a specific DC Region.

Define the new modes to use in subsequent patches and the helper
functions associated with them.

Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
[iweiny: split out from: Add dynamic capacity cxl region support.]
---
 drivers/cxl/core/region.c |  4 ++++
 drivers/cxl/cxl.h         | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 75041903b72c..69af1354bc5b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1772,6 +1772,8 @@ static bool cxl_modes_compatible(enum cxl_region_mode rmode,
 		return true;
 	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
 		return true;
+	if (rmode == CXL_REGION_DC && cxl_decoder_mode_is_dc(dmode))
+		return true;
 
 	return false;
 }
@@ -2912,6 +2914,8 @@ cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
 		return CXL_REGION_PMEM;
 	case CXL_DECODER_DEAD:
 		return CXL_REGION_DEAD;
+	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
+		return CXL_REGION_DC;
 	case CXL_DECODER_MIXED:
 	default:
 		return CXL_REGION_MIXED;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ed282dcd5cf5..d41f3f14fbe3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -356,6 +356,14 @@ enum cxl_decoder_mode {
 	CXL_DECODER_NONE,
 	CXL_DECODER_RAM,
 	CXL_DECODER_PMEM,
+	CXL_DECODER_DC0,
+	CXL_DECODER_DC1,
+	CXL_DECODER_DC2,
+	CXL_DECODER_DC3,
+	CXL_DECODER_DC4,
+	CXL_DECODER_DC5,
+	CXL_DECODER_DC6,
+	CXL_DECODER_DC7,
 	CXL_DECODER_MIXED,
 	CXL_DECODER_DEAD,
 };
@@ -366,6 +374,14 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 		[CXL_DECODER_NONE] = "none",
 		[CXL_DECODER_RAM] = "ram",
 		[CXL_DECODER_PMEM] = "pmem",
+		[CXL_DECODER_DC0] = "dc0",
+		[CXL_DECODER_DC1] = "dc1",
+		[CXL_DECODER_DC2] = "dc2",
+		[CXL_DECODER_DC3] = "dc3",
+		[CXL_DECODER_DC4] = "dc4",
+		[CXL_DECODER_DC5] = "dc5",
+		[CXL_DECODER_DC6] = "dc6",
+		[CXL_DECODER_DC7] = "dc7",
 		[CXL_DECODER_MIXED] = "mixed",
 	};
 
@@ -374,10 +390,16 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 	return "mixed";
 }
 
+static inline bool cxl_decoder_mode_is_dc(enum cxl_decoder_mode mode)
+{
+	return (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7);
+}
+
 enum cxl_region_mode {
 	CXL_REGION_NONE,
 	CXL_REGION_RAM,
 	CXL_REGION_PMEM,
+	CXL_REGION_DC,
 	CXL_REGION_MIXED,
 	CXL_REGION_DEAD,
 };
@@ -388,6 +410,7 @@ static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
 		[CXL_REGION_NONE] = "none",
 		[CXL_REGION_RAM] = "ram",
 		[CXL_REGION_PMEM] = "pmem",
+		[CXL_REGION_DC] = "dc",
 		[CXL_REGION_MIXED] = "mixed",
 	};
 

-- 
2.41.0

