Return-Path: <linux-kernel+bounces-146462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759BB8A65B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912C71C21825
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400F12E1CA;
	Tue, 16 Apr 2024 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6yDzMFd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241D1804A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254897; cv=none; b=sDcZZ5lr60gLBLC0SzUAYlydmbsmuTN7hx6LBc6FaMO5V/ftgtsIa6IO6Ip8RyGWRL8WFiJ9eKHhb04/iFtRB6+PnIApwHO6Emttqowcv3QqCW+6lCaG33dUJX4RKzOW+uh9EpfH7v3FJua9rpcXfj6bEXXuwatapW6YX+hxY6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254897; c=relaxed/simple;
	bh=VhzUrtvuOfZtVOr8Ta9jkiC09pi3LUr3rEnhTlnyq2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CI7vqFS0KCWiqjysm4WSbE5nr8Hfxqu3OvGtjjm29Dc0BWIngAI9jvewujb7ZDN97HPQbH+86e75EJyofRS4q0tl2Ff3Zxo/laj5sLJ6up80PTrlwhcNPzBSwKqTeN1D5A/EfQxNYQONbXQdW8xwAoIMR1dbajn4K5NYfwbWxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6yDzMFd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254895; x=1744790895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VhzUrtvuOfZtVOr8Ta9jkiC09pi3LUr3rEnhTlnyq2w=;
  b=B6yDzMFdVnBrEQvfizgm2TwMFLtSIrp1Urcs0yLky5ZRGzCZ3NbLriRc
   bC7a8GDX69So0LX535P0/RGkLliVeiBcBDsH09iba+hEGmXOLAo7aRrik
   j7HoRSKrikgWI8CZG9BTSijYwfEz3Vyy5swm/Vdu6wOQwpQKXmkQOpyOG
   SMcAlwviw9InXmtbjQf0WrzpPeN2txJLlZpul20DB2G3ZOiEXC5KRoj4F
   iKBzzidOLHZCzjMiMspBr35Q/pO2/nTgseCZN3pG/SYx/3Y9z+IvFkyQX
   GwoO41/gxvJLyHyv/Jo3fVInXPKxW+z0B60XZuCimkItyY0uLzpvCdiPb
   g==;
X-CSE-ConnectionGUID: 8wCPsjVDT1OBTTlxtwluLg==
X-CSE-MsgGUID: C4iZAi3dS2uDaUjaZoDkHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466422"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466422"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:15 -0700
X-CSE-ConnectionGUID: gd49YCjkRcW/r0kHzr+wKw==
X-CSE-MsgGUID: TQDMqGY4SmiexAbqNHlm7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077643"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 00/12] Consolidate domain cache invalidation
Date: Tue, 16 Apr 2024 16:06:44 +0800
Message-Id: <20240416080656.60968-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU hardware cache needs to be invalidated whenever the mappings
in the domain are changed. Currently, domain cache invalidation is
scattered across different places, causing several issues:

- IOMMU IOTLB Invalidation: This is done by iterating through the domain
  IDs of each domain using the following code:

        xa_for_each(&dmar_domain->iommu_array, i, info)
                iommu_flush_iotlb_psi(info->iommu, dmar_domain,
                                      start_pfn, nrpages,
                                      list_empty(&gather->freelist), 0);

  This code could theoretically cause a use-after-free problem because
  there's no lock to protect the "info" pointer within the loop.

- Inconsistent Invalidation Methods: Different domain types implement
  their own cache invalidation methods, making the code difficult to
  maintain. For example, the DMA domain, SVA domain, and nested domain
  have similar cache invalidation code scattered across different files.

- SVA Domain Inconsistency: The SVA domain implementation uses a
  completely different data structure to track attached devices compared
  to other domains. This creates unnecessary differences and, even
  worse, leads to duplicate IOTLB invalidation when an SVA domain is
  attached to devices belonging to a same IOMMU.

- Nested Domain Dependency: The special overlap between a nested domain
  and its parent domain requires a dedicated parent_domain_flush()
  helper function to be called everywhere the parent domain's mapping
  changes.

- Limited Debugging Support: There are currently no debugging aids
  available for domain cache invalidation.

By consolidating domain cache invalidation into a common location, we
can address the issues mentioned above and improve the code's
maintainability and debuggability.

The series and related patches are available on GitHub:
https://github.com/LuBaolu/intel-iommu/commits/iommu-vtd-cache-tag-v3

Change log:
v3:
 - Fix the difference of range end between mm_types and iommu gather
   API.
 - Align invalidation address to page mask.
 - Use mmu_notifier_put() in intel_svm_domain_free() and defer the
   domain free in mm free_notifier callback.
 - Various mics refinements and adjustments.

v2: https://lore.kernel.org/linux-iommu/20240410020844.253535-1-baolu.lu@linux.intel.com/
 - Allow cache tags of parent_type to be reusable.
 - Save the the iommu device pointer to @dev of IOTLB tag type to make
   it present the location of the TLB explicitly.
 - Rename cache_tag_flush_cm_range() to cache_tag_flush_range_pt() to
   make it clear that cache_tag_flush_range_pt() is called for PTEs
   changes from non-present to present.
 - Split out a patch series to clean up all inconsistent devtlb
   invalidation policies for caching mode.
   https://lore.kernel.org/linux-iommu/20240407144232.190355-1-baolu.lu@linux.intel.com/
 - Fix a bug in intel_nested_cache_invalidate_user() where the @nrpages
   is misused as @end.
 - Various mics refinements and adjustments.

v1: https://lore.kernel.org/linux-iommu/20240325021705.249769-1-baolu.lu@linux.intel.com/

Jason Gunthorpe (1):
  iommu: Add ops->domain_alloc_sva()

Lu Baolu (11):
  iommu/vt-d: Add cache tag assignment interface
  iommu/vt-d: Add cache tag invalidation helpers
  iommu/vt-d: Add trace events for cache tag interface
  iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
  iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
  iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map
  iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
  iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
  iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs
  iommu/vt-d: Remove intel_svm_dev
  iommu/vt-d: Remove struct intel_svm

 include/linux/iommu.h        |   3 +
 drivers/iommu/intel/iommu.h  |  85 +++++--
 drivers/iommu/intel/trace.h  |  97 ++++++++
 drivers/iommu/intel/cache.c  | 419 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c  | 286 +++---------------------
 drivers/iommu/intel/nested.c |  69 ++----
 drivers/iommu/intel/svm.c    | 288 ++++++------------------
 drivers/iommu/iommu-sva.c    |  16 +-
 drivers/iommu/intel/Makefile |   2 +-
 9 files changed, 707 insertions(+), 558 deletions(-)
 create mode 100644 drivers/iommu/intel/cache.c

-- 
2.34.1


