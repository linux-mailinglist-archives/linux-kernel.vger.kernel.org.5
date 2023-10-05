Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57787B9FEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjJEOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjJEO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:28:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5BE1BE3;
        Thu,  5 Oct 2023 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513800; x=1728049800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kBxCGjZW2FJhQ282tkABZbg5NvDP8ru8sP0OrIfFg3Y=;
  b=CdRn38pa5y1n0KzSfqKaFrWdcFXryBYUef4pF+cadbHpWUu8uKGEvMOD
   hubK03SK5r7tf6zZz8o98aXm91UkQ9WHQJvufajpJjUu2GTF1eNCrDeTO
   2w4duqWTeyeKho1o0wJHBSfMjV7sDKU4MuKWUCF0s1o4RNetM3a3Mc2TO
   BvKelDzRrsdpWH1K1ljVR1awE5denSGxPlMa2it7jeCxeZzOanvz/3mEG
   A6pvzlFzeUzWpchbbLivOi+MZal3lzd8gX471/WQuIGda6Pj6gBvn7SNQ
   BGiDfT/hNfsCSjN5eeOipFa7lFYQ4tEsGYsCb0JS9HTpObGkHCyoH66jy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383339485"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="383339485"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="875477082"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="875477082"
Received: from lpopiela-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.13.229])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:16:27 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Newman <peternewman@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 4/4] Documentation/x86: Document resctrl's new sparse_masks
Date:   Thu,  5 Oct 2023 10:15:39 +0200
Message-ID: <7bbdf55ac6f909a6701915d99d79c8f9977bd0b4.1696493034.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Fenghua Yu <fenghua.yu@intel.com>

The documentation mentions that non-contiguous bit masks are not
supported in Intel Cache Allocation Technology (CAT).

Update the documentation on how to determine if sparse bit masks are
allowed in L2 and L3 CAT.

Mention the file with feature support information is located in
the /sys/fs/resctrl/info/{resource}/ directories and enumerate what
are the possible outputs on file read operation.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v4:
- Add Ilpo's reviewed-by tag.
- Add Reinette's reviewed-by tag.

Changelog v3:
- Add Peter's tested-by and reviewed-by tags.

Changelog v2:
- Change bitmap naming convention to bit mask. (Reinette)

 Documentation/arch/x86/resctrl.rst | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index cb05d90111b4..4c6421e2aa31 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -124,6 +124,13 @@ related to allocation:
 			"P":
 			      Corresponding region is pseudo-locked. No
 			      sharing allowed.
+"sparse_masks":
+		Indicates if non-contiguous 1s value in CBM is supported.
+
+			"0":
+			      Only contiguous 1s value in CBM is supported.
+			"1":
+			      Non-contiguous 1s value in CBM is supported.
 
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
@@ -445,12 +452,13 @@ For cache resources we describe the portion of the cache that is available
 for allocation using a bitmask. The maximum value of the mask is defined
 by each cpu model (and may be different for different cache levels). It
 is found using CPUID, but is also provided in the "info" directory of
-the resctrl file system in "info/{resource}/cbm_mask". Intel hardware
+the resctrl file system in "info/{resource}/cbm_mask". Some Intel hardware
 requires that these masks have all the '1' bits in a contiguous block. So
 0x3, 0x6 and 0xC are legal 4-bit masks with two bits set, but 0x5, 0x9
-and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
-of the capacity of the cache. You could partition the cache into four
-equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
+and 0xA are not. Check /sys/fs/resctrl/info/{resource}/sparse_masks
+if non-contiguous 1s value is supported. On a system with a 20-bit mask
+each bit represents 5% of the capacity of the cache. You could partition
+the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
 Memory bandwidth Allocation and monitoring
 ==========================================
-- 
2.42.0

