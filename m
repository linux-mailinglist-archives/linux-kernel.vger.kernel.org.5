Return-Path: <linux-kernel+bounces-47544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731B844F30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3EE1C2309F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E3739FD8;
	Thu,  1 Feb 2024 02:37:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ECB376E6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706755047; cv=none; b=etFwaY8KYx4PqGjYOJ9ZdCE5GxYnvDCydLA2Q5DYDhNHvYQRo/LYzNXhQe8FO0frzTzHDV6nP4FVNv0Y9JQYmC9rDmylrX35TujBMv/T4w06Bz3AXnKSlyi+w8jsizUF2bsp8hLNDNtZPYiE2eiCKjd4GgBUp1R/eYKXJcfa+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706755047; c=relaxed/simple;
	bh=/OXksEnSFlXIOc+J6tvL/j6uTr3vE9N3sXiHcc+DOAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PosbEe+Aboti8uRzm5f4/ZS5ihleJejqsnNclGSSl+L3a0o4UCNHblHezBgDkPGMq8SDm6pVVW9XcEfI1axmijxekzTM+5vH5IlcjKr3TvY8Vm+vq+uwyLYDXbEmhAe/2yhCMXvPrp2GI/YLWCdiEFs/TjQw6Dvzz3wTiZHkqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96DD1DA7;
	Wed, 31 Jan 2024 18:38:06 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C87B23F738;
	Wed, 31 Jan 2024 18:37:21 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/cma: Don't treat bad input arguments for cma_alloc() as its failure
Date: Thu,  1 Feb 2024 08:07:14 +0530
Message-Id: <20240201023714.3871061-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invalid cma_alloc() input scenarios - including excess allocation request
should neither be counted as CMA_ALLOC_FAIL nor 'cma->nr_pages_failed' be
updated when applicable with CONFIG_CMA_SYSFS. This also drops 'out' jump
label which has become redundant.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Also inclined to fold (!count) check into the first one i.e (!cma || ..)
before the pr_debug() output. This applies on v6.8-rc2.

 mm/cma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 7c09c47e530b..464fb4c8b4f0 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -438,13 +438,13 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	int ret = -ENOMEM;
 
 	if (!cma || !cma->count || !cma->bitmap)
-		goto out;
+		return page;
 
 	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
 		(void *)cma, cma->name, count, align);
 
 	if (!count)
-		goto out;
+		return page;
 
 	trace_cma_alloc_start(cma->name, count, align);
 
@@ -454,7 +454,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 
 	if (bitmap_count > bitmap_maxno)
-		goto out;
+		return page;
 
 	for (;;) {
 		spin_lock_irq(&cma->lock);
@@ -515,14 +515,12 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	}
 
 	pr_debug("%s(): returned %p\n", __func__, page);
-out:
 	if (page) {
 		count_vm_event(CMA_ALLOC_SUCCESS);
 		cma_sysfs_account_success_pages(cma, count);
 	} else {
 		count_vm_event(CMA_ALLOC_FAIL);
-		if (cma)
-			cma_sysfs_account_fail_pages(cma, count);
+		cma_sysfs_account_fail_pages(cma, count);
 	}
 
 	return page;
-- 
2.25.1


