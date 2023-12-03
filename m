Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03335802407
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjLCNRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjLCNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:17:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E93E6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701609473; x=1733145473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5tg3umOvWMLFINtDpx9XgsbQvVEtzPNqeysIbkIpyE8=;
  b=VHkGG84HwYRKDy3VI5W+w+UcFBeP8CjLgmD2GONhM+F0cuHKPym9VJAb
   HGbjJcR6l8zO6A9g+Sx96gBV5tdmsui4FyUPRb6F2c3rs1nDfRN51pSVu
   GjTpZuvMVSxSqsrw/+rzfqMHHr54X3qyGOina56WeiJMZE0X10ZwZOQ0p
   Wrl+KCRaKH7rxK7bgeYxVbx3pjQviR/YaZD8ovJsFPrkIcK63MJ7WV6JI
   T37Q50dvE8TMsK07zhj6nEsxQpQD3dhrI/UQXMkfVJyH9n+qmZl0chYfU
   JJnAZEkN66tCa61Nah31Eg5410M05YUFciQx9JF2VVq4YbyxkBhGhCnrm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="498216"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="498216"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 05:17:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770262355"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="770262355"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2023 05:17:48 -0800
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
Subject: [PATCH v3 2/9] drm/i915: Use memcpy_[from/to]_page() in gem/i915_gem_pyhs.c
Date:   Sun,  3 Dec 2023 21:29:40 +0800
Message-Id: <20231203132947.2328805-3-zhao1.liu@linux.intel.com>
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
kmap_local_page()[1],  and this patch converts the call from
kmap_atomic() + memcpy() to memcpy_[from/to]_page(), which use
kmap_local_page() to build local mapping and then do memcpy().

The main difference between atomic and local mappings is that local
mappings doesn't disable page faults or preemption (the preemption is
disabled for !PREEMPT_RT case, otherwise it only disables migration).

With kmap_local_page(), we can avoid the often unwanted side effect of
unnecessary page faults and preemption disables.

In drm/i915/gem/i915_gem_phys.c, the functions
i915_gem_object_get_pages_phys() and i915_gem_object_put_pages_phys()
don't need to disable pagefaults and preemption for mapping because of
2 reasons:

1. The flush operation is safe. In drm/i915/gem/i915_gem_object.c,
i915_gem_object_get_pages_phys() and i915_gem_object_put_pages_phys()
calls drm_clflush_virt_range() to use CLFLUSHOPT or WBINVD to flush.
Since CLFLUSHOPT is global on x86 and WBINVD is called on each cpu in
drm_clflush_virt_range(), the flush operation is global.

2. Any context switch caused by preemption or page faults (page fault
may cause sleep) doesn't affect the validity of local mapping.

Therefore, i915_gem_object_get_pages_phys() and
i915_gem_object_put_pages_phys() are two functions where the uses of
local mappings in place of atomic mappings are correctly suited.

Convert the calls of kmap_atomic() / kunmap_atomic() + memcpy() to
memcpy_from_page() and memcpy_to_page().

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
 drivers/gpu/drm/i915/gem/i915_gem_phys.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
index 5df128e2f4dc..ef85c6dc9fd5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
@@ -65,16 +65,13 @@ static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
 	dst = vaddr;
 	for (i = 0; i < obj->base.size / PAGE_SIZE; i++) {
 		struct page *page;
-		void *src;
 
 		page = shmem_read_mapping_page(mapping, i);
 		if (IS_ERR(page))
 			goto err_st;
 
-		src = kmap_atomic(page);
-		memcpy(dst, src, PAGE_SIZE);
+		memcpy_from_page(dst, page, 0, PAGE_SIZE);
 		drm_clflush_virt_range(dst, PAGE_SIZE);
-		kunmap_atomic(src);
 
 		put_page(page);
 		dst += PAGE_SIZE;
@@ -113,16 +110,13 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
 
 		for (i = 0; i < obj->base.size / PAGE_SIZE; i++) {
 			struct page *page;
-			char *dst;
 
 			page = shmem_read_mapping_page(mapping, i);
 			if (IS_ERR(page))
 				continue;
 
-			dst = kmap_atomic(page);
 			drm_clflush_virt_range(src, PAGE_SIZE);
-			memcpy(dst, src, PAGE_SIZE);
-			kunmap_atomic(dst);
+			memcpy_to_page(page, 0, src, PAGE_SIZE);
 
 			set_page_dirty(page);
 			if (obj->mm.madv == I915_MADV_WILLNEED)
-- 
2.34.1

