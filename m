Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B56378FA53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348689AbjIAI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348674AbjIAI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:57:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275FF10F2;
        Fri,  1 Sep 2023 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693558622; x=1725094622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=psJh6vY3E+3/B3OgEgSlz9IZ/M/u0a/9heXK3c+Qo8Q=;
  b=VoM3k9ttp/vEBhTifx350RKyZWLmuvssOO1zLjfqatlLDgIgdxiKDTk+
   a5t/v4gVmsOVSVMgoTO4oxnxFIWFqvaJUAMkS76JwGvHS/ZexSdsPZCsm
   YAXjeZrCoHX3SqQ+W3ADZIGUDiSjO2BFYt26Bt6TEU0yU+o/6AGPvuZWg
   RTHYb2Jo8F+HCQ58lTGikVzxVb90dc5dDzN0sj5r8aNLa0cywUaSVYgP1
   /Md7NNbkG86FnKVq+ko02+X5jmt9xYeDY95JY01dFaZSHaYenZ3OTRw5y
   LdvD09d13vgpW0UGcVmZ3HAHje7qd2QmtAVu8ZdP7gMy4WcocReIosQnk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440151945"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="440151945"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="769133703"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="769133703"
Received: from akoczor-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.14.236])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:56:52 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 3/3] Documentation/x86: Document resctrl's new sparse_bitmaps
Date:   Fri,  1 Sep 2023 10:55:39 +0200
Message-ID: <89435c36b43651d63bd034adc142e932062aab21.1693557919.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
References: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
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

From: Fenghua Yu <fenghua.yu@intel.com>

The documentation mentions that non-contiguous bitmasks are not
supported in Intel Cache Allocation Technology (CAT).

Update the documentation on how to determine if sparse bitmasks are
allowed in L2 and L3 CAT.

Mention the file with feature support information is located in
the /sys/fs/resctrl/info/{resource}/ directories and enumerate what
are the possible outputs on file read operation.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 Documentation/arch/x86/resctrl.rst | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index cb05d90111b4..38694fc5800c 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -124,6 +124,13 @@ related to allocation:
 			"P":
 			      Corresponding region is pseudo-locked. No
 			      sharing allowed.
+"sparse_bitmaps":
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
+and 0xA are not. Check /sys/fs/resctrl/info/{resource}/sparse_bitmaps
+if non-contiguous 1s value is supported. On a system with a 20-bit mask
+each bit represents 5% of the capacity of the cache. You could partition
+the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
 Memory bandwidth Allocation and monitoring
 ==========================================
-- 
2.42.0

