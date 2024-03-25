Return-Path: <linux-kernel+bounces-116409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4B88966B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AB02988CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1A145B25;
	Mon, 25 Mar 2024 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXGaNuht"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB5155380
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333084; cv=none; b=TOnKeX4gp0R/La9jmPPAu1GuGYm7x1wv9VSGd30gRYoycKKaVCNqyrCPOXWoVqW/XSppBVd+ZMa4gY53qi47JstAj+kBSlWF2qowXmO5VUYdfR/BGB2Oe+kKE6oblz5kiaP9hGNevS4EEq2r2Bq+B2l95Gh/Vr7J+WkI2GnVfCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333084; c=relaxed/simple;
	bh=NoQ/9ZnQSMX+2qUfsoDT6WHWT7bNrCxUqTCcoTOjF7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kTC8wkqoBhwxoTDTK8CrMMMuTe+/eL4exR8z13/OJ50rsEzP/kEEimRIr0lyPnjDGJyjaUXlbOeNG4ry9QQOfGO104mW1Hfq3DXHYc6fOQQ6GWp04T29kxU/BohieG3O0v1bizA9kCgE5fNXy4dmly1/e9LwHPClkdK2l2c5/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXGaNuht; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333082; x=1742869082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NoQ/9ZnQSMX+2qUfsoDT6WHWT7bNrCxUqTCcoTOjF7I=;
  b=jXGaNuhtIwxuHc6OPE4usGi46q8kyhk7MIgQ5sktGbgcjSVIe02wNTOS
   jHy5dtOdo3dGcY8LVMyoer1IuWVmyL1BdmyfQ1ur8yVliCWXhPXZ7OWND
   +ly+9py+SZ6eZLO3GG6Glv9d1skenwpKeGTPC8o+tUaxh+k8FWo2Edb3X
   3F0PszUx6DTaP2Firh/t9hufBMSVcERj+y3oUO/Q+2zINUuSgf8PnCZmT
   2WsvQVEmzVVleQ5ZmPrzFANK7WRH1a0wmdAuPgrCJGN1cl5oluudl2edM
   smA4Nm5wi1x58iR+xS7Fz1vBgQlpv2U2B2DEj8d75yQwDqojrdLfTgB2W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271305"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271305"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353886"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:17:57 -0700
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
Subject: [PATCH 00/12] Consolidate domain cache invalidation
Date: Mon, 25 Mar 2024 10:16:53 +0800
Message-Id: <20240325021705.249769-1-baolu.lu@linux.intel.com>
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
  attached to devices belonging to different IOMMU domains.

- Nested Domain Dependency: The special overlap between a nested domain
  and its parent domain requires a dedicated parent_domain_flush()
  helper function to be called everywhere the parent domain's mapping
  changes.

- Limited Debugging Support: There are currently no debugging aids
  available for domain cache invalidation.

By consolidating domain cache invalidation into a common location, we
can address the issues mentioned above and improve the code's
maintainability and debuggability.

Jason Gunthorpe (1):
  iommu: Add ops->domain_alloc_sva()

Lu Baolu (11):
  iommu/vt-d: Add cache tag assignment interface
  iommu/vt-d: Add cache tag invalidation helpers
  iommu/vt-d: Add trace events for cache tag interface
  iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
  iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
  iommu/vt-d: Use cache_tag_flush_cm_range() in iotlb_sync_map
  iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
  iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
  iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs
  iommu/vt-d: Retire intel_svm_dev
  iommu/vt-d: Retire struct intel_svm

 include/linux/iommu.h        |   3 +
 drivers/iommu/intel/iommu.h  |  66 +++---
 drivers/iommu/intel/trace.h  |  97 +++++++++
 drivers/iommu/intel/cache.c  | 389 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c  | 294 ++++----------------------
 drivers/iommu/intel/nested.c |  71 ++-----
 drivers/iommu/intel/svm.c    | 279 ++++++-------------------
 drivers/iommu/iommu-sva.c    |  16 +-
 drivers/iommu/intel/Makefile |   2 +-
 9 files changed, 660 insertions(+), 557 deletions(-)
 create mode 100644 drivers/iommu/intel/cache.c

-- 
2.34.1


