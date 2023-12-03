Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF4802418
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjLCNSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjLCNSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:18:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09F1711
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701609493; x=1733145493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n0RVul1j1ChdDPLa632W5FsA9VNrjI6ORXgE1LsiNbo=;
  b=MszwCkU85LYhOQvnZttPbF41LffBuS8WH5Ww4Se9kY76qOcuq9bCX5BT
   8A47z2rmlYJ8TCtL5IdxedlHavkDk0/Q8wez/hVe1fkQiCiH0KfPtfNlK
   EX7pNFe3YxzgQFiWUE0ij7bPtGhdHlzIUfFW59+yHavsYo3QrhZPMQSQO
   5z6J1iN2+Lxn7ke2UQkqJ6lSF0t9MRLOFHKRpfxjEicSnXWcDR41IbMVU
   pd26W2/ahtyt/1utuHN8nCgehYSw533cNxLgo5yaPIrkA0I5FSw+ttcQZ
   yAiIVTFWFCAo/PiHn1BdZxARcpYraDvMkQieczpnFYEEJlXa9729m91RI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="498252"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="498252"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 05:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770262464"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="770262464"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2023 05:18:08 -0800
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
Subject: [PATCH v3 7/9] drm/i915: Use memcpy_from_page() in gt/uc/intel_uc_fw.c
Date:   Sun,  3 Dec 2023 21:29:45 +0800
Message-Id: <20231203132947.2328805-8-zhao1.liu@linux.intel.com>
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
mappings doesn't disable page faults or preemption  (the preemption is
disabled for !PREEMPT_RT case, otherwise it only disables migration).

With kmap_local_page(), we can avoid the often unwanted side effect of
unnecessary page faults or preemption disables.

In drm/i915/gt/uc/intel_us_fw.c, the function intel_uc_fw_copy_rsa()
just use the mapping to do memory copy so it doesn't need to disable
pagefaults and preemption for mapping. Thus the local mapping without
atomic context (not disable pagefaults / preemption) is enough.

Therefore, intel_uc_fw_copy_rsa() is a function where the use of
memcpy_from_page() with kmap_local_page() in place of memcpy() with
kmap_atomic() is correctly suited.

Convert the calls of memcpy() with kmap_atomic() / kunmap_atomic() to
memcpy_from_page() which uses local mapping to copy.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/T/#u

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
Suggested by credits:
  Ira: Referred to his task document and suggestions about using
       memcpy_from_page() directly.
  Fabio: Referred to his boiler plate commit message and his description
         about why kmap_local_page() should be preferred.
---
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
index 362639162ed6..756093eaf2ad 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
@@ -1343,16 +1343,13 @@ size_t intel_uc_fw_copy_rsa(struct intel_uc_fw *uc_fw, void *dst, u32 max_len)
 
 		for_each_sgt_page(page, iter, uc_fw->obj->mm.pages) {
 			u32 len = min_t(u32, size, PAGE_SIZE - offset);
-			void *vaddr;
 
 			if (idx > 0) {
 				idx--;
 				continue;
 			}
 
-			vaddr = kmap_atomic(page);
-			memcpy(dst, vaddr + offset, len);
-			kunmap_atomic(vaddr);
+			memcpy_from_page(dst, page, offset, len);
 
 			offset = 0;
 			dst += len;
-- 
2.34.1

