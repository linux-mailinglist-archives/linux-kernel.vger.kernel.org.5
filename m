Return-Path: <linux-kernel+bounces-92375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730C8871F31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2462D288B32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46805CDEF;
	Tue,  5 Mar 2024 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h38YFYa+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895005C913
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641663; cv=none; b=nYVpEFgOX48dpDQIAVnbsnUqfDuZn0yUSxDYtzbH7nYZ7bmJifo8rYqYBH7VOXDiuQYBd/DjMEeZPl/dWia1OrPC1jZTwISjCbKOCQ4UlEw0cJcUh4qipCo40HKWLGDxKuvfuWxzLt8ZB2/J5eLBjuzhncneaaKbewd1I0Y3ykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641663; c=relaxed/simple;
	bh=ZowgDUVcvv+doVk6YVMSxDhTJIb10vanJKzULJxdQqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h71dIIQWoHfVXWuFuywXEkNVhnaVig5NglQUhEg3AbhPIBilnmF/NhDyWCcPgKaVnuoYp41JP7/XRjUgO4kjFFMZ/2ndtVxVjpnRodf8vHo3JTPvjztus8KcuQO1wHzufoJyoRDA/T3bNGQe9jiBDBqffvgDhwO462MStWbjwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h38YFYa+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709641661; x=1741177661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZowgDUVcvv+doVk6YVMSxDhTJIb10vanJKzULJxdQqE=;
  b=h38YFYa+v0wsrOdkE2zZLgycP6CPGYbBwhgQxcFnQqFNFGTM/5JeOoqK
   MsFJAsafi11X9ilVWLv+DIzHgwjs/cwQir69+sasIYEY6Gw87WYVJ45sB
   YIhgG+P1oc2kz2MGuN2mOLv9uN4u6mKx+G+nrm8CxBXN4mXoX62nCTwT5
   IDLtNVgil41UYm3X1wG2tmpwUCjMg8sjZHexg6ezrPw4d5WNdjajwDs4a
   ItmCTszJPlKC+N5DnRUETJjTB3qm1Ldg69R/oivV5YdKuivk/3ooNJzuO
   S+pgNfm8Tmk722UAPYzVyAgXZ/vFH5H2zcl7iYjSt+7KY8wAY6FqkJ4G7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21648524"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21648524"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9330155"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2024 04:27:40 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] iommu/vt-d: Remove scalabe mode in domain_context_clear_one()
Date: Tue,  5 Mar 2024 20:21:21 +0800
Message-Id: <20240305122121.211482-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305122121.211482-1-baolu.lu@linux.intel.com>
References: <20240305122121.211482-1-baolu.lu@linux.intel.com>
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
Link: https://lore.kernel.org/r/20240305013305.204605-6-baolu.lu@linux.intel.com
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


