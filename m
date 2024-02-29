Return-Path: <linux-kernel+bounces-86485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF686C618
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425B91C24393
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC062802;
	Thu, 29 Feb 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLjA0+8o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A3629E6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200458; cv=none; b=Zidl1DsxsxFXEI1cN9T4Geq5ABithWxrYozW/ngBwIhMqEwDM62BzbiFA61hT5EZBi3+HHQLiQtZepXqOVs6OXSlymGTzQpGzL+rMgjmFGlVccFvIYyTazJTeU7ZakMBViA2gjEgQmFednA+XrIvnC8wnUq1gY3y3MOixZI5Vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200458; c=relaxed/simple;
	bh=i5VupaqaS+NrLRNsFYfr01tBDs7Ieuup0RZUQBFc98w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNH52YnbNhcFdjT5wZjZRmb3XmX7nUmWUFoNIRiX3lB89i5M0kAsKVmn3NMyqEvnCahpEHk39R/hFNrnkZQkbErwFoy4s6G5Bfctk35MoSjAoBP+0oslEBYkS0edHNQStPMv1jPQMaFrY6rP9nCP0YVjGQB1esYXnZJ0bZ0AYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLjA0+8o; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709200457; x=1740736457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i5VupaqaS+NrLRNsFYfr01tBDs7Ieuup0RZUQBFc98w=;
  b=cLjA0+8o2zSfRQzUYV02lkw4jot+499FxTMQR8q5h4dYbo/RKQ5rfwzI
   oz3lY9+bfZYjOXJTeX3nuOI/7Fdkk+HpcUbWyX3cFFO1TABS1bE72DspF
   LZQUKdVF+QWlv9xDkCk2XDXvN4s3a0zMxu9TFw04ZI1Ce7X/wod+LD5ks
   5Hlofcg6fRz66LRm2hDaAi79NJKoAgWG/MGXa/iCUVSX5CvtALlrLrEKd
   CbBWlNXeqckYuEI++TlNm9esaMAEGd2MW3adQ7UQtNbcfNwQEwhsasfNg
   6MgtwOja7Ms28c8x8En6aQ6yqI0DN6f2xdhHfwMuy3VA01dEmjt4cNZ9n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7480797"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7480797"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7695772"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 29 Feb 2024 01:54:15 -0800
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
Subject: [PATCH 3/3] iommu/vt-d: Remove scalabe mode in domain_context_clear_one()
Date: Thu, 29 Feb 2024 17:48:04 +0800
Message-Id: <20240229094804.121610-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229094804.121610-1-baolu.lu@linux.intel.com>
References: <20240229094804.121610-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

domain_context_clear_one() only handles the context entry teardown in
legacy mode. Remove the scalable mode check in it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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


