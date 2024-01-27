Return-Path: <linux-kernel+bounces-41082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080683EB87
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0426D1F234F6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16DC1D524;
	Sat, 27 Jan 2024 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPHoHJPH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8EE17744
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706338247; cv=none; b=hA3BP/l/px5PUqVzWTmvYYPJUSUk/qrNtjnqeiWCiROBwirkV7JsKmmxvOnU5YoLJ2zm0mfLIaKyPpE6c79tKvPJF6PJzClqGKod3Eg1GmtxaJ72rPA6LkFF3/Q61mof54NqmpQLuhSI7dGecvUsud5ac7z+PEwY7Ce3zOTVCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706338247; c=relaxed/simple;
	bh=baNrkmKkIf2EbMQeJAh+ylYFxPSnzWuHm7wIxFgXO2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uqf/6ORupk2GY0LVmR6xQTjuBIm2OPB3nGjuXaeKCkZPFHMpz0MLbnVjTCzrAEkF5ZyRUijI1r4av6O+TopMhoPzivh8wnPG9VrVHiSZs4zTnsN4nt8Pw42yoE3n6nMM6LUXX0Jd6DPuo8NPxzb6U9r0Qc0VcmIK1Bv5lGCxsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPHoHJPH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706338246; x=1737874246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=baNrkmKkIf2EbMQeJAh+ylYFxPSnzWuHm7wIxFgXO2A=;
  b=HPHoHJPHYwMso5g+MoFxajFpwyozfGLxLRmZRC302Y9voicTN5EK9C1R
   1J6WleRnorUJWuHBTPQJZDkrWgrL2NwlPB0Sq9m8QlOIlyiIzIUcsVXVC
   WYD8vjAZUTYYjupuQK0Ci5zRZZbJaV7Oz1xRjc2QCu/ndd2LF38FyvYYF
   1WaAPL8XEvmHw9dDVRFEOqcR8cnvfbVX3oDt1tl4kMQvgDkg5hfHUDECj
   SSC0rR98eup4hjRqsVs+O3XsUzNBRBJ/xl+zqR56vg4hmHAXUZ7QVJCnq
   5iae/EVDDnCVEqdezyXeTKvaXXA2OqYUvNZSzG9pgDQ/dlLW7axzqmJfz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9769105"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9769105"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 22:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2894508"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 26 Jan 2024 22:50:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Date: Sat, 27 Jan 2024 14:45:12 +0800
Message-Id: <20240127064512.16744-1-baolu.lu@linux.intel.com>
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

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  4 ----
 drivers/iommu/intel/Kconfig | 11 -----------
 2 files changed, 15 deletions(-)

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


