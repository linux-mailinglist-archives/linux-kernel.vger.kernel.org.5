Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ED07BF8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjJJKnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjJJKni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:43:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB8B4;
        Tue, 10 Oct 2023 03:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696934615; x=1728470615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHOekVDgtaNocncHM8JY3mpFGLJsRdlpKILUbEllNtY=;
  b=HdXnT4baQcH1XHBvDofw7R5yMCOSMo4J1NMKwPcOI+erdBiDmhqKelZk
   UZM1Fs2YTwt6TV0eerOv+eF4qxWYC5GV7xHYhuI3ovB/mDFtyy6+gLs1J
   21AbsRA/06sHhfVl4yOuoqYofedzo3WF7tj5VYo3T/pqH99Mm4l8seBp4
   oYc7izTag4jjKulDsXOttoEldeN/Ax1XsRCudlfNg3YpLvgulQwn4d3Ze
   uLTJ+fjQ5AvAl3ImONW81Btp8mMFiwkZEUZMOr4bu5tREUQ19VQqVrvCK
   42GRCBUyUdVVIzRs3EOCLmyH8vdg8GVjaGOc6pzraojDB2bkMjBkKyxPg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374703550"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="374703550"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="747033037"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="747033037"
Received: from asalaman-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.16.145])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:43:29 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     ilpo.jarvinen@linux.intel.com,
        Peter Newman <peternewman@google.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v5 4/4] Documentation/x86: Document resctrl's new sparse_masks
Date:   Tue, 10 Oct 2023 12:42:39 +0200
Message-ID: <3e9610997164f648e15c5c2e90d4944ce36504fe.1696934091.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696934091.git.maciej.wieczor-retman@intel.com>
References: <cover.1696934091.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changelog v5:
- Remove last patch message paragraph. (Babu)
- Add Babu's reviewed-by tag.

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

