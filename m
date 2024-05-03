Return-Path: <linux-kernel+bounces-167712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCDA8BADD5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FDA1C22B39
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386A153BEF;
	Fri,  3 May 2024 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXVKDqft"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7197153BC9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743459; cv=none; b=A2ZVaPXaggnSuKc7DQ5gcQBwyabWtQ14VZNquQzBvl/nEdvr4BA97SnvkhFMGanop5I+LUneodcuj+Y9OHETatqy6NHUswMlhDOTv9IBoICf2rfit+m5Uv3A5jxQIxDa2BvFWekL17S4LLRvGLpFR3dsx8uF5ggIlzye/ItuIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743459; c=relaxed/simple;
	bh=PckfaEN9GLMYQKxkehM8NbsbWnFBdYLfz1dj4dyqX98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ID2sIlXydycgA/0nS17UjCK3LGC8hYwjZNM9tTkDNv3mGcsECISEURgZatNw4703HJ6M0DkyYtrvOGaxn0D5IWIs1WdrPRhipnSGhuD7s5JkJg45frtAOBEjh65kISI0jbB/VjCtNjfXi5XLyYpyUPRcGNyiNmljLAR7feGZDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXVKDqft; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714743458; x=1746279458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PckfaEN9GLMYQKxkehM8NbsbWnFBdYLfz1dj4dyqX98=;
  b=IXVKDqft1wo88DOOaiTLP7CDmm0yUGBByzq0ls8myXtDYEnojIr1hsr3
   x6dbe71i+ijvOvPbkPjApx3/MLtI0flww0hZ8/1tSdWlMpoj4TZXe9dn7
   yvSi1q0IM1VWMRK2U1415G6KlzlV7AaGWOOlLbRXj5CmydnzJOkxVAT+U
   r4/KrKPsW9pJysVmDdCK/eNLqKHWwE3BS1C5i34+sdvyxJSkwkjXOCyIB
   2palt58RpDurEjp/1SKgzDTQprOnUMrHlP7Zsn9sKdP9RPooWoE6tztZL
   sodYtzIVmwP6PkwbVrZQMoh03IgltslsZ0J1tjb2jI8x6Q2qDZMClbC4o
   Q==;
X-CSE-ConnectionGUID: TdetRNRHT26cbZ7Ugn1q9w==
X-CSE-MsgGUID: dd/pa4JAQyCHcL+aVmQC9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="13499476"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="13499476"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 06:37:37 -0700
X-CSE-ConnectionGUID: 5uVt1q6bQVGMFjVriNY+Ng==
X-CSE-MsgGUID: /4kl+Zt0Q9igVn6mU+ExWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27502243"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa009.jf.intel.com with ESMTP; 03 May 2024 06:37:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Decouple igfx_off from graphic identity mapping
Date: Fri,  3 May 2024 21:36:02 +0800
Message-Id: <20240503133602.78992-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503133602.78992-1-baolu.lu@linux.intel.com>
References: <20240503133602.78992-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kernel command called igfx_off was introduced in commit <ba39592764ed>
("Intel IOMMU: Intel IOMMU driver"). This command allows the user to
disable the IOMMU dedicated to SOC-integrated graphic devices.

Commit <9452618e7462> ("iommu/intel: disable DMAR for g4x integrated gfx")
used this mechanism to disable the graphic-dedicated IOMMU for some
problematic devices. Later, more problematic graphic devices were added
to the list by commit <1f76249cc3beb> ("iommu/vt-d: Declare Broadwell igfx
dmar support snafu").

On the other hand, commit <19943b0e30b05> ("intel-iommu: Unify hardware
and software passthrough support") uses the identity domain for graphic
devices if CONFIG_DMAR_BROKEN_GFX_WA is selected.

+       if (iommu_pass_through)
+               iommu_identity_mapping = 1;
+#ifdef CONFIG_DMAR_BROKEN_GFX_WA
+       else
+               iommu_identity_mapping = 2;
+#endif
..

static int iommu_should_identity_map(struct pci_dev *pdev, int startup)
{
+        if (iommu_identity_mapping == 2)
+                return IS_GFX_DEVICE(pdev);
..

In the following driver evolution, CONFIG_DMAR_BROKEN_GFX_WA and
quirk_iommu_igfx() are mixed together, causing confusion in the driver's
device_def_domain_type callback. On one hand, dmar_map_gfx is used to turn
off the graphic-dedicated IOMMU as a workaround for some buggy hardware;
on the other hand, for those graphic devices, IDENTITY mapping is required
for the IOMMU core.

Commit <4b8d18c0c986> "iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA" has
removed the CONFIG_DMAR_BROKEN_GFX_WA option, so the IDENTITY_DOMAIN
requirement for graphic devices is no longer needed. Therefore, this
requirement can be removed from device_def_domain_type() and igfx_off can
be made independent.

Fixes: 4b8d18c0c986 ("iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240428032020.214616-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fbbf8fda22f3..2e9811bf2a4e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -217,12 +217,11 @@ int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
 int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
 
-static int dmar_map_gfx = 1;
 static int intel_iommu_superpage = 1;
 static int iommu_identity_mapping;
 static int iommu_skip_te_disable;
+static int disable_igfx_iommu;
 
-#define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
 const struct iommu_ops intel_iommu_ops;
@@ -261,7 +260,7 @@ static int __init intel_iommu_setup(char *str)
 			no_platform_optin = 1;
 			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
-			dmar_map_gfx = 0;
+			disable_igfx_iommu = 1;
 			pr_info("Disable GFX device mapping\n");
 		} else if (!strncmp(str, "forcedac", 8)) {
 			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
@@ -2196,9 +2195,6 @@ static int device_def_domain_type(struct device *dev)
 
 		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
-
-		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
-			return IOMMU_DOMAIN_IDENTITY;
 	}
 
 	return 0;
@@ -2499,9 +2495,6 @@ static int __init init_dmars(void)
 		iommu_set_root_entry(iommu);
 	}
 
-	if (!dmar_map_gfx)
-		iommu_identity_mapping |= IDENTMAP_GFX;
-
 	check_tylersburg_isoch();
 
 	ret = si_domain_init(hw_pass_through);
@@ -2592,7 +2585,7 @@ static void __init init_no_remapping_devices(void)
 		/* This IOMMU has *only* gfx devices. Either bypass it or
 		   set the gfx_mapped flag, as appropriate */
 		drhd->gfx_dedicated = 1;
-		if (!dmar_map_gfx)
+		if (disable_igfx_iommu)
 			drhd->ignored = 1;
 	}
 }
@@ -4621,7 +4614,7 @@ static void quirk_iommu_igfx(struct pci_dev *dev)
 		return;
 
 	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
-	dmar_map_gfx = 0;
+	disable_igfx_iommu = 1;
 }
 
 /* G4x/GM45 integrated gfx dmar support is totally busted. */
@@ -4702,8 +4695,8 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 
 	if (!(ggc & GGC_MEMORY_VT_ENABLED)) {
 		pci_info(dev, "BIOS has allocated no shadow GTT; disabling IOMMU for graphics\n");
-		dmar_map_gfx = 0;
-	} else if (dmar_map_gfx) {
+		disable_igfx_iommu = 1;
+	} else if (!disable_igfx_iommu) {
 		/* we have to ensure the gfx device is idle before we flush */
 		pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
 		iommu_set_dma_strict();
-- 
2.34.1


