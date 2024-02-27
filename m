Return-Path: <linux-kernel+bounces-82589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0718686CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443D8287F81
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A61802E;
	Tue, 27 Feb 2024 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BX1ZQ04B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957AF9F0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000442; cv=none; b=CMcNPiO5+3Sei9zYcAvAzPO8U15ORZsgr8Q5Uo0W2AwPxaDQsLrWa3Ur6cIn28r8G01D86Y002fWEv+gqJ0ivtkJzhtub77SgFl7zbksxkjojaG/yq0rA6bdn+x2xoTQr7W9ailBwZGUTFK9/UK44ER9UsnwYj8RuNnsj+Bqf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000442; c=relaxed/simple;
	bh=cctrjxaRbRi+TKu+hYmdPS1a9OktKar4KCqbjTm4+5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncad9UMOwE9OiY9e1xXOjyv+2nz4vTMmSpK3+/6zR/Ftas9vHyMWch632JtiC7BhedNXABZrkeChbSYKaCUTScF7DKFjuBq6h2DAwt2tAL6aSYQH/nMcLCDX/L5lgs8Fpamcub1EUSZVl/ZL76hNAWuofT3RafUBnVYP+BcW+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BX1ZQ04B; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000440; x=1740536440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cctrjxaRbRi+TKu+hYmdPS1a9OktKar4KCqbjTm4+5c=;
  b=BX1ZQ04BZ3Dkcr2w6JKnrNCxelemG4ti5Jeyb/8UF/zl0emLC1Y3I/9F
   XiS7StSycO2hzZeOk/CypgLav2Evx0ArHR5I5wv/tSCR/v3Ao1C+ntf6U
   Wt0UvSmS778Rc2IKI53BxObow/3KNLoV8vVSNYF1NM/Pm5PvCwkrTkg2k
   kQ4Di2M9nPWPVq2YoRJM5qFIRA1+cplb3FnGXkJvBFPaMJ+zql4F3guAL
   xpIQIzs9gKnHRYzEfTuWF746WfJeCycxMptZIkoWTXn8SQyC2W7E9XmVo
   brFpibTLmbEyxl6dqoM8XbBL6MPSf6qAN3SAo84kvmegK4e87BEvsW86C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6273096"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6273096"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:20:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7418282"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 18:20:38 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Date: Tue, 27 Feb 2024 10:14:34 +0800
Message-Id: <20240227021441.50434-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227021441.50434-1-baolu.lu@linux.intel.com>
References: <20240227021441.50434-1-baolu.lu@linux.intel.com>
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
the DMA translation for the graphic dedicated IOMMU. Hence, there is
really no good reason to keep this config option.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240130060823.57990-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c |  4 ----
 drivers/iommu/intel/Kconfig | 11 -----------
 2 files changed, 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 11652e0bcab3..cfbe7c8e74fb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2712,10 +2712,6 @@ static int __init init_dmars(void)
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


