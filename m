Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6983380241D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjLCNSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjLCNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:18:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD61010F0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701609497; x=1733145497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EKKa4BOOnEyA4HUJAkWqKp5uSW09uVdvjZ+3UJneSag=;
  b=OA/89Uy3NIrSEw3ijxLzfAYfrpr5RrzPn8PJ9akyDrPM2unDkofxIj5S
   uxlfGxz0oF9swS92wMdsx93kypSNfpBX6vaOfOMEz9/4LLkmSHKVN6MDC
   lM6jG3gpCvk6eUO0YrfrDD0IbpH6JGwFeZ/xI6VIKLRPr7m+W0ZXuLx5A
   xpV0jLARztv2RF7kwq/Cp6t5HjTDXFae/6blhvPdOS0AmpNXYATvQ1Ctd
   BNwT+T8Zp0ycVjZ2u/OTiHw0a4fqqZo7kVvTig7f5//iz7RwPlkiUo0lu
   xIIPIi+/74PkwxydGY3VU9zGO+erq3D22vyRKQczL44mWOVT1zvgmWsd3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="498263"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="498263"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 05:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770262478"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="770262478"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2023 05:18:12 -0800
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
Subject: [PATCH v3 8/9] drm/i915: Use kmap_local_page() in i915_cmd_parser.c
Date:   Sun,  3 Dec 2023 21:29:46 +0800
Message-Id: <20231203132947.2328805-9-zhao1.liu@linux.intel.com>
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

There're 2 reasons why function copy_batch() doesn't need to disable
pagefaults and preemption for mapping:

1. The flush operation is safe. In i915_cmd_parser.c, copy_batch() calls
drm_clflush_virt_range() to use CLFLUSHOPT or WBINVD to flush.
Since CLFLUSHOPT is global on x86 and WBINVD is called on each cpu
in drm_clflush_virt_range(), the flush operation is global.

2. Any context switch caused by preemption or page faults (page fault
may cause sleep) doesn't affect the validity of local mapping.

Therefore, copy_batch() is a function where the use of
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
 drivers/gpu/drm/i915/i915_cmd_parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_cmd_parser.c b/drivers/gpu/drm/i915/i915_cmd_parser.c
index ddf49c2dbb91..2905df83e180 100644
--- a/drivers/gpu/drm/i915/i915_cmd_parser.c
+++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
@@ -1211,11 +1211,11 @@ static u32 *copy_batch(struct drm_i915_gem_object *dst_obj,
 		for (n = offset >> PAGE_SHIFT; remain; n++) {
 			int len = min(remain, PAGE_SIZE - x);
 
-			src = kmap_atomic(i915_gem_object_get_page(src_obj, n));
+			src = kmap_local_page(i915_gem_object_get_page(src_obj, n));
 			if (src_needs_clflush)
 				drm_clflush_virt_range(src + x, len);
 			memcpy(ptr, src + x, len);
-			kunmap_atomic(src);
+			kunmap_local(src);
 
 			ptr += len;
 			remain -= len;
-- 
2.34.1

