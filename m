Return-Path: <linux-kernel+bounces-71191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984885A1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4631C22975
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AE2D05F;
	Mon, 19 Feb 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIvOZoyL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6B2C1A6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341728; cv=none; b=sJO1mo/I7/Tf7AXwKCEB0boq3/TgrMtBT3X+LDTvNa71IwSeAy+NzDfoA/nvK3KgFr/M/r1FHy+ZBd/osaH0kEiYu0qnl8JR27peZKtfNMi3kggdqs6rdD4nnD8e4CNo2uXDcJgslRYyD/kSbF+SmcNszjcVPdf+xJJ68tmjlJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341728; c=relaxed/simple;
	bh=7Xq0FoTONpxLm9RWoF+B7SARgkpsA7bimB+gDd+Xbq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYydErpbGEsjh4SvceS/A/8EOGf2EEptQeoRPjY4lruZmHJUguCpbvqVHmj3H9KJgLZdP2LuNfaZ/ZkM4Od4/IdRNlK1BjXMJLNBsBi/Yge0AgnDEEdqtDyirqLvkWPNfBsQHfJXaywjbzS6Uu7IwNyOXB5TdhdjPT2W38lQb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIvOZoyL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341727; x=1739877727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Xq0FoTONpxLm9RWoF+B7SARgkpsA7bimB+gDd+Xbq0=;
  b=lIvOZoyL6ChB/TMoFlm5bqWyYSueZV1nP5HtHs4AI4pc0VnpsiaHUtor
   mmXkG41A3j9BJjrcttTbwy9mD0YoUDg5oHVYJuUbeVh/06wIGw10ZkmTP
   x53CONktxkaWxfgkr1B7ApM5Z9ZBNyKjGz3dpUyJ3ZdUU3TDgJwFCnUHz
   sj9WNHG5J5w6q0G3iX7sslFfMpBzr7FZhIlyh5Y/05BZ0crksd5vQD6xD
   yzJ2wIacrqea5w3AmhvCoDo7nSR97kc9UCz0Wi6yO5lLvW65AsGyKyj4f
   rvmNGatCGXM6+NZKNfMtWH2q0oo9J/NIOuuT0F5jXLVPXNfcTiNH8V49s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823381"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823381"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:22:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826846"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:22:04 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] iommu/vt-d: Remove domain parameter for intel_pasid_setup_dirty_tracking()
Date: Mon, 19 Feb 2024 19:15:57 +0800
Message-Id: <20240219111601.96405-7-baolu.lu@linux.intel.com>
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

The only usage of input @domain is to get the domain id (DID) to flush
cache after setting dirty tracking. However, DID can be obtained from
the pasid entry. So no need to pass in domain. This can make this helper
cleaner when adding the missing dirty tracking for the parent domain,
which needs to use the DID of nested domain.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240208082307.15759-7-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h | 1 -
 drivers/iommu/intel/iommu.c | 7 +++----
 drivers/iommu/intel/pasid.c | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 8d40d4c66e31..487ede039bdd 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -307,7 +307,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, u32 pasid);
 int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
-				     struct dmar_domain *domain,
 				     struct device *dev, u32 pasid,
 				     bool enabled);
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2eee83b5441b..d286b8554227 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4741,8 +4741,7 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 		goto out_unlock;
 
 	list_for_each_entry(info, &dmar_domain->devices, link) {
-		ret = intel_pasid_setup_dirty_tracking(info->iommu,
-						       info->domain, info->dev,
+		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
 						       IOMMU_NO_PASID, enable);
 		if (ret)
 			goto err_unwind;
@@ -4756,8 +4755,8 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 
 err_unwind:
 	list_for_each_entry(info, &dmar_domain->devices, link)
-		intel_pasid_setup_dirty_tracking(info->iommu, dmar_domain,
-						 info->dev, IOMMU_NO_PASID,
+		intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
+						 IOMMU_NO_PASID,
 						 dmar_domain->dirty_tracking);
 	spin_unlock(&dmar_domain->lock);
 	return ret;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3239cefa4c33..a32d7e509842 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -428,7 +428,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
  * Set up dirty tracking on a second only or nested translation type.
  */
 int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
-				     struct dmar_domain *domain,
 				     struct device *dev, u32 pasid,
 				     bool enabled)
 {
@@ -445,7 +444,7 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 		return -ENODEV;
 	}
 
-	did = domain_id_iommu(domain, iommu);
+	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
 	if (pgtt != PASID_ENTRY_PGTT_SL_ONLY &&
 	    pgtt != PASID_ENTRY_PGTT_NESTED) {
-- 
2.34.1


