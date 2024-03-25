Return-Path: <linux-kernel+bounces-116418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D546B889AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753F81F35048
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994D3149C7D;
	Mon, 25 Mar 2024 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5q4+HFk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E214AD1A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333098; cv=none; b=GEK30mrrSe4zyGC+2FaeSisCDIos0STy1Wf+86yV/wElUS+hOnLyO0pb5lkUQD/xjhsh2qMB+3ZCX2AN4t1xjsjWghbxhMWC5ZWLFJ0oVnW2mG1NnU/e6pb1fZyVpBwwwkUgyHjz0tmF7ZJzB0t0wfA9NvDhxolkAx9dsm0zWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333098; c=relaxed/simple;
	bh=X91sn3qLI1hNjQ+x53CENgbWg0CtCQsOM/1KIO/sS8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+35azmh0aN4QcVyXGuVgotU0krRP8w3MYUeU+R33ZdTx882kOyvDBS6juQw/urNfpwUeMDXhl66yDjYuWLDQAHA+sCh7B1FJefxJcTZzDqPL71CD802QjFowixE9iukek9KJJGaa6U0e8pCwjxY/cF7s8ibipjdxg9gg1rFMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5q4+HFk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333096; x=1742869096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X91sn3qLI1hNjQ+x53CENgbWg0CtCQsOM/1KIO/sS8s=;
  b=W5q4+HFk01ZhavriYnUlUFGCWQ9ILaRRfwU70cJdU8EMxauNufDU+6DD
   YgB+5VKka8FKhBq0sM3Qwo1GUBDLuG0rc+9Ksct2zksej/u2kYtbjvn0I
   9PZZ98lF2CH34uMkW1HctXBRhkVoGeorUGeDy4VpSUdFmQt8qpDeYPf+d
   9CMVQbqZ0EkajHJzQsr1NUYoBvIldPmo8bd0NNVMOxxcWeeIECbSD2S2i
   5svKOu2I2SmXK8GCScuCOLF5aYlxdIZ2DR0qmFcqCcPNIExfwBWiGcMMQ
   iKz+HFKAKo6IMJU0MG5BorZ4tqbYlnnyHU1gSaID9IEQ3DNn/OA8uQAMJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271347"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271347"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353941"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:09 -0700
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
Subject: [PATCH 04/12] iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
Date: Mon, 25 Mar 2024 10:16:57 +0800
Message-Id: <20240325021705.249769-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flush_iotlb_all callback is called by the iommu core to flush
all caches for the affected domain. Use cache_tag_flush_all() in
this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 93e4422c9b10..4ce98f23917c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1560,26 +1560,7 @@ static void parent_domain_flush(struct dmar_domain *domain,
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct iommu_domain_info *info;
-	unsigned long idx;
-
-	xa_for_each(&dmar_domain->iommu_array, idx, info) {
-		struct intel_iommu *iommu = info->iommu;
-		u16 did = domain_id_iommu(dmar_domain, iommu);
-
-		if (dmar_domain->use_first_level)
-			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
-		else
-			iommu->flush.flush_iotlb(iommu, did, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
-
-		if (!cap_caching_mode(iommu->cap))
-			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
-	}
-
-	if (dmar_domain->nested_parent)
-		parent_domain_flush(dmar_domain, 0, -1, 0);
+	cache_tag_flush_all(to_dmar_domain(domain));
 }
 
 static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
-- 
2.34.1


