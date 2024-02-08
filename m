Return-Path: <linux-kernel+bounces-57471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D873484D978
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7383D1F22FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF367C51;
	Thu,  8 Feb 2024 05:07:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EB67C46
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 05:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707368841; cv=none; b=RFRqndvS92s0YIN8dznYaW8u3xl4vrJ5v/5HrFN+WWujTjcOUDBXSTHnWC6xHX6UyIqaYXz9y06WhRSL9YtLOgoL4Gz/T9buKf14YhdjLAHcUiOCSuLiXynyY+FWnevqgpuie+uOCUZXWioUPa4uj14ra+UbzqH6JsA8Oryw2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707368841; c=relaxed/simple;
	bh=yK+uFXtxFn87nkdWgSYYDyZzSn3VTVrn/pbv3CUB03g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfPl51+QxZYPBe+u7tOquwTusCwiuHdDWPH4wZJ/IstNbA3PFt1I9OYtpMd3fiQqDnTnc5YdjosCto90KbIebxws5iWM44o+vyW7TU6o3gUiFMq6cVI6SgBZvSRXPFXJtgQxLvmXWw+UKKjahByR+aadWSA8CKSTV+GvbHycBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFCF11FB;
	Wed,  7 Feb 2024 21:07:59 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.44.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F3CC3F762;
	Wed,  7 Feb 2024 21:07:11 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC] mm/cma: Move cma_mutex into 'struct cma'
Date: Thu,  8 Feb 2024 10:37:01 +0530
Message-Id: <20240208050701.1081613-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Concurrent cma_alloc() requests might race with each other, inside the same
CMA heap area. These races could not happen between two different CMA areas
as their pfn ranges will be non overlapping. Let's just reduce the scope of
the 'cma_mutex' from being system wide to CMA heap area specific, allowing
concurrent cma_alloc() requests in different CMA heap areas.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch is slightly tested, although wanted to get some initial feedback
on whether the scope of this CMA mutex should be reduced down in principle.

 mm/cma.c | 6 +++---
 mm/cma.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 4f95266eba1d..d6a52dec1b19 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -33,7 +33,6 @@
 
 struct cma cma_areas[MAX_CMA_AREAS];
 unsigned cma_area_count;
-static DEFINE_MUTEX(cma_mutex);
 
 phys_addr_t cma_get_base(const struct cma *cma)
 {
@@ -111,6 +110,7 @@ static void __init cma_activate_area(struct cma *cma)
 		init_cma_reserved_pageblock(pfn_to_page(pfn));
 
 	spin_lock_init(&cma->lock);
+	mutex_init(&cma->cma_mutex);
 
 #ifdef CONFIG_CMA_DEBUGFS
 	INIT_HLIST_HEAD(&cma->mem_head);
@@ -460,10 +460,10 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		spin_unlock_irq(&cma->lock);
 
 		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
-		mutex_lock(&cma_mutex);
+		mutex_lock(&cma->cma_mutex);
 		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
 				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
-		mutex_unlock(&cma_mutex);
+		mutex_unlock(&cma->cma_mutex);
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
 			break;
diff --git a/mm/cma.h b/mm/cma.h
index ad61cc6dd439..d84183e1caba 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -16,6 +16,7 @@ struct cma {
 	unsigned long   *bitmap;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
 	spinlock_t	lock;
+	struct mutex	cma_mutex;
 #ifdef CONFIG_CMA_DEBUGFS
 	struct hlist_head mem_head;
 	spinlock_t mem_head_lock;
-- 
2.25.1


