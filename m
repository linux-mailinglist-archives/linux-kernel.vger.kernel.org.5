Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E04802409
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjLCNRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCNRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:17:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED2FE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701609465; x=1733145465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6RiMuSqJalQ4rXfkz3A6f6FgEAyAyrtGB/pofpVVePA=;
  b=feaM5pJUWUB0zzc1PwS16yAzKHOgeka3Dbmo2i/YBctB905HYGGwmmc8
   zQYpb1/i/u+JJgMm2D843AwHff42a4tbUs5ZRSyaQxbaI53d5HXlN3OG3
   JjcWhij2jWr4rf8R8b36sTSsjgpJ+INw7sK79abVQsY6DpkqWrZ56UT2c
   vL+AzHVQUqsjUAmW8G9gQMOOFfBhqOZBEE5RloOJkR7GuqnoXm18r4fUk
   Fh/JCC3x418ysRpLgK5V2sQNNd4ucieVk1PjD+h1LKA4AD+oCFOsrf5wC
   +FZbFvKIQbxVBxxh7cY4DLQbh9y8ksHZcsoYS74OGfK+qY8QqzC/e7OYA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="498207"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="498207"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 05:17:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770262325"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="770262325"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2023 05:17:39 -0800
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
Subject: [PATCH v3 0/9] drm/i915: Replace kmap_atomic() with kmap_local_page()
Date:   Sun,  3 Dec 2023 21:29:38 +0800
Message-Id: <20231203132947.2328805-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi all,

I refreshed this v3 by rebasing v2 [1] on the commit 968f35f4ab1c
("Merge tag 'v6.7-rc3-smb3-client-fixes' of git://git.samba.org/sfrench/
cifs-2.6").

Based on the current code, I rechecked the substitutions in v2 and they
still stand and are valid, so no code change in v3.

Thanks for all the review! And sorry v2 was missed, I'll pay more
attention to this v3.


Purpose of This Patchset
========================

The purpose of this pacthset is to replace all uses of kmap_atomic() in
i915 with kmap_local_page() because the use of kmap_atomic() is being
deprecated in favor of kmap_local_page()[2]. And 92b64bd (mm/highmem:
add notes about conversions from kmap{,_atomic}()) has declared the
deprecation of kmap_atomic().


Motivation for Deprecating kmap_atomic() and Using kmap_local_page()
====================================================================

The main difference between atomic and local mappings is that local
mappings doesn't disable page faults or preemption (the preemption is
disabled for !PREEMPT_RT case, otherwise it only disables migration).

With kmap_local_page(), we can avoid the often unwanted side effect of
unnecessary page faults and preemption disables.


Patch summary
=============

Patch 1, 4-6 and 8-9 replace kmap_atomic()/kunmap_atomic() with
        kmap_local_page()/kunmap_local() directly. With these local
        mappings, the page faults and preemption are allowed.

Patch 2 and 7 use memcpy_from_page() and memcpy_to_page() to replace
        kmap_atomic()/kunmap_atomic(). These two variants of memcpy()
        are based on the local mapping, so page faults and preemption
        are also allowed in these two interfaces.

Patch 3 replaces kmap_atomic()/kunmap_atomic() with kmap_local_page()/
        kunmap_local() and also disable page fault since the for special
        handling (pls see the commit message).


Reference
=========

[1]: https://lore.kernel.org/all/20230329073220.3982460-1-zhao1.liu@linux.intel.com/
[2]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com


Thanks and Best Regards,
Zhao

---
Changlog:

Changes since v2:
* Rebased on 968f35f4ab1c ("Merge tag 'v6.7-rc3-smb3-client-fixes' of
  git://git.samba.org/sfrench/cifs-2.6").
* Removed changelog (of v2) in commit message.
* Fixed typo in cover letter (Fabio).
* Added Reviewed-by tags from Ira and Fabio.

Changes since v1:
* Dropped hot plug related description in commit message since it has
  nothing to do with kmap_local_page().
* Emphasized the motivation for using kmap_local_page() in commit
  message.
* Rebased patch 1 on f47e630 (drm/i915/gem: Typecheck page lookups) to
  keep the "idx" variable of type pgoff_t here.
* Used memcpy_from_page() and memcpy_to_page() to replace
  kmap_local_page() + memcpy() in patch 2.

---
Zhao Liu (9):
  drm/i915: Use kmap_local_page() in gem/i915_gem_object.c
  drm/i915: Use memcpy_[from/to]_page() in gem/i915_gem_pyhs.c
  drm/i915: Use kmap_local_page() in gem/i915_gem_shmem.c
  drm/i915: Use kmap_local_page() in gem/selftests/huge_pages.c
  drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_coherency.c
  drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_context.c
  drm/i915: Use memcpy_from_page() in gt/uc/intel_uc_fw.c
  drm/i915: Use kmap_local_page() in i915_cmd_parser.c
  drm/i915: Use kmap_local_page() in gem/i915_gem_execbuffer.c

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c       | 10 +++++-----
 drivers/gpu/drm/i915/gem/i915_gem_object.c           |  8 +++-----
 drivers/gpu/drm/i915/gem/i915_gem_phys.c             | 10 ++--------
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c            |  6 ++++--
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c      |  6 +++---
 .../gpu/drm/i915/gem/selftests/i915_gem_coherency.c  | 12 ++++--------
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c    |  8 ++++----
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c             |  5 +----
 drivers/gpu/drm/i915/i915_cmd_parser.c               |  4 ++--
 9 files changed, 28 insertions(+), 41 deletions(-)

-- 
2.34.1

