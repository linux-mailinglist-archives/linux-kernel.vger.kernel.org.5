Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30044802417
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjLCNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjLCNSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:18:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08414198
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701609489; x=1733145489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fm2E31LppwjrR39Uy7KnRmjjwMXiEfdx6p7tDjCHHk8=;
  b=KQdCGtR3QXXuPDMGy8RSCKzxvZtdWMFGsy7Cncm/U/Mlqv5U9XEC57pf
   aeWdNWvgT1d1fra/IbupjWWwlefvJsh4GH2ZVb9PD8a67MiCw+639FVlY
   k4G2xNI6sH6mPjMgV9g7hDLHwG3zpttCxEVhe5c8f50IGD3HbseoYEBHq
   MAJlzaEPXAD9qlSEGodVotpE5RxwN1o4JEpJRc2ACQ4ytTdpJ4qfsCRJZ
   Z5aMAg+YRxBdrV4qVt5SMWVVCNVSErAjGIHdnTzSdWzfJ2Sqj5IOKOB6s
   mVFlSCdbLoIHR9vc5cGg3sNoqTj2YeioVufXOsUHIyaEwUHWLWR1p+RRE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="498245"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="498245"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 05:18:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770262446"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="770262446"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2023 05:18:04 -0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 6/9] drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_context.c
Date:   Sun,  3 Dec 2023 21:29:44 +0800
Message-Id: <20231203132947.2328805-7-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203132947.2328805-1-zhao1.liu@linux.intel.com>
References: <20231203132947.2328805-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Liu <zhao1.liu@intel.com>

The use of kmap_atomic() is being deprecated in favor of
kmap_local_page()[1], and this patch converts the call from
kmap_atomic() to kmap_local_page().

The main difference between atomic and local mappings is that local
mappings doesn't disable page faults or preemption.

With kmap_local_page(), we can avoid the often unwanted side effect of
unnecessary page faults or preemption disables.

In drm/i915/gem/selftests/i915_gem_context.c, functions cpu_fill() and
cpu_check() mainly uses mapping to flush cache and check/assign the
value.

There're 2 reasons why cpu_fill() and cpu_check() don't need to disable
pagefaults and preemption for mapping:

1. The flush operation is safe. cpu_fill() and cpu_check() call
drm_clflush_virt_range() to use CLFLUSHOPT or WBINVD to flush. Since
CLFLUSHOPT is global on x86 and WBINVD is called on each cpu in
drm_clflush_virt_range(), the flush operation is global.

2. Any context switch caused by preemption or page faults (page fault
may cause sleep) doesn't affect the validity of local mapping.

Therefore, cpu_fill() and cpu_check() are functions where the use of
kmap_local_page() in place of kmap_atomic() is correctly suited.

Convert the calls of kmap_atomic() / kunmap_atomic() to
kmap_local_page() / kunmap_local().

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
Suggested by credits:
  Dave: Referred to his explanation about cache flush.
  Ira: Referred to his task document, review comments and explanation
       about cache flush.
  Fabio: Referred to his boiler plate commit message and his description
         about why kmap_local_page() should be preferred.
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index 7021b6e9b219..89d4dc8b60c6 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -489,12 +489,12 @@ static int cpu_fill(struct drm_i915_gem_object *obj, u32 value)
 	for (n = 0; n < real_page_count(obj); n++) {
 		u32 *map;
 
-		map = kmap_atomic(i915_gem_object_get_page(obj, n));
+		map = kmap_local_page(i915_gem_object_get_page(obj, n));
 		for (m = 0; m < DW_PER_PAGE; m++)
 			map[m] = value;
 		if (!has_llc)
 			drm_clflush_virt_range(map, PAGE_SIZE);
-		kunmap_atomic(map);
+		kunmap_local(map);
 	}
 
 	i915_gem_object_finish_access(obj);
@@ -520,7 +520,7 @@ static noinline int cpu_check(struct drm_i915_gem_object *obj,
 	for (n = 0; n < real_page_count(obj); n++) {
 		u32 *map, m;
 
-		map = kmap_atomic(i915_gem_object_get_page(obj, n));
+		map = kmap_local_page(i915_gem_object_get_page(obj, n));
 		if (needs_flush & CLFLUSH_BEFORE)
 			drm_clflush_virt_range(map, PAGE_SIZE);
 
@@ -546,7 +546,7 @@ static noinline int cpu_check(struct drm_i915_gem_object *obj,
 		}
 
 out_unmap:
-		kunmap_atomic(map);
+		kunmap_local(map);
 		if (err)
 			break;
 	}
-- 
2.34.1

