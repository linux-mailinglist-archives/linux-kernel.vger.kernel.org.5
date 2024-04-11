Return-Path: <linux-kernel+bounces-139690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E4A8A0685
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5591D1F25E32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FB713BAE3;
	Thu, 11 Apr 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zj3Xqoc+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7013B795
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804942; cv=none; b=u3B5dgdF3u56U6GVfa8fVQn8Y/ZqKMwIxegXWM8Ku1Vebn4rz9e8TlTmyCWcSUVPVq81vb09Ti648IV8vjtu8Bq1flyIiV+mebXBpipSspJnA1eSkMuz0eqGqujjY80Zh6xcJMCCIqb7kBL5mG6ks8nu04ziaLEm7lac+/iTcsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804942; c=relaxed/simple;
	bh=OGnOMxkpin9TYenIr8jNLqVcXysJ8LZw6T1asCHfxQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ddnfg2dNNhgIAhWcSBiUCS4j8du74rnViqW1nCFfLeCMpzPuZvBWAWZ8DfWPeGvWAgbEzxdnu0pWgJNtHbJ2Hci3OAB0e5Mp2Qh5cW6aYJl0n2B9vKGLbnHqKgOP7ePSdRMNY3BDv94B8l8lhlxcqXiUAj8otPRoJL7s5sFNKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zj3Xqoc+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804941; x=1744340941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OGnOMxkpin9TYenIr8jNLqVcXysJ8LZw6T1asCHfxQA=;
  b=Zj3Xqoc+OJ9ze3/clfGcrAhgCK93eZMLd7ARnjRzAEtoO8w2IqyRW4Gm
   QmZjOmyotw4yK561QJN2w8uPLDjqob+Cp5LsemROJwUiIF8XPqY0Ln5X5
   ScNYcV6GGKSohwIE5IW0Fx5QxvW2Nv1xshy/pXQo7F9X85ClVzBFANrge
   XyPZ2Kb/mkWy1S92KlqW6JDnV9bCINoKt2Vd4o6342jyBaX2dtjyQ7pVU
   XLpVOLpuUh4xIQu4PQ1F0BMeFJ9aEikzerOnHiyuU2U8K7+VOo47rWtsd
   jmbkjPEhRBeWehnyGh2A6xoCgWIHXvOnev3mmTu3LXdfaIgTHjuqgbj6s
   Q==;
X-CSE-ConnectionGUID: HSHb+TRARp6y58sem3PMMw==
X-CSE-MsgGUID: aP0GrKg6T32tSWtgKZkTSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30681442"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="30681442"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 20:09:00 -0700
X-CSE-ConnectionGUID: c67rkbpHQduq8UVS+RAUvg==
X-CSE-MsgGUID: BDA9RDfFQgWOqCEdwfaKcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20822973"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 10 Apr 2024 20:08:59 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Xuchun Shang <xuchun.shang@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iommu/vt-d: Allocate local memory for page request queue
Date: Thu, 11 Apr 2024 11:07:43 +0800
Message-Id: <20240411030744.273460-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411030744.273460-1-baolu.lu@linux.intel.com>
References: <20240411030744.273460-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

The page request queue is per IOMMU, its allocation should be made
NUMA-aware for performance reasons.

Fixes: a222a7f0bb6c ("iommu/vt-d: Implement page request handling")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240403214007.985600-1-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c1bed89b1026..ee3b469e2da1 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -66,7 +66,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	struct page *pages;
 	int irq, ret;
 
-	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
+	pages = alloc_pages_node(iommu->node, GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
 	if (!pages) {
 		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
 			iommu->name);
-- 
2.34.1


