Return-Path: <linux-kernel+bounces-156457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFDD8B02F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5052A1C230E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFA81586C7;
	Wed, 24 Apr 2024 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X44sDN0H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63261581F2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943096; cv=none; b=pm23WvCU5sxKTFQA/FrhRgMIJpzpYQ+FtnW0ayjuan0nqiY/WgRFuJufBiIKnu34GQauumNiVr83kYXW9t/0S0iCB2qAa0d7nnUJZbrVSUxfm6GZRmsajpsNjUQdlYD63ADxO8rvLh4b4BDcMKRnfeCBEBK+ClKNIGRcTChllHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943096; c=relaxed/simple;
	bh=CgopBTKaZCe/lGwr/TCnJyjo+XR0f8rgTTVctbIZQKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6xRzX0YbTgeNrjGEUg3s9Bs5lVvkUG+WhZEju0rMomUzZY8yg7HByuvyfu2EeSWlPBPSV/1oktKKKUaExpsnQCBKArKfHajgckaHVgoc+z5bGtguRlMzNxGHdsl8QwyBK06S/M9lwFx+sj5Zdckah5d4GGozV2/t+epS9efaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X44sDN0H; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943095; x=1745479095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CgopBTKaZCe/lGwr/TCnJyjo+XR0f8rgTTVctbIZQKs=;
  b=X44sDN0HJ7vGewG3k58NKMe01QTJMgpS87I7cBYtO4u6D1XSr6vr7ROi
   amzPlYoMqg4g9fUZqa6GGDkkKmK+D9Ky9o8MBem91BcqYs5KyWjxvR/J2
   3rBk0KWo2ESYtZzucYnRqV4Or3ccUNLTkMB0F25jQYPLTmdxd+TzRcJfp
   IQuxzMcwGp/APfm0JrDJenQcSoakcF6BH+iOeKlN8Z27RZs2BkfIQpyu3
   UIIdkaPjKw1K0IPLwisY/BRLHSOKihXtCxYp5pW9kt43T+OklecOy+JzK
   5Y8AVlQbWfrQVggkFg8MgixEW/ZrGzZ/QFCjK2bUILMvMZEzP69hIXWho
   A==;
X-CSE-ConnectionGUID: 4pL+UqirR5yKcdVJVa1seQ==
X-CSE-MsgGUID: U7cJggfSRrKtKG8vg89gWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073098"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:14 -0700
X-CSE-ConnectionGUID: hdRNhGS5SQ+th1Jfx+MzRw==
X-CSE-MsgGUID: /wTxSCbaTSCZHoRz9JKW7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24664711"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/18] iommu/vt-d: Use try_cmpxchg64{,_local}() in iommu.c
Date: Wed, 24 Apr 2024 15:16:28 +0800
Message-Id: <20240424071644.178250-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Uros Bizjak <ubizjak@gmail.com>

Replace this pattern in iommu.c:

    cmpxchg64{,_local}(*ptr, 0, new) != 0

.. with the simpler and faster:

    !try_cmpxchg64{,_local}(*ptr, &tmp, new)

The x86 CMPXCHG instruction returns success in the ZF flag, so this change
saves a compare after the CMPXCHG.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240414162454.49584-1-ubizjak@gmail.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a7ecd90303dc..4a2afe89b464 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -865,7 +865,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			break;
 
 		if (!dma_pte_present(pte)) {
-			uint64_t pteval;
+			uint64_t pteval, tmp;
 
 			tmp_page = alloc_pgtable_page(domain->nid, gfp);
 
@@ -877,7 +877,8 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			if (domain->use_first_level)
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 
-			if (cmpxchg64(&pte->val, 0ULL, pteval))
+			tmp = 0ULL;
+			if (!try_cmpxchg64(&pte->val, &tmp, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
 			else
@@ -2128,8 +2129,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		/* We don't need lock here, nobody else
 		 * touches the iova range
 		 */
-		tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);
-		if (tmp) {
+		tmp = 0ULL;
+		if (!try_cmpxchg64_local(&pte->val, &tmp, pteval)) {
 			static int dumps = 5;
 			pr_crit("ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
 				iov_pfn, tmp, (unsigned long long)pteval);
-- 
2.34.1


