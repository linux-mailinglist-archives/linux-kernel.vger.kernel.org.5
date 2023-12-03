Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7572680240B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjLCNRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjLCNRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:17:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FDB102
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701609469; x=1733145469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGMem3p2DJYsfNDR22BCHsoG0wKxhOHO8cUgjkpX0Tg=;
  b=h8u8zRKRGYeNE01Bp2yNO7wAD3ZuK3RNINwjE4Nr+tSbUwI0h5EkMEVq
   oykpi82UeZpHHKlPielrekhrN4WbPJjnWl1QM//SdnD+DjBgSWeCw0z5s
   bLaCOlTQRIGvg8qMf4JeInA8ajvz7WvwN6tKAG1oJWEiueiiRR51fMXIW
   VcgBIK6r++jkek3ouzTwgND6Y+vgYhWu+aJ99GtI7Tfasq6tOwTK8RnTv
   utn+2FpVA8ltRyJXDt0uIrwRkDG3l7dvpMD3LI0jnOsPQE0Y3IDgKAxba
   y/n6mBjztFJFWZGZLnZruZKjsN9QRpkqXKjhGvR0rXFHQJQSNEMqfk8G4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="498212"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="498212"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 05:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770262333"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="770262333"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2023 05:17:44 -0800
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
Subject: [PATCH v3 1/9] drm/i915: Use kmap_local_page() in gem/i915_gem_object.c
Date:   Sun,  3 Dec 2023 21:29:39 +0800
Message-Id: <20231203132947.2328805-2-zhao1.liu@linux.intel.com>
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
mappings doesn't disable page faults or preemption (the preemption is
disabled for !PREEMPT_RT case, otherwise it only disables migration).

With kmap_local_page(), we can avoid the often unwanted side effect of
unnecessary page faults and preemption disables.

There're 2 reasons why i915_gem_object_read_from_page_kmap() doesn't
need to disable pagefaults and preemption for mapping:

1. The flush operation is safe. In drm/i915/gem/i915_gem_object.c,
i915_gem_object_read_from_page_kmap() calls drm_clflush_virt_range() to
use CLFLUSHOPT or WBINVD to flush. Since CLFLUSHOPT is global on x86
and WBINVD is called on each cpu in drm_clflush_virt_range(), the flush
operation is global.

2. Any context switch caused by preemption or page faults (page fault
may cause sleep) doesn't affect the validity of local mapping.

Therefore, i915_gem_object_read_from_page_kmap() is a function where
the use of kmap_local_page() in place of kmap_atomic() is correctly
suited.

Convert the calls of kmap_atomic() / kunmap_atomic() to
kmap_local_page() / kunmap_local().

And remove the redundant variable that stores the address of the mapped
page since kunmap_local() can accept any pointer within the page.

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
 drivers/gpu/drm/i915/gem/i915_gem_object.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index c26d87555825..a2a7e5005415 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -493,17 +493,15 @@ static void
 i915_gem_object_read_from_page_kmap(struct drm_i915_gem_object *obj, u64 offset, void *dst, int size)
 {
 	pgoff_t idx = offset >> PAGE_SHIFT;
-	void *src_map;
 	void *src_ptr;
 
-	src_map = kmap_atomic(i915_gem_object_get_page(obj, idx));
-
-	src_ptr = src_map + offset_in_page(offset);
+	src_ptr = kmap_local_page(i915_gem_object_get_page(obj, idx))
+	          + offset_in_page(offset);
 	if (!(obj->cache_coherent & I915_BO_CACHE_COHERENT_FOR_READ))
 		drm_clflush_virt_range(src_ptr, size);
 	memcpy(dst, src_ptr, size);
 
-	kunmap_atomic(src_map);
+	kunmap_local(src_ptr);
 }
 
 static void
-- 
2.34.1

