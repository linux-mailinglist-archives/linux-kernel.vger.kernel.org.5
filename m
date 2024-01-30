Return-Path: <linux-kernel+bounces-43974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C2841BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827441C2331A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7E5381D1;
	Tue, 30 Jan 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTvbDsNF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45353839C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595240; cv=none; b=S5ptesMRqvjWyWAiUz93gGduw2FdKRuhkOQw8ZH+fxuocJ/6tQ9zIANAEAuisRgzGHOdIbnImox36Hr+ZgltKTuxGUuuwUF9hviJ4cE1tecueBtaMUOFA6Iv8xTYeL4gqWK9nwhCaFOAWV+kn0IdYS7DAI3r2vocLILvPrM7aPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595240; c=relaxed/simple;
	bh=mbAJ/zTviPWkO8LHJ1tHYgfZ4TkYmkoH7kPNS0Gfjmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nCUVfSs7sBNxPMiu3YifVm4gjlXFnMCCpQgWs0upMXT5LRYlOzHszAKMBHDMtMVrp4uhECMnsUeYuZQfPDS4+xzWnLWkoC32YsEq6aHGw8ybdnAxpP/QZ8/47vpkfeb8KV8vxNbTUPDh6UdrVFtIZDc2Wpb5u47WQujRzOXNE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTvbDsNF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706595239; x=1738131239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mbAJ/zTviPWkO8LHJ1tHYgfZ4TkYmkoH7kPNS0Gfjmc=;
  b=hTvbDsNFCn/m7I7+0xP7Y77bZuaEssL2M9Aa43MYkbSGADHRhl9LAXY6
   XJQCtzstH7vCJXUtDvqaiLft6pTCzTnTCMNx2ZYmzOc9qZj5YU3XPeBMH
   U+WxA0kd5UuT49zpoHLiwlEObMB0jDfnNmkVnhPR1EhDR3UWG8YK8V/OB
   6gtJN9l9pLbplSIbFWi7gP5jEFGrEMiT/VgWFP37Bqm2yyKsuB4NteveW
   vuyNMASBUcFkE39q5ixyvJODRhg0ZlrNHsBNx0vJ/s858hmoJCJAiYy9T
   vA0be23kvYJhzUP3Mfz2Iup5Ko1Lu6xh3lhLA7VfBzKKJEfVXaKF7HxeO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10570669"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10570669"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:13:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3706925"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 29 Jan 2024 22:13:54 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	iommu@lists.linux.dev,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Date: Tue, 30 Jan 2024 14:08:23 +0800
Message-Id: <20240130060823.57990-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA option for
broken graphics drivers") was introduced 24 years ago as a temporary
workaround for graphics drivers that used physical addresses for DMA and
avoided DMA APIs. This workaround was disabled by default.

As 24 years have passed, it is expected that graphics driver developers
have migrated their drivers to use kernel DMA APIs. Therefore, this
workaround is no longer required and could been removed.

The Intel iommu driver also provides a "igfx_off" option to turn off
the DAM translation for the graphic dedicated IOMMU. Hence, there is
really no good reason to keep this config option.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c |  4 ----
 drivers/iommu/intel/Kconfig | 11 -----------
 2 files changed, 15 deletions(-)

Change log:
v2:
 - Add igfx_off option to commit message and Cc Intel graphic
   maintainers.

v1: https://lore.kernel.org/linux-iommu/20240127064512.16744-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6fb5f6fceea1..fc52fcd786aa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2660,10 +2660,6 @@ static int __init init_dmars(void)
 		iommu_set_root_entry(iommu);
 	}
 
-#ifdef CONFIG_INTEL_IOMMU_BROKEN_GFX_WA
-	dmar_map_gfx = 0;
-#endif
-
 	if (!dmar_map_gfx)
 		iommu_identity_mapping |= IDENTMAP_GFX;
 
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 012cd2541a68..d2d34eb28d94 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -64,17 +64,6 @@ config INTEL_IOMMU_DEFAULT_ON
 	  one is found. If this option is not selected, DMAR support can
 	  be enabled by passing intel_iommu=on to the kernel.
 
-config INTEL_IOMMU_BROKEN_GFX_WA
-	bool "Workaround broken graphics drivers (going away soon)"
-	depends on BROKEN && X86
-	help
-	  Current Graphics drivers tend to use physical address
-	  for DMA and avoid using DMA APIs. Setting this config
-	  option permits the IOMMU driver to set a unity map for
-	  all the OS-visible memory. Hence the driver can continue
-	  to use physical addresses for DMA, at least until this
-	  option is removed in the 2.6.32 kernel.
-
 config INTEL_IOMMU_FLOPPY_WA
 	def_bool y
 	depends on X86
-- 
2.34.1


