Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2680F802412
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjLCNSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjLCNSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:18:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FFA10FD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701609485; x=1733145485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09wp7qEie3hPA9tmFNTCYBM6WHJ7/7jxnVGZAD5l5W4=;
  b=lrm/hR5hpRqpudchOcSjnmPOSqPJ9eDK84FNkZwpWkb9TiIL1Yxvlgys
   J5q6HcYOovnWgAD90CGrS2Ihi9VGVTaAqFpv+KCpeYKh2v7xPRDbg5lbR
   MNulsPjgTgxwA0U7PpL3OgCXIiuChfcdxvgu0lyRk0m0LpdN8P8oZtHXq
   98Igxy1jvu+n8CXWhRZSzHbufpqZjKOxalKxyn1+NeER/Tob8sKhFdS4J
   sDABQMSBjOVhH7pZyrIoQ5ixuRFSvWsSFX042+p/dCGiltcgRoBYvFff1
   uHockDwE27s0g1+J6swPCgvhYPDaeVnc4uLAoHtqHI7XUiqkiCX4kWBbE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="498241"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="498241"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 05:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770262426"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="770262426"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2023 05:18:00 -0800
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
Subject: [PATCH v3 5/9] drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_coherency.c
Date:   Sun,  3 Dec 2023 21:29:43 +0800
Message-Id: <20231203132947.2328805-6-zhao1.liu@linux.intel.com>
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
disabled for !PREEMPT_RT case, otherwise it only disables migration)..

With kmap_local_page(), we can avoid the often unwanted side effect of
unnecessary page faults or preemption disables.

In drm/i915/gem/selftests/i915_gem_coherency.c, functions cpu_set()
and cpu_get() mainly uses mapping to flush cache and assign the value.
There're 2 reasons why cpu_set() and cpu_get() don't need to disable
pagefaults and preemption for mapping:

1. The flush operation is safe. cpu_set() and cpu_get() call
drm_clflush_virt_range() to use CLFLUSHOPT or WBINVD to flush. Since
CLFLUSHOPT is global on x86 and WBINVD is called on each cpu in
drm_clflush_virt_range(), the flush operation is global.

2. Any context switch caused by preemption or page faults (page fault
may cause sleep) doesn't affect the validity of local mapping.

Therefore, cpu_set() and cpu_get() are functions where the use of
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
 .../gpu/drm/i915/gem/selftests/i915_gem_coherency.c  | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
index 3bef1beec7cb..beeb3e12eccc 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
@@ -24,7 +24,6 @@ static int cpu_set(struct context *ctx, unsigned long offset, u32 v)
 {
 	unsigned int needs_clflush;
 	struct page *page;
-	void *map;
 	u32 *cpu;
 	int err;
 
@@ -34,8 +33,7 @@ static int cpu_set(struct context *ctx, unsigned long offset, u32 v)
 		goto out;
 
 	page = i915_gem_object_get_page(ctx->obj, offset >> PAGE_SHIFT);
-	map = kmap_atomic(page);
-	cpu = map + offset_in_page(offset);
+	cpu = kmap_local_page(page) + offset_in_page(offset);
 
 	if (needs_clflush & CLFLUSH_BEFORE)
 		drm_clflush_virt_range(cpu, sizeof(*cpu));
@@ -45,7 +43,7 @@ static int cpu_set(struct context *ctx, unsigned long offset, u32 v)
 	if (needs_clflush & CLFLUSH_AFTER)
 		drm_clflush_virt_range(cpu, sizeof(*cpu));
 
-	kunmap_atomic(map);
+	kunmap_local(cpu);
 	i915_gem_object_finish_access(ctx->obj);
 
 out:
@@ -57,7 +55,6 @@ static int cpu_get(struct context *ctx, unsigned long offset, u32 *v)
 {
 	unsigned int needs_clflush;
 	struct page *page;
-	void *map;
 	u32 *cpu;
 	int err;
 
@@ -67,15 +64,14 @@ static int cpu_get(struct context *ctx, unsigned long offset, u32 *v)
 		goto out;
 
 	page = i915_gem_object_get_page(ctx->obj, offset >> PAGE_SHIFT);
-	map = kmap_atomic(page);
-	cpu = map + offset_in_page(offset);
+	cpu = kmap_local_page(page) + offset_in_page(offset);
 
 	if (needs_clflush & CLFLUSH_BEFORE)
 		drm_clflush_virt_range(cpu, sizeof(*cpu));
 
 	*v = *cpu;
 
-	kunmap_atomic(map);
+	kunmap_local(cpu);
 	i915_gem_object_finish_access(ctx->obj);
 
 out:
-- 
2.34.1

