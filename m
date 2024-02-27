Return-Path: <linux-kernel+bounces-82592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A638686CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06BD1C22E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E34838FA1;
	Tue, 27 Feb 2024 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7OLLwig"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497C10A34
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000447; cv=none; b=qM5r20WHnGsl2543CkLp0lNd4Rz8saRx8aC5rWavKeIeqn3CxTSENGFAQSlZKu1SgOns2AsnsSqs30xd5uJVrihF6dsxTA7SBQnpLe8Jzn1HP62jrUgnUDzYVhdqGTbZ/lobhvxuDIxEw3AVD5f6RYP7m/ZCpKOcOGEwI93cThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000447; c=relaxed/simple;
	bh=qVQIcSHSJ4R57qtQzHqo/LOuOIYQCzdxlV3v9opOJ34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BnbD3d/9d5pR+OhOAkrDIAmxAbVpGui/J1cQaDCHUy6g34OqMNyO7/3RsWMfS9Bu0FgQ6xFxfVjXp1wHWk4UEDODx0njl+04uurO457/y5KHyNBNfeGIoUUoRIBvwlHB/dhiQZWTyt1G8muhtsHAvoWLSNHvIQaHUa3nLp/Vcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7OLLwig; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000446; x=1740536446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qVQIcSHSJ4R57qtQzHqo/LOuOIYQCzdxlV3v9opOJ34=;
  b=R7OLLwigWihZDCx/o2BM/QIbFAPmUyqaYO23EhEYoyOR4r1hxDSp4VKc
   wB2lyFJYJ5sAcvHQAT9KoyYnknczCktToMAPlhp9V37/ri2pPNM+K6OTj
   2eWQDlMJS+Hyp9BgKbmsKBR3gQfQjGoZgKazns3HyeVO6H2B0Gpz12j0W
   LLUjOEBJNk77Du3eek7sRMni5xd54tTaNM+Gnoz2yuRrrr8GDhR8WJ/WQ
   KuszVNLA2h65QQBQsJ6GuNUCvEd4r0elJymnmErH+oPaRiGLK3L66FeJX
   Qmqy6xm5vBEbTMbKbnnKWq43aCJc0hoP9OH0HRkDdflCD2FjoORgSKSgD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6273112"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6273112"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:20:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7418295"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 18:20:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] iommu/vt-d: Remove treatment for revoking PASIDs with pending page faults
Date: Tue, 27 Feb 2024 10:14:37 +0800
Message-Id: <20240227021441.50434-5-baolu.lu@linux.intel.com>
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

Commit 2f26e0a9c986 ("iommu/vt-d: Add basic SVM PASID support") added a
special treatment to mandate that no page faults may be outstanding for
the PASID after intel_svm_unbind_mm() is called, as the PASID will be
released and reused after unbind.

This is unnecessary anymore as no outstanding page faults have been
ensured in the driver's remove_dev_pasid path:

- Tear down the pasid entry, which guarantees that new page faults for
  the PASID will be rejected by the iommu hardware.
- All outstanding page faults have been responded to.
- All hardware pending faults are drained in intel_drain_pasid_prq().

Remove this unnecessary code.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20240219125723.1645703-2-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 40edd282903f..a815362c8e60 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -408,13 +408,6 @@ void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 			if (svm->notifier.ops)
 				mmu_notifier_unregister(&svm->notifier, mm);
 			pasid_private_remove(svm->pasid);
-			/*
-			 * We mandate that no page faults may be outstanding
-			 * for the PASID when intel_svm_unbind_mm() is called.
-			 * If that is not obeyed, subtle errors will happen.
-			 * Let's make them less subtle...
-			 */
-			memset(svm, 0x6b, sizeof(*svm));
 			kfree(svm);
 		}
 	}
-- 
2.34.1


