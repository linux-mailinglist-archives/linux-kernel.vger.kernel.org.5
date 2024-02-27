Return-Path: <linux-kernel+bounces-82594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3038686D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE401C285FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7F54BC3;
	Tue, 27 Feb 2024 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/oJpDjK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3112A4EB46
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000451; cv=none; b=dp70+KLeN2eA1bB5En4muE51sZ3QiDl4GZqMGE+rwBB1jN4UrtuED1An4mIGyklLt55zc7fC6EraIZtnTa8alT/jiAQ3EugBaIoSs185/BEV+RgUaxaANa8z06+8hhtpKWdyS9Pi+fj5v+KW8iD5RJTbIgkuqpwHzOf4EWWzxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000451; c=relaxed/simple;
	bh=l3KHltvidM1+Dw9DIvEfLJOSy3pkwtgZUOjJYqUC4ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6FLs23nC+uS6vJSKWAX7Rj3vs08wWHsgjTeLhzHJCyCHANaC1KowsCfVM8Pg6paHPJTwOGNiPvEuLt4Za2RTeIwlezKnfIXIF1w1IQxjipJ3TgANJnyeKLCOOJU1gsY3u7L7xbZtgom2ZH+5hK9MgEufnlrC6jUp8GplHTSR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/oJpDjK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000450; x=1740536450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3KHltvidM1+Dw9DIvEfLJOSy3pkwtgZUOjJYqUC4ug=;
  b=T/oJpDjKLsa6pxXHYMzCgUsae+pawnT3dZqIf6YO1YksqCWk7dgPI2zB
   0YBJ7yGcuU0NdTaZaLSbQJon8RwmIjQS90SFhpRCnq9VQmpquY7JDDEqN
   p9ix77hxNCQWHHC0i/pgsxoDivvtQYJEv1bu9e8sa0iSA8Cy7pDhQM25b
   oFO0hZb5fBjBTl1xOaeek061k9LwfJGelU2hpKUVhoWmc01y27AtP76qh
   14FLVa1t787U9+eKxzvz9uhdCZNRx52u+8qp9aad+qBAuSiHo2zzLAdHj
   4vDjUkTcF4rUxyw2R79vgJMjNGJtT2bmWSdAO6FHfXQyUIEvH7/jqaA3h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6273124"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6273124"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7418303"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 18:20:48 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] iommu/vt-d: Merge intel_svm_bind_mm() into its caller
Date: Tue, 27 Feb 2024 10:14:39 +0800
Message-Id: <20240227021441.50434-7-baolu.lu@linux.intel.com>
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

From: Tina Zhang <tina.zhang@intel.com>

intel_svm_set_dev_pasid() is the only caller of intel_svm_bind_mm().
Merge them and remove intel_svm_bind_mm(). No functional change
intended.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20240219125723.1645703-4-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index a92a9e2239e2..1dd56d4eb88c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -315,10 +315,11 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	return 0;
 }
 
-static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
-			     struct iommu_domain *domain, ioasid_t pasid)
+static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
@@ -796,15 +797,6 @@ int intel_svm_page_response(struct device *dev,
 	return ret;
 }
 
-static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
-
-	return intel_svm_bind_mm(iommu, dev, domain, pasid);
-}
-
 static void intel_svm_domain_free(struct iommu_domain *domain)
 {
 	kfree(to_dmar_domain(domain));
-- 
2.34.1


