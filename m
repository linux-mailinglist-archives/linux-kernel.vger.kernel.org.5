Return-Path: <linux-kernel+bounces-137816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AD789E803
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C41E283994
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBA9539A;
	Wed, 10 Apr 2024 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnx9R4xT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3C10F9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715003; cv=none; b=d23hkeU05D+eQufBPjDq2A6R+FnK0jYtM6A3dUB86tHQfiH+m9V0v/S/HoE5OeZtL4sXFfSWQNSNlqmyYdLQHK82tFV+EAfj7XOwwpfrLpSa05KphFwi+WO9rboUgJmhiFIpj9vTAEd/AL4XASLSTsUc95kFzuW9FNSu3dY8xq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715003; c=relaxed/simple;
	bh=REOhqJJd8sYpwA0ffeiV27cAvZ9AtNWJXYSp8PBZaAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0/9b9eJhBqByEsWdZIy1S4EX7hRc2bsvG/QNw4AocAG3lpn31p81DOfczmRJ1pHvn8YjUQCWDxjCGwu1h3kvJCGUo/tuvwYgYp748p1L9SIEGIS8QJa7thThp8pNs4KuoESNjNMNkBCS66cHIXrZwvrCRCSnAVmWqW0fwEladU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnx9R4xT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712715002; x=1744251002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=REOhqJJd8sYpwA0ffeiV27cAvZ9AtNWJXYSp8PBZaAM=;
  b=bnx9R4xThuwE3ZUlYwLFdL0ZGQOxUa829N9K5FVEM6ybW8tTY1PfpOHT
   XG77mlwheo9X24AF56UxhhN14UK7c1BRAFQ8bO4UUtMh6HbebKLOuqJWS
   POWRzjrLbkPZjwdb3h3yBEOA3qE5NfSX5625qQqI3GUjGmzFNbIVHWAXf
   cIN50U36DuRNaIdm3FNDKCZUlZRTzGCZdE80pOzwciyN04XXkR7MkePZH
   4xhPk4X4FPLhlGV/mhkvIIOZr4LAO923U9mH3CoOiMKNgf+CtUND6xBod
   wVKZpsmnRZdq8SJymAr77SwO4Vjz38T7OAWwg8JSnR83qVwYXqZOUf7ec
   w==;
X-CSE-ConnectionGUID: zVIiCnpnSdeC4nMM7wlavg==
X-CSE-MsgGUID: 67TYDuprQHeu4+RATurkhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7918525"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7918525"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:10:02 -0700
X-CSE-ConnectionGUID: DWJyA+sySQ6Z98Er4nZBwg==
X-CSE-MsgGUID: iG+0dSp7QISLdcFGTSt/fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20478872"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 19:09:58 -0700
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
Subject: [PATCH v2 00/12] Consolidate domain cache invalidation
Date: Wed, 10 Apr 2024 10:08:32 +0800
Message-Id: <20240410020844.253535-1-baolu.lu@linux.intel.com>
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
https://github.com/LuBaolu/intel-iommu/commits/iommu-vtd-cache-tag-v2

Change log:

v2:
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
  iommu/vt-d: Retire intel_svm_dev
  iommu/vt-d: Retire struct intel_svm

 include/linux/iommu.h        |   3 +
 drivers/iommu/intel/iommu.h  |  79 ++++---
 drivers/iommu/intel/trace.h  |  97 +++++++++
 drivers/iommu/intel/cache.c  | 401 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c  | 296 ++++----------------------
 drivers/iommu/intel/nested.c |  71 ++-----
 drivers/iommu/intel/svm.c    | 279 +++++-------------------
 drivers/iommu/iommu-sva.c    |  16 +-
 drivers/iommu/intel/Makefile |   2 +-
 9 files changed, 685 insertions(+), 559 deletions(-)
 create mode 100644 drivers/iommu/intel/cache.c

-- 
2.34.1


