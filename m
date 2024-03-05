Return-Path: <linux-kernel+bounces-91505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333A787126A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659311C2242B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2C61B81A;
	Tue,  5 Mar 2024 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcDLW+5W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD41AAD3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602771; cv=none; b=Wd4HPP8tviMsFuK+bslc2GwIssJqPetVhAOYGQh4lmYkXY/CWpcZN89tgLLBFgkniJMXvxIlt1OEdnVzKdI9CBWaDf1DVn6l8NT9q8yMrg9SyhPe07OZg6K4l+0ObHiVcBkQ2loheeVDc9ir1TEdgReOu////ATeOP21zch35V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602771; c=relaxed/simple;
	bh=qIJJGnwDPVDv4F7r6y/s39ika2Bz0nOGa718N4ZxZGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqi8KqBWfFzCrM3BisbriAXjTzlZKnuZjRtayJd28lvAXefc+3wN8a5PjUMvVcOcWtyG7X/hndzwPAtvo1EldjIbB1ZoCBDRGiEW6mSsuRGyjEFTERBL0sZv777VI4IcxwCAsHT+cbF3xayGKdcJSKpCbsLxY0J98Zl6diOTwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcDLW+5W; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709602770; x=1741138770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qIJJGnwDPVDv4F7r6y/s39ika2Bz0nOGa718N4ZxZGg=;
  b=NcDLW+5Wch8F6MgI2ncxdbWutcwKXgY+8YoZq0DSDeOoKY8YUkXiKrbF
   0jcmlLo395FI+tRkvjB3fsdUeTaRgbp0plt4lIus/Iv/gSrppXJgOs6Lp
   y9CauQkUVHvxlqUvs4vgZcXJ9L5kZ3X2YCVStQ3d4Usrr5FgtMM+zYcW0
   MFT+/4sEUPvnKyRdmxDcKQILuCrYtHhyid+r/TvlMgV9oW3VbCSSFNpk2
   KfEiB9NQn5MA8n+Iap36iFpauqvrBPxO+Hrnm3E8AzPhO/wKRbbwq3wTl
   gLi9yuj0T5QmDxf8EPdI5eDoC48vDrWkvHGfOSlBu7pzojbf0+pONkykZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4286734"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4286734"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:39:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13865517"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2024 17:39:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 5/5] iommu/vt-d: Remove scalabe mode in domain_context_clear_one()
Date: Tue,  5 Mar 2024 09:33:05 +0800
Message-Id: <20240305013305.204605-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305013305.204605-1-baolu.lu@linux.intel.com>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

domain_context_clear_one() only handles the context entry teardown in
legacy mode. Remove the scalable mode check in it to avoid dead code.

Remove an unnecessary check in the code as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d682eb6ad4d2..50eb9aed47cc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2175,9 +2175,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	struct context_entry *context;
 	u16 did_old;
 
-	if (!iommu)
-		return;
-
 	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
 	if (!context) {
@@ -2185,14 +2182,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 		return;
 	}
 
-	if (sm_supported(iommu)) {
-		if (hw_pass_through && domain_type_is_si(info->domain))
-			did_old = FLPT_DEFAULT_DID;
-		else
-			did_old = domain_id_iommu(info->domain, iommu);
-	} else {
-		did_old = context_domain_id(context);
-	}
+	did_old = context_domain_id(context);
 
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
@@ -2203,9 +2193,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 				   DMA_CCMD_MASK_NOBIT,
 				   DMA_CCMD_DEVICE_INVL);
 
-	if (sm_supported(iommu))
-		qi_flush_pasid_cache(iommu, did_old, QI_PC_ALL_PASIDS, 0);
-
 	iommu->flush.flush_iotlb(iommu,
 				 did_old,
 				 0,
-- 
2.34.1


