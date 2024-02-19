Return-Path: <linux-kernel+bounces-71188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41AC85A1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBAC283D97
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59062CCDF;
	Mon, 19 Feb 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIu7a43C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1412C6B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341721; cv=none; b=oubcB5nt/dVEBrSoMmkwVLWuDxNU9hVPvtcXb3w7+f7sOzlT1m90EoINcQJ0iy+1rJrj33/Ujtiix5KZfROukw2zcNVcQCiyv63WfHU0kG1IKlT0VN8//gDzrK3aQqM9l6ZNUvRn82/wQ0unWsVXM1yfO5/Dzk5BYeSWeaY9KHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341721; c=relaxed/simple;
	bh=wdo4y+teNsTSHhgxPZRjHIAgdvEhP4G9F49w7xcQvdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/LFRmW41T776k4ib7jrNGFPjGiZ3dDgHwjKf5Ajrxz6txfbpSVC3OzFqCaU1aaEFMvlDnVoNIlD9rHaVLAORpIBaNMSrmRH9RlJWzTD9vaYK8sbrMu49eaOVScYSOsu7aQYcQk7Tbysd8N1jZ+8Uw+UF8H7yvJaGRfdKbYlebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIu7a43C; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341720; x=1739877720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wdo4y+teNsTSHhgxPZRjHIAgdvEhP4G9F49w7xcQvdM=;
  b=PIu7a43CJOCZ6dAIk+AiUTwncLe19Yc7UxTY+0EvcNnR6Br7I0I3TztU
   I4hZRHXgHzaSgnFKttlH5iRDRKTI+m67vqbKMUGmD7aV5oaUaTCoNLxYZ
   WEjqyUfPrVMxv56V8IUwcQ9YuSdckwydaLhvJkB1hJv3rzzykfxb3Zc04
   N/nRJQ2pWmVUpqIkxvf9/Dfi2oecRxl/0jbLrfBLSu33rGjCHkLylqz9J
   K3kBNVdg8n380Q73eeKj/G/dvehD0ZSls6o27dNUEG5zi/g5lkxHf0y7J
   FRtylH1+MFOzce4JKoyn0kPmx3iFed+2+vFLxJKu+D5nV5CaZQk/DFiuY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823353"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823353"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:22:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826813"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:21:57 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] iommu/vt-d: Add missing iotlb flush for parent domain
Date: Mon, 19 Feb 2024 19:15:54 +0800
Message-Id: <20240219111601.96405-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

If a domain is used as the parent in nested translation its mappings might
be cached using DID of the nested domain. But the existing code ignores
this fact to only invalidate the iotlb entries tagged by the domain's own
DID.

Loop the s1_domains list, if any, to invalidate all iotlb entries related
to the target s2 address range. According to VT-d spec there is no need for
software to explicitly flush the affected s1 cache. It's implicitly done by
HW when s2 cache is invalidated.

Fixes: b41e38e22539 ("iommu/vt-d: Add nested domain allocation")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240208082307.15759-4-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dbdb8366c42a..e3dbcae95975 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1451,6 +1451,28 @@ static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *
 		iommu_flush_write_buffer(iommu);
 }
 
+/*
+ * Flush the relevant caches in nested translation if the domain
+ * also serves as a parent
+ */
+static void parent_domain_flush(struct dmar_domain *domain,
+				unsigned long pfn,
+				unsigned long pages, int ih)
+{
+	struct dmar_domain *s1_domain;
+
+	spin_lock(&domain->s1_lock);
+	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
+		struct iommu_domain_info *info;
+		unsigned long i;
+
+		xa_for_each(&s1_domain->iommu_array, i, info)
+			__iommu_flush_iotlb_psi(info->iommu, info->did,
+						pfn, pages, ih);
+	}
+	spin_unlock(&domain->s1_lock);
+}
+
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -1470,6 +1492,9 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		if (!cap_caching_mode(iommu->cap))
 			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
 	}
+
+	if (dmar_domain->nested_parent)
+		parent_domain_flush(dmar_domain, 0, -1, 0);
 }
 
 static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
@@ -1993,6 +2018,9 @@ static void switch_to_super_page(struct dmar_domain *domain,
 				iommu_flush_iotlb_psi(info->iommu, domain,
 						      start_pfn, lvl_pages,
 						      0, 0);
+			if (domain->nested_parent)
+				parent_domain_flush(domain, start_pfn,
+						    lvl_pages, 0);
 		}
 
 		pte++;
@@ -4125,6 +4153,9 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 				      start_pfn, nrpages,
 				      list_empty(&gather->freelist), 0);
 
+	if (dmar_domain->nested_parent)
+		parent_domain_flush(dmar_domain, start_pfn, nrpages,
+				    list_empty(&gather->freelist));
 	put_pages_list(&gather->freelist);
 }
 
-- 
2.34.1


