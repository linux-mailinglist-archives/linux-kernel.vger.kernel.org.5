Return-Path: <linux-kernel+bounces-130639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C5897AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5AAB267A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5115689E;
	Wed,  3 Apr 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIlZmHm1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA4156867
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180145; cv=none; b=bJJfe3ppuG5qUKRmbv0cq5epOpgX2q+TVurIkV46W46pwTKVPpGdA8ppUF9HLFHpnkZkSUZBfMwpkNjRZnhWOQxUAUu+Rk8JwsCObr1jiLPp4XohxhkpXia/nDTkGLka8OfbgE7KmhrLBC442dGp3RrzyEZEiTehw4UkkGVxPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180145; c=relaxed/simple;
	bh=5velOTIExN+yC0MZHPBQnGuRcYai9BnR3d+mvItiUjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FkYv2JAO76xxOnSxT6VZVWPWmrprNInovFDj6bfWOnCzOHAIdzcctS3GZfmYkqw8jakNtN5lLS1LO49qzN5P1iNFtBg9E6pEbPw++ITIYLdX25zr1lI9951wHiGGVR2vEIfs+/w9rFeXVHxbN3ugnz8FEArjXWmVrqPh5fCcna0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIlZmHm1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712180141; x=1743716141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5velOTIExN+yC0MZHPBQnGuRcYai9BnR3d+mvItiUjg=;
  b=DIlZmHm1kYOV27pnD/PsdeM7mwyFYiDJnJdRkHUj2IBrataYKj83QC+k
   G+Nt+6rtISKL/n6DKhsD2WgUU6zNcDazkL73OqPiuLhutn1CPg49yK7Hl
   HXHKzsoZXGiUW0e/1znDS5ZamoJiN5PuRSurczRXYSi5NtCkX0a6rB9SV
   W8iL1bVTi7vRzWGSPjIFzrwsHBA2ug7AoPDzktOhSRuh6vnHTkLlykTTS
   SII6yZdFqy9LwaflLCn0LRrzxmId8MbzZukUR8B93IxSDsWDW0LUMrKYb
   mOGdRjGUYGuyF+xWEt1ylqnOODTxtjq5BoDHmGSlgfTj+90n5MKt+k/gi
   g==;
X-CSE-ConnectionGUID: RWIJNLLDTp2v1LJIVcTx3A==
X-CSE-MsgGUID: GxndDhr6TkGKtINF4zufQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18014660"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18014660"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 14:35:40 -0700
X-CSE-ConnectionGUID: 5SFAvSoTT4u22VlaEsqO8g==
X-CSE-MsgGUID: ++kFMv6DS9WbzHYa0SquyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18681402"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa008.fm.intel.com with ESMTP; 03 Apr 2024 14:35:42 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Allocate local memory for page request queue
Date: Wed,  3 Apr 2024 14:40:07 -0700
Message-Id: <20240403214007.985600-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page request queue is per IOMMU, its allocation should be made
NUMA-aware for performance reasons.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
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
2.25.1


